Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE36C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 02:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F1861433
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 02:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhD3CYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 22:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhD3CYM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 22:24:12 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0FDC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 19:23:24 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u80so34974143oia.0
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 19:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+IDHi+W/1klRiNnqdNOut75C6OHx492pD/YW0X4lqk=;
        b=HE53S3lHe/91+A8tsRUaFv6faj7YdKHeveaATQF5HV0c1w/priEPnq8j+zUMugLbmZ
         Q+SbIVLE8LCedMGb2FShqJ8Arl83EEcDnJs6lovUKCWFG3iBmr+D/pFt6pBO35q7W0nZ
         qk6IpoMan5rkHDr3amACbfb04U/ox5BW1G5VnePQYJs8YWtzAqsF82fw7idR6XyA+QiH
         UEOniYNpEkijCWJnAfI+7ZQY3mL5wAUlBvaYnWcqRnMsVT0l1d10Icg3rq/nIfRL2+jq
         NUXRriM7JvDZAOOpPgOxelZKkRXUlRzgOW3eAMA9I9G73AIg3XlREbJZRcx8fW2T7Rj1
         F/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+IDHi+W/1klRiNnqdNOut75C6OHx492pD/YW0X4lqk=;
        b=cFc4xUYjFe6jOfP5q/XLnBSL5ttJPycs0Wip6gPHt3mw1zGZoQI8QaBBbAPLQKwG5/
         ijT4ZeFws7gEWLLNTSqIBx9V+1ZFA7/xJSIefBvCijHrnZUplfFB0i/20Um49v7w0OFq
         ifap+SITkZLxxH/6N5NEPkKBMr54jXPjy+fNLA1mkMdbR7z8TJbTYl9V4QxDvUZ3eSIV
         rWbYRLdp3X6276VKTDviPC8l7/+4cTn5kkT46BjD5hXl9huh1EkCiPgDKo8YUbqVpi8/
         IlAZhMfJhjefngjY8mmCNDwwSeq/EFZPrdCrqw0/vBOpH3oh4wvyRoWuhxtrUnwU0Rzi
         yRPg==
X-Gm-Message-State: AOAM530pRGf93tJOeMVnyhK3Jk7ew6AyaOlHNVQreIkN9jTsKt6VK0XN
        +fH0WDPF1ZveJdOPETJbtR0L5MRx6euscmXah7Y=
X-Google-Smtp-Source: ABdhPJzEDaJ46XYrKGpY79zlFKPgQmB8RYAphUmVZume+c4j8q6uPSZ2O6q4fjO6qFDRNJ48qG0HK1A2FNoiF2BqC0U=
X-Received: by 2002:a54:4498:: with SMTP id v24mr2333139oiv.31.1619749404302;
 Thu, 29 Apr 2021 19:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210422002749.2413359-1-lukeshu@lukeshu.com> <20210423164118.693197-1-lukeshu@lukeshu.com>
 <20210423164118.693197-4-lukeshu@lukeshu.com> <xmqqfszbcazc.fsf@gitster.g>
 <87o8dwq2hv.wl-lukeshu@lukeshu.com> <CABPp-BHhfT3b=UyWOXACrBb6nw86n74thNAx7DUDF0YNOcA-yA@mail.gmail.com>
 <xmqqim44fyjj.fsf@gitster.g>
In-Reply-To: <xmqqim44fyjj.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Apr 2021 19:23:13 -0700
Message-ID: <CABPp-BGUrOtHcu-o2xq-3xc3f=9wy2oxcL_4-ays+ejCg8i+sA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fast-export, fast-import: implement signed-commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 4:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I do get that we might have to use warn-strip as the default anyway
> > just because some existing tools might rely on it, but do you have any
> > examples outside of git-filter-repo?  Given the filter-repo bug
> > reports I've gotten with users being surprised at commit signatures
> > being stripped (despite the fact that this is documented -- users
> > don't always read the documentation), I'd argue that changing to
> > --signed-commits=abort as the default is probably a good bugfix for
> > both fast-export and for filter-repo.
>
> Thanks.  The "filter-repo already gets bug reports from the users"
> is a valuable input when deciding if it is reasonable to sell the
> behaviour change as a bugfix to our users.
>
> Perhaps teaching fast-export to pay attention to two environment
> variables that say "when no --signed-{tag,commit}=<disposition>"
> command line option is given, use this behaviour" would be a good
> enough escape hatch for existing tools and their users, while they
> are waiting for their tools to get updated with the new option you
> are planning to add?

As far as git filter-repo is concerned, you can immediately introduce
--signed-commit and give it a default value of abort with no
deprecation period.  filter-repo already has to check git versions for
available command line options, so one more wouldn't hurt.  And a
default of "abort" seems more user friendly, as it gives users a
chance to be aware of and handle their data appropriately.

Of course, there are a few factors that make filter-repo more tolerant
of upstream changes: I don't expect people to user filter-repo often
(it's a once-in-a-blue-moon rewrite), I don't expect them to use it in
automated processes, I tend to make releases that coincide in timing
with git releases (so I'll just release a git-filter-repo 2.32.0 the
day you release git 2.32, and it'll come with an option to handle this
new default), and filter-repo includes the following disclaimer in its
documentation:

"""
I assume that people use filter-repo for one-shot conversions, not
ongoing data transfers. I explicitly reserve the right to change any
API in filter-repo based on this presumption (and a comment to this
effect is found in multiple places in the code and examples). You have
been warned.
"""

So, if it's just for filter-repo, then I'd say just change
fast-export's default now.  If you're concerned with
--signed-commit=abort being a changed default being too drastic for
other users or tools, then the environment variable escape hatch
sounds reasonable to me.

Personally, I'm worried users are seeing "lost" data (though they
don't notice it until weeks or months later) and are being surprised
by it, which feels like a bigger issue to me than "my automated script
isn't running anymore on this one repo, now I have to figure out what
flag to use in order to choose whether I care about that data from
that special repo being tossed or not".  So I would bias towards
throwing an error so users get a chance to handle it.

> Also, I am glad that you brought up another possible behaviour that
> Luke's patch did not add.  Exporting existing signatures that may
> become invalid and deciding what to do with them on the receiving
> end would be a good option to have.  And that would most likely have
> to be done at "fast-import" end, as a commit that "fast-export"
> expected to retain its object name if its export stream were applied
> as-is may not retain the object name when the export stream gets
> preprocessed before being fed to "fast-import".

Right, but I'd go a step further: Even if the fast-export stream is
not pre-processed before feeding to fast-import, you still cannot
always expect to get the same object names when importing the stream.

To see why, note that the fast-export stream has no way to encode tree
information.  So if trees in the original history deviated from
"normal" in some fashion, such as not-quite-sorted entries, or non
standard modes, then sending those objects through fast-export and
fast-import will necessarily result in different object names.
fast-export also may have modified other objects to normalize them,
either because of default re-encoding of commit messages into UTF-8,
because of stripping any unrecognized commit headers, or perhaps even
because it'd truncate commit messages with an embedded NUL character.

Combine all these "normalizations" that fast-export/fast-import do
with the ability for users to process the stream from fast-export to
fast-import and it becomes clear that the only stage in the pipeline
that can check the validity of the gpg signatures for the imported
history is the fast-import step.
