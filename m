Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C27DC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 04:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356577AbiFVEgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356032AbiFVEgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 00:36:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07B534643
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:36:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eo8so22217619edb.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhNEPiwws1Ncip7zt4j6sanBhuEmhld3UEfWuEYSmko=;
        b=POVPp9/bVuL+ro/lBFMkcBXHtnz18Hp0Eid91ok3ceOoAcSqyCUuw8zbmwS9ka8Qdf
         sdHpfuPSMOGRclEMNbl7ck0jimup8Fa13qaFSKYKnnXkImeUDjb5WcykMLivX8qUcO12
         emKORz0PaIPRaVPx/y9o5ceNahF9c4LQ9E5BZOa66myrEqAbDcTAiXoPKXns0JX6oHna
         RvJo05mrA2JbUk6hPgONN0JGluMk3g+grp9jMcEbeYBsJy7C9reeHl0PVXkAlPpmIKBV
         SWYvsLetYIcEYWrJgd1H8ZJJfQWSYylYG7qjVJsaz/XG4dTyZPe71jtZhyLEUY+7xCTy
         7rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhNEPiwws1Ncip7zt4j6sanBhuEmhld3UEfWuEYSmko=;
        b=EloLipavHWUYhB/Moyg/Ebr2Q/ZMlwKIOtc0gXLGLpLyTBO7neRayLTpmdDLnVQu1a
         H83y/CKNme70YNrcQ1666YEgz3RV49zlYZ8wtj8m3LNJNRyA/ziLQeft4JvZSFv3KfgK
         bTWjDLRJ3/FGNR9X4NNJVLhjhXV++IL48JUXt8vCwcuqwPQy3XsWEDiudQ1YnbA2G41X
         sWKst68JiUTkSCWOI34qShdvnxVL9qu9pdokrk2TwpsyxzHDVmYaAoGXtqw0/DcTQleI
         rMF8YV05EydWPRsUSxpKJXbpLcAezHyVBwBGGn4tOvze1hsDD7aFmbC6k8IOoLZCt8vD
         S95g==
X-Gm-Message-State: AJIora8TkN1S2q9V33Okwv+aTrcU4iRV3TuEAkL81L6jkEICG8HI47vw
        E5tDoHro8EJy1hHF39gS9hdJwSZddBa8AtZGpvjABz4w
X-Google-Smtp-Source: AGRyM1vJ0JeUwpjnS9skaakYVaa816B2LuFAGkonVWSBECLMctSfcNsVejFGpbkMcUTJRN9oSaQW8KPCNLQhD4o1ARM=
X-Received: by 2002:a05:6402:27cb:b0:435:a360:5e9f with SMTP id
 c11-20020a05640227cb00b00435a3605e9fmr1823989ede.323.1655872574403; Tue, 21
 Jun 2022 21:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Jun 2022 21:36:03 -0700
Message-ID: <CABPp-BFiw3szsGDkhN4+Q0_JDNkEQoB6CuGj+39ryL7ToNgP1A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix dual rename into each other plus conflicting adds
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 9:21 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series adds some testcases based on the tensorflow repository issue
> reported by Glen Choo at [1], demonstrating bugs in both the ort and
> recursive strategies. It also provides a fix for the ort strategy.

Also, just to be clear, this is not a regression since 2.36.  It's
been with the ort strategy since it was introduced, and with the
recursive strategy for a number of years.
