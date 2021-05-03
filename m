Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57984C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E3061186
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhECFvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 01:51:43 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38410 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhECFvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 01:51:42 -0400
Received: by mail-ed1-f52.google.com with SMTP id n25so4932763edr.5
        for <git@vger.kernel.org>; Sun, 02 May 2021 22:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNpGybmwJR/J/62dOIewRPVL5sLADziJXbt1Mo3ALYQ=;
        b=LqWPR0kfRDmTMqKLdhtdJ4yMB1x5t+md9wy5q2Y0EMKe+W944kVxkTTKM41a1H56zh
         N54aaQNZ95+shfPMX+GEHeWVrmiMwLcjtQmQloc8b6Qm1nsZqhrjvtr/2msL1DMNS8CO
         tC+PCS3/V6yjeSpGbDI1qSs0XorujSUi75pNRb5DoQQjACJb/KBjJmOTUoIveKOlzlcC
         EU33k9eoa96FiKWIRDUT8mAXOtzH56GmCbYnUAZpK3zOpJdSHXmckiZAL/Kd6VzOWp3G
         Es5o4HP1YhmB+sBiXal4AQjoB3RTrQ+WuEvhzmIdJkbzq2FF/vcPn1ws/EkuC6VclJ6O
         i+Ng==
X-Gm-Message-State: AOAM530oystx/v9g0rf7HwV9nu+3a3RlPWxjkPDAvVI6HUoXEBoHxMWB
        gCAKDys/nuL61z9QPk5l4OVsS6wINkpCvn9w3So=
X-Google-Smtp-Source: ABdhPJxstpjY8GISK5Vy9UUZ0EFPQ9mjAEor7dXywHOWGnjelz7t9YMqdBPod8BvmZ5RtJHrfpFLACEMzgC2Ktlg5qE=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr18439309eds.291.1620021048103;
 Sun, 02 May 2021 22:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
 <20210502051423.48123-1-sunshine@sunshineco.com> <20210502051423.48123-3-sunshine@sunshineco.com>
 <xmqqwnsg8kaf.fsf@gitster.g>
In-Reply-To: <xmqqwnsg8kaf.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 May 2021 01:50:37 -0400
Message-ID: <CAPig+cTf6bTpqpi2b27N2jDd_cS26VC6M6GcTRB_FSAn3m5CsQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] merge: fix swapped "up to date" message components
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Josh Soref <jsoref@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 3, 2021 at 1:21 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > +     if (verbosity >= 0) {
> > +             if (squash)
> > +                     puts(_("Already up to date. (nothing to squash)"));
>
> The original scripted Porcelain may have said so, but the placement
> of full-stop in the above feels a bit strange.  Should we rephrase
> it to
>
>         Already up to date (nothing to squash).
>
> as we are fixing the phrasing now?

I don't have a strong opinion about it, and can go either way with it.
Josh's patch did place the full-stop after the closing parenthesis. I
can re-roll if people think that would be preferable (unless you want
to change it locally while queuing).
