Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A14C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C392E61107
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 14:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbhDPO4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbhDPO4I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 10:56:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD2AC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 07:55:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u21so42568540ejo.13
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=64595ha+gEL4KK1c7mPi98B8j7HyvmShCMpeqLFf+Pc=;
        b=GJxA/mZw9nAR8oRykoOZHYCcbVUtn6Zmdz9fXkDg0q/PGTrIqvDqfyOmsLn3xBTEqN
         RH84Xr+qD7pHtkpLgrbh+LodUsXeuzE+6I8Qw1wz+/JJlMBWUCFw5s4YhH/MVshHatAk
         IL3jY0iOchGgWuIxIeAFtWe7JG/vbNX5BanTwdWGGR1rHyi+U5MtZtG4R33KSsr2sK+c
         tQay2cZPbS27lO/PRMR3iOWsPaBGdCNe94AddhcVlRIl1V2/npvGnG+7wirmYp+lhNVm
         ymVFgLmDUpW5T60qhZ7r89ADHZ84gsFlqRQ+Uwtt9dRT5KL7Qf8RbfGeLs5u5/+JHcJo
         FZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=64595ha+gEL4KK1c7mPi98B8j7HyvmShCMpeqLFf+Pc=;
        b=gZkrcNdfgf4BPS4ZMKgdsuh8jKASuKA+BB7TxL/g6Z/6N1ZGQDRHWw6X1/h1vrP6kb
         /8kAtXjP9kJHMFMBF9032l12XM2KyHf5cpd4CeIRfTB+cPR4q07wP8lmGQnzJBr5pEum
         rwwIujV1cGlg190Vde99noCx/2rDhcFKdWJq0Z/yJbXdI8CS3YSaRjH8NHGG1antBC4D
         ZYkNTVK8uzISTV7g+SrG1MZswHQW5U9i1kR9NufbC594nL5jcb0TCgl/0lgpZTnX4eNI
         1TnBjIhacKfRRNdNehWdbQzcyLSZMuL/uXr+ZyE8nx/fR2wpp01/1HcVvrzFLoefV8WE
         FsyA==
X-Gm-Message-State: AOAM533QKZqJMZ4VRr5Le2x0e5hV5iSYgu5CgC7Ljl6pz1f6cn4qhup/
        rAGMpMvvz1ECFqNx3P8EjdXYV4E8+hg=
X-Google-Smtp-Source: ABdhPJyI28MuSbA6s+lyf+ilc4pATBVmJTeb1Sdjz1yqS/UqKencIb83BhNWmHarb+9gttID6yfgSA==
X-Received: by 2002:a17:906:1c8f:: with SMTP id g15mr8571203ejh.20.1618584941526;
        Fri, 16 Apr 2021 07:55:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c11sm2677960ede.45.2021.04.16.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:55:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v6 18/20] Reftable support for git-core
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <2dc73bf2ec96acae12a17c719083d11401775bc3.1618255553.git.gitgitgadget@gmail.com>
 <87im4qejpk.fsf@evledraar.gmail.com>
 <CAFQ2z_OSbeciLQnoognG+Hh5S1tZTHO6WUviC9h5YMer766k6g@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAFQ2z_OSbeciLQnoognG+Hh5S1tZTHO6WUviC9h5YMer766k6g@mail.gmail.com>
Date:   Fri, 16 Apr 2021 16:55:40 +0200
Message-ID: <87wnt2th1v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 14 2021, Han-Wen Nienhuys wrote:

> On Tue, Apr 13, 2021 at 9:18 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> [...]
>> I understand that getting this series to land has been a pain, but this
>> sort of thing doesn't inspire confidence.
>>
>> Manually running it under reftable anyway I have 17 out of 81 tests
>> failing. A lot of tests won't run under reftable because they're of the
>> form:
>>
>>         test_when_finished "remove_object $tag" &&
>>         echo $tag >.git/refs/tags/wrong &&
>>         test_when_finished "git update-ref -d refs/tags/wrong" &&
>>
>> I.e. we have some hack to get around update-ref guarding things for us.
>>
>> I would think that a better approach here would be to start with some
>> (per-se unrelated) series to teach update-ref some mode like
>> hash-object's --literally, i.e. "YOLO this ref update".
>
> I disagree.  I think this would be a job better suited to a
> test-helper. Then we don't put tools into users' hands that
> potentially corrupt the repository. I don't understand why hash-object
> --literally is not a test helper either.

