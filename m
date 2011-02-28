From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 10:40:13 +0100
Message-ID: <vpqwrkkpkea.fsf@bauges.imag.fr>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
	<4D68D630.9000608@drmicha.warpmail.net>
	<711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>
	<AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>
	<7v39n8ll0s.fsf@alter.siamese.dyndns.org>
	<4D6B5D09.8010806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 10:40:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptzao-00053Y-LJ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864Ab1B1Jkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:40:33 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40513 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384Ab1B1Jkc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 04:40:32 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p1S9eEjs029647
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Feb 2011 10:40:16 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PtzaQ-0002hN-9M; Mon, 28 Feb 2011 10:40:14 +0100
In-Reply-To: <4D6B5D09.8010806@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 28 Feb 2011 09:30:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Feb 2011 10:40:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1S9eEjs029647
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1299490819.25928@6FUmnFhEPGf7qpqYcjj1Bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168084>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> But just how useful is our default that "git add" is a no-op?

I dont care very much myself, but if you consider "git add ." as a
potentially destructive operation (discards changes that may be precious
in the index), then it's good that "git add" is a no-op.

Many beginners will try commands expecting to get a help message or a
hint on how to use it when ran without argument (principle of least
surprise)

Like:

$ ls
file1 file2
=> oh, so "ls" lists files.
$ rm
rm: missing operand
Try `rm --help' for more information.
=> ok, so rm needs more operands

A user typing "git add" just "to see what happens" may be disapointed to
have all its files added. In particular since "git add" is silent by
default, hence

# let's see what happens ...
$ git add
$ 
# ok, nothing happened ...
# continue hacking without noticing that a bunch of files have been added.

Mercurial has taken the other way, making "hg add" add everything by
default, and some users do complain:

http://osdir.com/ml/version-control.mercurial.general/2007-08/msg00316.html

If you change this for Git, you'll have people complaining about
backward compatibility plus people complaining about least surprise :-(

> - "add" should be about tracked paths by default (default pathspec "."),
>
> - "commit -a,--add <addopts>" be "add <addopts> && commit", and
>
> - "-A,--all pathspec" (default pathspec ".") be about tracked and
> untracked paths (whether add or commit).

Today, "git add ." adds new content in tracked files, and new files, but
doesn't notice files deletions. Did I miss something, or is there no way
to do that with your proposal?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
