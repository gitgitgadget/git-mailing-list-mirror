Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BC8C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 14:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiLSO4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 09:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiLSO4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 09:56:12 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601F12D01
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:51:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h7so8890367wrs.6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 06:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ca04+4JLEPxxkyE/nmXZ2w7x36UJmWVmuy8LD5b/Z/c=;
        b=pi+lMUIvjs6NSz5ywvrL/k27X2jQaRYopmPT3oOUoc4bSrg/fu8EqvqLyYM2tM1SZk
         3n1QonUb/VdblxuqyRITpTOL6v7+BVjZkCKgQuq5GgSxpDn8Esj3jJqNZ0MCFvgz1Gq+
         yLDD6tvTBYAXe/XUiHNK+gh/BPwWbwYRCIuUyBI0A6mAcEFJQxXB3c6DpmsF/Gt+szW4
         9tYI+4/rcr173OYK1URyb78bH84WPp80LQPNwnQEeD6NuGmEEpSgqTNekFvTemuTUMh1
         5OQ8hI45bUn7EcmogQobFAApUM3sPPi/213vfzuJBlGMD/uHak5uc2coNV3uDOMCea3K
         ZORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ca04+4JLEPxxkyE/nmXZ2w7x36UJmWVmuy8LD5b/Z/c=;
        b=pxghmEplhNQZbCbmMlxNEd+oi3CyGr4K++Fl1aWaSX55Orp8yuHywtwyyhF8sGtWs3
         SHK63zfCYRz+p9xNKhJ4CRzPXkTy/AatfcXJjtHrph8K1J5cXANs3ou4DM0O2I86iFZZ
         4HsHWJbmpNJj0mO/tiYfA9BI823FEJiFhd4eAmo82Ek5vYZa+LQTQgRsiyguTgf87u68
         d9T6LukNJMldw7Uu77p3HtQwV03NnpsYrMN6cyi2r8oCw9K/rVYX083Bv5fNjs/z/7op
         D0jrhBpn+O8B0xQ/lgXrqAGfZLSLc0gVKwo/q3okB7Mbw97HG5r6AopBXMckmGLjvVfe
         pYcg==
X-Gm-Message-State: ANoB5plSq3rbwlwU8BfhT7xe1mr0KauR70YR8jchi30yjQZQlGsojp7I
        9W9c2dUbGg+DMHo3zLNRujYfAGnYlQs=
X-Google-Smtp-Source: AA0mqf7HrnTKe/kHw0LRaf9Bht+3GsK79IPZjUDiZuFRttQBBOwx37bAe1wJ5YO9k0jSi+IoItK0uQ==
X-Received: by 2002:a5d:6a4c:0:b0:242:db9:4e3c with SMTP id t12-20020a5d6a4c000000b002420db94e3cmr33262170wrw.15.1671461472179;
        Mon, 19 Dec 2022 06:51:12 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id m16-20020adfe0d0000000b0025d9d13c7e1sm6929048wri.105.2022.12.19.06.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 06:51:11 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <11545cde-9ce2-acf4-7c08-1b49d2dbefa2@dunelm.org.uk>
Date:   Mon, 19 Dec 2022 14:51:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/6] remove USE_THE_INDEX_COMPATIBILITY_MACROS
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
Content-Language: en-US
In-Reply-To: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 15/12/2022 09:58, Ævar Arnfjörð Bjarmason wrote:
> My recent now-landed topic[1] to remove most use of
> "USE_THE_INDEX_COMPATIBILITY_MACROS" was merged in 041df69edd3 (Merge
> branch 'ab/fewer-the-index-macros', 2022-11-28).
> 
> It left out use of the macros that would have conflicted with
> in-flight changes, but as those topics have landed we can now complete
> the migration.
> 
> As before this is almost entirely a matter of applying the existing
> "pending" coccinelle rules, the exceptions being 1/6, and the *.h
> changes where we remove the macro definitions (the macro users being
> edited by coccinelle).
> 
> The 4-5/6 then handle some edge cases we had left (but the code change
> itself is done by coccinelle).

I've only given these patches a quick scan, but I think they look good. 
None of the callers that are converted here are in library code so using 
the_index makes perfect sense.

Best Wishes

Phillip


> 1. https://lore.kernel.org/git/cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com/
> 
> Ævar Arnfjörð Bjarmason (6):
>    builtin/rm.c: use narrower "USE_THE_INDEX_VARIABLE"
>    cocci & cache.h: fully apply "active_nr" part of index-compatibility
>    cocci & cache.h: apply pending "index_cache_pos" rule
>    cocci & cache-tree.h: migrate "write_cache_as_tree" to "*_index_*"
>    cache-tree API: remove redundant update_main_cache_tree()
>    cocci & cache.h: remove "USE_THE_INDEX_COMPATIBILITY_MACROS"
> 
>   builtin/am.c                                  |  6 ++--
>   builtin/commit.c                              | 18 +++++-----
>   builtin/merge.c                               |  8 ++---
>   builtin/mv.c                                  |  8 +++--
>   builtin/rm.c                                  |  2 +-
>   builtin/stash.c                               | 11 +++---
>   builtin/update-index.c                        |  4 +--
>   builtin/write-tree.c                          |  5 +--
>   cache-tree.h                                  | 15 --------
>   cache.h                                       | 12 +------
>   contrib/coccinelle/index-compatibility.cocci  | 36 ++++++++++++++-----
>   .../index-compatibility.pending.cocci         | 24 -------------
>   12 files changed, 62 insertions(+), 87 deletions(-)
>   delete mode 100644 contrib/coccinelle/index-compatibility.pending.cocci
> 
