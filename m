Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DFCC4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FA66109D
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhHaQku (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhHaQkt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:40:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A010C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 09:39:54 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b7so25752699iob.4
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K6sfhfSkh5XeSxm2Ye+dXQ/RWIE3qj6vsM2LqgPm5Yk=;
        b=qS+zRhGgmAmY0gWNAHVfmW7nI97dBU5JFq7g4fVIXoji3dHceLkZYW+yrxGjScnoBL
         yu6mqhyz4FxWB7cR6ikQ+F7OpFOj7+x954TXsgD1z+NOlXM0OMlMr2mWqja+mlaquDWr
         R5tWZgCj/4sA/eMcDlE6XFA9k4YJSt5XJIHbbn6+7ZKTNZvLNOLNzy+q28FbKVs9XtYV
         8ShKRSoUZh57cWQzkDQoDkpoxp/dkwrwrdxkkYFcoBEkMp7rW6lPDSqJsbp5diWSgn0d
         2PimhMhrzkhCa3UhZTnUaUrWmF9vnsF6KZZZIolHeO+9SFZEPgTxfPFOZ8F6EgkB1eSj
         Wpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K6sfhfSkh5XeSxm2Ye+dXQ/RWIE3qj6vsM2LqgPm5Yk=;
        b=REN32Hp/6zhjryRcRD30FMtYR3lDjIyIBNTgQVPnDU0wEuGFtGC1qO1t6Sb6gL742P
         iJAmyyL7AR9BrdbBBGnKzS9mdhLt7EFzqjinjgiI8dDJXDnzDAlTtgbiBvBKYTyBp/5y
         r7AmTGTn7wJ1KAhFdGa1FO92Y1j1wCPUcb4GckENVHv2XgC2fCHGLC6aa15rFk66JvEn
         6eiY8h8EkiV1KL/TJJZ70W8Wni/w80SG44ARvw8VqfoZdfXSLu6nMj2Sd4BZfCCTZtP0
         wcCP7vGjHLcqMW2q1NOIf4lx3C1QcePs1N5Y9IhWYZlEhRn/dcPOl3xLNeN4ZxqzkgXs
         V3Dg==
X-Gm-Message-State: AOAM531HLFguoDw9HOE+srJqMLpmU3HRBAsnXm2AMwXwid1AV3+OyO5d
        08AjHThBbSBNezE+FNAXvUm2QA==
X-Google-Smtp-Source: ABdhPJymwrGhfYg/x5CGoiBB718yqTMTAYZRIO1rUX/0h5hlkl5xNiKV0VyEjpbqtFIIg7mRdSNHYw==
X-Received: by 2002:a02:9695:: with SMTP id w21mr3645339jai.64.1630427993446;
        Tue, 31 Aug 2021 09:39:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m13sm10120053ilh.43.2021.08.31.09.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:39:53 -0700 (PDT)
Date:   Tue, 31 Aug 2021 12:39:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YS5bWMcXbODi+KmS@nand.local>
References: <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local>
 <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <xmqqfsur7otx.fsf@gitster.g>
 <YSwpsp/hQsPFnj+I@nand.local>
 <YS1XOMtj94BcI9HM@camp.crustytoothpaste.net>
 <xmqqmtoy1s9s.fsf@gitster.g>
 <YS1croR3etCfMQhR@nand.local>
 <xmqqmtoxwpad.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtoxwpad.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 09:29:46AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Mon, Aug 30, 2021 at 03:28:47PM -0700, Junio C Hamano wrote:
> >> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >>
> >> > Yeah, this is a possible problem.  You can also see it when using git
> >> > index-pack outside of a repository with an incorrect --object-format
> >> > option.
> >> >
> >> > I'm not sure how folks want to deal with that; I'm just fine saying,
> >> > "Well, don't do that," but other folks may have different opinions.
> >>
> >> OK, so if we go back to the original breakage of the test script
> >> that triggered this discussion, the right solution would be to make
> >> sure both test repositories/object stores are prepared with the
> >> algorithm specified with GIT_TEST_DEFAULT_HASH?
> >
> > Just to make sure do you still see this as a separate issue from running
> > the midx builtin outside of a repository?
>
> They are separate issues, but the .midx issue has a small overlap
> with the much bigger "do not mix repositories and object stores with
> different hashes" issue.

OK, good. Everything you wrote below (which I snipped off in my reply)
makes sense to me, and seems like a worthwhile direction to pursue
outside of this series, especially as more users start using sha256
repositories.

> I think it makes sense for the midx command to require being in a
> repository to run (to establish what "the current repository" is)
> and insist on the other object store given with --object-dir to be
> "compatible" with the current repository (i.e. the same hash
> algorithm, there may be others).  I am a bit fuzzy why we want it
> to be already our alternate.

I don't think there's any strict requirement to the other repository
being our alternate, other than touching arbitrary repositories is a
surprising behavior that appears (to me, at least) to be inconsistent
with the rest of Git.

After (the rerolled version of) this series, we'll be in a state where:

  - `git multi-pack-index` will not run when outside of a Git
    repository.
  - The `--object-dir` argument will only recognize object directories
    belonging to an alternate of the current repository.
  - Using `--object-dir` to point to a repository which uses a
    different hash than the repository in the current working directory
    will continue to not work (as was the case before this series).

I think(?) that there is consensus for that approach, so patches
incoming...

> Thanks.

(Thank you, by the way, for clarifying this all in so much detail. I
would much rather just have code to talk about, but it feels
particularly important to be on the same page beforehand in this
instance, since there is *so much* code, and this discussion is centered
around so little of it).

Thanks,
Taylor
