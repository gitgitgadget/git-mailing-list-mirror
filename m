From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/6] send-email: shorten send-email's output
Date: Thu, 09 Jun 2016 08:17:36 +0200
Message-ID: <vpqr3c6x4vz.fsf@anie.imag.fr>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-4-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:17:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAtHr-0006Fj-Vt
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 08:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbcFIGRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 02:17:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55816 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008AbcFIGRr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 02:17:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u596Hacj001492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jun 2016 08:17:36 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u596HaJk026580;
	Thu, 9 Jun 2016 08:17:36 +0200
In-Reply-To: <20160608130142.29879-4-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 15:01:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 09 Jun 2016 08:17:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u596Hacj001492
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1466057857.15827@Uszrl0KIRVGKDiOficOZRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296872>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> @@ -647,10 +647,10 @@ test_expect_success $PREREQ '--suppress-cc=all' '
>  test_expect_success $PREREQ 'setup expect' "
>  cat >expected-suppress-body <<\EOF
>  0001-Second.patch
> -(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
> -(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
> -(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
> -(cc-cmd) Adding cc: cc-cmd@example.com from: './cccmd'
> +Adding cc: A <author@example.com> from From: header
> +Adding cc: One <one@example.com> from Cc: header
> +Adding cc: two@example.com from Cc: header
> +Adding cc: cc-cmd@example.com from: './cccmd'

This hunk differs from the others a bit. I totally agree that removing
the (mbox) prefix makes sense, but you're removing (cc-cmd) here, which
did carry some information.

I'd write it as

Adding cc: cc-cmd@example.com from --cc-cmd: ./cccmd

It might make sense to split this into two patches: one for (mbox) +
headers and one for (cc-cmd) and (to-cmd). Spotting special-cases like
the above inside a long patch is hard for reviewers.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
