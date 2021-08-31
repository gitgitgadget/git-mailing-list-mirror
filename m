Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C918EC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA0161075
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbhHaQsQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 31 Aug 2021 12:48:16 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:37600 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhHaQsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:48:15 -0400
Received: by mail-lf1-f50.google.com with SMTP id l10so125635lfg.4
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 09:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h72cu2sgv0hcc1JgWUZtG0cZ9il7+uM4F8n24rNCGNQ=;
        b=YSDLssmCHMlQ+SjUTjtNioqB9mOInkRFZqgl53RAp4VJ/OffOlmNxE8HuhmciM2LyG
         uvNYSfVrNyZGKNn57K9GgRBPv5H8i/Sa+Sso5UkCRqU/OeAOgB242/NQc/YCPhT0YnDu
         IeDJyzyo4zmSxV9AhxBe/YDmNCTDCNTDM3OBmRpp1+T4zdwjCcvO6UyfpASrdGtfaj/1
         qGVYo1xfeVT8qvVQnTevCOfnYDk7fhjLaWydlhvaPzg48WHJDyYWUs+L/nFVVejtDd5j
         D5BiNX1KIkpgWS3la6hAnwcKEcrgKiFJiLauWBq5Bl9ZDyL9S8p5/HA6003gsL0f2NmP
         jQqA==
X-Gm-Message-State: AOAM5330vZw7CC6uKrxYeB93ysXrCTFkss/hk/JbjWOMoLOq3Q1xi8T0
        n3hJsuZ+ctRwssQoVFrLSRILNlR4DgH5S8kTwTvIhwZp
X-Google-Smtp-Source: ABdhPJw2M40EKs+Au45jSJBHRTPxXI/Y42Y0II85K0Vn6wK/SR27XgoxEcwR5hG2jtFQWuAw+2T9PO/PMAraFcHYVIM=
X-Received: by 2002:ac2:4e45:: with SMTP id f5mr22583551lfr.628.1630428438744;
 Tue, 31 Aug 2021 09:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
 <87a6kyxbo1.fsf@evledraar.gmail.com>
In-Reply-To: <87a6kyxbo1.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Aug 2021 12:47:07 -0400
Message-ID: <CAPig+cSy=mps-b3HWZSC7WcMaYV_H71BVRK5b0cSy2fA0ogJ7w@mail.gmail.com>
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 8:04 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:
> > Note: We intentionally use a slightly wasteful `set_config()` function
> > (which does not reuse a single `strbuf`, for example, though performance
> > _really_ does not matter here) for convenience and readability.
>
> FWIW I think the commit message could do without this, that part of the
> code is obviously not performance sensitive at all. But maybe an
> explicit note helps anyway...

FWIW, I also found this distracting; it takes the reader's attention
away from more important aspects of the patch. (But it alone is not
worth a re-roll; it was just a minor hiccup.)
