Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC7AC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A563160ED5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhJ3W0S convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 30 Oct 2021 18:26:18 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:38517 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhJ3W0R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:26:17 -0400
Received: by mail-ed1-f41.google.com with SMTP id r4so50286004edi.5
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=6drv69/pM7yrcbQ7IO1p79Cg3RwPJZH2L/nzdEToZh0=;
        b=mcQWeAl19rX3jsVmFunYlBjKrN/dnmHJi2sWL1aKW6hyPO7Gimk7+qgEuMec60dNs1
         B8KaPzhy7m4Q/5+bO4fKpefOhvQQ/77KN2ScjFtXhDsI8HXSs7O0h+mrsAZy3aFG66CR
         lOluNf6s+fgVbudo5ON95X/BLupceGHPAg2UIZUThqfF8HgjAwpoUWYSYCExJjYijN3f
         o9hdgjzN3o8Q4relXULs1xKugx9C01kcvoVA/nl1OQiVk9Aj3dFWq4CuWKf71T+v5IP9
         tKIdHN3IuKqnqAbQWRXDrvulwiCrQjll9uuGq0Q5OBGIvTLF88rbp3Ct8WNIVMxUFY+U
         u9sQ==
X-Gm-Message-State: AOAM531Org2vuKm+DHEJtS3EXj9+hpSTm8Led9ILeHHTdz37/bJygOTs
        QSg6lw/uicg25K3woI85jvoWDShJ6BQ2P1MHWKM=
X-Google-Smtp-Source: ABdhPJz1xSmLbbAAcEpLH+xnvpMtOgvtMfJxk8+wZGBqdO8IArlbu6GxdRxJsJUQJRUh842UnIDux7YPcD8WCzJ8yqM=
X-Received: by 2002:a17:907:6e04:: with SMTP id sd4mr24343841ejc.40.1635632625633;
 Sat, 30 Oct 2021 15:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211030213131.140429-1-alx.manpages@gmail.com>
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sat, 30 Oct 2021 15:23:34 -0700
Message-ID: <CAPc5daWURksnU02wWZzBsx+6nsw82Lgd1K+rBRnmnqA1SJ0UBQ@mail.gmail.com>
Subject: Re: [PATCH 00/22] man2: Add [[deprecated]] attribute
To:     Alejandro Colomar <alx.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: moved everybody else to bcc]

Please do not spam the git mailing list with these manual page update
patches. We may be interested in the final contents of the manual
pages, we appreciate the work done by the linux-man project, but we
already have our share of patch traffic on this list that people are
swamped with.


2021年10月30日(土) 14:32 Alejandro Colomar <alx.manpages@gmail.com>:
>
> Hello Michael,
>
> I added the C2X [[deprecated]] attribute to the prototypes of some
> system calls.  All of the cases where I added that were already
> marked as deprecated or obsolete somewhere in the manual page,
> so this is just about uniformity and visual effect rather than
> a new deprecation notice.
>
> There are cases where the syscalls have been simply removed, and
> so they are obviously not to be used any more.
>
> There are cases where some implementation (not necessarily Linux)
> is dangerous.
>
> In some other cases, the functions have been obsoleted by POSIX,
> but are still there in Linux without any deprecation notices.
> In these cases, if there's no clear replacement, or if the
> replacement is not a straight drop-in, or if the replacement adds
> more complexity, I didn't add the [[deprecated]] attribute.
>
> A list of the system calls that I skipped in this patch set:
>
> - utime(2)
>         Many filesystems have 1 second resolution, so it makes
>         sense to use it in those cases.  git(1) for example uses
>         utime(2) consistently.  Although deprecated by POSIX, it
>         is still part of POSIX; if it ever removes it, we can
>         reconsider.
>
> - setpgrp(2) (the POSIX/SysV version)
>         POSIX deprecated it (not yet removed), but the manual page
>         doesn't mention any replacement.
>
> Cheers,
>
> Alex
>
>
> ---
>
> Alejandro Colomar (22):
>   bdflush.2: SYNOPSIS: Mark as [[deprecated]]
>   create_module.2: SYNOPSIS: Mark as [[deprecated]]
>   get_kernel_syms.2: SYNOPSIS: Mark as [[deprecated]]
>   getunwind.2: SYNOPSIS: Mark as [[deprecated]]
>   iopl.2: SYNOPSIS: Mark as [[deprecated]]
>   query_module.2: SYNOPSIS: Mark as [[deprecated]]
>   remap_file_pages.2: SYNOPSIS: Mark as [[deprecated]]
>   sigprocmask.2: SYNOPSIS: Mark the legacy system call as [[deprecated]]
>   statfs.2: SYNOPSIS: Mark as [[deprecated]]
>   stime.2: SYNOPSIS: Mark as [[deprecated]]
>   ustat.2: SYNOPSIS: Mark as [[deprecated]]
>   pthread_mutex_consistent.3: Mark *_np() old function as [[deprecated]]
>   sysctl.2: SYNOPSIS: Mark as [[deprecated]]
>   vfork.2: SYNOPSIS: Mark as [[deprecated]]
>   tkill.2: SYNOPSIS: Mark tkill() as [[deprecated]]
>   sgetmask.2: SYNOPSIS: Mark as [[deprecated]]
>   getitimer.2: SYNOPSIS: Mark as [[deprecated]]
>   futimesat.2: SYNOPSIS: Mark as [[deprecated]]
>   gettimeofday.2: SYNOPSIS: Mark as [[deprecated]]
>   setpgid.2: SYNOPSIS: Mark BSD versions of getpgrp() and setpgrp() as
>     [[deprecated]]
>   sysfs.2: SYNOPSIS: Mark as [[deprecated]]
>   uselib.2: SYNOPSIS: Mark as [[deprecated]]
>
>  man2/bdflush.2                  |  4 ++--
>  man2/create_module.2            |  2 +-
>  man2/futimesat.2                |  4 ++--
>  man2/get_kernel_syms.2          |  2 +-
>  man2/getitimer.2                |  7 ++++---
>  man2/gettimeofday.2             |  8 ++++----
>  man2/getunwind.2                |  3 ++-
>  man2/iopl.2                     |  2 +-
>  man2/query_module.2             |  5 +++--
>  man2/remap_file_pages.2         |  5 +++--
>  man2/setpgid.2                  |  8 ++++----
>  man2/sgetmask.2                 |  4 ++--
>  man2/sigprocmask.2              | 12 +++++++-----
>  man2/statfs.2                   |  4 ++--
>  man2/stime.2                    |  2 +-
>  man2/sysctl.2                   |  2 +-
>  man2/sysfs.2                    |  6 +++---
>  man2/tkill.2                    |  2 +-
>  man2/uselib.2                   |  2 +-
>  man2/ustat.2                    |  2 +-
>  man2/vfork.2                    |  2 +-
>  man3/pthread_mutex_consistent.3 |  1 +
>  22 files changed, 48 insertions(+), 41 deletions(-)
>
> --
> 2.33.1
>
