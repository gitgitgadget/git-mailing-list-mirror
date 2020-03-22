Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1ADC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 17:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D6620732
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 17:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GzALSVdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCVRgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:36:20 -0400
Received: from mout.web.de ([212.227.17.12]:53471 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVRgU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 13:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584898577;
        bh=KQh+MbYdilfk6JGCncRFOnV56DwGDCcXh7y5dTMqhCQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GzALSVdyrkZeVBTVdMrebtNAtE7My8JstSEFUjNFXsrak6f710uK7K5BfOqu7FT6m
         G1AU6eH7zgm/MvWU/82LTiFqui8oYaFRbOZT9vklY0qGM6BCfbqPAVlYcc0aOImY4z
         7QZBDQ2nhwBBd5mx5TGifhJ5RzWVovaRfxLGtRrI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1GAG-1jZoMb0Q1Y-00tAhV; Sun, 22
 Mar 2020 18:36:17 +0100
Date:   Sun, 22 Mar 2020 18:36:16 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Shanthanu <shanthanu.s.rai9@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH 1/1] t9116: avoid using pipes
Message-ID: <20200322173616.wnz3umcxz25upv63@tb-raspi4>
References: <20200322124619.30853-1-shanthanu.s.rai9@gmail.com>
 <20200322124619.30853-2-shanthanu.s.rai9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322124619.30853-2-shanthanu.s.rai9@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:4PiLO4pclMLKnhC5gJD4fggRwfjD3j6EWAF6vFJUHSS0yCgm/av
 WNFekyqXlbzJGvZdBPvXdTOT4+iclw8LVzvabubefaXIVuXh0KsXTXYOPPmj+OJ4abHVtFz
 +/8MWGg4yn9BrKAoN2yXH68teU0QzFuVukmYd4ATtyjoZST1RL0DdAVyL3rN0cgxmwa+4RS
 0GKhz4Aiyjss5rig7/TTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WivfTOk98U0=:bkdo8sB5hT604scEPHkVtl
 nwD4MCBN9VXW+yWscDEFaqdZRuuS+Btbi9hAu5XNKl+8VVWJXOhaUlXzgsrKGNU0ChBsG2Oko
 x6QwV1IxQm+3ztuSX8JxvadOLLosmyLRTSgQJYV+jIUYoMm/FSjimb40p9wH8GPpiinv5XVot
 a83WW3hTIMMGjvM+9dud4SDwlqpmGn4g2xb2pGja8ghxT5kw/QdRk9bdN4wgpoTpusXetHS5Y
 BwNYGD0WtKpbF4JocIaVMYNW+spVF8VApa/krPl8LgRjx2m21PjLKuEJ0Oxafm37uy7MbRgYX
 TlxWlVcpejKAEHeZEySQQ2/KuVup7bq7fM3qBlrg3bv2/pWByNp6PTesZr9W1ABkU2HmBskws
 Tlo4rOnwmSecUcaBGZ/YyrmPo9UxiHYZC8SDpcToV3actHLYrKBWVF64lLPY84/M1hhz8Zix0
 Zt53VusG4A2RCh3tG00NrXnvzaqVObSS9NQdJQ0LmcTxCVzRFdfhlC87eKK1p6POaXHnkPwNd
 aTzBiYYplq7W9pRVkk6cE41yeGVn6RzxkoAKy4K5HUuvgUfDVz2Pw5RZ/zByNg2PSDz/dQu6r
 xIp1OtDxRmTInyP+ULA5IJ5MGVXCZYa9DRb8po+qLGVm9asP9KUd6NpmavbA5bMZ23NgeaZmY
 1by5f8I8OIwC5KVJY6fpw81NdbsCgFZYSnAPx6kx+y4tM7slSViiSoDzEMndg52e/ymLsWnv0
 g+CaQX3M0+YRTHzVUhgs3JMa3hkZB2C3OV4Nt4kgdUjvMz0vncmpd3eh3S8cgQTHNPrBrtm5r
 OyZwNLTczs0kGLk2ndmXUck7YVTDM1L8v1TFYXTpP2Xu19as1cOhJQB6b2gZCTXSPjLjkLD2E
 M0iffv8tKjugcXMFb9joqzMGP0N/pLegKPgGfYlz5YExKtjY+f56oRXjM7uMJ1At1OZGz/BGr
 o2LA9UxQ2lEYbDl00O7QbCDE0pKylkTJa/4kOre1q2b02M2xwaXRlFyVnGtI3Bpa1v1CDmQ9H
 qzQquGibdB+o+mF9mT5ZkqruOlEuAU8PK6ME/jILgepFC1d2KLyzbG1Pg8A0gKWFRhdyc+uEx
 U72Yh6nEPvsqoFu2Ze1kXbL3OKSANIUy8oIrSzy8/XgWkZZvKUqjFt0TmeH7sfCTJDSsMrReL
 9icexxD+N+NsGTrItxtuMZPc5PV72R5mR9JpovmCR6HzTrPZI2ziNe+ypaZ8syoAP2vpu19Qi
 qY6xJ6cYzTv2/onYW
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for contributing to Git.

