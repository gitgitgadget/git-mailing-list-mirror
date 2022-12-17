Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB4CC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 14:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLQOu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 09:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLQOuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 09:50:24 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8191C140CE
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 06:50:18 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id p24-20020a0568301d5800b0066e6dc09be5so3020086oth.8
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uzZ/FWoWnl7KLjBTNH/YrnUGxwYdhTH1uxUKcpcFFDg=;
        b=RuG2/m0qjXHT/QQ/uGJ+wMwJCiBr3EAJGm7TsRYe22Dgyg9x1q4JHZupfmkRnkDLJi
         TxU23RlsU5W5s7RFHPKzqT48yeH+QjOD+nyeJ9oW8tUZCTzeWD+yExKJMyWJfOOvFP1Q
         rwiUPDEq7/Hy89vjyJl/PKhYpkxdNS9Utazi0sFsPkEmdD1zbP/LAPuwagD6MrWjDtdd
         x0RfhXrmXWpaOLwNhExcLU6fMB7jV1snZtiq3mFuzPfPt2Zz8nAqPJeX5RICzGRe+ovD
         Twsn8ybAKaWVba97PcQRrltz92BzKzH6rNyCPCYElKd/gBg6//64L7OHzBge100NeDy5
         9ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzZ/FWoWnl7KLjBTNH/YrnUGxwYdhTH1uxUKcpcFFDg=;
        b=ogXe95izhZdD3nikSqhADMwmXzgccAl+55617l3RmtpsklxshPVSPw4inRuJxdi7yo
         AhOqhy6sxbCnwuVKpIqurNiPMef+VA7i2B/i3j9Fc5R47FurI7D7oULGsv1+3W1fNL6q
         HslaH4Nwyirgz8Uk5jYNP4J6RcgENOyboXhDcEnK29bcxwreSTe7lwqqFKNc1UTKgK84
         2Lu+ImUEWFqx7O8yw58CTE8YTSbNdXISQ/H7uh57TClbziHsa9mJJjbxs1ec/ijWSJ9N
         LtqVZ18mxzjqAxTL7bMiUnZBQk+QOUmxZDz52R8EFJNuPx+pG80hcfe7AoP3H2fSYtx0
         n7Dg==
X-Gm-Message-State: ANoB5pkffNZZSnUMz9eYEi4FDoK4kL7uJRzPkjCyiJ2iROz0PQ0gkD3N
        XhWQuqcxY0DhSNqhqOa128E7kmnkxtucAIf9KlQ=
X-Google-Smtp-Source: AA0mqf7be7MfBX/Sy86x06cNIZ+UVgAuLXeMO8fq1cY2kaXTGS+V2uZBd8k5Nr3bX6kD5Rw+iH7NiooVRgbSASx+LFU=
X-Received: by 2002:a9d:7656:0:b0:663:c86f:7573 with SMTP id
 o22-20020a9d7656000000b00663c86f7573mr40799443otl.187.1671288617805; Sat, 17
 Dec 2022 06:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20221216093552.3171319-1-karthik.188@gmail.com> <xmqq8rj7kk0r.fsf@gitster.g>
In-Reply-To: <xmqq8rj7kk0r.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 17 Dec 2022 15:49:51 +0100
Message-ID: <CAOLa=ZQ=9MP3BZLoW9QJXheKZz1tDeLHbAm0dkBbEuEV8tpqBw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2022 at 12:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > Changes since version 2:
> > - Changes to the commit message [1/2] to use more specific terms and to
> >   be more descriptive.
> > - Moved the flag's position in the documentation to be before the unbound
> >   list of non-options.
> >
> > Range-diff against v2:
> >
> > 1:  2e71cbbddd < -:  ---------- Git 2.39-rc2
> > -:  ---------- > 1:  57e2c6ebbe Start the 2.40 cycle
>
> Does this new iteration use something that was added between these
> two bases?  Asking because the choice of new base is questionable.
> I would understand it if the rebase were on top of v2.39.0 tag,
> though.
>
>  * If the updated series depends on new APIs and features added
>    since the old base, do rebase on the new one to take advantage of
>    them.
>
>  * A bugfix patch series may want to avoid using the newest and
>    greatest if it allows the series to be applied to the older
>    maintenance track, and keeping the older base may make more
>    sense.
>
>  * If a series based on an older base no longer merges cleanly to
>    'master' and/or 'next', but rebasing on a newer base makes it
>    merge cleanly, do rebase.
>
>  * Otherwise, keeping the same base is preferred.
>
> When rebasing is appropriate, choosing a well-known base (e.g. a
> tagged release) helps others.

Right! I think I just have a habit of rebasing on top of master on a general
basis. I'll keep the old base and modify my tags to make sure the next
range-diff
will use `2e71cbbddd` as the base for both ranges.

-- 
- Karthik
