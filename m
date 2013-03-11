From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Textconv
Date: Mon, 11 Mar 2013 11:41:02 +0100
Message-ID: <vpqd2v6b4n5.fsf@grenoble-inp.fr>
References: <513DA7E1.7050206@mylovecompany.com>
	<vpqtxoicl2l.fsf@grenoble-inp.fr> <513DB273.2090007@mylovecompany.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dmitry Ilin <dmitry@mylovecompany.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 11:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF0Ak-0004eg-FM
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 11:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab3CKKlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 06:41:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55682 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308Ab3CKKlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 06:41:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2BAf1as029828
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 11:41:01 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UF0AA-0000yt-Mg; Mon, 11 Mar 2013 11:41:02 +0100
In-Reply-To: <513DB273.2090007@mylovecompany.com> (Dmitry Ilin's message of
	"Mon, 11 Mar 2013 14:31:15 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Mar 2013 11:41:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2BAf1as029828
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363603266.8684@JX9ldeRHiAcVUuxYki0Nrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217866>

Dmitry Ilin <dmitry@mylovecompany.com> writes:

> I mean that our filter doesn't work with 'git show' and I need to
> enable it for this command.
>
> This is part of my git config file:
>
> [filter "openssl"]
>    smudge = openssl enc -d -base64 -aes-256-ecb -k 'abcde' 2>
> /dev/null || cat
>    clean = openssl enc -base64 -aes-256-ecb -S '12345' -k 'abcde'
> [diff "openssl"]
>    textconv = openssl enc -d -base64 -aes-256-ecb -k 'abcde' -in "$1"
> 2> /dev/null || cat "$1"
> [merge]
>    renormalize = true

Maybe a bad interaction between the [filter ...] section and the
[textconv ...] one. Can you run:

GIT_TRACE=true git show <some-relevant-commit>

to see what's going on?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
