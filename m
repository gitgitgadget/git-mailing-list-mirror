Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28157C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83152073A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHoCeYPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbgJWS1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754793AbgJWS1g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 14:27:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C40C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 11:27:36 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j7so2808866oie.12
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHs7uOYMkc8Fn+R3W6AVrbBpmkfHfRfwmPmnWpJARnA=;
        b=qHoCeYPhieXW/Ir8zWnPOzpp1205z7niTRE/M3yfu9PCtAKd7rJOrX3767DUVf4Bjs
         iEW/CgYEzFW5sCrlL0Vros+ln7dZ3Ry6JNvaGSciRbWFdJmOxlqN1lDUeW5zxClUd9ys
         FXE/uaHoWVnYZ5BSBxealKxeeq4+wWE5l7FRB9N+0Z+DimP0iIc0wsbcDJ+3e66sw6EG
         n5ICHmeH+Sf140yp6zO1uZHeYHKU66B5ygCtuJQW/1/Dt3bnVHxt4KXgAWkzt5MBnuVf
         FcgX+7ukT1xCbR194PZ+qS+C5ZLuyVFmpbDrBEC+aQZ1RWxysDGdZkbmuiR9whbb5n1b
         amcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHs7uOYMkc8Fn+R3W6AVrbBpmkfHfRfwmPmnWpJARnA=;
        b=RcpSbdyRNwZIgchBfpmcXFM/V7iorNy4JlZ8Ctzl2ILJS7+2pa+UJ9e8Knrc8jrscG
         J7YcK0FRaDU6YRwOb0gO2UJiDU9FhaSm8kpRS862icJh1BCLvBxLPQMF+iqoyaXnzvK2
         eQsta/g0YG0m8ALVcWRQRFyHWBcruMrGZ6VAZsW0Amvi2bxCNANNBrMRlNhMl/Ol4DFN
         HPcsUJI5buAM8mM9l2N4suD2u3Si2GaVSWRrEeKCfGqSUaRC8Kh6JS9YBnWpe9MuK24n
         MyY/7e07UK5wMiVuafsUtoCTmDiZXMywxcfoln/voq3/sidhrHeifq38tOx8opB/xvG7
         8uGQ==
X-Gm-Message-State: AOAM533XLKOB9uuyB+7e5SU7LSO8Wc1Bi5bMVB4shT0QzjwxQ5aYBzpD
        MMmF+r/w7eZCtI0oJdPY78yUFB4DMOoZtDO9y5IMzD8Tciw=
X-Google-Smtp-Source: ABdhPJxboKcct4kO+nB3CTkNCP31gezIQl/ERxAP3/O1ut5I6l8BJki6ANoUYuMIpuIS3BTPm7N/XqskC4EI6pEi2kM=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr2591803oic.31.1603477655431;
 Fri, 23 Oct 2020 11:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
 <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
 <xmqqr1pohos4.fsf@gitster.c.googlers.com> <CABPp-BEtBWktGB0ksfk5YLhVDfmUJ-QxUMiYtMANL1KhXd8qTA@mail.gmail.com>
In-Reply-To: <CABPp-BEtBWktGB0ksfk5YLhVDfmUJ-QxUMiYtMANL1KhXd8qTA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Oct 2020 11:27:24 -0700
Message-ID: <CABPp-BGsrMX8brBq4ckhMVmXS7+1A9uaieJfYc3k3mBT4+5xVg@mail.gmail.com>
Subject: Re: [PATCH 1/9] t/: new helper for tests that pass with ort but fail
 with recursive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One more comment...

On Fri, Oct 23, 2020 at 10:25 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Oct 23, 2020 at 9:48 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >

> > And the users are just too pleasant to see, with full of "failure
> > sucess", which is the second best outcome we want to see ;-)
> >
> > > +test_expect_merge_algorithm failure success 'check symlink mo...
> > > +test_expect_merge_algorithm failure success 'check symlink ad...
> > > +test_expect_merge_algorithm failure success 'check submodule ...
> > > +test_expect_merge_algorithm failure success 'check submodule ...
> > > +test_expect_merge_algorithm failure success 'check conflictin...
> > > +test_expect_merge_algorithm failure success 'rad-check: renam...
> > > +test_expect_merge_algorithm failure success 'rrdd-check: rena...
> > > +test_expect_merge_algorithm failure success 'mod6-check: chai...
> > > +test_expect_merge_algorithm failure success '6b1: Same rename...
> > > +test_expect_merge_algorithm failure success '6b2: Same rename...
> > > +test_expect_merge_algorithm failure success '10e: Does git co...
> > > +test_expect_merge_algorithm failure success '12b1: Moving two...
> > > +test_expect_merge_algorithm failure success '12c1: Moving one...
> > > +test_expect_merge_algorithm failure success '12f: Trivial dir...
> > > +test_expect_merge_algorithm failure success '4a: Change on A,...
> > > +test_expect_merge_algorithm failure success 'merge-recursive ...
>
> :-)

Actually, there are another 12 submodule-related tests that pass under
ort but not under recursive, spread across t3512, t3513, t5572, t6437,
and t6438.  I didn't (yet) apply the same change there, so they all
show up as "TODO passed" if you check out the 'ort' branch of my repo
and run the tests with GIT_TEST_MERGE_ALGORITHM=ort.  I delayed
marking them as expecting success under ort because I suspect that
nearby tests should also pass but are just coded too stringently.
(For example, perhaps they expected a directory/submodule conflict to
result in all files within the conflicting directory to be renamed out
of the way instead of expecting the submodule to be moved aside --
moving the submodule aside results in massively less rename handling
pressure and is an easier way to make sure that the files under the
conflicting directory aren't written into and over entries within the
submodule.)

I was hoping to get a submodule expert to look over those tests and
provide some opinions...
