Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58902C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362D060FD7
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhHQTaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhHQTaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 15:30:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2FC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 12:29:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y34so43429704lfa.8
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 12:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRcF7YJEDACmynDKGJLyydwBzBro17owvnQasMQ0D4k=;
        b=un88HqGhRe2adQu05iSAnMznsE+fE+YG9RfjwQUmb1X2CocbxgtAAY/VmTV4iZpYmI
         4XQfNpBLqJEXvkssppmmJ87My+AGKPsAeFzhde10lRslmTl35OxGB2dh2T1WiOLwWTdB
         JCqPQrF5sCD/sgFlGywW2Ze2Au/mBztTJQJmiDuch3SPKNz56XCqz9k6Ys3b1VsblFLd
         GSSICwCWk/nYITwlOq742ZihwZq5gelBJX3zAS+bbhg9MMc6bl816M8OwwKjbyraTl5M
         Bxg5v+I+2LbC74yRHiy5GlGSyt+IJV1FohLRU9RzYBq6dWnLK856AOqJGtYOq9jVL/Ik
         GoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRcF7YJEDACmynDKGJLyydwBzBro17owvnQasMQ0D4k=;
        b=XkIohgEYgt28KmiXSGSsayH61mP9sge8AxV0GtVQm233XqcgibwgMp3Hef4BY3oZwu
         O8P8wjn0jcZh97g3zlrcdPpP6esYTkbPYwAHDQX+9ckVdCJxNazQ5sZ9zWnAotBIij2a
         GcSkytn6q6F6wJW0YjlIE4eNTf3ifMuO7Sb7u7xTMjgTLpbwPk5/N9QTNvIJE+oz9znn
         UrA6nnwPNdjPa1nza+iqU0BgQ7PWPqcQoUKilC8dd0xg9pf3cZkg9JbitrOtNfH+UpbX
         DQwlKbFQkVDyHAEaxKI3dVGwU1xCe9cBH50VE4oEAu3c5Ri8r0kfDQrvHWnI+9XKpK+p
         yqsw==
X-Gm-Message-State: AOAM530UGESOI1+o9jPWKpOBVG4FAq5zkD8CxindK6z00hhyHC0SzF1A
        HRcyO7yR9RdfndsQ5N2PYEAEbd6bhej+3K85JzXeNg==
X-Google-Smtp-Source: ABdhPJxYbBqNZEJIUSB8PLjb1N8ag2tBZ4/sSmyUBWGysSKfGLlfqrrgDFyQh/CExEGd66UqL+F5cvrbi1yCKqAMCQs=
X-Received: by 2002:a05:6512:3f5:: with SMTP id n21mr3632402lfq.359.1629228589950;
 Tue, 17 Aug 2021 12:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1629148153.git.jonathantanmy@google.com>
In-Reply-To: <cover.1629148153.git.jonathantanmy@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 17 Aug 2021 16:29:38 -0300
Message-ID: <CAHd-oW6Va31PaTQeoSrwi09wjHk63S-Xd_PYtW1trhSokoKizQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] In grep, no adding submodule ODB as alternates
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 6:10 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Thanks for reviewing, everyone. Here are the requested changes.

Thanks. You've addressed all my comments from the previous rounds.

One minor suggestion which is not worth a re-roll on its own:

> Range-diff against v2:
[...]
> 7:  94db10a4e5 ! 7:  8b86618531 submodule-config: pass repo upon blob config read
>     @@ Commit message
>          When reading the config of a submodule, if reading from a blob, read
>          using an explicitly specified repository instead of by adding the
>          submodule's ODB as an alternate and then reading an object from
>          the_repository.
>
>     +    This makes the "grep --recurse-submodules with submodules without
>     +    .gitmodules in the working tree" test in t7814 work when
>     +    GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB is true.

This sounds to me as if the test was previously failing when
GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB is true, which is not the case.
I think an alternative could be:

This code path is exercised by the "grep --recurse-submodules with
submodules without .gitmodules in the working tree" test in t7814. The
test passes with GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1,
showing that we indeed are no longer accessing the submodule's ODB
through the alternates list.

But it's really a minor thing. With or without this change:

Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
