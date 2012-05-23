From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature idea: git rebase --exec $CMD
Date: Wed, 23 May 2012 17:41:09 +0200
Message-ID: <vpqd35udhwq.fsf@bauges.imag.fr>
References: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
	<nngfwar3p9z.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antonio Ospite <ospite@studenti.unina.it>, <git@vger.kernel.org>
To: <dag@cray.com>
X-From: git-owner@vger.kernel.org Wed May 23 17:41:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXDgj-0000jz-Od
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 17:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835Ab2EWPlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 11:41:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44633 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760197Ab2EWPlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 11:41:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4NFXDDd009766
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 23 May 2012 17:33:13 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXDgU-0007uf-1g; Wed, 23 May 2012 17:41:10 +0200
In-Reply-To: <nngfwar3p9z.fsf@transit.us.cray.com> (dag@cray.com's message of
	"Wed, 23 May 2012 10:12:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 23 May 2012 17:33:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4NFXDDd009766
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338391996.69114@IEcm9CuhA8i3oroBQAKlbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198300>

<dag@cray.com> writes:

> Antonio Ospite <ospite@studenti.unina.it> writes:
>
>> I find the x/exec function in "git rebase -i" very useful, but it may
>> be tedious to edit the commit list to add something like "make test"
>> after each commit.
>
> I've taken a more general approach inspired by
> run-command-on-git-revisions at
> https://github.com/garybernhardt/dotfiles/tree/master/bin
>
> I took that and turned it into a git-run-command subcommand.  It will
> take an arbitrary command and run it on each revision specified by a
> revlist.

That's sensible too. The nice things with running commands in "git
rebase" are:

* It's likely to be the place where you want to run some tests. The
  typical use-case is that you have a patch serie whose last revision
  passes tests, and you want to check that intermediate commits also do.
  At that point, you probably want to rebase against upstream too, to
  make sure you're developping against the latest revision, before
  sening a patch serie or pushing.

* if the "exec" command fails, you're likely to be exactly in the right
  place to fix it: fix the bug, run "git commit --amend", and "git
  rebase --continue".

The nice thing with your approach (as I understand it) is that it
doesn't require rewritting history, and may apply to all commits in
non-linear history.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
