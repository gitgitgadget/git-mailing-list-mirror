Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF9C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 14:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FB661212
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 14:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhKKOs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 09:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhKKOs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 09:48:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456C3C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 06:45:39 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z21so25091923edb.5
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 06:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DBB2En2BOVV8HUA0ynsBhVtMzcG+Qdao0aALGwXGpAM=;
        b=kf1nNwIEe/yuFR6kIQycd3jPG305HdxfuTsuPcedd5k+2E+6q7REZ9bEmdxkVHGKZf
         N1bAq8pNGisc19/j7siLhUkZZuQqGXgn1jYSezgW/YpAvuNHe5NI32zsxvnzL4ihtzWD
         vA/08X6NukNKeX8Favr/TgO5yzvV88WvOSXUWLT4hCQY5ncRNhgDcgKpapLXXpVG7wZ9
         fbYvUeQ8CYcRqpQiSa5wSIUMHn4XLqpZOMW72/XdrNMo1ohLamcCm3HI93hz48K5uNFq
         ilAY7V9U+/hYv+u0rlOggtBeV0BYDTwUrj1EszsOEg4BlhVu8KfaYg+u5CZxoeowS0L0
         ExdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DBB2En2BOVV8HUA0ynsBhVtMzcG+Qdao0aALGwXGpAM=;
        b=NgHthalNOlBj2sRJP8q1F7wLPE9nXRF1/XVWPQwzejLIdTirlJFQ0Bc8Rq1ZIs8gdm
         xi7HQzZ82ABfnv3R5ZGWzTo3wWizBYRLOlBYLZaaJ4AqcGr+l+qXYXVMMcsPbtyO+rcz
         miV0NGu186m/91pOwX7aI62SdTGiGnrJSQtuHIbw9J0cQYfRhRdtpSoL84CcMFLOTri/
         pjXOP3qJcwL9c/P2/227qyKt7TZtoFDhJdm2n/9s7mAHS0xhVRTjt+d0U7psBtPxdPHC
         VGNnMfhOO9SNqk0BcDZuBZjMx6FcsSkOx5Ke5+cqF/o5d8xuzd0ns8I2BXGBi3eyfrX2
         sKhg==
X-Gm-Message-State: AOAM530YCYof1qH+amKWLJFohzJ12BJESlDVcZ2Ite/Zh4l012AHNJvQ
        QkaA1VDLqvqO+At+UeKzRMw=
X-Google-Smtp-Source: ABdhPJz6ER4pGTH7ivSTyz6w2DZ+XCZbrpzxA/gL5IeBK0LoWGwEQUv+nIJWgHasuIAtY5EKpT+DGg==
X-Received: by 2002:aa7:ca0a:: with SMTP id y10mr10770694eds.148.1636641937647;
        Thu, 11 Nov 2021 06:45:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb2sm1495372ejc.52.2021.11.11.06.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:45:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mlBKZ-0008VR-TG;
        Thu, 11 Nov 2021 15:45:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/7] Gets rid of "if reflog exists, append to it
 regardless of config settings"
Date:   Thu, 11 Nov 2021 15:38:56 +0100
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
 <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
 <CAFQ2z_PAs3fG1h31KWVXJ=02t1i9UvWPuD4tCK-ZWfewkPQJEw@mail.gmail.com>
 <xmqqk0iqrp4q.fsf@gitster.g> <xmqqfsterotr.fsf@gitster.g>
 <xmqqbl40razw.fsf@gitster.g>
 <CAFQ2z_NASfhdHdZrY3gK29LRK_8Guj0LZ=GgCr84k7XX2L+Dow@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAFQ2z_NASfhdHdZrY3gK29LRK_8Guj0LZ=GgCr84k7XX2L+Dow@mail.gmail.com>
Message-ID: <211111.86k0hevjhs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 11 2021, Han-Wen Nienhuys wrote:

> On Thu, Oct 7, 2021 at 7:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > Not really.  I think the comment on the RFC still stands, and I do
>> > not recall seeing a response to the point.
>> >
>> >     One potential harm this change will bring to us is what happens to
>> >     people who disable core.logAllRefUpdates manually after using the
>> >     repository for a while.  Their @{4} will point at the same commit no
>> >     matter how many operations are done on the current branch after they
>> >     do so.  I wouldn't mind if "git reflog disable" command is given to
>> >     the users prominently and core.logAllRefUpdates becomes a mere
>> >     implementation detail nobody has to care about---in such a world, we
>> >     could set the configuration and drop the existing reflog records at
>> >     the same time and nobody will be hurt.
>
> A git 'reflog disable' command would address your concerns, but it is
> a destructive operation, so the cure might be worse than the solution.
>
>> IIRC, the only reason why reftable implementation may want to change
>> the behaviour we have to avoid getting blamed for breaking is
>> because it cannot implement "a reflog exists, and we need to record
>> further ref movements by appending to it, no matter what the
>> configuration says" when the existing reflog is empty, because its
>> data structure lacks support for expressing "exists but empty".
>>
>> I think the behaviour change described in the title of this message
>> can be limited in the scope to hurt users a lot less, and can still
>> satisfy the goal of helping reftable not getting blamed for
>> breakage, perhaps by making the behaviour for an empty but existing
>> reflog unspecified or implementation defined per backend.
>
> If we accept implementation-dependent features, we could just leave
> the whole feature as is. I had expected more breakage, but there is
> only one test case in t1400 that needs addressing. If the test
> coverage reflects the popularity of the feature, it should be fine to
> leave this divergence in, and mark the test with REFFILES.
>
> The commits prior to the RFC should be OK for committing. In
> particular, there is a bugfix for the show-branch command. Should I
> resend those separately?

I've got some follow-up patches to what's sitting in "next" already that
hoist some reffiles-specific stuff into builtin/reflog.c, I haven't
tested but I expect that the behavior change is silent now in the
reftable backend, i.e. it doesn't implement progress/verbose the same
way, presumably.

Between that and 5ac15ad2509 (reflog tests: add --updateref tests,
2021-10-16) & 52106430dc8 (refs/files: remove "name exist?" check in
lock_ref_oid_basic(), 2021-10-16) I wouldn't put too much faith in those
reflog tests.

None of that should be a blocker for your series landing, just say'n. I
don't trust those tests.

IMO the only meaningful way to be confident in testing these sorts of
things with reftable is more of the chaos monkey approach of the
GIT_TEST_* modes, i.e. we now have a WIP mode to do that for reftable
that has known breakages.

We could similarly instrument the test suite to do "git reflog expire"
for each ref at the end of tests, a bunch of things would break, but we
could log the complete -V run and see if what breaks is different under
the two backends.

I've got some WIP patches to add a similar chaos mode using "git gc
--auto", and it turned up some interesting stuff. It's what I used
initially to test what's now landed in ae35e16cd43 (reflog expire: don't
lock reflogs using previously seen OID, 2021-08-23).
