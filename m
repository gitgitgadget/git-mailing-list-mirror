From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Mon, 12 Mar 2012 09:47:26 +0100
Message-ID: <vpqzkbmcijl.fsf@bauges.imag.fr>
References: <1kgsxjq.jf2f02ib96ufM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com (Junio C Hamano),
	marcnarc@xiplink.com (Marc Branchaud),
	cmn@elego.de (Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto),
	git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Mon Mar 12 09:48:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S70vU-0002ej-FZ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 09:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab2CLIsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 04:48:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51238 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab2CLIsA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 04:48:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2C8h7VH005363
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Mar 2012 09:43:07 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S70ud-0002bv-G5; Mon, 12 Mar 2012 09:47:27 +0100
In-Reply-To: <1kgsxjq.jf2f02ib96ufM%lists@haller-berlin.de> (Stefan Haller's
	message of "Sun, 11 Mar 2012 21:26:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 12 Mar 2012 09:43:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2C8h7VH005363
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332146590.93705@uu/u7bhKJtRJurwLbbU/gg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192846>

lists@haller-berlin.de (Stefan Haller) writes:

> We're a closed-source company that uses git more or less like an
> old-style, non-distributed VCS.
> [...]
> Also, it is very common for two or more developers to collaborate on a
> topic branch,
> [...]
> Topics are never pushed to master; we have a "merge --no-ff" policy for
> integration.
> [...]
> To sum it up, push.default=current is almost perfect for this kind of
> workflow; except that you still need to configure your upstream branches
> so that pull works, and status (and the shell prompt) displays the right
> information.

What do you set "upstream" to in your flow?

I agree that push.default=current is the best setting for you. But I
think 'tracking' would not be a silly choice either: if you collaborate
on topic branches, it makes sense to set the upstream to the remote
topic branch, so that "git pull" gets changes in the same branch (and
you may need to "git pull origin master" to sync with the master branch
from time to time). If you create a new branch with, say

  git checkout -b new-branch

then the new branch has no upstream configured, and the next push
without argument will fail, pointing you to the right command for your
case:

  $ git push
  fatal: The current branch new-branch has no upstream branch.
  To push the current branch and set the remote as upstream, use
  
      git push --set-upstream origin new-branch

If you do a "git checkout new-branch" when "origin/new-branch" exists
and "new-branch" doesn't, the upstream is configured to point to the
remote "new-branch".

In both cases, the upstream is configured so that push.default=current
do the same thing as push.default=upstream, so you don't really care
which value is taken.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
