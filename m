Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646FAC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3999C61409
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhI2ECG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 00:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhI2ECF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 00:02:05 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D56C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 21:00:25 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso1239959ota.8
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 21:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=adDjGDdKCk3yKjDy+UQxmYDd5Xwm8UJHoIITxtq4+/o=;
        b=LLP9wSybYLbn1k7mljMF+kZ93TIbiWpmyDUv0ub8zVgdW/G/AODA7/UD/ynYOijuw/
         ZBlRlx6O94jmtsshvHZNILTd0LDyQWCcDg83qN38uFQEcBiwreDe78UTt9AMUqByS2Ad
         YP0dt3ReNZD1qo8m6FbHtvvOSsimRuJOEIJCQYS8XyiVLjeOSBhJnuRwl2xhqr+Mwwq/
         SEL05H4IkdOQ1OpQxfGnFeTFF7AA3/5v0ZTtk7JuYI4BN3zbrBeBaTsl2iPi0E/YMia8
         q0JvqRiZysgJBA0hriDcwSmKLc8RJjlojUETuswHrC96VTN9pxZ2HTUAPtLbBuZKONon
         pzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=adDjGDdKCk3yKjDy+UQxmYDd5Xwm8UJHoIITxtq4+/o=;
        b=zmz9fGrLgg5DJzfKMxWFF1C58JKM1aqG7j8/qcT4+Ijb7q//Ko8dfaoeXVClPrimfh
         4qzobxWHhoQc9UmsVa+LdclwTV3iaFrul0fdLiD/ER9IQQui/u34Nefqcq2fBKbtg1Bt
         cyZcKLeunfI48/wF0UFfI7WaQtc0ECX2n9LH39AHwfsT83Sxe+YosVndRLGfa3MU4jUA
         cWMhkLJFqIINaGqrsZYoiNpBS0QA/hLsg3wJ6qWr4F49XwgrPlKabIvB0r1JNN4fc2QG
         A+aftweONLChEKl0d362vGoQGw14W9u12oQYTp9AfL0cjT5fUnxe9q0TIU+402DWlYOR
         jENQ==
X-Gm-Message-State: AOAM530kLwIqVsN1Am+JQFMSbYvZbH1iv4ZveZMWZBKB/mgB5yhAxxRF
        wzYxU4fL9t3xfh7Roo7Y8J4ZArIVlqesKn54AoA=
X-Google-Smtp-Source: ABdhPJya/Oi7DO3B98wXEQl4CELyfwGTNHtiURvi7BPlVfhO45sSsMJSnl/Pbs8p7aePkHPizSbxh0eDZOSlQTz9MfQ=
X-Received: by 2002:a05:6830:24ac:: with SMTP id v12mr8326292ots.174.1632888024723;
 Tue, 28 Sep 2021 21:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <b75e73384fde4f23296bd02eb40455263f805706.1630376800.git.gitgitgadget@gmail.com>
 <87mtnxxgz3.fsf@evledraar.gmail.com>
In-Reply-To: <87mtnxxgz3.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Sep 2021 21:00:12 -0700
Message-ID: <CABPp-BGwunfsThNEPAKfXMUZKpHQTCdRU7V8=3J88XThN6=2Kg@mail.gmail.com>
Subject: Re: [PATCH 6/7] show, log: provide a --remerge-diff capability
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 1:05 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Aug 31 2021, Elijah Newren via GitGitGadget wrote:
>
> >  static int decoration_given;
> >  static int use_mailmap_config =3D 1;
> > +static struct tmp_objdir *tmp_objdir;
> >  static const char *fmt_patch_subject_prefix =3D "PATCH";
> >  static int fmt_patch_name_max =3D FORMAT_PATCH_NAME_MAX_DEFAULT;
> >  static const char *fmt_pretty;
>
> So here we make this static file-level etc...
>
> > @@ -407,6 +410,17 @@ static int cmd_log_walk(struct rev_info *rev)
> >       int saved_nrl =3D 0;
> >       int saved_dcctc =3D 0;
> >
> > +     if (rev->remerge_diff) {
> > +             tmp_objdir =3D tmp_objdir_create();
> > +             if (!tmp_objdir)
> > +                     die(_("unable to create temporary object director=
y"));
> > +             tmp_objdir_make_primary(the_repository, tmp_objdir);
> > +
> > +             strbuf_init(&rev->remerge_objdir_location, 0);
> > +             strbuf_addstr(&rev->remerge_objdir_location,
> > +                           tmp_objdir_path(tmp_objdir));
> > +     }
> > +
> >       if (rev->early_output)
> >               setup_early_output();
> >
> > @@ -449,6 +463,13 @@ static int cmd_log_walk(struct rev_info *rev)
> >       rev->diffopt.no_free =3D 0;
> >       diff_free(&rev->diffopt);
> >
> > +     if (rev->remerge_diff) {
> > +             strbuf_release(&rev->remerge_objdir_location);
> > +             tmp_objdir_remove_as_primary(the_repository, tmp_objdir);
> > +             tmp_objdir_destroy(tmp_objdir);
> > +             tmp_objdir =3D NULL;
>
> ...but all of the "tmp_objdir" usage is in one function, can't the
> variable be declared here instead?

That's a very good point.

> We need to hand the "remerge_objdir_location" off to the "rev_info"
> struct, but that seems separate from its lifetime.

Given Peff's suggestion elsewhere, though, to destroy the tmp_objdir
after each merge and create a new one, I wonder if I should actually
be passing a tmp_objdir** to rev_info (allowing log-tree to do the
work of destroying and creating a new one after each merge, instead of
using the "remerge_objdir_location" to run a recursive delete of
files).  That'd still work with your idea to remove the statically
scoped variable, though.

> Re my [1] & [2] I like Neeraj's "atexit cleanup" approach better,
> perhaps that makes your cleanup in log-tree.c redundant or easier?

Having an atexit cleanup as a safety measure seems fine.  However, I
don't like avoiding the manual cleanup step and relying on atexit
cleanup; I'd go so far as to say I think that'd be a bug, at least for
my usage.  It presumes one-shot usage, whereas I'd rather move git to
being more library-like.

However, fully destroying the tmp_objdir probably makes the cleanup in
log-tree.c easier.

> Per [2] it looks like you need to "hand off" the
> "remerge_objdir_location", so having the struct live in tmp-objdir.h as
> I suggested in [2] might make that work...
>
> 1. https://lore.kernel.org/git/87v92lxhh4.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/87r1d9xh71.fsf@evledraar.gmail.com/
