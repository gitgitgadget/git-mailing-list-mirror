From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 15:05:06 +0100
Message-ID: <vpqy5ev7xpp.fsf@grenoble-inp.fr>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
	<vpqobfr9da7.fsf@grenoble-inp.fr>
	<CABPQNSbYCrdSP5rWbfLX==u--bJpQo6A6sNE46a1RuU-fMDiWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 11 15:05:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4u0o-0004nd-8S
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 15:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab3BKOFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2013 09:05:10 -0500
Received: from mx2.imag.fr ([129.88.30.17]:33427 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756332Ab3BKOFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 09:05:09 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1BE55AZ031835
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2013 15:05:05 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U4u0J-0003cl-4Y; Mon, 11 Feb 2013 15:05:07 +0100
In-Reply-To: <CABPQNSbYCrdSP5rWbfLX==u--bJpQo6A6sNE46a1RuU-fMDiWg@mail.gmail.com>
	(Erik Faye-Lund's message of "Mon, 11 Feb 2013 14:57:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Feb 2013 15:05:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1BE55AZ031835
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361196305.79624@MEcvw31azRfG6wFV/tfe4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216034>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> But isn't UTF-8 constructed to be very unlikely to clash with existin=
g
> encodings? If so, I could add a case for non-ascii and non-UTF-8, tha=
t
> simply writes the byte as a hex-tuple?

If it's non-ascii and non-UTF-8, I think you'd want to display the byte
as it is, because this is how it was entered. IOW, I'd say we should
keep the current behavior in this case.

>> 2) The non-ascii sequence is NOT valid UTF-8, then if I read correct=
ly
>>    (I didn't test) utf8_width would set next to NULL, and then you a=
re
>>    in big trouble.
>
> Outch. Yeah, you are right; this is not good at all :)
>
> But I guess the solution above should fix this as well, no?

It should, yes.

Of course, there's still the case where the user entered "git -=C3=A9" =
as a
=C3 followed by a =A9 in a latin-1 environment, but as you said, it's
unlikely enough ;-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
