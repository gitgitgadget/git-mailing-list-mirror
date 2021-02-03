Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F0C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D6B64F68
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhBCFpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 00:45:36 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:42663 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhBCFpe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 00:45:34 -0500
Received: by mail-ej1-f45.google.com with SMTP id r12so33671825ejb.9
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 21:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKfiiSIhHS9XosDD9bQtHFrrLvNdepjT+3d42JF5AVQ=;
        b=OKJgzhDYijovzJ+95LNvAnoCnoyjes1ZkO97lZA/Mst99du9Le4t1YWlRGkd31IORB
         K2wCam3txFx7mauGw53SmSUfKDkWKLpbabdYgHc35myVTOH8w52bnJb8xpBTnQ5VorUU
         ntqYfcWd2DLOUI0KbSHjDCGqJsBg3lD+oowIN6sZrlb1yvv6vteiJbZ13B3sHZjjJOEC
         IEfvnb5zqXFRMTLUfsOTY/X17NzK8cWV19+ESQOH1smXJHrYqc9mXYu0YF21nNYj1Zv5
         9uOgkLTPZRytU0Q7zJOlh/f1DTiTgq2X7jBT9riycDy5c18pEzRhM3FqwT5j+caQIpUx
         KTbg==
X-Gm-Message-State: AOAM532gCpVSeJTfO7sZyvthPqFHfTPRDTDdlUWOhNchNdZGC+NccHez
        KLyJGDW8KtjFi3GfxgOCwIwKuv7mHjJ9gWTH+RgQORAT7L22gw==
X-Google-Smtp-Source: ABdhPJw9/suQYcwaizWD00f5z0O6Qoma++cg/6z31C7WOGnZzTTzGqV32T+8+hIFEovfocbo3P3aAkJqlL4CWyEDBls=
X-Received: by 2002:a17:906:6d94:: with SMTP id h20mr1591531ejt.231.1612331091166;
 Tue, 02 Feb 2021 21:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-8-charvi077@gmail.com> <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
 <CAP8UFD2m18ZemGMkfzFhO1TUrMjNOGuQCqP1KVnRK7JEngeuog@mail.gmail.com>
In-Reply-To: <CAP8UFD2m18ZemGMkfzFhO1TUrMjNOGuQCqP1KVnRK7JEngeuog@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Feb 2021 00:44:40 -0500
Message-ID: <CAPig+cSBVG0AdyqXH2mZp6Ohrcb8_ec1Mm_vGbQM4zWT_7yYxQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] t3437: test script for fixup [-C|-c] options in
 interactive rebase
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 5:02 AM Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Feb 2, 2021 at 3:01 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Fri, Jan 29, 2021 at 1:25 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > > +               merge_*|fixup_*)
> > > +                       action=$(echo "$line" | sed 's/_/ /g');;
> >
> > What is "merge_" doing here? It doesn't seem to be used by this patch.
>
> Yeah, it's not used, but it might be a good thing to add this for
> consistency while at it.

It confuses readers (as it did to me), causing them to waste
brain-cycles trying to figure out why it's present. Thus, it would be
better to add it when it's actually needed. The waste of brain-cycles
and time is especially important on a project like Git for which
reviewers and reviewer time are limited resources.

> > > +# Copyright (c) 2018 Phillip Wood
> >
> > Did Phillip write this script? Is this patch based upon an old patch from him?
>
> Yeah, it might be a good idea to add a "Based-on-patch-by: Phillip ..."

Agreed.

> > The implementation of test_commit_message() is a bit hard to follow.
> > It might be simpler to write it more concisely and directly like this:
> >
> >     git show --no-patch --pretty=format:%B "$1" >actual &&
> >     case "$2" in
> >     -m) echo "$3" >expect && test_cmp expect actual ;;
>
> I think we try to avoid many commands on the same line.

For something this minor, it's not likely to matter but, of course, it
could be split over two lines:

    -m) echo "$3" >expect &&
        test_cmp expect actual ;;

> >     *) test_cmp "$2" actual ;;
> >     esac
>
> In general I am not sure that using $1, $2, $3 directly makes things
> easier to understand, but yeah, with the function documentation that
> you suggest, it might be better to write the function using them
> directly.

The direct $1, $2, etc. was just an example. It's certainly possible
to give them names even in the rewritten code I presented. One good
reason, however, for just using $1, $2, etc. is that $2 is not well
defined; sometimes it's a switch ("-m") and sometimes its a pathname,
so it's hard to invent a suitable variable name for it. Also, this
function becomes so simple (in the rewritten version) that explicit
variable names don't add a lot of value (the cognitive load is quite
low because the function is so short).

