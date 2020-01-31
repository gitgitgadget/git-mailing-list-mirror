Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85A3C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FCC20707
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAVzWu0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgAaTqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:46:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38799 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAaTqM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 14:46:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so4002221pgm.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 11:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUuPD38bU+4mA1Fo00cNUXeqYsr4ah4UGTY9UWfrKD0=;
        b=hAVzWu0oSSTEA4X2st5O8MzROHf+w2DB886WPlGZRopab/B0SrC18fbJB85AXzK3si
         V6SE+hQFcDVqPRjRrXCxmTdxNYj4bGMFcpEeiBKUZ31Q7OuZLnOT4QGjm2Gxhgjbj0M7
         Y7wrM3uJx9h9H1j6hgcOIO+nrIDsH/HJ82kkdRElF5Gy2grHw30KCA5fOvrNVgFu6xJs
         vaOobPwVb7aIwy+QwkbisaecsXTsQJC8prnyQ9a1i+A8NZx48ShgmxsdIDchGclfQELZ
         pZe5shCz4GrcFD1OkEmE12EM2jPgkhI1QWJ4Diij/4n3H4MC3qtcUnQDw4peOvX2bfIE
         j5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUuPD38bU+4mA1Fo00cNUXeqYsr4ah4UGTY9UWfrKD0=;
        b=QFlxrnn31hv2BDXLgvQOEgPdh1iKyRoZcoUKAhpJFNj5HxVP3kYhlsw368CDzUHpgK
         B68qeDJ2X17tucwm7jOjwQxkKHoAYKWiSvsc8obVgdibrAyLmW5qSGujI1v9pqA4i9I1
         CQf2NFXktgYwMQHQC4Ppa0BDo3M6/a1qOVJkVH8SW0QNvWjHsRTIyMDU9cA9UsTx3T4g
         Wn+3rmn3ZOMEho2ogwzhMLeLkjR8ZGqGJmzRs+qDUCYKU2SDZ+94ZcdUg7TqCkFWC7J7
         IPjvJHTsWAgvJxMuqdd/VOvswTXb24Dg5r3vLWuMdIvdNzAfyHQe73bYlht8VVf3Um6S
         ln2w==
X-Gm-Message-State: APjAAAWoTUf8YgSHzYUkfwuZfM53jem4+oTrJosJ+j0LlT3mBLaIT6iJ
        nQkupZeG16bCMQLm0jq6chwQQkfd9g571QKK1jdV1g==
X-Google-Smtp-Source: APXvYqze7OzyvWbtEWjMHu6fxpWUF8tuut7zaSaxlI/YsX0vhQ3XDFTNma+QqyaoTHbScwLadcSW4uO8ZMWxubAC7qM=
X-Received: by 2002:aa7:8654:: with SMTP id a20mr12002785pfo.88.1580499971739;
 Fri, 31 Jan 2020 11:46:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580430057.git.me@ttaylorr.com> <c329a8ddc087c9b74f673005f8b1e8769816ab9a.1580430057.git.me@ttaylorr.com>
In-Reply-To: <c329a8ddc087c9b74f673005f8b1e8769816ab9a.1580430057.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 31 Jan 2020 20:45:59 +0100
Message-ID: <CAN0heSpfqMChHO=iNuUExrBsMPcpZ6K2zH68GkHO2ttEiSinSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] builtin/commit-graph.c: support '--input=none'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 31 Jan 2020 at 01:30, Taylor Blau <me@ttaylorr.com> wrote:
> In the previous commit, we introduced '--[no-]merge', and alluded to the
> fact that '--merge' would be useful for callers who wish to always
> trigger a merge of an incremental chain.

Hmmm. So it looks like you've already had similar thoughts as I did
about patch 1/3. At some point, you had a separate `--merge=...` option,
then later made that `--split=...`. :-) Could you say something about why
you changed your mind?

> There is a problem with the above approach, which is that there is no
> way to specify to the commit-graph builtin that a caller only wants to
> include commits already in the graph. One can specify '--input=append'
> to include all commits in the existing graphs, but the absence of
> '--input=stdin-{commits,packs}' causes the builtin to call
> 'fill_oids_from_all_packs()'.

(Use one of those options with an empty stdin? Anyway, let's read on.)

> Passing '--input=reachable' (as in 'git commit-graph write
> --split=merge-all --input=reachable --input=append') works around this
> issue by making '--input=reachable' effectively a no-op, but this can be
> prohibitively expensive in large repositories, making it an undesirable
> choice for some users.
>
> Teach '--input=none' as an option to behave as if '--input=append' were
> given, but to consider no other sources in addition.

`--input=none` almost makes me wonder if it should produce an empty
commit-graph. But there wouldn't be much point in that... I guess
another way of defining this would be that it "uses no input, and
implies `--append`".

> This, in conjunction with the option introduced in the previous patch
> offers the convenient way to force the commit-graph machinery to
> condense a chain of incrementals without requiring any new commits:
>
>   $ git commit-graph write --split=merge-all --input=none

Right.

> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -39,24 +39,29 @@ COMMANDS
>  --------
>  'write'::
>
> -Write a commit-graph file based on the commits found in packfiles.
> +Write a commit-graph file based on the commits specified:
> +* With the `--input=stdin-packs` option, generate the new commit graph
> +by walking objects only in the specified pack-indexes. (Cannot be
> +combined with `--input=stdin-commits` or `--input=reachable`.)
>  +
> -With the `--input=stdin-packs` option, generate the new commit graph by
> -walking objects only in the specified pack-indexes. (Cannot be combined
> -with `--input=stdin-commits` or `--input=reachable`.)
> -+
> -With the `--input=stdin-commits` option, generate the new commit graph
> +* With the `--input=stdin-commits` option, generate the new commit graph
>  by walking commits starting at the commits specified in stdin as a list
>  of OIDs in hex, one OID per line. (Cannot be combined with
>  `--input=stdin-packs` or `--input=reachable`.)
>  +
> -With the `--input=reachable` option, generate the new commit graph by
> +* With the `--input=reachable` option, generate the new commit graph by
>  walking commits starting at all refs. (Cannot be combined with
>  `--input=stdin-commits` or `--input=stdin-packs`.)
>  +
> -With the `--input=append` option, include all commits that are present
> +* With the `--input=append` option, include all commits that are present
>  in the existing commit-graph file.

Do these changes above really belong in this commit?

> +* With the `--input=none` option, behave as if `input=append` were
> +given, but do not walk other packs to find additional commits.
> +
> +If none of the above options are given, then commits found in
> +packfiles are specified.

"specified"? Plus, that also happens for `--input=append` right? (It
really seems like "append" is an odd one among all the inputs.)

>         N_("git commit-graph write [--object-dir <objdir>] [--append] "
> -          "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
> +          "[--split[=<strategy>]] "
> +          "[--input=<reachable|stdin-packs|stdin-commits|none>] "
>            "[--[no-]progress] <split options>"),

Hmm, you've left "--append" the old way.


Martin
