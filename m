Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAFDC433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 16:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiEKQwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 12:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbiEKQwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 12:52:16 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDDB60
        for <git@vger.kernel.org>; Wed, 11 May 2022 09:52:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x16-20020aa793b0000000b0050d3d5c4f4eso1388760pff.6
        for <git@vger.kernel.org>; Wed, 11 May 2022 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I5CzC+LkCNL/IaTQ2lJ4De6XfS+VyFou7euo5mTC5BY=;
        b=nLCjWowYodm5z7/LkJqXRSkF34n6wk4ufzjXXdHUm7lAWWCYygLSgSNR1BeiMu+V3n
         Mtz9T0n1p1fW99OHFz/4aNZ0pQqN9R54y835b64jqZ+EZI7fc6r1UxJEJiw4qF7zTo2J
         zVwnf1w155tSxoa1+T8EOlPSL+e8KpvCE2Kd/dIia3iLI31+C9AU2IpN7njCuBuQlTm8
         89FHTQlEyrCZBenJ7e8vm4Fw4lVZfDbAIYOI+ZsJdewrM9FGy7SyWr16NJPFAW/Rhu9F
         XEyqPwUWFs4qmGeTClT63WA76A8V1uRjL4JQurqSdCsmNGijdzdZHsX6hnO1e8vkzeJV
         Lwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I5CzC+LkCNL/IaTQ2lJ4De6XfS+VyFou7euo5mTC5BY=;
        b=1Z9SSV3D8I8r9uzccHVcrBQJrC22vSLt5xWc5M7psHYxRAoZYsWrujS3GBZmiIPjNS
         WY5r7Cspnkoq8uUv+jAzsZVTctj5VePBKFlRHZod6OnlCoeNmHgTsTW/grVGFtTMfoPz
         RrN2KnXBTcrNZj01Bb+xDcC5+g4fJzEpaCkncPSzN74h5Or89dxhvCxpPXBxVT5yRYDU
         vD27qrzylI7iJgpqmZIpqf/hMowv8G6al95RoSQs3PmHjOWjhVkuKJ6YAn4QufifPJ9M
         SkrCrGw2DHC6Z8CnUK/Eitk8le8mLC3lK/aMk/FyPBX6FIEyUk1kCUXLoR9363ubp6/O
         enTQ==
X-Gm-Message-State: AOAM5309qFR1wfPVshKx8f1sVlpxEKuDIGHEPBlM4BE9a2OX+YZDOjAT
        VSi3+oKfLgDOXF3tJR6stRUDjiDe2cAbkg==
X-Google-Smtp-Source: ABdhPJzZ8QnrX/ZOhmFIZga9hGmyDsYdRXzZYGkyzNDMgZv/eez68ImuNtC+D5J3DdzebaXvIZR1APlfecxHcg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2188:b0:50d:b093:12a2 with SMTP
 id h8-20020a056a00218800b0050db09312a2mr25907475pfi.84.1652287933853; Wed, 11
 May 2022 09:52:13 -0700 (PDT)
Date:   Wed, 11 May 2022 09:52:12 -0700
In-Reply-To: <xmqq4k1wq1i6.fsf@gitster.g>
Message-Id: <kl6lwnesxb9f.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq4k1wq1i6.fsf@gitster.g>
Subject: gc/pull-recurse-submodules (was Re: What's cooking in git.git (May
 2022, #03; Tue, 10))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/pull-recurse-submodules (2022-05-10) 1 commit
>  - pull: only pass '--recurse-submodules' to subcommands
>
>  "git pull" without "--recurse-submodules=<arg>" made
>  submodule.recurse take precedence over fetch.recurseSubmodules by
>  mistake, which has been corrected.
>
>  Expecting a reroll to retitle it.
>  cf. <3234941c-5190-819f-fe3a-f528942c6b44@gmail.com>
>  source: <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>

Thanks for picking it up! Unless others, e.g. Philippe, feel strongly
about the title, I'm not planning to retitle it.

I don't feel strongly about the title, so I also don't mind if you
choose to retitle it to whatever you wish.
