Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F02DC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 17:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiAFRDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:03:01 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:46030 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241490AbiAFRDA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 12:03:00 -0500
Received: by mail-pj1-f41.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso3794538pjg.4
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 09:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=294cBrGhb6J+ty6pFwmF66SHGphoiUwTTS3cUGNqdMI=;
        b=CuKisr0KYE7ToQS5SItqwGrItR0xQvwOaCDA4HX9f+GAu5yUFZNl3cFA8a6PlnDz2N
         32ueI6m8mdLZqEe72O9InmrrOa6CZbtYiJbD0Z/k++Glu9oqezZWSrQPxtPCphivxnPl
         J8Ijq4SUo+z1hYKFLghRdmY3yvBRpdu1Duhbs0pQ1ME61TA1Yw9pQLaAuifHFW0cn928
         BHmuGrwQsZwbfA8D28TP9q2bJug1zTS/6ENmz/oVtFkCMzXkiSDjnViYaocXIGPzzEFj
         tDRjDVVZ6Y4YccIqi334ZBEJG/4510jWvjvMBO1gZahm7UrEWWyvqNl2iX+wnuN9HjUo
         4YDg==
X-Gm-Message-State: AOAM5302b3pO+rPou91wucbzGZOxpq2OS/pFBTjVgRBQJN7YR2N51AyD
        f3B0ml64XGC2JhPj5iH/w2uEOOB2yiw8asGdeEg=
X-Google-Smtp-Source: ABdhPJxIRgTuWS1TmoiweB4hbws1xFCjNItbWlZTEhDeVsd1CD6mKrSngplR63B8VZwMZ1ekMnVT0jRMrj36Lt0mADQ=
X-Received: by 2002:a17:902:bd94:b0:149:c926:7c26 with SMTP id
 q20-20020a170902bd9400b00149c9267c26mr9708720pls.64.1641488579926; Thu, 06
 Jan 2022 09:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20220105161451.56378-1-jholdsworth@nvidia.com> <20220105161451.56378-2-jholdsworth@nvidia.com>
In-Reply-To: <20220105161451.56378-2-jholdsworth@nvidia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Jan 2022 12:02:49 -0500
Message-ID: <CAPig+cTN933GO42m10qbABz8gX61d2uKDJWQmYHYCCar5rgFSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] git-p4: don't select shell mode using the type of the
 command argument
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 6, 2022 at 7:43 AM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> Previously, the script would invoke subprocess functions setting the
> shell argument True if the command argument was a string, setting it
> False otherwise.
>
> This patch replaces this implicit type-driven behaviour with explicit
> shell arguments specified by the caller.
>
> The apparent motive for the implict behaviour is that the subprocess
> functions do not divide command strings into args. Invoking
> subprocess.call("echo hello") will attempt to execute a program by the
> name "echo hello". With subprocess.call("echo hello", shell=True), sh
> -c "echo hello" will be executed instead, which will cause the command
> and args to be divided by spaces.
>
> Eventually, all usage of shell=True, that is not necessary for some
> purpose beyond parsing command strings, should be removed. For now,
> this patch makes the usage of shells explicit.
> ---

Missing sign-off.
