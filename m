Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21191C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CBF2072E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F03nn6rL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgI3UGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UGO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 16:06:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D42DC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 13:06:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so778882wmi.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqeMjU9TL2saTpowkDTC0QGmnNfAMzInIXiRsm+qYxI=;
        b=F03nn6rLrEjNxUbMRNcsESql6rYdtfi93428lylGi4RdfL1czJkV/AnpmA4bSnB8Uj
         /vygZFv2U7SOVWEHmfVzm2m9Cv03uxvFWHDQ7IzJsVMu4UM0a2WY6QDkdfOdn1mLKd9j
         1yBd7y/FBoMjMB8YZ13pRlZSLiv+E44URDIL+69FiPJlilDJhi3+O6Usg67e7YW/s3BF
         x+JWAMrKBsVxY1pwCRqd7yDpVqsa+28OduGqU16vVTv7nPAh1PZK4ptHdErsYMhDXBK+
         pDWnO/kNaoTPti8vCAUKevf2l3T6dQfua9ZGYD+f/F/cQIVrC+d/DMlAgdopOfXuaI1T
         8ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqeMjU9TL2saTpowkDTC0QGmnNfAMzInIXiRsm+qYxI=;
        b=hRvuTDfIJstZcJ36K4eNazgUAk0IT1oNTt7XVVXUy+bI5j9CMMf049WwN2zDnlIwxJ
         DmA1wBFxc0riBjeyWroNsIfbp4Y3y9h7ypOOdEYfbxv9L2kMP1ZbSqZnTtvinyP+3XGy
         j4jyqXSZx90JoNzPhEhoOb0SpU3eezlvLc7ohKXoC0rqn5JRYZR18I3Za8hSq139I4ct
         3aPlse8jtFh0JV/xBZSdQGBkbCK6SHyvLWFq7q/ode0mpQGQmW9kGqWxxopbzff8Nz8I
         d+OhsGBpxtC6grymZXCBnjy+QS218S5mAZFBgbTtDUOdhVuMUKWnXyldevShb9E0E5Jp
         Z9zQ==
X-Gm-Message-State: AOAM532MwBXVYaN3DLVmvBvJOyEXAuUXvPBhI1oDFQJX6F0zEbGvDVOk
        tSd+/U1Mwu1xDmN+6wKMxWylZCRVriJRkiQfRo4pSHNN
X-Google-Smtp-Source: ABdhPJwq99p+mivE6LF6krEy2Z0eVEnP87nBdJxnTmXh47vKH567ysbgxuMgHFp0BmGFllXeP257IK3D8kPt/PGwDNA=
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr4561961wmf.37.1601496372986;
 Wed, 30 Sep 2020 13:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200930115240.GA1899467@coredump.intra.peff.net>
In-Reply-To: <20200930115240.GA1899467@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 30 Sep 2020 13:06:02 -0700
Message-ID: <CAPx1Gvd7WpAgUGgZkZARY7JcFj8nbDJ6zEDTSaBt2=xR535E-g@mail.gmail.com>
Subject: Re: [PATCH] combine-diff: handle --find-object in multitree code path
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 4:54 AM Jeff King <peff@peff.net> wrote:
> I'm a little nervous that the second "wart" may actually be making
> things worse, because now we sometimes produce a wrong answer and
> sometime a right one, and it can be difficult to know which options
> cause which (e.g., rename detection puts us onto the slow path). Is it
> worse to sometimes be right and sometimes wrong, or to always be
> consistently and predictably wrong? I suppose one could even argue that
> the current semantics aren't "wrong", but just what we happen to
> produce. But IMHO they are so un-useful as to be considered wrong.

"Predictably wrong" *is* actually useful while "unpredictably wrong"
is, um, "less useful".  Perhaps just documenting exactly which options
use which path?  Basically turn some of this into documentation.

Chris
