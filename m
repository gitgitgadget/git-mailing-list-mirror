Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2543C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 20:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88879206C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 20:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTgSV1fX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLUUp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 15:45:57 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40884 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLUUp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 15:45:57 -0500
Received: by mail-ua1-f68.google.com with SMTP id v18so4459628uaq.7
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 12:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEBeB2vMf5J41khY1TOa38H40EJVe4Mz9Si/U/Bmsug=;
        b=TTgSV1fXgKbYwnKch31ElrLokYSd+DBYhKy1NeQ8Ti+ZyaHABPD3BPg4kk2o3peVsu
         6QugqfdILXnc6a2DTeFPxYeHqbBbSf/0ITYBsM0vFultpoHE5YiOMD/yusCP95NQI5ai
         TRoP4obsbuohO4NS0M3Il5yWHsWZapcBdw4fQJAyVnqXWC9xpRsW8RSNhfiHwgDJLUHB
         di0H6eW9Kcl6HXQmuH9qGyny8ewjbhK0ZI0NiAKiFowooKNWI292lCEC/rwm4GpWc7Uo
         N5OXL9qI/xcQzD87yrl1AAuESX2ELlSdCPadtmKOQ0O2bMCWEiA+rOj9wKDLbOOvrNvv
         jUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEBeB2vMf5J41khY1TOa38H40EJVe4Mz9Si/U/Bmsug=;
        b=QYebp2GgYHarG7SHyBJyQBuLYaqPIgawO8f2dr7CfqNQVxXjjOC00ZmEr/ex6hzl3j
         FpgPWhEe18vSlBU790sacWvNw0CffGGu96fihxPiphZt5qJJoYdTNs15cquRSm09xrfe
         dfwjt56CkX9hfKKWPUbXlMxaD5zJB7uYF+Ol/NRsRoqTRtjAdkrLXKAInaXVAqH46mi4
         cJxDGVYQdv/oMq8HrfV/qhSnxw034EKJ7HC3EyMjXXuotjeQ12OcgysVwmCFc4Vu5GLK
         /b1pzu+vn8n5i9QnJPe7ThOkiT+jCx7K61YxalahvP35IXEd/j/+H1iEhqNgm2fjnCVP
         PvwQ==
X-Gm-Message-State: APjAAAUv6K6QZwpCXvZsDPOETRqf/NSp2ZBBdnuw9fXkJwreaYL8lNSg
        MA5/ivoBlr+dTi0XtXnO456icHSbsOkLrUF7k9k=
X-Google-Smtp-Source: APXvYqzc0MkPJIlwHKtSIPbtaJV8IL2eSbzUxQZhumY4JAcVnZTxDkDOE2BLOxJI3xf9wJkXBkr/Cw/bqYGgVUQuT3w=
X-Received: by 2002:ab0:5b0f:: with SMTP id u15mr13491015uae.43.1576961155909;
 Sat, 21 Dec 2019 12:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20191221164057.24616-1-congdanhqx@gmail.com>
In-Reply-To: <20191221164057.24616-1-congdanhqx@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 21 Dec 2019 12:45:43 -0800
Message-ID: <CAPUEsphavRpYeJGLY73rzy18VFvTUfhsb=y6pC53e8b9aEbfRw@mail.gmail.com>
Subject: Re: [PATCH] test: switch to POSIX compliance symlink check
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 21, 2019 at 8:50 AM Doan Tran Cong Danh
<congdanhqx@gmail.com> wrote:
>
> POSIX doesn't specify `-L' flag for test(1), POSIX specify `-h' for
> checking symlink instead.

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html

seems to indicate both are valid and equivalent

> While most shells and test(1) implementation provides both `-L' and
> `-h' for checking symlink,
> OpenBSD and NetBSD says we shouldn't rely on its existence. [1]

and macOS (from FreeBSD[1]) says the exact opposite :

     -h file     True if file exists and is a symbolic link.  This operator
                   is retained for compatibility with previous versions of
                   this program.  Do not rely on its existence; use -L
                   instead.

agree it would be a good idea to use only one for consistency though,
but it might be in that case a good idea to add it as a
"recommendation" by adding this rule in t/check-non-portable-shell.pl
or something like that IMHO

Carlo

[1] https://www.freebsd.org/cgi/man.cgi?test
