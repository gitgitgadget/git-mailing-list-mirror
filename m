Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3806C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 12:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A931060041
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 12:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhH1M5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 08:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhH1M5T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 08:57:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29928C061756
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 05:56:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r2so8585249pgl.10
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tu+9M0aGvMb7bnrKfkh6B8OrGh2MgnrNK3QHVjEZKrg=;
        b=ita03QSXjxgqpYGV1txVXU2YyWUTPQ1zfnxH/jqq5zpCkrfCredft9sssRf9ZeNcih
         damYXnmPI1lOnfWS7YTumg+fHdv8Vqjc0g5B5k2TrPYtFFMTzFpGycBv3PsbY17gJX4O
         utx2UKOGpimDw4jiPKWlbP2QBJN5XEQe2sHoLz4gSJRPJ10NaVr3Ev378AodPycHCZix
         kObb8rVhHjjwrEJvf146r2Bhj7G4Pc6o4SET2uWvoQAep+CIB0+qIFgpeRt+h3JiuZAS
         XqvRtLn4ditGiV2Ui/kTH1gTLXIbpyWVki/xJEplCeYyZ+xzNBEgs6eVg1xr06yDIec/
         PiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tu+9M0aGvMb7bnrKfkh6B8OrGh2MgnrNK3QHVjEZKrg=;
        b=k5yiXaS0aEVicdiS71/pd9V72r+8MeIZJ19GBG5Ag24JqR1HHQX7LujbmXqMfRB8CR
         DTLXCawp0JBzWrIHn0A3FPlCTGGQmY7VW7QGcx5RUn2WWFc3puEYOHMfMW2IikPtsmrw
         w4Nq9BIVhKwVUETGxLnXEpz39+wTOTTuBwougTJaE8Sd3bB0KegLKJfus9dFGxJnpeC1
         /yulENZ6KyVGLEQdOVC3SK09CrSKo6Mo7+3f8g52QAuQQO15uw/1ILz66p88gdkV7QJd
         5ldztuRV1ZKnO9qjL7ZXoK0uBG7V9rmyEVAtserKnx3GkE/5NWwAKDe7mbjykaVUy4LC
         E6Lw==
X-Gm-Message-State: AOAM5317bzXlKpAMU1N6xwxqqkF3l4rY+6SBiJtodKqRhbD3g4IiB6Kc
        zpMq/kAQfktE7ofCInA0D6LK0J3JCzUGMKFWBvzsMb0mmQ==
X-Google-Smtp-Source: ABdhPJzEAT2CYUMLY77AMxiAsZ+CNzneD/RTmNZhV0+Tfat43/qv2lpWEE+Ufr+izSDCcUYaSaQo0Vjfg/cC4KisW7U=
X-Received: by 2002:aa7:9250:0:b0:3f9:2b90:b34f with SMTP id
 16-20020aa79250000000b003f92b90b34fmr3334068pfp.7.1630155388450; Sat, 28 Aug
 2021 05:56:28 -0700 (PDT)
MIME-Version: 1.0
From:   Stef Bon <stefbon@gmail.com>
Date:   Sat, 28 Aug 2021 14:56:17 +0200
Message-ID: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
Subject: Exec upload-pack on remote with what parameters to get direntries.
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've got a custom ssh library which I use to make a connection to a
git server like www.github.com, user stefbon.

Now I want to get the direntries of a remote repo, and I know I have
to use upload-pack for that, but with what parameters?

I want to use the outcome to make a fuse fs, user can browse the
files. Possibly the user can also view the contents.

Stef
