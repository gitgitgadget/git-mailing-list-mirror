Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3635CC64ED8
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 00:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjBYAYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 19:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjBYAX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 19:23:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89915C8F
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:23:57 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b10so822083ljr.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xYjRi+AAnNmBItqXaNHpWIQM33HcRz3viz4JZ5iBaUk=;
        b=GQy0xdFwyBGRoXbH8xkKCFXyQZX6Ix5rkBCe1U8XrctbgHKc64OkHAUwBfV6GAog3b
         pJPPCzKXAYMIZNl6mXtiiluOi0GqUKwT332FcKZTyu4F6XyyFc875W9Kvn32B4OtMlvP
         VwsVqTyiw6i8sIW0yFHtKLq9hxTpenm2xiRz7jyB2DCNu1kCqH6s5ZIfFmwVw8zZms3t
         YXva704KjgRAVj7vq/QXygkcx+a8fuEfSkezWCAZ1b9bfxoGr8TvfnYSpAe2/1hblA6B
         S+DbKufvV9GW01JgxjMIVNCwaJIkg8y2mfelJOXx39pBkvcBBf//GaBfHrRiu85R8Xzu
         8sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYjRi+AAnNmBItqXaNHpWIQM33HcRz3viz4JZ5iBaUk=;
        b=12AZwWH0nMdhwHiq9/9NGHU7ac8/8MbkA1+174THNSTCXjBDG9aIF/HLre2x5t9HXR
         TAhxgG7fGlvOxn2IXNvnfkKJmuskdZkW5mzW7YPWd8kV2qvjREORYjMvdY08AKVcDoAi
         PduwISpKzfK9FSFcUHOdOPxAov3LDd/lzRV6c/1l94pLl5f/xfA9Q727jn53/LSjD+qy
         WFIAWgZP9yTYwOppx8pMvYQ20m1DK8F3jeeSglEXXpcL3nEodaew/sLClHFd0A4fc7xQ
         hghfaTu9UKBtlZihQGmc38S11iji8nmbKTVerdUpsPt25gQDvF4fs2W0zCo/ctiog4Pr
         Arfg==
X-Gm-Message-State: AO0yUKVT8utMrvaECPh9n2vv+oja5XM58sMjKyvRf+wrOjVQ/lsW4RqR
        jO+6yAtcNYqtN7YUb+4Giu/MTW81uZDoxmj/XYVvfaNSsULJ5g==
X-Google-Smtp-Source: AK7set/dVP8a6BWken57rwnO9pzxv8D5iV6TMHBqKrMlv8XxXIiNejI+9YBWL32a9gH5rdHWOy1uRVXD2Jf1D4L1lK0=
X-Received: by 2002:a2e:b5dc:0:b0:293:34ef:355b with SMTP id
 g28-20020a2eb5dc000000b0029334ef355bmr5403695ljn.6.1677284635690; Fri, 24 Feb
 2023 16:23:55 -0800 (PST)
MIME-Version: 1.0
References: <239b10e11812d99be587265c0a5e283da45ca315.1677143700.git.gitgitgadget@gmail.com>
 <20230224223116.1508846-1-jonathantanmy@google.com>
In-Reply-To: <20230224223116.1508846-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Feb 2023 16:23:42 -0800
Message-ID: <CABPp-BG4KChJa0Kj8n84QBUt5Rc6_rX2Fus3R4MbmUuF6RNuOQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] dir: add a usage note to exclude_per_dir
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 2:31 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > diff --git a/dir.h b/dir.h
> > index 33fd848fc8d..2196e12630c 100644
> > --- a/dir.h
> > +++ b/dir.h
> > @@ -295,8 +295,12 @@ struct dir_struct {
> >       struct untracked_cache *untracked;
> >
> >       /**
> > -      * The name of the file to be read in each directory for excluded files
> > -      * (typically `.gitignore`).
> > +      * Deprecated: ls-files is the only allowed caller; all other callers
> > +      * should leave this as NULL; it pre-dated the
> > +      * setup_standard_excludes() mechanism that replaces this.
> > +      *
> > +      * This field tracks the name of the file to be read in each directory
> > +      * for excluded files (typically `.gitignore`).
> >        */
> >       const char *exclude_per_dir;
>
> I'm not sure what is meant by "allowed caller", but I wouldn't have
> expected this to also mean that unpack-trees would need to know to
> propagate this from o->internal.dir to d in verify_clean_subdirectory.

Are you confusing fields that are internal to dir, with fields that
are internal to unpack-trees?

This series does not make exclude_per_dir an internal field within dir_struct.

Later in this series, we do make the embedded dir_struct within
unpack_trees_options as internal.  Thus every access of any field of
dir within unpack_trees will have an "internal." prefix, but that has
nothing to do with this patch and would still be true even if this
patch were dropped.

> I would be OK with excluding this from the patch set - I think the other
> changes can stand independent of this.

Trying to get a consistent look and feel between commands is
important.  The "setup_standard_excludes()" is one small area where
we've achieved that, and it's shared by _almost_ all commands
(builtin/ls-files being the only exception and it persists for
backward compatibility reasons).  So I definitely want to keep the
deprecation notice and warn people away from using this field.  That's
what this patch is for.
