Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD797C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80060206E0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+OU8rTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfK0RPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:15:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45048 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK0RPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 12:15:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id c19so19745241otr.11
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 09:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPJaiEpb8ZY65+0SAwjWkQFmCy8YkzhLeGXIN2TnbU4=;
        b=B+OU8rTjX90YtjPgyFRhDQbquXkFhmVIg7u0UJmKNUsde4Wds+GfJlzFppKI9Kshwx
         1WvYlmbZ1GetotPZO+WvAvBuQqvVLzFUwQb7vojpuQJwuxFSQwB9rlNjePvagPWOd2tJ
         Gkf83WJZQTas/wu5x8T2qF1YVYhxvvao6xtVJGgDxJKAW4BjY/zYfe+VmZ1qJ1ctxfzS
         pjdnRDzZbIKDuCnyqc2032d8IdYCqy5VL65Pwn6oXOYjS+rRY5O7zBWdCrvgcEu7Xmpl
         arXoCW5Jf+VXG6WRarQ9bv28+UV37OUOkResS6sL7ocOqfcN4H7qwzOw9xRd/PtafeUH
         6FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPJaiEpb8ZY65+0SAwjWkQFmCy8YkzhLeGXIN2TnbU4=;
        b=fpzKeZm23YfG6VBYKWwzNImDr3dR4rpfqSBKRT3ot2HG/3wwwNxvPCqAZ+Ms+Cq//H
         dqdIXFCI4bgR8pgHJRVHEMn1PuE34mVoFalcSkXkbn9rMMRXyN/kV5Rlg0kCnwTocv1G
         kw3f/1muy+yAC9Mcxp4NZBHFNiRloosaJRsKgwfTsqMfiFlooqVwaVQE5sdB00RM263H
         ZFSG8WBK/uAZb1u7GS5/mz/K16AwuGqMcwv20f2SNGLaXdN0njjjRB2G+EYEHKwR4N5y
         0y0SlaQVxAJ8341O5fpXUPftaU+iPx1jqkvHsbjovnZ26V+WhtjdVda4w6DNPoQhaLXH
         oR3Q==
X-Gm-Message-State: APjAAAWbBzrv5OtsyLJnojEmJyY8lGmp6tc7nhpjztNnU+yvf5le+rd7
        v1UPQwuTVMXLQTXr9OWJ8bPufuDnhv1Tnmug2fOIjg==
X-Google-Smtp-Source: APXvYqx0sjzgdhelvU7sFfqShY8YJFpW3LKFb007iShWJ9zPvL8cZuoiDuMgJyJeAW3eZZCJDzaFJ4Wiq7TQj1jT4PQ=
X-Received: by 2002:a05:6830:22e2:: with SMTP id t2mr4546741otc.129.1574874935867;
 Wed, 27 Nov 2019 09:15:35 -0800 (PST)
MIME-Version: 1.0
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
 <cover.1574820308.git.liu.denton@gmail.com>
In-Reply-To: <cover.1574820308.git.liu.denton@gmail.com>
From:   Christian Biesinger <cbiesinger@google.com>
Date:   Wed, 27 Nov 2019 11:14:59 -0600
Message-ID: <CAPTJ0XH62P_-R4XCy5Jv-egQ06H8eJZ4YhLdRGAt721WVD5bXQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] rebase: fix breakage with `format.useAutoBase`
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 8:09 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> Thanks for reporting the breakage, Christian.
>
> Apparently, this use case has been broken for a long time... Since
> bb52995f3e (format-patch: introduce format.useAutoBase configuration,
> 2016-04-26). I'm surprised it's only been reported now.

Thanks for fixing! Maybe few people use this option as it's not
documented in the format-patch manpage? (A separate thing to fix, I
guess)

Christian

> This patchset fixes the breakage by teaching
> `git format-patch --no-base` and making rebase use it.
>
> Denton Liu (5):
>   t3400: demonstrate failure with format.useAutoBase
>   format-patch: fix indentation
>   t4014: use `test_config`
>   format-patch: teach --no-base
>   rebase: fix `format.useAutoBase` breakage
>
>  Documentation/git-format-patch.txt |  5 +++--
>  builtin/log.c                      | 26 ++++++++++++++++++++++----
>  builtin/rebase.c                   |  3 ++-
>  t/t3400-rebase.sh                  |  6 ++++++
>  t/t4014-format-patch.sh            | 14 +++++++++-----
>  5 files changed, 42 insertions(+), 12 deletions(-)
>
> --
> 2.24.0.504.g3cd56eb17d
>
