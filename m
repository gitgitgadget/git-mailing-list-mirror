Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2F6C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 22:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbhK3Wjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 17:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344342AbhK3Wjm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 17:39:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C5C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 14:36:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w1so93437071edc.6
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 14:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7tsE+oNKs5cJ+MN2sH93Fg0PS8cfOOHW8HFQJZkmm8=;
        b=kYQRw2O2T3uay3xBEyEkdU/UWCCCbHrtc771z0mfyuWAifIyLrVB7a16+uUomC5JCd
         LPspwchahoWlFRj9QNd9yyCKNxiJ+SIISSvxHaEZMth38ckCMfvoxRvf1IAcTdtwHcy2
         hu2NB7k137DEEqS24cBVnDswpNgJ3BTzUZvGHrnHEWxdeoph/DCOp9SghNbIX+SYrmKU
         6v1f4VrC3yvp2+6KYHSWFaSbyzDoLl2CKefgUkUtuFTtc53Ru+giON6ElH5lSn5IChq6
         kU9Oxdzo7XJ44wGDZRkSABUypXu1qboN0vag4S69dIUGk2duF3+jA7cwLOcI2rC/CmF8
         XKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7tsE+oNKs5cJ+MN2sH93Fg0PS8cfOOHW8HFQJZkmm8=;
        b=ACzatwI0fUyZ3V5bminwUvhTydElUBcrS+xGcrV+8buY56UnYaFFTeuereQdXmtyCS
         0pVCNL8fjX7RhmBxI0C8wNaA66XNuVsOC7bbBkTaY83OBTNZwxr/Xk/os3wjYa3vQzkB
         OI1CI0NaEAW2TsOBZk23mKUYtdQgj1uHnegwLG5I5XFSmNSWArySN50RaLwcMwnfDqzY
         RRG/sbVO64dHxm8NQWNlrEAkNILLASMT64chjabhYlaIo7c1HtS8o5Dkyxf9KuqtmZpG
         5dm5IZfmy9VR2o+IVNtXvN85/lvnICUrP7xi3wb3Ye6O4briHc6EbxCCWnOXYHaiZGgJ
         XgVw==
X-Gm-Message-State: AOAM533sflvqpiA+hcIYVrmgpO6SBTM9AliJ/v6hfeKmkHiaEXrVnXtj
        Pa6s51akbs3XHSCA4tUyusYtmq0F8EfpvRSxRwY=
X-Google-Smtp-Source: ABdhPJyRTPlLVsMHtt71tvUaRkyrGidGPSB/c7todmu3yRecYVSWJsRdi3BsqzfeNUSxquCim18LpIzMWfp5TfFTsZQ=
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr2296010ejf.341.1638311781495;
 Tue, 30 Nov 2021 14:36:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <6b27afa60e05c6c0b7752f1bcf6629c446ede520.1637020263.git.gitgitgadget@gmail.com>
 <CABPp-BH6m4q_EoX77bqLcpCN1HRfJ_XayeCV2O0sRybX53rPrw@mail.gmail.com> <CANQDOdd7EHUqD_JBdO9ArpvOQYUnU9GSL6EVR7W7XXgNASZyhQ@mail.gmail.com>
