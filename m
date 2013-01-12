From: Pete Wyckoff <pw@padd.com>
Subject: Re: Suggestion: add option in git-p4 to preserve user in Git
 repository
Date: Sat, 12 Jan 2013 17:56:40 -0500
Message-ID: <20130112225640.GA23079@padd.com>
References: <CAFXk4bpQo26sAfHkE5_VLi_UkZcgsYvwYNH8byZjuXs=EAhu+A@mail.gmail.com>
 <20130112163838.GA28722@padd.com>
 <CAFXk4bpM8X3k=iwRjM9kvm4XbZyKS+hTCiVbHOjH3jK6MkkBSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Olivier Delalleau <shish@keba.be>
X-From: git-owner@vger.kernel.org Sat Jan 12 23:57:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuA0f-0003UF-Dv
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 23:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408Ab3ALW4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 17:56:45 -0500
Received: from honk.padd.com ([74.3.171.149]:49511 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754302Ab3ALW4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 17:56:45 -0500
Received: from arf.padd.com (50-52-235-227.drr01.drhm.nc.frontiernet.net [50.52.235.227])
	by honk.padd.com (Postfix) with ESMTPSA id 4D1372F3F;
	Sat, 12 Jan 2013 14:56:44 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BA63B27CDB; Sat, 12 Jan 2013 17:56:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAFXk4bpM8X3k=iwRjM9kvm4XbZyKS+hTCiVbHOjH3jK6MkkBSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213313>

shish@keba.be wrote on Sat, 12 Jan 2013 14:44 -0500:
> 2013/1/12 Pete Wyckoff <pw@padd.com>:
> > shish@keba.be wrote on Thu, 10 Jan 2013 22:38 -0500:
> >> I'm in a situation where I don't have P4 admin rights to use the
> >> --preserve-user option of git-p4. However, I would like to keep user
> >> information in the associated Git branch.
> >>
> >> Would it be possible to add an option for this?
> >
> > The --preserve-user option is used to submit somebody else's work
> > from git to p4.  It does "p4 change -f" to edit the author of the
> > change after it has been submitted to p4.  P4 requires admin
> > privileges to do that.
> >
> > Changes that are imported _from_ p4 to git do have the correct
> > author information.
> >
> > Can you explain a bit more what you're looking for?
> 
> Sorry I wasn't clear enough. When "git p4 submit" submits changes from
> Git to P4, it also edits the Git history and replaces the Git commits'
> authors by the information from the Perforce account submitting the
> changes. The advantage is that both the P4 and Git repositories share
> the same author information, but in my case I would like to keep in
> the Git repository the original authors (because the P4 account I'm
> using to submit to P4 is shared by all Git users).

Ah, I see what you're looking for now.  It's certainly possible
to keep a mapping in the git side to remember who really wrote
each change that went into p4, but there's nothing set up to do
that now.  And it would be a fair amount of work, with many
little details.

You could put the true name in the commit message, like
we do signed-off-by messages: "Author: Real Coder <rc@my.com>".
That would keep the proper attribution, but not work with "git
log --author", e.g.; you'd have to use "--grep='Real Coder'"
instead.

		-- Pete
