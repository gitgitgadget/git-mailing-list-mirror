From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 2/2] test-config: Add tests for the config_set API
Date: Mon, 07 Jul 2014 19:04:55 +0200
Message-ID: <vpqvbr9w154.fsf@anie.imag.fr>
References: <1404719566-3368-1-git-send-email-tanayabh@gmail.com>
	<1404719566-3368-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:05:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4CMJ-0000O5-6C
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbaGGRFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:05:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47761 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbaGGRFi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 13:05:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s67H4sdH013286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 Jul 2014 19:04:54 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s67H4toe004388;
	Mon, 7 Jul 2014 19:04:55 +0200
In-Reply-To: <1404719566-3368-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 7 Jul 2014 00:52:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 07 Jul 2014 19:04:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s67H4sdH013286
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405357500.08564@DPL+iFwCjEcSzGuXNUH1Xw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252969>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/t/t1308-config-hash.sh b/t/t1308-config-hash.sh
> new file mode 100755
> index 0000000..ad99f8b
> --- /dev/null
> +++ b/t/t1308-config-hash.sh
> @@ -0,0 +1,168 @@
> +#!/bin/sh
> +
> +test_description='Test git config-hash API in different settings'

You may want to call it "config_set API" now.

> +#'check section.key value' verifies that the entry for section.key is
> +#'value'

Style: space after #.

> +check() {
> +	echo "$2" >expected
> +	test-config get_value "$1" >actual 2>&1
> +	test_cmp actual expected
> +}

You need to &&-chain these lines, to catch potential test-config
failures (if it returns 1 after sending the right output, you won't
notice).

The doc says

 - test_cmp <expected> <actual>

You swapped the order of parameters.

> +test_expect_success 'setup default config' '
> +	cat >.git/config << EOF

Missing && here (sorry, I should have noticed the first time).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