On Sun, Mar 22, 2020 at 06:16:19PM +0530, Shanthanu wrote:
> Commit de26f02db1 (t9001, t9116: avoid pipes, 2020-02-14) noticed that
> when grepping through the output of a command, there is always a
> chance that something could go wrong.

That "something could go wrong" may deserve little bit more explanation
in the commit message.
One thing when using pipes is that we may loose return codes of programs
being part of the pipe.
The other thing is that it is hard to debug, if the test case fails.
Having the "out" file left on disk allows manual inspection, and tracking
down why it failed.
Having said this, we can make the test case even easier to debug, and cons=
istant
with other test cases, please see below.

>
> So, redirect the output into a file and grep that file. Thus the log
> can be inspected easily if the grep fails.
>
> Signed-off-by: Shanthanu <shanthanu.s.rai9@gmail.com>
> ---
>
> In test 'test ascending revision range with --show-commit (sha1)',
> 'out1' variable is used since 'out' variable was already in use.
>
>  t/t9116-git-svn-log.sh | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
> index 0a9f1ef366..d82aa0fab9 100755
> --- a/t/t9116-git-svn-log.sh
> +++ b/t/t9116-git-svn-log.sh
> @@ -61,12 +61,14 @@ printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
>
>  test_expect_success 'test ascending revision range' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r1-r2-r4 -
> +	git svn log -r 1:4 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 =
-

That could be written as
	grep '^r[0-9]' out | cut -d'|' -f1 >actual &&
	test_cmp expected-range-r1-r2-r4 actual

Or something in that style  (and similar below).
What do you think ?

>  	"
>
>  test_expect_success 'test ascending revision range with --show-commit' =
"
>  	git reset --hard origin/trunk &&
> -	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | te=
st_cmp expected-range-r1-r2-r4 -
> +	git svn log --show-commit -r 1:4 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 =
-
>  	"
>
>  test_expect_success 'test ascending revision range with --show-commit (=
sha1)' "
> @@ -74,7 +76,8 @@ test_expect_success 'test ascending revision range wit=
h --show-commit (sha1)' "
>  	git svn find-rev r2 >>expected-range-r1-r2-r4-sha1 &&
>  	git svn find-rev r4 >>expected-range-r1-r2-r4-sha1 &&
>  	git reset --hard origin/trunk &&
> -	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f2 >out=
 &&
> +	git svn log --show-commit -r 1:4 >out1 &&
> +	grep '^r[0-9]' out1 | cut -d'|' -f2 >out &&
>  	git rev-parse \$(cat out) >actual &&
>  	test_cmp expected-range-r1-r2-r4-sha1 actual
>  	"
> @@ -83,45 +86,52 @@ printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
>
>  test_expect_success 'test descending revision range' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r4-r2-r1 -
> +	git svn log -r 4:1 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4-r2-r1 =
-
>  	"
>
>  printf 'r1 \nr2 \n' > expected-range-r1-r2
>
>  test_expect_success 'test ascending revision range with unreachable rev=
ision' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r1-r2 -
> +	git svn log -r 1:3 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r1-r2 -
>  	"
>
>  printf 'r2 \nr1 \n' > expected-range-r2-r1
>
>  test_expect_success 'test descending revision range with unreachable re=
vision' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r2-r1 -
> +	git svn log -r 3:1 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r2-r1 -
>  	"
>
>  printf 'r2 \n' > expected-range-r2
>
>  test_expect_success 'test ascending revision range with unreachable upp=
er boundary revision and 1 commit' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r2 -
> +	git svn log -r 2:3 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r2 -
>  	"
>
>  test_expect_success 'test descending revision range with unreachable up=
per boundary revision and 1 commit' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r2 -
> +	git svn log -r 3:2 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r2 -
>  	"
>
>  printf 'r4 \n' > expected-range-r4
>
>  test_expect_success 'test ascending revision range with unreachable low=
er boundary revision and 1 commit' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r4 -
> +	git svn log -r 3:4 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
>  	"
>
>  test_expect_success 'test descending revision range with unreachable lo=
wer boundary revision and 1 commit' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r4 -
> +	git svn log -r 4:3 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
>  	"
>
>  printf -- '------------------------------------------------------------=
------------\n' > expected-separator
> @@ -138,12 +148,14 @@ test_expect_success 'test descending revision rang=
e with unreachable boundary re
>
>  test_expect_success 'test ascending revision range with unreachable bou=
ndary revisions and 1 commit' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r4 -
> +	git svn log -r 3:5 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
>  	"
>
>  test_expect_success 'test descending revision range with unreachable bo=
undary revisions and 1 commit' "
>  	git reset --hard origin/trunk &&
> -	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expecte=
d-range-r4 -
> +	git svn log -r 5:3 >out &&
> +	grep '^r[0-9]' out | cut -d'|' -f1 | test_cmp expected-range-r4 -
>  	"
>
>  test_done
> --
> 2.26.0.rc2.28.g7fcb965970
>