In-Reply-To: <CANQDOdd7EHUqD_JBdO9ArpvOQYUnU9GSL6EVR7W7XXgNASZyhQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Nov 2021 14:36:10 -0800
Message-ID: <CABPp-BELu8xzJeSoDtMYFXj6Zw6JSm4qgBSXnSFmQbGzwjiD_Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] tmp-objdir: new API for creating temporary
 writable databases
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 1:52 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On Tue, Nov 30, 2021 at 1:27 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Nov 15, 2021 at 3:51 PM Neeraj Singh via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: Neeraj Singh <neerajsi@microsoft.com>
> > >
> > > The tmp_objdir API provides the ability to create temporary object
> > > directories, but was designed with the goal of having subprocesses
> > > access these object stores, followed by the main process migrating
> > > objects from it to the main object store or just deleting it.  The
> > > subprocesses would view it as their primary datastore and write to it.
> > >
> > > Here we add the tmp_objdir_replace_primary_odb function that replaces
> > > the current process's writable "main" object directory with the
> > > specified one. The previous main object directory is restored in either
> > > tmp_objdir_migrate or tmp_objdir_destroy.
> > >
> > > For the --remerge-diff usecase, add a new `will_destroy` flag in `struct
> > > object_database` to mark ephemeral object databases that do not require
> > > fsync durability.
> > >
> > > Add 'git prune' support for removing temporary object databases, and
> > > make sure that they have a name starting with tmp_ and containing an
> > > operation-specific name.
> > >
> > > Based-on-patch-by: Elijah Newren <newren@gmail.com>
> > >
> > > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > > ---
> > >  builtin/prune.c        | 23 +++++++++++++++---
> > >  builtin/receive-pack.c |  2 +-
> > >  environment.c          |  5 ++++
> > >  object-file.c          | 44 +++++++++++++++++++++++++++++++--
> > >  object-store.h         | 19 +++++++++++++++
> > >  object.c               |  2 +-
> > >  tmp-objdir.c           | 55 +++++++++++++++++++++++++++++++++++++++---
> > >  tmp-objdir.h           | 29 +++++++++++++++++++---
> > >  8 files changed, 165 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/builtin/prune.c b/builtin/prune.c
> > > index 485c9a3c56f..a76e6a5f0e8 100644
> > > --- a/builtin/prune.c
> > > +++ b/builtin/prune.c
> > > @@ -18,6 +18,7 @@ static int show_only;
> > >  static int verbose;
> > >  static timestamp_t expire;
> > >  static int show_progress = -1;
> > > +static struct strbuf remove_dir_buf = STRBUF_INIT;
> > >
> > >  static int prune_tmp_file(const char *fullpath)
> > >  {
> > > @@ -26,10 +27,20 @@ static int prune_tmp_file(const char *fullpath)
> > >                 return error("Could not stat '%s'", fullpath);
> > >         if (st.st_mtime > expire)
> > >                 return 0;
> > > -       if (show_only || verbose)
> > > -               printf("Removing stale temporary file %s\n", fullpath);
> > > -       if (!show_only)
> > > -               unlink_or_warn(fullpath);
> > > +       if (S_ISDIR(st.st_mode)) {
> > > +               if (show_only || verbose)
> > > +                       printf("Removing stale temporary directory %s\n", fullpath);
> > > +               if (!show_only) {
> > > +                       strbuf_reset(&remove_dir_buf);
> > > +                       strbuf_addstr(&remove_dir_buf, fullpath);
> > > +                       remove_dir_recursively(&remove_dir_buf, 0);
> >
> > Why not just define remove_dir_buf here rather than as a global?  It'd
> > not only make the code more readable by keeping everything localized,
> > it would have prevented the forgotten strbuf_reset() bug from the
> > earlier round of this patch.
> >
> > Sure, that'd be an extra memory allocation/free for each directory you
> > hit, which should be negligible compared to the cost of
> > remove_dir_recursively()...and I'm not sure this is performance
> > critical anyway (I don't see why we'd expect more than O(1) cruft
> > temporary directories).
>
> I'll take this suggestion.
>
> > > +               }
> > > +       } else {
> > > +               if (show_only || verbose)
> > > +                       printf("Removing stale temporary file %s\n", fullpath);
> > > +               if (!show_only)
> > > +                       unlink_or_warn(fullpath);
> > > +       }
> > >         return 0;
> > >  }
> > >
> > > @@ -97,6 +108,9 @@ static int prune_cruft(const char *basename, const char *path, void *data)
> > >
> > >  static int prune_subdir(unsigned int nr, const char *path, void *data)
> > >  {
> > > +       if (verbose)
> >
> > Shouldn't this be
> >     if (show_only || verbose)
> > ?
>
> Doing that breaks one of the tests, since we print extra stuff that's
> unexpected. I think I'm going to just revert this change, since it
> appears that we call this callback and try to remove the directory
> even if it's non-empty.

Makes sense.

> Do you have any comments or thoughts on how we want to allow the user
> to configure fsync settings?

I don't; sorry.
