Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E37DC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKHTyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKHTyV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:54:21 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315FC11C21
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:54:21 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x7so4517092ilg.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 11:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c63EWUO8XTLJU9drvkM0ooUohtBaiHR0wL0lDeod31o=;
        b=qdXBVYkyR70e4e8vHJF0r9jbfgsfoCdk7aNn6JyD1M6A0isZLgaO7lqkSLuPvo+r2e
         E8BgYpeTyGjUGeUUzB6mECAcAEQajV+jdJwkwJ+fFSKoD6Whu7mOLfefVNs8BlYE+5NL
         hYxBN1zHbfNM1nGjPpo12u3mUjnWIa2y3Snu05f98q2UUBIDVnWBE0/tOt/JWqezrdjO
         rV4v5MEtHYcrhvEXMY23oG/FKnFFlcJDAp1PJCg7d9X0AfA9u826WO42lcyjWhpkAAyD
         pExyelpLHPLFfobjEuSdkrOAeNu4DVerDdJwJoRk9aUtZ85msP6yRTG6MOdGsOzyfvpz
         BRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c63EWUO8XTLJU9drvkM0ooUohtBaiHR0wL0lDeod31o=;
        b=Clz6nTPuZ5fcLgUzByYGlxUDhMZ2Y6Ndq2SNdtbgiFWTySGkA3I9/PCQEdGyEWmI5V
         fP2YtVHDrEvklltiiIai6sDQOdbB7rg0TWwepVyHvqnzGrRmxUZTKz68PJqh08zHrRYG
         nh4nPW1SbzN9DN7ogefXLT47a4Ues7sU4afpsVcCU5w9PrrDR8bSyf28uiopjoa9tX01
         nKKwcxdj/UgX2pIKGyWd3i81BablNENWbJrVDfF1t9GtBFn99DpkitTOSs8YQQPuigBT
         vHDaIe8C6QPg+kQUVxqVwMCf67mPcKbzgPA0P20FMHNi5wIJQJjYUbnRBvd+ndlaRsHj
         /9tg==
X-Gm-Message-State: ACrzQf1UTSNXxGzW/WuCGlDnoB8D4dKsEypTqLTmDxsS/NYJxj8fexNv
        D0a9V+QP8TOn4DFwGm8zi5jx9Q==
X-Google-Smtp-Source: AMsMyM7WoAzgFun455LqOJlqFf+syHIOw0zkvYvZ5u9u2BN3Ph6DGRmevBPTSNcV4b+ZuRjZqCaAYg==
X-Received: by 2002:a92:d84d:0:b0:300:74ff:d77e with SMTP id h13-20020a92d84d000000b0030074ffd77emr1002880ilq.143.1667937260607;
        Tue, 08 Nov 2022 11:54:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i15-20020a056e020d8f00b002fab1376ba0sm4123102ilj.85.2022.11.08.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:54:20 -0800 (PST)
Date:   Tue, 8 Nov 2022 14:54:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org, me@ttaylor.com, derrickstolee@github.com
Subject: Re: [PATCH v2 0/2] git-maintenance quality-of-life improvements
Message-ID: <Y2qz6yxvJeiEQyb7@nand.local>
References: <20221108194930.25805-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221108194930.25805-1-ronan@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ronan,

On Tue, Nov 08, 2022 at 12:49:28PM -0700, Ronan Pigott wrote:
> Ronan Pigott (2):
>   for-each-repo: interpolate repo path arguments
>   maintenance: add option to register in a specific config

Thanks, this round looks good to me. Will queue.

Thanks,
Taylor
