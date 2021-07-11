Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A724C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CF86101E
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhGKQyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGKQyD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:54:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB00C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:51:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h19so8069348ljl.4
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=WKU5vdsZAXyOHvqrBBMoPdF1WSx59R14aqaHxNjVwMY=;
        b=f8apQJeaFqY7Wk+B1ozA9bN6BCHZEjyANB59ixz361uAS1BU5ZEJlHbOpfQaHQ4T7k
         gygZ4ptE1p3xIZkhOdanvDErz0roD/XSGpMkZyLZlwooMUGWeyubO7XHfLXV47gL5+SR
         BBdF2ZeTi02/h283hSZxVBjUPUCvRT9WZhV94izo5B+YVI8TuNYlUV5fFOtT3NfbLGqc
         TXsUuGI/pnSmahdmkYFMrTpSrQX/EESyxhOlxruYpUfUWTln1bdmG6YpcyfLxzd8T4ZO
         TgL5CSizZwdK8tevIeXE6A7VuV4HZn2OT8BOv+Sh0FeY0HCVjttv45U1o271MnHK5yW8
         TBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=WKU5vdsZAXyOHvqrBBMoPdF1WSx59R14aqaHxNjVwMY=;
        b=ggtcPoB3ckX7Ap1jKQhPkAcUJukMdwZcyOhH2iWykZOvM4e7cHwbB196DJZDdc4Y+K
         33bQ/UYAuVQqSIjgrNJ/+uhCwh2rKZTacM1NFcSp4nIJtihk0N6Y9rigi6ekdqYXiwiC
         R7Ep7zoEaP/qEnTnm+ybFMMqjpWuQTpDlT46k297GlcaK6NA3uM6DE81ltvH2qQG8Gly
         O0vyJggiifp7I8u/rbLEsF4iau7AQyk9BfzcROOo68nmiwKb/3HANKXKNt7+jEVdyNgP
         JLWi3jTyOA6yTBJY0pSAozc3hCcabAOQ5kLIovxyrMjR1BsxwTjaaSVrSLrxF7wRbtCJ
         8b5w==
X-Gm-Message-State: AOAM53373SZDQ71+kKtpOZYjqzTXaa+0yH4AvNtAJFtp/LD7bWIJsseY
        TfR6rfFMvoqRuNNVrRblrfifGSJuWqU=
X-Google-Smtp-Source: ABdhPJzHuupB8tnCQ1aCasKi4iEjWlctggW0+59ql40eXheqNz6SGJ8xVzibd0uB6wZ+nvwJ0yomtA==
X-Received: by 2002:a2e:a785:: with SMTP id c5mr38782693ljf.490.1626022274451;
        Sun, 11 Jul 2021 09:51:14 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q21sm1063834lfp.260.2021.07.11.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:51:13 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <877di13hhe.fsf@osv.gnss.ru>
        <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <87im1ieaba.fsf@osv.gnss.ru>
        <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
        <87a6mudt9b.fsf@osv.gnss.ru> <60e9ff4430c57_7ef20815@natae.notmuch>
        <874kd1gr0q.fsf@osv.gnss.ru>
        <6ffd7f1c-97be-a57c-b738-31deae26e8fc@mfriebe.de>
        <871r85f39n.fsf@osv.gnss.ru>
        <33af677c-8fec-5b49-0e00-878918c4ea1d@mfriebe.de>
Date:   Sun, 11 Jul 2021 19:51:12 +0300
Message-ID: <87bl78eqv3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> On 11/07/2021 14:23, Sergey Organov wrote:
>> Martin <git@mfriebe.de> writes:

[...]

>> Anyway, it's more the consistency that matters, not particular
>> convention. Git problem is that is has no convention at all. "Just do
>> what feels right today" seems to be the motto.
>
> Well human languages are not as rigid as computer languages.
>
>> Finally, the problem for this particular discussion is that if we decide
>> that it's rather:
>>    git <object> <command>
>> that is the way to go, that I'm pretty fine with as well, we should
>> simply *obsolete "git switch" right away*, rather than spending time
>> improving its now almost useless documentation.
>
> Actually then we would end up with
>
>    git branch switch
>    git tag switch   // detach
>    git commit switch   // detach

Why? You don't switch tags or commits. You switch only branches, so it'd
be:

    git branch switch <dest>

where <dest> is any commit'ish.

>
> Well it could be
>    git worktree switch
> (ignoring the effect on the index / and bringing "worktree" into a
> single worktree setup)

Yep, it could be, and it could be even both doing similar things.

>
> The problem is, that IMHO forcing either verb or noun, ends up with
> grouping commands in ways that create unnecessary dividers between
> related actions. (Continued, next paragraph)

The problem is that there are multiple ways of grouping, and selecting
the right one is not an easy decision. Having carefully though-of
guidelines would help.

Grouping by action first is more universal than grouping by object
first, but not always more "natural", as you've correctly noticed.

>
>> 
>>>>   From that POV, for the commands you mentioned, "git bisect" is probably
>>>> fine, whereas "git worktree", and "git remote" should better be split to
>>>> operations on them, e.g.:
>>>>      git new remote
>>>>      git new worktree
>>>>
>
> This is what I mean with dividers.
>
> There may be some relation between "new branch", "new tag"
>
> But I can see none between "new branch" and "new remote" and "new
> worktree". None at all. Yet I can see relations between different
> things
> you can do with a worktree.

The only true relation in this model is that if you want to create
*something* new, you use "git new". Simple like hell.

>
> I also think that, switching to a commit or branch are to closely
> related, and should not be divided.

Strictly speaking, there is no need to switch to something that is not
a branch. But we'd need the notion of "unnamed branch" to achieve this
simplicity while not loosing useful functionality, and even gaining
some, see below.

> (There were even suggestions that switching to a commit, is an unnamed
> branch)

Yep. We just switch our current *branch*, so another *branch* becomes
current. If we specify a commit or a tag as the target, the unnamed
branch should be reset to point there, and only then we should switch
our current to this new unnamed branch. That's it. No need for
complications of "detached HEAD", that even sounds awfully and makes me
scared every time I see it.

In fact this "unnamed branch" could have a non-empty name, say "AUTO",
and its own entry in the reflog. That'd give even more functionality
than is currently available with this chilling "detached HEAD". We should
better bury this Nearly Headless Nick finally.

Thanks,
-- 
Sergey Organov
