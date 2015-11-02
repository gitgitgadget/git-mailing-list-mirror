From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: configure: -lpthread doesn't belong in CFLAGS
Date: Mon, 02 Nov 2015 09:27:41 +0100
Message-ID: <vpqa8qwst4y.fsf@anie.imag.fr>
References: <201511012230.tA1MUGa5016836@tezro.nonet>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Rainer M. Canavan" <git@canavan.de>
X-From: git-owner@vger.kernel.org Mon Nov 02 09:28:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtATG-0006EN-0y
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 09:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbbKBI2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 03:28:00 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54885 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbbKBI15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 03:27:57 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tA28Rg6o018687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 2 Nov 2015 09:27:42 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tA28RfZT019906;
	Mon, 2 Nov 2015 09:27:41 +0100
In-Reply-To: <201511012230.tA1MUGa5016836@tezro.nonet> (Rainer M. Canavan's
	message of "Sun, 1 Nov 2015 23:30:16 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 02 Nov 2015 09:27:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tA28Rg6o018687
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1447057665.67772@UcPhRKHxc2nnosVgSNp79A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280688>

"Rainer M. Canavan" <git@canavan.de> writes:

> Hi,

Hi,

Thanks for the patch. However, it will need a bit more work to be
integrated into git.git.

Please, read
https://github.com/git/git/blob/master/Documentation/SubmittingPatches

The body of your email should end up being the commit message. It is not
(yet) properly written as such. Also, read about Developer's Certificate
of Origin in the document above.

>    for opt in "" -mt -pthread -lpthread; do
>       old_CFLAGS="$CFLAGS"
> -     CFLAGS="$opt $CFLAGS"
> +     old_LIBS="$LIBS"
> +     if test "$(echo $opt | cut -b 1-2)" = -l ; then

Don't use "echo" on string that may begin with - (different versions of
echo will have different behaviors). One option is to use "printf" which
is more robust. Another one, more elegant IMHO in this case is to use a
case:

case "$opt" in
   -l*)
      # ...
      ;;
   *)
      # ...
      ;;
esac

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
