From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: rev-list --cherry-pick and context lines
Date: Fri, 2 Sep 2011 18:33:06 +0200
Message-ID: <1k6zcbk.ov5qevxc1a91M%lists@haller-berlin.de>
References: <4E60F707.40708@drmicha.warpmail.net>
Cc: git@vger.kernel.org
To: git@drmicha.warpmail.net (Michael J Gruber)
X-From: git-owner@vger.kernel.org Fri Sep 02 18:33:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzWgH-0005x7-RJ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 18:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346Ab1IBQdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 12:33:11 -0400
Received: from mail.ableton.net ([62.96.12.117]:59436 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941Ab1IBQdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 12:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=aY4T/6bJv3QnhoCgOGj30js3+9UGKdgmd96q44+v0bE=;
	b=LpDg5w//zhIXOeCQrMCdx6W4IS2OjOVcovP7kb+OVQIoHcd6FBFXemYTRZ0E5/1gAuQ4dq4y0C8haPV2Palr9QTQ14JxkoyzD2W3EgTb5p5iZMXWI2Mg9oF5Z+uHp7674+zBsFt2r3oD08f33GWQk8w5U0Z98LZbBvTRAdlBSAQ=;
Received: from macbook-stk.office.ableton.com ([10.1.12.116])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <lists@haller-berlin.de>)
	id 1QzWfw-0000fO-HZ; Fri, 02 Sep 2011 18:33:04 +0200
In-Reply-To: <4E60F707.40708@drmicha.warpmail.net>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.8 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180621>

Michael J Gruber <git@drmicha.warpmail.net> wrote:

> Stefan Haller venit, vidit, dixit 02.09.2011 12:35:
> > Consider two commits on different branches, one with this patch:
> > 
> >     diff --git a/file.txt b/file.txt
> >     index 704fa27..2f7e74c 100644
> >     --- a/file.txt
> >     +++ b/file.txt
> >     @@ -1,3 +1,3 @@
> >      old_context
> >      
> >     -foo
> >     +bar
> > 
> > and the other with this patch:
> > 
> >     diff --git a/file.txt b/file.txt
> >     index f35051b..8c7de32 100644
> >     --- a/file.txt
> >     +++ b/file.txt
> >     @@ -1,3 +1,3 @@
> >      new_context
> >      
> >     -foo
> >     +bar
> > 
> > If I run "git rev-list --cherry-pick --left-right branch1...branch2", it
> > reports both commits as being genuine commits on their respective
> > branch, even though I consider their patches to be the same.
> > 
> > I guess for my purpose I would like to have patch-ids that ignore
> > context (or that use only one line of context, I'm not sure which).
> > 
> > In fact, if I do "git show <commit> -U1 | git patch-id", both commits
> > show the same id.
> > 
> > So, would it make sense to have a parameter for git-rev-list (and
> > git-cherry) that lets you specify how much context to be used for the
> > patch ids?
> 
> It would be a bit like the patch below. "git log" accepts diff options already.
> But:
> [...]

Thanks a lot.  I can't contribute much to answering your "But:"
questions; I can only add more questions myself. :-)

Is there a reason why the hard-coded default is 3 in the current code?
It seems to me that 1 would be a better choice; it would mean "patches
are equal if their added/removed lines are the same, and they could be
cherry-picked without conflicts."

Now, I'm in a situation where I'll be stuck with git 1.7.1 for quite a
while, so no patch is going to help me.  It looks like the only way to
get the behaviour I want is to reimplement git-rev-list --cherry-pick
myself, feeding each patch to git-patch-id, right? (Horribly
inefficient, but might be good enough for my purpose. Just wondering if
I'm missing a smarter way to solve it.)

Thanks,
   Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
