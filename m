Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38941F404
	for <e@80x24.org>; Tue, 16 Jan 2018 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeAPSYf (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 13:24:35 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:41974 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeAPSYf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 13:24:35 -0500
Received: by mail-pf0-f177.google.com with SMTP id j3so10134244pfh.8
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t29nstYEEkH1XllOBJ4cm4Hxn/kog2VuISv1nUfT2DQ=;
        b=GNxl2kP/4Y/Zfc/B6XmvaD/yoz0bNwFKfoDKsh/SIAWWN9rjjxr1Ho+vu2BhBmGonz
         EWGq+7y96t1XleCRV/vK6V5fpU5mu7b17QHTBDbzD5CSLcPHDC33a7pHmumouuf40dQC
         T7gpyke9hPn5CwmSm7K7Yf1fskRZZuzXUHhJVd0zz8tOTVpkKhuSLaCT1WbIfzalAQSC
         N2kswYU53Rwy9zae5KOvq531oOmrf2q5dZ0Sc+CZ3IWqG2RU1yzDF9uDyhWPpNGR7Pzw
         BApN23S5aYPFkVU8tfxuSJKveixp4qNW3nW/hsemvUxGsp5ZqS4aOELCrEiHuu6Nzh1R
         VQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t29nstYEEkH1XllOBJ4cm4Hxn/kog2VuISv1nUfT2DQ=;
        b=sk+/EtnEQhwwUkKiW5FSUrXQExRxcpUvXr4Hzgr2UKm0zTueviHutyqdZL9CXWtIAu
         7T16nSKVjwrPtns3lvQZBI3s8qRHKC0lt3xzo2O5TlaNFodPyXBUZW0tr3OZf32EgGAI
         oJ57CfefnyOF/bLkpUAQ3/SV/NVQYKL9S8kkTw5N6+DFkJc/r2cP4O9btAmfEI2FayMd
         TTC3yAcD5WnzHQEsaV09gi6q635bpkj/1LyyB0k23vsdMWXcFaI/8GmC1wBNAsKYi11q
         9ejo5/2pEChNxQvWmoxaPkidU6OzOqSWaDG3CCxe81YDM82Tge2zHskYWy3W4jESUsKy
         bsmQ==
X-Gm-Message-State: AKwxytdkY42NNUJCt8BYCd5kjddY//WT0ZppeyL9uN43lYBk+HpAnr3P
        BOGHR5Q9nO68d53MmMToKVHoOg==
X-Google-Smtp-Source: ACJfBotgTYZW21n4bZe+KDBPpxb8TEXkOSyqhJ9LlDWAyTcO+ER36rURQNuai7yRPbr1eTVsTSge7g==
X-Received: by 10.98.224.205 with SMTP id d74mr23750875pfm.56.1516127074337;
        Tue, 16 Jan 2018 10:24:34 -0800 (PST)
Received: from google.com ([2620:0:100e:422:f523:b526:bbca:bb86])
        by smtp.gmail.com with ESMTPSA id c29sm5151060pfd.172.2018.01.16.10.24.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 Jan 2018 10:24:33 -0800 (PST)
Date:   Tue, 16 Jan 2018 10:24:32 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 3/7] trace.c: move strbuf_release() out of
 print_trace_line()
Message-ID: <20180116182432.GA135179@google.com>
References: <20180113064949.6043-1-pclouds@gmail.com>
 <20180115105949.18328-1-pclouds@gmail.com>
 <20180115105949.18328-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180115105949.18328-4-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/15, Nguyễn Thái Ngọc Duy wrote:
> The function is about printing a trace line, not releasing the buffer it
> receives too. Move strbuf_release() back outside. This makes it easier
> to see how strbuf is managed.

This makes the code much more readable.

-- 
Brandon Williams
