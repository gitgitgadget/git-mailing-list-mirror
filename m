Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9DBC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 00:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DC760BD3
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 00:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbhIGAjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 20:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbhIGAjH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 20:39:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F92C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 17:38:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s32so6641091qtc.12
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 17:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghcu60m4UDlD62JCeSO6uXSnX0DhuODFQ4r6zopenBk=;
        b=T04+mqMAXGF6GQQNSCU48VhXI00LZP5yRguLjhTG4QsSxXcJQf9zSsa1g0swOI+TLF
         JNPmfNT0J+YQajmd4bhIQWIzKH5Gx2agJIVjWysk1ASXWpSYRvLJQ/63DKS8CQgUnl1m
         Ae3KBMYAAtgOtupgxErrF23sHxcFo0ZJcRD0qGpFiRWdhQkWlntlQcAlf/s+E5f+mSLo
         pp0jbPZUE4ODEnRu8OxCAViSHBwsFAZTy3B+2Dby1D60rVQGek+jSjpogQlkMLncF/gX
         a18onypjIHR5Bb4eccOLyQn7NS5HGU076Qc5KppiMG4QuTK8naB2ygF/XPPHyLxE58Xg
         3kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghcu60m4UDlD62JCeSO6uXSnX0DhuODFQ4r6zopenBk=;
        b=MCtIAIYpdFO9oFY/PTB3rahV8KFQyz1F+Z7+G3IMqVxHKN+DRNGAkSSCdxyTVApKdd
         g5o0hvofgNLqVgRLorRyeEJioRpTpMx+An3plb1VJyKRk9sPxNxpoCK6lyD0U3kzH1K4
         jxSq1uglmT6IvDv/5tf9ZAOuiyEOkhJkxPCjGXqUfo6AuW8REiDCIiFzgn6bDQlmdofg
         zs63meMU/jFYPzkV8mG9xR5NG3Fk+Usnom0enVtoETCn3REfXnrdB8BkHOj13InMPSJ0
         Z47UFhhv2kzEdTkB8DoNjlvpTQxICo7egLmFvDn+zjxFlnhuzRn+36CTi9Z1FwfXeHGm
         3eyw==
X-Gm-Message-State: AOAM531i8NenbHp7SMXND/vFaZMj6k6TFjdXRd9pS2pNsfEYD2554Ir1
        R1yrVEbJhnHBsA+UCC++uuXChBYjAyd+jPfFjrGx
X-Google-Smtp-Source: ABdhPJzdRs/M6myQJCGVUDrD0LqEDgOa5CSE0ruELqeg8h0bm1Fkgiya6W3QNgTNhhOGmw3xDK2mvlyKQ+BbBxIk1kU=
X-Received: by 2002:ac8:59c4:: with SMTP id f4mr13376689qtf.334.1630975081171;
 Mon, 06 Sep 2021 17:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com> <066e186a-ffa5-3548-1b7d-a769bbd296f2@gmail.com>
In-Reply-To: <066e186a-ffa5-3548-1b7d-a769bbd296f2@gmail.com>
From:   Andrew Olsen <andrew.olsen@koordinates.com>
Date:   Tue, 7 Sep 2021 12:37:50 +1200
Message-ID: <CAPJmHpV2c_EubO4-GpV5Yi3RLpgvcaake=fz0rfgD_SZZcawOg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Compile-time extensions for list-object-filter
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Coup <rcoup@koordinates.com>
Cc:     Andrew Olsen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrew Olsen <andrew232@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good point - sorry I sent this out without accompanying explanation. I'm still
learning about contributing to Git.

The filter extension that I want to implement is a spatial filter - it will
return blobs that store geometries that intersect with a given geometry, eg,
"only return blobs in North America". This is useful to us at kartproject.org,
"distributed version control for geospatial data", which is built on Git. But
safe to say that this functionality is not generally useful to Git users.

However, the idea we have is that there will be others who want to implement
custom filters also - perhaps like the spatial filter, these could be
domain-specific filters that are not useful to most Git users, but allow for
a custom Git to be more powerful when storing data from a particular domain.
We could just fork git and do what we want with the fork, but defining a plugin
interface makes it possible for us to keep using Git at master, instead of
maintaining a fork indefinitely.

My colleague Robert Coup coded this up once already as a plugin library
interface that could be loaded at runtime, and I've been tasked with rewriting
it as a compile-time interface, which he thought was "more likely" (but of
course not guaranteed) to be accepted as a worthwhile change to Git. He's
unfortunately on the other side of the world to me and not working today, but
I hope when he reappears he'll be able to say something more in defence of this
idea, and perhaps give a history of the reasoning for this particular solution.

Regarding licenses: the sample extensions I'm contributing will be covered by
Git's GPL-v2 (I assume), if they make it into the Git repository. Any other
extensions that may be written by third party authors and are maintained
elsewhere could be licensed as those authors see fit, as long as they take care
not to violate the terms of Git's GPL-v2 when they distribute the extension or
Git and the extension together. I could add a link to the GPL-v2 in the README
warning developers to check it before distributing any kind of extension to Git.
I'm not a lawyer and wouldn't want to give more specific advice than that.

On Tue, Sep 7, 2021 at 11:24 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 06/09/21 06.51, Andrew Olsen via GitGitGadget wrote:
> > Adds an extension: option to list-object-filters, these are implemented by
> > static libraries that must be compiled into Git. The Makefile argument
> > FILTER_EXTENSIONS makes it easier to compile these extensions into a custom
> > build of Git. When no custom filter-extensions are supplied, Git works as
> > normal.
>
> I don't see why this series is useful (use cases?).
>
> --
> An old man doll... just what I always wanted! - Clara
>
