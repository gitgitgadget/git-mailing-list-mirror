Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B563C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 12:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbiBDMiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiBDMiY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 07:38:24 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB1C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 04:38:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m4so19053821ejb.9
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 04:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=znHs7tyruvnCwx//E2mazwQb9XJ47dO0Uv1Ij9Hu2hY=;
        b=nkx4ekB7JjamS5CaTHgB+oDHelia0nc+2oBaClZVTtrKVhzrSSC3wJnKDpcFA0MDs+
         /+RCB9mdnDVV589lLM5zNS1R04oc62Lc++WfWAZ6DaHNPwvU1gaEWSKgYXAS/Fas66pq
         4/FgWvG52yyhAFx8vxsLaNt7+aeMyHFu6S3CybO+9dGlGZ87u3wQjhmvULuFMuJA48MB
         jd6t+EL5pnekq/QhC/az/I8XkiOPX4kqIrUSsAS+RQCJhSQJvzzR3LjSvrg+XAQgThd3
         c/Njg12cfyyDBZRU891EZaXFM4psuDen7DdGxkA13UTf5HyqVwHKCCZWXD6EyxGhGSsO
         sB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=znHs7tyruvnCwx//E2mazwQb9XJ47dO0Uv1Ij9Hu2hY=;
        b=L6OsK4Cuk4bQ+dEQjN0C+s0NdlRElTkrvZt0uzx00WkGHK7X3idU2WEipkNccdq5CW
         POx+G7cGyTIJhjBwXjPbIO6b3AjcKpXZqQDVcPC+3Mcbr/sjPb1Odk3F1z2yudGm7hbb
         PUh4mNif9uweAdqBkNO3IRlCAiqC3WzWsqhX0hNFQatgEF2P7FQdKtSDGPQ8CI+Az5MS
         i0RgL2AExvxorUBErJi/vtB0of/n4XbD8LCc4szzqj0F6ZQBKKjspknuK9mKx1K2hXOu
         dS72L7l8W6E2AassD/W6NZUdv0WzZQ5e/xIJAHyQHwjEe76/r6ZYux5XZl9V7CtPRzc6
         1IsQ==
X-Gm-Message-State: AOAM532HnPZiTiMdUoFFa0NSO9B9bqeq3eq+gvFlsKP+CVAQHt/TPC/n
        D2QelwNPtkCgh2qUkXcNcrc553/vnQVDEA==
X-Google-Smtp-Source: ABdhPJzLNxxLgb+LyTGhIpTuustLgr0X41EN7ZieyK9HjtMf2jfNX2A9FuoboBWhGOwGzvof0B+47g==
X-Received: by 2002:a17:907:6d96:: with SMTP id sb22mr2326842ejc.25.1643978302924;
        Fri, 04 Feb 2022 04:38:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 5sm811882edx.32.2022.02.04.04.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:38:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFxr3-0064fG-Qy;
        Fri, 04 Feb 2022 13:38:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/ambiguous-object-name (was: What's cooking in git.git (Feb 2022,
 #01; Thu, 3))
Date:   Fri, 04 Feb 2022 13:36:51 +0100
References: <xmqqr18jnr2t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr18jnr2t.fsf@gitster.g>
Message-ID: <220204.86a6f63iyq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Junio C Hamano wrote:

> * ab/ambiguous-object-name (2022-01-27) 7 commits
>  - object-name: re-use "struct strbuf" in show_ambiguous_object()
>  - object-name: iterate ambiguous objects before showing header
>  - object-name: show date for ambiguous tag objects
>  - object-name: make ambiguous object output translatable
>  - object-name: explicitly handle bad tags in show_ambiguous_object()
>  - object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
>  - object-name tests: add tests for ambiguous object blind spots
>
>  Error output given in response to an ambiguous object name has been
>  improved.
>
>  What's the doneness of this thing?
>  source: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>

I think it's thoroughly done at this point & ready for next, and the
latest (small) re-roll addressed the outstanding comments you had, which
you already acked. Thanks!
