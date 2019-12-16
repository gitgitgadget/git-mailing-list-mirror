Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A090CC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 16:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722502067C
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 16:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwd8Dnq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLPQBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:01:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42153 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfLPQBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 11:01:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so9746106otd.9
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i07q50e1wNTWbiK6JhnnKJbjctgiQLdNx3rRxDhV1KM=;
        b=rwd8Dnq0Mpeo7CandbCqi+neudVNFHKCWAPJ+xsbHbkt+b7tAcPOMXhvPCKlmcMTLA
         JO6bM7EJaZpM5z0zPSoV6XHHqtfu+j6qAr7qf20+MKJGhOsIK9tEAsBblTFHKBbh3zMF
         GZAAXOocPlH63SICagZFjKG8/hLHJmj52xeNCJqjO3cgQYwCTOY2xpRDERpDSihmWA0c
         hP0J21jzhRKSBvDLuZwd5qpDDnzRO4LkpkluNq8grPaP0d2Q/99sovODLQryTWrM0Oco
         li986mCr8oBTH4RYKUOx/yVuQ2J+qmWPvoI4esKMpqBBJq4jFDwg/zK8DTwHs7YT87bF
         ZdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i07q50e1wNTWbiK6JhnnKJbjctgiQLdNx3rRxDhV1KM=;
        b=LCVuxkWibBZn0H050qC6QWrA62Uqd1YsUJDz0K9UkhS7RlyxKqnNrleIeW0SnSKKe8
         uJ+jtRR9jT5t9yLeJEruXtLognEL8LSB1cAtvOfiMFmchEREPPmjUi7sjWPMe9cFhg/o
         SGQDzS7Kpg200MpW7vhPilZk1AfupoimPSl3nVt7Z7rTCCHe7TMFnEnhQULbKeuBpTMm
         VCjNSm47scQ+EIoxMczRK6E6QhqLQvU9WcTF4IB5d+WOueVi7kJjaKdm3lPFNN+/vWmm
         Z64FXhsuMXhMM3kHgQL59jFZ7tcW0wKWpTPWQ3aLjgZCfMu5QIKD3ohwv0EP9si5B4cR
         HaCA==
X-Gm-Message-State: APjAAAWB6ixUXMvpyvR19C6CfxTlxtR8ngPwvJ0kxgRzgFDlfYVa4KnV
        r4re74L3/vthwpXMdfhSWx20GnKNZ6daQVDHEelEldwG
X-Google-Smtp-Source: APXvYqwgVLocOBvEJ1X52gFJNfxX37IpvSfIrFhWuPrQQt3UOrsudh7a8t7RWpE5/fZYNvwne2pws94melRdsw25lYY=
X-Received: by 2002:a05:6830:681:: with SMTP id q1mr32738894otr.162.1576512067841;
 Mon, 16 Dec 2019 08:01:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet> <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com>
In-Reply-To: <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Dec 2019 08:00:56 -0800
Message-ID: <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com>
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

On Mon, Dec 16, 2019 at 5:51 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Sun, Dec 15, 2019 at 2:29 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Elijah,
> >
> > I have not had time to dive deeply into this, but I know that it _does_
> > cause a ton of segmentation faults in the `shears/pu` branch (where all of
> > Git for Windows' patches are rebased on top of `pu`):
>
> Weird.  If it's going to cause segmentation faults at all, it would
> certainly do it all over the place, but I tested the patches on the
> major platforms using your Azure Pipelines setup on git.git so it
> should be good on all the platforms.  Did your shears/pu branch make
> some other changes to the setup?
>
> > On Tue, 10 Dec 2019, Elijah Newren via GitGitGadget wrote:
> >
> > > diff --git a/dir.c b/dir.c
> > > index 645b44ea64..9c71a9ac21 100644
> > > --- a/dir.c
> > > +++ b/dir.c
> > > @@ -2102,37 +2102,69 @@ static int treat_leading_path(struct dir_struct *dir,
> > >                             const struct pathspec *pathspec)
> > >  {
> > >       struct strbuf sb = STRBUF_INIT;
> > > -     int baselen, rc = 0;
> > > +     int prevlen, baselen;
> > >       const char *cp;
> > > +     struct cached_dir cdir;
> > > +     struct dirent de;
> > > +     enum path_treatment state = path_none;
> > > +
> > > +     /*
> > > +      * For each directory component of path, we are going to check whether
> > > +      * that path is relevant given the pathspec.  For example, if path is
> > > +      *    foo/bar/baz/
> > > +      * then we will ask treat_path() whether we should go into foo, then
> > > +      * whether we should go into bar, then whether baz is relevant.
> > > +      * Checking each is important because e.g. if path is
> > > +      *    .git/info/
> > > +      * then we need to check .git to know we shouldn't traverse it.
> > > +      * If the return from treat_path() is:
> > > +      *    * path_none, for any path, we return false.
> > > +      *    * path_recurse, for all path components, we return true
> > > +      *    * <anything else> for some intermediate component, we make sure
> > > +      *        to add that path to the relevant list but return false
> > > +      *        signifying that we shouldn't recurse into it.
> > > +      */
> > >
> > >       while (len && path[len - 1] == '/')
> > >               len--;
> > >       if (!len)
> > >               return 1;
> > > +
> > > +     memset(&cdir, 0, sizeof(cdir));
> > > +     memset(&de, 0, sizeof(de));
> > > +     cdir.de = &de;
> > > +     de.d_type = DT_DIR;
> >
> > So here, `de` is zeroed out, and therefore `de.d_name` is `NULL`.
>
> Um, yeah...didn't I have an allocation of de.d_name here?  It will
> always have a subset of path copied into it, so an allocation of len+1
> is plenty long enough.

Actually, it looks like I looked up the definition of dirent
previously and forgot by the time you emailed.  On linux, from
/usr/include/bits/dirent.h:

struct dirent
  {
    ....
    unsigned char d_type;
    char d_name[256];           /* We must not include limits.h! */
  };

and from compat/win32/dirent.h defines it as:

struct dirent {
        unsigned char d_type;      /* file type to prevent lstat after
readdir */
        char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8 conversion) */
};

and 'man dirent' on Mac OS X says it's defined as:

struct dirent {
        ...
        _uint8_t d_type;
        _unit8_t d_namlen;   /* length of string in d_name */
        char    d_name[255+1];  /* name must be no longer than this */
}

so, allocating it would be incorrect and my memset would just fill
d_name with nul characters.


But the raises the question...what kind of segfaults are you getting?
Can you link to any builds or post any stack traces?  Can I duplicate
with some copy of git-for-windows on linux?
