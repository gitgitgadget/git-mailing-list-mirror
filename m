Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616FBC1B0D9
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D92D239D0
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgLGWeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 17:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgLGWeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 17:34:14 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E608C06179C
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 14:33:34 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d3so622000wmb.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 14:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdGFE3zNht6lIUwCb2nutFnksNqmlNN+xzCyNqlDK1E=;
        b=rh44smeEj9wzihUfgLNJ8Qq72SkFjmrJt/juOKEuHjMikOWJMA4JUayS88dYa2Kcl5
         IzCr7Obsh0bbxbJ/S2jW1CUG1qNHjT0oOxG/CHAtPTMdh9ASJchmihxKqUYagMcCJowl
         lEbGWKkFvXsVB067UrYLHaSpMVDQFAcCE+XWWYm5QwSrNFn2H3ImKcAqiHe42edw3Miq
         ueI5w4q1HdyHwSh1fi5wWJU1RSIuandtaKDZTkEcmukD13qNAdSXErgI+LUscBrhG6vF
         N5ymBq97UeZ1uknMLWR0D+5Vv0g3NtvlcW+85wkckOROwVcQVSHX0Kwx0hLo/8nYg+zY
         kylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdGFE3zNht6lIUwCb2nutFnksNqmlNN+xzCyNqlDK1E=;
        b=VuBV2NS+IzMKaVScm5LHzwkoUc8Cw+2yIrBPtSgpP1I0kIeAYAQluUt6tyi4esCtV/
         2qJdkLk3L8aD1vRp0q7u8XQXoCY7nLe/KVwXuK5Sx8wvXpUqmdYzrFqf0txsf54nqEv7
         2//cphqws6b2z+ztTrhG0xRaY1F4ylxWsdIJ+RrO15Zx+k8bp8C9K5FGnQ6YzGAMzZu1
         XI8xRbVqgvkLUoVGsvWt2iIVsaKCW44oQK/yibV3BfBX8r6PyqXE4Sj02qutzxhexYju
         l0wFCB3ySq64FaNH/QLr4MzXmOfklVHzvnKwkeWzf3xeThHncnXLR8NGEC5mNxH1EU/9
         51eg==
X-Gm-Message-State: AOAM532fB0kKV2T4c16kU7tNwMZnwLh1/2ErZK4jppwM0X9OHaSXTfnw
        jTivRmAgFpEanOeRBDUA1aq9kdtB/gwz3+pL7Fo=
X-Google-Smtp-Source: ABdhPJxsdhZ4IKxv4FQTkfdKRR4x7hOHyHbY9UHYGxFN1gaN1IRg+rPkvu4o7NNTOQTV93RFEoXb4pdcZOikZcSIfP8=
X-Received: by 2002:a1c:6008:: with SMTP id u8mr903931wmb.173.1607380412876;
 Mon, 07 Dec 2020 14:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20201205195313.1557473-1-felipe.contreras@gmail.com> <xmqqwnxt8hev.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnxt8hev.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 16:33:21 -0600
Message-ID: <CAMP44s2sDPT8mQqSuUZ7HaN8EBXOdKBkU5t4-1k6EZfmRa0Mow@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] pull: default warning improvements
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 2:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > It is not a complete solution, but should improve the current situation.
> >
> > Since v2:
> >
> > 1. The warning is updated to say "a merge, a rebase, or a fast-forward"
> > 2. A suggestion 'If unsure, run "git pull --merge".' is removed
> > 3. A new REBASE_DEFAULT is introduced
> > 4. Tests are revamped using helpers
> > 5. The logic of --merge and --ff-only is updated so one can override the other
> > 6. A bunch of commit messages are updated
> > 7. A memory inconsistency is fixed
>
> On what base has this series been built?  Applying to 'master' seems
> to stop at the "refactor fast-forward check" step.

Ninth batch.

The 'pb/pull-rebase-recurse-submodules' merge is the one causing the
conflicts (I think).

-- 
Felipe Contreras
