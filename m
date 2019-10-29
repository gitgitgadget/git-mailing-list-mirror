Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D27E1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 19:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfJ2TGs (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 15:06:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34942 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731435AbfJ2TGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 15:06:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id k2so11634275edx.2
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UDfScaLXqfDYIyrhukmES2FJPD20pZE2eEex4w2jhs=;
        b=b2O2sNwfi2mykGmxlQbZU913crHIOvxsb4xhJKRAbIbLZnFqlU+zG7cUgghuFnpFxe
         BhweoNvqdfB84eqd6JclH3+/JpEY9Ys4//Q2RqRM9m12pRNfKXmVA6J3lWjGfYUyz047
         i6gOjXRGEBGpvWft6c8LrRxXt3At3F8GfOdKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UDfScaLXqfDYIyrhukmES2FJPD20pZE2eEex4w2jhs=;
        b=XyRVb9tZE1K0KPyYIO/zIDVs+iegP6VSklaWGFWrkmo4graTyDG0UP1Y+yGfbRV3rI
         Db2qUx7rhCavN3VX4/DgS9iu3bJIYoUIcwGQ/47YU3weGFBp8YKiGrln45ciygbNcCW1
         C+fmVIdZymHWSrbIoN5gINDNN/erRb+jxZbI54jeu/WPs75QY9Fr6BTID4ch5qJZ8Kny
         mfWCmt1HB+RPFefnu/S7cVojpLlDIrQwVzTlXcwpVqL8swNtD/U7sLGMUt4PFTyIQjXn
         PUAjvM1kRyW0ZjsLSVtjaQRs/llsuCH/TQd/M84apTxDGEPiDb7GHdt3QGY3qcsUzFsx
         WhfQ==
X-Gm-Message-State: APjAAAVD3KI6qj736msLrQhGbIMBYfih7RtcDvH1Ypv91KnJSCeCgsYX
        YCJMuax9JnkyxG9sz4NtZN5b0xBJ7jOesj8kENJ44Q==
X-Google-Smtp-Source: APXvYqw8R3x9agYpVu6dAipf8MqWZDN987THSmtwfWapvgBloIfTmRtbJvF4y2vRP+WlqMk/gzZLnM/k72f8yubeRP4=
X-Received: by 2002:a17:906:d9d0:: with SMTP id qk16mr4879237ejb.70.1572376004608;
 Tue, 29 Oct 2019 12:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
 <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
 <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com> <CAPYzU3N9mDfHVogfq=mhJFj6VOjS2z4ui4msnDdK6pOtVBa_QA@mail.gmail.com>
 <BN6PR21MB078676C4FA54391B1954D5F791660@BN6PR21MB0786.namprd21.prod.outlook.com>
In-Reply-To: <BN6PR21MB078676C4FA54391B1954D5F791660@BN6PR21MB0786.namprd21.prod.outlook.com>
From:   Utsav Shah <utsav@dropbox.com>
Date:   Tue, 29 Oct 2019 12:06:33 -0700
Message-ID: <CAPYzU3NZZ-H_PWcRH_ooXzrYnRNjvF9ayX4_xeMJeMiHB=8fLg@mail.gmail.com>
Subject: Re: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
To:     Kevin Willford <Kevin.Willford@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 12:23 PM Kevin Willford
<Kevin.Willford@microsoft.com> wrote:
>
> On Monday, October 28, 2019 12:40 AM Utsav Shah <utsav@dropbox.com>
> wrote:
>
> > > I wonder if !ce_uptodate(old) should say "this one is up to date and
> > > not modified" when CE_FSMONITOR_VALID bit is set.  Are there other
> > > codepaths that use ce_uptodate(ce) to decide to do X without paying
> > > attention to CE_FSMONITOR_VALID bit?  If there are, are they buggy in
> > > the same way as you found this instance, or do they have legitimate
> > > reason why they only check ce_uptodate(ce) and ignore fsmonitor?
> > >
> >
> > Yes, there are other code paths as well. After reading the code some more, it
> > seems like there's no legitimate need to ignore fsmonitor.
> >
> > > If there isn't, would it make sense to get rid of CE_FSMONITOR_VALID
> > > bit and have fsmonitor directly set CE_UPTODATE bit instead?  That
> > > would make this fix unnecessary and fix other codepaths that check
> > > only ce_uptodate() without checking fsmonitor.
> > >
> >
>
> I would need to go back and see if there was some reasoning why the
> new flag was added but using CE_UPTODATE makes sense especially when
> most calls to ce_mark_uptodate is followed directly by a call to
> mark_fsmonitor_valid.

I've been playing around with the patch and trying to get the tests pass.

I've found that we set CE_UPTODATE when we try to skip worktrees to
stat in the case of sparse checkouts, and there are cases where we
mark cache entries up to date without consulting fsmonitor or stating
them.

It seems like making fsmonitor only modify CE_UPTODATE makes it hard
to verify and test correct fsmonitor behavior and debugging fsmonitor
with git ls-files -f. I think the patch also makes things overall
slightly more complicated.

There is a little more going on in the
> mark_fsmonitor_X than just setting the bit though and the invalid
> calls are not matched with code to clear the CE_UPTODATE flag.

Yeah. The patch to replace CE_FSMONITOR_VALID doesn't remove the need
for calling mark_fsmonitor_valid/mark_fsmonitor_invalid, since there's
special behavior like modifying the untracked cache which doesn't make
sense in a more general mark_ce_not_uptodate function.

>
> The change to use CE_UPTODATE would have
> more extensive effects and like you said we would need to make sure it
> would not cause correctness issues in some corner case.
>
> Did you run all the git tests with GIT_TEST_FSMONITOR set to
> t/t7519/fsmonitor-all?  This will run the tests with fsmonitor on.  I was
> getting multiple failures with this change and fsmonitor on.
>
> I added the refresh_fsmonitor call to the tweak_fsmonitor after
> using the bitmap to set the dirty entries.  This fixed most of the test
> failures but there are still some failures that I haven't tracked down the
> reason for.

I'm getting the same test failures with or without
GIT_TEST_FSMONITOR=t/t7519/fsmonitor-all and calling refresh_fsmonitor
in tweak_fsmonitor. Could you share your patch? I'm probably messing
something up, and I can try taking a look at fixing test cases as
well.

>
> I will do some more digging and testing to see what other pitfalls there
> might be with this change.
>
> Thanks,
> Kevin
