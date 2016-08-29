Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868561F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756876AbcH2JZj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:25:39 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37746 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756891AbcH2JZh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 05:25:37 -0400
Received: by mail-wm0-f53.google.com with SMTP id i5so81695431wmg.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjen14l0Yz6lv7zOgfeqMbTG5nidlcYIGCzZZngEcIk=;
        b=M8mF/iyuo5d8orSIi74kZdirwYeW/ITxPV3hlVU2LqlkQjLB/ew4wl6q1UofklAYDe
         ZX07YmaFPlV6ikoYX8jNGCKRViCfpv9Cz4OPPlEQZIr/MDfghRUyl9075RCiVARxN8dU
         h7hqIvSg12bisDV/r9QdjxDzfPUYcdm3ZTScSvXLsPq4qdtxS9EVFDUIPT0SUKk3Tviq
         GahfpMK/qUUO7WwkRGBt9YG5DLEDiqNJrPti2QAnVz83OGwFDnRyJc1fAQf8lpqCAkOm
         w4ay+/TJBdwNnPOct6LY3PWRzZ8+bORqgFEHes1tJGksjR9nf6hUgv8S5Mn7qlbwzYMf
         JDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjen14l0Yz6lv7zOgfeqMbTG5nidlcYIGCzZZngEcIk=;
        b=IjooyeK2fev/C6cIr+qDM7LHdGjdvFzEtASra0t02+x2rC2WSFgh/5+5/NLZKs7LNh
         nbhQFDrLi8JcEc6zFbsRTOKcqkW3ArwAUmUJoclDvxyGXDSEZaYj3YXH3shCY8CZYngH
         cZnxrOTbjH0th7hv0FVQ4rGugIFxaTBzLW+YCT9TBp+qebDt5gr0hmnJ61njjX9hcIzm
         ZLwK43hbtnY544fqGVTZ8GEqpkUis7Dgz33rZbAplumyxQVS79zUJtfdW/sARwhMb1Y/
         rdS7uLXt0dl6L22uBiPNATgJ4IqIhEokb82oTpFwB3yapH/2iOYtwOQYC+HtUxMUTpdM
         q9ww==
X-Gm-Message-State: AE9vXwMcJE4uakyguwu4FAc1Vet09DHCqdgkIpvOSX9yNWwDIUKVkcFa9vuBqrFekV6XlQ==
X-Received: by 10.28.154.208 with SMTP id c199mr9871046wme.102.1472462697576;
        Mon, 29 Aug 2016 02:24:57 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id n7sm33432622wjf.11.2016.08.29.02.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 02:24:57 -0700 (PDT)
Message-ID: <1472462696.4265.23.camel@kaarsemaker.net>
Subject: Re: [PATCH 04/22] sequencer: future-proof remove_sequencer_state()
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Mon, 29 Aug 2016 11:24:56 +0200
In-Reply-To: <2245e7db4d4c028f63b2f4c41097559f91756f2c.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
         <2245e7db4d4c028f63b2f4c41097559f91756f2c.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ma, 2016-08-29 at 10:04 +0200, Johannes Schindelin wrote:

> +       if (read_and_refresh_cache(opts))
> +               return -1;
> +

This doesn't seem to be related to the get_dir changes?

D.
