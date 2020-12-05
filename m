Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D57C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FD422DD3
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLEB3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgLEB3S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:29:18 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7647AC061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:28:38 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k14so7035060wrn.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZL4kSuQfHRhfAaHZzKW1rBJuCZbFMXAuUEcdZMw1oM=;
        b=UVwA6kIEO2mlEThb9kD28BI1y+IEgLVV5GUJ3lldFVgEtOd9mwuetSAu/7Nrj0W0Gz
         t84sqNPkFcqC641EirGoEXG9tjr0WpKEN5o/k1bYVMcpIDzV+7Y6DF0rEgOz/r05mtFh
         sfPNZIi2cTJqxukH011p+wdrsEDfezN0laIEytDVAbBDK0hLwvw/kOAqHn2BZxZOM63S
         4XhaicaYExXn1hwyTOnXH31Eee0X9fVW205I/SBE5pbrl2IgxgZNTt/VOxwAMYLD5Y6n
         B/eNxW/XHJeYCXRqV8Zaoqe21EaXGlflKOq2YwQw0s3rqjF5ldBwEzABk7vV1txALD/B
         t03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZL4kSuQfHRhfAaHZzKW1rBJuCZbFMXAuUEcdZMw1oM=;
        b=YYQTpp1uXMcdT85oIM5I/v/aY3HmKdp+h3K9IjNHFkz/9gqsvcosGaL/HV/zxUot4t
         tbCid87pVyGIlem5icvpP6lI20gq/M1yVPnohWdbnT1NulMx3mPKE989Vf0noWNyVb5I
         f9fbeMiiECTWPuF9iKplA8RtxmLLbYbcNWTwUsoF6jkvxwLrMLK8g2q+jVgj6QxsRu0V
         TRtt9y1UxFS5T5XOqOocQM/GOjiJID8gLtG7opDzwRv4RJHutpR4XH6/Ld0s2gamQaWJ
         imqU4gbB7xZR2HPAKd3cC2ekRCW4HPMifjjqpood/IvWAI3vqK36HreywyphVCwWSWic
         PgAg==
X-Gm-Message-State: AOAM531nbsNFlh9c3hPe1KoyUd8gVO+P6ptgYaU+QQKj8ftEx6UOsZ93
        y/tdgoZ9WeI7iMkN9NGhouF7JZ5MIbDmXEFeVus=
X-Google-Smtp-Source: ABdhPJxby0TGc9UfX7sgwi3IfzcIrHst/74jjZJ/aVnIWGlCXI9jpl+iCiLmGljIQNobdJewcGqMATVK9OzH90DIlOw=
X-Received: by 2002:adf:e788:: with SMTP id n8mr7789583wrm.84.1607131717209;
 Fri, 04 Dec 2020 17:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-15-felipe.contreras@gmail.com> <CABPp-BEfxvkuVsDR9duwg1QCMxV9O4RqGF_rm2NuiStczggQoA@mail.gmail.com>
In-Reply-To: <CABPp-BEfxvkuVsDR9duwg1QCMxV9O4RqGF_rm2NuiStczggQoA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 19:28:26 -0600
Message-ID: <CAMP44s1-Q=3AN8o03gncQZtExewYqwvKos1o1k1Ap8CcGKn23A@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] test: pull-options: revert unnecessary changes
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:49 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Commit d18c950a69 changed these tests, but it's unclear why. Probably
> > because earlier versions of the patch series died instead of printing a
> > warning.
>
> Another case where log --pretty=reference notation would be more
> helpful in referring to commits.
>
> Looking up that commit, I see that commit made a number of other test
> changes which seem to be better motivated by the commit message and
> code changes.  I wonder if we could make that clearer in the commit
> message somehow.  Perhaps
>
> Commit d18c950a69 ("pull: warn if the user didn't say whether to
> rebase or to merge", 2020-03-09) changed a number of tests in t5521
> and added some new tests in t7601, but it is not clear why the changes
> in t5521 were made...

Fine by me.

I had a mind to do some mail archeology and find the likely reason
myself, but we all have limited time on this Earth.

-- 
Felipe Contreras
