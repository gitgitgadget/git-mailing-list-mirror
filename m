From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Tue, 08 Jan 2013 05:11:23 +0100
Message-ID: <50EB9C6B.6080802@web.de>
References: <201301012240.10722.tboegi@web.de> <20130102094635.GD9328@sigill.intra.peff.net> <7vtxqzyw0g.fsf@alter.siamese.dyndns.org> <7vpq1nyvp1.fsf@alter.siamese.dyndns.org> <50EB0928.3090901@web.de> <7vwqvoj293.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 05:12:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsQXl-0004tJ-0T
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 05:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab3AHELi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 23:11:38 -0500
Received: from mout.web.de ([212.227.15.4]:60121 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab3AHELg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 23:11:36 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MTxxp-1TRrDx00kz-00Qw8C; Tue, 08 Jan 2013 05:11:24
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vwqvoj293.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:bmimw3YmPGI/4N/YWkOHBvF451onm+5xOViWUyo/5hZ
 +JpMDUBGVqKRutc5t88FpoDhvLu0QAjcpH5uQMUd9l/tlFO0Qw
 Tm8xKE5EsfM0HataB+zBl7FEg7r4H4BIq88KtaZlkoYgvBzpeS
 a+19snIUoyW++XDvrex+u8HPy7PK8zFsCe2YwnIuUzylFUV3dE
 CuduuKx7mT2awHvMJQF0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212934>

On 07.01.13 19:07, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Sorry for late answer, but there is a problem (both linux and Mac OS=
 X) :-(
>> $ make test-lint does not do shel syntax check, neither
>> $ make test-lint-shell-syntax
>=20
> In which directory?
>=20
>     $ make -C t test-lint-shell-syntax
>     ... passes silently ...
>     $ ed t/t0000-basic.sh
>     /test_expect_success/
>     a
>             which sh
>     .
>     w
>     q
>     $ make -C t test-lint-shell-syntax
>     t0000-basic.sh:28: error: which is not portable (please use type)=
:      which sh
>     make: *** [test-lint-shell-syntax] Error 1
>=20
> If you edit out '@' (but nothing else) from this line:
>=20
>> 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T)
>=20
> and run the above again, you would see that it is running this shell
> command:
>=20
> '/usr/bin/perl' check-non-portable-shell.pl t0000-basic.sh t0001-init=
=2Esh ...
>=20
> If you introduce a Perl syntax error to check-non-portable-shell.pl,
> like this, you will get:
>=20
>     $ make -C t test-lint-shell-syntax
>     syntax error at check-non-portable-shell.pl line 11, near "whoa
>=20
> So... is your shell broken?  The above seems to work for dash, bash,
> ksh and zsh.
Thanks for helping me out, and sorry for the noise.

My brain "went off track" while chasing a failure of t7400 on pu under =
Mac OS :-(
