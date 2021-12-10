Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D5EC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhLJDTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhLJDTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:19:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4CBC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:15:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y12so25165161eda.12
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IxHTXQ0q4ER7BBoZ4qR0d7PuMwSzrB+LzME1qXtBOHE=;
        b=W1L4kMueRY1q2TN301KT6zlZ6ZuLX4rtqo4L8x/wVua4OWD9l7kFQqlV76thmZNQgN
         DmJH8HznPcAKYii8lgVfivSo7oCnAJ0kIgY9E62Lk1WC5bvocpdyVhXUsFzkRLr4Zyvb
         uvug/hW3k6Mtr73Ijg+AE+nSaqrHvQkekE6AW5YaXKAa6ZNoFH6ooZIzOoW0GkS8LyAO
         /GUWbW+Kmso9C/BDH7YzuVQZpKUlzP460ba6UPBmJJ4HFSDY5RqMrJUDyzRY5AxRj0Zc
         EV2xaNrQP8ARxNeYO5CXu21Fv3c+p9i2E36+4ne0eOfiTnHB94gEoNPViHQGN74RIORU
         qJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IxHTXQ0q4ER7BBoZ4qR0d7PuMwSzrB+LzME1qXtBOHE=;
        b=lH67FwRFK1HePD46kwAJiClBaI3ZQ/sQIYjr2MGiLXhWCyXUwWsRkQ9NHaS4pGPwrf
         DmqNS9tC/AhasHqWSEqkVDPOx/AHGX2F6aCmiVczatdMoq1JI6yw7w1RwwhpZ+wp98xq
         akTH5S8IqKgvIe1eDJCJTzqpi9qWh2hYHhS2aHjpMEJ54Ur0JsUre+brNLxfJpuxyB2u
         X9pQBC3N3regcnuOVt+AXWaoQh0WG4t5XLY9GDhpQfIW0laCzlhQyrT0v0/KZtsFOW4F
         kH9GlbcAWzU4khQJC3zTt60vZpEOkEueD/CQMgfDlUvR05Esytj/SzDy1tEyokeFDdXX
         X3Aw==
X-Gm-Message-State: AOAM531bpVCePT+dAUe43MflTbKRVyHOTA6fXJb3KdszXlOe8y6V0i94
        RiLR06ckk3L661YV0R2dumc=
X-Google-Smtp-Source: ABdhPJyBOyX6u/SaHfHPJFcGLi0lz61ude3a5a/WaNKWjLbyDZAU4WgdBGgP+2v8Hwe2u1bkZmDhmg==
X-Received: by 2002:a17:907:8a1b:: with SMTP id sc27mr20821292ejc.572.1639106134876;
        Thu, 09 Dec 2021 19:15:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z25sm747086ejd.80.2021.12.09.19.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:15:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvWNh-000AwD-LX;
        Fri, 10 Dec 2021 04:15:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Date:   Fri, 10 Dec 2021 03:38:53 +0100
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
        <211209.86fsr2l8vn.gmgdl@evledraar.gmail.com>
        <xmqq4k7htzpk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq4k7htzpk.fsf@gitster.g>
Message-ID: <211210.86a6h9duay.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 09 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> So, how about doing it this way?  This is based on 'master' and does
>>> not cover contrib/scalar, but if we want to go this route, it should
>>> be trivial to do it on top of a merge of ab/ci-updates and js/scalar
>>> into 'master'.  Good idea?  Terrible idea?  Not good enough?
>>
>> With the caveat that I think the greater direction here makes no sense,
>> i.e. scalar didn't need its own build system etc. in the first place, so
>> having hack-upon-hack to fix various integration issues is clearly worse
>> than just having it behave like everything else....
>
> We decided to start Scalar in contrib/, as it hasn't been proven
> that Scalar is in a good enough shape to deserve to be in this tree,
> and we are giving it a chance by adding it to contrib/ first, hoping
> that it may graduate to the more official status someday [*].
>
> And 'test-extra' is a way to give test coverage to things already in
> contrib/ that has 'test' target in their Makefile.  When js/scalar
> gets merged to a tree with 'test-extra' target, it may be tested in
> that target, too, because we want to have it behave like everything
> else.
>
> [Footnote]
>

I'm referring to the divide between testing things in CI v.s. "make
test" making no sense. Not the path at which scalar is stored in-tree,
which I don't care about, except insofar as it's used as a proxy for
behavior that doesn't make sense.

Scalar uses libgit.a, and is built by default in the js/scalar topic. So
we don't have a choice to really ignore it. E.g. there's part of the
refs.h API used only by it. If you're changing that API you need to test
against scalar.

Which makes sense, and I'd like to have scalar in-tree.

I just don't think it makes any sense that I edit say refs.[ch], run
"make test" locally, but only see that something broke in scalar's
specific use of libgit.a later when I look at GitHub CI.

If you're preparing a series for submission you'll need to get the CI
passing. Except for portability issues etc. it should be trivial to run
the same set of tests locally as we run in CI, that's the case now with
any change you make to libgit and its consumers.

With the scalar topic we lose that 1=3D1 mapping. I don't think doing that
in the name of it living in contrib makes sense.

If I'm preparing patches for submission I'll need to get CI passing, so
I'll need to fix those tests & behavior either way as it's
in-tree. Knowing about the failures later-not-sooner wastes more time,
not less.

> *1* You may not like the "try unproven things in contrib/ first and
>     then we may graduate it later" approach, but that particular
>     ship has sailed and this is not a time to complain and waste
>     project's time.

We have t/t9902-completion.sh testing contrib/completion/, and we run
that under "make test" and in CI alike, the same goes for
t/t1021-rerere-in-workdir.sh and contrib/workdir/git-new-workdir, we've
got similar (but optional) tests for contrib/credential in t/ too.

The reason we do that with the completion is because some changes to
e.g. tweak getopts will need to have a corresponding change to the
completion.

The reason we've not done that with contrib/{subtree,mw-to-git}/ is
because those are thoroughly in the category of only incidentally being
in-tree.

I.e. we don't have any reason to think that testing those would stress
core features of git itself any more than testing say out-of-tree
software like git-lfs or git-annex.

Testing those is still interesting, but that's for the benefit of that
software itself not bitrotting, not that we're likely to introduce
in-tree breakages by changing an API and missing one of its users.

Scalar is thoroughly on the "completion" side of that divide, not
"subtree".
