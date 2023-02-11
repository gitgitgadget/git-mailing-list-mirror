Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C81C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 07:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBKHLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 02:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKHLR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 02:11:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C0232CE2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 23:11:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gj9-20020a17090b108900b0023114156d36so11946974pjb.4
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 23:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnKVW6qM6yI7vQw+C2p+4cSBsGyIcUlRZjL25lrcRU0=;
        b=mfr24Dk2xjGTi1Gkw8o48eiq8zfRJsYWEWDETYiKa07S4kgZwaiQ4I9bTmr0vhMfM4
         BmWufm1SHE+tmysq6Bl5P81s10ankJWlbultyRRE41D2V3CznOEexIv45SfC1Gq6K1Am
         ZRZvNyRXd7TzBOppp0rUz+KRKudC9LA9mwhwkYad/2v7xox/3eC83rIL9ZrzQcM36FeY
         YziUUuvjAa95aCez3qFkt+BQ2MzCBZsM/1/A1FE5n7E1z06O1Cfbz018YeMnXIZyrRN9
         XoisFf1AliC+0n9kM/qqNaBCf1fW8DKLA0Rz67fh3x1HphcJQV+iCzzQAoMDFpO3Ygdj
         jXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnKVW6qM6yI7vQw+C2p+4cSBsGyIcUlRZjL25lrcRU0=;
        b=wZ7uqO0r+JGOdYxYjXoWBiazuqAqLcn3tEWkwIlTw7MbbBNdwfjvSfmvAMrkxipUzJ
         CTTWVgVXjR1LxSjB1LMvoiIYd3wP7bbJwrcNpoNiEYc5hgIyWNgokS0KldYHBD09Xj2X
         dB5wTLovRt6kHoxU8pUGbQmt2IWkLC2r3sRiwpCWP36j3n6/6iWaarEh3Lj03Sopf2+c
         TokjoIOJu0dKPEGDerszIlamVx3iOoPQ4cxNsWVHWITvTiZaef2/Y4wAvV9oxQqXOjOw
         nHP6k/sadUz4+7fy6Tx90tpirziA0N95KXBOV0iraKLNGVnG81WteGI2KzA0x2U6sT3+
         begw==
X-Gm-Message-State: AO0yUKXfWMPtpbfS8bO4yPB7YFoPz8myxBTuHqxrjWW0YorzUB3L3zkJ
        8Liw+UHndKrYfP53280q6YJbB3vAkJrD6ZVUH/w=
X-Google-Smtp-Source: AK7set/H38WhpAFbMSCQ7VVSYxbwcgPSdJCPZa5zFyKvXH07pyc+8XAfN6wHebH7lgM5h+ej2TAl3sQwAZQ/fQ9Llio=
X-Received: by 2002:a17:90a:3da5:b0:233:ca37:37c6 with SMTP id
 i34-20020a17090a3da500b00233ca3737c6mr151056pjc.108.1676099476190; Fri, 10
 Feb 2023 23:11:16 -0800 (PST)
MIME-Version: 1.0
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
 <Y2p4rhiOphuOM0VQ@coredump.intra.peff.net>
In-Reply-To: <Y2p4rhiOphuOM0VQ@coredump.intra.peff.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sat, 11 Feb 2023 07:11:00 +0000
Message-ID: <CAGJzqsk=vbyrzeeq091RcKFmprpFaukFbcO9ctV1ti5vr-95ig@mail.gmail.com>
Subject: Re: The enduring popularity of git-credential-store
To:     Jeff King <peff@peff.net>
Cc:     M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
        johannes.schindelin@gmx.de, mha1993@live.de, carenas@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 8 Nov 2022 at 15:41, Jeff King <peff@peff.net> wrote:
>
> On Tue, Nov 08, 2022 at 10:50:33AM +0000, M Hickford wrote:
>
> > Secondly, the docs recommend git-credential-cache [2] which ships with
> > Git and is equally easy to configure. So why isn't it more popular? My
> > hypothesis: while caching works great for passwords typed from memory,
> > the combination of caching with personal access tokens has poor
> > usability. The unmemorised token is lost when the cache expires, so
> > the user has to generate a new token every session. I suspect GitHub's
> > 2021 decision to stop accepting passwords [4] may have inadvertently
> > pushed users from 'cache' to 'store'.
>
> Another big problem with credential-cache is that it requires Unix
> sockets, so it doesn't run on Windows.

Thanks to the work of Carlo Marcelo Arenas Bel=C3=B3n [1], credential-cache
*can* be built on Windows 10 April 2018 update or later. But Git for
Windows has to support older Windows versions for many more years so
the build flag can't be enabled. Perhaps Git for Windows could ship
with a credential-cache binary that works on Windows 10 and gracefully
degrades on older Windows versions? That's beyond my expertise. Help
very welcome at https://github.com/git-for-windows/git/issues/3892

Might this be suitable for a GSoC project? If a mentor could be found.

[1] https://lore.kernel.org/git/20210914072600.11552-1-carenas@gmail.com/
