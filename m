Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EACC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6AC61464
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhEHAFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 20:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhEHAFi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 20:05:38 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAB2C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 17:04:36 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id c3so10201096oic.8
        for <git@vger.kernel.org>; Fri, 07 May 2021 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuO1JFRb41rDJNbjRNr5ekOdGY1cdGJSbO06yXOhkf0=;
        b=cPTSbSucc2kjaV4yrd+B3i6a8priKbt8d3p4ej5YmcilTNA1NQ8qT486YSMl6sGbKs
         1k42KqLnZkKz42PU63T/RGfBte5hP9PUSTlC3VaEEfzJRs13N4rV8Nu1lpXuDW9X7xbe
         id9Zj/sSeviJlbOIEffV3B0Hvm2dEHHYwLEaWwYq4eUCBx9V/ePZkTnxb3urER9+FwkM
         zt+XC2g+MlwqbWjG3ShVry2xjFN16lbGjFYPNZftRaMYh7PpenKxqCKgvMEj962+fFHd
         zNdjjQynSrz8O5gv9JQcQAriW/sBJjq2jTFEjVR4JbvKImKAF0cjrL8aXS78YQ65UHX3
         rAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuO1JFRb41rDJNbjRNr5ekOdGY1cdGJSbO06yXOhkf0=;
        b=OSRaRB0O1KiKPSOgud/xIRABC+BVDsVLvyfqP7AaIDAN2efPw4lUaoBauhOBXxHZoZ
         5PZXb1FAjuXIYviBp98161+GhVqkESqe9tRCSq5wRjqD3OO2za3MMB4qS+jQqwIgHInA
         VNCKGIX6fMY5k3sJgFYKzHZKgiqDEWBAVIer8IDATDf35JGXqX4kS5jNwSrlrYXw2PV0
         40ZqXdF92i/rsKxkoEFvJECWlszjzFlm+qQzTywq/1ZpegPJIt8f8jzJk0zu33UNsqAw
         QHT4fGbuJyo3frbsr9PrIe9KW/Osk7Lr6lAjuPjePvUrlNKy2gBA/y6M3qRFJDILIDt8
         T6bw==
X-Gm-Message-State: AOAM531YgwD6WPDWcMk+TSw68NcGlL5G5ZRrny/CCOHWKoxyFh7QoI24
        URz4ghw47tdhy5OTIrsM1YRvSp6JpnJt01KsrIo=
X-Google-Smtp-Source: ABdhPJwFxgvqZTfEXvynO5fZf0Aplv7bSQKaFdOVDoi+ugrVR6RdBI0LO7gN8fR1jtrZCNUyOlQOBHA/fsowt43E/ps=
X-Received: by 2002:aca:3e05:: with SMTP id l5mr16577130oia.39.1620432276018;
 Fri, 07 May 2021 17:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
 <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com> <YJXHrXWVDSgg5TZw@coredump.intra.peff.net>
In-Reply-To: <YJXHrXWVDSgg5TZw@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 May 2021 17:04:24 -0700
Message-ID: <CABPp-BEyUX8j-_rhNTyR5ZiqeLUWbBS-9q5+gEUWOEHpchambQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 7, 2021 at 4:05 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, May 06, 2021 at 10:00:49PM -0700, Elijah Newren wrote:
>
> > > > +               >directory-random-file.txt &&
> > > > +               # Put this file under directory400/directory399/.../directory1/
> > > > +               depth=400 &&
> > > > +               for x in $(test_seq 1 $depth); do
> > > > +                       mkdir "tmpdirectory$x" &&
> > > > +                       mv directory* "tmpdirectory$x" &&
> > > > +                       mv "tmpdirectory$x" "directory$x"
> > > > +               done &&
> > >
> > > Is this expensive/slow loop needed because you'd otherwise run afoul
> > > of command-line length limits on some platforms if you tried creating
> > > the entire mess of directories with a single `mkdir -p`?
> >
> > The whole point is creating a path long enough that it runs afoul of
> > limits, yes.
> >
> > If we had an alternative way to check whether dir.c actually recursed
> > into a directory, then I could dispense with this and just have a
> > single directory (and it could be named a single character long for
> > that matter too), but I don't know of a good way to do that.  (Some
> > possiibilities I considered along that route are mentioned at
> > https://lore.kernel.org/git/CABPp-BF3e+MWQAGb6ER7d5jqjcV=kYqQ2stM_oDyaqvonPPPSw@mail.gmail.com/)
>
> I don't have a better way of checking the dir.c behavior. But I think
> the other half of Eric's question was: why can't we do this setup way
> more efficiently with "mkdir -p"?

I think I figured it out.  I now have the test simplified down to just:

test_expect_success 'avoid traversing into ignored directories' '
    test_when_finished rm -f output error trace.* &&
    test_create_repo avoid-traversing-deep-hierarchy &&
    (
        mkdir -p untracked/subdir/with/a &&
        >untracked/subdir/with/a/random-file.txt &&

        GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
        git clean -ffdxn -e untracked &&

        grep data.*read_directo.*visited ../trace.output \
            | cut -d "|" -f 9 >../trace.relevant &&
        cat >../trace.expect <<-EOF &&
        directories-visited:1
        paths-visited:4
        EOF
        test_cmp ../trace.expect ../trace.relevant
    )
'

This relies on a few extra changes to the code: (1) switching the
existing trace calls in dir.c over to using trace2 variants, and (2)
adding two new counters (visited_directories and visited_paths) that
are output using the trace2 framework.  I'm a little unsure if I
should check the paths-visited counter (will some platform have
additional files in every directory besides '.' and '..'?  Or not have
one of those?), but it is good to have it check that the code in this
case visits no directories other than the toplevel one (i.e. that
directories-visited is 1).

New patches incoming shortly...
