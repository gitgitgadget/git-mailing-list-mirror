From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: Jobs and skipSubmitEdit
Date: Sun, 24 Jun 2012 16:24:45 -0400
Message-ID: <20120624202445.GA27664@padd.com>
References: <CAFLRbop2aETNp0-6AdvSTx7Jmh7epYZ6rQc6hhFHbxZrGdEo9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michael Horowitz <mike@horowitz.name>
X-From: git-owner@vger.kernel.org Sun Jun 24 22:25:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SitNO-0003n6-M4
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 22:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab2FXUYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 16:24:50 -0400
Received: from honk.padd.com ([74.3.171.149]:57370 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab2FXUYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 16:24:49 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id E82E42C1E;
	Sun, 24 Jun 2012 13:24:48 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 13C8931383; Sun, 24 Jun 2012 16:24:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAFLRbop2aETNp0-6AdvSTx7Jmh7epYZ6rQc6hhFHbxZrGdEo9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200539>

mike@horowitz.name wrote on Fri, 22 Jun 2012 12:15 -0400:
> I've written a git prepare-commit-msg hook to do what the Perforce
> JobsView would essentially do, so I can include the jobs directly in
> my git commit message, and then use git-p4.skipSubmitEdit=true, so I
> can just push things into Perforce directly from git without ever
> being prompted by Perforce.
> 
> Problem is that this doesn't work, because git-p4 tabs in the entire
> commit message to put it in the "Description:" section of the Perforce
> changelist, and my "Jobs:" ends up tabbed in, and it it required by
> Perforce to be at the beginning of the line.  The submit ends up
> failing, because "Jobs:" is required.  I am forced to turn off
> skipSubmitEdit and edit the message to remove the tab from the "Jobs:"
> line each commit.
> 
> Is there any option to make this work right, or does the git-p4 not
> support this?

This is a great idea, and something I've thought would be useful
too.  There's no code to handle it currently, but it shouldn't be
too hard.

I'm imagining that special strings in the git commit are hoisted
up out of the description when building the p4 change message,
as you describe.  Are there any more than "Jobs:"?  Is it just
a single instance that might appear?

An easy way to do this is to change prepareLogMessage to alter
or add a Jobs line.  Unless we decide this needs to be more
general.

		-- Pete
