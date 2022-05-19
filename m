Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA77C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 19:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbiESThW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiESThU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 15:37:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C4326D2
        for <git@vger.kernel.org>; Thu, 19 May 2022 12:37:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tk15so11829458ejc.6
        for <git@vger.kernel.org>; Thu, 19 May 2022 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hY09CQK9VdOrh8pUJemv7dYJBkDzEL64E+krmWEAYTM=;
        b=RoYv631fbj7+zQe1XSIiNiGsCUdH5/CIbhZcL01Otz7tr0Zm8yqoIw8mFWUU+bOpTm
         UVrr0uxIwpLssKV6ilBGrHGMitPUf5OJOgyVbCJJU6WFRBJqOdPwHAtr7kYNTfCWOxZ/
         qKq4B8+vHaj5hmU7UGR2lXaoTU0NGlTXlD4y+68IWtSvSNKosjDmjixeSDY0gLFMdkWc
         bVvb8usmnGg2lIU2sRwLN9IE56sDJP1MXGHIORxgHw0za2pTW25brtkpUjB1CZ2Dooev
         oZ/FhHygd1tY5LM/yWVuO3+amieQt/WRKaT2B3QZloWOz1h6pqgdRNMLOGKzFCzXaBIK
         teJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hY09CQK9VdOrh8pUJemv7dYJBkDzEL64E+krmWEAYTM=;
        b=xjDFD6snN05z6OJjK51murUvQSoAyqDP4+YudJUB8pBlpJdSbNYqq4mfxXH6catXla
         +dPh3/GMp6EOMsnrnLRUpSnVUQ1ttWvzi/Kw6K2RGplsxBgh8V1bc99zbheo5Hraoejh
         w8DYfrYM+XKMRyY9t5LBwVV102GfgFLMKBfVzL+WN/uz3XVeqCmz31CyQT6/PBhvaQuM
         fJSGSpamLmfjqTz95MChD9vKAl3THYDaAu6HfXir3pQAszAqKkOjxJGAeX0ZwjTyXVh3
         bEKQSyqMrszqFyFcGgepzOXhVtBfxo1e2pQGl2mcAHcNPWz8BR6sA5nRDF1liBtKA+qv
         m69g==
X-Gm-Message-State: AOAM530jJUn8O0/pw2+gyUcShtmiKMUfJ6DyFBzwLQpFtTpYBdoXKGJc
        ke7lr+XYXZotnk55+A3tgM1jEO6IG6TKEQ==
X-Google-Smtp-Source: ABdhPJyXvL6qhKU+A3l8lbLHjo8O2gj34wAbb582rmX2+lw9QJY5Huoq+2Zpw/ljHJHBWWUg6k4ECg==
X-Received: by 2002:a17:907:a40b:b0:6fe:7c67:2210 with SMTP id sg11-20020a170907a40b00b006fe7c672210mr5738335ejc.341.1652989037501;
        Thu, 19 May 2022 12:37:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id eb10-20020a170907280a00b006f3ef214e54sm2347262ejc.186.2022.05.19.12.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:37:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrlxT-002ISj-BW;
        Thu, 19 May 2022 21:37:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Alyssa Ross <hi@alyssa.is>
Subject: ar/send-email-confirm-by-default (was: What's cooking in git.git
 (May 2022, #05; Mon, 16))
Date:   Thu, 19 May 2022 21:34:31 +0200
References: <xmqq5ym4zpmn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq5ym4zpmn.fsf@gitster.g>
Message-ID: <220519.86o7zt2u1g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 16 2022, Junio C Hamano wrote:

> * ar/send-email-confirm-by-default (2022-04-22) 1 commit
>  - send-email: always confirm by default
>
>  "git send-email" is changed so that by default it asks for
>  confirmation before sending each message out.
>
>  Will discard.
>
>  I wanted to like this, and had it in the version of Git I use
>  myself for daily work, but the prompting turned out to be somewhat
>  distracting.
>
>  Thoughts?
>  source: <20220422083629.1404989-1-hi@alyssa.is>

I'd prefer for this to go in. As noted in my review I've been running
with this setting for many years, and I don't think I'd trust myself to
use git-send-email without it.

But it's always hard to figure out what's the right UX trade-off in
these cases, particularly for something like git-send-email which is a
relatively advanced tool, and likely has a small-ish userbase that's
used to the current defaults.

But for those users setting the config to the current (and more
foot-gun-y) will be easy, and I think making this friendlier to
newcomers is worth it.
