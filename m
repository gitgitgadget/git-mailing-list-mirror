Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF6C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE664F3A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhCQSQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhCQSQS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:16:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC558C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:16:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p8so4125085ejb.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dK2j3pIgJ62qgt654zyuUvJE7DpfnyPF120ITJA4nkk=;
        b=GGGGRv9aVStF53ib1+hVFrUOnhiue6u4BwoR902UdmE6+F1HAej3qIvmgx2ea0Vue4
         puFyZoNmKGZ3eQgIRr2pJQQrxcNO0vPKvy2FrUz1vXXso3De9wuQ+O/L5FwSaxNtj+o7
         hnSuJy1aj08WIa5tyb5JTKxI1yX1mMCst/cG7pGhJrW9b3djckWGE5D3PJghI3uJvdi3
         kmJP2EG515sENeD1BnKmE/NLtyyTiRMCGC4icbu02fHdmApIjqEMqW3e2nq0wLm9vF3h
         VnYGC33mjdF5NKF4A3c6WBBzhjnUswg6+hQTLiYbxvfIVW5t3LWlOk05/EjgRzsk1Wpx
         wuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dK2j3pIgJ62qgt654zyuUvJE7DpfnyPF120ITJA4nkk=;
        b=NSjIQyVYzVNI62nL97/z60qIyNbrHxNhW51w1U3yuKhrMpSmnJjbVBhT1RLfU9wU+i
         sgVQn2hluvIPwIJS4K0l9MAsRL9hjq6rtfZly/ZR6NPHq4k0T9B6PHtUSekD5J+X6IED
         JxhFBGZknufAihHgw8d0UWeWwRPi+D/Y1YK+TfGOrjHdPTqNZUzsbBBwD3pFP0HSS9bV
         0tAUQZrW1ywenhVUG6zUjx1dsgUfgNgE6zEKiKHNMmYboNNO7JnL/Jtai0eipzcpoGAf
         yJtm9PQwLBtGplbJlg+MKMYJkPjuqIcjZNiiddgQiDOok6JLvffAZyv+44CNlmruqepI
         Yr+Q==
X-Gm-Message-State: AOAM532SdaasTUOQqUfKoJ3yRYDvanWCamTeH40ViveyJuGm8FjjlzdJ
        dAGYPYD02z9ODlIC2FHDBDI=
X-Google-Smtp-Source: ABdhPJxjeArhZpsUHfSBQ8zjcHPOY4ElqXu//FUyZgJuLXd+uWaT7dxQ6IPTjKjRUxrjX7gUzTZrzg==
X-Received: by 2002:a17:906:3488:: with SMTP id g8mr35858547ejb.282.1616004976582;
        Wed, 17 Mar 2021 11:16:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a12sm13415101edx.91.2021.03.17.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:16:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
References: <cover.1615856156.git.liu.denton@gmail.com>
 <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
 <87mtv2dk18.fsf@evledraar.gmail.com> <xmqq1rcdy7zo.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq1rcdy7zo.fsf@gitster.g>
Date:   Wed, 17 Mar 2021 19:16:15 +0100
Message-ID: <87o8fhzlw0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> +	./check-sort.perl '\t\{ "[^"]*",' <git.c
>>
>> This last one you can IMO be done better as (or if we want to be more
>> anal, we could make git die on startup if it's not true):
>>=20=20=20=20=20
>>     diff --git a/t/t0012-help.sh b/t/t0012-help.sh
>>     index 5679e29c62..5bd2ebceca 100755
>>     --- a/t/t0012-help.sh
>>     +++ b/t/t0012-help.sh
>>     @@ -77,6 +77,11 @@ test_expect_success 'generate builtin list' '
>>             git --list-cmds=3Dbuiltins >builtins
>>      '
>>=20=20=20=20=20=20
>>     +test_expect_success 'list of builtins in git.c should be sorted' '
>>     +       sort builtins >sorted &&
>>     +       test_cmp sorted builtins
>>     +'
>
> "LANG=3DC LC_ALL=3DC sort ..."
>
> I like this 100% better than the original ;-)

We don't need to use "LANG=3DC LC_ALL=3DC sort", the test-lib.sh sets that
already, so just "sort" works consistently.

It's also why with GETTEXT_POISON gone we can just "grep" output,
instead of worrying that it may be in the user's locale.
