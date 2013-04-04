From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG] git log -S not respecting --no-textconv
Date: Thu, 04 Apr 2013 10:34:17 +0200
Message-ID: <vpqd2uay9rq.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 10:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNfdH-0001OZ-HS
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 10:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763728Ab3DDIeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 04:34:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42484 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763573Ab3DDIeX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 04:34:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r348YGsB026872
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Apr 2013 10:34:16 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UNfcf-0002gi-Np; Thu, 04 Apr 2013 10:34:17 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 04 Apr 2013 10:34:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r348YGsB026872
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365669259.89334@a9BaQUOQ+IOmoJNlumkbjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219993>

Hi,

It seems the command "git log --no-textconv -Sfoo" still runs the
textconv filter (noticed because I have a broken textconv filter that
lets "git log -S" error out).

Steps to reproduce:

Create a repo with *.txt file(s) in it
$ echo '*.txt diff=wrong' > .gitattributes

An incorrect textconv filter errors out as expected:

$ git -c diff.wrong.textconv='xxx' log -Sfoo 
error: cannot run xxx: No such file or directory
fatal: unable to read files to diff

but --no-textconv has no effect:

$ git -c diff.wrong.textconv='xxx' log --no-textconv -Sfoo
error: cannot run xxx: No such file or directory
fatal: unable to read files to diff

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
