From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 4/9] t5520: test for failure if index has unresolved entries
Date: Wed, 13 May 2015 11:32:03 +0200
Message-ID: <vpqy4ks257w.fsf@anie.imag.fr>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 11:32:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsT1W-00049d-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbbEMJcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:32:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42227 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985AbbEMJcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:32:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4D9W2EK001814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2015 11:32:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4D9W3r8021598;
	Wed, 13 May 2015 11:32:03 +0200
In-Reply-To: <1431508136-15313-5-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 13 May 2015 17:08:51 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 May 2015 11:32:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4D9W2EK001814
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432114324.21545@5iIkoBVKp5aXqoIr6s4wTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268964>

Paul Tan <pyokagan@gmail.com> writes:

> +test_expect_success 'fail if the index has unresolved entries' '
> +	git checkout -b third second^ &&
> +	test_when_finished "git checkout -f copy && git branch -D third" &&
> +	verbose test "$(cat file)" = file &&
> +	echo modified2 >file &&
> +	git commit -a -m modified2 &&
> +	verbose test -z "$(git ls-files -u)" &&
> +	test_must_fail git pull . second &&
> +	verbose test -n "$(git ls-files -u)" &&
> +	cp file expected &&
> +	test_must_fail git pull . second 2>err &&
> +	test_i18ngrep "you have unmerged files" err &&
> +	test_cmp expected file &&
> +	git add file &&
> +	verbose test -z "$(git ls-files -u)" &&
> +	test_must_fail git pull . second 2>err &&
> +	test_i18ngrep "have not concluded your merge" err &&

Reading this, I'm actually thinking that the message may have been
better written as "You have not concluded your previous merge". But
that's definitely out of the scope of this patch.

Anyway, the patch looks good to me, thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
