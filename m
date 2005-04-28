From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Git fork removal?
Date: Thu, 28 Apr 2005 11:10:39 +0200
Message-ID: <20050428091039.GI8612@pasky.ji.cz>
References: <20050428021237.GA8612@pasky.ji.cz> <Pine.LNX.4.21.0504272221030.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 11:12:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR53O-0006st-0G
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 11:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVD1JQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 05:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVD1JNN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 05:13:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42935 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261962AbVD1JKl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 05:10:41 -0400
Received: (qmail 21645 invoked by uid 2001); 28 Apr 2005 09:10:39 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504272221030.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 04:47:24AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > If this breaks your workflow, could you please describe it? Perhaps we
> > could find a good semantics to support both.
> 
> The part that I'm worried about is the way I turn a mass of debugging and
> little local commits into a clean patch series. I've got a working fork
> "barkalow", which is the result of a bunch of stuff and a dozen
> commits. It is derived from "linus". I want to split up the changes and
> make a series of commits, each of which will be a patch to submit.
> 
> 1) I fork "linus" into "for-linus". I go into "for-linus".
> 
> 2) I do "git diff this:barkalow > patch". This gives me the complete set
>    of changes I want to submit.
> 
> 3) I cut down the diff to a single logical change by removing all of the
>    other hunks.
> 
> 4) I do "git apply < patch". I do "git commit". I describe the logical
>    change.
> 
> 5) I go back to step 2, unless I'm done.
> 
> 6) For each of the commits between "linus" and "for-linus", I do 
>    "git patch <commit>", and send out the result.
> 
> The thing that I think requires the symlinks is step 2, which requires
> that there be somewhere I can run git and have it able to see a pair of
> unrelated local heads and the relevant trees.

Just do cg-pull barkalow, to get the latest changes from that repository
(perhaps clone should inherit branches information?).

But if you want Linus to pull from your tree, you generally want it to
be clean - that is, you want to manage clean separation (as Pavel Machek
describes in his document). That is another advantage of hardlinking -
you don't get any unrelated stuff in if you don't explicitly pull it, so
you can keep your for-linus branch clean. I'd do cg-diff linus:this in
the barkalow branch instead to keep this property.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
