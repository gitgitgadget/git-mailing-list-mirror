Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8099F1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 12:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHSMeh (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 08:34:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45228 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfHSMeh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 08:34:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so8527095wrj.12
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1Obr9ggSE+3RHy0a6UQKCNCHKLoHnoLjWNbQ0cklm+Y=;
        b=P/ABsnZpVwvz+riHTkyqudi2fcIahoBDH6Ue5gmKkoUpfW02Ys5uFrysn2z7ARHUdd
         x95sk9sTPFr/bz/88+o7eHOv5DH/cfzH0DFFJ7yK/jgmulT9l8Kdxq/vTwBvYhOIMG17
         a0VpcAAb3Jxe9mKuUt6QcxgKghTYFLsogbdxCLFuwTmt0kvaFP9habiQYTAIDvDJs3q4
         agPkWkbalYdH5alUIyyMra/yOYlHb55adiW6GQHeFe3IEfOXjm/1+WS6wQ08VmcQTmxO
         JMtmpki+aa1UE8TRflfvf4ogW7k4bZp0GtwgF7AxkjAuw+aM7JxnURdzNUIm+cMRpYxm
         uqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1Obr9ggSE+3RHy0a6UQKCNCHKLoHnoLjWNbQ0cklm+Y=;
        b=At9HOxEGmwa/FYFcZ34CVFjgrLXrSXPJVZRfVbjsOrd9u8bO2YZm3CfI6R1PqTbC05
         lLhOkmly2FJyWHqfqDWKqaGnHREDeBRO74bLo8jkAmC2SxOXS8HVuQhk89iVBekKkWnH
         x0LnJXJFGMOGn0mbxC1qOvpuwR2izPPNGhRrbQc4rW6K2/3aRssLVvEZukyXxMrCVz9Q
         tJ4yUPfgvN3i7tbDdmGRUHfAmQjx7UHY/DAjE8gU5J7ELworoh3ZaJwQiciH1jV7nUba
         bURI/09pBbQjn/u2Opi0KEmBBKGtRDw0W9YMaZUkzhvFEC0JOCFDBW8x+QQZh3t7FVlK
         SCfQ==
X-Gm-Message-State: APjAAAViz3Gzd5mIQUGW2iEshUWpeM74II85gRboN4K8qvBeuZtVNkzw
        qb33QiuH/Jm1dL91q1/BtTakAoEB
X-Google-Smtp-Source: APXvYqzcPJRDEpiIMO3IPTOEppNDtPzRBQ4wdFl0vYVm2YC29mDG63ftxpfFXx6H8Z7ox8OdMAOfcg==
X-Received: by 2002:adf:bd84:: with SMTP id l4mr27403138wrh.143.1566218074798;
        Mon, 19 Aug 2019 05:34:34 -0700 (PDT)
Received: from szeder.dev (x4db60b9a.dyn.telefonica.de. [77.182.11.154])
        by smtp.gmail.com with ESMTPSA id o25sm4795851wmc.36.2019.08.19.05.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 05:34:33 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:34:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 4/5] line-log: more responsive, incremental 'git log
 -L'
Message-ID: <20190819123431.GT20404@szeder.dev>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
 <20190818182801.7580-5-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818182801.7580-5-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 18, 2019 at 08:28:00PM +0200, SZEDER Gábor wrote:
> The current line-level log implementation performs a preprocessing
> step in prepare_revision_walk(), during which the line_log_filter()
> function filters and rewrites history to keep only commits modifying
> the given line range.  This preprocessing affects both responsiveness
> and correctness:
> 
>   - Git doesn't produce any output during this preprocessing step.
>     Checking whether a commit modified the given line range is
>     somewhat expensive, so depending on the size of the given revision
>     range this preprocessing can result in a significant delay before
>     the first commit is shown.
> 
>   - Limiting the number of displayed commits (e.g. 'git log -3 -L...')
>     doesn't limit the amount of work during preprocessing, because
>     that limit is applied during history traversal.  Alas, by that
>     point this expensive preprocessing step has already churned
>     through the whole revision range to find all commits modifying the
>     revision range, even though only a few of them need to be shown.

s/revision range/line range/

