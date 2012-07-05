From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/3] git p4: remove unused P4Submit interactive setting
Date: Thu, 5 Jul 2012 08:30:10 -0400
Message-ID: <20120705123010.GA31388@padd.com>
References: <1341408860-26965-1-git-send-email-pw@padd.com>
 <1341408860-26965-2-git-send-email-pw@padd.com>
 <4FF54041.2000507@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Horowitz <mike@horowitz.name>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 14:30:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmlCS-0004fa-5m
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 14:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab2GEMaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 08:30:16 -0400
Received: from honk.padd.com ([74.3.171.149]:54127 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754236Ab2GEMaP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 08:30:15 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 3782E5B33;
	Thu,  5 Jul 2012 05:30:14 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 18D265A9BF; Thu,  5 Jul 2012 08:30:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4FF54041.2000507@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201044>

luke@diamand.org wrote on Thu, 05 Jul 2012 08:20 +0100:
> On 04/07/12 14:34, Pete Wyckoff wrote:
> >The code is unused.  Delete.
> 
> I've used that non-interactive code path in the past, in the very
> early days of using it (setting interactive to false manually).
> 
> The nice thing about it is that if you're using git-p4 for the very
> first time it lets you do the final submission to p4 by hand,
> without having to trust the script to do the right thing. Once I
> convinced myself that git-p4 was doing the right thing, I then
> stopped using it.
> 
> Is it worth retaining, perhaps fixed so that it can be set on the
> command line and documented? Or just discard?

My biggest complaint is that there's no way to enable the option.
You have to edit the code to change self.interactive to False, as
you pointed out.

Then it doesn't help you with the submit message, and doesn't
do the little details of cleaning up pure-copied files or
changing the username for preserveUser.

What you're doing makes sense, though, but maybe there's a
cleaner way to provide that functionality.

We could build the change then say "type p4 submit -c ... if it
looks good".  Still doesn't handle the little details.

We could spawn a shell to let them go inspect.

We could try to implement a "--continue" option, and give them
a chance to edit.

I've got an upcoming series that changes the interaction loop on
conflict, and makes it easier to do some interaction at each
patch, possibly before applying too.  Might make things easier.

		-- Pete
