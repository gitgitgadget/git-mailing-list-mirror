Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6218DC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbiBOWVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:21:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242968AbiBOWVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:21:48 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D92F22B34
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:21:36 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lw4so219127ejb.12
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=50FG3Pk7qjwt+HE9OYGl2Zb+v4Zkf1j2iw2jzqtcJYg=;
        b=K0fFnx0WRbcWRaitWlYYGEgGDc97jk3hPQyVLwk9da1NPMTzT9R/uKvvAdn4jYDKvl
         3H+SQemn6p1nFiyFijmkhi1lSCuKdbsXUm0ErTMZechv0PCviDimLjUjL7xSnyZyNdBK
         MuYcfuWJUPvtRl6euOWwmzxZ12aDnwXx9KFNvDKZNCTRcNfhERZfFfBMBmWJSKsoVlyB
         wGHnTsMeJvN13hvYIstZNP3klxttKU0ddXn7GNhlYB//LRS8h1q+ptZa7vJogZkhuPaO
         q5vsMUJmgXOUSPRqGESKBw57v3Lr11+GmNHC8YrYCewWtyRWtOUcYG/F3cH6co/eyUuQ
         rAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=50FG3Pk7qjwt+HE9OYGl2Zb+v4Zkf1j2iw2jzqtcJYg=;
        b=KtsV7avchP/YjjCz+fP4RqfGrZu+YxTNj2fUb+zAGWr14HQw21efiluHaKbTrICvfx
         c7P0NGffMQAwbBb4FZb2urYTZUpXexcHcqIG06O76y7LGK3wD0iXDrCQ+LiGax6pwslx
         ywR08KMFA5D9Z2KNtuqUuVc3OpmF1CnFeX02WGqcQm8JzZNLKHo77EHnP2T/gwEqZTj6
         8WyrNHHv7r67nLKIycgcYRnP5cFVYsrjKU5oGyms7WGvp2Pt0cmXDELrkzASPAxm1gxz
         jeFAf6C9vw7TvFZwWoOmpkl7ZhQQ23lrXl7fDpZX7U3VsIjcKdH+pnDREnAx3prRbT4d
         5L9g==
X-Gm-Message-State: AOAM533oDJ7TG3kJr4+Q+m4/xaorjp+gOm1wwImcr7YK1dZO81n4L/fn
        1SHndW49s2zSuBQBK1wHKnU=
X-Google-Smtp-Source: ABdhPJy7QUIHRIA8dJ9T3OAdbRCSDG9jF6nOJRqlCQmLG9APw0fntf6O7nug/f7F9KNVqPNZ9kytTg==
X-Received: by 2002:a17:906:698a:b0:6ce:b983:babf with SMTP id i10-20020a170906698a00b006ceb983babfmr51980ejr.553.1644963694764;
        Tue, 15 Feb 2022 14:21:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a18sm554390edu.31.2022.02.15.14.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:21:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK6CT-002uMC-Nr;
        Tue, 15 Feb 2022 23:21:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: ja/i18n-common-messages (was: What's cooking in git.git (Feb 2022,
 #04; Tue, 15))
Date:   Tue, 15 Feb 2022 23:17:56 +0100
References: <xmqqk0dwyrcv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqk0dwyrcv.fsf@gitster.g>
Message-ID: <220215.865ypfwz2q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 15 2022, Junio C Hamano wrote:

> * ja/i18n-common-messages (2022-02-04) 4 commits
>  - i18n: fix some misformated placeholders in command synopsis
>  - i18n: remove from i18n strings that do not hold translatable parts
>  - i18n: factorize "invalid value" messages
>  - i18n: factorize more 'incompatible options' messages
>
>  Unify more messages to help l10n.
>
>  Will merge to 'next'?
>  source: <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>

The changes to messages etc. in this series and the previous ones all
look good.

The one reservation I had about it was the addition to the
parse-options.c API:
https://lore.kernel.org/git/220201.86a6fa9tmr.gmgdl@evledraar.gmail.com/

I don't mind if this goes in as-is, but would really like us to give
ourselves license to make some generalized parse-options.c feature (like
the OPT_INCOMPATIBLE() I proposed in the linked thread) not need to have
the semantics introduced in die_for_incompatible_opt3() and
die_for_incompatible_opt4() in this series.

I.e. it's a lot simpler to just die with a message the first time we see
that --opt-b doesn't go with --opt-a, instead of needing to continue
parsing and finding that --opt-c is also incompatible with the two, etc.
