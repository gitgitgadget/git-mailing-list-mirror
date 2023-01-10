Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C55C67871
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 15:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbjAJPKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 10:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbjAJPJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 10:09:57 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1EF1788C
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 07:09:56 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id g7so11152823qts.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpiNpbAfjdVmrnXdM6y+1mmaDZvqRaKsotfNgv4lJ2E=;
        b=hC29Nu0o5xfGMMwiMuGTRrakOxdvKweMNcJZnWoVbLw7WCbus9x+0rHD8Kemx5UjwV
         2M6J3I7arG0Y1Uj9Vbt7ijSQPPTGCTXs3NfqgxdWaXfD1si59fiX2TybGrWSyeM1jGV6
         gg7tjqi+a6SKFV7/LspMFnVkp7pv5cGYbSErew6EfOpPgllRjNvcuzigFt+iEg7MFfuJ
         vLe1HF2dt35Mv2pjFjK6lP9Hdf2y4RhrXdoxHxDB2DpM56OjLk7X3hE/a+w5l3C67WGd
         jwxH75lofci0WAjIuNPHbrrf2u2TrOqq+MzukdYoh2lCwQ6UMHOzAPiDRoK1SaLGniEI
         owMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpiNpbAfjdVmrnXdM6y+1mmaDZvqRaKsotfNgv4lJ2E=;
        b=gS79tJSXUfoRqCRRW0C/PgjD9uyOEqKXBogXuEAP3OhwRXNg/2cVouYwP+kt3JbcGi
         33OtS0JWNP19EM2rQA0iY4MQolBtn/I3dRksL+9h7Ehkm8xiWOx1P1wb0S2vu+0c84ax
         hqUIMMHJ/g/80NSyF+76n68bIvo+yX+02BELL9CUvMUV/quY9TTFeMU9a9JTokmOrWne
         lHfOE5iVqI83vpkp0+JOYCnrdQ7nTWYj80Ea9BP7wOZScYd8Pli5ey7l2XSM/V/fovH7
         qZlmTbUUaX5vGGMfBxn9/8/F4WgNlkLKynbLh76mer8qtsMCQEKxH9TYjezyusUx9lKV
         Z4xg==
X-Gm-Message-State: AFqh2kqA+IfuBu+WElxrQWVAB0Xv9W75w5MMJA61AhvBlTmDSKIIcAWf
        uJE4Cw/qDmobIocYbfeKoO13
X-Google-Smtp-Source: AMrXdXs62GwajuS1y8D649tJ9flp+VGsLMVKxHmLfGby+TVHC9Ar0P2JZpqTtjVpFTdJBRTHUr1upg==
X-Received: by 2002:a05:622a:4d47:b0:3a7:f183:7f66 with SMTP id fe7-20020a05622a4d4700b003a7f1837f66mr104774569qtb.22.1673363395726;
        Tue, 10 Jan 2023 07:09:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3590:f4a:dde:5efd? ([2600:1700:e72:80a0:3590:f4a:dde:5efd])
        by smtp.gmail.com with ESMTPSA id u12-20020a05622a198c00b003ade7d4ad7asm2418384qtc.10.2023.01.10.07.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 07:09:55 -0800 (PST)
Message-ID: <84705c15-803f-3062-8a02-474eb1eb053a@github.com>
Date:   Tue, 10 Jan 2023 10:09:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/5] cache API: always have a "istate->repo"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/2023 1:17 AM, Ævar Arnfjörð Bjarmason wrote:
> The "struct index_state" contains a "repo" member, which should be a
> pointer to the repository for that index, but which due to us
> constructing such structs on an ad-hoc basis in various places wasn't
> always available.
> 
> We'd thus end up with code like this, in the recent
> ds/omit-trailing-hash-in-index topic:
> 
> 	struct repository *r = istate->repo ? istate->repo : the_repository;
> 
> Really we should be able to trust the "istate->repo", but were
> carrying those sorts of conditionals because our index might come from
> a manually constructed source, so we'd have to fall back to
> "the_repository".
> 
> This series changes the relvant code so the "repo" field is always
> non-NULL, as 5/5 here shows we had various workarounds in place for
> that, which can now go away.

Thanks for these changes. I only had a recommended change for Patch 3,
along with Philip's recommended commit message fixup.

Glad to wrap up this tech debt.

Thanks,
-Stolee
