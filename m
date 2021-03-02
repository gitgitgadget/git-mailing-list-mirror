Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD1C43603
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B8664EBA
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447357AbhCCGfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837956AbhCBWNC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 17:13:02 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04962C06178C
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 14:12:22 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id k2so19499230ili.4
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 14:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EeJv+I/ah6G8G+q92r/POP19r3/TisEaUNSKQMrOgJM=;
        b=fr1ib5I/XGE29xls3AG/X2S6cadk6A64TJGYufWNHF0TYhwJlO5oI2JXSZ8H3E83bC
         rfE4AbtO692L83jVq2pPU8bV9GyliJFdZnIllFACwkX6yuSeDvK1f4Ho1Unz5+yGFYrH
         HWzBHbT3BiIh7fMrq/RU5cba54wuoI5o2cTNykyIZaJjDeJUVZvV3RUl++SKFcIGMm/C
         ryS8BjmLuKITUseBrvh4hRD9W5PitUnGpLE//0TAWTUlXyNBENCxSk2P39+QzX1WANEI
         bi0GMZ7W1uDhtFDZLDQowiLV25cB+vmqB/I1o4OY6CfCejUfkRc92/gKWm81LiCdz0Ja
         BDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeJv+I/ah6G8G+q92r/POP19r3/TisEaUNSKQMrOgJM=;
        b=ULoVUA2+Ywoq4PdHRUtfsHpSlRM6uhG8QMNUP5+A7lfEq7THH8bqLlCboBJBHpau4B
         spBgD8PQTh1Txo2sgfof0cpzEaFsHnm6JuPH6WawLRPelUmrBWMQpldQUz6U+6Qqt2Qh
         Tiknq0LrZoHiSDDGIDY2pYSQjJcrt9fK1Y2bMvVp6Pd/o0XMtQcZnPwRkN7WcyjS70Q4
         PupqqG7FzJwl4ceyGCrtcK7Y29Qkn0GsOt/iRyQvNhySULX60KFd+vM3aJtAYS6+cBmI
         Ro7Sv4e+lHhhe8Ep/9KWG0nmQXmM834FmdZuOcbiXY/IO7mZWeiSUcbRvMv5yWQHf6a0
         iMKg==
X-Gm-Message-State: AOAM530sABElhLT4CLUs5n5Seb166PdoENvOiRAWJZTwkW7MqGEHBy/p
        2lw6wucWVsYPzJlmOTI5Q5doN1kC4MJhRhYlPj4=
X-Google-Smtp-Source: ABdhPJztGImTWe08aTtDJDHYp4o4OcsKN/1fJJfHY7BRgDJLOQyuPYAX5a7Z7x8Mw/dVfNB1r+A2io4Mjl5oLOXgsww=
X-Received: by 2002:a92:c145:: with SMTP id b5mr18836869ilh.186.1614723141170;
 Tue, 02 Mar 2021 14:12:21 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <CABPp-BE=9wzF6_VypoR-uEPHsLWdV7zyE13FOgLK0h8NOcMz3g@mail.gmail.com>
In-Reply-To: <CABPp-BE=9wzF6_VypoR-uEPHsLWdV7zyE13FOgLK0h8NOcMz3g@mail.gmail.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Wed, 3 Mar 2021 01:12:05 +0300
Message-ID: <CAPkN8xKTAEfm+1-PfjUPYMf7RhjuwSEb3eESkTQjcWhUDi+7FA@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 9:06 PM Elijah Newren <newren@gmail.com> wrote:
> On Sun, Feb 28, 2021 at 11:44 PM anatoly techtonik <techtonik@gmail.com> wrote:
> For example:
>
>    git fast-export --reference-excluded-parents ^master~5 --all
>
> and then pipe that through fast-import.

That may come in handy, but if certain parents are excluded, it will be
impossible to find them to reference and attach branches to them.

> Other git commands will also refuse to create
> objects with those oddities, even if git accepts ancient objects that
> have them.

Are there any `lint` commands that can detect and warn about those
oddities?

> (But if you really want to see the original
> binary format, maybe `git cat-file --batch` will be handy to you.)

Looks good. Is there a way to import it back? And how hard it could
be to write a parser for it? Is there a specification for its fields?
-- 
anatoly t.
