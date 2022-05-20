Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B62EC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbiETTqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiETTqP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:46:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6050F26AD9
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:46:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so12344352pjb.2
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fXHEUwoIjknYwb98ar02Swqq7u+lWDMyxZYabQ/If7I=;
        b=a88wYh5MTVTn76rvPLvOghMfB6L6PqCyHLlbNtEYv6EaeAUTUrpobYsrOFEkmmv7fO
         JJXVSvo90Rq2pDYLje3R8KIshSVN2fZwC3JX8wx+fvms4YWvj/hu378Ifph3Cc7txX7x
         37tivmNElLW56l1tGVGSGWEzTbGALLfkCfg65TcD1+8cFdgvL8bGdLoMs3u005CRWALt
         e6rAIXUIlkHbAuIQPcAqWJL31f5Rx6GH2hmVTv60BhhQv7BgB6Xz2LCLKkZA9aOmkVdZ
         PMw7jml5+6Flgp940TPH9HDMQJaJj0PIFT3UnZtlAqDosV5ChowB+3P9YTZzVOro2t5o
         8J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fXHEUwoIjknYwb98ar02Swqq7u+lWDMyxZYabQ/If7I=;
        b=FDvQIIiND9cB/CfOO0Zq5O5yNoZ0Zkbk8TK1yN7LNbJJjc6JaWx0qn9YMm3TgqSvSb
         VS3glNJ+hTC7kmwPWvZh5CGgebCqNmaa14Toz+7uUaLGWgBjv/hIrFwRZyDzll6xxL+7
         MliVugVg+nSlVN6ggNHXdb4yrdWSwKNKYa5EpvL0/jmpQ0V4vYahn37OR37FgXQWIESM
         QWWRehobkuko7wTh2ZT3x/j7YheojH/HmOAC2hLFiSo0pWDwZ2zzIb4q5gkYshDhHCdr
         cjuzazu/jWV4YKmpPeOcQ/b4aUzVSogyWFG6Ki5207EjpEkeGmHbbVF94Ue/3tTjL72R
         zx+w==
X-Gm-Message-State: AOAM532tq1Ce18hGBye9Yrzais2bCt+hdmgdGauEQdcK/MGTvrtMlzIt
        6Js8Tdk1IyiuuEYaGB+QB43Do14ZOyTp
X-Google-Smtp-Source: ABdhPJxXZ32eqd1E7K/YnhYft8NS8CFewapp0AFpIpuFZBGA5XeXXMXP32lYnf+lwZcWFpz7Yhtg+A==
X-Received: by 2002:a17:902:6f16:b0:15e:f719:34ec with SMTP id w22-20020a1709026f1600b0015ef71934ecmr11563966plk.166.1653075973892;
        Fri, 20 May 2022 12:46:13 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902a60c00b00161a16f0050sm114354plq.222.2022.05.20.12.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 12:46:13 -0700 (PDT)
Message-ID: <5517f0f8-871c-a155-7d8c-d0d6086bb7d2@github.com>
Date:   Fri, 20 May 2022 12:46:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] repack: handle --keep-pack, --max-pack-size for
 geometric repacks
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <cover.1653073280.git.me@ttaylorr.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <cover.1653073280.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> This series fixes two issues that Victoria and I noticed while working on an
> unrelated issue yesterday.
> 
>   - The first patch comes from Victoria's earlier submission[1], and addresses
>     an issue where packs specified as kept via the `--keep-pack` option could
>     potentially be removed (without rewriting their objects) during a
>     `--geometric` repack.
> 
>     The first patch is Victoria's alone, with some minor fixups applied from my
>     review in [2]. It's included in this series since it's related, and avoids
>     any conflicts when merging.
> 

I'm happy with the fixes you applied here and don't have anything else I'd
like to add this patch.

>   - The latter two patches are mine, and address an issue where specifying a
>     `--max-pack-size` value during a `--geometric` repack could result in object
>     loss because of a false positive in our "did we write a pack with this
>     name?" check (which can occur when the list of packs we wrote isn't sorted).
> 
>     The first of these two patches demonstrates the issue (done in a separate
>     patch, since the scenario is quite involved), and the second patch fixes the
>     bug.
> 

I was worried about the robustness of the test, but some deeper diving
revealed that it should produce consistent results. Otherwise, the fix
itself is a straightforward (albeit hard to find in the first place). These
two patches look good to me!

> Thanks in advance for your review.
> 
> [1]: https://lore.kernel.org/git/pull.1235.git.1653064572170.gitgitgadget@gmail.com/
> [2]: https://lore.kernel.org/git/YofJLv8+x5J7yPmf@nand.local/
> 
> Taylor Blau (2):
>   t7703: demonstrate object corruption with pack.packSizeLimit
>   builtin/repack.c: ensure that `names` is sorted
> 
> Victoria Dye (1):
>   repack: respect --keep-pack with geometric repack
> 
>  builtin/repack.c            | 49 ++++++++++++++++++------
>  t/t7703-repack-geometric.sh | 75 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 12 deletions(-)
> 

