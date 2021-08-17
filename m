Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74565C432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFBC600D4
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhHQVci (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 17:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhHQVci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 17:32:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2BCC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 14:32:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d11so410474eja.8
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FR5Ix+67bcxyRDsD6kbJ84gllsa2RKfoB/Y7HKYnrus=;
        b=KP97NQp6WT40C8ugl3nfmvoX3H8s2xgfzafPK6yHjjPBMTcI2hE+huBEtwCk8WgsM6
         vk/tz3P49o9QmD7doeVaNk2i1D0LBMZJS0hszBMJXgR+GGNj91ICX/jkeW9Lqe4wYXNC
         OSxedXu1hcWyW0O1YUvVn9DzSJ0frUtW06Eg35FBcnroBIja6gcjuHq2wCwQidJstbhl
         sNNF0n986Ltjwt43FRbK63B+fr0gg/hfOddQHcvpiRh33ix4KrHEN4ZFSqMy3wKfKUw6
         cAPexvT60DtoeiqiojysEAVOtfmXGfxPSvprKvmMMkHziuoExwXKcnixuJZFkSvdGlMj
         hg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FR5Ix+67bcxyRDsD6kbJ84gllsa2RKfoB/Y7HKYnrus=;
        b=opsiNPYoXOGssFK2vHys7gKFNH1RXnWxdFngqBUoFXPQFG043YXkOZwiLiuSeID0sZ
         UtZ8iLB+Ni9waMxPYQKmSDobYrc8XcFIWkPBz+hhTGXdFukofKt+AyMblIC+S28KxczY
         2oJrwCni+Ye93VKnh1B/bxhJ0DPN2xckcHA9UPo9laNs6R24ujjUztVdEE1frsLoCVpP
         0uHiIkuymv3KAfEQP4kzguYOqZZSiuPsBAYlY1R3M5NA6KHoxu9C3NVZRx2LDdB06B0g
         k6B+ERnhjaKBtGphCkHwdwwyEzqRS+8xKt8axhYfDEejAhbP8+y6F9pqr5zVQ7HJumNp
         T1Eg==
X-Gm-Message-State: AOAM532a8OLYr0pJgkFrNy9GKxpBOhgGQGAwr1ImjcXdW8lYLB2yJcTW
        XiSLYrxPuk0aVtGndALQR5pM+0CkznY=
X-Google-Smtp-Source: ABdhPJzOFGrj5sPd2ty4Eejl5BSl05ERN6OlVmAe5EenP2Il+9IIuoHRZznpl6MC9dNcuu4DsgXcrw==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr6118029ejw.92.1629235923071;
        Tue, 17 Aug 2021 14:32:03 -0700 (PDT)
Received: from szeder.dev (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id ee29sm1581910edb.63.2021.08.17.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:32:02 -0700 (PDT)
Date:   Tue, 17 Aug 2021 23:32:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/6] tests: disable GIT_TEST_SPLIT_INDEX for sparse index
 tests
Message-ID: <20210817213201.GD2257957@szeder.dev>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210817174938.3009923-6-szeder.dev@gmail.com>
 <6f900a58-19b4-753c-18f5-852eaebc1527@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f900a58-19b4-753c-18f5-852eaebc1527@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 02:26:23PM -0400, Derrick Stolee wrote:
> On 8/17/2021 1:49 PM, SZEDER Gábor wrote:
> > The sparse index and split index features are said to be currently
> > incompatible [1], and consequently GIT_TEST_SPLIT_INDEX=1 might
> > interfere with the test cases exercising the sparse index feature.
> > Therefore GIT_TEST_SPLIT_INDEX is already explicitly disabled for the
> > whole of 't1092-sparse-checkout-compatibility.sh'.  There are,
> > however, two other test cases exercising sparse index, namely
> > 'sparse-index enabled and disabled' in
> > 't1091-sparse-checkout-builtin.sh' and 'status succeeds with sparse
> > index' in 't7519-status-fsmonitor.sh', and these two could fail with
> > GIT_TEST_SPLIT_INDEX=1 as well [2].
> > 
> > Unset GIT_TEST_SPLIT_INDEX and disable the split index in these two
> > test cases to avoid such interference.
> > 
> > Note that this is the minimal change to merely avoid failures when
> > these test cases are run with GIT_TEST_SPLIT_INDEX=1.  Interestingly,
> > though, without these changes the 'git sparse-checkout init --cone
> > --sparse-index' commands still succeed even with split index, and set
> > all the necessary configuration variables and create the initial
> > '$GIT_DIR/info/sparse-checkout' file, but the test failures are caused
> > by later sanity checks finding that the index is not in fact a sparse
> > index.  This indicates that 'git sparse-checkout init --sparse-index'
> > lacks some error checking and its tests lack coverage related to split
> > index, but fixing those issues (let alone making sparse index
> > comparible with split index) is beyond the scope of this patch series.
> 
> s/comparible/compatible.
> 
> I agree that making these two things compatible is not something to
> solve today. I'm not sure they should _ever_ be solved because of
> the complexity involved (what if the base index is not sparse but
> the tip wants to be, or vice-versa?,

I think that this's not an issue, because a shared index file is not
for forever, but it's expected that a new shared index is written
every once in a while anyway, see splitIndex.maxPercentChange.  So
whenever sparse index gets enabled/disabled we could just write a new
shared index accordingly.  Maybe even when the sparse patterns change,
if necessary.

> or if a directory must be expanded because of a conflict?).

I'm not quite up-to-date in sparse index terminology, so I'm not sure
that this means...  but as mentioned above we can just write a new
shared index when deemed necessary.

> They use very different approaches
> to solve a similar problem: how to deal with large index files.
> 
> * The split index reduces index _write_ time by only editing a diff
>   of the base index.
> 
> * The sparse index reduces index _read and write_ time by writing a
>   smaller index, but only if the user is using cone mode sparse-
>   checkout.

Yeah, I think that in general there is more to be gained with sparse
index than with split index, though the split index might further
reduce the write time of a sparse index, because the amount of data
written is proportional with the nr of changed files instead of the nr
of all files in the sparse index.  I'm not sure that it's worth it,
either.

My remarks about compatibility primarily stem from your remarks about
compatibility in response to my sparse vs. split test failure report
in:

  https://public-inbox.org/git/48e9c3d6-407a-1843-2d91-22112410e3f8@gmail.com/

  "the sparse-index is (currently) incompatible with the split-index"

I assumed that that "(currently)" implies that eventually the two will
be made compatible.

Anyway, I'm fine with leaving them incompatible, but 'git
sparse-checkout' should still learn about split index, so it won't
pretend to succeed after it couldn't do what it was asked to when
there is a split index.  Maybe vice-versa as well.

> >  test_expect_success 'sparse-index enabled and disabled' '
> > -	git -C repo sparse-checkout init --cone --sparse-index &&
> > -	test_cmp_config -C repo true index.sparse &&
> > -	test-tool -C repo read-cache --table >cache &&
> > -	grep " tree " cache &&
> > -
> > -	git -C repo sparse-checkout disable &&
> > -	test-tool -C repo read-cache --table >cache &&
> > -	! grep " tree " cache &&
> > -	git -C repo config --list >config &&
> > -	! grep index.sparse config
> > +	(
> > +		sane_unset GIT_TEST_SPLIT_INDEX &&
> > +		git -C repo update-index --no-split-index &&
> > +
> > +		git -C repo sparse-checkout init --cone --sparse-index &&
> > +		test_cmp_config -C repo true index.sparse &&
> > +		test-tool -C repo read-cache --table >cache &&
> > +		grep " tree " cache &&
> > +
> > +		git -C repo sparse-checkout disable &&
> > +		test-tool -C repo read-cache --table >cache &&
> > +		! grep " tree " cache &&
> > +		git -C repo config --list >config &&
> > +		! grep index.sparse config
> > +	)
> >  '
> 
> This test is safe for now.
> 
> >  test_expect_success 'status succeeds with sparse index' '
> 
> This test is being edited in ds/sparse-index-ignored-files. v3
> of the relevant patch was just sent today [1].
> 
> [1] https://lore.kernel.org/git/e66106f7a99d94145eec983ea5e72b7cf8a8a479.1629206603.git.gitgitgadget@gmail.com/
> 
> You might want to rebase on top of that topic. The edits to
> the test are likely stable now.

Oh, no :)  The test 'cone mode clears ignored subdirectories' added in
that patch series (as in 'seen', so not the newes version) fails with
the working GIT_TEST_SPLIT_INDEX=1 as well, and I don't immediately
see why, as it doesn't seem to use sparse index.

