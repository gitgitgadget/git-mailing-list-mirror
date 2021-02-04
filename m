Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BF0C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB93E64E27
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhBDAFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 19:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhBDAD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 19:03:26 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2518C0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 16:02:10 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id n7so1839934oic.11
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 16:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G80ioGbMJin/gJG5SmV8rP49atYKQXLOUMIXXvhvc64=;
        b=M9z0PfjnIF2cwPnPI5NhOmSAi+t+M3cBeyODDKWpt4GVGLXGAulqDTVy2IqzsPGR0c
         cM24DG5r9YHbLkomu7FcTAOhlVGSxms7kdSKbMcxUOLTlEJH6Wwz1fHF0UnEMYGiWnp3
         iujVflCRNQTZn/db3E2NgQdcNugs0qNbBtZhhr5rW4Nq9djXog71w3dhGCSMCWpOzuF1
         tgzTmsWZk9IiI9K31yYREcFoqrLRhp1NfbnrsedQdfsp43dTQ9Q1/GMIV5LrfYfTcL+h
         pP9WfN0M85OcZo/17EwsbhsnhGFL5PSfBTzhaGN9CCME50/CdVtAnBgWQzDEv62csmKa
         Apvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G80ioGbMJin/gJG5SmV8rP49atYKQXLOUMIXXvhvc64=;
        b=ZHDa/AseexlOPCeBIeJsrfMYWQ8+GSxAC3Y+o2TJr5zhLb5AOclgPa90xZoHs+527G
         lkSFvNd7npwM0KBn6sYvIXB5WjHVZnAKpyivqMLp5LBrN30OqSGNJvB0FsqDQleOI5nu
         YDW8pC68rDPeQMZue6MeyeZpSu71RkpteOWdMLkt4909ZiYDpKkWT75oZPvz3qRShSq2
         K4GxPT3FBgPIug2sm9z7fzXzhFuaKkU281745TnuHDBfoNtnjc3yvvHmISSkLx5Yz+PU
         cBUZR/5RXfWhgx34N6WmgAXsYK+H/1DDtJSUKjYw7/McvVOXOHIX/AtrtkZDTNrSzwfO
         umvQ==
X-Gm-Message-State: AOAM5335sn8OgYdw/nBHLBf+V82rnQo/eKnv6uTax0RQkHXdAPxvwj8b
        dM0E2gVRbkytiUBhrz+KlvLshuuhX2VQ1xuwwVw=
X-Google-Smtp-Source: ABdhPJx6feRi9uarYlEurKeFVBX3og7xFBDe8/fQ7sq4Lb9XFXA5WiZ0xxQy0PTtVBJSapAE2rlSuGq+43o2uJK8qXY=
X-Received: by 2002:aca:db03:: with SMTP id s3mr3639314oig.48.1612396929624;
 Wed, 03 Feb 2021 16:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-8-charvi077@gmail.com> <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
 <CAP8UFD2m18ZemGMkfzFhO1TUrMjNOGuQCqP1KVnRK7JEngeuog@mail.gmail.com> <CAPig+cSBVG0AdyqXH2mZp6Ohrcb8_ec1Mm_vGbQM4zWT_7yYxQ@mail.gmail.com>
In-Reply-To: <CAPig+cSBVG0AdyqXH2mZp6Ohrcb8_ec1Mm_vGbQM4zWT_7yYxQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 4 Feb 2021 05:31:58 +0530
Message-ID: <CAPSFM5d=9yV6TrmuZoJX7SMHpKNUdO=n7f-DJN1q4i__hUChSQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] t3437: test script for fixup [-C|-c] options in
 interactive rebase
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 3 Feb 2021 at 11:14, Eric Sunshine <sunshine@sunshineco.com> wrote:

> > > What is "merge_" doing here? It doesn't seem to be used by this patch.
> >
> > Yeah, it's not used, but it might be a good thing to add this for
> > consistency while at it.
>
> It confuses readers (as it did to me), causing them to waste
> brain-cycles trying to figure out why it's present. Thus, it would be
> better to add it when it's actually needed. The waste of brain-cycles
> and time is especially important on a project like Git for which
> reviewers and reviewer time are limited resources.
>

Okay, I will remove "merge_" from this patch series and maybe later will make
separate patch for it and also adding its tests and updating
t3430-rebase-merges.sh

