Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848DCC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C3F6109D
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhFQQvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhFQQvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 12:51:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E247BC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:49:08 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c13so7166392oib.13
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzKqfOJdvY/cDx6fZvasvTUgbtSbbZXQsLGb3BtoGhQ=;
        b=eUZVbrx0Iv3ozZLetzwIPlqYES3OZmRzpA/tfDUqiHzflSc/enslzJMy1hMBcMwcb9
         by7qjDh7NZGBY7PgWUpCvWPFFhP8+wW68lptylnCpwFXN4b/CoGc+ACnnKr/5DPV5q/k
         OKJPzLFhQXpnjIWofFGBR/aAdHIr4MlO4bO/07P4ezWBaGkEVWp6wowFUruqAsY+nVHl
         LBHu5ah8Jsj62Cb5pH6LdXm/l43Q3L5wvaiYls9W6hpzw9x1WLPX2Wv/CN3EZyDdxXpL
         lDzxXUaxSWa/eUmqH0PDb3aN6WT0hiH7xsAcPAemYmhCXy7zH/cVeodEul43PWgkmy4z
         h8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzKqfOJdvY/cDx6fZvasvTUgbtSbbZXQsLGb3BtoGhQ=;
        b=bZtq32IbgnBKrtDOOtpAfcq2iox1eN+gP8qJqvYSTXwiA/a3RDdonfiAgJIrffM0NW
         ot3Q/5ieMS464vNVrdm6Wkt93CCxnq4hJ7o4H0OrXhPgEzv0ogR0H0/5aeiEyDz3Yb59
         3xMH9bMjYktjUzvJNQt4cRF0Iwdm9q/RHgTKZVtT/ymuUfQAdcrHWKUhiJwNEZbEcXch
         UYo7oxsSUkNluC9Gdrtl1ApxSPF1X75P7VteAJp1AI6609lM/cnuP1NBGBzedRV4urqq
         SFxPvW9JSBOfDirdfqYHaC1EQe9s5oV8ZG54cjQovhDycXdeCnOnc4J530drGr2cAWO1
         JFmw==
X-Gm-Message-State: AOAM533AJ/P+vZPq2YxsmaS1DpM9UuL8b8qa3+8Bnrt/pE7UoSNpRDZt
        mRXq7YrWIQWuUADLQpUKTZqGBBHmqGYGZDZ5oM0=
X-Google-Smtp-Source: ABdhPJzBoFZR0gds/afILt+nTJ/uGYisUxEDjhan8c6OaCvjddaRLj+hyJn/K/VN9dh7VCYBXJrlDUTuFZYGyKrF0es=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr11217349oib.39.1623948548363;
 Thu, 17 Jun 2021 09:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210613045949.255090-1-felipe.contreras@gmail.com> <20210617161710.81730-1-felipe.contreras@gmail.com>
In-Reply-To: <20210617161710.81730-1-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Jun 2021 09:48:56 -0700
Message-ID: <CABPp-BG4gCt260MhAgZMO1nuV=VdPfRoQsPaQBzbv0Qi2JujEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pull: obvious fixes
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 9:17 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> These are obvious fixes that I sent many times in series like [1], but
> for some reason they were never merged.
>
> No changes since v1, except the removal of a reviewed-by trailer that
> was not expressly given.

Thanks for correcting this.
