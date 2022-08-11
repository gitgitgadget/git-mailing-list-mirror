Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496A4C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 12:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiHKMtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 08:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiHKMt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 08:49:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F686C77D
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 05:49:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l22so21238097wrz.7
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=zTsIeSBjDPhYd7AGZ8cST1b+k8MMW6F56+0RazR2xPo=;
        b=jJn176JxfUK4+vsFPJPG2Oz/Y1wuQpCVFiRITyiPJdoPx8TP9THy4gzHG7vj/4Auc4
         V5PY79XPfPr/UfgE098N5YaaTpRGCUP0QIO1RwS27dgp7BrbwUqS7jYawnWtthkUwKjD
         ayxtIj/D4h2XgxnvRHUa8Kr4ZQkbtgn8mvz+lENgbrZSwJRJip8LY9wDZai8DOcK1Yu0
         pJ/lMc35caiHEXoqvwzBzfbi05h/JG9YeB9uhbeRmV7UVQtfldJUAi7TXRch2FQA04nG
         LBy3G5q8/ZpNH1k3Yv0qTxmoZmvceHRU6XGx/gEkY3YEYZN8vhnJVWeNtK3ZKhYNuU1m
         EIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=zTsIeSBjDPhYd7AGZ8cST1b+k8MMW6F56+0RazR2xPo=;
        b=WVuzoJNp6q+pWaCyNFgkwAvic+wQ3tQ1Z+RNupmasb6HIuWh4EuX4Wcka0uyQJmw4S
         GpcWe/SV3i6V3fKKhOpri5FSrZc4ckLUh2VlT0CdL38bvJb5d0d/9gn0bAji57cd8vpK
         z1vhKqB4yex6eE/tjvSw/iY3EpC+txYPoD/H+hVhRtaQs+NMpoaxeAWlPfO45LwnE6vw
         Vj0/TS4EtrWbSDIeBdisomESFWjz8WBP3Hy/ZibqcfAc5yQgx8hJeWvjOmcIMftx4iQY
         N2ESUYadNBdvsMb8tf+tmtgHt9O5PCMt7+jhqbFjJArEvp8PnEu/ISvet6cwaJaspvY5
         WY0Q==
X-Gm-Message-State: ACgBeo30PKiy+el6PgsllPZW9Pxm/bBVcv3kclWB6+fDjTNf7ae4UKle
        ofemnvfku1i0FvGToKyZ8Bk=
X-Google-Smtp-Source: AA6agR4DjBY1a6rqUSp7l6lEQWiy+6b/Hn1VsS83RpabCH+2Tflengu0LxDvWUGE7VmPdkiE+fS9tg==
X-Received: by 2002:adf:f10d:0:b0:220:7e4f:ceb6 with SMTP id r13-20020adff10d000000b002207e4fceb6mr20272267wro.316.1660222167334;
        Thu, 11 Aug 2022 05:49:27 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id q3-20020a056000136300b0021b956da1dcsm18829303wrz.113.2022.08.11.05.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 05:49:26 -0700 (PDT)
Message-ID: <ec8204d5-9d0d-9850-f930-6fc1a8efacc5@gmail.com>
Date:   Thu, 11 Aug 2022 13:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] add -p: avoid ambiguous signed/unsigned comparison
Content-Language: en-GB-large
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 10/08/2022 16:02, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In the interactive `add` operation, users can choose to jump to specific
> hunks, and Git will present the hunk list in that case. To avoid showing
> too many lines at once, only a maximum of 21 hunks are shown, skipping
> the "mode change" pseudo hunk.
> 
> The comparison performed to skip the "mode change" pseudo hunk (if any)
> compares a signed integer `i` to the unsigned value `mode_change` (which
> can be 0 or 1 because it is a 1-bit type).
> 
> According to section 6.3.1.8 of the C99 standard (see e.g.
> https://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf), what should
> happen is an automatic conversion of the "lesser" type to the "greater"
> type, but since the types differ in signedness, it is ill-defined what
> is the correct "usual arithmetic conversion".
> 
> Which means that Visual C's behavior can (and does) differ from GCC's:
> When compiling Git using the latter, `add -p`'s `goto` command shows no
> hunks by default because it casts a negative start offset to a pretty
> large unsigned value, breaking the "goto hunk" test case in
> `t3701-add-interactive.sh`.
> 
> Let's avoid that by converting the unsigned bit explicitly to a signed
> integer.

Oh the joys of bit-fields!

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   add-patch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 509ca04456b..3524555e2b0 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1547,7 +1547,7 @@ soft_increment:
>   			strbuf_remove(&s->answer, 0, 1);
>   			strbuf_trim(&s->answer);

Unrelated to this change but why don't we just call strbuf_reset() here?

>   			i = hunk_index - DISPLAY_HUNKS_LINES / 2;
> -			if (i < file_diff->mode_change)
> +			if (i < (int)file_diff->mode_change)

The change itself looks good

Best Wishes

Phillip

>   				i = file_diff->mode_change;
>   			while (s->answer.len == 0) {
>   				i = display_hunks(s, file_diff, i);
