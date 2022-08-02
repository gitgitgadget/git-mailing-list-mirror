Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D265C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 02:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiHBCMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 22:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiHBCMP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 22:12:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CB83C150
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 19:12:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kb8so8970589ejc.4
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 19:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=udk+MPmnsy6HC6/ZgeMhCOIVD75MI4EW5lonFYCy9W0=;
        b=B3UDTxAQReejYFMIdYxZVrdUL1zDuxWmQYaXPOJ3zswsUzpDfN+iG857HwKdUGbB8m
         GfiZ1rpJnzhomHIrlX8i2EhAa1cb+1BNxX5CD5O5MmPF5cZmEmr6gO/Alua0DvZO47Y1
         aZdS5jylgre18Xp0f9LS6ohRhCutc68W8JAbD10VZPb+EdRcuA20ihg6nXE9F53DJWl0
         /gII39X1ZH0Xu8bijw3mPWPh5s+tSKafor0eUrg/OR2OQZnOmSOKjgtdM/k1N942OPzS
         Ze5SZ3OrLy+AwfGJJi/Rui061MQPz5gAfI7/7WlIyJis1FJcoG2VPOCPJhkLOTFSwch+
         okkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=udk+MPmnsy6HC6/ZgeMhCOIVD75MI4EW5lonFYCy9W0=;
        b=TLj3vwnw9CfeF/7QXxg3VRvbMO0AbeQ+7zQ+F6JMfQUMu5n0R5TPFniDMepYTcHKE/
         rl6RwjuuxOvwzw/NLwUNr6qDy66deABM8jHehxk9dyEFhnHyfT6V4NuW6FEBa2CiUrGP
         PE+EBiS46t8r6GqVnQI74ohtTr4/2WM+45Oa7IV8HHtdzLaNYCBFE47N3HN4wliwfeP7
         Xoy0O66dSeEYb+yGVGXR/kDvTUTPW72Fk1Op7kgSJQ+yyqsU/8BZvBp/iNwIUA9GLW7Y
         qdArJHGASqAJa1gCsv8amvgQygeMRdLC5t1MGpxDo6KLYNUK4Thw/JRemnK+r8Yn+Xg7
         vhBg==
X-Gm-Message-State: AJIora/uCuUEvNBKVhfXYhxX7s4pqABIpXuYGpAWmjR5Y0OLRUUdd0KT
        PNM7CHFdGtrEgCPhEpUJsX+r4aRo+OY=
X-Google-Smtp-Source: AGRyM1uyq5cH7uEuB6vybTi+whicq/mOPif/9v0A/pIG5+2rGcptvCGQkieCl7CR44+AhacwHjjcvQ==
X-Received: by 2002:a17:907:1c8f:b0:6e8:f898:63bb with SMTP id nb15-20020a1709071c8f00b006e8f89863bbmr14704761ejc.721.1659406332725;
        Mon, 01 Aug 2022 19:12:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ie9-20020a170906df0900b007306d478c62sm2396467ejc.62.2022.08.01.19.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 19:12:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oIhOF-009AMO-17;
        Tue, 02 Aug 2022 04:12:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 3/7] builtin/bugreport.c: avoid size_t overflow
Date:   Tue, 02 Aug 2022 04:03:55 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <e8abfdfa892f5670ed411ed6daef26a4ffa1bfe6.1659388498.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <e8abfdfa892f5670ed411ed6daef26a4ffa1bfe6.1659388498.git.gitgitgadget@gmail.com>
Message-ID: <220802.86ilnbgzr8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 01 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Avoid size_t overflow when reporting the available disk space in
> 'get_disk_info' by casting the block size and available block count to
> 'uint64_t' before multiplying them. Without this change, 'st_mult' would
> (correctly) report size_t overflow on 32-bit systems at or exceeding 2^32
> bytes of available space.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/bugreport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 35b1fc48bf1..720889a37ad 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -258,7 +258,7 @@ static int get_disk_info(struct strbuf *out)
>  	}
>  
>  	strbuf_addf(out, "Available space on '%s': ", buf.buf);
> -	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
> +	strbuf_humanise_bytes(out, (uint64_t)stat.f_bsize * (uint64_t)stat.f_bavail);

Doesn't this remove the overflow guard on 64 bit systems to support
those 32 bit systems?

I also don't tthink it's correct that this would "correctly
report...". Before this we were simply assuming that "size_t" and
"unsigned long" & "fsblkcnt_t" would all yield the same thing.

But I don't think per [1] and [2] that POSIX is giving us any guarantees
in that regard, even on 32 bit systems, but perhaps it's a reasonable
assumption in practice.

1. https://pubs.opengroup.org/onlinepubs/009695399/basedefs/sys/statvfs.h.html
2. https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.html
