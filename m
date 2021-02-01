Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249BAC433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE09E64EC1
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBAWNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhBAWNY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:13:24 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D055BC061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:12:43 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id n42so17908635ota.12
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HwtJZz1dI7xo2+/aitpNluPZfJ4yiRlRlskqN2Wieg=;
        b=EFP8ZFHyUc9kxWrNKWtGo6DdPcthoBznGvuYBnePULt7J+zL5Ec8DTOt+LxblKJNGK
         YZbFI3WfDsNDav/aq6EXsmu5W+mbMbf9YvJx97QgDFclJsOQTybarDeXzl2lxxbr5/Dx
         kTmGVGDxaVTljvULdWpviLh47mL60cDEKUK1DFFl/dkpzooy12lEAfIoNq6crlarElle
         Nex5e/vvxDjowEbfg7gWE7BBTydUGkAjxNqr3GgNyZM83I0/xbk1VtqzmWnhl32MwT+T
         Bam4iQy08eSCGtu7qrqqLYSLwzFxksFEpmTrLdzFAmsCY1sZf5VYFeqzWc5McDagcRRW
         CMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HwtJZz1dI7xo2+/aitpNluPZfJ4yiRlRlskqN2Wieg=;
        b=VjkUc9YBW1axDAH3kDjraU3253OPw6K8tkoIidD1DTKRRBesU6tFW29FaJXnkYU3GM
         hOn4okFHsn0/E8kAjmiP2hvCKWpjqO4ApbK678JteKA61JpyPFeR9fSSUBfMR2P85LQ7
         EA40CxzqA7LkqSpYb9coA56/RUS0tlZQKVrACWcHuBG/wVGSbbxHMFSCZV3xLGWYkwP+
         y7ADVXb2MgHiiywts9gYESN4OlXi31oiGippDr9+fBGeA6Ef9pJz8tdIVbH/2oMFbGzC
         Lf044PV4EZs4kSOb7gz6C9m8FT+CE0Cf7KEOCeSgxdGXVYDsBzsLW8eYwWmVnM7uKib9
         0Lxg==
X-Gm-Message-State: AOAM530Rzd44YQGGylIUD3i/gRaZyomTXg+7VbqYi9Xaw40R/Owz9BTR
        HfUlW03vdmYwmkAjUmJa4IX/iMTV1QGyID5/sjk=
X-Google-Smtp-Source: ABdhPJzNGREa/VtkSSYuA3gWtDVTVLqZH5WOOcdCLpvRssEE7JHuphANzY4IY9Yi17tqKHk2py4ZY4i2TDEjlm/k/jQ=
X-Received: by 2002:a9d:506:: with SMTP id 6mr12892867otw.162.1612217563155;
 Mon, 01 Feb 2021 14:12:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <036653cac368c6c04b439f5352d70a5dcc3c5feb.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <036653cac368c6c04b439f5352d70a5dcc3c5feb.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 14:12:32 -0800
Message-ID: <CABPp-BEQR6udbGRMVm8vUBkJvAeCOZF09YAMjACHDNWC5Wnjtw@mail.gmail.com>
Subject: Re: [PATCH 17/27] dir.c: accept a directory as part of cone-mode patterns
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When we have sparse directory entries in the index, we want to compare
> that directory against sparse-checkout patterns. Those pattern matching
> algorithms are built expecting a file path, not a directory path. This
> is especially important in the "cone mode" patterns which will match
> files that exist within the "parent directories" as well as the
> recursive directory matches.
>
> If path_matches_pattern_list() is given a directory, we can add a bogus
> filename ("-") to the directory and get the same results as before,
> assuming we are in cone mode. Since sparse index requires cone mode
> patterns, this is an acceptable assumption.

Why is "-" a bogus filename?  Is that only on certain operating
systems, or are you just not expecting a user to name their file with
such a bad name?  What if there is a file with that name in that
directory in the repository; do you need the pathname to be bogus?

What do you mean by "get the same results as before"?  The first
paragraph suggests the code wouldn't handle a directory path, and that
not handling it was problematic, so it seems unlikely you want the
same results as that.  But it's not clear what the "before" refers to
here.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/dir.c b/dir.c
> index ad6eb033cb1..c786fa98d0e 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1384,6 +1384,11 @@ enum pattern_match_result path_matches_pattern_list(
>         strbuf_addch(&parent_pathname, '/');
>         strbuf_add(&parent_pathname, pathname, pathlen);
>
> +       /* Directory requests should be added as if they are a file */
> +       if (parent_pathname.len > 1 &&
> +           parent_pathname.buf[parent_pathname.len - 1] == '/')

Ah, this looks like a case where the trailing slash is helpful;
without it, you might have to feed extra data in through the call
hierarchy to signify that this is a directory entry.

> +               strbuf_add(&parent_pathname, "-", 1);
> +
>         if (hashmap_contains_path(&pl->recursive_hashmap,
>                                   &parent_pathname)) {
>                 result = MATCHED_RECURSIVE;

hashmap_contains_path?  Don't we already know (modulo special cases of
our bogus value not quite being bogus enough) that this is false since
we were adding a bogus path?  How could the hashmap have a bogus value
in it?  Won't this particular call fail with or without our adding "-"
to the end of the path?

After this hashmap_contains_path() call, the subsequent code looks for
the parent of the path by stripping off everything after the last
'/'...which seems like the relevant code anyway.  Is the problem that
the hashmap_contains_path() call was returning true when we didn't add
"-" to the end?  If so, can we use and if or a goto instead to make
the code skip this first check and move on to where we want it to go?

Or am I misunderstanding something about this code?
