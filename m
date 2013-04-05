From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 3/3] diffcore-pickaxe: respect --no-textconv
Date: Fri, 05 Apr 2013 09:40:21 +0200
Message-ID: <vpq7gkhqvbu.fsf@grenoble-inp.fr>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
	<7d36738417942b594c185953115a244ad6f3c7a0.1365105971.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 09:41:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO1Gk-0005FF-W6
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 09:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349Ab3DEHki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 03:40:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60782 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab3DEHki (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 03:40:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r357eKlJ007219
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Apr 2013 09:40:20 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UO1G1-0008Mz-HR; Fri, 05 Apr 2013 09:40:21 +0200
In-Reply-To: <7d36738417942b594c185953115a244ad6f3c7a0.1365105971.git.simon@ruderich.org>
	(Simon Ruderich's message of "Thu, 4 Apr 2013 22:21:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 05 Apr 2013 09:40:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r357eKlJ007219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365752422.74527@7kNISp3552ITQe7Rahejag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220155>

Simon Ruderich <simon@ruderich.org> writes:

> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -116,4 +116,18 @@ test_expect_success 'log -S -i (nomatch)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log -S --textconv (missing textconv tool)' '
> +	echo "* diff=test" >.gitattributes &&
> +	test_must_fail git -c diff.test.textconv=missing log -Sfoo &&
> +	rm .gitattributes
> +'
> +
> +test_expect_success 'log -S --no-textconv (missing textconv tool)' '
> +	echo "* diff=test" >.gitattributes &&
> +	git -c diff.test.textconv=missing log -Sfoo --no-textconv >actual &&
> +	>expect &&
> +	test_cmp expect actual &&
> +	rm .gitattributes
> +'

While we're there, we could test -G --no-textconv too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
