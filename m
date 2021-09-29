Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F843C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4694B6138D
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhI2EFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 00:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhI2EFu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 00:05:50 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DEBC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 21:04:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so1216041ota.13
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 21:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/CPuQK5qimaYHsXo7eQfgGpK3bHkOZniDlyt3YDpUg=;
        b=bb8/jbhyCSNcIm3UxrQT7eu5Pm7XpDkG0+kyNTKHvW3/3Gqt1n0hq4hpwUDtDhDpce
         95qA4b7hGzRIMgnHQeSMzal/zJIfaBmT6IOFaS8g2nQXXXk3twbb7iXWpgSq+mqH6Jt3
         7eU17T6Ist6G4PDj53aQNfgSx7qcM8a34c3mbWBnMVfcCN6hbR4eNbibvSrzTnL4VmAw
         +8nE6wpLv7LZvfDDHBaAbfqhM14NeoukpqXorak52zR9f4xmyVRSo0VGcgmtrKcVW4t2
         KP8CnQdY6lvACzdXZPkwRH+BmKC+4ugZ69Ag+zwvRbmhuz2FUvUmgSaDLhtjlu3VHQIe
         a+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/CPuQK5qimaYHsXo7eQfgGpK3bHkOZniDlyt3YDpUg=;
        b=mCI+iZ6JxYwoaJ3HExDcfcxhOWwrCKcL3eg0aUoGc0Ood0/tgXA4BwocJptEwhpS4h
         ZykWUOsvdMPWMsN6yDSyJIcuO5pWURcDlHLCZnqMhXG5JI+BN7+3GiIUCuYgZT8vV/EL
         7ZedCSpQgF/1h595d5U0JYkGwImbomcsfezyR0WkJpG3OTJONTTHJwblVY6gRde9wLsz
         KHsTHLQ4IDT72UdCYpwlfRdeEM8WQvmIHrV87kAE7TXYZWfHf0Mbb4ZQYHSN7e1vQYyT
         elhmH87NEKe6HALlK9zJB5hS0KsOwJi2DDqhJoplzncSdT14xBNQrJNF2WobjVGVf3ld
         n40A==
X-Gm-Message-State: AOAM5315J9hXeoBnFXoZDLiAN0sOiKnl7dBP5TSdIMQyfqt0Ac37jGKG
        jt+34mH5rflJQjMoTLictVtOzOYbRSQAHf6cS2M=
X-Google-Smtp-Source: ABdhPJxOU07vgCbQNYVHR9zIlR0gZypODuA1wJN/+sGyygqrC2kJ8eLrv5sfePdJ6/TY058yTuaWBOyLdNYphvS+ceE=
X-Received: by 2002:a05:6830:24ac:: with SMTP id v12mr8339062ots.174.1632888248588;
 Tue, 28 Sep 2021 21:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <2bf5efb5169b71ee7c1da006a74aa67794f1399d.1630376800.git.gitgitgadget@gmail.com>
 <YVOZRhWttzF18Xql@coredump.intra.peff.net>
In-Reply-To: <YVOZRhWttzF18Xql@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Sep 2021 21:03:56 -0700
Message-ID: <CABPp-BGH+zgLuxQpy8DF0MefGfoVc26Z2RwsNN9yvs98jvkn3Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] ll-merge: add API for capturing warnings in a strbuf
 instead of stderr
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 3:37 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 31, 2021 at 02:26:36AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Whenever ll-merge encounters a binary file, it prints a warning to
> > stderr.  However, for the --remerge-diff option we want to add, we need
> > to capture all conflict messages and show them in a diff instead of
> > dumping them straight to stdout or stderr.  Add some new API that will
> > allow us to capture this output and display it in our preferred method.
>
> This is a reasonable strategy for error-handling in general (though some
> more thoughts below).
>
> > @@ -71,8 +75,11 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
> >       } else {
> >               switch (opts->variant) {
> >               default:
> > -                     warning("Cannot merge binary files: %s (%s vs. %s)",
> > -                             path, name1, name2);
> > +                     if (warnings) {
> > +                             strbuf_addstr(warnings, "Warning: ");
> > +                             strbuf_addf(warnings, msg, path, name1, name2);
> > +                     } else
> > +                             warning(msg, path, name1, name2);
>
> The usual warn_builtin() has a lowercase "warning: " prefix, but your
> strbuf variant uses uppercase.

Ah, thanks for catching that.  I can fix it up.

> > @@ -98,6 +105,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
> >
> >  static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
> >                       mmbuffer_t *result,
> > +                     struct strbuf *warnings,
> >                       const char *path,
> >                       mmfile_t *orig, const char *orig_name,
> >                       mmfile_t *src1, const char *name1,
>
> There's a lot of plumbing this variable through. This is probably too
> gross, but another option would be to call set_warn_routine() to
> override it temporarily. It's gross because it affects everything, not
> just this call stack (and I also think we'd need to beef up the warn
> routine code to handle some of the rough edges).
>
> I do wonder if the ll_merge() code should avoid calling warning() in the
> first place. It is after all, meant to be "low-level". We already return
> an error code from the function. I wonder if returning a more detailed
> code instead, like:
>
>   enum LL_MERGE_RESULT {
>         LL_MERGE_OK = 0,
>         LL_MERGE_CONFLICT,
>         LL_MERGE_BINARY_CONFLICT,
>   };
>
> would let the caller do the sensible thing.

Ooh, I like this idea.  I'll have to change all the callers, but
there's only about half a dozen or so...
