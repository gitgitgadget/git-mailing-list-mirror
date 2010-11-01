From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git stash and manually edited chunks
Date: Mon, 01 Nov 2010 17:58:24 +0100
Message-ID: <vpqfwvlkmkv.fsf@bauges.imag.fr>
References: <AANLkTik6esqP2EkA6SFmfS0zdokG1iTKXqivA2wnpq=9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Olivier Verdier <zelbier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 17:59:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCxio-00037W-5s
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 17:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab0KAQ6w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 12:58:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42731 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab0KAQ6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 12:58:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA1GhnDS011116
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 1 Nov 2010 17:43:49 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PCxiD-0004XH-0i; Mon, 01 Nov 2010 17:58:25 +0100
In-Reply-To: <AANLkTik6esqP2EkA6SFmfS0zdokG1iTKXqivA2wnpq=9@mail.gmail.com> (Olivier Verdier's message of "Mon\, 1 Nov 2010 08\:27\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 01 Nov 2010 17:43:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA1GhnDS011116
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289234631.5429@8H8z+kijd1ovSZtjREV2rQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160484>

Olivier Verdier <zelbier@gmail.com> writes:

> Hi!
> I asked a question on stackoverflow
> (http://stackoverflow.com/questions/4058372/git-stash-and-edited-chun=
ks)
> and someone suggested it might be a bug...
> For convenience, I reproduce the question here:
>
> =A0I occasionally have the following problem, which is reproduced by =
the
> following sequence of commands:

Let's say the state of your working tree here is A (and last commit is
HEAD).

> * git add -p my_file
> * I=A0edit a chunk *manually*=A0(using=A0e)

Here, the index contains a state which is neither in the working tree
nor in the last commit. Let's call this state B.

> * git stash --keep-index

Here, the working tree takes state B.

> * git stash pop

Here, you're trying to apply the stash, which is somehow a diff
between HEAD and A, on your tree which is in state B. Hence the
conflicts.


If you do a "git reset --hard" before the "git stash pop", you'll come
back to state HEAD, and the stash will apply without conflict.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
