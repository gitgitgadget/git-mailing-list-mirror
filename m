From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 2/2] send-email: add tests for refactored prompting
Date: Tue, 31 Mar 2009 12:33:03 +0200
Message-ID: <20090331103303.GD3307@atjola.homenet>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com> <1238290751-57461-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 12:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LobIq-0006Sp-27
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 12:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbZCaKdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 06:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbZCaKdK
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 06:33:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:41451 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751637AbZCaKdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 06:33:08 -0400
Received: (qmail invoked by alias); 31 Mar 2009 10:33:05 -0000
Received: from i59F54235.versanet.de (EHLO atjola.local) [89.245.66.53]
  by mail.gmx.net (mp045) with SMTP; 31 Mar 2009 12:33:05 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18UOl5/dA0UYt2FXFzKk3Iiq8AEaIfNlSEaleO/Jc
	K9lkxBLdaZLGBz
Content-Disposition: inline
In-Reply-To: <1238290751-57461-2-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115248>

On 2009.03.28 21:39:11 -0400, Jay Soffian wrote:
> +test_expect_success 'confirm detects EOF (auto causes failure)' '
> +	CONFIRM=3D$(git config --get sendemail.confirm) &&
> +	git config sendemail.confirm auto &&
> +	GIT_SEND_EMAIL_NOTTY=3D1 \
> +		test_must_fail git send-email \
> +			--from=3D"Example <nobody@example.com>" \
> +			--to=3Dnobody@example.com \
> +			--smtp-server=3D"$(pwd)/fake.sendmail" \
> +			$patches < /dev/null
> +	ret=3D"$?"
> +	git config sendemail.confirm ${CONFIRM:-never}
> +	test $ret =3D "0"
> +'
> +
> +test_expect_success 'confirm doesnt loop forever' '
> +	CONFIRM=3D$(git config --get sendemail.confirm) &&
> +	git config sendemail.confirm auto &&
> +	yes "bogus" | GIT_SEND_EMAIL_NOTTY=3D1 \
> +		test_must_fail git send-email \
> +			--from=3D"Example <nobody@example.com>" \
> +			--to=3Dnobody@example.com \
> +			--smtp-server=3D"$(pwd)/fake.sendmail" \
> +			$patches
> +	ret=3D"$?"
> +	git config sendemail.confirm ${CONFIRM:-never}
> +	test $ret =3D "0"

These two cause interactive prompts for me.

Bj=F6rn
