Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12275C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 23:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D642261287
	for <git@archiver.kernel.org>; Mon, 31 May 2021 23:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhEaXps (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 19:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhEaXpr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 19:45:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5BC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 16:44:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l1so18817451ejb.6
        for <git@vger.kernel.org>; Mon, 31 May 2021 16:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Gf5Tv/MyJZUuBwxxendPWgsMym+w+ZtMdu3JXrJ2V/I=;
        b=DmHUJ0n1TPWpZxAn+XPWiSe6O5UKXVoGuPSIqk/8nmPt40uH+IAO4DY3+hQtsbRGLn
         LJzuV+hXT1vggrooEkadjfGNMQyB8MGrP1Ix3jrkkGpdWPJHt8OGyQod+Dzkikb9iFPW
         TRetSYsFyykL5NaZrBXL5gjIR4ghpdC4T1exdvh9LiXlNneeGGIeeeCboxjmWZG4He82
         Ydvo4mW2MA5mbV8nBGS54fCKma28RD+yr+USy9NNL5HzH28KPM6CGhndkHueAaNdRfzn
         iaWVNEGO+x1YseqsEukMBOgErapV+MUBbOu5t30rklANfD/9H5dxoUWlg1ijhqQxDv3k
         ltuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Gf5Tv/MyJZUuBwxxendPWgsMym+w+ZtMdu3JXrJ2V/I=;
        b=nhQCmgdY6Ml8IeD/U189a5qL8zRihq0AcnUeqs7hhVNvn0EjC68aCaQa/KNz9IhjDG
         EwhJudS+7e0/XjppAnek5yIPHZUK6iOYIUn+lKcdQFTlEzN5P6u0oLgg8HfCMWym+axI
         UQuD6sI2v6EN9HCSrI8awv57j3FjLnw98TyBNbrwCUNMkXrDgdXZwW1x1gWMC8/r2T+a
         /jdBmASXI2WYcH6l8jJhaDPUFwNwk1yWs2R+MjkFZ954HDiJ/bBy26FfHXs9aGjfFIV3
         npZ1y3pqDU7kaPgw8kRgJnnVraCLYnhWkr8sgrV0ly1sCTF7hQt9NLuqpI+uaxsZu6GZ
         zoVA==
X-Gm-Message-State: AOAM532cE3bNGuGZNiQrBZyhhY4grGRJ7lvnyInc5MAlfHpN8+6Ztxyo
        owv1Du7mUp2I0FGn35eD77HJJwJpVAc=
X-Google-Smtp-Source: ABdhPJztpEVTeEkkf5hE3yVNfXvmkwT/+Zu4P3BxIc6L6WZjRuhoOtmeM1RHQqEa6pGEXpHk3Xxbug==
X-Received: by 2002:a17:906:dfcb:: with SMTP id jt11mr24551003ejc.362.1622504643938;
        Mon, 31 May 2021 16:44:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z7sm6528987ejm.122.2021.05.31.16.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 16:44:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 21/21] t1415: set REFFILES for test specific to
 storage format
Date:   Tue, 01 Jun 2021 01:36:10 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <d7e5de8dba465098afa421d162df5ca7b0fb1a33.1619519903.git.gitgitgadget@gmail.com>
        <87bl95pfnt.fsf@evledraar.gmail.com>
        <CAFQ2z_N=RtSeD6f3a2VPVdDUBxFS1ekC=na=5iVcsWOpkDdORw@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAFQ2z_N=RtSeD6f3a2VPVdDUBxFS1ekC=na=5iVcsWOpkDdORw@mail.gmail.com>
Message-ID: <87sg221nb0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 31 2021, Han-Wen Nienhuys wrote:

> On Thu, May 20, 2021 at 5:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> > -test_expect_success 'refs/worktree must not be packed' '
>> > +# The 'packed-refs' files is stored directly in .git/. This means it =
is global
>> > +# to the repository, and can only contain refs that are shared across=
 all
>> > +# worktrees.
>> > +test_expect_success REFFILES 'refs/worktree must not be packed' '
>> >       git pack-refs --all &&
>> >       test_path_is_missing .git/refs/tags/wt1 &&
>> >       test_path_is_file .git/refs/worktree/foo &&
>>
>> Nit but also chicken & egg: Let's keep the "pack-refs --all" though
>> under reftable in its own test, and do the test_path_* assertions just
>> under REFFILES, i.e. does/should pack-refs warn/error under reftable as
>> redundant, succeed silently?
>
> I don't understand your comment. This test is checking constraints on
> worktrees that are only relevant for loose/packed storage. In fact,
> under reftable, there is no such thing as a "packed ref" storage
> class. This test is just not relevant for reftable, and I tried
> explaining in the comment why this is so. Happy to hear how to further
> clarify this comment.

The chicken & egg part is that reftable isn't landed in-tree yet, so
it's probably pointless to discuss at this point.

But what I was getting at is that while the test when written was trying
to test that the file backend is doing some particular thing, when we go
through our tests to find those cases we should at least make a mental
note (hence my E-Mail) to eventually positively assert the new behavior.

I.e. if pack-refs is a noop shouldn't it warn or something, and then the
tests should check if reftable warn, else do_old_stuff().

In this case one can imagine that e.g. a na=C3=AFve buggy implementation
would check if .git/reftable or whatever exists, which of course with
".git" being a plain file in worktrees won't work, so testing this
particular case somewhere in the worktree tests is probably prudent...
