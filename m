Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B449C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 21:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349027AbiEPVIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 17:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiEPVIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 17:08:09 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419549FAB
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:49:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j3so3769389qvn.0
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8CuKCBM7cXDzJuz3yhi0Qw5PGYC335NHabDpDO220x8=;
        b=de3ZM5kiQcWNGWn0dA4YPab3gE3YFq1x0IsHQTTc/wJBcmxQ3IykBGioXaNkjTmjP6
         LG5Nq8vioqMu5qZoWwpzNYgc9E8qwW8NQF6ew9w0hERSEkafoOGxEg7bBaevkU/PmRFS
         2eEQT+uM1rx3mQsJKaZcnjBblZFXmBhiJfIi1fjF7cS487eLIuG6LK6/fcCfIYqOtF/M
         WnQmo79zmP1mM4MQzFwBrvy7wVysw6wMoFKVrjX5ZKF09s05f8RUeNursicmcKomayh1
         J/vqp9SkfCmT2ZS/+7FhkeJG7L3aRK9G26bWhvyXrKljs0aX6FYPnwFg303YPkRhHJTp
         PuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8CuKCBM7cXDzJuz3yhi0Qw5PGYC335NHabDpDO220x8=;
        b=d/TkLZGH+H4+V5+VpwWMM6MeWMC/bFuXRP0u3DpgzhFoFexTH6t7stGuc0jMeai0VU
         h1cyFCDZPsrtuf0VK+kzazZVrI8YLD5WsKGEELeL/hJKhEM8mf5msTgxRj4ATdZNcZ/C
         VL7PW0kUJ4j50cKW7nSkAKC/rI3eXwiPrsJG7sqV+95I6eCJLyfyhSCBwIHOV/k/sPYI
         SxbbCuOnnBppvvCSGHfPzLUijVGZpta/0WntA5ZdauZC5GfT50ifq7CY/Mb0PAnIxh/V
         TygNdgB06fzq6KR/uDeUSvFB0bH1xVifFuny+9kZqJhTsumY1/JBzLcU3Nia619i2/CV
         BUsw==
X-Gm-Message-State: AOAM531fh9vUlt9nT+88LYFDmBzhMF7UmuTHGQjHPUDDK0tcXQUyrEGR
        hJ7Etft6XgJPo0EMNwy7QyFq
X-Google-Smtp-Source: ABdhPJwvmXeJmi8zrlVIqMndIohmd5FgKQSNk+5ZP1ejJHpU5YoHnLCSFb90sbp6OXXUqDTSBQKxpw==
X-Received: by 2002:a0c:ea89:0:b0:461:c43d:7b5c with SMTP id d9-20020a0cea89000000b00461c43d7b5cmr9315570qvp.38.1652734164973;
        Mon, 16 May 2022 13:49:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a875:ee72:945f:af93? ([2600:1700:e72:80a0:a875:ee72:945f:af93])
        by smtp.gmail.com with ESMTPSA id r144-20020a37a896000000b0069ff8ebec64sm6274613qke.103.2022.05.16.13.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 13:49:24 -0700 (PDT)
Message-ID: <0d4cf56a-83b6-c7d2-b0b8-a5a5e5d0ccfd@github.com>
Date:   Mon, 16 May 2022 16:49:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/8] sparse-index: create expand_to_pattern_list()
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <f1194d56d331611446c285a1d070509d73bd5f43.1652724693.git.gitgitgadget@gmail.com>
 <12df1777-9f02-ca6f-7d17-57aebe25d06c@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <12df1777-9f02-ca6f-7d17-57aebe25d06c@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/16/2022 4:36 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:

>> -void ensure_full_index(struct index_state *istate)
>> +void expand_to_pattern_list(struct index_state *istate,
>> +			      struct pattern_list *pl)
> 
> Hyper-nit: I don't think this is aligned (it's probably not worth fixing
> unless you end up rerolling for something else).

You're right. When I saw this I thought it was just the
"off by one" issue when patches have a "+" in the beginning,
but it's actually the backwards order. Thanks for catching it.

-Stolee
