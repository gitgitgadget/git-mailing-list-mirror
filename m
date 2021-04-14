Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B460C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 16:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4DE61153
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 16:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349809AbhDNQpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhDNQp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 12:45:29 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B66C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 09:45:07 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id b18so5490289vso.7
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XhLFyGej0TFreHdgHNoLarcVf7a0w0UTLLwpKBal5TI=;
        b=RPAglbbleZKmrjj+WxD/6IrjkeyqecOQNwbAQsRXmveJ6u3nQeCNNCzOa9tEZ51rc3
         vWz1FFbs6qL5aSd4K/j589CsC4pHHBTydnXAapINlh+cQXThpMcaZ/fWoVIBrYtGhjoZ
         evS1Y8683OGRePIun8Bzfj9aRHJBVdHNYLvFGpRVJAPH9MsNqB36NDUR2Wu6Slw5BYcZ
         PGU2rjnUhNm7Jbqz0tmk+X7PRnZkem4cycMMO5e7xxe4G528VJgI3zLrnSV4MtgXPnYs
         ZOoyAch3VRhHlxL50PI91nECgvkG05z2ZInZpvYNfsKrTcKz5OxF6zmOyvrKnelj9qu/
         nJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XhLFyGej0TFreHdgHNoLarcVf7a0w0UTLLwpKBal5TI=;
        b=HB6KqP3npEHR/Kbxz4xdFC5x83a5TOJfgDn5e6pS+70TIbisdNn0kUGhSzGq/hW8GQ
         s85kHPLoHYy7CzJoVuHzRfq/rR9LXoAhfPARlJFLxv6b4ET25NLXLbvADiqR0aUBpJuD
         tmCZDlsGMaXQSyYj9YFI3Umt2jEJi/cIZC1/7JmPEMAWFKfgy9MwAMaBIrkP/8taEJNj
         G67EYFQzlbU/FgcGq21M/7TXFKUXb8qHbUQGDctcXu9P5oyx4NXF2LQuiUs6QKy9bR48
         EOTXOavTs7VVg4tUskDuf44FnwUHh1P4101/bNvsM3Jcb3ET1UdxC1d6IHsgunWIOoNr
         s8ww==
X-Gm-Message-State: AOAM530h9J4u6hqA9z5Ewt81IKy8d3kgRE8A/lzt7G28hjxH4tH1yi1A
        s07JYSpDO0Qvqfj8TVPd4lxPp3nijJ1vCCC9UZ6caA==
X-Google-Smtp-Source: ABdhPJygZ3kjQkaiduuJHXOSCzuKU887puP8yWL8tSODhELsmdeJR7UDreA0gmErOmwjc8KCE9X4rvKLhnmXfoNKoeE=
X-Received: by 2002:a67:fd68:: with SMTP id h8mr12284673vsa.54.1618418706516;
 Wed, 14 Apr 2021 09:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com> <2dc73bf2ec96acae12a17c719083d11401775bc3.1618255553.git.gitgitgadget@gmail.com>
 <87im4qejpk.fsf@evledraar.gmail.com>
In-Reply-To: <87im4qejpk.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 14 Apr 2021 18:44:54 +0200
Message-ID: <CAFQ2z_OSbeciLQnoognG+Hh5S1tZTHO6WUviC9h5YMer766k6g@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] Reftable support for git-core
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 9:18 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > It can be activated by passing --ref-storage=3Dreftable to "git init", =
or setting
> > GIT_TEST_REFTABLE in the environment.
> > [...]
> > +const char *default_ref_storage(void)
> > +{
> > +     const char *test =3D getenv("GIT_TEST_REFTABLE");
> > +     return test ? "reftable" : "files";
> > +}
>
> Nit: use git_env_bool() here. So GIT_TEST_REFTABLE=3Dtrue is true, but
> GIT_TEST_REFTABLE=3D is not.

thanks, adapted this.

> Not a nit: are these tests supposed to work / do they work for you? For
> me there's a *lot* of failures, e.g. t6120-describe.sh fails for reasons
> you might expect, manually tweaking things in the FS-refstore, but
> e.g. t5510-fetch.sh segfaults.

I'll have a look; segfaults should not happen, of course.

> > +if test_have_prereq REFTABLE
> > +then
> > +  skip_all=3D'skipping tests; incompatible with reftable'
> > +  test_done
> > +fi
> > +
>
> I understand that getting this series to land has been a pain, but this
> sort of thing doesn't inspire confidence.
>
> Manually running it under reftable anyway I have 17 out of 81 tests
> failing. A lot of tests won't run under reftable because they're of the
> form:
>
>         test_when_finished "remove_object $tag" &&
>         echo $tag >.git/refs/tags/wrong &&
>         test_when_finished "git update-ref -d refs/tags/wrong" &&
>
> I.e. we have some hack to get around update-ref guarding things for us.
>
> I would think that a better approach here would be to start with some
> (per-se unrelated) series to teach update-ref some mode like
> hash-object's --literally, i.e. "YOLO this ref update".

I disagree.  I think this would be a job better suited to a
test-helper. Then we don't put tools into users' hands that
potentially corrupt the repository. I don't understand why hash-object
--literally is not a test helper either.

> Then adjust our various tests that move, clobber, or intentionally
> corrupt things in the refstore to use that helper/option.
>
> At that point we can actually run things like t1450-fsck.sh, maybe we
> simply have to skip some of them because we think the sort of corruption
> we're testing/worried about is impossible with reftable, but that in
> itself is *very* interesting.

One reason for skipping some files wholesale, is that quite a few
tests are not isolated in their test functions, so skipping an
individual test functions affects follow-on tests. I can't remember if
t1450 is one of them, though.

> I.e. do we not have to handle certain edge cases at all in fsck and
> friends because of inherent properties of the reftable backend (e.g. I'd
> assume, but don't know, that we're not likely to get one corrupt ref
> entry with it), but of course we can have a ref pointing to a loose
> object that then gets removed, and is thus corrupt.
>
> Anyway. I'm speculating, but that's also my point, that I'm having to
> speculate. That comes down to us having a new GIT_TEST_* mode that
> doesn't pass the test suite._

The speculation is warranted, but there are currently about 80 files
that have some sort of test failure, and some of these are for quite
common workflows. I would rather focus on those before looking at
tests like fsck. Functional failures may have far reaching
implications on the code structure (example: worktrees considerably
complicated both the reftable library and its git-core glue), while
corruption issues if they occur, will be due to localized bugs.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