> > > > +# Copyright (c) 2018 Phillip Wood
> > >
> > > Did Phillip write this script? Is this patch based upon an old patch from him?
> >
> > Yeah, it might be a good idea to add a "Based-on-patch-by: Phillip ..."
>
> Agreed.
>
> > > The implementation of test_commit_message() is a bit hard to follow.
> > > It might be simpler to write it more concisely and directly like this:
> > >
> > >     git show --no-patch --pretty=format:%B "$1" >actual &&
> > >     case "$2" in
> > >     -m) echo "$3" >expect && test_cmp expect actual ;;
> >
> > I think we try to avoid many commands on the same line.
>
> For something this minor, it's not likely to matter but, of course, it
> could be split over two lines:
>
>     -m) echo "$3" >expect &&
>         test_cmp expect actual ;;
>
> > >     *) test_cmp "$2" actual ;;
> > >     esac
> >
> > In general I am not sure that using $1, $2, $3 directly makes things
> > easier to understand, but yeah, with the function documentation that
> > you suggest, it might be better to write the function using them
> > directly.
>
> The direct $1, $2, etc. was just an example. It's certainly possible
> to give them names even in the rewritten code I presented. One good
> reason, however, for just using $1, $2, etc. is that $2 is not well
> defined; sometimes it's a switch ("-m") and sometimes its a pathname,
> so it's hard to invent a suitable variable name for it. Also, this
> function becomes so simple (in the rewritten version) that explicit
> variable names don't add a lot of value (the cognitive load is quite
> low because the function is so short).
>

Agree, and will update it.

> > > Style nit: In Git test scripts, the here-doc body and EOF are indented
> > > the same amount as the command which opened the here-doc:
> >
> > I don't think we are very consistent with this and I didn't find
> > anything about this in CodingGuidelines.
> >
> > In t0008 and t0021 for example, the indentation is more like:
> >
> >      cat >message <<-EOF &&
> >           amend! B
> >           ...
> >           body
> >      EOF
> >
> > and I like this style, as it seems clearer than the other styles.
>
> I performed a quick survey of the heredoc styles in the tests. Here
> are the results[1] of my analysis on the 'seen' branch:
>
> total-heredocs=4128
>
> same-indent=3053 (<<EOF & body & EOF share indent)
>
>     cat >expect <<-\EOF
>     body
>     EOF
>
> body-eof-indented=24 (body & EOF indented)
>
>     cat >expect <<-\EOF
>         body
>         EOF
>
> body-indented=735 (body indented; EOF not)
>
>     cat >expect <<-\EOF
>         body
>     EOF
>
> left-margin=316 (<<EOF indented; body & EOF not)
>
>         cat >expect <<\EOF
>     body
>     EOF
>
> So, the indentation recommended in my review -- with 3053 instances
> out of 4128 heredocs -- is by far the most prevalent in the project.
>
> [1]: Note that there is a miniscule amount of inaccuracy in the
> numbers because there are a few cases in which heredocs contain other
> heredocs, and some scripts build heredocs piecemeal when constructing
> other scripts, and I didn't bother making my analysis script handle
> those few cases. The inaccuracy is tiny, thus not meaningful to the
> overall picture.
>

Okay, will update the indentation.

[...]
> > >     fixup-*)
> > >         action=$(echo "$line" | sed 's/-/ -/');;
> >
> > I agree that "fixup" arguments are not arbitrary at all, but I think
> > it makes things simpler to just use one way to encode spaces instead
> > of many different ways.
>
> Is that the intention here, though? Is the idea that some day `fixup`
> will accept arbitrary arguments thus needs to encode spaces? If not,
> then mirroring the treatment given to `exec` confuses readers into
> thinking that it will/should accept arbitrary arguments. I brought
> this up in my review specifically because it was confusing to a person
> (me) new to this topic and reading the patches for the first time. The
> more specific and exact the code can be, the less likely it will
> confuse readers in the future.
>

I also agree that fixup will not accept arbitrary arguments, So I think to
go with the method using fixup-*) (as suggested above).

[...]
> > Yeah, perhaps the global "expected-message" could be renamed for
> > example "global-expected-message", and tests which need a specific one
> > could prepare and use a custom "expected-message" (maybe named
> > "custom-expected-message") without ever changing
> > "global-expected-message".
>
> That would be fine, though I wondered while reviewing the patch if a
> global "expect-message" file was even needed since it didn't seem like
> very many tests used it (but I didn't spend a lot of time counting the
> exact number of tests due to the high cognitive load tracing how that
> file might mutate as it passed through each test).
>
> Another really good reason for avoiding having later tests depend upon
> mutations from earlier tests, if possible, is that it makes it easier
> to run tests selectively with --run or GIT_SKIP_TESTS.

Agree, also for this patch series I think to remove all tests for
amend!, change the
test setup and will take care this time to remove the test dependency
(in case of expected-message).

Thanks and Regards,
Charvi
