Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FB4C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE54C64FBA
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhBESVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhBESUb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 13:20:31 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C95C06174A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 12:02:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y18so10222436edw.13
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 12:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zbm145pbcjQEaJroVTYQMN7JmWbrM59tjrU0YeViDjM=;
        b=nLBCw1VHSB3arX2Kf2hGALd+UbWOXXV7J3expc6Bqpa5GY5ApoEhC1QfPcc80Za6k6
         EQgNFcoHKn0fwLIPjCcAT00CYIhWce8Vfr1eBAJbOkiTfVBkxuSznWZs0YRD2EU8GwHm
         09anEzWXs6vNF6XrOG3vCl8eF2HF/wJix4SGijdTblPKx9Smhbk9H861GMb1uT/M2Q5A
         J+YQwFG3BXkidXuHZnVOeTi0zHSQoGv2sckKXi4hgRW443o+/iwq2dPxTXH4Mp7hPqdB
         ACtIAR5+1eMfNBf+eWP6/BYzn12NuUnhtrn/7Lwje6vXTC3P/6Gr87sV6pcTDNtdWG9S
         VnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zbm145pbcjQEaJroVTYQMN7JmWbrM59tjrU0YeViDjM=;
        b=hQRUCd2kZnQNDV2Idxnu0XtfSwOb5qUQy8elZ4Bzp2Z/ftgj8jNJUyQ255IQ94AREp
         e7YJUKRkmvZMYdLxbNuoWZnlAH8MGMdh7VMVQlJpK7TvGme5tw7+2LXH/exrC/bow3gT
         M1E/WGeAtdlnUMLUIHvptY+wCx4axofE5PEZBF5DljerEmAbua3zCTm9HAE9y067RiK5
         n0alWoyxSH1eLMEki5p7ioaTQQZgxlu4y0xw+GNaN8QFc26Y3ZL1EAjDDpFaVaUiVBjn
         IGWpjDjzhvB4tzPx8aPuvrjNBTEUf8Q1khDk5OjDa7dj/PkiVX/ZppHw1Kq6yxd7lUuu
         3iWA==
X-Gm-Message-State: AOAM531cSzUeAJzQHV+w0LO9d4zR8xtheHP8viK2o8Tz86RAamXk35cr
        ZOi2VBwbEXoit4aiIMtGm+uUPMWoNj74st9N63gq0S23qoU=
X-Google-Smtp-Source: ABdhPJxZuwPgkx+nvQvaZWvrySgqDmmNAWVdXNPNjDhKkVYjBbn4CUhRQ/yjaROhMI/O7RvCjdyUtNUt2A2kSYn3mi8=
X-Received: by 2002:a50:bf4a:: with SMTP id g10mr5041976edk.201.1612555334073;
 Fri, 05 Feb 2021 12:02:14 -0800 (PST)
MIME-Version: 1.0
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
 <YB148VZJqKIPC8P2@coredump.intra.peff.net>
In-Reply-To: <YB148VZJqKIPC8P2@coredump.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 5 Feb 2021 12:02:03 -0800
Message-ID: <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
Subject: Re: I've noticed the command `git --git-dir=<path> shortlog`
To:     Jeff King <peff@peff.net>
Cc:     SURA <surak8806@gmail.com>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 5, 2021 at 9:28 AM Jeff King <peff@peff.net> wrote:
>
> It's possible somebody is relying on this in order to read ".mailmap" in
> a bare repository, but it seems rather unlikely. And the documentation
> says "If the file .mailmap exists at the toplevel of the repository",
> which I think pretty clearly means the top of the working tree.

There was a time, before the change was made to have bare repositories
read the HEAD:.mailmap blob if one exists, when Bitbucket Server
relied on this in order to have mailmapping. We'd unpack the
`HEAD:.mailmap` blob to `.mailmap` in the bare repository whenever it
changed. Now that it's automatically read out of the repository,
though, that manual unpacking code was removed.

(Not disagreeing with your "seems rather unlikely", by the way. With
the blob reading behavior I think it's probably true.)

Bryan
