Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF612C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5246117A
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhGQVZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 17:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhGQVZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 17:25:47 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F86C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 14:22:50 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e13so11824348ilc.1
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CpShEYYmQpVpPzr3Q+zu/ppOFgNJxX3Oi80m39TuLFQ=;
        b=RJIii3MTVuP97LmDixwx2hD6xlCaGaIzEqrMAkWrJYM8a4i8EnAjySsrYrqv+ESqtS
         61YUpPnYQl0/wgIPlf/eZWmh2Mi2Nn+XM0fFIFMq7/rivh7NjmJ0JsQqibQvvUByxOb+
         y7616bwVyYXzAfmZs9+YjgE1Yp5FNu1+8ktQvFVKGI5mOsvD0zc7jOPJOMiF36doFi9k
         Qr+2Dy4W3CmZH0polmMlIZCQmJpmLPEl5dhZ1smmpzWx8eMUvDItw6SziknMZyjjl6QJ
         O/jUpSaeeHBIyCCJNEkLsrpPGfUBQDJxhCXHEuByHk2AP4Pf6CScZ1BuBhI6nof7pilS
         3lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CpShEYYmQpVpPzr3Q+zu/ppOFgNJxX3Oi80m39TuLFQ=;
        b=XKlMkX2K8H66DM+XzMHt6bOvrD7Q9s7i/diMl4mKotsJB4znUVB6eCqQTlmzadi4Yi
         adh+PIj/WFNWXCGA3hxzEu5ZP0li2f0O68y17xN8Vwi7rJX4J3sqlQx8QB5jOVSGpGtf
         p3nh0GkkaX1P+PXXZ9xTWC/La4E6H6m3c0QNGfZ5HZdiA/YwfMwKYeEX7MUMcSi8Znfz
         P/N4+HLvgzBbRtGRSi9ZHkHDrPaEtFWvqyy0rEvOJx2BXpPd/SZ1E6t6OEhnbDcMEFKv
         ioTQXIUHsLkJLabSkgBWQqbUDzjaaevtzWd3ak+EYRmnkdThNBFiG0+If4uq69+kOwYW
         hTxA==
X-Gm-Message-State: AOAM532fUc9c2qUiBQkA/p/6PquZZzkU/kKxq0wBVC9PjIT6keAsI3p5
        Py4mBTFqzHt73FTAQxe1pSwpZZykpiTBc+whzno=
X-Google-Smtp-Source: ABdhPJzj5f0k7aVnRFoiqQU15qxFhJ2VWNpbzYSP0Z5nbXd8oha4reLqd2n5lCJ3379PuvNW0jImpueQ6wsXdaF/yz8=
X-Received: by 2002:a92:dc8a:: with SMTP id c10mr1491334iln.48.1626556970369;
 Sat, 17 Jul 2021 14:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
 <YPHgUuxqmKFkbEku@camp.crustytoothpaste.net>
In-Reply-To: <YPHgUuxqmKFkbEku@camp.crustytoothpaste.net>
From:   Rostislav Krasny <rosti.bsd@gmail.com>
Date:   Sun, 18 Jul 2021 00:22:38 +0300
Message-ID: <CANt7McHrYhSe3JsS8UKX8NgsUajwxQY4h9KTtXkEXdd0Be_+yw@mail.gmail.com>
Subject: Re: Incorrect and inconsistent End-Of-Line characters in .gitmodules
 after "git submodule set-branch --branch <branch_name>"
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rostislav Krasny <rosti.bsd@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 10:39 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-07-15 at 21:55:07, Rostislav Krasny wrote:
> > Hello,
> >
> > Originally this bug was reported in the Git for Windows project and
> > contains two screenshots:
> > https://github.com/git-for-windows/git/issues/3321
> > Johannes Schindelin (dscho) is convinced that this is not a
> > Windows-specific issue. Following is a brief description of this bug
> > as I've faced it:
> >
> > After running the "git submodule set-branch --branch master -- ms1"
> > I've noticed that the .gitmodules file is encoded with both DOS and
> > UNIX End-of-Line characters simultaneously: all original lines use DOS
> > EOL characters but the added "branch = master" line uses UNIX EOL.
>
> What behavior are you expecting to see here?  Are you expecting Git to
> write carriage returns when the file already uses carriage returns?
> What about when the file already contains mixed endings?

I expect it to be consistent, like the vi editor in the Git for
Windows distribution.

If the vi editor is used to create a new file or a file in the UNIX
EOL format it continues to use this format.
If the vi editor is used to edit an already existing file with the DOS
EOL format it continues to use that format.
Now if the "core.autocrlf" option is enabled (and in Git for Windows
it's enabled by default) all local copies of textual files are always
converted into the DOS format of EOL.

For example:

$ vi .gitignore
$ git add .gitignore
warning: LF will be replaced by CRLF in .gitignore.
The file will have its original line endings in your working directory

> Are you committing CRLF line endings into the repository, or are they
> just created by core.autocrlf=true (or some .gitattributes setting)?

In Git for Windows "core.autocrlf=true" is the default configuration.

> Does this cause a functional problem with Git (or maybe another tool),
> or is it just aesthetically displeasing?

I don't know, at least in the vi editor it looks broken because of all
those '^M' symbols.

I would like to take this opportunity to ask: why cloning a repository
that contains submodules sets this repository branch to its default
(master, main, whatever) but all submodules are set into a detached
HEAD mode instead of their default branches? This is actually the
reason I started to check what happens with the .gitmodules file. What
is the point in such an inconsistent behavior? There are a lot of
questions about that in Google and it seems most of the users expect
different behavior.
