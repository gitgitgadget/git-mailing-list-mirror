Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C6EC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAB06115A
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbhI1UB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbhI1UB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:01:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D19C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:00:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y35so36574168ede.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vaZCnpc88jzAiG09TOxojqoihFbAIuRZ7AOzX1nc6NQ=;
        b=ZS1Tul2sILuMp/nO2fMTZrJ6RAaO/F5i1JwrA2Paq476X81a+xYNS/CcdCp9EAq5wp
         nRn7sYKU1S/pO+fy25zeyuQI4KXdJD4gm36+2+bTrMzWZsuuLulu5EL1ToqZ58ye/K09
         QLSdM128tpSUZ1DxIg6JGa5CKkc6q0Ayte+L5NAeD7SrrvGK/aSkcqwxZT8guhyGAZe7
         GeVK+2AZRCp9eac3+/wvK9xgGDn5FwMFRtjGZNFJ8m0rOh87A+QSxwZ0TAFZO/FL+dFP
         nS0ZDhWCHyPK5QM8GqOL3PtIeAG0j/9qmzRyQ80OsPY1m+30HO4xAOdmQDK1X0/MtsFc
         Ga6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vaZCnpc88jzAiG09TOxojqoihFbAIuRZ7AOzX1nc6NQ=;
        b=sR9xVuiKXqMH+I2f85y7a+dmfWCFORSV2Ad+dKtHWc+M8hmzyXDF8Ur2ovR6tQwcJq
         diwN0lx1TFO2KMsnBtdg3kU7Luopoel0Mlyp+3hpuncMrtS5kvT0q/7He575pKE4LH1V
         mHRlDZoqnhnYsdCGRB/GB28y8W9Mtf1B9v8tGA0Jn3thQnhMnVs5pQoZxr4yKeBr9Vmz
         Ev7CvLLSHtZDRBPmbeZI39+tgcr/hPGJ3qCe4ENRz0TmO4npXI5ekK606n32Vh1aLG4Y
         v4PsvsVokLjCEZoJyj/B4oXfhQ9DINQo/OqTbvnDDQOWPyIuxVhmRjaYJpMGMl3DHqfs
         sESA==
X-Gm-Message-State: AOAM532ScaZoQqbtDpWnPCUudYVI78FhOerevnDbzJLSxmhEj2ssgqHj
        jp1WRwR+prijSyCdWUbIcMRqZtm7/qsDvw==
X-Google-Smtp-Source: ABdhPJzfVb490tA7NGmkrhnHO0OzLRsTfu2gjM42HxsZOPfaZdz+rtyRmgxOEt2QXGBq2k3m9HQEKA==
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr9889029edl.58.1632859216203;
        Tue, 28 Sep 2021 13:00:16 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q6sm60511eju.45.2021.09.28.13.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 13:00:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Aidan Gallagher <aidgal2@gmail.com>, git@vger.kernel.org
Subject: Re: Feature Request: `git commit --amend-to`
Date:   Tue, 28 Sep 2021 21:54:28 +0200
References: <CAENgTz2DoStQEqoKYKa-qMcyaez64u55mnv1HHOzDm392fuEqQ@mail.gmail.com>
 <CAENgTz0st6RpnVusP67-SSh2eENSxQn1_qiEqUDiMKzg=r54vQ@mail.gmail.com>
 <CAPUEspgr71t-thozi+Ez4xwxAkSJizsLuV=0TnROKZ85M6-kBg@mail.gmail.com>
 <kl6l1r58r6ba.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <kl6l1r58r6ba.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <87y27gv5bk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Glen Choo wrote:

> Carlo Arenas <carenas@gmail.com> writes:
>>   git commit --fixup reword:$SHA && EDITOR=true git rebase
>> --interactive --autosquash "$SHA^"
>>
>> granted it is not 1 command, but usually I find it useful to do
>> several of those and then one single
>> rebase at the end.
>
> This is fairly similar to what I use, though I use this through the
> Magit Emacs plugin.
>
> My concern with "--amend-to" is that the semantics aren't as simple as
> --amend.
>
> With --amend, you know you're working on the branch tip, so
> it's relatively simple to discard the last commit and create a new one.
>
> With something like --amend-to, you aren't just modifying a single
> commit, you are also introducing a potential merge conflict with every
> commit after that. You would have to provide some kind of facility for
> users to fix the merge conflicts. A command like git rebase --autosquash
> does a good job at communicating to users that they are actually doing a
> rebase and they need to be prepared to fix problems through a rebase UX.
> However, git commit --amend-to communicates none of that. A user who
> takes a cursory glance at git commit --amend-to has no idea that they
> are potentially comitting to a rebase.
>
> I personally think the current UI makes sense given how Git works. I
> also wish that it were easier to do --amend-to, but I think the problem
> has more to do with how Git manages merges and conflicts and less to do
> with having shortcuts in the CLI.

I think that users who'd like an --amend-to would probably be happy with
or might want to try out something like "hg absorb", which is something
I think we should have stolen in git already, but it's never too late.

I.e. it's a "git commit --squash" on steroids, which tries to find what
commit to amend things into.

See [1] (and [2] for an archive of the linked PDF) for a past
reference. There's a "git absorb" in Rust that I haven't tried out, but
seems interesting[3]. It looks like "absorb" is now part of "hg"
itself[4], but I'd looked at & tried it back when it was part of the
Facebook-specific patchset to "hg", which I understand has then mostly
or entirely gotten upstreamed in some way.

I'd think that for a git implementation we'd want to re-use the engine
we've got in range-diff.c, i.e. consider each unstaged hunk and find
which hunk/commit in say @{u}.. to squash it into.

1. https://lore.kernel.org/git/877ej0iuhc.fsf@evledraar.gmail.com
2. https://web.archive.org/web/20181003211051/http://files.lihdd.net/hgabsorb-note.pdf
3. https://crates.io/crates/git-absorb
4. https://gregoryszorc.com/blog/2018/11/05/absorbing-commit-changes-in-mercurial-4.8/
