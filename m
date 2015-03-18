From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 18 Mar 2015 17:41:05 +0100
Message-ID: <vpq3852dzry.fsf@anie.imag.fr>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 17:41:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYH2A-00078t-5g
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 17:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933093AbbCRQlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 12:41:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36212 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755466AbbCRQlY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 12:41:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t2IGf3n3010526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Mar 2015 17:41:03 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2IGf52v017059;
	Wed, 18 Mar 2015 17:41:05 +0100
In-Reply-To: <1426662276-8728-4-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Wed, 18 Mar 2015 15:04:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Mar 2015 17:41:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2IGf3n3010526
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427301665.17833@9J7Hh6Kl5yrm2sY91VqyqA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265741>

Similarly to the "merge doc and code", I personally prefer seeing code
and tests in the same patch.

Actually, my preference goes for a first patch that introduces the tests
with test_expect_failure for things that are not yet implemented (and
you can check that tests do not pass yet before you code), and then the
patch introducing the feature doing

-test_expect_failure
+test_expect_success

which documents quite clearly and concisely that you just made the
feature work.

Paul Tan <pyokagan@gmail.com> writes:

> +test_expect_success 'if custom XDG_CONFIG_HOME credentials file
> + ~/xdg/git/credentials exists, it will only be written to;
> + ~/.config/git/credentials and ~/.git-credentials will not be
> + created' '
> +	test_when_finished "rm -f $HOME/xdg/git/credentials" &&
> +	test -s "$HOME/xdg/git/credentials" &&
> +	test_path_is_missing "$HOME/.config/git/credentials"
> +	test_path_is_missing "$HOME/.git-credentials"
> +'

Broken &&-chain. That is a real issue that must be fixed.

> +test_expect_success 'get: return credentials from home file if xdg files are unreadable' '

"files are" -> "file is", no?

> +'
> +
> +
> +test_expect_success 'erase: erase matching credentials from both xdg and home files' '

Double blank line.


On overall, except the broken &&-chain above, the whole series looks
good. Feel free to ignore my other nitpicks if you prefer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
