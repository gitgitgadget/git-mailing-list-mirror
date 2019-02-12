Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5A11F453
	for <e@80x24.org>; Tue, 12 Feb 2019 07:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfBLHUu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 02:20:50 -0500
Received: from mout.web.de ([212.227.17.11]:40551 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfBLHUu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 02:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1549956040;
        bh=fVTjQslt4JrzbicmP94VFaKSKtOupjAbmw3RRl5GZvc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QLbBE/mrzKkfnwaya/3+YZUwv6NIRnyVpG2v5mXGoKhXJbPNkE6nhBXI4Ip5yDD3e
         7Evc2A0op8B2NCZlDwunnW4EqlgXW8UUUgh9iMOEi6dLe1h40cgVlXDw4ufgn2P06n
         ypMOem4J2rH7poxpkjn8mODfVZFlMIaTK+R6/DzA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([79.237.250.190]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshWf-1h4lvd1UIT-012Jc7; Tue, 12
 Feb 2019 08:20:40 +0100
Subject: Re: [PATCH 24/31] archive-tar: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-25-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2a6cf99a-c297-225c-b3c9-c30e1ac83948@web.de>
Date:   Tue, 12 Feb 2019 08:20:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212012256.1005924-25-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YU0vd3+qdpug1VGTQZ7Nw5pasIsCGAMD0GwzmB/QXqBY1bfKuR/
 7yCwMvCQLlu8Hc4zFUw+RaPrZxxoDkj7Lt1nWpWgo4kE/8sOc65gWgcUmDIod9dKL5A5DdR
 scgPAoNjXz3a5z2v+6cjfQX2pwaHWyQrSyHPnER9Dj4qUisy213rC775/abRw5S0zcL/l9K
 0U+NQJYzFvMy+kCg1bz3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lv+mC6lqtm4=:Qg/b53BWjAHD6NNeBlDCdj
 VIePTgWqZHnotF5Q0hhZ1PRiToMKND1pvsiBGs+QYegA3LjY+RLq4ckS5FSlrte44MOXzl1ub
 Hadxz63mlTve4mrgiO2cqj6srOx/9RboCU+66DuR+ejN+JV0l81jqdnob/TLRK6R1YC7yU/EU
 aizMyUKIQLQ+RuoAPuu0nFoz0C/DJ4qfAqEuGtNJIjJW19VD76CZYOboQB7jz7Qy2e4jC2R4s
 N89Or8IMdEBiMlmm2E6ipyGuRgdXQqTGQvcc9NObrLFN6+UJa6xVn8+NIcdaMvn/8vJLmDpJF
 yca2nvd86v+4kDX/wCVbrToLND+bFar6Bpma/sK4BH98u9jdmVZZZUoQwzYQjbKqiNlGb/PVa
 2vl4oDJml/7XeBYtve9rWlAGcwtAgfYU28XgjcgSsoIIfMY9hB47E92kHaAdo4arp+u5NI+nq
 cD94ntttlgqVm4vHGqjv6iSEGCrTP5v4PHquBGs3fEZD8c1ULg9R4WKZeyofwuTibAdKwwFqK
 BL3tVmeofZ1pIYXUP2ZW+ByFSfgSV2EhwdH28b+sDwA5/7T4KkfsX9TA98GHhD9aaxCEg1URs
 kv37KHlHZ/mSPfzpP25ko0AnC0d0S8PzJSxhMsGN57NHgv0sJXC1sJA6nik/CYOBAxU3uE3bp
 gSX1eYkCJbPjcayWmLmdvNExP19NUC7e73ftM5/LGxz+4GLBEkdUYcWTQI5HBoiNGa3Erg1ws
 WGcF2hq4hpvk5tRGRhiKUhnx0lUba35FqaXOqgBnDqMkG+7EsNbFXC+DKz2te+fznl6iQLyG1
 hEHzfRJoH6gtdb/kTOy2/49MlRE83hIYZ6ZV1JtuhT7V9t5FHtRnE7fxvg0yu2Vw5IStKEnGz
 5rsKLr0cFRIobjyd6OnH00EGbjosXdGESJvTfchdIj5BUryey2YXdkvOoNUqqf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.02.2019 um 02:22 schrieb brian m. carlson:
> diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
> index 2706fcfaf2..2760549e91 100644
> --- a/builtin/get-tar-commit-id.c
> +++ b/builtin/get-tar-commit-id.c
> @@ -5,6 +5,7 @@
>  #include "commit.h"
>  #include "tar.h"
>  #include "builtin.h"
> +#include "strbuf.h"
>  #include "quote.h"
>
>  static const char builtin_get_tar_commit_id_usage[] =3D
> @@ -21,6 +22,8 @@ int cmd_get_tar_commit_id(int argc, const char **argv,=
 const char *prefix)
>  	char *content =3D buffer + RECORDSIZE;
>  	const char *comment;
>  	ssize_t n;
> +	char *hdrprefix;
> +	int ret;
>
>  	if (argc !=3D 1)
>  		usage(builtin_get_tar_commit_id_usage);
> @@ -32,10 +35,14 @@ int cmd_get_tar_commit_id(int argc, const char **arg=
v, const char *prefix)
>  		die_errno("git get-tar-commit-id: EOF before reading tar header");
>  	if (header->typeflag[0] !=3D 'g')
>  		return 1;
> -	if (!skip_prefix(content, "52 comment=3D", &comment))
> +
> +	hdrprefix =3D xstrfmt("%zu comment=3D", the_hash_algo->hexsz + strlen(=
" comment=3D") + 2 + 1);
> +	ret =3D skip_prefix(content, hdrprefix, &comment);
> +	free(hdrprefix);
> +	if (!ret)
>  		return 1;
>
> -	if (write_in_full(1, comment, 41) < 0)
> +	if (write_in_full(1, comment, the_hash_algo->hexsz + 1) < 0)
>  		die_errno("git get-tar-commit-id: write error");
>
>  	return 0;

That command currently prints the pax comment in tar archives if it
looks like a SHA1 hash based on its length.  It should continue to do
so, and _also_ show longer hashes.  Your change makes it _only_ show
those longer hashes.

So it could check for all known valid hash lengths in turn, or accept
any payload length between 40 and the_hash_algo->hexsz, or loosen up
totally and show comments of any length.

Ren=C3=A9
