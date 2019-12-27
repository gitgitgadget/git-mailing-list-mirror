Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C75C2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F8120740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvgddzIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfL0Vr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:47:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33102 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0Vr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 16:47:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so15998473otp.0
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 13:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3NLpmBv6VuXQsrH7nwEd3ImUm01vMhT0Q+Kkxt8Q3I=;
        b=VvgddzIBXMKte4qDmlfPGFEdXlrzSiNIu1/jN82RCuA9gqLeIs9VL0lcAmQoCT/9Vp
         PO2M1AkuizXh9FSnYoCxRSkBdTPOFRQthbXN+XWrd5UXVnHsRg6XH1aSdNFMpLxQv5Pf
         gUgDymCmczFaCKpD6W3qoyFUTUeucCWnrOtxPhJM5fQnkJTNXBVckUUNlFuvMjbD525w
         2w8IJyxjsrzwh5RxKQXrFDtoHLDyOYEQFcGR5wLr75NH4WiSbuzB/xDeDfG0eJU4Rix3
         AQFupUCwW12NJLU+4sHT4Ewp6HtyKflwP30dehpRLhnazTXZhqvu7MGJawana6hDf9ZE
         Zd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3NLpmBv6VuXQsrH7nwEd3ImUm01vMhT0Q+Kkxt8Q3I=;
        b=SrEgQj033RUJ3slZA/RcgjmnSXSPld8dFEAKY00z1ZWz/faJNdQN5ZPLuNtYQtcCt4
         ta5t45LscjY5mg7QA87dY9SsD6Fxwwu1QT4AusvqmSK+E3yK4JlmRhehOBSfltEbBQI1
         RK6Qox9jwHozlPuORRWBLt4Eqql5cwwh7xPp3O31LT6Acy0qwLqQMJ0Dv+W+WcLPpd/F
         onM7nc6iT5aMO7U+IW/8+x1iHa4Jbun3sssflSFlIFn7umRjJ8y/rw521FyE1zsUj652
         ke7CPcdUYGRs+KP+w5Ab+q31Gd80oOVm4wV7L4e2VZo/MYpgPVGKr4ulNj4LhfT9iW7a
         DkEQ==
X-Gm-Message-State: APjAAAVz6gRDAh8Aur+w1Dqlb4/6rfpLEPj4L4mvm+YoW7ajMs3Rp6d8
        JavmlZX67C2rla8gilMl7LU7AkGWAMU+tJIwDRB4Rw==
X-Google-Smtp-Source: APXvYqypK3ki1/+BlvnoYKizj4/UhZucx/cKVLskTUDKVIzISkm65+Zm46WeA8VKl4fbWIz52ZosQiXs56bCojb8m/w=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr60362851otp.316.1577483276337;
 Fri, 27 Dec 2019 13:47:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
In-Reply-To: <pull.500.git.1577393347.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Dec 2019 13:47:49 -0800
Message-ID: <CABPp-BFAcWVrtoYMHghkk4AOEYaUWq0cD3xjtUwMPc2bfvrWSw@mail.gmail.com>
Subject: Re: [PATCH 0/1] sparse-checkout: list directories in cone mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        jon@jonsimons.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 26, 2019 at 12:49 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> When in cone mode, "git sparse-checkout set" takes a list of folders and
> constructs an ordered list of patterns for the sparse-checkout file. The
> "git sparse-checkout list" subcommand outputs the contents of the
> sparse-checkout file in a very basic way.
>
> This patch changes the behavior of "git sparse-checkout list" when
> core.sparseCheckoutCone=true. It will output the folders that were used in
> "git sparse-checkout set" to create the patterns, instead of the patterns
> themselves.
>
> I believe this was requested in the initial review, but I cannot find that
> message now.

Yeah, I think I mentioned it, but couldn't remember for sure.  Just
did a little digging and found
https://lore.kernel.org/git/CABPp-BH13XbNR3MQKE7cHO5e=pMY7kLtGhkX1SQg_o9it=uUug@mail.gmail.com/:

"Should the list mode in cone mode be modified to just show the
directories the user added?  It seems a little weird to show the
internal details of the implementation (all the parent directories and
negated entries and whatnot).  That's also not in a form that users
can pass along to future `sparse-checkout add` invocations."

Though I then went into other tangents, which may have been what
caused it to be forgotten or overlooked.

> I was going to include this as part of a longer follow-up series, but I
> think this may be worth considering for the 2.25.0 release. Hence, it is
> included by itself.

Yeah, I think this is a good and small fixup to a new feature in
2.25.0, so it'd be nice if it could be included.  Not sure if it's too
late given that we're at -rc0, but here's a thumbs up from me if it
makes any difference.
