From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [BUG] log: Non-zero exit code?
Date: Sat, 21 Aug 2010 09:33:56 +0200
Message-ID: <4C6F8164.3020005@lsrfire.ath.cx>
References: <20100821062158.GJ6211@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 09:34:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omib7-0004ij-Qt
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 09:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab0HUHed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Aug 2010 03:34:33 -0400
Received: from india601.server4you.de ([85.25.151.105]:56785 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab0HUHec (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 03:34:32 -0400
Received: from [10.0.1.100] (p57B79B15.dip.t-dialin.net [87.183.155.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 7E43F2F8082;
	Sat, 21 Aug 2010 09:34:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20100821062158.GJ6211@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154119>

Am 21.08.2010 08:22, schrieb Ramkumar Ramachandra:
> Hi,
>=20
> Here's a quick patch to illustrate the bug report. I initially though=
t
> Bo Yang's series was at fault, but a quick checkout-make tells me tha=
t
> the problem is much deeper- Am I doing something wrong? How did we no=
t
> notice this problem for so long?
>=20
> -- 8< --
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Sat, 21 Aug 2010 11:44:13 +0530
> Subject: [PATCH] log: test to check exit code
>=20
> Add a test to check the exit code of a simple 'git log'
> invocation. The test currently fails: the exit code seems to be 141,
> instead of the expected 0.
>=20
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t4202-log.sh |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 2e51356..bd05bc9 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -37,6 +37,12 @@ test_expect_success setup '
> =20
>  '
> =20
> +test_expect_success 'exit code' '
> +
> +        git log
> +        test_cmp $? 0
> +'
> +
>  printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial" > expect
>  test_expect_success 'pretty' '

> Er, I meant test $? =3D 0.
>
> -- Ram

You can leave out the test line entirely, as test_expect_success alread=
y
checks for an exit code of zero.

The test passes for me with 1.7.2.2, next and pu.  Which version of git
do you use?

Error code 141 smells like the pager.  Can you reproduce the problem
without the pager, i.e. like this?

	git --no-pager log

Ren=E9
