Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B8AC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbiCBU7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiCBU7O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:59:14 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E2AD2057
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:58:31 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c4so2853004qtx.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 12:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1TGG52htElKPw3whcjO4SkQRukCf83zoz5tsBhwZW7c=;
        b=Rgy5O4iOhnviT3Q76CP4c6Z7owptW8hBrKplQQzWf5BEy/A76c5PL061nlIzjJKmvi
         9aYufY1Ru06U55LvEROfS6+2UxGrb+9mDKFRqaiTIjSf1oxOAblhm7efgEo0P1/sb3X0
         ZsQnPaqczreAhgy8kgQN726YsX2tuPN5SxuF9UZkQ9jcbWsi/Iz0Z6o7uR4ogQGT0qk8
         38seWthpFFz71K4sCPv8MFrm6jtNM5PgU2f869R2sdLkICRA1uLtsQt2lX/9kLdtzhzG
         iUotLUPpq6a93c1UqsdF5o7ELt/DEQigFBjDoBgZEjzD+oUQXp1qY+vZO/etq0j4m0XR
         Xnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1TGG52htElKPw3whcjO4SkQRukCf83zoz5tsBhwZW7c=;
        b=wPIIbluRa/DRjIFfeMN7OA27yiQ05otlfvSAgWZ5zf8larKxejQL4Ef4ozoEBcN6Il
         UG7sL0Y49hhQ5JL2wj9HgNRjwJlV2gZBJ1PPFGbGgiRV9bK+ryMoQVZlLckIzr1XYB2P
         8c1hsq5s0Y5aeJDqbANSdHGU9p6Ts1mwdFEcu9As6h5UMcZlEFv897wQGASLiLtQhXGn
         yEACHLmh2wqCzV3uvLzB24I6IlxA7yCdgea4hgYYmk+VLCgqUsLxCWMN0lXIxT3RuJS1
         JAt4mimorZ9bgl+WsejQJadt5inFGnPvwAG4eJgMGxAUGypqv+V1zUTkGr4qbmFODWaC
         PLWg==
X-Gm-Message-State: AOAM533J7Ohflp8yq5MAcp6uO0HQWdKvPwWDxn6nGnGjSlVxcnZ3stZu
        tvcAMdDL2AZ8zI8G8XXhbJbnC0wq1LNE
X-Google-Smtp-Source: ABdhPJwlBmcXot+XYiQIT2gfaWzYWAcfqbTiwB91CaO437KUkKf6GEJlCxXLTq8EQODv72Xz+yHj6Q==
X-Received: by 2002:ac8:588a:0:b0:2de:2dfc:77a5 with SMTP id t10-20020ac8588a000000b002de2dfc77a5mr25233824qta.357.1646254710247;
        Wed, 02 Mar 2022 12:58:30 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f19-20020ac859d3000000b002de4d014733sm70456qtf.13.2022.03.02.12.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 12:58:29 -0800 (PST)
Message-ID: <1ff00775-c6da-2616-4032-9eb3a453669c@github.com>
Date:   Wed, 2 Mar 2022 15:58:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/14] tree-wide: small fixes for memory leaks
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 12:10 PM, Ævar Arnfjörð Bjarmason wrote:
> This is a collection of various otherwise unrelated tree-wide fixes
> for memory leaks.
> 
> In fixing more targeted memory leaks in specific areas I've run into
> small leaks here & there. Rather than submit e.g. a 2-series patch for
> just small bundle leaks, the same for range-diff etc. I thought it
> made sense to submit these together.

I read these patches, and they were quite small, so it wasn't hard.
The most difficult thing was going into the code just to get more
context than the patches allowed.

Thank you for fixing all of those memory leaks I introduced in the
commit-graph code.

I had a few nitpick comments on the first commit message, but I
think what I pointed out in patch 7 might be a problem that needs
fixing before this merges.

Thanks,
-Stolee
