Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A471C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A31960F9E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhH3UJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbhH3UJo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:09:44 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4125C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:08:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso19901624ota.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwEtU9UhtAsEvLTxJTWAAAdLZmJ27Z2vtWXQ6LTAyz4=;
        b=gGD45qJKJ2d6Wn+3r8mBQDYXMMFABjS7Jcx/pfeGF+51bZMVZgqMNz7FOby9qzppsc
         DSw4Xgq+pjowVmDje8cfrPWFAybJvRsU+pKDishz4jtjvYnh32eYUZi9icEoExYdBRtX
         g8c7djz0wY9vdvgpfkA/k1S3qyqGYwIfmu34BsahFXlOxgs5vN2xHJ6OcwVQFEmzL/L0
         ox5p8UJhmRMgArAT2+7N6e4Y8qtD3ioLkOK8fdVHhZlv44TOKJRraokW7TJwu/aQlMNF
         SHS3BiFVNM6GqCx/3QCFTIh0PbUdr+KTbQZrcDJRQgt1FXwVCYDoQo5APlQSqCf/ZLpF
         5Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwEtU9UhtAsEvLTxJTWAAAdLZmJ27Z2vtWXQ6LTAyz4=;
        b=Hd/mpbiVhaB9Ul2TRcgVdhnP+rJ5A/e7Re5d3MfIXd5UahqugA3n71l3a3QCCmwZe/
         lp4CwMtVygh0FS6EZSXCVwGXSdY4crv4wbnCL0/pRq0CzdruHlu1LlXjB8g7Js3vKJkt
         8Qkab27vCnxRFZeyS+gW2B2NZF2AUL+o3jU94YdIXKTp9WSnMtsjWK+CVjwQctHGwOOG
         Wc0AtDgf42mYtNF8YiPpfv+z5eifVTPqzNr09MJkX3rE0ZctiA8vdhHVDe3Bd5G1LEhG
         QMiYv74teLXRD4WHFIKDITpl9fm/M+IFbt+D8Cy/VXILgMOfR2yBvDvAz41iVXkmwvtS
         0tsg==
X-Gm-Message-State: AOAM531V6Mc8KG2musxCpiWJsrHi7eWgjTFL1AqKyrFlPKBJlD7Zh0Wl
        QsOlfDuqQkTS6IunkEWSLiEkHq54iH2pQD1Q/pCsd2XYm0M=
X-Google-Smtp-Source: ABdhPJx+rUYS/c/+3UapD2Vk0wGp6BDe5/1fhjZDz3VV1pdw1f49+BQL+ERmBPOx+3BJG6NGQMX5mdgabXDig2bNSYY=
X-Received: by 2002:a05:6830:b8e:: with SMTP id a14mr20854629otv.162.1630354130122;
 Mon, 30 Aug 2021 13:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com> <b379b8fc61af8a8c39ff8b73aae03ad4999a456c.1629841904.git.gitgitgadget@gmail.com>
 <CABPp-BFcySug2kSvxT7YdJ1Oorza5AfxKPJgMBE2wN8qOw+=Eg@mail.gmail.com> <2870fcb8-a356-c2c2-d084-b560326e1ad4@gmail.com>
In-Reply-To: <2870fcb8-a356-c2c2-d084-b560326e1ad4@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Aug 2021 13:08:39 -0700
Message-ID: <CABPp-BF6-1_AVmuT9bE4wRqqh1p4RAjfK1EqyyRW98sQPYNDyw@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] sparse-index: use WRITE_TREE_MISSING_OK
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 6:19 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/27/2021 5:33 PM, Elijah Newren wrote:
> > On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> When updating the cache tree in convert_to_sparse(), the
> >> WRITE_TREE_MISSING_OK flag indicates that trees might be computed that
> >> do not already exist within the object database.
> >
> > Okay.
> >
> >> This happens in cases
> >> such as 'git add' creating new trees that it wants to store in
> >> anticipation of a following 'git commit'.
> >
> > This doesn't make any sense to me.  Does 'git add' call
> > convert_to_sparse()?  I don't see why it would; wouldn't the calls to
> > convert_to_sparse() come via sparse-checkout init/set commands?  If
> > I'm correct on that, and 'git add' wants to create new trees, then by
> > the time convert_to_sparse() is called in some subsequent git
> > operation, then convert_to_sparse would already have the trees it
> > needs.
>
> If someone adds a change outside the sparse-checkout cone, then the
> index is expanded in-memory, then is converted to sparse when the
> index is written again.

Ah, I missed that convert_to_sparse() is called from write_index(),
and that we are dealing with a single operation that does a
sparse->full (in memory)->sparse roundtrip.

Thanks for clearing that up.

> > I thought the reason you would need this is someone modified and
> > staged a change to a file underneath a directory that will be
> > sparsified away; at the time of convert_to_sparse(), a tree object may
> > not have yet been written for the new tree with the newly modified
> > file (because those tend to be written at commit time), but you'd need
> > it at the time you sparsified.
>
> Yes. I think we are trying to say the same thing.

While writing this, I was thinking in terms of the `git add` being
done when the index was full (both in memory and on disk), and then a
later `git sparse-checkout ...` command would invoke the
convert_to_sparse().  I didn't fully catch the nuances here.

Thanks for bringing me up to speed.
