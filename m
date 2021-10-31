Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F6C433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF7760FC1
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 14:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhJaOFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhJaOFL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 10:05:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D34C061570
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 07:02:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m17so54228951edc.12
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FntGyRDFICzwTaNAoHaza+tkuMc2kMOd3ZrweXUbXrU=;
        b=oB60mRVnjIaD4jC35Lfhyf2QnvnOJxERf6hZ1YHmD0UJ6n0ZMjB5AuKVo2mWncYrnn
         2XUCqllCXiQM8Ppc397PaunaJadyglN3skXfRM6BGvqzmwD5y+CkAdVteKgDIgo29CQ3
         5G45Zzi0T9pwC95bafw0pSF/KfWDL0bsp2rcx4NpO8HMaLNk712ypHrmopzK72DCEm8N
         SUfDBSkLSSssJf87lXbOTaedWULnPejpIbDhPGo5zJrrr6zAs+JbVDNUVxjmDbbF2JkJ
         lmdBe/Xmyynq4nea7gxIeybBptzSCC8AcdCzsVusLcKe6483hiB9t5jyUIERTgsF9IPk
         sEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FntGyRDFICzwTaNAoHaza+tkuMc2kMOd3ZrweXUbXrU=;
        b=pWEan6F7vcEHG5u5bSMTo+35pZuxoecizpF/ls82DCFO+tFve+56uw7G7p9K8D0lug
         P3cHlZK+BfJh+ATdp6OgMIUqGZg9Upu6WUY7TKGjGeiKIpD/G/INKdc2qBy14M90i85B
         cahW4MW3g3Cvj30qO5MoRYqcQi4MOUFkQUzJ04b3zfohYrSdpHeU9rnRnFEdcjr6Jf1K
         b7cYQISTa7RgxKrrzed9wcCcMci07s2ZDXXzQJaIX2X/7JjMjclybLSZlKAOksACgxIb
         FnaNHU+1dVDKWV4IyAsxKCTNzzd6EU5zLs6uJnlGd0UC09XeuZ5GKyGTMjutGeL45V/g
         aJlw==
X-Gm-Message-State: AOAM530bIJybYWe9W6dBFZaqLnqI5eMewYOS9FHfMVTjlT55qN5Dwd/d
        U3iYLTc5UN2NTHNNNqc2MdxapCQe6CbCAg==
X-Google-Smtp-Source: ABdhPJxCjthJr/Ue8PWbjNnMvxFqjmvfxiLTcp00ptvmGd7QbDnEb5LSeI7Njj0kRUQMXVYDSa84ow==
X-Received: by 2002:a50:be87:: with SMTP id b7mr32989123edk.382.1635688957784;
        Sun, 31 Oct 2021 07:02:37 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn16sm2174807ejc.90.2021.10.31.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 07:02:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhBPw-0028Tv-MQ;
        Sun, 31 Oct 2021 15:02:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
Date:   Sun, 31 Oct 2021 14:00:42 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <YX5T+wt0hSkxkLHA@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YX5T+wt0hSkxkLHA@coredump.intra.peff.net>
Message-ID: <211031.86a6ip47ib.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 31 2021, Jeff King wrote:

> On Sun, Oct 31, 2021 at 12:32:26AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> [...]
>> +# LIB_OBJS: compat/* objects that live at the top-level
>> +ALL_COMPAT_OBJS +=3D unix-socket.o
>> +ALL_COMPAT_OBJS +=3D unix-stream-server.o
>> +ALL_COMPAT_OBJS +=3D sha1dc_git.o
>
> I think "compat" is a misnomer here. For one thing, they're by
> definition not "compat/*" objects, because they're not in that
> directory. ;) But more importantly, the interesting thing about them is
> not that they're compatibility layers, but that they're part of a
> conditional compilation. I.e., we might or might not want them, which
> will be determined elsewhere in the Makefile, so they must not be part
> of the base LIB_OBJS set.
>
> Probably CONDITIONAL_OBJS or something might be more descriptive. That
> _could_ be used to include things like CURL_OBJS, but there's probably
> value in keeping those in their own list anyway.

Good point, will rename them.

> Likewise, they could go into a conditional-src/ directory (or some
> less-horrible name) to keep them distinct without needing an explicit
> list in the Makefile. That's sort of the flip-side of putting all the
> other LIB_OBJS ones into lib/.

The goal here was just to get us rid of tiresome merge conflicts when
two things are added to adjacent part of these lists going forward,
rather than some source-tree reorganization. I didn't search around and
didn't find that 2011-era thread.

I think overall just maintaining the list of the few exceptions is
better than any sort of general mass-move of these files.

Even if we carefully trickle those in at a rate that doesn't conflict
with anything in-flight, the end result will be that e.g.:

    git log -- lib/grep.c

Will stop at that rename commit, similar to builtin/log.c, unless you
specify --follow etc. Just that doesn't make it worth it to me. Likewise
sha1_file.c to sha1-file.c to object-file.c, which is a case I run into
every time I get a "git log" pathspec glob wrong.

Also.

I didn't notice before submitting this but this patch breaks the
vs-build job, because the cmake build in "contrib" is screen-scraping
the Makefile[1].

What's the status of that code? It's rather tiresome to need to patch
two independent and incompatible build systems every time there's some
structural change in the Makefile.

I hadn't looked in any detail at that recipe before, but it the vs-build
job has a hard dependency on GNU make anyway, since we use it for "make
artifacts-tar".

So whatever cmake special-sauce is happening there I don't see why
vs-build couldn't call out "make" for most of the work it's doing, isn't
it just some replacement for what the "vcxproj" target in
config.mak.uname used to do?

1. https://github.com/avar/git/runs/4057171803?check_suite_focus=3Dtrue
