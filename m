Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C780C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 01:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A4164F03
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 01:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhBYBPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 20:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbhBYBOt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 20:14:49 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A67EC061756
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 17:14:09 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id x20so4471817oie.11
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 17:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0xnS2ZSLXgwWjnZzfrrd1n5KLi62LxiejaGAvr7mD4=;
        b=sQnquvrBJSy9Z5LAJPTBpsE+lgBaO7Zw2a1oRNgr0lZYpjpExFYdyH9uLOAeuXj8nL
         FtWXoQLn1esSFnlrsnM+z4YiGoHzBBET/CN/1AOqXGjTa5HbbcT+tupsTIsL7fFaTWr2
         z4/TR0iDSKu7F9mqHDK3NwHnZekoDDLaFI29HAuLgAUp2yXpGK/lzl/gRL4Vr6XfmhGb
         Sg5LiBiubKjRU8RQs4/ggEgwl8zGk6ufj04SZgPvHyrDDqkgT5OzwIoTMHgPmBjUkQ6C
         1kJKU8eNMjzx0eNQ3wyJEK4AfZfW+cuPHqWImffZ9hWKmVDZ0TQIkjRGrJQB637LdMQ+
         BYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0xnS2ZSLXgwWjnZzfrrd1n5KLi62LxiejaGAvr7mD4=;
        b=VILx7uYUNvxdo2KdLE3VITgI/5AxYxYLu8rMUfSTzR19ydb2yOyDw7ruou1+TShT62
         wPWZiIHwc/gBtZQtxZFmoFKkO/rYMifJLokVxx9712HuD3S9YkD+sA4Cghx0JDBE4o1P
         6FjLZpKh3XgsM4hSgr0VLD0zyVovyUjgC6yQ6W8thrk7k7wn3voK8H4I4R44rOBJOr84
         4Ak8MSfjOo+Lu/g1IIpJIEl2Ai/Tl5GLP2FtxMfSdEgoPtXpBBmZqcLz5Jk7+aEiUT/M
         gZjudwikuAUBunblUiFxo+Bo5EFvtasaHx1XxAl+k2wxlo78FtmredCP6IkHAkxeSNoq
         nUfg==
X-Gm-Message-State: AOAM533yEbQH9BrsCAKyC8hwyyEl97eqBZ1ZvvXJB6Zpfd/o/Auf5wXR
        YS1j9/iT2t682FjjsZc+QrLBjNwJt1UgC9rVuamrINwHxPMKnQ==
X-Google-Smtp-Source: ABdhPJwlqMmK1eYEWLQyICU9QAe5kEpzaF9wonj28i+AyUgEqsibUhoLaFisFylFbLmETUpoL2mey3UpoxlSy4BQweU=
X-Received: by 2002:aca:b407:: with SMTP id d7mr274783oif.167.1614215648895;
 Wed, 24 Feb 2021 17:14:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com> <cbd055ab33998962cb7712906cdad5dff3390660.1614123848.git.gitgitgadget@gmail.com>
 <aaf7c657-ef16-7612-166f-01560918d82d@gmail.com>
In-Reply-To: <aaf7c657-ef16-7612-166f-01560918d82d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 17:13:57 -0800
Message-ID: <CABPp-BGL+OrWtuh4tDLA2e-XHw0=zkMCitb46jOkO_5d+vJtkw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] diffcore-rename: add a new idx_possible_rename function
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 9:35 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/23/2021 6:44 PM, Elijah Newren via GitGitGadget wrote:> +static char *get_dirname(const char *filename)
> > +{
> > +     char *slash = strrchr(filename, '/');
> > +     return slash ? xstrndup(filename, slash-filename) : xstrdup("");
>
> My brain interpreted "slash-filename" as a single token on first
> read, which confused me briefly. Inserting spaces would help
> readers like me.
>
> > +      *   (4) Check if applying that directory rename to the original file
> > +      *       would result in a destination filename that is in the
> > +      *       potential rename set.  If so, return the index of the
> > +      *       destination file (the index within rename_dst).
>
> > +      * This function, idx_possible_rename(), is only responsible for (4).
>
> This helps isolate the important step to care about for the implementation,
> while the rest of the context is important, too.
>
> > +     char *old_dir, *new_dir, *new_path;
> > +     int idx;
> > +
> > +     if (!info->setup)
> > +             return -1;
> > +
> > +     old_dir = get_dirname(filename);
> > +     new_dir = strmap_get(&info->dir_rename_guess, old_dir);
> > +     free(old_dir);
> > +     if (!new_dir)
> > +             return -1;
> > +
> > +     new_path = xstrfmt("%s/%s", new_dir, get_basename(filename));
>
> This is running in a loop, so `xstrfmt()` might be overkill compared
> to something like
>
>         strbuf_addstr(&new_path, new_dir);
>         strbuf_addch(&new_path, '/');
>         strbuf_addstr(&new_path, get_basename(filename));
>
> but maybe the difference is too small to notice. (notice the type
> change to "struct strbuf new_path = STRBUF_INIT;")

Ooh, nice find.  Since this is in a loop over the renames as you point
out, this is an O(N) improvement (with N = number of renames) rather
than an O(1) improvement.  It does turn out to be hard to notice,
though.  Since we still have some O(N^2) code (all the inexact rename
detection for which our exact- and basename-guided detection
optimizations can't handle), with that N^2 actually being multiplied
by the average number of lines in the given files, this improvement
does seem to mostly get lost in the noise.

I tried a bunch of times to measure the performance with these
changes.  After a bunch of runs, it seems that this optimization saves
somewhere between 3-10ms (depending on which testcase, whether at this
point in the series or at the very end, etc.).  It's hard to pin down,
because the savings is less than the standard deviation of any given
sets of runs.  I don't think it's big enough to warrant restating the
performance measurements, but I'm very happy to include this
suggestion in my reroll.

>
> > +
> > +     idx = strintmap_get(&info->idx_map, new_path);
> > +     free(new_path);
> > +     return idx;
> > +}
>
> Does what it says it does.
>
> Thanks,
> -Stolee
