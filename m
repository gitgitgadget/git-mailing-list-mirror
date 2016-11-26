Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F781FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 12:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbcKZMxX (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 07:53:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:49164 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbcKZMxW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 07:53:22 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6BKc-1cvKF2408A-00y9fJ; Sat, 26
 Nov 2016 13:53:11 +0100
Date:   Sat, 26 Nov 2016 13:53:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Klein <markus.klein@reelworx.at>
Subject: Re: [PATCH v2 2/2] Avoid a segmentation fault with renaming merges
In-Reply-To: <d1571a25e8f3860a2867b00994d4d6938aa602ec.1480164459.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1611261348420.117539@virtualbox>
References: <cover.1480091758.git.johannes.schindelin@gmx.de> <cover.1480164459.git.johannes.schindelin@gmx.de> <d1571a25e8f3860a2867b00994d4d6938aa602ec.1480164459.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:htIR6B3+irNxSevcloZdxtA3QxK68sv2Y2+qGstWIOs1Q/dX2p7
 B/uYyeTfPWUJPLXdUtmymIzI1IHOgcIKyt+5YeKN9BG6BBn7/8PafIbXoI2P9c/+z4b3Wm0
 UvGIIu2HFfYVH5suvJyxbBWzb+rrpxuLmHqfX7bfPvDMJl/MPPLokUMSdR+VHYtxJpEh3kw
 cAwgB+Kbx78RaVdNITuvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XX1n5GkHB7o=:U2rL7/J5ztj15fKsC/fcxt
 WzHs1aFol64B4VQZsGkdbPPxihZx4lrPs9kV/8qJL0d0LoyHvBBAsSZxWgfi9/I/97dsQg+Di
 jI9FzRXXP+eInNNf9cnbEE12oynN1ARIJZXlxLrsOY8ysj5faHooU5vPnTPTc1USrmVa5a/xY
 yBDONb3jXJAJF0mxY7oX4hpaIl948nGTBEmJHRMCArr+PwCNssDAIkVydT4Q+lMmkQ7QxGlpc
 xEJxXH05W/FDX3n3IsHLauBatuTn/ELZ3ggbIuF3kEFlY05n7hUUEWljVMTQmbMYpZRXREf1d
 3O5MUikWzSbEgLVIFQA6p6nK5v1FZ0jMuaht3Q2bQgGebth3/u3zpno+VaRZsPGKaPuHA6JIN
 kh2D1fg+GdD4Awc1Y8MGtUfn518BOHEtY3x4s7qIiT6FKydC/GyJfDWj7Vv0MT6ySTQUuiS6D
 5Diu1kFZxlLmWIl9w5dn7Zk47XCC5eOXtPAEcI7uCKaueQOltDIj6DVvyt1SNWLQvzOOi05WC
 Cn2Q/vn0kmS4r9rutpUXg7v3X/stuoV3s99w/vIH9RTfyDUM4oDe1y9cbIuGR8LZ5lumyav6w
 aS2++WGqHSi6OZcAVdRU+4hAlsXxc4axScLwR7IaURWxG+hSfwNAYILLKwKBHGx2f0M/GPugt
 ieJnaMuwpYkvqgamlHliV/fZ3K61OyFpEm0uMVCcIhVlP01uLmrU1hLsb0ta6YmvY23bYtN+3
 ZZ19X0ccA1qmCy3pm1Rg9pIKSuxbzyfcY72TUw7if5ehHDKU9bOrfTYDr1jaPDtjdreLWIXgG
 nJRmTZw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 26 Nov 2016, Johannes Schindelin wrote:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 9041c2f149..609061f58a 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -235,6 +235,8 @@ static int add_cacheinfo(struct merge_options *o,
>  		struct cache_entry *nce;
>  
>  		nce = refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
> +		if (!nce)
> +			return err(o, _("addinfo: '%s' is not up-to-date"), path);
>  		if (nce != ce)
>  			ret = add_cache_entry(nce, options);
>  	}

BTW I was not quite sure why we need to refresh the cache entry here, and
1335d76e45 (merge: avoid "safer crlf" during recording of merge results,
2016-07-08) has a commit message for which I need some time to wrap my
head around.

Also, an error here may be overkill. Maybe we should simply change the "if
(nce != ce)" to an "if (nce && nce != ce)" here, as a locally-modified
file will give a nicer message later, anyway.

Dunno,
Dscho

