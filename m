Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B65C433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA3A64E98
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 17:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhCNRbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 13:31:46 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:42588 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhCNRbV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 13:31:21 -0400
Received: by mail-ot1-f51.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so4006775ota.9
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 10:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E3FUBfFGN1E1XVpGyLmAaSnICGnJSZzn9kgmWQJ5bWU=;
        b=AOtW9Clys2IuGZ78fowMOEu2GF3/GLVB+8pL5BmzHF7P3Ia8D9zH3WWljQXXdztilZ
         F9AdxIx4cdO7/vQj4wPEXL/zd4avs4eEP2wmtq/pyA4gUrpykXwPUUw8/g/GaUOz9cfk
         tUihsX/5hD2EgfhfR+O/5E+9vlvWhbbEga9XvsTgCoXqGCuuNX879H1X/FtCIXxIyUej
         pO34k398/Yk9jQq6O/v55p7zpcKy9xe74T/Idso7gsD9KGoRET3LHfr9XF8CDTEcmUNh
         PVZkAk2qXVONoinirpbdi02IHb572fVy3RZUMdjXE5KMeyfr3koYv3hfRDQkigFy3uHp
         2w8w==
X-Gm-Message-State: AOAM533BF/8jGlw/vzCd672SsxwMM3S1qhfpyNh+bWOljyP31EikvQId
        DaclyGluQfuDSMzGWlfjn0w+Fht9cqqshJuwWeFuY5QneWIV1w==
X-Google-Smtp-Source: ABdhPJz3Wy81SZAET4dPceolt/XCcSRa1EoyhtWlXd+BsoUV5TFXX8ARz4LmBh0qZ2o0RGLJ13u4M1KmMOH3Q1KYHCI=
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr11196456otk.172.1615743080481;
 Sun, 14 Mar 2021 10:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7rbOve-EFOGPjr1wrD77r-3RQ+3+qso82_oV5Qud-skobL7w@mail.gmail.com>
 <YEzwOqgFcva4fmoV@camp.crustytoothpaste.net>
In-Reply-To: <YEzwOqgFcva4fmoV@camp.crustytoothpaste.net>
From:   Arun Sharma <arun@sharma-home.net>
Date:   Sun, 14 Mar 2021 10:31:11 -0700
Message-ID: <CAN7rbOuOaHY553KX1Qcr_XWGG6DFo1yUjdYVu5mn=HYPmOj6vQ@mail.gmail.com>
Subject: Re: bug report: mutual recursion in the git-subtree shell script
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arun Sharma <arun@sharma-home.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 13, 2021 at 9:03 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> I don't use git-subtree, but there's some additional information which
> would probably be helpful here to someone who does.  What OS are you
> using, what version of Git, and what shell is the shell you have as
> /bin/sh (or, if you've compiled using a custom shell, the shell you're
> using for that)?

Thanks for the hint. I was using ubuntu 20.04.

$ git --version
git version 2.25.1

$ bash --version
GNU bash, version 5.0.16(1)-release (x86_64-pc-linux-gnu)

To repro, you can try to split a week old version of:

https://github.com/postgres/postgres (subtree: src/interfaces/libpq)

It could take several minutes because of the size of the repo.

And then try to pull the latest version and push the merged result
into the smaller subproject.

 -Arun
