Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E8C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D9820866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joL61v2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTWXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:23:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37750 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLTWXH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:23:07 -0500
Received: by mail-oi1-f195.google.com with SMTP id h19so5464300oih.4
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XsRYcHjyPcACMhVADGiLUQT1QaIUu5iRGsO2TRXZUJY=;
        b=joL61v2hpHSa1LZ0583wI0sidNC/V+g4su5G5XCtCFldORXqbaJa4cxYlMjxTBW5zl
         dZL7HqtohjFx2EyV+LhnsBdqU3KSpMllrjCndcB1qsCISOSg4AVdLPEkebdG47I005Qu
         IKJCWbtpd/ZL6LCzrW2Wfs/YQIqz4l5YxldlyZrC34gky6meyX24G4FIqwWFQBvbNRud
         idSW+Wu0OT7P1E9TzYlL58G9h31xFoGBApfKvXU0h3FBKknBRIqSMz2ug+L498C6GY3I
         +XTy8aU45V0A5BKqh3RHBhbv6sC5Yhti6E/hOLFZIH+VGVubaRXCRDxg0VzzYEeYlwuE
         qg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsRYcHjyPcACMhVADGiLUQT1QaIUu5iRGsO2TRXZUJY=;
        b=eQ1NF8jJj6szcpc9qWk9eT6g8IUboSzOMytAhnDgnwKwVtLJ484fgpRCvcEq4KGbjs
         kQWlKxzClHQ5MlPdNRiQS8vuV080QNmBhaa+WKumCpoehjVAu5ORtUFTPwNLWhEvg274
         A+DfUreDq/576dD8L158TapvLURPfbLkHRHAvxZ+5p6divuTO7hV0r0DUisWnl0RqJbz
         q75O8MMpwiWeGSyufc54W7oKzjmHBS2X7GQn3/z6UzKilbCiCE3MYgI0WEmU63Ue21jt
         oaBg017bH8Cc+Fnphoo1F27sc/FpPqutvVbKZRJfR/2j3/zGiWKZNye/jybrGJfUNR76
         S0MA==
X-Gm-Message-State: APjAAAXLBNeJo08DvIrS3Ej4L7HZOyle2yf2BQnkZXL7artUG31Fw9+v
        OB/pSLDgbc1BCj3GCqvy3dMqt6OMyQCrwtEMHcg=
X-Google-Smtp-Source: APXvYqxHoZgJXwPofNwNBJXlrIp/Pft5pLpUwJFVdJeVofiVyqPSQlskyJDRrkPUHAjrQ3BLUhgsWB3n4tgHQIJF4x4=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr1115190oib.6.1576880586104;
 Fri, 20 Dec 2019 14:23:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
 <e1870f3fee8be6ebbecdd618ae1803afb878e67e.1576868036.git.gitgitgadget@gmail.com>
 <xmqqwoaq94ql.fsf@gitster-ct.c.googlers.com> <CABPp-BFYyF5RbZVuwo8LtDZZQ9KQ2od4FQqQYaeSqNCNKcZXPw@mail.gmail.com>
In-Reply-To: <CABPp-BFYyF5RbZVuwo8LtDZZQ9KQ2od4FQqQYaeSqNCNKcZXPw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Dec 2019 14:22:55 -0800
Message-ID: <CABPp-BGvh-NvooVE-K-WYpv9RAs4BZ_d0=Mv=b5iEoGbNt5amA@mail.gmail.com>
Subject: Re: [PATCH 1/2] am: pay attention to user-defined context size
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Dec 20, 2019 at 11:38 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Dec 20, 2019 at 11:28 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Besides, I do not think it should be affected by any diff_*UI*_config()
> > in the first place.
>
> Does that mean that diff.context is checked in the wrong place in
> diff.c, and should be moved from git_diff_ui_config() to
> git_diff_basic_config()?  (And perhaps the same is true for
> diff.algorithm?)

So, referring to git_diff_ui_config() as ui and
git_diff_basic_config() as basic:

* Moving diff.algorithm from ui to basic requires updating the error
message printed by t3701.47
* Moving diff.context from ui to basic breaks t4055.6 (which wants
diff.context to NOT affect plumbing)
* Moving diff.suppressblankempty from basic to ui causes no issues
* Moving diff.color.* and color.diff.* and diff.*.* from basic to ui
causes no issues, but you have to move the userdiff_config if you want
to move the color config or else t4020.12 breaks.

In particular, t4055.6 is pretty interesting in that it was a test
specifically created for the sole purpose of declaring that
diff.context should NOT affect plumbing.  So if it's not plumbing by
that test, and it's not *UI* as per what you say, what exactly is it?
Do I just make am directly check diff.context and ignore any other
diff settings?

Not sure where to go on this...
