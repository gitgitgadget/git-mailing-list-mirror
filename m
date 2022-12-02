Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F397C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiLBBbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 20:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLBBbS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:31:18 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587CD15A8
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669944672; bh=qnWN1PzPDrjuVQaZepHIhstbWIgwps1KXoIGEsM3pLg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KRNxxKAD5Z41SHQe8HvLB0vIV1luLA8vJsYEwLpk7yepvBz70LqU8J59QwMn26pzb
         mZWQ6dJSoKvHli3xhPry6kncoG5lFK3vOz4wDexKTc72uGMhqeN6gDH4ysqLvTIyXs
         7Rf5oONMi1MbiWhuZi2kjTKRGJG3oQNYCoXm0kT5LWOdMQz3iugTiEix9/llsR4qu1
         y+GGspipPiPaX37naELUoBVOtHWqpadv9c4OFce/9LUFjM/QFOyr2g01nsCrz3hLH5
         4MHsifoIMoL1EsWnQYZEVMCB7YIszVG5Zsqn6AdTITfuxTf0cNxHjWtN6JcBHPmWbG
         8cO1UBbpPGhfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpU1u-1odyfs27NU-00pk8j; Fri, 02
 Dec 2022 02:31:12 +0100
Message-ID: <4f6f065c-1fd9-7c1a-f547-c568e930562d@web.de>
Date:   Fri, 2 Dec 2022 02:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 5/8] t/lib-patch-mode.sh: fix ignored "git" exit codes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-5.8-f826a336c3d-20221202T000227Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v2-5.8-f826a336c3d-20221202T000227Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DVrvjBH/H7VICkrilbPC1ebmRFIJ3s2BBgP4SkjFxZUyh+A4Yez
 LlDKf0Up8frZgGhZm4fP9FRZGew7gjh8BWmD5JEBNDlCGhQNPxhpjQYYQ+MGai7PGVJiDR4
 5EiRRAoYWo9b2l1sEgdptB3NaImmEqtC8SX/Fk1K1ilkwcPFmmOf9J8oiAqCxocKI7yz+GN
 JbhS6wOS3Bo6IQJUJ4Rhw==
UI-OutboundReport: notjunk:1;M01:P0:NG6UhXeJMMM=;kTTAeRMqzxIEVds6psmbE6kHC0i
 Bcria/8TTkgszFsS3zFAUnUYQbrkuNELA2TBWXbaAZajMRBgBQtlZoYAXQ/LPrsvEhX1s9Dx2
 eSEFiaqm+2AP3slwglctvjWnYNSm8xOmfDCOTaOak2085zABvN25lqdfKb1qn0982yZeevPtp
 iLV2QKMKwODFKyvB2irYV8Ysd/zMZzALe+xuywaNDQiRFw9sOHdeMEPSQzeLQZJ6clcn4yVqZ
 6T4rB6IUYYReMac2Hpkopd10y/Ycz/S3dKx+9hBOL5U95NjLUSqbJVIyOoGQzHA37wG51chlL
 3vXpvK21GFKgsWgUSdvAc7JQxr2wL3xACZ2299+Fx7dJOzv+DFJ+EO0iOjkWTW0UxwdCY+cjO
 cYVgNV2lnADlyCcZyW3BCJhzZQEB5DLXD81wrvrB6HF9IBFL+kDNQ7+w/5FCW79U0I44p4+z5
 OvE+H1iw9Ys2MnDMNGeopSnamKPH216S9mb0RQ60FkzwxyXmUTFp4LgrUVoiBAx2BP3a/BRUs
 OXmUB2qwPxYPSYDcnb1oPmkklJq5PamHQHyGAU+Y44H5pXlboSY6BbNwcEHPZpCWRcQFtPnl4
 CKR3sIYOpGNLuHGE56qRl6rPqXi1IfEG7ZPkCq0HaUdGsqg8DkHu+3BblVVREyt1zl9pfxMH8
 OlRJC32zL0AqQgLBlWx8zA+KvY04kMNhkJuFay8e005SjMsR9R21d7LaDEq/66ytYQklbFpGK
 js15mkwqFDNEN0UoQD3XhUKQ/hjN7pe9N3yFSPA2zGI1lrWtjuCTxEl1qwlNgU0uBSeeNoJtZ
 CiH7NYAMbugelXfGLBdAQKWn2aQ3ye5hR7cGp4r6bqPd/KVP2vI8NkZ0bi8eozRkEXyVex3JQ
 gdK7m5ox8g+3ZqayKMb79D/wnX2xhHJWVa6J+BR28CKPLuuWp231T9iUUMwXh7gP3U4kDWW+d
 vDntAlsmbUMMsq4zZ4DLPkUn/jo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.12.2022 um 01:06 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix code added in b319ef70a94 (Add a small patch-mode testing library,
> 2009-08-13) to use &&-chaining and the newly added "test_cmp_cmd"
> instead of interpolating "git" commands in a "test" statement.
>
> This fixes cases where we'd have e.g. missed memory leaks under
> SANITIZE=3Dleak, this code doesn't leak now as far as I can tell, but I
> discovered it while looking at leaks in related code.
>
> The "cat _head >expect" here is redundant, we could simply give
> "_head" to "test_cmp", but let's be consistent in using the "expect"
> and "actual" names for clarity.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/lib-patch-mode.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
> index cfd76bf987b..ae51f33a010 100644
> --- a/t/lib-patch-mode.sh
> +++ b/t/lib-patch-mode.sh
> @@ -29,8 +29,11 @@ set_and_save_state () {
>
>  # verify_state <path> <expected-worktree-content> <expected-index-conte=
nt>
>  verify_state () {
> -	test "$(cat "$1")" =3D "$2" &&
> -	test "$(git show :"$1")" =3D "$3"
> +	echo "$2" >expect &&
> +	cat "$1" >actual &&
> +	test_cmp expect actual &&

Hmm, I'd have expected this oneliner instead, matching the conversion of
the second command:

	test_cmp_cmd "$2" cat "$1" &&

cat is not a git command, though, so the extra checks of test_cmp_cmd
are unnecessary.  But how about avoiding its useless use then?

	echo "$2" >expect &&
	test_cmp expect "$1" &&

> +
> +	test_cmp_cmd "$3" git show :"$1"
>  }
>
>  # verify_saved_state <path>
> @@ -46,5 +49,5 @@ save_head () {
>  }
>
>  verify_saved_head () {
> -	test "$(cat _head)" =3D "$(git rev-parse HEAD)"
> +	test_cmp_cmd "$(cat _head)" git rev-parse HEAD
>  }
