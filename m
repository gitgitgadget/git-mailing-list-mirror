Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC8EC33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 10:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10A9206D3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 10:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HR+48b7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgBAKED (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 05:04:03 -0500
Received: from mout.web.de ([217.72.192.78]:42921 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgBAKEC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 05:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580551420;
        bh=4+eOcY5FsrcGQAzmegarf3+GZ2GZ6Q2xrjqmxdzSdUQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HR+48b7wN2hMiwhLcwZiGQJxiW4LJbTFBF7BXzddBUZGD9hJV1RtnSgBW9h2HUMlv
         32ZBG3PJ4hsujLAhiikpFp2RzO9ROpqnMaXhCqcLeS4+mmP+we1UH6G8F2n/9K+pdE
         p/hiBXTFKSYelP0udNm3dQ4n3SdcGPxmwVReVMv4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxfGh-1je1AW3U2V-017DJM; Sat, 01
 Feb 2020 11:03:39 +0100
Date:   Sat, 1 Feb 2020 11:03:37 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/7] sha1-file: pass git_hash_algo to
 write_object_file_prepare()
Message-ID: <20200201100337.u4ikzmrprca4ltvb@tb-raspi4>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
 <f256d2058736091c3d9662788762849e8df794b0.1580413221.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f256d2058736091c3d9662788762849e8df794b0.1580413221.git.matheus.bernardino@usp.br>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:NzqkHKS+vZuUm0C0xt50HzZHTbkGozNncBy+2htLPUD4LMoNwvz
 qrrtV9b8bry0Bp7G8TNy0Qcgkvx/Wyy94rMkyVDfokFJDONi5uS9eR9YRyGMAXFSSxd/qCO
 63324NdT9XqLPQjo/Mjr61BLhcRXeOYxnZ5VNjGxI9Pg0PxANroSBdBBkC8iEUw4S55MSfi
 YwJ5UT/yBpjrXYsv2+V9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FD1IDBlkJ6w=:tSaXl+D3rqicwSSRl6Osw3
 mgsMqFZh/Jnyv9qJytMiZ43ybFP1/ayhNCGe3nLd6NFDmI7AXBtcjMLKEOu1WloAlNv5deoRV
 DLHck7WdaeqUfb8zDr3YSLoHP4x5jaDBADIN+MNoXethaNceQq1+yf4TcdjAZT/NnIPEBMTtk
 Ior5JVzYeI4MWgd1Y4/Zf33a+vke3Bgcy11g6AVpQtw1+IQiR2a15bT8fmvRLIdJiiZgQL3bU
 1lEFI0jAMO3C25YC7v2M8xTY3PUH8uzqciveZClsHgfIij/00AUTNCjMX/hagL9ZCwjneQerJ
 RuV7kacs+BLdLIaif62HJ4gjlouxmGVifAQo6SOM4hbfZrjYW0YvQrs4GF2H2mly2Rl9OVjEi
 UJu8zESTAiKNlJsncQWrLcmC1q5tb4B03CQZcmFleD+hSPs8oehR6acQ+rf+9D0+E0mVDcJwZ
 QTK1WkZW0eRDA0Px1hUWVuRo+W6Hkt07/kg4+zlR/p/KDcWggS4rW8A1AGpR0VENSTHhHtJc6
 8B3NxZYs9YGUtzVophefmjLoPXhfnU7ve6fJmZMCUv2Z3ZrJ/XMRab0l39l1KIZCU5o8+SAMl
 z/fCnrblUKo1oPkQyPIG2sFU5KWMxCR+wjdN9d4UN8xKMrjLvybAPa+cqpdBh0d2J16IU6teo
 MflqO5kOv9mK8rQI9A3R3wngrfZvjhTr10PDWKEpgFOzpFXtgmktOBZDxmngpSzKnHrCMMCL2
 6WuhvB+rKT5R52R7nxcFVzvMUijxx9Z7m3cRmUKxwmz4kNPjmk6MgBpU//hxB4a/50iab56KH
 DYek+xmc5Y+ybVJ4mdOqSE+rZBN0TCxy1wO1RtRUQD5pc+Yf2BQ/qguJ9l4/cB3YFWvvvAxWh
 Fz36Hv4dnTqgJ+v2MLFb7M1+eDe232ffXBmfy9i8wkAuSHs09xF4E+k3iJTJhsGcKSiGu39Un
 wkz6mlo6McLY7ChGDDtGg4SottfBIrf7IlXMtCkriTPsaJ5+YZf0zKKG7cueS3vwFYNRC+bjk
 ygRHD4jYu/oehh4TbqzjqZoMvTGZeA6vpHTak5Bc1gOhf7XyCX9dGkPh27avyAqglvDQMNB6j
 DPKhDs7/bXRe6mgRT+SDo5jqsC6h0uk3Lboyj5GguYFPp4Kg6g5m2ZQERd6ewy4r3wy+968RT
 hfUD3G53jKxIAAT/Zl03Jnc1ryFYIZWF+9YTL03O4fFpXPevSqI7XZiio9D9vE5wShSlk5lt+
 kSGV+Hb/+hE/Ts4Us
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 05:32:21PM -0300, Matheus Tavares wrote:
> Allow write_object_file_prepare() to receive arbitrary 'struct
> git_hash_algo's instead of always using the_hash_algo. The added
> parameter will be used in the next commit to make hash_object_file() be
> able to work with arbitrary git_hash_algo's, as well.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  sha1-file.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/sha1-file.c b/sha1-file.c
> index 13b90b1cb1..e789bfd153 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -1647,7 +1647,8 @@ void *read_object_with_reference(struct repository=
 *r,
>  	}
>  }
>
> -static void write_object_file_prepare(const void *buf, unsigned long le=
n,
> +static void write_object_file_prepare(const struct git_hash_algo *algo,
> +				      const void *buf, unsigned long len,
>  				      const char *type, struct object_id *oid,
>  				      char *hdr, int *hdrlen)
>  {

One minor minor suggestion/nit, may be my own type of style only.

When adding a parameter to a function, we typically add it at the end of
the parameter list, rather than at the beginning.
The other (unwritten) convention, when dealing with "buffer pointer/len",
seams to be that buffer-ptr is the first paramter and len is is the second=
.

However, this is my personal note, other opinions and comments are welcome=
.
What do others think ?


