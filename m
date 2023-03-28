Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F2C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 18:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjC1Sj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjC1Sj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 14:39:56 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55351BC5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:39:55 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p203so16327702ybb.13
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680028795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTSf4C/eDp05smU1CG+Jnci4JTDNAnkdlAUkt93gNk0=;
        b=ouVNaxlNFSpvKsUHWMW5iVWKJtw8h0OVJuulRjTATC2Xtg5JRJk3rlerk+AGX7jeDu
         1TK/6xNgNS/P184Sa+zJT+punQBaKLbhOaeWveZl3mQYaemLEEfv/UM7tOJFDpD1NyKr
         czwymYTMQ3SBVRw0HMl0Uv/EynQfJogNB9VIP8j5/799o3jqq6YUnr3KxRhoAEMD3Maf
         Kd9yVOSTPx9elpKN4RDmww5gA+91dp/tX+NFCDb/2e1YpknUX2mQDpXCsi8QYsYXoVjC
         NdOvTJQm0ZqbAunnVSwCwyByKZiMJKPzgDsFl4BXs9f3wbhmI1MxcVkS9xGQdBC0Uegh
         cIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680028795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTSf4C/eDp05smU1CG+Jnci4JTDNAnkdlAUkt93gNk0=;
        b=TvD7BnXoohNCYrj+fRHr1orLwmn7I0E/D7nqQkxep53HnbBwJYRtEFv8NLL6eGgczd
         RZgwC5nZ909nTBZtHh16LuHHaRk74hP7CICuem0uva5GvOVxSmjEXkMzWrhK9NuoDFye
         +70QgFjLbpZPyBtCWHqw6GjIuKqAcaARNzhVPI1s9jWwwopdWXjd2az9iykerBDps43F
         LA9o9nBtemUEUK7UyxzDgamUm5RM7i7VfGGpsMexfKL0FBgPElRpnrHSBKQcyX15AMKE
         IsPg11QyP4qDNK9loY8vlxnycvRiaMnWnqDh202dZZJ6TsP2ztzbZKKq4XSp8VAWQ0i+
         NHlA==
X-Gm-Message-State: AAQBX9eHBh0E/49zPWN90W8zeRap5QZ2wyrPdqVKNKhyLB2WT7Jh2Ohc
        OlqkjCqclsgG5sTEcFAO9yTZew==
X-Google-Smtp-Source: AKy350YE4Ence3O6qWsrMSEvlCGIE+f1wlaEtCeLBpTu8CAfUqzTIyoo3W8cryZ8NQtl6WWp6oob6Q==
X-Received: by 2002:a25:ac8e:0:b0:b25:594d:eaff with SMTP id x14-20020a25ac8e000000b00b25594deaffmr16051319ybi.57.1680028794767;
        Tue, 28 Mar 2023 11:39:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l62-20020a252541000000b00b7767ca7482sm3046025ybl.31.2023.03.28.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:39:54 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:39:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] commit-graph: fix truncated generation numbers
Message-ID: <ZCM0eYGKWc8UusZ7@nand.local>
References: <f8a0a869e8b0882f05cac49d78f49ba3553d3c44.1679904401.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8a0a869e8b0882f05cac49d78f49ba3553d3c44.1679904401.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2023 at 10:08:25AM +0200, Patrick Steinhardt wrote:
> In 80c928d947 (commit-graph: simplify compute_generation_numbers(),
> 2023-03-20), the code to compute generation numbers was simplified to
> use the same infrastructure as is used to compute topological levels.
> This refactoring introduced a bug where the generation numbers are
> truncated when they exceed UINT32_MAX because we explicitly cast the
> computed generation number to `uint32_t`. This is not required though:
> both the computed value and the field of `struct commit_graph_data` are
> of the same type `timestamp_t` already, so casting to `uint32_t` will
> cause truncation.

Yes, well spotted and explained. Indeed, the `generation` field of the
`commit_graph_data` struct uses our custom `timestamp_t`, so this cast
is unnecessary.

And it's fine to have a value greater than 2<<32-1 here, since we can
represent values that require more than 32-bits of storage. For that we
rely on the extended offset table (in this case, GDA2).

> This cast can cause us to miscompute generation data overflows:
>
>     1. Given a commit with no parents and committer date
>        `UINT32_MAX + 1`.

FWIW, I don't think this is the only way to trigger this bug. It would
also work if there was a commit C whose maximum parent's generation
number is (2<<32-1), in which case C's generation number would be 2<<32,
and trigger our overflow here.

> This commit applies on top of cbfe360b14 (commit-reach: add
> tips_reachable_from_bases(), 2023-03-20), which has recently been merged
> to next.

This all looks good to me, I'd be happy to see this squashed into that
topic on 'next'.

Thanks,
Taylor
