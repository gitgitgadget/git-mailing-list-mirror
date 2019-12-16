Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11606C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 13:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD8A20684
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 13:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwKjOIPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfLPNvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:51:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43621 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfLPNvn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 08:51:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so9273700oth.10
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 05:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMLphM8iptsVq4LPU77bEmZDD7BPEb4ItUMsS5tfGKo=;
        b=SwKjOIPF9ITouP0H1AFpq9y9jMVkOEM8QtiK6D/mgxG3lihoeiPe5SkqGQ8nB5VueG
         OggXymZAOZ/VI8foGZeKgThYgM6Rwq3i72pKRfbwFZgBYQf+xRftLRHBUJ0yu1EkHeLm
         Wh5Vm51o74bTSWkaGbwzPwd1zb+DLWdZlsGBzlpcK8jHuVE10m9MtrvY0mP+jd5wH+AC
         VvXVuCbbXGZUhZ5XV84SpuppoMSLukkwDffjM4aXUBn5Wg7XWKnq52PvWMtFWCrRSzEM
         88+fjMuPBOaUFSPHi6KJumV/Of5BvsMCSkNv1fHVTJ7guBUFNm3o6GuV2R7oPAD0JuBn
         qptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMLphM8iptsVq4LPU77bEmZDD7BPEb4ItUMsS5tfGKo=;
        b=EFagNDlUetYfbDQoUHbWUmxhpo7Blg5i9J4hyQAXSu56MhLcwpP3GFmRFBy+xCRs7y
         DvOrZywNTgyJC15I0tgD3jJf+Y9D7w4sQKkqaqA3crDwfIFy+h5cZ+DKjyjKWaNfogic
         mk2kNcPhcHiMxrVsl8ZxHrP570r5CdzUZH7tb8SpqDqNeUQsNRZZ0g74+AXfDduvrJK+
         FCIlSmqtnMwGwZXMsp28+RXqC1DTz+Yfq1C6upAGauv15HjcuAwR7shy+0YUd9Y0haNC
         3TE9ITNy4un7yFrdnY9tpKvWJ4LHYT9pO9oPCafVRstHKIPb9xBHYHImMFunPF6amcFc
         4SCg==
X-Gm-Message-State: APjAAAVVryelyB4TZd/tW0JSgLPF+wh5b7zXiXPeI28cUZMh+9XLcztL
        54dICvsevnw9Ck1u/WS6Ps+XymmxBZe+silJ3nw=
X-Google-Smtp-Source: APXvYqwodD4+nLQ6lnBlLILSISmapWZJ5QsI8q3ePAGRyxnS3LucdqepHr35vqlLpF56vn58CYHTAlOrpcm+MuRDBjE=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr31018489otq.112.1576504301710;
 Mon, 16 Dec 2019 05:51:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Dec 2019 05:51:30 -0800
Message-ID: <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 15, 2019 at 2:29 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> I have not had time to dive deeply into this, but I know that it _does_
> cause a ton of segmentation faults in the `shears/pu` branch (where all of
> Git for Windows' patches are rebased on top of `pu`):

Weird.  If it's going to cause segmentation faults at all, it would
certainly do it all over the place, but I tested the patches on the
major platforms using your Azure Pipelines setup on git.git so it
should be good on all the platforms.  Did your shears/pu branch make
some other changes to the setup?

> On Tue, 10 Dec 2019, Elijah Newren via GitGitGadget wrote:
>
> > diff --git a/dir.c b/dir.c
> > index 645b44ea64..9c71a9ac21 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -2102,37 +2102,69 @@ static int treat_leading_path(struct dir_struct *dir,
> >                             const struct pathspec *pathspec)
> >  {
> >       struct strbuf sb = STRBUF_INIT;
> > -     int baselen, rc = 0;
> > +     int prevlen, baselen;
> >       const char *cp;
> > +     struct cached_dir cdir;
> > +     struct dirent de;
> > +     enum path_treatment state = path_none;
> > +
> > +     /*
> > +      * For each directory component of path, we are going to check whether
> > +      * that path is relevant given the pathspec.  For example, if path is
> > +      *    foo/bar/baz/
> > +      * then we will ask treat_path() whether we should go into foo, then
> > +      * whether we should go into bar, then whether baz is relevant.
> > +      * Checking each is important because e.g. if path is
> > +      *    .git/info/
> > +      * then we need to check .git to know we shouldn't traverse it.
> > +      * If the return from treat_path() is:
> > +      *    * path_none, for any path, we return false.
> > +      *    * path_recurse, for all path components, we return true
> > +      *    * <anything else> for some intermediate component, we make sure
> > +      *        to add that path to the relevant list but return false
> > +      *        signifying that we shouldn't recurse into it.
> > +      */
> >
> >       while (len && path[len - 1] == '/')
> >               len--;
> >       if (!len)
> >               return 1;
> > +
> > +     memset(&cdir, 0, sizeof(cdir));
> > +     memset(&de, 0, sizeof(de));
> > +     cdir.de = &de;
> > +     de.d_type = DT_DIR;
>
> So here, `de` is zeroed out, and therefore `de.d_name` is `NULL`.

Um, yeah...didn't I have an allocation of de.d_name here?  It will
always have a subset of path copied into it, so an allocation of len+1
is plenty long enough.

> >       baselen = 0;
> > +     prevlen = 0;
> >       while (1) {
> > -             cp = path + baselen + !!baselen;
> > +             prevlen = baselen + !!baselen;
> > +             cp = path + prevlen;
> >               cp = memchr(cp, '/', path + len - cp);
> >               if (!cp)
> >                       baselen = len;
> >               else
> >                       baselen = cp - path;
> > -             strbuf_setlen(&sb, 0);
> > +             strbuf_reset(&sb);
> >               strbuf_add(&sb, path, baselen);
> >               if (!is_directory(sb.buf))
> >                       break;
> > -             if (simplify_away(sb.buf, sb.len, pathspec))
> > -                     break;
> > -             if (treat_one_path(dir, NULL, istate, &sb, baselen, pathspec,
> > -                                DT_DIR, NULL) == path_none)
> > +             strbuf_reset(&sb);
> > +             strbuf_add(&sb, path, prevlen);
> > +             memcpy(de.d_name, path+prevlen, baselen-prevlen);
>
> But here we try to copy a path into that `de.d_name`, which is still
> `NULL`?
>
> That can't be right, can it?

Yes, it can't be right.  How did this possibly pass on any platform
let alone all of them?
(https://dev.azure.com/git/git/_build/results?buildId=1462&view=results).
This is absolutely an important codepath that is hit; otherwise it
couldn't fix the three tests from failure to success.  Further, the
subsequent patch added code within this if-block after this memcpy and
fixed a few tests from failures to success.  So it had to hit this
code path as well.  How could it not have segfaulted?  I'm very
confused...
