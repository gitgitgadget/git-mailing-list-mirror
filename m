Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C412ECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 07:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiITHRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiITHQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 03:16:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764775C9DC
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 00:16:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j24so1386205lja.4
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CyJSY0eY/vC9AWrDXB/QdxUJzPIBt2ixk/OMcMh4Fx0=;
        b=j1GO0RYIHET03j7AvylPUGkF4XP5ZOvLpK4hXOjXPuUz4wUEJwMu8g/1xFdYvrtpWj
         nMr7rr0R/nRMReEOrJHSJdDqyFe3Cszp1vg6P9jt0JFobTzI1o+N0wgx1T2zrXLJlU4A
         I4D0WlXzGnD/pDF45y2OYImcWeHVnRqUUIWKOuBgTzCh1uJnwMfHRYJ3dO9X1NiWeWVx
         N1g38wfVTuNn+qIHbNaynpNN+udcP4fmhc8bURx6pUEC+62cFgho8W5KMFJltF99agCS
         rebt5E3w95IIyocqu7RFyzttAppCvw1clCRNu7Qj1XpOSnf6nTXsM3HaVRfUaa4EXSOB
         Ymkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CyJSY0eY/vC9AWrDXB/QdxUJzPIBt2ixk/OMcMh4Fx0=;
        b=KZaNqkcE3ZwiFG/QWd1tcYtl23/N3uCPfMHUW2t+V/RNqKGW0FXkUNsblofeLRgzkk
         45bhQZiYvVPRkN9sKWgNLgMlnElVGFvxPXL/3/dqRKObKAajtPgEDTiZJXqDY/S2veBV
         ieML/msaONIpxwMrtLK2s9q7CCfmCZel3xnDfdL9PeCN4HQKf5KVBUWNIKzrA6tlB+gQ
         GahGHtealtp0BLpMEQ1RGSNqt/0I9lsCUUcTrdoE3jZ8awGa7xS43tSFN9DZMSpWc1UZ
         wLAxTJB1L5eP+ZBzsKemxWCRSkUVqXEo+j2O67Ryiq06RGZXakDXbk2qUmBmYmv+AJBR
         j2qg==
X-Gm-Message-State: ACrzQf1d60TL4PTlINcvyzn+Oodi+SpcIjK1fsrki08xG36EjqkCB5qh
        IwpH2tarLfdKqlmHf9DzKvzAKhQ67k0ZN3JeQ+4zXRl+nqM=
X-Google-Smtp-Source: AMsMyM6O3Wy7PK71GKF8664qTpBkz6MIIejI7oAznBSXD8WoYv7A7tCGkD7rKu+qIPUMt0QGo4T6ctbd1naGI2BuOQo=
X-Received: by 2002:a2e:2205:0:b0:26c:2423:a508 with SMTP id
 i5-20020a2e2205000000b0026c2423a508mr6769529lji.163.1663658168764; Tue, 20
 Sep 2022 00:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220916124234.h57p67mwywzok23s@haydn.kardiogramm.net>
In-Reply-To: <20220916124234.h57p67mwywzok23s@haydn.kardiogramm.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Sep 2022 00:15:56 -0700
Message-ID: <CABPp-BGdGZ6dg4_wWxkz+VCvaThfn3eL9uqBvmsK3+8GQf0ByA@mail.gmail.com>
Subject: Re: git rebase crash: merge-ort.c:2622: apply_directory_rename_modifications:
 Assertion `ci->dirmask == 0' failed.
To:     Stefano Rivera <stefano@rivera.za.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Sep 16, 2022 at 6:24 AM Stefano Rivera <stefano@rivera.za.net> wrote:
>
> Hi, I got a crash in git-rebase, a failed assertion in merge-ort.c
>
> $ git rebase renamed-parent
> git: merge-ort.c:2622: apply_directory_rename_modifications: Assertion `ci->dirmask == 0' failed.
>
> I was rebasing a branch that replaced a directory with a symlink, onto a
> branch that renamed a parent directory of the modification.
>
> Reproducer script attached.
>
> Using --strategy=recursive avoids the crash, so it's a bug in ort.
>
> Not subscribed, please CC me in replies.
>
> Thanks,
>
> SR
>
> [System Info]
> git version:
> git version 2.38.0.rc0.373.g21cbab7515
> cpu: x86_64
> built from commit: 21cbab75150d71ca294e09180c59ee529ca53957
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.18.0-3-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.18.14-1 (2022-07-23) x86_64
> compiler info: gnuc: 12.2
> libc info: glibc: 2.34
> $SHELL (typically, interactive shell): /bin/bash
>
> [Enabled Hooks]

Thanks for testing out a release candidate, typing up the detailed
report, and even finding a simple testcase!  Very cool.

I don't have a fix, but just wanted to send a note out that I've seen
your report and will take a look at it this week.
