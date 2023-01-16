Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D156C46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjAPRgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjAPRgH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:36:07 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155F838B4E
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:12:23 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4d13cb4bbffso268842997b3.3
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rak6xYxkBW1XCHYUlam22uTySF+kDpvdUJu3Eh/kB5Q=;
        b=Nd702OuzKQnN9BXOYhvjLyxOUARxCa5En3NxivLC7Bku7rJXMGfzEJ2zrtbilbmQxw
         sOiApadXoUr08+Yny7zxOtf25zAg+fqP6ZViRpIdXmUz0DzdW3KwA6DSJLKLXsYtjLTY
         A/XlNV/asNR3UmIzqD+HMyqCI659IJ40Mqw7rZs615mrbLx1xE5/U81MGfaADch6KGS1
         6YCKAVP4kqLV5wBfkkaYql3NWg5DSphpva8AxUs2OHXH5dFxQMbKu+tGRkIn4IXFd/OP
         TUCAdVHTG9UwZ7NN0rwklj1vqeiMgbcEtr55EwC9s9BFpXKJFHK9rpvLnoD1UeaNEaQt
         urAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rak6xYxkBW1XCHYUlam22uTySF+kDpvdUJu3Eh/kB5Q=;
        b=P0naRKaCAqy+7LnnhC+oPw81MfEqf28CLsa3oyst61/nh7xTO7/+rU2AGBnjU2pI8h
         2vfdnbW59ZT/fhX4AIiDrBBlONPzC9e/0AM8/i3pORiKPBzjW2XOW0WghiVgFcptyYds
         vXyqOwOchix+1liizscDIVCwnpCMh+nSKH9s9qnsfR3Bd5YcR9l9xLJ5ukNaI1wp4eJD
         rd/n5IlHL+r0PMVVftgVsshOmOLRtkUjKafwJ6Iw3iXD7r3oaav+t8eiE62DFe/+em9D
         ykv/mzsqFwEx/gXBS3wbjgZh0Jpia08L+yx84V5J7b1WpwRohW8LbmqnYGB9Q6yF6naT
         buug==
X-Gm-Message-State: AFqh2kqSTE6fY2FyKGvLKv6G2+ii6/4PjVcMxPT/JGOrjjCzvhhqsJmg
        MVesT5hbpxlO6UMk439XQDEryuhbwpljFRfCGyhdKpSnpl0PVg==
X-Google-Smtp-Source: AMrXdXu4atWHLzFSVSVJNijQsgLuzjYbLFp4W7LsaK9wOmzJ3v2tp8kwW9bh+UiWier+I7BnffzFakm+P3U0obw3awo=
X-Received: by 2002:a81:7b86:0:b0:46a:ca45:4844 with SMTP id
 w128-20020a817b86000000b0046aca454844mr11919ywc.43.1673889142177; Mon, 16 Jan
 2023 09:12:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
 <1d1330243109d499d1c07f6518265b2e163406ef.1673584914.git.gitgitgadget@gmail.com>
 <CAOLTT8Qx6chcA7MEY9Hzeq9U5pfR-fC8aOxhZMvYvi8ZtQeVdA@mail.gmail.com> <CABPp-BFuZK2yap_VXWPo8qHvJ+E9V7v2UAZ9tAaQcX8zc-daDA@mail.gmail.com>
In-Reply-To: <CABPp-BFuZK2yap_VXWPo8qHvJ+E9V7v2UAZ9tAaQcX8zc-daDA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 17 Jan 2023 01:12:10 +0800
Message-ID: <CAOLTT8TxHhbjicJp1fEdjGhmP2AwOef3OU9t+tWOLq+XDcJLOg@mail.gmail.com>
Subject: Re: [PATCH 2/4] ls-files: clarify descriptions of file selection options
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8815=E6=97=
=A5=E5=91=A8=E6=97=A5 03:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jan 14, 2023 at 12:21 AM ZheNing Hu <adlternative@gmail.com> wrot=
e:
> >
> > Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=
=E5=B9=B41=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=94 12:41=E5=86=99=E9=81=93=EF=
=BC=9A
> [...]
> > > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fi=
les.txt
> > > index cb071583f8b..f89ab1bfc98 100644
> > > --- a/Documentation/git-ls-files.txt
> > > +++ b/Documentation/git-ls-files.txt
> > > @@ -29,21 +29,26 @@ This merges the file listing in the index with th=
e actual working
> > >  directory list, and shows different combinations of the two.
> > >
> > >  One or more of the options below may be used to determine the files
> > > -shown:
> > > +shown, and each file may be printed multiple times if there are
> > > +multiple entries in the index or multiple statuses are applicable fo=
r
> > > +the relevant file selection options.
> > >
> >
> > `--deduplicate` option can be used to remove deduped output.
>
> Yes, I'm aware.
>
> If you're suggesting adding this text at this point in the document,
> it occurred to me already, but I chose not to put it here.  The reason
> is that this is a brief synopsis.  The "relevant file selection
> options" of this brief synopsis could also be expanded to mention what
> they are or what the default selection is or whatever.  But folks can
> read on to learn that `deduplicate` can be used to remove duplicate
> options.  Likewise, anyone who reads the text about "relevant file
> selections" and wants to learn more is inclined to read on to the
> other options to find out.
>
> In contrast, no one will be motivated to read on to find out that
> files can be printed multiple times if we don't mention it right here.
> And they are likely to get confused when it happens, thinking it is a
> bug (in fact, I can point out emails from the archives where that has
> happened).  Without mentioning the possibility of multiple files at
> this point, we have a discoverability problem.
>
> There is no similar discoverability and negative-surprise problem I
> can think of by omitting other details, so there is no need to expand
> this brief synopsis any further.
>

Well, you are right. It may be better to be concise here, telling users too
much will make it difficult to read.

> The one place we could potentially change thing that might help, is
> moving the text about -c being the default from under the -c option
> and putting it here.  That's a toss-up to me, but for now I elected to
> keep it where it is.
>

I think it's fine to do this or not.

> > >  OPTIONS
> > >  -------
> > >  -c::
> > >  --cached::
> > > -       Show cached files in the output (default)
> > > +       Show all files cached in Git's index, i.e. all tracked files.
> > > +       (This is the default if no -c/-s/-d/-o/-u/-k/-m/--resolve-und=
o
> > > +       options are specified.)
> > >
> > >  -d::
> > >  --deleted::
> > > -       Show deleted files in the output
> > > +       Show files with an unstaged deletion
> > >
> >
> > This is a nice fix: make it clear to the user that only files in the
> > working tree are deleted, not in the index.
> >
> > >  -m::
> > >  --modified::
> > > -       Show modified files in the output
> > > +       Show files with an unstaged modification (note that an unstag=
ed
> > > +       deletion also counts as an unstaged modification)
> > >
> >
> > Good to mention that deleted files are also modified, otherwise no one
> > looking at the documentation would know that.
> >
> > >  -o::
> > >  --others::
> [...]
>
> Thanks for taking a look!
