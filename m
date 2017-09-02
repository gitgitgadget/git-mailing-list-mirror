Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E45208CD
	for <e@80x24.org>; Sat,  2 Sep 2017 08:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbdIBIjW (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Sep 2017 04:39:22 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:35453 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdIBIjW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2017 04:39:22 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 02 Sep 2017 10:39:21 +0200
  id 000000000000009B.0000000059AA6E39.00005BC3
Date:   Sat, 2 Sep 2017 10:39:20 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     martin.agren@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
Message-ID: <20170902083920.simgdrdteorxt6yo@ruderich.org>
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com>
 <20170830185922.10107-2-git@jeffhostetler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20170830185922.10107-2-git@jeffhostetler.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 06:59:22PM +0000, Jeff Hostetler wrote:
> [snip]
> +/*
> + * Re-enable item couting when adding/removing items.
> + * If counting is currently disabled, it will force count them.

The code always recounts them. Either the comment or the
code should be adjusted.

> + * This might be used after leaving a threaded section.
> + */
> +static inline void hashmap_enable_item_counting(struct hashmap *map)
> +{
> +	void *item;
> +	unsigned int n = 0;
> +	struct hashmap_iter iter;
> +
> +	hashmap_iter_init(map, &iter);
> +	while ((item = hashmap_iter_next(&iter)))
> +		n++;
> +
> +	map->do_count_items = 1;
> +	map->private_size = n;
> +}

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
