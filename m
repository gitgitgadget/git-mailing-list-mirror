From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 01/11] t6301: for-each-ref tests for ref-filter APIs
Date: Sun, 14 Jun 2015 10:12:50 +0200
Message-ID: <vpqvbeqd7y5.fsf@anie.imag.fr>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
	<1434226706-3764-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:13:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z432c-0002JP-BX
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbbFNINB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:13:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55464 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbbFNIM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:12:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5E8Cnts026604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 14 Jun 2015 10:12:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5E8Co9N026161;
	Sun, 14 Jun 2015 10:12:50 +0200
In-Reply-To: <1434226706-3764-1-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 14 Jun 2015 01:48:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 14 Jun 2015 10:12:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5E8Cnts026604
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434874372.11252@XWPxIDjJiaRVAL6nzykYgA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271610>

Karthik Nayak <karthik.188@gmail.com> writes:

> +test_expect_success 'setup some history and refs' '
> +	test_commit one &&
> +	test_commit two &&
> +	test_commit three &&
> +	git checkout -b side &&
> +	test_commit four &&
> +	git checkout master &&
> +	git update-ref refs/odd/spot master

I think you want more corner-cases here. For example,
refs/headsfoo/master should not match refs/heads, and it's easy to write
an incorrect implementation for this => test.

> +'
> +test_expect_success 'filtering by leading name' '

Blank line between tests please.

> +	cat >expect <<-\EOF &&
> +	refs/heads/master
> +	refs/heads/side
> +	EOF
> +	git for-each-ref --format="%(refname)" refs/heads >actual &&
> +	test_cmp expect actual
> +'

Isn't this test redundant with the content of t6300-for-each-ref.sh?

At this point, you've done only internal refactoring, so you shouldn't
need new tests (except to fix coverage holes in existing tests).

I guess you're adding this to build more tests on top, but the commit
message should clarify this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
