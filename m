Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3390DC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 22:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E597222DD3
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 22:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbhARWBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 17:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbhARWBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 17:01:25 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7806AC061575
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 14:00:45 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id p5so8232650qvs.7
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 14:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4S/dx4NS/txosdSJ3ZJbqJZtkgpMn0FtihKoQ730Fyw=;
        b=jP70WqCZdz7x8RwYxKUNgLeTEtpbWEaGIrgycs3LeejUYz/tUnIHIGPPsx48er91N1
         AIvdR9nGibgyz2+W1M9LoVskOtWFujlLt2xXDVRQXwkDkUbXZb/LjI+/yyZtxCX7PUor
         KpuzxfkTu5fjRNQLteooNRsvz5CnuLo8ypc4Qunei/AULYnN/pNYPUaBeznNCWy0Hqyu
         0jyVuO8UaDZBdSolMJKNe1SBkQHjEKlfXZnziqml4dBdOKiVzTUibr/2ELPh2Ar1OCHU
         yM9erNASpPd+QJtdLOM6HXjR3fuLmiSiKYLvc1pEto17Z4r2yBWQmqViJeexlnOIaVRS
         Aaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4S/dx4NS/txosdSJ3ZJbqJZtkgpMn0FtihKoQ730Fyw=;
        b=J7nUhKTNgDkjX5UMlpzia4g+YVieUTh9N3JCdQuTJ6TdxGkW/VvfzyyQ57I5HBqJeN
         qy3O5e+iqkh8SV9cwu8GjFm17PetMbYBMSHlPrPsust5l28ALU2QAmOZPihzMHPaIb6c
         srBAyuAWyuGhGC2OvnsF94WKs81bxCRkyMcNhKw0rEnZN/iMUbTkdJmR2WwtNyz+JmsI
         kM5yN2wyKzZjFONlXFEmrW9q4HJ7NalbpgjNZ27W5Do/K8tkC+lkaxirW7RG9eJ37G/B
         xAD4vnGfzMenkUbRlUIYSZM0Ix2ni76Zt4UxQnbvqDzomF3vMHf455tIObQymg2SiOUl
         JrtA==
X-Gm-Message-State: AOAM531OhTNHFACDmpskiclb4km+ElQfJRHCWN//w5S2JSYxd2cnOSsO
        A9z7mjOwFH9dYtIHdVvcVPCP7w==
X-Google-Smtp-Source: ABdhPJxT4IfcYV+//JUkQd8skla6cVPOUeQBHXJknNOMljJUgtSr04jnIJnsY6UeAFq4qDOJ/Xwcng==
X-Received: by 2002:a0c:b4d1:: with SMTP id h17mr1409452qvf.53.1611007244780;
        Mon, 18 Jan 2021 14:00:44 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:626b:1275:5dba:df42])
        by smtp.gmail.com with ESMTPSA id a77sm11613301qkg.77.2021.01.18.14.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:00:44 -0800 (PST)
Date:   Mon, 18 Jan 2021 17:00:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 00/11] [GSoC] Implement Corrected Commit Date
Message-ID: <YAYFCbVvEL+GbQOl@nand.local>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
 <2437ba7c-f9d9-34bd-5e08-eff96cadcf91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2437ba7c-f9d9-34bd-5e08-eff96cadcf91@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 04:04:14PM -0500, Derrick Stolee wrote:
> I checked the range-diff and looked once more through the patch
> series. This version is good to go by my standards.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

I re-read this series now that it seems to have stabilized, and I agree
with Stolee that it LGTM.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> Thanks, Abhishek!

Incredible work!

Thanks,
Taylor
