Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798AB202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 00:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966233AbdIZAUX (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:20:23 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:47605 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966161AbdIZAUW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:20:22 -0400
Received: by mail-pg0-f52.google.com with SMTP id d8so4957529pgt.4
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AKzfqUAZZiMmhCZ7EsTCBWZDFaCqTg7CGxuI8ydfeLA=;
        b=VA/suRzdP5k7PW+fw07YznJFgaOmbm0ZFBmmfTHSCVPS7Y0MsrT1lJKjitRCDU9zhV
         VYkQokDjJ7hYBVLWI5LeRHYIC/H4A2TatfK3qZEx9m0qqdLTzJ+1excJ2sD9kjtwWGzI
         4l1jwGMpnLmrnq0/CvDiMAK03T2zkR1twT7UQnWMqWblAKmus16tJgClEy6d5rGoUIaY
         SGANGDMDegh69PKBAE4tLD7MJn/O9kRSkwg6kbKLqmVYD33+H6X+HD7MQzsmD6yTp0AD
         ToyfTxqoI7CldNRieGkqeU2qcKqR6OCZCvIiSzEmHiPeBd24tAWOgUe03u5GwmRe8GFc
         ABow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKzfqUAZZiMmhCZ7EsTCBWZDFaCqTg7CGxuI8ydfeLA=;
        b=AO0waxfUIqatLz6dhHY+3dJ7+0NtmgC1gCWC9sTdEUVPQegPDCsF3UlHm+yo22Mbud
         TvPuRBeE3Y1oo0ZUHBt9hIpMFoHFmcme6gFhQ/vzTeBTT65DHlVlqzz7QLzoKxo5JNzg
         HKKaEXQROFa91JY2nuiKNQafYFCdjQVfrIvY/BUx5l2NCpbI3Q+irzzIZiL5Z7uLNv8v
         C3F/PQvCz8X11EjDp6HTEJYw33FWfSJJo1CXoArtIiMAK7HUu/fTMUfpl6LU/O8/jEup
         oV9smRNCxHSV0GlIQw0XKQuTqEjlH4frtKN6DsWiC4gKm+cSMt0Fx5DeEdRVMqGEb5SN
         uouQ==
X-Gm-Message-State: AHPjjUhcm+zBaDDDIh3qrcwPtItG1hwne+P2sgXzfqdJJB7idhyQex5Q
        jtluoX90W3OwCDEqxenNiJh++9Ii
X-Google-Smtp-Source: AOwi7QAHs1G/PWWz2KQLZSA5BAfOYbzK74sVd8EWLI9HiqAcMv+2gjvg94Flf1N2qxz6TKmfz1GN0g==
X-Received: by 10.84.245.134 with SMTP id j6mr9115314pll.283.1506385222352;
        Mon, 25 Sep 2017 17:20:22 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id x28sm13405262pgc.91.2017.09.25.17.20.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 17:20:21 -0700 (PDT)
Date:   Mon, 25 Sep 2017 17:20:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926002020.GQ27425@aiede.mtv.corp.google.com>
References: <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <20170926001354.GN27425@aiede.mtv.corp.google.com>
 <20170926001724.cxuwsdadjbqqmnig@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926001724.cxuwsdadjbqqmnig@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I definitely would prefer to avoid EIO, or anything that an actual
> read() might return.
>
> What do you think of ENODATA? The glibc text for it is pretty
> appropriate. If it's not available everywhere, we'd have to fallback to
> something else (EIO? 0?). I don't know how esoteric it is. The likely
> candidate to be lacking it is Windows.

ENODATA with a fallback to ESPIPE sounds fine to me.

read() would never produce ESPIPE because it doesn't seek.

So that would be:

/* errno value to use for early EOF */
#ifndef ENODATA
#define ENODATA ESPIPE
#endif

Thanks,
Jonathan
