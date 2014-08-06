From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 8/8] add tests for `git_config_get_string_const()`
Date: Wed, 06 Aug 2014 17:32:14 +0200
Message-ID: <vpqmwbhvdkx.fsf@anie.imag.fr>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
	<1407336792-16962-9-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:32:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF3CZ-0005bG-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbaHFPcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:32:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52721 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbaHFPcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:32:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s76FWDab009852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Aug 2014 17:32:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s76FWEXo024848;
	Wed, 6 Aug 2014 17:32:14 +0200
In-Reply-To: <1407336792-16962-9-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 6 Aug 2014 07:53:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Aug 2014 17:32:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s76FWDab009852
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407943936.32576@FHP/O0i2BJSFJ6GRZHelKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254867>

Tanay Abhra <tanayabh@gmail.com> writes:

> +test_expect_success 'find string value for a key' '
> +	check_config get_string case.baz hask &&
> +	check_config expect_code 1 get_string case.ba "Value not found for \"case.ba\""
> +'
> +
> +test_expect_success 'check line error when NULL string is queried' '
> +	test_expect_code 128 test-config get_string case.foo 2>result &&
> +	grep "line 7.*.git/config\|.git/config.*line 7" result
> +'

This is still dependant on the locale ("line" is translated). You need
to use test_i18ngrep instead of grep here (see its definition and
comment in t/test-lib.sh).

I don't think you need these two alternatives OTOH.

BTW, Junio, I don't understand your remark "This test is too tight (the
full string)" in the previous iteration. Can you elaborate?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
