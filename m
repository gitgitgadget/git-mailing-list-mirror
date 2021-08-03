Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC69EC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 00:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9794960F93
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 00:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhHCApt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 20:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhHCAps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 20:45:48 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518FC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 17:45:38 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 14so196402qkc.4
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 17:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JV6jjK4G+sAT646cijRIVYeUoqurPQuocCEtk4Hjx08=;
        b=G0UXmcTp14vLDyfOydfcdN599soSuA7V2yps3dGc5Vp5trztyMc1zw4ihRYlMp9q3V
         zzVb6xRDfaINQbyhqsW/LQIU+pJeYqxASGDpVw8Sw4W3K4+UdRi7fLxPr7gJFj/EkUwz
         I7I0W+yGCWj1ZTdgRrvj/1poKI/d9mFKk8vln7iIu/AYhLXz8Ptix/r6A+aGcNdzbLYy
         rTjYYtAPJ4/R7YF1XBMzXKYtZrTf3EJcQhryC60wNqZp/qkEH99QGyQpOz/UbbKXa7B1
         hJPTHzvanZ//oKYGjkJdACHgbTmVqsB3Y8tDqOzwS0JXu53Xzkq679XL/d3kt6RZGLbN
         qpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JV6jjK4G+sAT646cijRIVYeUoqurPQuocCEtk4Hjx08=;
        b=nvbAWKh+HZPFhsko3WRmvtnIO2oGk2E6gHize2kLHlJLSAWHgN2kd4xZsxCcCqGFl+
         Aehrqy13NCz4IhZxqhfH5xVp533KLeSssPdOBjG74/SBmn1jQ4Q4Y3KJschsQN2MICbw
         ZicvWgpgJF/WoqRGW3kS4yarXYUSSHwqcJHFAWoEhgDz58RkavG5BePLqJ2iCvCEzMEO
         Cnmz05LC1g5qrvRKYzEu+0eYV/ZPgpUc9rr6K9/p6TRe6gCRuqAGq73gPFWzYpk3aqRL
         Dn4bRkqMvNyE3RhCw8GPIQQtd4HtbGBzvINn03nonY7c9uVufdfU6wQnVXZBgPjchMAj
         sFMw==
X-Gm-Message-State: AOAM532CMGEnvdCJF8lYycf4XxGcvsdOs8w1MTmnJ6XC+fczDnrmCcC1
        0ThRIqMk+lrsuzP9NBTVDxk=
X-Google-Smtp-Source: ABdhPJx/DaidL743ipeNZOmfPFYt1hBZlGve2aouy4LdEq4IPCeu25RoAwYjMn2+lNjVlzfHBiOxgg==
X-Received: by 2002:a05:620a:294b:: with SMTP id n11mr18296014qkp.145.1627951537645;
        Mon, 02 Aug 2021 17:45:37 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id n13sm5347223qtx.92.2021.08.02.17.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 17:45:37 -0700 (PDT)
Date:   Mon, 2 Aug 2021 20:45:36 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/4] advice: remove usage of `advice_*` global
 variables
Message-ID: <YQiRsEzF8psNTqRR@erythro.dev.benboeckel.internal>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
 <nycvar.QRO.7.76.6.2108030009330.55@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2108030009330.55@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 00:15:06 +0200, Johannes Schindelin wrote:
> On Fri, 30 Jul 2021, Ben Boeckel wrote:
> > When looking at global variable usage for my `branch.default*` settings,
> > I found the `advice_` variables which were simple enough to resolve.
> 
> Even better, it concludes the journey started in c4a09cc9ccb (Merge branch
> 'hw/advise-ng', 2020-03-25).
> 
> I reviewed the entire series and left a few comments I believe to be
> constructive.

Thanks, they've been helpful. I'll work on updating my topic in the
coming days.

> Since patch 2/4 resolves a problem introduced by merging divergent changes
> (one adding `advice_settings`, the other adding two entries to
> `advice_config`), an obvious concern with this patch series is: How can we
> guarantee that we're not introducing a similar problem when removing
> `advice_config`? A future branch could easily add entries to that array,
> and a merge of this here topic could potentially forget to add those
> entries to `advice_settings`.
> 
> However, such a future merge would always cause merge (add/remove)
> conflicts in the `advice_config` array, i.e. it will be much easier to
> notice such a divergence, and hence it will be much more likely that the
> `advice_setting` array will be adjusted accordingly in such a hypothetical

Yes, Git should be able to notice a conflict of this nature.

Thanks,

--Ben
