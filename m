Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7190B1FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 09:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbdBIJ6R (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 04:58:17 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34774 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdBIJ6P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 04:58:15 -0500
Received: by mail-oi0-f43.google.com with SMTP id s203so97877579oie.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 01:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4FUOxjBi7ceWEmYnxaZ6gx0H3P42/q7m5uuCbSgHm30=;
        b=C2w+edaovsXcKJa1VvkVPUBJuNipc7SRrQOph6ASqEJUTr53XheOar7DCtqRqDZUEF
         RxzlLqE/aBEqGR4qmuzdcniBTedqlbmCZDvrHVRmhCbEQo5NXfm9xrH3IBBA5Or9oly8
         hJ4tTU9O8Gl4BYLbkyS/3SGi6HKOiyLTIekzotkuslLbQJ0iJvCI3kS9TvwiHH/H+dX4
         0+ssIltTsNzUt+O7WP5eEetPbGxMaXU9MgxrnvdmwMp0rDrYiTgpib71hSIrjgevx/UD
         kF8Pc6E0Rj9f2hhxj78ehM8QTYX34XSflFjVxExXmyXw5ipeQ1bjN0n/2/QE9RnCwFUF
         g8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4FUOxjBi7ceWEmYnxaZ6gx0H3P42/q7m5uuCbSgHm30=;
        b=f6mrWqephv0qymuF2hUZmUAkF6KtSKTNS97F9zdJzjJigtw3yYsmpiQVIYkGyryDqz
         2jk7bu0AhSEMUAAa4WazjuOe5LgnZW8y+/dmENTnqIJldOvkcw4Tc/MsBsC6E7teWADl
         SagTv+0fowIkeHMLVkVrgKNgQc4M7sM4VcbUDIu89lM2x0KKrrKFvQBL55JQocNLC83N
         ysOohMa3wj8xtTn81Yy4W0TaXtuqzL6r5jV79Uv5sONWbRpbroMFuZ2tceYXo2nLCWN6
         ii94Zu0HuTeSiXiJjZnx3hnCsYr4M4OIjGnj2jepkKYyW4FOABqk0+0RNKDY0VguRazK
         klQg==
X-Gm-Message-State: AMke39mAdakENSxbjc1CpNHyLdGDz4NY2FXdua9t5ouH5XfsclG8lOfDGSiN4ID/aPxlJ5DbcLpA+4BHP4kIhg==
X-Received: by 10.202.79.138 with SMTP id d132mr960339oib.169.1486633731290;
 Thu, 09 Feb 2017 01:48:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 9 Feb 2017 01:48:20 -0800 (PST)
In-Reply-To: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 9 Feb 2017 16:48:20 +0700
Message-ID: <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a subdirectory
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 7:17 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> In addition to making git_path() aware of certain file names that need
> to be handled differently e.g. when running in worktrees, the commit
> 557bd833bb (git_path(): be aware of file relocation in $GIT_DIR,
> 2014-11-30) also snuck in a new option for `git rev-parse`:
> `--git-path`.
>
> On the face of it, there is no obvious bug in that commit's diff: it
> faithfully calls git_path() on the argument and prints it out, i.e. `git
> rev-parse --git-path <filename>` has the same precise behavior as
> calling `git_path("<filename>")` in C.
>
> The problem lies deeper, much deeper. In hindsight (which is always
> unfair), implementing the .git/ directory discovery in
> `setup_git_directory()` by changing the working directory may have
> allowed us to avoid passing around a struct that contains information
> about the current repository, but it bought us many, many problems.

Relevant thread in the past [1] which fixes both --git-path and
--git-common-dir. I think the author dropped it somehow (or forgot
about it, I know I did). Sorry can't comment on that thread, or this
patch, yet.

[1] http://public-inbox.org/git/1464261556-89722-1-git-send-email-rappazzo@gmail.com/
-- 
Duy