I don't feel too strongly either way, and in any case that's a
discussion for any such mass test update series, and separate from the
reftable series per-se.

I do lean on the side of shipping a thing like that as part of our
plumbing, of course with very prominent warnings, just as we do
--literally.

It is useful for not only our test suite, but also for others to
reproduce issues locally with the ref and object store going out of
sync.

Until now there hasn't been much of a need in practice, the file backend
format is trivially understood and you can just echo a bad value to a
file.

But if I or anyone else encounters some Heisenbug in the wild where we
suspect the ref and object store went out of syncy, and we're using
reftable, it would be very handy to test that with an "update-ref
--literally", instead of having to locally recompile git, or otherwise
munge the opaque reftable format.

>> Then adjust our various tests that move, clobber, or intentionally
>> corrupt things in the refstore to use that helper/option.
>>
>> At that point we can actually run things like t1450-fsck.sh, maybe we
>> simply have to skip some of them because we think the sort of corruption
>> we're testing/worried about is impossible with reftable, but that in
>> itself is *very* interesting.
>
> One reason for skipping some files wholesale, is that quite a few
> tests are not isolated in their test functions, so skipping an
> individual test functions affects follow-on tests. I can't remember if
> t1450 is one of them, though.

[...]

>> I.e. do we not have to handle certain edge cases at all in fsck and
>> friends because of inherent properties of the reftable backend (e.g. I'd
>> assume, but don't know, that we're not likely to get one corrupt ref
>> entry with it), but of course we can have a ref pointing to a loose
>> object that then gets removed, and is thus corrupt.
>>
>> Anyway. I'm speculating, but that's also my point, that I'm having to
>> speculate. That comes down to us having a new GIT_TEST_* mode that
>> doesn't pass the test suite._
>
> The speculation is warranted, but there are currently about 80 files
> that have some sort of test failure, and some of these are for quite
> common workflows. I would rather focus on those before looking at
> tests like fsck. Functional failures may have far reaching
> implications on the code structure (example: worktrees considerably
> complicated both the reftable library and its git-core glue), while
> corruption issues if they occur, will be due to localized bugs.

I'm not sure from reading this if/where we disagree, so let's enumerate
and see where we land point-by-point:

 1. The test suite must pass 100% for any new GIT_TEST_X mode as it
    lands.

 2. It must do so in a meaningful way (i.e. not skipping entire files,
    if some/many of the tests are relevant / stress the codepath
    involved)

 3. #2 should be there as the series lands.

My comments on that:

 1: I feel strongly that #1 is an absolute prerequisite for integrating
    this or any other major core surgery.

    E.g. now we can't do any meaningful cross-platform tests for this to
    see how it breaks on our various supported platforms.

    We're also in V6 of this and apparently finding an easily
    discoverable segfault now, if v7 of this had a GIT_TEST_REFTABLE in
    the relevant ci/* code ...

    I realize that that's hard, e.g. we had to do large refactoring for
    all of the commit-graph, protocol v2, sha256 etc. modes, but it
    really pays off. E.g. for protocol v2 upload-pack not paying
    attention to hideRefs was discovered that way.

 2-3: I do think we should have this too, but would be willing to be
      convinced otherwise. E.g. we have a "gcov" target, once we have #1
      passing do we se that under GIT_TEST_REFTABLE=3D1 we have the same
      (or trivially explainable) test coverage, or are we simply
      skipping a large part of the fsck etc. code (some/much of which
      will have to do with refs).

      Even more than test coverage I think this is interesting to see
      what we *don't* cover, as I noted upthread. I.e. can we skip large
      parts of some sanity checking "if (reftable)"? I suspect so, but
      without the coverage we won't be able to tell.

I realize the above would be a lot of work, probably a >50 patch series
to t/* if previous major GIT_TEST_* refactorings are any indication.

But if we agree that's a viable way forward that's not all work that
you'd have to do.

