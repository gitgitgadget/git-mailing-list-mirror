From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 14:46:13 -0400
Message-ID: <20050423184613.GE20410@delft.aura.cs.cmu.edu>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org> <20050423175422.GA7100@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 20:42:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPPZZ-00044b-VK
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 20:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVDWSq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 14:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVDWSq2
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 14:46:28 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:55214 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261686AbVDWSqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 14:46:21 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DPPdt-0003P4-00; Sat, 23 Apr 2005 14:46:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2005 at 11:30:36AM -0700, Linus Torvalds wrote:
> On Sat, 23 Apr 2005, Thomas Glanzmann wrote:
> > # This creates the signature.
> > gpg --clearsign < sign_this > signature
> 
> This really doesn't work for me - I do not want to have the gpg header
> above it, only the signature below. Since I want git to actually
> understand the tags, but do _not_ want git to have to know about whatever
> signing method was used, I really want the resulting file to look like
> 
> 	commit ....
> 	tag ...
> 
> 	here goes comment
> 	here goes signature
> 
> and no headers.
> 
> Whether that can be faked by always forcing SHA1 as the hash, and then 
> just removing the top lines, and re-inserting them when verifying, or 
> whether there is some mode to make gpg not do the header crud at all, I 
> don't know. Which is exactly why I never even got started.

It is a bit more messy, but it can be done with a detached signature.

To sign,
    gpg -ab unsigned_commit
    cat unsigned_commit unsigned_commit.asc > signed_commit

To verify,
    cat signed_commit | sed '/-----BEGIN PGP/Q' | gpg --verify signed_commit -

Jan
