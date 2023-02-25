Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E56C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 03:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBYDXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 22:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYDXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 22:23:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39C083C1
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 19:23:16 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k14so1637657lfj.7
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 19:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GBYCBaakEBltwYE8JsphwxH3qIHu/fQqi2AzZOh0U2s=;
        b=R8UCIEvLGyg5z/hhzP9NstVNrP10u2T9Ux9ZPTRrGnCqeMrj248y1RScGm5uMIamw4
         KC+utMk5cThMOCnJwoS+JmPpj1TczvHLvqSuOq23zNH6cm1dedxFmrybD7Hb60myUkd0
         K7AU1TEsSz7FCyXBk5FyKnmKHqcJNt8cQt6mq5t+tehHWLjwh3OxOSN+XJsjm+PFcDOB
         pvn8KdAJSwJtBiaqy1B6it8Uh6RXo8ZqEdqeVOYdKXMHKI8nprcdvsG7eGgIX/IHkpcV
         Zi/FmMDL/zMx/JAzXLvBxrOyYB/wT+Ce5evh9j3brOXsAAY0hjAoy8wbCWRl6JZSmlr1
         JGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBYCBaakEBltwYE8JsphwxH3qIHu/fQqi2AzZOh0U2s=;
        b=2YqkbdZfHWt4CofN/f/B9jt/mAa9DT/1tqAFQPm23liKin93NmxSjfIDZfujNLy0z+
         GkvZmgsBfuHK0oBByvtrD8seMR5ruWBQtDJlAHKO7DG072W3cOMnvub+z2NuOUGkwlqi
         hopNLkgbBM3VgP2+GGKyNiX9uSbXIU74VsSeQVbr53eaeWxQB0Z1FHG9maD5GNjRsUoQ
         baTs7f6Ae9VWg+oJ8NytTGT8+mxAKiy2REUCjA9NDgGB35TfQrjNYnNiFFRZUb+ci0QO
         eprWALjOpDuwORbario3z1jYzDjltJw/AodPEeQjMLbRaMFUTt3jQ8two+kretVqnrFb
         tfZw==
X-Gm-Message-State: AO0yUKUJvcAqJnABRArrn9iDWJh+4Br9DO/0gtRQ/rXSbuPaK0j9xI51
        XQu1wsAL/hEa1hbCzwp6O3U9UsP1H7ljV9L/ymY=
X-Google-Smtp-Source: AK7set+NhBKWt3yOX2raV1UavHO7+ivpzODVD+grHJLOpx0htM3EY93075LbCatGgFHL1AlPxNpZZfm7wZLBcJr3cF0=
X-Received: by 2002:a19:5207:0:b0:4db:1326:79b2 with SMTP id
 m7-20020a195207000000b004db132679b2mr5485627lfb.2.1677295394925; Fri, 24 Feb
 2023 19:23:14 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BG4KChJa0Kj8n84QBUt5Rc6_rX2Fus3R4MbmUuF6RNuOQ@mail.gmail.com>
 <20230225015432.2065788-1-jonathantanmy@google.com>
In-Reply-To: <20230225015432.2065788-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Feb 2023 19:23:02 -0800
Message-ID: <CABPp-BFNd3ihQbMb+Sc270W=obnZkEgvwAuKZ8v_UBcFBoFUVg@mail.gmail.com>
Subject: Re: [PATCH 02/11] dir: add a usage note to exclude_per_dir
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 5:54 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
> > On Fri, Feb 24, 2023 at 2:31 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> > >
> > > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > > diff --git a/dir.h b/dir.h
> > > > index 33fd848fc8d..2196e12630c 100644
> > > > --- a/dir.h
> > > > +++ b/dir.h
> > > > @@ -295,8 +295,12 @@ struct dir_struct {
> > > >       struct untracked_cache *untracked;
> > > >
> > > >       /**
> > > > -      * The name of the file to be read in each directory for excluded files
> > > > -      * (typically `.gitignore`).
> > > > +      * Deprecated: ls-files is the only allowed caller; all other callers
> > > > +      * should leave this as NULL; it pre-dated the
> > > > +      * setup_standard_excludes() mechanism that replaces this.
> > > > +      *
> > > > +      * This field tracks the name of the file to be read in each directory
> > > > +      * for excluded files (typically `.gitignore`).
> > > >        */
> > > >       const char *exclude_per_dir;
> > >
> > > I'm not sure what is meant by "allowed caller", but I wouldn't have
> > > expected this to also mean that unpack-trees would need to know to
> > > propagate this from o->internal.dir to d in verify_clean_subdirectory.
> >
> > Are you confusing fields that are internal to dir, with fields that
> > are internal to unpack-trees?
> >
> > This series does not make exclude_per_dir an internal field within dir_struct.
>
> Agreed, but the comment says that ls-files is the only allowed caller,
> and I would have expected that non-"allowed callers" would not need to
> write to exclude_per_dir. But in unpack-trees.c:
>
>   2346          if (o->internal.dir)
>   2347                  d.exclude_per_dir = o->internal.dir->exclude_per_dir;
>
> Both "d" and "o->internal.dir" are of type "struct dir_struct" (well,
> one is not a pointer and one is). I would not have expected such non-
> ls-files code to read or write from this field. (But if unpack-trees
> is considered part of ls-files and/or copying the same field to another
> struct is not considered "calling", then this patch is fine, I guess.)

Ah, gotcha, sorry for misunderstanding earlier.  And you are right;
the code in unpack_trees() is buggy and should not be using
exclude_per_dir; the fact that it is using it directly actually hints
that it has bugs when exclusions are specified in .git/info/exclude
instead of .gitignore.  I've found a testcase that demonstrates this;
I'll update the series with a new patch fixing it.
