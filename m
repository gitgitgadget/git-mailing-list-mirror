From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 2/2] test-config: Add tests for the config_set API
Date: Wed, 09 Jul 2014 14:13:00 +0200
Message-ID: <vpq4myqd92r.fsf@anie.imag.fr>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>
	<1404903454-10154-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:13:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4qkI-0005q3-QD
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 14:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbaGIMNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 08:13:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33170 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbaGIMNE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 08:13:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s69CCxVr030111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Jul 2014 14:12:59 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s69CD0aP024018;
	Wed, 9 Jul 2014 14:13:00 +0200
In-Reply-To: <1404903454-10154-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 9 Jul 2014 03:57:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Jul 2014 14:12:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s69CCxVr030111
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405512780.46939@7HwElLi/HKn/4q6oViz8WQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253122>

Tanay Abhra <tanayabh@gmail.com> writes:

> +test_expect_success 'find value with misspelled key' '
> +	test_must_fail check "my.fOo Bar.hi" "Value not found for \"my.fOo Bar.hi\""
> +'

Sorry, this is still not right. You're checking that either test-config
OR test_cmp fails. You want to check both.

Basically, you can't use the "check" helper here. Your v5 was right for
this test:

test_expect_success 'find value with misspelled key' '
	echo "Value not found for \"my.fOo Bar.hi\"" >expect &&
	test_must_fail test-config get_value "my.fOo Bar.hi" >actual &&
	test_cmp expect actual
'


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
