Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F9C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 01:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhLUBgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 20:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUBgq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 20:36:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A4C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 17:36:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m21so18416269edc.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 17:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2+ykGUZUH7rA8NB9u+yDGBa7ECYKnajOVAn8PTtAYfY=;
        b=U1o6PRMqpKBRLfxx8dEb5hstPEX5Pz59yG7TECrnxAZuKaOpUS+6danh99RBqLEXjK
         9lHQHki5p4l4a3EDUQBGOiWGKf95sypm4fLCOxInJnTEM5xJ0uH4XcCT5+FH5UcoLhFD
         N4ilneTVE0pGVAYz3Iql0jYQk0aWss0WluaisWiyR0TfLxLIAkN7p3UILoYmonsikPm1
         W24S/eXNQSbOSfW5bMKPF802m4to+MfYDAqvWF2tpV2bK0Rr6ZNvDRSlfGiDz92uGWtX
         fc7pHjk9Iz76V6wqryUgfWi9Fo0K19kt7ueylA6DboXlsVrAxgeIGziRSEVTCS94UIp0
         DZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2+ykGUZUH7rA8NB9u+yDGBa7ECYKnajOVAn8PTtAYfY=;
        b=KiG/oG2d7SK9DeBO4VP0nScfkDQLbN8vtuJYwNGg3io44oU+51ICHI7AsTNcWfQUgF
         wdHYuHA0k8+8P5Xg3n2KYMa239c/TDvC6Dehh4w6rBOJL1ctmQj3SGAMcz1S9d68LfvD
         bE4E96XhRUHZlrviTbmrQnYkg1VicL4QQBa3luovfah1K4H5/6d9gppWiJX6uKN+vIPS
         S7OZYof6ETTmYmzX6e4/TuJpjd7BGGojdparaRftuGyeFKwnvLO1T4Uqu8lMPFS7qd1O
         Lo07uz+j+FTmcJWxuqfbuLfXkc5z9glHZXsl0/mqlAP9ENHDQVjM0MPSlKeV8UHdhQVY
         P2Gw==
X-Gm-Message-State: AOAM532RLhVRF7RDUh9mQK6kFx/+PT1cfA3DOEXEiRviPyK7kBMi65bi
        btoONNVQ15BzYEQSf71k7w0=
X-Google-Smtp-Source: ABdhPJySs0Xvn1Ngk/q/1+qKiu9+EGkdwPiqGeT/92WCm+FOOTCnfbZc4SSaW/bVegf05R5Ogg+j0Q==
X-Received: by 2002:a17:906:39c8:: with SMTP id i8mr698438eje.335.1640050604326;
        Mon, 20 Dec 2021 17:36:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sd5sm1017486ejc.37.2021.12.20.17.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 17:36:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzU55-000alF-1S;
        Tue, 21 Dec 2021 02:36:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Date:   Tue, 21 Dec 2021 02:15:11 +0100
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
        <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
        <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
        <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
        <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
        <xmqq1r27xfi4.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq1r27xfi4.fsf@gitster.g>
Message-ID: <211221.861r26u4b9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> What I _am_ saying is important is that if we are trying to write
>> a file to a known location and its parent directory doesn't exist,
>> then we should create it. Not doing so is a bug and should be
>> fixed, no matter how rare such a thing is to occur. As you've
>> shown, it is not required to have an info directory until we need
>> one (e.g. for sparse-checkout or an excludes file).
>>
>> If you're not planning to add that to this series, then I'll add it
>> to my list. I do think it would fit well into this one, though.
>
> Historically, "git init" relied on the templates to create necessary
> directories, and the subcommands in turn learned to depend on the
> presence of these directories.
>
> At the same time we allowed that the templates can be customized by
> the end users.  It was a bug, exactly for the reason you said above.
>
> Before we talk about creating 'info' directory directly in "git
> init" or anything done in this topic, we should fix the existing
> bug, and the right fix is to use safe-create-leading-directories.
>
> With that, it may become unnecessary to have this "create 'info' in
> 'init'".

I don't see why we'd consider that as a worthwhile direction to go
in. The "git-init" documentation states:
    
    This command creates an empty Git repository - basically a `.git`
    directory with subdirectories for `objects`, `refs/heads`,
    `refs/tags`, and template files. 

I.e. we promise to create "objects", but not "objects/{info,pack}", even
though we've done so since f49fb35d0d5 (git-init-db: create "pack"
subdirectory under objects, 2005-06-27) and d57306c7945 (Create
objects/info/ directory in init-db., 2005-08-20).

Our test suite reveals our own assumptions, but it's also indicative of
assumptions others have made.

It's cheap to create .git/info unconditionally, and we create similar
empty subdirectories, so why not do it for .git/info? Why would we
needlessly break widely documented out-of-tree recipies like:

    some-user-excludes >.git/info/excludes

Which yes, rely on something you can't strictly rely on, but is true
enough most of the time that people do.

So I don't see what finding and fixing every instance of assuming
.git/info in the test suite buys us.

After doing that we'd be back to square one of having to decide if
exposing a mode that effectively did the same could be overly pedantic
in that case, or cheaply cater to out-of-tree code that made the same
assumption.

That's the question this topic is mainly trying to address. It's also
worthwhile to fix the in-tree dependency in sparse-checkout, but I don't
see why we'd insist that one can't be done without the other.
