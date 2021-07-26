Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F6CC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 11:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA9760241
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 11:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhGZKbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 06:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhGZKbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 06:31:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D696C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 04:12:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u20so10514048ljo.0
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnYxz1aKhr3xtnBU/gr1M5/xD2hm1RyDXNVHlfYHPQQ=;
        b=qOb8XdU4aMX++bClopo4dIxEPh9FlvPenuaM2zjJT7Z3MXs3331vUfiaMcYh8xZicu
         agHO1hBhB0lGMjNDAEF1B2dbcKKOGySUYvzQEwZANbT6KbEf6eQE5cWa0w5YTa/J7P58
         Xdq0J5wB9utF9w/nY/jSo3KMB7Yu5fYsCNnMRJoul1IbLdliMdj+DsqgDDyot9pW8PsE
         ZsTTzYwwIdqUKYHal/DHWyAGlTSwsZ4J7DdJC3WDV8furYt0eUTEi/o52RmNaiLFYC/R
         deOsR/GMtZd0kOAgF0NH73LzeV4UIC3NazzKA2ybjxmCz84QUD8uyNySY9iMws/dbAh7
         O94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnYxz1aKhr3xtnBU/gr1M5/xD2hm1RyDXNVHlfYHPQQ=;
        b=DrVSLEIN5j63gbhIgbjuhbhidJsMqL0ih8i9sUUfwhOUJX/cF8iTxXESToNij7dt5J
         vltftGudLt9bEHAgivVBHlGLdOsI0mdHfWIeh3LNtcEZCGsuCiTEOKCODScLpFsmUMT5
         wKa4++68krBuWogfWwToiQWeTqI+Lf9MXtu4dEux26uvqHIW+KhJCVOU1tO4P7ICBO7m
         VOVVWyl86AWXpn4LtFto/qw8nVCTiLuZL2ztLv4AecRTA1k6ggcdSsi1hE0sffWUe+f4
         rVXfBOusmsO1H+7u9EfEfBNDpuhCu68y6o6dQ5glNRVhTFd/rLaBtaSEzV3yN71W3nyO
         6k8w==
X-Gm-Message-State: AOAM533fxAYBwzcRYs2gvm7Aj9IdtbSN0fQxxgE8vpCXKtc9mnP1VkgK
        U2EzI7bKteUX+cj4sBiMqEAoE+5zZ5f90ibdNs8=
X-Google-Smtp-Source: ABdhPJz+zAU+RN0mkHP3x5cN/ObRjZeED3W7NSCjTZiIx1jeCA9ksfV1U+W8WTlWfh1KXFMhllITEKHKDOlbcpG70Ck=
X-Received: by 2002:a05:651c:246:: with SMTP id x6mr11593799ljn.452.1627297920927;
 Mon, 26 Jul 2021 04:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de> <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de> <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
 <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de> <CAPx1GvdM7CzsbT1SWW9+OPcG9FL7WXQ7YD6aM7P0krujp_OrkQ@mail.gmail.com>
 <f454bf5b-c5ff-4140-02a8-b02dcd35c6b9@mfriebe.de>
In-Reply-To: <f454bf5b-c5ff-4140-02a8-b02dcd35c6b9@mfriebe.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 26 Jul 2021 04:11:49 -0700
Message-ID: <CAPx1GvfH0Rqz238GUByBGkrRK8UeBpF3-1XvW_M66_w6DVgYFA@mail.gmail.com>
Subject: Re: Files modified, even after: git reset --hard
To:     Martin <git@mfriebe.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't have Windows and hence cannot test your exact
situation (which I understand to be:

    `core.autocrlf` set to `true`

and of course "using Windows"). I will repeat that I think
setting `core.autocrlf` to `true` is a bad idea, though.

In the meantime:

On Mon, Jul 26, 2021 at 3:31 AM Martin <git@mfriebe.de> wrote:
> origin  git://sourceware.org/git/binutils-gdb.git (fetch)

I cloned this repository so as to be able to obtain its commits.

> fsck had some dangling commits, I did a "git gc --aggressive".

(Dangling commits are irrelevant and unimportant: there's no need
to do this.)

> Switching to a far away commit
> git switch -f --detach master
> git rev-list master | wc -l
> 93917

The actual hash ID of the commit would be potentially useful here
(whether it's really useful would depend on whether I have or can
obtain that commit).

I do see that commit 16788ca9fd7352b2b20f4b11111283a8cd4212e2
removed various `Makefile.dos` files, including one mentioned
below (`bfd/Makefile.dos`).  That's the only file name I looked at
specifically for this kind of operation initially (I checked another
just now and it too went away in that commit).

> ... Then switching to  (this is on master branch)
> git switch -f --detach a362ee23634

The hash ID is all that matters: branch names are irrelevant here.

This commit contains a `bfd/Makefile.dos`.  The actual line
endings in this file are LF-only.

> git status --porcelain=v2
> 1 .M N... 100644 100644 100644 9e677a52ae690808165993a0f3f17ac49e3969df
> 9e677a52ae690808165993a0f3f17ac49e3969df bfd/Makefile.dos

This is also useful:

 * The `.M` means that the committed copy of the file matches
   the index copy, while the index copy does not match the working
   tree copy (presumably because the working tree copy has had
   its line endings changed to CRLF).
 * The `N...` means that this is not a submodule.
 * The three `100644`s mean that the file is mode 100644 in
   the commit, the index, and the working tree.
 * The two hash IDs are the blob object hash IDs for the committed
   and index copies of the file data; these match.
 * Last, we have the file's name in the index.

The same pattern seems to repeat for the remaining files.

These "Makefile.dos" files seem to be hardly ever touched,
in any commit, so these four files are likely not to be swapped
out by `git checkout` or `git switch` operations.

> My question is are there any plumbing commands, that could allow me to
> look further at it.

The simplest is to get the raw hash ID of any existing Git-ized object,
and use `git cat-file -p <hash>` on that object.  Since `git cat-file` has
no idea whether the data are to be treated as text or binary (in this
case where there is no path name and no `--textconv` flag),it just
writes out the raw text.  You must, however, make sure that the output
from this command is not mangled by some other tool (e.g., some
Windows editor "helpfully" changing LF-only to CRLF).

Note that `git ls-tree`, with the `-r` (recursive) option, allows you
to inspect the raw hash IDs of committed files by their path names.

Chris
