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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F535C2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FD320716
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lKtMOHay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAZWXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:23:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:43669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgAZWXk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 17:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580077412;
        bh=QRdmhWnfyhI5SfOHRGAJE5FmZsum/lDUGmQCZRQx8cU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lKtMOHayS+t1AIDQgY4Jr7wMILqnKRNALhjx/OluG0k1XnC5zYmqoTDA1GZwoyjt6
         +87Ao4f4WVv4vH2XtAWfoevNatcK4ay9O8jpCDsj8dFCZFF6KBzVRrIyRuCFPMDuC3
         4uRrKfuARfUdaQqwnysu35jpX//+8dju+fXHX7lY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPog5-1jHcQh2gmR-00MwWd; Sun, 26
 Jan 2020 23:23:32 +0100
Date:   Sun, 26 Jan 2020 23:23:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 11/22] t5302: make hash size independent
In-Reply-To: <20200125230035.136348-12-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2001262315150.46@tvgsbejvaqbjf.bet>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net> <20200125230035.136348-12-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XLjHbPR5sefsUT25yqioZyyyCGJgrHPIdcTDTGMw9+WwuPoTdpq
 RhxjK0tNPqUbz0caKVhVSGk4V2qVgRIW2OFRjeP6cOgVV/NUPeU7/Uh0BwKLMJdKifIc7hE
 /cfaPhhX5K3mSKqCdIXjyGLkBpVCRJTQzAAy2IHUJe1hWGPHOuyBwyk114m6f+i2lqLU/iW
 GNBacgsxzhL9wWGALjf2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gUCGnIAyNIg=:0gNzjwGldSqi6JZ15Lx08M
 bp0o4JPudWk2spxF5esQRECvs3WnakNw26OnCzB0VzAFvLd/Zxhwo0ra3Tq4Mg0KH85PP5ox6
 G08fQK+8Y3kXzWJEG3o4aTPmrXywXEsUeFzfYzcqXoXObB6v+qquZE267NX2+O5RODADOaHyY
 ZWa3yPZc4XHSRU01vbRttHbmZwcz10+oc9DbycNeqa7w36LXWoU6xf9TjL9B6rqXNAaPG8flW
 jurx2lMXk+1qeakcq7k4szCp+jMVDhRQFOPzM7gZks5eKIbKizBdiZUxZeMthtfzxizsu2HBU
 WkYmTR35ZZukgrRK9X737iTqTa753RXB57nSBS5HcRdZHd9+u6oRWxV9nhrLmOFaVij8KOmyk
 Y1Ohkf4mfbEguGSRCodffMWTy2xrlBEOMtAWQBcxTt3JQMDllPJ5/ShzJUJ/QH0STZpukg+Xj
 ZI0Ef9wffXnbVUnK1LVP9kNF27KOWxv6kLoD7CWdDoU+Z/AQqPzNEq3weYhyEBybzROt0+3lD
 hg2Z+OEACLRWOARXEz5NP6MwKYo2shhYXkJIhl8ie8EYQJBMfBkCedtI5UfpLknDTou5QN208
 CBWNspoAeL1iCS4XlyJnQB/+oEzU0qHMZoDiCsiPmJJruhp7wz3Hmc1hkPnN3evLy5e6QswYL
 +bycBFkVd13JDPpTNW56WdDS2kiwibsKISDoPgCWI7L2PftA0jqbzmFW1qqdBtRblwtQxGKvH
 CaE/pNMVy+mKS1Kny4lPBovKjlwcsbcMEfEzE/Im7ztDLw8Eesk3YPcTGjDgMjmQJFTl5Kq7d
 KtC5hJbztBNdC4vMvXYk1uQZJc9x9jc94cYfsKd7DcnRNgtgdBQ3WDBBfSwWDiQRZKtzY94BP
 A5auXy6vQdEbRPIwikgFI00AwXMrG2ZTn7vgiblAiLyQWFSfYgFYSrvTAkajs3tQ3v4iJXPmt
 1bDIxZkY+5Ubo+qI0e0fTP5UMgIq9RdgY4715lMuGdPN27medFar3IlPEWELYhtajMdanlpZH
 92EzzEzA0pOXrFX/eNd5qOg9h1fW2b0RGUYj2XQsEP/BIQC+0DxXl1kG5VkFMHMf+iKdKbzMI
 XfPVQ1i3uAbMgWV3Y7TyuP3s/W0HkbZk1Hc+Jy21JhKVeM91E7zfTXJUADIWFRZbuvLqRHP3Q
 0R+ajGWtympp062KvcL04p+mGgoYKfphtDZ3AO4PLcU+KtyVzG4O+RBwR62zx9rN7ity1Q0eQ
 eqIa6EPKHJKeHrixf
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sat, 25 Jan 2020, brian m. carlson wrote:

