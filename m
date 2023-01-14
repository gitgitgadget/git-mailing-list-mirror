Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A8C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 19:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjANTmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 14:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjANTmT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 14:42:19 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964E9027
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 11:42:17 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bf43so37582216lfb.6
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTob0NK6kztBxMaPAn8lOYoiAinnhPGQm/LuGF0IENQ=;
        b=nLjI6YlhRTHxwJmYpER+eWRo0LuwkaUllcparpPD+MR2Rp3GPpS5vwirJjU6e5HXZT
         bUCF551WUq/WhfcB1tTu9+xtXcNSa1bzYml8WgFv86CV2sJu/TbR5ydrDvcb13+l8b1W
         9ewv62OwiMlU8RDfKMMc8mQ6Cc6K+yW3wsSwKKKGKExSRYsin96bEEDDFABlEyCF9+ZX
         0JS7WSOw2yZRTnkv8cJZWujnCTACXbGEcqNFb9TgtrXOyhJ7UwS7YN7OlhypkNtFFhYF
         V4hTurKzORJm0jYpwBah+w2ZrqO+hfhYJrd0rjavAbpeHgz7Fvj1Q/IxK4qu+GTLW/do
         nXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTob0NK6kztBxMaPAn8lOYoiAinnhPGQm/LuGF0IENQ=;
        b=PxPQaiIl0CVbs4AF0GvkE5068ZkZBUYglNWcSAWO1yx/DENP53fgda0UkxD3PcoH4f
         lFOmnoaT4mSsOA6zAy5M/XEssuddXEzsta5P+Da8hLo6urUtJ1e67SMEVcd5sb4vd2NA
         5KUEZsyODVpOkHSdMuvWlORcqMiixfINIcz51ADyE7zXLYjVFDE7h/EtruHWxU6NF8Xs
         Rda3xIlGLVS3V+FN8k7S8WLtNn1Pq9g+9On04TSGY8edbOHlzYimjeB2ZC9K5cBNhFcq
         PtWg2L343c6E+739TJhNWN71bT1STEhpuZyOsCWtSBjmHi1fYYYkdQePtbSkSihvi1ZW
         21Qw==
X-Gm-Message-State: AFqh2kolTteGGtLaa0zaiQvqqIWncMOHhEiipP9MsLyzD3HAnXKVnHVX
        Ll1xqxtCJ7TCUyq/obMCgpgyqDR7mljqfPZmzXuGAz0g
X-Google-Smtp-Source: AMrXdXvvxugnwrgJLtespI6F3SbkcKbSyHgxsJ6khRQ6Y5XQnRVgUUAIvP8yEAO0rBQ78mqWel/eG+qhR/52a2vlL28=
X-Received: by 2002:a05:6512:acc:b0:4cb:24a0:27ce with SMTP id
 n12-20020a0565120acc00b004cb24a027cemr5993872lfu.238.1673725335916; Sat, 14
 Jan 2023 11:42:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
 <1d1330243109d499d1c07f6518265b2e163406ef.1673584914.git.gitgitgadget@gmail.com>
 <CAOLTT8Qx6chcA7MEY9Hzeq9U5pfR-fC8aOxhZMvYvi8ZtQeVdA@mail.gmail.com>
In-Reply-To: <CAOLTT8Qx6chcA7MEY9Hzeq9U5pfR-fC8aOxhZMvYvi8ZtQeVdA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 14 Jan 2023 11:42:03 -0800
Message-ID: <CABPp-BFuZK2yap_VXWPo8qHvJ+E9V7v2UAZ9tAaQcX8zc-daDA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ls-files: clarify descriptions of file selection options
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 12:21 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=E5=
=B9=B41=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=94 12:41=E5=86=99=E9=81=93=EF=BC=
=9A
[...]
> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
> > index cb071583f8b..f89ab1bfc98 100644
> > --- a/Documentation/git-ls-files.txt
> > +++ b/Documentation/git-ls-files.txt
> > @@ -29,21 +29,26 @@ This merges the file listing in the index with the =
actual working
> >  directory list, and shows different combinations of the two.
> >
> >  One or more of the options below may be used to determine the files
> > -shown:
> > +shown, and each file may be printed multiple times if there are
> > +multiple entries in the index or multiple statuses are applicable for
> > +the relevant file selection options.
> >
>
> `--deduplicate` option can be used to remove deduped output.

Yes, I'm aware.

If you're suggesting adding this text at this point in the document,
it occurred to me already, but I chose not to put it here.  The reason
is that this is a brief synopsis.  The "relevant file selection
options" of this brief synopsis could also be expanded to mention what
they are or what the default selection is or whatever.  But folks can
read on to learn that `deduplicate` can be used to remove duplicate
options.  Likewise, anyone who reads the text about "relevant file
selections" and wants to learn more is inclined to read on to the
other options to find out.

In contrast, no one will be motivated to read on to find out that
files can be printed multiple times if we don't mention it right here.
And they are likely to get confused when it happens, thinking it is a
bug (in fact, I can point out emails from the archives where that has
happened).  Without mentioning the possibility of multiple files at
this point, we have a discoverability problem.

There is no similar discoverability and negative-surprise problem I
can think of by omitting other details, so there is no need to expand
this brief synopsis any further.

The one place we could potentially change thing that might help, is
moving the text about -c being the default from under the -c option
and putting it here.  That's a toss-up to me, but for now I elected to
keep it where it is.

> >  OPTIONS
> >  -------
> >  -c::
> >  --cached::
> > -       Show cached files in the output (default)
> > +       Show all files cached in Git's index, i.e. all tracked files.
> > +       (This is the default if no -c/-s/-d/-o/-u/-k/-m/--resolve-undo
> > +       options are specified.)
> >
> >  -d::
> >  --deleted::
> > -       Show deleted files in the output
> > +       Show files with an unstaged deletion
> >
>
> This is a nice fix: make it clear to the user that only files in the
> working tree are deleted, not in the index.
>
> >  -m::
> >  --modified::
> > -       Show modified files in the output
> > +       Show files with an unstaged modification (note that an unstaged
> > +       deletion also counts as an unstaged modification)
> >
>
> Good to mention that deleted files are also modified, otherwise no one
> looking at the documentation would know that.
>
> >  -o::
> >  --others::
[...]

Thanks for taking a look!
