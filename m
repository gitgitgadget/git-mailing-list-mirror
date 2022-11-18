Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20254C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 00:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiKRAAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 19:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKRAAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 19:00:15 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676E64570
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 16:00:15 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pi2-20020a17090b1e4200b0021834843687so5195529pjb.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 16:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO4mH0sRxPyQGNCIKyIZgqsmfxtVKcRsCgZfPvqhBY0=;
        b=QvZRau0tX4ECT6GV3S+jj41tjMFqKsdLmOhmcAqy8BG5f8uEvqmPRf1R7ifYE/z/c2
         H20Ydah5uYTzDK58XINCMsJI5PbnlXMQMF+bM8qZ/Qn1bvwrFURwvzpzUMBOZs1Sjc6Z
         Ac1FjFOoPczF0Qk9/gPenXJ5DJ82PsoWT7Hbp8AYpcJHOg3IW9NpcG36Q8zKsXe0unJL
         krGF+aptBzTHL2yLoVdeotIkEUQClJITQ8DvmgMzxzlhg7kSnfdj77prvwxBTi2Miq0M
         gDkhFs13KgIAIVzdUHquE1hhFt2swb/bR3jVe0ntXkSSe9WOuPjty9giJ5CySBpWWiwS
         fSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QO4mH0sRxPyQGNCIKyIZgqsmfxtVKcRsCgZfPvqhBY0=;
        b=Br6nw+Sj+GMR0Z6wpMKzHVwAyNPAMQdZ7BcDBmLQEq0CRIM80+BYnVLpmp3FSnJqXQ
         lw1QhYzqWQXTijSlitP8Zp9arOjZbTdkDXnuW5ByKr4VVHdFEfG3sLHsM0Ye36tlD230
         ODlwaBxwsUjoyZs2YIaL+Hn05GwJpmbhwOFKOu0fi8eWqQmzmq0o7LN9LSQH/TeT95QM
         s3kz/WMUvGMnrx0w8eJ5y5HL0vKQxZSwYgeNjm/vrBjpQJIZqU/cYacooI2lvnJ0VVNE
         IllTEtc+3CZnvpvywVFy5G2YnaNywpb1DVThILN4y+3L0iYmf3aMiAvtBTD0hY5IuGiU
         SEGQ==
X-Gm-Message-State: ANoB5pmfA1WAq2N4keZWNn4Z/XDbLaWH6DCsnCPiKG7+xSiyIZXyCvom
        0k1B0HV3sK7g0zuERg+EbrsM4uL+S27B0w==
X-Google-Smtp-Source: AA0mqf5HAiD8HPCF7e9nt9sXdLMEtJScvoO12Vd7Xmy8fGQtOvrcFV7YYc8nFRF+LSFaCdYYFAjvtoZxD3Vz0g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:fa8b:b0:213:2708:8dc3 with SMTP
 id cu11-20020a17090afa8b00b0021327088dc3mr108099pjb.2.1668729614651; Thu, 17
 Nov 2022 16:00:14 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:00:12 -0800
In-Reply-To: <Y3auRnJqHq3pMKAe@coredump.intra.peff.net>
Mime-Version: 1.0
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <Y3aBzbzub7flQyca@coredump.intra.peff.net> <221117.86h6yxgy7b.gmgdl@evledraar.gmail.com>
 <Y3auRnJqHq3pMKAe@coredump.intra.peff.net>
Message-ID: <kl6lsfihgmib.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] object-file: use real paths when adding alternates
From:   Glen Choo <chooglen@google.com>
To:     Jeff King <peff@peff.net>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 17, 2022 at 08:41:44PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This probably isn't worth it, but I wondered if this wouldn't be easier
>> if we pulled that memory management into the caller [...]
> [......] But crossing a function boundary to me introduces way too many
> questions in somebody reading the code (like "is pathbuf supposed to
> have something in it?") to make it worth doing here.

Thanks, both :)

I think the loss of readability is enough for me to hold off on this
suggestion, but I don't mind reviewing cleanup patches on top of this.
