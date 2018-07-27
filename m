Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08701F597
	for <e@80x24.org>; Fri, 27 Jul 2018 17:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbeG0SyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 14:54:02 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33600 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbeG0SyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:02 -0400
Received: by mail-yw0-f194.google.com with SMTP id c135-v6so2142888ywa.0
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBAvifPE1k5sDlhTfLMN3zdxA+LOrWLyB1U9Yog9EJE=;
        b=h/PeLS3jLlao8c70J6HDiZH0Gg6oCO8BKEZ4u9uSPD27fVb1r1uDCqTvBfi5VpokXm
         WaR51NJdFf2l/7d3GvZ7fG8/ZZpiIm3gJ6krowYMfV7QYk0zcyaIEcJEt1CdI6dPa0BG
         Nfyvmhl6Frdq5xpSGg9Arb2rhk5+O4jEMlYlG+tr1DXbiysAwRb0HxNz3/64Hi82LC6d
         UR/0nhPwptkbw4gmLFxeyJ94NGzKGZP9bJ0xpqg931oetlg4nwj0IrL/UchxOy1i5lu1
         JHz40JRTcu3ywcWcaK1x2k9o/UEYUJNM+9crAVwXfjdXGV+AQqbJbYLbmmTqY/zYhFf+
         qhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBAvifPE1k5sDlhTfLMN3zdxA+LOrWLyB1U9Yog9EJE=;
        b=Mc7ci8mktJBt3gah9ZlhOA3C20U/2+/vfIidVxDnAg30ZgOP/hPNvre1hoPmoNjujV
         WgZMpomy2UJxersUMZd77+4kXxMh4iar+QZwSzmF8in2fsCL2rWK+lXXOEv/GJ8QWLNH
         nyt0G3V+58dKfA0ASO6Xvw698FBKaGGtuAcCgpDuBTb68FaKRLGj31HFRVsx4doMMBAZ
         21G3kAVL3HXhaJxt+yYXkHqHvS05mXZaX5egxQLaZEbdf6RUj7GJeIxbTvGmMT/aPDbH
         ixafVONIyX0bF3avV5kS5fcmH3maBD5EnGiE3sDEt9C4KoCMb5ZDO4nR6W9uENmrVtq0
         0B9Q==
X-Gm-Message-State: AOUpUlFkbTuixK5HwfBvwMd9GfwJeQpdwZ4gbhWwCLAczEQfuDDwCld7
        xYk9dS8uzO4Sgl7YxFcFskkP6MViqOmoUQ39fK7MLA==
X-Google-Smtp-Source: AAOMgpdOXEhtTeQuOC4eC96LrgVKwkvC5NDMa+MD3pMiF5w0M5x41PgtLIpyk7SkGjjGsfDz8/OKUPTwZwZhaEm+BHE=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr3779711ywj.33.1532712668978;
 Fri, 27 Jul 2018 10:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180727003640.16659-1-sbeller@google.com> <20180727003640.16659-3-sbeller@google.com>
 <CACsJy8Ae3sZvOQ3irQM+hv0fCRchGi8995kvLZBadbaphRo-3A@mail.gmail.com> <20180727171941.GA109508@google.com>
In-Reply-To: <20180727171941.GA109508@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Jul 2018 10:30:58 -0700
Message-ID: <CAGZ79kZfhSwtNgNk-GRDb6f4Uq7y6fi21HVO7xHv1YiuQoaSvA@mail.gmail.com>
Subject: Re: [PATCH 2/3] refs: introduce new API, wrap old API shallowly
 around new API
To:     Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 10:19 AM Brandon Williams <bmwill@google.com> wrote:
>
> On 07/27, Duy Nguyen wrote:
> > On Fri, Jul 27, 2018 at 2:40 AM Stefan Beller <sbeller@google.com> wrote:
> > >
> > > Currently the refs API takes a 'ref_store' as an argument to specify
> > > which ref store to iterate over; however it is more useful to specify
> > > the repository instead (or later a specific worktree of a repository).
> >
> > There is no 'later'. worktrees.c already passes a worktree specific
> > ref store. If you make this move you have to also design a way to give
> > a specific ref store now.
> >
> > Frankly I still dislike the decision to pass repo everywhere,
> > especially when refs code already has a nice ref-store abstraction.
> > Some people frown upon back pointers. But I think adding a back
> > pointer in ref-store, pointing back to the repository is the right
> > move.
>
> I don't quite understand why the refs code would need a whole repository
> and not just the ref-store it self.  I thought the refs code was self
> contained enough that all its state was based on the passed in
> ref-store.  If its not, then we've done a terrible job at avoiding
> layering violations (well actually we're really really bad at this in
> general, and I *think* we're trying to make this better though the
> object store/index refactoring).
>
> If anything I would expect that the actual ref-store code would remain
> untouched by any refactoring and that instead the higher-level API that
> hasn't already been converted to explicitly use a ref-store (and instead
> just calls the underlying impl with get_main_ref_store()).  Am I missing
> something here?

Then I think we might want to go with the original in Stolees proposal
https://github.com/gitgitgadget/git/pull/11/commits/300db80140dacc927db0d46c804ca0ef4dcc1be1
but there the call to for_each_replace_ref just looks ugly, as it takes the
repository as both the repository where to obtain the ref store from
as well as the back pointer.

I anticipate that we need to have a lot of back pointers to the repository
in question, hence I think we should have the repository pointer promoted
to not just a back pointer.
