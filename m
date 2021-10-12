Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774F5C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E9060F38
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhJLWbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJLWbo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 18:31:44 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD69AC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:29:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x25-20020aa79199000000b0044caf0d1ba8so401716pfa.1
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=TXUop9FQna/gArM9lt1/nifcSAazoGTUyIFVc28VVnI=;
        b=Qf60YdL4c/XGmz1nh8UdR0ew0q7TbdUxoQaCM05s9NhIoWbXPOkcoXMDddOMBMN0mQ
         s4n8WIU57dl9qif45/o6s85p5dFkkIPmnPpwpfYGptZgtVivuY2tJ5qRtA4q6TvYoPaR
         mnV4FiSUlXyDxSlZsYuqyanbBQV1jvJNBENlp/ZI/oRwzGeHvg3Bnbm9EzaEYI8PiCwO
         kHcAKvI1NwZ3Ihc2F+l6TGCMPry8mVUZowSCPib4ONmM/Szh0OlwW0LStR0GhT1bVY2Z
         zrWztIBkpnO/NBIeTgLUrWu95N/5J/5C2bgJRc5BBZadoSuSVJ8PI9b9jr3qqnHRn0LV
         eDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=TXUop9FQna/gArM9lt1/nifcSAazoGTUyIFVc28VVnI=;
        b=puWx/97l+BMWyRcm/vdZfcqnNtCtGTIgxbfUkn4bi1b5sd/rIbDzPzwTo6thJ+JNyr
         ek/M0xu0yMFGY7tNqlPqt/daBL6upHeae+xrbjxT7mvE4fLFz0RTqCQLBono/7jqrvPB
         kF2V/0q8qOiSZkhn3coiTx/H5kubPzIk1ENBPHDnbBJcWd/2SjUlc/b23e4Ev3znechp
         kwLc9T4AZcy9kQnRUjN9vFwLOVjIdBqBsBB1HIgHA//HvO0vj+VVWdwUEsnbA9C7Hk0l
         n7umKLaO7qPtAdfhYAxiOFno6M5IGRIoQBBLPSgHYxzzfKRPx0rj3+7VZTRGEt1FhJBu
         UdPw==
X-Gm-Message-State: AOAM530SW5uBBJ11LoAaXSqEq7tx0IMlNiMnO0lKRAO5NGlEnou0tOSp
        3CNa59HdYoGRhz+05/mYSNnqyPGKoWLKAw==
X-Google-Smtp-Source: ABdhPJzQ0CGJkbz9/1R2Ch4IWwwaaK3oANneCGVJN0DdoqNSKWE0bH91okXCjXO7uMw5U2ck25LloMnIa9xz2w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:e40a:0:b0:44d:a86:43ce with SMTP id
 r10-20020a62e40a000000b0044d0a8643cemr17725786pfh.69.1634077782167; Tue, 12
 Oct 2021 15:29:42 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:29:40 -0700
In-Reply-To: <87wnmihswp.fsf@evledraar.gmail.com>
Message-Id: <kl6l1r4p3mi3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211005001931.13932-1-chooglen@google.com> <20211012174208.95161-1-chooglen@google.com>
 <87wnmihswp.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ...how isn't disabling those t3800-mktag.sh tests just plasting over
> corruption that we're noticing because of your changes to (rightly) fix
> the bug where "fsck" wasn't checking the graph at all?
>
> IOW haven't we just found exactly the sort of bug that
> "GIT_TEST_COMMIT_GRAPH" is put in place to find for us, but now instead
> of fixing it we're hiding it?
>
> If I comment yout your addition of GIT_TEST_COMMIT_GRAPH=3D0 in that file
> I see that we fail N number of tests, but all of them are actually
> fallout of just this test:
>
>         git replace $head_parent $head &&=20
>         git replace -f $tree $blob=20
>
> I.e. we've created a replacement object replacing a tree with a blob, as
> part of tests I added to test how mktag handles those sorts of weird
> edge cases.
>
> This then causes the graph verify code to throw a hissy fit with:
>
>     root tree OID for commit 0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 in
>     commit-graph is da5497437fd67ca928333aab79c4b4b55036ea66 !=3D
>     0fbca9850869684085d654f9e1380c9780802570
>
> I.e. when we wrote the graph we somehow didn't notice that the root tree
> node we wrote is to an object that's not actually a tree? Isn't this a
> bug where some part of the commit graph writing should be doing its own
> extended OID lookup that's replacement-object aware, it didn't, and we
> wrote a corrupt graph as a result?
>
> If there is a legitimate reason why we're not just hiding a bug we've
> turned up with these fixes let's disable that one test, not the entire
> test file.
>
> If you don't run the one test that fails (which is split up into 3
> individual pieces) there's still 143 other tests that are run, all of
> those presumably benefit from finding future bugs with
> GIT_TEST_COMMIT_GRAPH=3Dtrue, particularly since the test file seems to
> just have turned up one just now...

I think this falls on my shoulders. I assumed that the failures were
expected behavior, not bugs. You are right that we shouldn't be
plastering over bugs.

I'll have to ask for help here because I don't know enough about mktag
to distinguish between 'expected' and 'unexpected' failures. The best I
can do is to add GIT_TEST_COMMIT_GRAPH=3D0 + NEEDSWORK for the failing
tests. But if that's good enough for now, I'll just do that :)
