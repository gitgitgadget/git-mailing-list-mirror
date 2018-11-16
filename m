Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A8F1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 20:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbeKQGl7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 01:41:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40341 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQGl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 01:41:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id x2-v6so11907139pfm.7
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 12:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xvn+QtbMTHQ6H7614B3QW267qCj4jG3Ka0dEAkG04Rc=;
        b=EGEDVo/7/jp5jAARSm+4RI0qe2Abyw6Pq4WdQQVdWsppJjviM9ScAGi8IaujyubGIT
         9ONVhgGYV5AA8V7F/uL+oiOmNEOdAztTe2iB9xHLPkOQN6PeIe6srygwwZzAuukGZSiD
         k8amNXD2rTMVfD1m/d33/Tux5TfkRJ100Lc7Xq35wknnr0h0k+8qJ8NxcDKRWTu4Sn4R
         V1Bu/BMqF/Jr9lo437Qp7ept8JrJ2nSMvmns6+UWlyQLz76IJqlov9gr1HretWnN3SoU
         e3/31uvlEekXpF5v6xeIQRiNcIFEpre21KiWTSqI+sOPaRDsWvfY6Q7GyncGjSLdLvWf
         2aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xvn+QtbMTHQ6H7614B3QW267qCj4jG3Ka0dEAkG04Rc=;
        b=lHNsca+K3euxxCZIcLkaXEDkVi6jxV2Pdq3Yu/KRt0aRzHs9FR86jc7aLd+jS2jWKB
         DOgTswIJH7QJiAp8UKzA1o5l3q3BARiUF4gRslN9+WRPn05WIArO9ap1x634r/i2Dc9e
         OQPxvtJpWoKPtbWg7a7DP8LP/BBrDAysW6hUiA0py6g1lObSjRZR0U/AHimCN09zXqS1
         0Dw1LaPqrH322G4Bl4tLceDmOwq2yDUK9HpgEuIoLgndAOn/8DeqwRZY44YJpZ27PbXp
         EvF4/zitJamoeCnBDcJBPaXvCnnvUOmNfo2KqenCLghgOUF0P6YAsW5VTTFsAuS6ffJi
         9Ang==
X-Gm-Message-State: AGRZ1gL7zv0ZFZ7rHu4QXKI0UFcqTjYAIxUKZgp8ADTMBubdA0SADHrB
        v6CWnfFav4P6PFLz0rVLeOhgXc78/NWFEQ==
X-Google-Smtp-Source: AJdET5e66jMBHhTLXsX7b8vYBr3u9nTpRMvkQHpBf7SEHpeklkDVOxyAUcoQI/EX0BpxdMORjOTizg==
X-Received: by 2002:a62:7e13:: with SMTP id z19mr1630236pfc.94.1542400085612;
        Fri, 16 Nov 2018 12:28:05 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id e126-v6sm23182904pfe.67.2018.11.16.12.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 12:28:04 -0800 (PST)
Date:   Fri, 16 Nov 2018 12:28:00 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] remote-curl: tighten "version 2" check for smart-http
Message-ID: <20181116202800.GD9703@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20181116084427.GA31493@sigill.intra.peff.net>
 <20181116084838.GB31603@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116084838.GB31603@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.16 03:48, Jeff King wrote:
> In a v2 smart-http conversation, the server should reply to our initial
> request with a pkt-line saying "version 2" (this is the start of the
> "capabilities advertisement"). We check for the string using
> starts_with(), but that's overly permissive (it would match "version
> 20", for example).
> 
> Let's tighten this check to use strcmp(). Note that we don't need to
> worry about a trailing newline here, because the ptk-line code will have
> chomped it for us already.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote-curl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/remote-curl.c b/remote-curl.c
> index dd9bc41aa1..3c9c4a07c3 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -375,7 +375,7 @@ static void check_smart_http(struct discovery *d, const char *service,
>  		d->len = src_len;
>  		d->proto_git = 1;
>  
> -	} else if (starts_with(line, "version 2")) {
> +	} else if (!strcmp(line, "version 2")) {
>  		/*
>  		 * v2 smart http; do not consume version packet, which will
>  		 * be handled elsewhere.
> -- 
> 2.19.1.1636.gc7a073d580
> 

Looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
