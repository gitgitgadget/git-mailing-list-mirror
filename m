Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F6C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 13:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbjFGNv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjFGNvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 09:51:25 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F919BF
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 06:51:24 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-565bdae581eso91838827b3.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686145884; x=1688737884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Abk8qR4FuM4HF+bnzqP74omOwhGc2kHU8CEsh5bvFAU=;
        b=ZMbE3Ik7dh1wjxndyc9+OqIfRzD+CMtm+m4GQEEhcV6pEaaqIGtn/iv+yaHwY4yXLk
         Z0M88W0K2C5xltri/k6wWMl7shnSNqOkwjQXUlrwfu1YbHbjEN0vPGicUclngkO2WPlI
         qGkvqBeCUHadT3HA67Wjhs41FARGtSXSW2VRBr/8jp/7Xrgf5OcaXi4lx7w3H5l9coMU
         VXhB/zEYyVKvTi0LPkdT9kHsMVc8d+A60JWlGRU8iLDObQbVdGrFETJwLUoO1axQEJCz
         ALzEFUlm/izZBdKGrJTi+WyQfvpiKEGtmlHGVg9lJmzLTK4XUZTO3D836LPqoLmI2Ezw
         9+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145884; x=1688737884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Abk8qR4FuM4HF+bnzqP74omOwhGc2kHU8CEsh5bvFAU=;
        b=UkmpRol97CJsyvfWPxsWsbgFIieswFcoR4OyJzUTYsH+3UYV2hAyeT0sQcR6B39bHf
         nwoHezWNZvykLGX8jof9CgDmiJZ9fgeR1bemzmorDUkmMANvlI3rsEwAgC2xygyv8Wr1
         yMX+APjO+9CVI5FHEsPjFoA3rSXb18Fu1qXROH6GqkEe7CgI6+OtWcF7sZCf2sM0qPDm
         StQQDruNPJpaH9xPRdydCxz3ylR8LkUdtj1TdG+iJ38s2yQtgeiXOWyngx4RqijuL+WU
         WDykMTXASUVDXgABgP+35j5EldvriR9wFYABMBmZCgWRiwbPyWHNiXwoAfEjPj7MTPbV
         WLww==
X-Gm-Message-State: AC+VfDyhEnp1zdCDAe+4s1hBwNNlDXdAnTi4Xuw6/NmnwNi62+724jr2
        wXKk0R1jpPsW3j/AenKexP0o
X-Google-Smtp-Source: ACHHUZ4IW/D0Qe3JQzYV/q4+tsdjrAqlKjmR5hPZq6QK/O/rXdmgKqhSxeUnuizH1sHb+M2l1imT1Q==
X-Received: by 2002:a0d:e291:0:b0:569:ff01:41b8 with SMTP id l139-20020a0de291000000b00569ff0141b8mr4549094ywe.15.1686145884188;
        Wed, 07 Jun 2023 06:51:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ec69:1775:6713:a647? ([2600:1700:e72:80a0:ec69:1775:6713:a647])
        by smtp.gmail.com with ESMTPSA id p130-20020a0de688000000b0055d6b67f468sm1221804ywe.14.2023.06.07.06.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:51:23 -0700 (PDT)
Message-ID: <d3c67344-a10d-f680-4601-581138985006@github.com>
Date:   Wed, 7 Jun 2023 09:51:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] builtin/repack.c: only collect fully-formed packs
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <dda5a34a3e879787ce8651674962db6cf913b7b2.1686132967.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <dda5a34a3e879787ce8651674962db6cf913b7b2.1686132967.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2023 6:16 AM, Taylor Blau wrote:
> To partition the set of packs based on which ones are "kept" (either
> they have a .keep file, or were otherwise marked via the `--keep-pack`
> option) and "non-kept" ones (anything else), `git repack` uses its
> `collect_pack_filenames()` function.

...

> Fix the above by teaching `collect_pack_filenames()` to only collect
> packs with their corresponding `*.idx` files in place, indicating that
> those packs have been fully staged.

I reviewed an internal version of this patch, so I'm happy with this
version. I'd be very interested if anyone has concerns with the
approach, though.

Thanks,
-Stolee

