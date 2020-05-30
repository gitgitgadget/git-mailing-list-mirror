Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD701C433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 19:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A189020722
	for <git@archiver.kernel.org>; Sat, 30 May 2020 19:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5/Lnnu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgE3T2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 15:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE3T23 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 15:28:29 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FFCC03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 12:28:29 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y5so2861592iob.12
        for <git@vger.kernel.org>; Sat, 30 May 2020 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fG+Ch9pypZOMBVey6UZOOUgD2mp/z04gbkn3HNpLmL8=;
        b=r5/Lnnu9g3aIKbeDnPbIl2r2EXHxXhousE6l58tyGIy43yiRNdPOr745Zjv4L3S8N0
         Rxu2z4QAeeLutlagxbD2SmI1G8oXkRqzljsyORMsmEbSxfCv6DHUb149DdvyYdYppSIk
         60MokbGm7TTYtiEJA8IMMKl68OAtqvszbr1moO42+uC4f0EUja8aE+572vW0dZaplHKZ
         xOjs6qj/9X7VI3PSGIalDoldJskHgRx1/GGPkh93Olx6uNH5j7zLvVngaA0dHYd7pPfM
         ZgP/wzoqZJ5D5NspwAkZaQ8Z5BK/fWoLS1i5eMF12+nt8MCVYqTXjerX1eSKezr80jqg
         dYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fG+Ch9pypZOMBVey6UZOOUgD2mp/z04gbkn3HNpLmL8=;
        b=uIblLVgoEABLzD1NYSeo8uL5p1EuICw+/wtBpGF7fu7DRKmGRxCrO8F5necOma3rnX
         bq1X07ErTSnQ6jY9Whbv/8UtlymnoyT9hEsoUvZFD3suD8OnP67vE18CD4Y3ZAe64DH8
         5akE7njm6iLwBunLrfUAgY2fgdQldZAyTGDeW1gVKZj6TKZWYiK1lXt/Rcyov/IBZ+28
         /RqY5Tdjj8btMWnqI3aczAfLZldBXnyRKRraRpatqiaM0Wp791TWhSiu/FVFhKGe0LCl
         2txBrP4JnpmK0N0NNRMaV8p6JNMAaXjJQauXt9J3ueJsUFdKQPA8DYjvPkELzCK2bG3g
         a07w==
X-Gm-Message-State: AOAM533Q3WgYS9whheM9Th9AzPcEG5+1oJ/IoMu+yOVY5PGkJM0FlGvZ
        lEtTXE5bqg9vtYsnSbk76TFjmyq5hfGL2/WskLI=
X-Google-Smtp-Source: ABdhPJwxHoYmJ0RnGQ5cDAiQpDTPgiLxb52n7idED6VR1nj6rsN0qzSNOhCRDeCNz9mYHc9Mk4EFExfQKb2w6SSHGoE=
X-Received: by 2002:a02:cd2b:: with SMTP id h11mr7375578jaq.47.1590866907366;
 Sat, 30 May 2020 12:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHgM7c4PQQvTrfn4fqKy8evQ2ydbO7ggBn4hPUTF5e2G+ApMvQ@mail.gmail.com>
 <76f5b3ff-21a7-bff7-4785-b56c34eda644@gmail.com> <20200530180259.yv6vfsv3ysk7yg5c@yadavpratyush.com>
In-Reply-To: <20200530180259.yv6vfsv3ysk7yg5c@yadavpratyush.com>
From:   Peter Jensen <report.jensen@gmail.com>
Date:   Sat, 30 May 2020 20:28:16 +0100
Message-ID: <CAHgM7c4GkPafhtTCJ4uk0wUq3CwVpg1XSZmB9qaUtYpdz1pKyQ@mail.gmail.com>
Subject: Re: Git gui freeze on ubuntu 18.04
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Peter Jensen <report.jensen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush,

>Any hints more specific than "something
> crashes" would be much more helpful in figuring out what's going wrong.
The program freeze before the main window appears.
As far as I can see from the strace log "tcl" is waiting for something
to happen.
I think "tcl" is waiting for the output from a git command.

If the strace log does not give you any useful information, what do you suggest
I do to track the bug down? Has git-gui got any logging build in that I can
activate via an option e.g "-debug" or by setting an environment variable?

If not can you suggest anything that would be useful?

I installed 18.04 on my laptop, and the bug also showed up here.
The machines have very little in common, except that they
both have a SSD disk.

Peter

On Sat, May 30, 2020 at 7:03 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi Peter,
>
> On 29/05/20 09:37AM, Peter Jensen wrote:
> > strace from the very beginning until crash
>
> git-gui is written in Tcl. So while strace output might give some clues,
> it is not as helpful as I'd hope. And anyway, I'm afraid I just don't
> have the bandwidth to look through it and figure out what's going on.
>
> If you could try the latest master [0], it would be nice. The build is
> pretty simple and quick. Any hints more specific than "something
> crashes" would be much more helpful in figuring out what's going wrong.
>
> [0] https://github.com/prati0100/git-gui/
>
> --
> Regards,
> Pratyush Yadav
