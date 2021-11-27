Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0736C433F5
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 07:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbhK0Hhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 02:37:55 -0500
Received: from mout.web.de ([212.227.17.11]:37365 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234455AbhK0Hfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 02:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637998352;
        bh=N5mkVn2DmCwnN0Z0tiRnoj0cTi69en3mO2nVy+nfai4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Wixu1LCEBM5VJy1Idm3QWNXStehk9YRnG1fHwPCYNjiNazV633n0J65McnjGqvuLr
         rXeTMrXkIpOkn4ODNjcRjq7xBEdjaJR5g53RFtYGuRIrjYwQ17UGu2I8dVnLS4u5d1
         Ku5C9PqsuZALovhjndnA0imhGYfeXo7Zr3B0rl9I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.144.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO5C-1mHXRg2smO-00Za4q; Sat, 27
 Nov 2021 08:32:32 +0100
Message-ID: <9c3d6d3c-1f3b-f51c-6856-b5ced44a8f4b@web.de>
Date:   Sat, 27 Nov 2021 08:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 1/4] mergesort.c: LLP64 compatibility, upcast unity for
 left shift
Content-Language: en-US
To:     Philip Oakley <philipoakley@iee.email>,
        GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20211126113614.709-1-philipoakley@iee.email>
 <20211126113614.709-2-philipoakley@iee.email>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20211126113614.709-2-philipoakley@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YHBYLJK8eVrAahNpF02yjFgCdB0mAO36PZrxXeBfu2ku4qtM4wd
 0cu3eCOLXurM2eJqvONpm1hZrTNduMV93r0S7Q83MAIZphcpxZtydPrRv9CKy+oSXyKAj3y
 sCsKVtDF9HZSnlDIxqi46FrTt7AYc8Cml5sauReKVv7qF/HzR5FYi0wKAlt0TA6LefpqBxB
 9VLr2UXPHNqAahw8y39Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9RTBS8AKTqo=:6EQ2TPGfsDeKOnKiDJdqwP
 0rd8duzM1+dd/isaU5KsFUdukjBJ9HJgrZ1lWSw28Gnl4w6stm7VysspOO4dCoZvICTDJMVyh
 CDz4tC/+8H2ruWl6xd1qYE1N8k/X0mnESCYhT8+PDHlfkIdByD+bZx+4CK6FqvokhPFXu7m+Z
 D7M8itSRpV/vZi+U8ZJNf6ruVXAy1/YQI7xafKeW4b4Csh0M7l/jUofUwdCmv7yoqlGwum/69
 OC+Zb+DpqI+OCUmEYpv8Ho8TpUi29t82jWqkKbt14Biq5QZmfYwr/aU6dL6avPreKrrKcONJd
 +5uZDipaN3kBzd0ALCx+9/m0Sk2uKFMu7LwqwgwPKm0eblddAGrLL27vJA4EFb1Tinf1CzCkz
 EeFVUD0p02TSOl1dLXt11sDR9lq3jAnIJB4ggfoXqbEppJAj/KBv17ZZITjQn81LEIyTltKW5
 E3/sgf8lmK6uPRBtiqMLtDZKzwS4r/6UZd/YqcRV2Si1pLy546O1STqkOH4js6IUqTxW29hA8
 Ig+M+gXSm+l4FwLdgsb+7eRuNLtmLtl9LRhJT4amY/H4EnHzLOnQ6S8OGVCkqSpbdVPCXB0PS
 vpxyFeFUNcvNL+McK0BcWQ42wwmcEbhw2q6Heg7eoW+YTipbxM2qk/vD6f+Fz/AqlDBCcGDWd
 5JEyISmCHFQnwqo5F1/3gj/DZgqhXiTHWReUlFbMjF8w6UnZOMtPBFi/JqBfYhkVS+TXuR3y4
 TSuSsZUJD9R0pwKBc5kIqR8PWbfaxnhD6OCPEnW3zCbBRBRfMLVYPA+2Zrjzn80PMRt/8lWdu
 S47yTfTG/1UsmaJArlFOSnZn2InPruNOdAsb9Fp3wKYLrIhQ79YkXQB9STdwtdIzndi7vUZUy
 4GpwHzb39vNgTIheeiwdIOdqIzDGKxgsBCdUc9aL5f6oXex5pi0AL6kaG5IAv09XH1nv82HXx
 4lJFD0ecvl7mtEFaHyCVmouA/STLiGT1t8tTWURSMXbyjsSxtrAnBVTrGPOex0Wp2TvGdWlA5
 Bx4600ubGjPvV2dZFJSxcnn20ouW32IDLwB+AkxbYeHyaP3f0UFjHGMvI0bbeOtQgg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.11.21 um 12:36 schrieb Philip Oakley:
> Visual Studio reports C4334 "was 64-bit shift intended" size mismatch
> warning because of size miss-match.
>
> Promote unity to the matching type to fit with the `&` operator.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>
> ---
> This is the same fix that Ren=C3=A9 Scharfe provided in 42c456ff81
> (mergesort: avoid left shift overflow, 2021-11-16)
>
> Use size_t to match n when building the bitmask for checking whether a
> rank is occupied, instead of the default signed int.

Fine with me -- it's just nicer to take the whole set.

Ren=C3=A9

> ---
>  mergesort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mergesort.c b/mergesort.c
> index 6216835566..bd9c6ef8ee 100644
> --- a/mergesort.c
> +++ b/mergesort.c
> @@ -63,7 +63,7 @@ void *llist_mergesort(void *list,
>  		void *next =3D get_next_fn(list);
>  		if (next)
>  			set_next_fn(list, NULL);
> -		for (i =3D 0; n & (1 << i); i++)
> +		for (i =3D 0; n & ((size_t)1 << i); i++)
>  			list =3D llist_merge(ranks[i], list, get_next_fn,
>  					   set_next_fn, compare_fn);
>  		n++;
>

