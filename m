Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C09C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 22:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245181AbiBTWl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 17:41:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245176AbiBTWl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 17:41:57 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E91108D
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:41:35 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id v3so3434953ilc.7
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dDu1Cfi7dmh4s0pQ9QrkvucS7dNgGSm8Gu7vaP8gNAw=;
        b=ZUEEjs8OUfmYevNPNx9oMlfbwJlKglEb/1wHR98WGfuxnNBGhySFKU0L1FmrBhl9WO
         eTeyTC+iJ+GfAoFY67MiXSpL95Q+QwTtTdaFtZzQJILySjoKX0fToAhQpC+rz3MJ3CCt
         3feKpMAxZLcZGB4EGVkFDzQe9Y18QKRAbCb1V4UXIVbM6jogNzxMkMMl9F+z6DEAOFbc
         QBtg8B9UkNTPL87hHFNZcx2MtLmMoeX2TswjI33eJaDrHUEiY1je/XZ5a7u+5n6Dklki
         2ZLzj6GzkQnUPHyt3XbyTB8BMEkRSEsuvHurpdyXHKH6bHeY6t6Ij9CXdx6VCyDhFWcO
         MLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dDu1Cfi7dmh4s0pQ9QrkvucS7dNgGSm8Gu7vaP8gNAw=;
        b=DIASiY8wBF9l3BXXl1Er4Mpz6m9HCfUjh7foDeR0i2d0uo2akP8UBmCMukTwgrg+QD
         gJ3p7bQhCWzXegGPSOLXDEVss9Q7SCcF3/81o1JoIc8CSiHDd/oO0uYa2K+SGAo3oNul
         qHiGYhMETXMC1n30c6w3gRtrylSXKZkKEhy9g5FRG1/KNyWFJn8fmU6unjBbF8s3Twx2
         nqMEJZnGu2WdWS4rRxPRA4iD/8yZoLvJLOAsdM4b5TvuZ9wMpyespV6ZLgdvx1jBIVE9
         AYTTZHRwbwlhsWQDoLJsKXggUwLiUeYMHGdJxZEoeGefPvP+dJ6T1zkBCmO16FNIrl9N
         ID/Q==
X-Gm-Message-State: AOAM533iXZqRQ3eGA3VSpx0N+HVresaN6ZWTmH0oAt6tgZ9WRv8UPIsr
        ivebbx/9WWmNznyfkoDXlU36sQ==
X-Google-Smtp-Source: ABdhPJz+zVj9JN+AbFy48yJqHaQFl62wlmP2dnnz016k0n1PhLnpuWnWtonQjQ9VL82Hz4sqRcMXzw==
X-Received: by 2002:a92:3314:0:b0:2bc:8054:9780 with SMTP id a20-20020a923314000000b002bc80549780mr12632995ilf.12.1645396895044;
        Sun, 20 Feb 2022 14:41:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m11sm2384398ilg.53.2022.02.20.14.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 14:41:34 -0800 (PST)
Date:   Sun, 20 Feb 2022 17:41:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/11] Updates to worktree code and docs
Message-ID: <YhLDng5kFnZgfDll@nand.local>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <YhLC3OVuRpAbxrhY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhLC3OVuRpAbxrhY@nand.local>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 05:38:20PM -0500, Taylor Blau wrote:
> On Sun, Feb 20, 2022 at 05:54:16PM +0000, Derrick Stolee via GitGitGadget wrote:
> > This is built on top of ds/sparse-checkout-requires-per-worktree-config and
> > includes some forward fixes for comments from that series.
>
> Thanks, I took a careful look through these and they all mostly look
> good to me.
>
> I left a couple of small notes throughout, but I wouldn't be sad if you
> ignored any or all of them (though see my notes on the very last patch,
> where I think you replaced one too many instances of "working tree").

In this (and a handful of other replies), my 'group-reply' macro was too
eager to drop any entries in the Cc list that it couldn't parse, so a
handful of recipients got dropped.

That's fine, since nothing in any of those messages was critical in
terms of reaching those individuals, but they are CC'd here just in
case.

Thanks,
Taylor
