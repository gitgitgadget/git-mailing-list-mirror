Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B45C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C77613EA
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbhDFA1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 20:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbhDFA1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 20:27:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0992DC06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 17:27:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o126so20029711lfa.0
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 17:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wViaMTkWU4Lg0/XzPZTRkmKB64c9UwSOdNJbPoYuMxM=;
        b=ZaJlFnyMv6RUBSPzaH8L4AdNzOxPtjzrY9p3XZPhUVj3x7nz9IY2iSH28vYGIwnsje
         PzqGyYmUh/Lq9IEPZUqmVPFTaql34P3nLtgAaPBof9XxY90YWfITVzMyNoYBa+KQafYf
         VwI6REl0vNLu+HaUkKbQRKP8wKDGh/0PuaGTjknvTA4pjYNhGm+VnKVVZErEgqzkIiqy
         oXK0A3oEVekxrP+Bty7EURIa7UTS75Cl9UsQ4vxBGpEjNzcAOyreGkgWAFQM1e6UioGH
         n+35jZJwUdSb18xQIeonVQfH+SgXMetEgjWa5wOhuCtGw7LLFRqSxPGeKI+sf4+BiGPT
         XR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wViaMTkWU4Lg0/XzPZTRkmKB64c9UwSOdNJbPoYuMxM=;
        b=gAidPWaXALUqbdw7NTMhTQA57+lLNGCW+hA2PoSn9AUs68mqdMLOPfBXfeBIsCcNZw
         jF5ZzMJ8M3vd6nio7/StIM+bhClCptbnY6bNnLIjx08NpQ6QuN73ldO83Zy120R9rFfF
         4DZiIkALRau4Cufu3I1L5vPCrxzER30s4SWWqMQ3rOkXNGUq9paPkZTFRZHFGSJ6d4FZ
         QzIk0/3D4XLVaBY5kjF+2E6/A/hklDx9NcAsk3AdRXU1zNgiQoPkX144Ws8CMcX22yDF
         9BCi57sx+sRFDqM3y3z6P2rRD2Y348vVxrN9tOZkv+MP71VaWgcsw4PJUpjjnONhUsHl
         AckA==
X-Gm-Message-State: AOAM531umXrO/SkT0sjmPpm57eW9kduRNZ9Ao2P2UDDzHhK+ltlbHKCt
        bofpp+oXvg69fs2k9icXAf4KpZaxBPjYwDijVOA=
X-Google-Smtp-Source: ABdhPJwiriaRD0jmlycs/bq5edoGm4sXq947+50IljsGwEKOHkbB9VKZgnCAW2Z14j15q4ylulV3CCGnKfAQsNZHW0U=
X-Received: by 2002:ac2:4250:: with SMTP id m16mr18389952lfl.40.1617668849405;
 Mon, 05 Apr 2021 17:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com> <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
 <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
 <xmqqmtuc49cm.fsf@gitster.g> <CAMbkP-SBQMLeM14d9KSnzE44KsfhHPsxWQ1PaskauWPynTJvWQ@mail.gmail.com>
 <xmqq7dlg46d6.fsf@gitster.g>
In-Reply-To: <xmqq7dlg46d6.fsf@gitster.g>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Mon, 5 Apr 2021 17:27:18 -0700
Message-ID: <CAMbkP-Tamv6yt2CFp92UOK0SFZudXq71oX6ORPEY46n-gN=wdA@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 5, 2021 at 5:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Albert Cui <albertqcui@gmail.com> writes:
>
> > I'm a little confused, and maybe it's because we have different
> > definitions of what "installing hooks" means. By installing hooks,
> > I meant the addition of the hook command to the config, e.g the
> > outcome of:
> >
> > `git config --add hook.pre-commit.command pylint`
>
> Yeah, I was envisioning that it won't be as a simple, mechanical and
> unconditional single command invocation.  Rather, the 'pylint' part
> would have to become different depending on the environment (e.g.
> what operating system you are on, what editor you prefer, etc.).
> And the part that decides what kind of environment you are on would
> have to be written by the project that controls the "project-managed
> hooks"---unfortunately that would most likely to be an error-prone
> part.
>

I don't see a need for that. At least, this doesn't feel part of the
"minimum feature set."

I don't think any existing solutions for hooks management handle this,
so it feels fine to push this part to the project. As you said, if
they wanted this, I'd expect `git config --add hook.pre-commit.command
lint.sh` where lint.sh does whatever cross-platform magic is required.

I wouldn't expect a lot of need for this anyway; I'd expect most hooks
to depend on tools that already work cross-platform (e.g. pylint) or
be hooks written in the programming environment of the project, so the
toolchain should already be in place to execute the hooks.
