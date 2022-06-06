Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AEEC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 09:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiFFJsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiFFJsb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 05:48:31 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D89BF5D0D
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654508893;
        bh=Heu8lMCqhXJ9ltK34wiWrzexk4NJXwzUNdPBzMsPLf0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Pt1mZvvbfxPk0D+Po2loAC1cc16Rn//QzeGA3MiwmF9LhGf4WRiNZb3uztRZ8u/53
         bl+D97MG6zLf+WAPSgbrsM9w1i6NSOPcM++Mr2e5jX8fzF5izsnJ7svPrvokzU/c9B
         tikmC2Vor4fgLfvxD27PKV2TO5G7OuDwcRV6Wfjw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3t5-1o1lyk2nV1-00FLVn; Mon, 06
 Jun 2022 11:48:13 +0200
Message-ID: <9195fe51-a696-1fb7-3617-a5b65358a806@web.de>
Date:   Mon, 6 Jun 2022 11:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] read-cache.c: reduce unnecessary cache entry name copying
Content-Language: en-US
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1249.git.1654436248249.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.1249.git.1654436248249.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2J6m7z9Q3h3yWd8qygJgTGFAIrUfc02TSzTMAQrSDVV/p29a88H
 Haux3Kuia3NvQhL6og9vz2OlARQuZdXeTDNxoSLx6Of+nQ6p8KnNjgE23/zL8cGG+1YxkYd
 Bjyk1jkNsm3p6a2c22bv0a6YpekuOrKXGbu4dRjHuUMDNDWOiKUlYqwaIXabFzYM3A4Jb0R
 46R+WmtmogxIg1raoaIHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4/B4+Lof35s=:ly32NwNyi0NTpj6LgL4h31
 C9hy+V0fKtQLjDpDHZJqkEHFQDAiQ0m/bf0EVrrQVj4CLkEaFzGvN9WsqjaxRDd2uwuC2RIu4
 S8APm+I9HynHRO362IIFP3DYfbkpmv7MFvlP2yl7hexNikvf+jxr8tmSnMeb3LxgtXDgaO0lg
 px1G2JID0rNPwCMVugpLeDXtPTEsME/SIpH7dxaHNHEOG7kh+YRX4D/rcMSh/77ChkSL156NT
 D6mxVFIN72eP56VD0T5pujl20WxTydGRUBzR1yRVZ4DG56USFNHozf/pdB0YA+qKOGkd0o5hg
 QWrCpzuvyki/BgcTBwxcWMKb3+EqhSZoM3xioXe4j+jUvUjbv4zGt/qPJY1X8A5MyFSdnmSWz
 RLfJlVYSXw3LkMKj8jUn6AwftNz/shjbewwDJyfT/FC/lc2GwxOs3KA4+sYGXC/JcdI1PVPBo
 VZONfpFuOnfby+9O+bPCyr8I7qOFglDfrGa000w+uM6NAJ8+3nwX+/El0VtZRRaDcEjmKTVTF
 t9fX/3BxXmat9pZbIzv3C5wJ4HCRExJE1sMJ7qKDrRk5sE/zw5npmR8GVYrtFTDUsd4prq1dz
 KULVhs3aH8y9VHrh58bj61EFDOveVYseG8K6frjpunlRuJQmfv6wyXUXwq+QFlVKxiDyaOn/G
 HIf7c8xJkJrSv2OSMG9oLGNWxIB3y+7t/NskQmPPlgNIi/hK/7uZA9YJkn4cI0+dQt1fOe2qT
 TdNYGfo29cgoUuz7eE9KDoxGxxexrTv0ruL4XjOE+ROd6J8aoVR4WRgDWPojU+ylkk9VFheGB
 VL3hknqtCYKm5nToBW82hqq0D4J3l7P7QmBTlomHwO0iPEYpa5fJ/3eZQB7Ph5C6OwBPh2qEX
 zR2MHiYblMHVNm5RIbp3R21uT98ELM3HGwlE+APBG030NF0/0mOHRyXsYayQXTFcSu1H0nFfu
 4yh8SNMRGQdxftdALHO0EmIjBer3c3iqAPZMYwG1gHH4d0nFZMSofVJfPNmaMAGxh7Wb8YuvP
 xbbTN7xCBlq5ODL5jUYWBGfZV4vJ29YRjvZj2Vmb5HMJRzqQ+BaQ/alYZG9wOCvHlcOEUl70r
 44BmZ0fJdRq+N7r4p7kww6T2/+tuvnMpD49
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.06.22 um 15:37 schrieb ZheNing Hu via GitGitGadget:
> From: ZheNing Hu <adlternative@gmail.com>
>
> In function create_from_disk, we have already copy the cache
> entries name from disk or previous cache entry, we can reduce
> unnecessary copy before that.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     read-cache.c: reduce unnecessary cache entry name copying
>
>     Index cache entries name are copied twice wrongly, so reduce the fir=
st
>     one to fix it.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1249%2=
Fadlternative%2Fzh%2Frm-ce-copy-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1249/adlt=
ernative/zh/rm-ce-copy-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1249
>
>  read-cache.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 96ce489c7c5..e61af3a3d4d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1944,8 +1944,6 @@ static struct cache_entry *create_from_disk(struct=
 mem_pool *ce_mem_pool,
>  	ce->ce_namelen =3D len;
>  	ce->index =3D 0;
>  	oidread(&ce->oid, ondisk->data);
> -	memcpy(ce->name, name, len);
> -	ce->name[len] =3D '\0';

This removal looks  correct to me.  The extra copying was added by
575fa8a3ed (read-cache: read data in a hash-independent way, 2019-02-19)
but its commit message doesn't mention it.

>
>  	if (expand_name_field) {
>  		if (copy_len)

Some more context lines would help to see the redundancy; here they are:

	if (expand_name_field) {
		if (copy_len)
			memcpy(ce->name, previous_ce->name, copy_len);
		memcpy(ce->name + copy_len, name, len + 1 - copy_len);
		*ent_size =3D (name - ((char *)ondisk)) + len + 1 - copy_len;
	} else {
		memcpy(ce->name, name, len + 1);
		*ent_size =3D ondisk_ce_size(ce);
	}

>
> base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
