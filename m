Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190ADC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E3661108
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbhIIXMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbhIIXMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:12:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC3BC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:11:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso112070pji.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wkevs5khqBKhFXSFz1meRE98ReFOceYCGvbFXMVzMGs=;
        b=HecCuBXQKk1SvzZApoGWV4ah36qq2tUFW+BUbmK+tBFSRDkjH6UPBiexidzM+9b5Jg
         ulxH4fh68j8gtUnPsjAG/eBM5fSqIcoFxUWJkKvFhMmKglnMIYgkpPJoTBAifD4d9rGV
         Fk9N6i6q+QGDUCc+8eBxlY8vSghdLQ0WlEpx1VGyw7ngxwdf1Qf3xWolJoM9HJoXgSym
         ro8P2Nw1lCY4teFYA5PPw/gv8LoCqGSGSqld7QnrDArzEk0eMT+uWmrmVNxiR+Lgwb0Q
         5QnnOhputtzrcRepjFMEjDAc82QQKzMh6EwYOyGxP5aJ9v1yfoawmb0JvwR/BiQf1w5b
         l4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wkevs5khqBKhFXSFz1meRE98ReFOceYCGvbFXMVzMGs=;
        b=dPJt+E6ybbQaWAV4h+/RQq7DEH68EVHRpWNwfVRDJUs5GfAmtP03dvNn/01rXwFtax
         UeSIZ82+9acdNl0kTdcCfhL+xHoiRVw7o3Di3+AAe1x0Gwp/++ytN7HKePjRIKCUijSi
         5SIA6VaXGeA34PyWfDX0Bu2b71GSxsast/R4ufcp76JW0qu52jOwh+eXcjnZHHSFREIM
         U7+i/CkB9A5gxvmvkOQfgzLkhAq7JYLxkHmW06J/aCSuF3xXKTBBfhVS47HegEgJ/EJY
         kYsZLTkPzCHBOYeh8U61ac1PfqxAcc/aF5gDqWzWzoTxWMyKPHcm8Cx6krLwsY/NgVSL
         pnJA==
X-Gm-Message-State: AOAM530gesqbq9emE/1iv3c/gXKPmMuT5hmO0m8tDVtOF48GtVj+9dAC
        VKEI01OOxLzykubR8SfUPxMdsQ==
X-Google-Smtp-Source: ABdhPJz21YB/QxCzLYwTPl2FTmBVc8uCHepwyD31TuYoCjk7myPpo/3uAjxj2JXY7XxqwBpFW4K/tA==
X-Received: by 2002:a17:903:2284:b0:138:a6d8:117f with SMTP id b4-20020a170903228400b00138a6d8117fmr4812324plh.29.1631229062208;
        Thu, 09 Sep 2021 16:11:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:9b9a:8ffe:4c52:3843])
        by smtp.gmail.com with ESMTPSA id i8sm3279434pfo.117.2021.09.09.16.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:11:01 -0700 (PDT)
Date:   Thu, 9 Sep 2021 16:10:56 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Andrzej Hunt <andrzej@ahunt.org>,
        =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/3] add a test mode for SANITIZE=leak, run it in CI
Message-ID: <YTqUgOcNYGl8Nljp@google.com>
References: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
 <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
 <xmqq35qf72jp.fsf@gitster.g>
 <87sfyfgtfh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfyfgtfh.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 02:03:30PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Sep 08 2021, Junio C Hamano wrote:
> 
> > Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> >
> >> We can compile git with SANITIZE=leak, and have had various efforts in
> >> the past such as 31f9acf9ce2 (Merge branch 'ah/plugleaks', 2021-08-04)
> >> to plug memory leaks, but have had no CI testing of it to ensure that
> >> we don't get regressions. This series adds a GIT_TEST_* mode for
> >> checking those regressions, and runs it in CI.
> >>
> >> Since I submitted v2 the delta between origin/master..origin/seen
> >> broke even t0001-init.sh when run under SANITIZE=leak, so this series
> >> will cause test smoke on "seen".
> >>
> >> That failure is due to a bug in es/config-based-hooks [1] and the
> >> hn/reftable topic, i.e. these patches are legitimately catching
> >> regressions in "seen" from day 1.
> >
> > So is there a point in sending this out to the list, before sending
> > fixes to these broken topic and making sure they get corrected?
> >
> > Because the CI does not "bisect" to tell us "ok, up to this point in
> > 'seen', all the topics merged play well together", the overall
> > effect in the bigger picture is that 'seen' with this series would
> > cause CI to stay in failed state.
> >
> > For now, I'll keep this near the tip of 'seen'.
> 
> The breakages with it are in combination with:
> 
>     ab/config-based-hooks-base
>     es/config-based-hooks
>     hn/reftable
> 
> You've got v4 of ab/config-based-hooks-base, the v5 is at [1], but we've
> been waiting on emily to re-roll hers on top. As noted in that E-Mail
> I've got a working re-roll of it as
> avar-nasamuffin/config-based-hooks-restart-3 in my repo.
> 
> That'll leave hn/reftable, which given [2] I thought you were planning
> to eject, and wiht the number of fixups for it / the planned re-doing of
> it by Han-Wen[3] maybe it's better to do that now?
> 
> What do you think about that plan?
> 
> I.e. ejecting hn/reftable while waiting on a re-roll, and either
> ejecting es/config-based-hooks while waiting, or I can submit the
> avar-nasamuffin/config-based-hooks-restart-3 I've got pending Emily's
> own re-roll (which may or may not be different from that).

My own reroll is waiting on some feedback internally and probably won't
show up this week at all, so I suggest to kick mine out and prioritize
the reftable stuff for now.

 - Emily

> 
> That along with picking up the v5 of my ab/config-based-hooks-base
> should make "seen" pass with SANITIZE=leak on these tests, unless
> there's other just-introduced regressions. I tried re-building it a few
> days ago, I haven't done that just now.
> 
> 1. https://lore.kernel.org/git/cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com/
> 2. https://lore.kernel.org/git/xmqq4kaxe5dt.fsf@gitster.g/
> 3. https://lore.kernel.org/git/CAFQ2z_N8pUsp3cdBpybHBD-V9_1sARCZvSxr0UkMfcwCoQfCbw@mail.gmail.com/