> Compute the length of object IDs and pack offsets instead of hard-coding
> constants.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t5302-pack-index.sh | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> index 91d51b35f9..93ac003639 100755
> --- a/t/t5302-pack-index.sh
> +++ b/t/t5302-pack-index.sh
> @@ -8,7 +8,8 @@ test_description=3D'pack index with 64-bit offsets and o=
bject CRC'
>
>  test_expect_success \
>      'setup' \
> -    'rm -rf .git &&
> +    'test_oid_init &&
> +     rm -rf .git &&

Why not consolidate the `test_expect_success` line into the current
convention at the same time ("while at it")? I.e.

	test_expect_success 'setup' '

>       git init &&
>       git config pack.threads 1 &&
>       i=3D1 &&
> @@ -32,7 +33,9 @@ test_expect_success \
>  	 echo $tree &&
>  	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
>       } >obj-list &&
> -     git update-ref HEAD $commit'
> +     git update-ref HEAD $commit &&
> +     rawsz=3D$(test_oid rawsz)

Since the `rawsz` assignment has a lot to do with `test_oid_init`, I would
coddle this added line with the `test_oid_init` line above instead of
adding it here.

> +'
>
>  test_expect_success \
>      'pack-objects with index version 1' \
> @@ -152,6 +155,7 @@ test_expect_success \
>      '[index v1] 2) create a stealth corruption in a delta base referenc=
e' \
>      '# This test assumes file_101 is a delta smaller than 16 bytes.
>       # It should be against file_100 but we substitute its base for fil=
e_099
> +     offset=3D$((rawsz + 4)) &&
>       sha1_101=3D$(git hash-object file_101) &&
>       sha1_099=3D$(git hash-object file_099) &&
>       offs_101=3D$(index_obj_offset 1.idx $sha1_101) &&
> @@ -159,8 +163,8 @@ test_expect_success \
>       chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
>       dd of=3D".git/objects/pack/pack-${pack1}.pack" seek=3D$(($offs_101=
 + 1)) \
>          if=3D".git/objects/pack/pack-${pack1}.idx" \
> -        skip=3D$((4 + 256 * 4 + $nr_099 * 24)) \
> -        bs=3D1 count=3D20 conv=3Dnotrunc &&
> +        skip=3D$((4 + 256 * 4 + $nr_099 * offset)) \
> +        bs=3D1 count=3D$rawsz conv=3Dnotrunc &&

Similarly, the `offset` variable is only used here, so I would assign it
just before the `dd` call. The name `offset` might be a bit to generic not
to be reused, either, maybe `recordsz` or `index_entry_size` or `entrysz`?

Apart from that, the patch looks obviously good to me.

Ciao,
Dscho

P.S.: I'll stop reviewing here for now (It is not that I am tired of
looking at your patches, it is that I am just tired).

>       git cat-file blob $sha1_101 > file_101_foo1'
>
>  test_expect_success \
> @@ -200,8 +204,8 @@ test_expect_success \
>       chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
>       dd of=3D".git/objects/pack/pack-${pack1}.pack" seek=3D$(($offs_101=
 + 1)) \
>          if=3D".git/objects/pack/pack-${pack1}.idx" \
> -        skip=3D$((8 + 256 * 4 + $nr_099 * 20)) \
> -        bs=3D1 count=3D20 conv=3Dnotrunc &&
> +        skip=3D$((8 + 256 * 4 + $nr_099 * rawsz)) \
> +        bs=3D1 count=3D$rawsz conv=3Dnotrunc &&
>       git cat-file blob $sha1_101 > file_101_foo2'
>
>  test_expect_success \
> @@ -226,7 +230,7 @@ test_expect_success \
>       nr=3D$(index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj) &&
>       chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
>       printf xxxx | dd of=3D".git/objects/pack/pack-${pack1}.idx" conv=
=3Dnotrunc \
> -        bs=3D1 count=3D4 seek=3D$((8 + 256 * 4 + $(wc -l <obj-list) * 2=
0 + $nr * 4)) &&
> +        bs=3D1 count=3D4 seek=3D$((8 + 256 * 4 + $(wc -l <obj-list) * r=
awsz + $nr * 4)) &&
>       ( while read obj
>         do git cat-file -p $obj >/dev/null || exit 1
>         done <obj-list ) &&
>