> > Style nit: In Git test scripts, the here-doc body and EOF are indented
> > the same amount as the command which opened the here-doc:
>
> I don't think we are very consistent with this and I didn't find
> anything about this in CodingGuidelines.
>
> In t0008 and t0021 for example, the indentation is more like:
>
>      cat >message <<-EOF &&
>           amend! B
>           ...
>           body
>      EOF
>
> and I like this style, as it seems clearer than the other styles.

I performed a quick survey of the heredoc styles in the tests. Here
are the results[1] of my analysis on the 'seen' branch:

total-heredocs=4128

same-indent=3053 (<<EOF & body & EOF share indent)

    cat >expect <<-\EOF
    body
    EOF

body-eof-indented=24 (body & EOF indented)

    cat >expect <<-\EOF
        body
        EOF

body-indented=735 (body indented; EOF not)

    cat >expect <<-\EOF
        body
    EOF

left-margin=316 (<<EOF indented; body & EOF not)

        cat >expect <<\EOF
    body
    EOF

So, the indentation recommended in my review -- with 3053 instances
out of 4128 heredocs -- is by far the most prevalent in the project.

[1]: Note that there is a miniscule amount of inaccuracy in the
numbers because there are a few cases in which heredocs contain other
heredocs, and some scripts build heredocs piecemeal when constructing
other scripts, and I didn't bother making my analysis script handle
those few cases. The inaccuracy is tiny, thus not meaningful to the
overall picture.

> > I see that you mirrored the implementation of FAKE_LINES handling of
> > "exec" here for "fixup", but the cases are quite different. The
> > argument to "exec" is arbitrary and can have any number of spaces
> > embedded in it, which conflicts with the meaning of spaces in
> > FAKE_LINES, which separate the individual commands in FAKE_LINES.
> > Consequently, "_" was chosen as a placeholder in "exec" to mean
> > "space".
> >
> > However, "fixup" is a very different beast. Its arguments are not
> > arbitrary at all, so there isn't a good reason to mirror the choice of
> > "_" to represent a space, which leads to rather unsightly tokens such
> > as "fixup_-C". It would work just as well to use simpler tokens such
> > as "fixup-C" and "fixup-c", in which case t/lib-rebase.sh might parse
> > them like this (note that I also dropped `g` from the `sed` action):
> >
> >     fixup-*)
> >         action=$(echo "$line" | sed 's/-/ -/');;
>
> I agree that "fixup" arguments are not arbitrary at all, but I think
> it makes things simpler to just use one way to encode spaces instead
> of many different ways.

Is that the intention here, though? Is the idea that some day `fixup`
will accept arbitrary arguments thus needs to encode spaces? If not,
then mirroring the treatment given to `exec` confuses readers into
thinking that it will/should accept arbitrary arguments. I brought
this up in my review specifically because it was confusing to a person
(me) new to this topic and reading the patches for the first time. The
more specific and exact the code can be, the less likely it will
confuse readers in the future.

Anyhow, it's a minor point, not worth expending a lot of time discussing.

> > It feels clunky and fragile for this test to be changing
> > "expected-message" which was created in the "setup" test and used
> > unaltered up to this point. If the content of "expected-message" is
> > really going to change from test to test (as I see it changes again in
> > a later test), then it would be easier to reason about the behavior if
> > each test gives "expected-message" the precise content it should have
> > in that local context. As it is currently implemented, it's too
> > difficult to follow along and remember the value of "expected-message"
> > from test to test. It also makes it difficult to extend tests or add
> > new tests in between existing tests without negatively impacting other
> > tests. If each test sets up "expected-message" to the precise content
> > needed by the test, then both those problems go away.
>
> Yeah, perhaps the global "expected-message" could be renamed for
> example "global-expected-message", and tests which need a specific one
> could prepare and use a custom "expected-message" (maybe named
> "custom-expected-message") without ever changing
> "global-expected-message".

That would be fine, though I wondered while reviewing the patch if a
global "expect-message" file was even needed since it didn't seem like
very many tests used it (but I didn't spend a lot of time counting the
exact number of tests due to the high cognitive load tracing how that
file might mutate as it passed through each test).

Another really good reason for avoiding having later tests depend upon
mutations from earlier tests, if possible, is that it makes it easier
to run tests selectively with --run or GIT_SKIP_TESTS.
