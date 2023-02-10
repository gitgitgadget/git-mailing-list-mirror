Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA1C6379F
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 19:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjBJTpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjBJToc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 14:44:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE5FF2B
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:43:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r8so7579222pls.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HE6nRbGaDGOM4GvRU44amWQ5/0dc8ljv/JNX6nWREQ=;
        b=T3bPdBUzTNIFSLsrBcOAXO+aYUCZ91V5Nq/Zded8N8bGAVs2kpubmW7901MQiZUrWD
         HXnEm7II4L5mwMwTHhbb8PjPFK3GPRYnLvli743Si5jtcc0xukBZdbWaw6OPAjtdatdh
         8ivv43QWzw6SxcWi4Pc8a2UJQ/IP/z736I3A0YYdiIib56/DlVgM+jPX2YA04y5btYmL
         Rs1Risl+m3wdwO5nfBacjgAyTwGacOHGshpCcQrN5NYd6iJdKRA6PsyVGQoXLcqlpXKa
         PXWCj7Yb5OIVU66U6swUJ995ggcGyp896gT4O0OCMzOGclOhnN5DMmyh3nd4RFF3cBwl
         rTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HE6nRbGaDGOM4GvRU44amWQ5/0dc8ljv/JNX6nWREQ=;
        b=JaeNB4hht7sFXPxZHiE7Ps8pyc98m0L3PAWn1N4HhNElLxo1wamtZhfaHowmpsZf49
         vorSuUMSGMC0DoIpS5LJ7C6ThVEChP6U5C3ewsnOXvb+0wprZZcUjVw8mH0QRI0WH8Dm
         /kdCA0pkAb7f9uPfVyjR4/QA22B0dYQJe7zsTDviqwvdYyyV/o84Lo79pk0lTk8BGcay
         xvpuc6hvG/I3wdkuhr9DzKei7gcUJfBDtk/HesBtYb3EcHh8NGQib16wj5+60vjfJgnH
         AgVo80CvXEyGNLIeFrZT8jxIkAJu45bXk2YTjIVd5eFYDu9FNXRWoElwc2hFfTdzwczu
         BThw==
X-Gm-Message-State: AO0yUKWNI/Jrsen1KPtQu1ktWcHCd5XS17ia5GKIyfm3oXK/aSOGybZn
        qrffwdlJr6qN7zee9BA87H4=
X-Google-Smtp-Source: AK7set/w5ixl7uD5tGWqGcBN/ekKYZEhMfbKZeHRoyPb3wmbcILWa/qccW1D25BQPvrC936fhV+p0Q==
X-Received: by 2002:a17:90a:7f98:b0:230:f874:3600 with SMTP id m24-20020a17090a7f9800b00230f8743600mr15652540pjl.28.1676058162989;
        Fri, 10 Feb 2023 11:42:42 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a1fce00b002311a83e333sm5026237pjz.44.2023.02.10.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:42:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 6/6] cocci & cache.h: remove
 "USE_THE_INDEX_COMPATIBILITY_MACROS"
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
        <patch-v2-6.6-77c30cfe455-20230210T102114Z-avarab@gmail.com>
Date:   Fri, 10 Feb 2023 11:42:41 -0800
In-Reply-To: <patch-v2-6.6-77c30cfe455-20230210T102114Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Feb
 2023 11:28:39
        +0100")
Message-ID: <xmqq1qmxi9xq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Have the last users of "USE_THE_INDEX_COMPATIBILITY_MACROS" use the
> underlying *_index() variants instead. Now all previous users of
> "USE_THE_INDEX_COMPATIBILITY_MACROS" have been migrated away from the
> wrapper macros, and if applicable to use the "USE_THE_INDEX_VARIABLE"
> added in [1].
>
> Let's leave the "index-compatibility.cocci" in place, even though it
> won't be doing anything on "master". It will benefit any out-of-tree
> code that need to use these compatibility macros. We can eventually
> remove it.

When I saw 2/6 I thought it funny that discard_cache() and
read_cache() was left there.  So three clean-ups (the other one is
the .active_nr member) were done across two patches, which looks a
bit funny.

Shouldn't 2/6 and 6/6 combined into one and/or split into three?

The end result is that we need to write our reliance to either
the_index or the_repository more explicitly, which may be what some
folks want.

Will queue.
