Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3217FC6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 01:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBYBzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 20:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBYBzR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 20:55:17 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AA4618F
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 17:54:37 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bbaeceeaso20008507b3.11
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 17:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Y5VGvY4QKCs8zW7gq2gAUmh31rsCn8gqb5TF4tbJxo=;
        b=EDciOFA9s0dKOYNKvH1dWuGUAquocdU3mBtWs7d71x0j+91dOfhAZC2REIcFW09OKP
         AaIoLMbhZIrTFVb4iEIpGCD0plfqxdsoaBxO2nw0cdJGwzVy23wUM5k1RAjgNYQs/Zq6
         OPENrFoAptLsKWKMS9SPzMqUp2/QVVEI0aM8PkflB9lz2HgGewyDaq5fxov1DX5r+Gnu
         FwDLIEM7sLTKt7437xfl4r14UNedIqwsXioVtJAMMkIhjRiICfMc16cr3OFRQJ9KDrZl
         GURyuQK8MYLp6qh99jnvFPGF/a8wa7nKZq20oNRE6xIn42mJagLRuBvexfyBzXqCbxEI
         Q/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y5VGvY4QKCs8zW7gq2gAUmh31rsCn8gqb5TF4tbJxo=;
        b=zTDncnG1rZnTz72fc9pavaAypfgujRrYzJgKNBSBfsebGh2paAmIMgFCHogUTl9b3P
         Q2dxbomUVaEzaJkPTs4uLYchSgr214Q4Uav6a5OrXRrO81SsPoY4U/xr7iYJ5oHrKS02
         Wdhnk1w7tE0wmYOhVdh48oCcw95HeVzFd+CM5yLL83cWkj7EgwfvntOdBem1ycw6iO+W
         ZlSZ39lPUdwyRyQdKYQNkZxJSyh1kE7eYOpDl8MNPSvR/eRAg9X6C1dhNh+7qw+XNX/M
         Y64/txrbAD6ZqC3t8GHsabizfrebpm7St6MIawiJIH+l2MJ+om3k3qIzow6WZZ8UdIRf
         z6uA==
X-Gm-Message-State: AO0yUKVg8qvPFhJDX/oEmahWthSQ0k79vHOd5XSfhk9Z3OGxDu/ABx5e
        ZglUgPEiQKiMfH1y+FRiBA9x4Wyim8/UM+xEWbR7
X-Google-Smtp-Source: AK7set/lyTXQRdjTUDl2fsWnUojvX2j4GB8j9ESVHrAJpYq/RPtH7FAUPlRXKEoRynFv2p6cR76/70bT4sUqsMl3pogV
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:60fb:bc56:6979:1f96])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:b10:0:b0:8e6:f40a:adc7 with SMTP
 id z16-20020a5b0b10000000b008e6f40aadc7mr5219767ybp.6.1677290074521; Fri, 24
 Feb 2023 17:54:34 -0800 (PST)
Date:   Fri, 24 Feb 2023 17:54:32 -0800
In-Reply-To: <CABPp-BG4KChJa0Kj8n84QBUt5Rc6_rX2Fus3R4MbmUuF6RNuOQ@mail.gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230225015432.2065788-1-jonathantanmy@google.com>
Subject: Re: [PATCH 02/11] dir: add a usage note to exclude_per_dir
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> On Fri, Feb 24, 2023 at 2:31 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > diff --git a/dir.h b/dir.h
> > > index 33fd848fc8d..2196e12630c 100644
> > > --- a/dir.h
> > > +++ b/dir.h
> > > @@ -295,8 +295,12 @@ struct dir_struct {
> > >       struct untracked_cache *untracked;
> > >
> > >       /**
> > > -      * The name of the file to be read in each directory for excluded files
> > > -      * (typically `.gitignore`).
> > > +      * Deprecated: ls-files is the only allowed caller; all other callers
> > > +      * should leave this as NULL; it pre-dated the
> > > +      * setup_standard_excludes() mechanism that replaces this.
> > > +      *
> > > +      * This field tracks the name of the file to be read in each directory
> > > +      * for excluded files (typically `.gitignore`).
> > >        */
> > >       const char *exclude_per_dir;
> >
> > I'm not sure what is meant by "allowed caller", but I wouldn't have
> > expected this to also mean that unpack-trees would need to know to
> > propagate this from o->internal.dir to d in verify_clean_subdirectory.
> 
> Are you confusing fields that are internal to dir, with fields that
> are internal to unpack-trees?
> 
> This series does not make exclude_per_dir an internal field within dir_struct.

Agreed, but the comment says that ls-files is the only allowed caller,
and I would have expected that non-"allowed callers" would not need to
write to exclude_per_dir. But in unpack-trees.c:

  2346          if (o->internal.dir)                                                                                                       
  2347                  d.exclude_per_dir = o->internal.dir->exclude_per_dir;

Both "d" and "o->internal.dir" are of type "struct dir_struct" (well,
one is not a pointer and one is). I would not have expected such non-
ls-files code to read or write from this field. (But if unpack-trees
is considered part of ls-files and/or copying the same field to another
struct is not considered "calling", then this patch is fine, I guess.)
