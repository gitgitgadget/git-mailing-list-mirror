Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C743EC77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 14:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjDSOc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjDSOcY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 10:32:24 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2F840D2
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 07:32:18 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7606ce9bfdeso3658239f.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681914737; x=1684506737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LUPnRo96dQCJEOZEML47sN4XBWYTDDkVegVt/g83lHw=;
        b=c/nTJUGBCJ0rHoHgqZYtHJRtFtNXB4YKzpPQFpSLPKxPlb5HCr3MxFoj9tSOl5vL2D
         QLIuc1HZBwPEtSM2G0caiMLBJuZD6cEy1+O1r0YVYXiPll++I3RNp2ZLm2E9SYJiepAX
         9t7Gp2cF2UwZg/Cj/xQxO5HqgbvAZ6Y/BkGPBvec5EjNaMPp1hmYmxp9eK5YG912RoQn
         bTJZGCOJ5Nuy4dqkeWucK9z2uUpHDbpv9UvyBHrSEVSBNZDHUx4EkKSa9glBA7mpUnlc
         IPXrAkNtf4rjK5PnylTyVpfJHLsHEtoN148zYNyRN9SdSj1C91bKEMl6aLXRLeXtLU9l
         TvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914737; x=1684506737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUPnRo96dQCJEOZEML47sN4XBWYTDDkVegVt/g83lHw=;
        b=Zc4iTKzArxcqLC9K5zDJfhZ0MAHsv9lmvJlxw7z0/0AC7rxiCPYrbLxzkw1ArIvT71
         pdmGclApdWhKDEA3g56oDuDnzCpGD15iS7TgMbmUvq+4VxqHxMiLhO/U8hlKOiqOsGqS
         53QOVusapaDrHl6EEYUpWz1TrNyIOBj/UgWmx5+Mm3YmS+xTIcMipz4HNqazGcn+08TC
         tV/vfpl/rKhyxtfL/SVjQu2ehsd5lk8+oKPkz7RoXXJHPRl6GNV6mQnIqOBM2pX7IHNm
         JirBnGGzVysCvpcKkdoiAPA9zRIL6LRCqUXhkTM+iRKC3Un9T+vX43gJk5AlDkzAu4N0
         e2mg==
X-Gm-Message-State: AAQBX9cq4eBRzE+tfMGBYUTWCV2PzRCA5IILr+AbFINowXjJMYkAMh6z
        ssaVstCm5l4obTLq36n6F0vGR7QG5K86aLOZVds=
X-Google-Smtp-Source: AKy350b3zs16V8KMv0LUlyrEVn34XlhCHWRd3hG7TR+bAL+0V0F2yAiyZUtu5YiiYIv5+KSuotiWIhfCWUox3UxGt7g=
X-Received: by 2002:a02:8545:0:b0:40f:ae69:a144 with SMTP id
 g63-20020a028545000000b0040fae69a144mr3643152jai.5.1681914737476; Wed, 19 Apr
 2023 07:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com> <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email>
 <xmqqk03jcwxz.fsf@gitster.g> <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com>
 <xmqq7cuamjmu.fsf@gitster.g> <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de> <CAPx1GvcsxFbdUBZayzAU0U1MNMUN2NqaBLfZ6C1M=SykWQ_CHg@mail.gmail.com>
In-Reply-To: <CAPx1GvcsxFbdUBZayzAU0U1MNMUN2NqaBLfZ6C1M=SykWQ_CHg@mail.gmail.com>
From:   Samuel Ferencik <sferencik@gmail.com>
Date:   Wed, 19 Apr 2023 16:32:06 +0200
Message-ID: <CABwTEiSd1_WB_BXpT9BqkO3+rb2+FaZ7fFhGLo=CW=feKG2gUw@mail.gmail.com>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[resending my previous response, which I had sent only to the PR, not the
mailing list; composed before dscho@'s last email]

> > 2. casing (use of `/i`)
>
> My preference is to do this case sensitively (in other words, start
> stupid) and if somebody wants to use "/i", add it later after the
> dust settles.

Fantastic.

> > 6. what's the use-case?

> > * Note all of the use-cases above would cope with WSL reporting "Linux",
> >   except of `merge.tool`.
>
> I think that this is the most important question to ask, and from
> here, we'd see how #3 above should be resolved (I suspect that you
> may want to have at least two layers to allow WSL to be grouped
> together with MinGW and Cygwin at one level, and at the same time
> allow it to be grouped together with Ubuntu at a different level).

Actually, I take that back: I can install the Linux version of BeyondCompare
into WSL, use my license, and I'm fine with WSL reporting that it's Linux.
(This is just to correct my previous claim. More below.)

> > 3. handling Windows (MinGW, WSL)
>
> The answer depends on which layer you care about.  The underlying
> kernel and system may be Windows, and some characteristics of the
> underlying system may seep through the abstraction, but these
> systems aim to give user experience of something like GNU/Linux.

Fair point. I think we only care about the top-most layer (the one nearest to
the user).

The "seeping through" aspect means things often aren't clear-cut, but I also
think we can make practical decisions. The closer the top layer approximates an
OS, the more we can say it *is* that OS without compromising correctness. For
example, a Linux container on Windows should report (uname) it's a Linux, and
`includeIf` should go by this. So should WSL2, I think, because it provides a
Linux kernel. Maybe there is a use-case for git config (`includeIf`) to behave
differently in WSL because the host OS is Windows, but I'm not aware of such a
use-case. In contrast, "Git bash" and Cygwin report something other than "Linux"
(`MINGW64_NT-<version>`, `CYGWIN_NT-<version>`) because they are not Linuxes,
and that's also fine. Interestingly, though, they don't report the host OS
(Windows) either.

So I propose that we limit ourselves to the top-most layer. Can we come up with
a name (`os` or another) that would capture this concept?

- Felipe proposed `platform`. I'm afraid this may be confused with the hardware
  platform (as reported by `uname -m`).
- Phillip proposed `uname-s`. It's self-documenting in a way, but it's also
  wrong on Windows and describes the tool rather than the concept.
- Philip proposed `sysname`. It's slightly better but still very much a pointer
  to `utsname.sysname`.
- dscho@ proposed `os`. I like it for its obviousness. The issues with the name
  are marginal (not bigger than with any other name) and can be sufficiently
  addressed by good documentation.

If we can agree on the name, I can help fix up the documentation, the tests, and
remove the case insensitivity. Thoughts?
