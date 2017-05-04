Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14937207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbdEDJ2K (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:28:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:62952 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932668AbdEDJ1t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:27:49 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LswqM-1e2ovZ247u-012cUQ; Thu, 04
 May 2017 11:26:59 +0200
Date:   Thu, 4 May 2017 11:26:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] archive-tar: fix a sparse 'constant too large' warning
In-Reply-To: <252ddd6a-3516-6619-8ea6-d3897f13d93d@ramsayjones.plus.com>
Message-ID: <alpine.DEB.2.21.1.1705041121520.4905@virtualbox>
References: <252ddd6a-3516-6619-8ea6-d3897f13d93d@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j6oysdTnC6FY2UsZZN0iuqDpDI3Yvtdp8Q0pCeRdMcJcjB+3mHS
 sctz//1KwB7Ok2TOonMmqeCBI41UlThUd/7LAXUshfNvp5sh1uB/yS73IgmpZfVIjvMlZ6+
 tnBIDsSCmfLlCCz0cR1IGi+l5U4oa/r3h34eXNhXBECxFLelKVO2XoE6kdHdQ8VsxOUL/Ru
 du3SUES9Mh2yY9wTOKxhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ysnzZEhHkGY=:RW97mu/F5qtX5avJtj32DR
 58XHq26K2hJhVoioSSFtVoPk5oS0/0JPaKFR0CuITvlnxEcuD3phPyvcOsFtVBB9Pkv4xPe/k
 xpGAj16tvWDiVHZg5JJl0hpY2F45pQOLyH7CJGuwOF2icu4Wj3JqS+svf/43BjL6eKD35V/m5
 421J8Bdsg/ayn2ex25jYFp4z26OmxXpMORUtmBccg8F15ytew2baHUX6EjJGtu8kjlGwjECoN
 C9yY51Yy642l1a42e6gNSKRaPxhoAePQV1WCpd6HuaI6bW06sW7Pqw2UTpN6UWp+Kmtu4YW21
 0M3h9oOs/Anl0ig+Z6OHi+X64CRN669EHvWsKM5cJJkCPlFqu4oRb2gNiofOCKzc4/XE7tkrO
 fKy1sVCAXomwX1cLHucoBxtqh5g2VK1M59lRwv2CS5fS49t0EutEDdI6oAG3C1BzCC3SLeUup
 xU+4ZzsEwFqsMsLrZufJbvpgP0Q43H+fTbYfOIDngzgZy9vR7lFprwoWlTRo0mShQ/sIXgb75
 2wYYWVuvzl3qEWPx0aY1fl/dwvct0FSy4dKlayh/iFxIZOvQmEoFnkb2NwcETuhPT8emfeLIW
 Lu4dhzWi4jLrPj2rYxuO1lq7TYwGiJdeZyYXtfjjWIuOyA4jUnc7bBjkH2eri/b3ZnxTN8pzc
 gm1/kP0CPyoZL/0N0tKPEPX4ZMXK/T8Lk/cY2dx6v+76VpikQ1VV6Q0omRXXAArkeO1fJZ99O
 oZygQhmY55eiOZ1r3HtuZ1x/kESw+wmLOPP0iwR5Pw7FcNv5wV+8spvuTkm4g+xUuGunpOkpT
 EArxcU0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Thu, 4 May 2017, Ramsay Jones wrote:

> diff --git a/archive-tar.c b/archive-tar.c
> index 319a5b1c7..6dddc0cff 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -33,7 +33,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
>  #if TIME_MAX == 0xFFFFFFFF
>  #define USTAR_MAX_MTIME TIME_MAX
>  #else
> -#define USTAR_MAX_MTIME 077777777777UL
> +#define USTAR_MAX_MTIME 077777777777ULL
>  #endif
>  

Funny. This problem was pointed out by Hannes Sixt (IIRC) and I fixed this
very thing in v6.

Except I did not. I changed the wrong constant! Instead of
USTAR_MAX_MTIME, I adjusted USTAR_MAX_SIZE. D'oh.

I just saw that my patch series already hit `next`, so I fear you are
right that we need a follow-up patch. Maybe we want this diff, though?

-- snipsnap --
diff --git a/archive-tar.c b/archive-tar.c
index 319a5b1c7cd..073e60ebd3c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -28,12 +28,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
 #if ULONG_MAX == 0xFFFFFFFF
 #define USTAR_MAX_SIZE ULONG_MAX
 #else
-#define USTAR_MAX_SIZE 077777777777ULL
+#define USTAR_MAX_SIZE 077777777777UL
 #endif
 #if TIME_MAX == 0xFFFFFFFF
 #define USTAR_MAX_MTIME TIME_MAX
 #else
-#define USTAR_MAX_MTIME 077777777777UL
+#define USTAR_MAX_MTIME 077777777777ULL
 #endif
 
 /* writes out the whole block, but only if it is full */
