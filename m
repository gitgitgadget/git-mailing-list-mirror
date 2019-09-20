Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2261F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfITQh5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:37:57 -0400
Received: from mout.web.de ([212.227.15.14]:36411 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfITQh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568997474;
        bh=MTWlzrHbB/0zDMvPjxCAfSU459XJR2WWM+7iJo6PiNc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PFRawOLzymFxsKBLrGhtZr002cyv4I62pnYnQckz5wziaeKY8dH8XTPEC5urmc9O5
         EXzANc8KwthR7cEyfd2DIeKdJhuWxSE1YuXsQktivyO3JFA37bMzd6J18E7r/xMRHQ
         0M/aApEcC78Y0D9QrDeP7EaW7pYCuQBDWb3EO1RQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrbHJ-1i3dIF2Sy5-013Pd4; Fri, 20
 Sep 2019 18:37:54 +0200
Subject: Re: [PATCH 05/15] name-rev: use sizeof(*ptr) instead of sizeof(type)
 in allocation
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-6-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <afa53824-9d55-9a55-eb00-ead9ff9940ce@web.de>
Date:   Fri, 20 Sep 2019 18:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-6-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WplELNFq5fanfFxUrSRgG0SRH7AwfRZh87e2xdFgMDDDGevveV2
 M2G870anhWYd+jSnMwdTpMBUuTwaSXI8WZ2KsObaBTx1jKmvoKhU9s4tbSMYAbxCFdEFG+6
 f9Wda3BAJRFSrI01KseBK8CZfsbAcuMjL5i/YDqfnbdDVJ8jSk25IJY412hwBGnvpC3Qt+q
 ug9jr4NKybXx2AqOlNaFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1UJAX9LsMO0=:lCCFOIkiUhrlHAAeBbgmBW
 xK+4lCORBvr7FznR+X5+6bBK2OzBwLISxx18CC6yKoNZZEJOUpuA5wDTYjtG+Lag157od+Hxh
 CGtKjYCnaxHCQMBMeljUDG4sbpi+KOlz5uyHVlGknZIJRtHXaKjpyKDMcZGXRnvGNJfsF08Oh
 5DcKOvxUrLBN4tHLWe2sMBOjTcwA/JgFVSezh/JO32PyGxLWPBSKnWZ3i8BrHHy5tbSF4Qj0b
 QwrfrHn7ACVcUzJWlzLj1jhWU+bjIhmX0EDOLtHEYUcwP4GabKzAz7/hjn9uzwrmQ6myE75Qu
 xHpDnojjrb6+5sUEXzzky+uP+pM1d11jhge+O/l0MVYgoGaqJB68mCBYhjOVC4/CFvey0UU+h
 kpeT2TpY2F9Sc+QqqevgODIJfu96EO+op3AYOjXg0r1vUYH2MjEXpl8RxCNdAO3eMxLCBIMuY
 SN+BWp4YQgCEshsOeadQ/kTAJrAmscCHv1eZQVYh95YHr14tOKYmLyXqkitX8ovtJzTYwGsl9
 Zsr8w38H6R8taWqy5XlJnd3A6giUWYKaReOCD4Jai7QmHdmmVf/WJAPvCczSd2U6mh5zhoZXQ
 JB4fQebwXkpmt15PCyKDiTa0GUME/aRxL5fX47utes1YhPfd5bgDEMr2QpEgu/+nphK19OK/q
 JM+hedSOIZYwQtikmckhIsfV+nBM7MHKGAN8g/L8C3GUR4jN0kVuPVlv+YS3zRo+7gu6pwJd3
 AQtzRLXg8Q1lyGq8CXGAZeXQIyRWkRlYaIgdXtz2aAEhYxa0tsCLxrR3mfDZOFa54hoW0aXnY
 rIHGFWXC1Nqd1KQgk0UPsyjWGmxNUjdxkivs7TugLn6yC+tHVbOcB44KxX+qlO2KjvudIwfww
 /CLmTDNfh/oFIm4//IZiFwphO9DMqZMKfMukJDlVHsfLJglh9w53+t+di4HtOYTfC7IXhR60u
 Tv7/GdxzYettTpxphl4Y05pHBEqxDkVCIN2ykykvNUo1UeBv48h4VgnpJo+2N5rZSL+g+E0U7
 J4rRIYzdR3SM425dFXVArAzRE5i1FhLYUDd+rn2xm0qIPcRkRhM95ggEud6ZP6O0LJq4EUDx0
 MBB4sk8/fHZGAo+yGz4hH8LTupNvJbEzTQTF7eG3MqofXU20ysAMFqQ5NscFQghAA3NFS8dkg
 Xoboqj3HVIVK4CTN+JCLZrr6Mo6xdHt9ilIEmaJMDAfzRkAb1LVERrahLuVI8nV5CxUIeCIcg
 EcFqPNSvd9KPLWlyEarLU7jMZQR/tBuMOT1RRjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.09.19 um 23:47 schrieb SZEDER G=C3=A1bor:
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index e406ff8e17..dec2228cc7 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -98,7 +98,7 @@ static void name_rev(struct commit *commit,
>  	}
>
>  	if (name =3D=3D NULL) {
> -		name =3D xmalloc(sizeof(rev_name));
> +		name =3D xmalloc(sizeof(*name));

Here are the declarations of both (and my beloved --function-context
option would only have shown the second one):

typedef struct rev_name {
	const char *tip_name;
	timestamp_t taggerdate;
	int generation;
	int distance;
	int from_tag;
} rev_name;

	struct rev_name *name =3D get_commit_rev_name(commit);

So your patch is correct.  Had me scratching my head when I first saw
it, though.  That old code has been present since bd321bcc51 ("Add
git-name-rev", 2005-10-26).

>  		set_commit_rev_name(commit, name);
>  		goto copy_data;
>  	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
>

