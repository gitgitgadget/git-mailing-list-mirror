Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F198C2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA4206F0
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GcU0FeG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgAZWOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:14:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:45343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgAZWOD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 17:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580076836;
        bh=XVwpV1jmIUHyA7xHI+j5gv81OXVusdDjQfEDeteUdz8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GcU0FeG+ukmxL/NHqeXcND9CY1WXPDic0IulGEqlyCW5pePFx8qD2WFQ19CjaaoJW
         712gsHMrYoqNB88ehtfjAxxRGcQ9C/VbFeLBfIT/X8Zyq+byBaEbMYxxOYxmTvLJyY
         5PNVQ9CnZTxzdSR/1Zun7W1e1Ux+z02J8C5JixV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYux-1jkMDn1Ukt-00tzY0; Sun, 26
 Jan 2020 23:13:56 +0100
Date:   Sun, 26 Jan 2020 23:13:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/22] t4211: make test hash independent
In-Reply-To: <20200125230035.136348-11-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2001262311220.46@tvgsbejvaqbjf.bet>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net> <20200125230035.136348-11-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8PlAuoLKGVxlYPRqbkOcjfLS8XP8AX6bUhYFupKucva1JoDgQg2
 DP2XocVUl9GsyZUCC68CE9q+O6rIkC9pnZyoigcotk4PRAWkl0dtS8wqfuR0xdICsG89oew
 4XIr2jYqPkV3hsQ2dmKkUP0FdPn1gskn+39UJfgQpvJdJ8p8fgN8k4s8mxqFPncw0uf+98D
 Ja8H4gKTNYqhdu4d7WqLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GXppowz18sU=:Qgsy/EVrAk5XeAVfPiib0J
 kNARL1YIzeFD2DV+WKSfK21NaEJjlMLzd2DG8PaabA6SwQ6IWghwYm4ViyTPzJx9DqecXD1UN
 1y1xJhitw3zsGzH6Hbn2dFMDqE0coc4Eni+03YmYJ034WwSn2KilthWf8hNWtX/UBg9YB20al
 BpWVbXNf70M1jyjX3GIiv80r2qPbXYe/xKOfNz2GrwByUdBk/Jzywl9SetuOJWxBYXqE+NMvA
 KwWgvsj/ZdMaiBXkqPYdy3dw6jyDacY/KyaqgVu/tihA3cJGYBqM8+BokPugfCX5NQoaUF7VN
 ZhDT3LAHxo6TZkUFqMniwMZgCUat9DT9f049Z3vB7YkHZA4l0zCtYPUzshAhaLwoBzCdJeSvg
 aG6rSKXKAm+3IRJgvRcVCp543+hPc6G9xgzhF0r/JcH13M/wDUrufey2Erzu/VXhf1k4NaF8p
 2j258EzvVJ+aGIOlROozn4pxeEf4DXY+pdkab3yUBwO61B10Y59suqt482zpOHuSDs1eAN5SG
 f+DQj3o3XWYmyjDqERRaA442l6EsIDW0Srf8vs/JIU2IXG4gZRRtzoHiglJH3FhTJ+9LbrozC
 JQk37/CxQsm0IxsBYS+tfmMF0q74pO66j2UXeJoqGabUDEx48dZT3cj1qkBUc1VZ7W++wrj9f
 nEhgQXwnfmvGKNBhIEgVTY+nAFGR7ENR9WGgaNgE72tHRI9IJBeKcyRnCymW58lOxx9uRat2f
 bHtpivur9FME9z+y6RAaKll1JslvU33zptK538buAx1WHb9i8TXXNqtPdhVlpDDXxC5HWOi93
 rMzwSKaUsBasyYNcDk1YHP0jrNnXTtLS5oXJWm8Wp9zWbtoscTQ2dVUNy/BgYjRubaNlacdIp
 OB/jyau+4YB+r6AXygyPbjMs75T/PApIlHxge+6hyfKpKVqd4nN9LpTMVcGJaovjB2iFCydGx
 eSh8DylqPY/CbsaSZPRidinPEZDXgFVdfaSFM3DLxsNHQUlUM+SQmtRSdUNU4YvQK3Rb5beYr
 zOZ50HQ1Zj5wbo76iizjCKm3lb5ft+Q6BxS5Ru50I3hc/x2L77mRdW1pVyT+VCbbqihNxEChw
 wzmiiZmSWgHiNuzkKUJfpB5BMVd8hRTwxP++lbaRQm6F3hYrCa4gWjYRIy9/ikBtNAWiZYQK7
 1e+/htDC+hxlqWikYYwFQRsxIgCG4zGFI3r0lH34wEc1CrAwqZDN9HZfGSGONIHjreTr8l0bu
 3MxJQBtHdgCUTmneT
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sat, 25 Jan 2020, brian m. carlson wrote:

> This test uses several test files that contain hard-coded SHA-1 object
> IDs. Replace these values with generic ones of the correct size so that
> the test works with either SHA-1 or SHA-256.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

An alternative would be, of course, to change the files in t/t4211/ to
have SHA-256 variants, and then to implement a helper to replace those by
SHA-1 variants when needed.

It would be quite a bit more work (and I'd be willing to carry at least
some of it), but I think it would be worth it, in order to keep the
associated safety against regressions. Would you agree?

Ciao,
Dscho

>  t/t4211-line-log.sh | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> index 8319163744..2cbfd8dd9e 100755
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -8,10 +8,20 @@ test_expect_success 'setup (import history)' '
>  	git reset --hard
>  '
>
> +process_output () {
> +	x07=3D"$_x05[0-9a-f][0-9a-f]"
> +	sed -e "s/commit $OID_REGEX/commit $ZERO_OID/" \
> +	    -e "s/commit $_x40$/commit $ZERO_OID/" \
> +	    -e "s/Merge: $x07 $x07$/Merge: 0000000 0000000/" \
> +	    "$1"
> +}
> +
>  canned_test_1 () {
>  	test_expect_$1 "$2" "
> -		git log $2 >actual &&
> -		test_cmp \"\$TEST_DIRECTORY\"/t4211/expect.$3 actual
> +		git log $2 >result &&
> +		process_output result >actual &&
> +		process_output \"\$TEST_DIRECTORY\"/t4211/expect.$3 >expected &&
> +		test_cmp expected actual
>  	"
>  }
>
>
