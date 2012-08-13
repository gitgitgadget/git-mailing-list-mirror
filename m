From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git diff vs git diff-files
Date: Mon, 13 Aug 2012 17:13:38 +0200
Message-ID: <vpq1uja25b1.fsf@bauges.imag.fr>
References: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Bernd Jendrissek <bernd.jendrissek@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 17:13:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0wL2-0004mV-BI
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 17:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab2HMPNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 11:13:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34412 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469Ab2HMPNp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 11:13:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q7DFAElZ027745
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 13 Aug 2012 17:10:14 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1T0wKo-0006DH-KP; Mon, 13 Aug 2012 17:13:38 +0200
In-Reply-To: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
	(Bernd Jendrissek's message of "Mon, 13 Aug 2012 10:55:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 13 Aug 2012 17:10:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q7DFAElZ027745
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1345475418.59394@JLIuNs4uPBfdqhv/aP2n7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203339>

Bernd Jendrissek <bernd.jendrissek@gmail.com> writes:

> $ /usr/local/git/bin/git diff-files -p --color -- TwoStageAmp-output.net
> diff --git a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> index a5ee1e7..a9f3620 100644

> $ /usr/local/git/bin/git diff TwoStageAmp-output.netdiff --git
> a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
> b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.n
> index a5ee1e7..a9f3620 100644

What's surprising is that both diff show the same "index" line, so both
commands actually diff the same content, and then show a different
output.

You can try something like

git cat-file blob a5ee1e7 > /tmp/staged.txt
diff -u /tmp/staged.txt TwoStageAmp-output.netdiff

to recover the content from the index (Thomas' version should also work
and give the same result), and use another diff tool. This "diff -u"
should give you an output similar to one of "git diff" and "git
diff-files" (my understanding is that it should match diff-files, and
"git diff" is the one being wrong here).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
