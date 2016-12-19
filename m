Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1400A1FF76
	for <e@80x24.org>; Mon, 19 Dec 2016 11:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762681AbcLSLsO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 06:48:14 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36246 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758143AbcLSLsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 06:48:13 -0500
Received: by mail-pg0-f65.google.com with SMTP id w68so2263223pgw.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 03:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dugFg5l3/5Pvf6+s5kzqfzxNyswP+5PUNSwf4Svoqno=;
        b=WD5BWWah9OXgqp1KXHd7kQcCT9WePpM2oUbJuW7tCvU7DTONKeZubt6dMjdXaiLXme
         eF7Q9qZmgn6Gkv4TxJUSR5qzCHvueZ8UphoYbnso5pT6O20qpO7dMvOQhy5Adss6+Xw4
         eZcJpPd61l+87YxoOwlvm28bz4hQ1W5uP+N/Lqu4jAjtb8ObngkJC/8JI+jIk18XTDOZ
         WRWG71Scany+4Ii2OST0JxlUszSScFBWxK5THoANnMN8fSoc3iwxfIwV3JkmEmcK1K8+
         IDVLw+1kuHIUgCmUUIVVMegaEmB3u3KWBotDiHDiUBaggvyEBgIlH9hxlgqihDUsMOiF
         AZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dugFg5l3/5Pvf6+s5kzqfzxNyswP+5PUNSwf4Svoqno=;
        b=MkYHyAJuBMGHO/WaZPStM+k0eeruvNzPnOLSgrU9fQwlg9HQdFhUL5v4qeEjcr/koE
         AB+FU279gPd6jOIv2tERQ0nvjYvZrp8xxcyWYAqM4NVeZjTtL8SwJY75UFSlTYD8bNdC
         a4aTiIPLqtK/qU8YAl004Jti8CiflJ9eSpCW8attUWcnSro1UZPYA+dChzOfrlTKCC4c
         Yul1UuQNcHiL/BY1E+0lMt3dH2ay8L1KVupvyqa1F5jugejtC6QoSWIYPbtvgH/VnAp4
         i3Oa3j6j7LKxZLBM6Ir1UxS5VGnOddAi3C60a2rTw0D/dlPqU6ZOkPE7kfFhBOs0R6pe
         O44Q==
X-Gm-Message-State: AKaTC03mXwUGI+FVSaqmlQOhuo8DZLTlnhkhixTEDU9MJbaWO+Di23lVqG7iC4GKslsxIw==
X-Received: by 10.99.152.10 with SMTP id q10mr24004064pgd.106.1482148092506;
        Mon, 19 Dec 2016 03:48:12 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id y134sm30929787pfg.81.2016.12.19.03.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 03:48:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 19 Dec 2016 18:48:07 +0700
Date:   Mon, 19 Dec 2016 18:48:07 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 10/21] read-cache: regenerate shared index if necessary
Message-ID: <20161219114807.GC24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
 <20161217145547.11748-11-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161217145547.11748-11-chriscool@tuxfamily.org>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2016 at 03:55:36PM +0100, Christian Couder wrote:
> +static const int default_max_percent_split_change = 20;
> +
> +static int too_many_not_shared_entries(struct index_state *istate)
> +{
> +	int i, not_shared = 0;
> +	int max_split = git_config_get_max_percent_split_change();
> +
> +	switch (max_split) {
> +	case -1:
> +		/* not or badly configured: use the default value */
> +		max_split = default_max_percent_split_change;
> +		break;
> +	case 0:
> +		return 1; /* 0% means always write a new shared index */
> +	case 100:
> +		return 0; /* 100% means never write a new shared index */

I wonder if we really need to special case these here. If I read it
correctly, the expression at the end of this function will return 1
when max_split is 0, and 0 when max_split is 100 (not counting the
case when cache_nr is zero).

Perhaps it's good for documentation purpose. Though I find it hard to
see a use case for max_split == 0. Always creating a new shared index
sounds crazy.

> +	default:
> +		; /* do nothing: just use the configured value */
> +	}
> +
> +	/* Count not shared entries */
> +	for (i = 0; i < istate->cache_nr; i++) {
> +		struct cache_entry *ce = istate->cache[i];
> +		if (!ce->index)
> +			not_shared++;
> +	}
> +
> +	return istate->cache_nr * max_split < not_shared * 100;
> +}
