Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F744C0015E
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 02:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGPCwA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 15 Jul 2023 22:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPCv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 22:51:59 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F28198
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 19:51:56 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so3407908276.3
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 19:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689475916; x=1692067916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hc9k9C7ymiehKXMDehFin40/q0EAKVhmsodnLI80FVQ=;
        b=S0OwnqVeIU8TxiT9hBJ1gC0i2mAzZUZoM2qhOu8E6TOelra/zzM6mBGgvPd9ufAxGo
         lXqLaC9JExrwYXy+L+WLFiIeKNk3vKrxAoGaur39ndFi1ZfapWwXc27AZOAac129TsGQ
         TCHs6Ix5dtKL29gGS4R2YKhjn1Nj/Kvpvg3Vji4AaQ3W6ARuHINvx0bHR+qxfoaiO3vU
         /4EeujO+n6k2qLx+fn20X8F0j6FXZPjqGU2lZ54V2y8jDr6I1uqDxKAvBhesy5Q/ann3
         BqZ2t/eAqvrei5/wW5zNvfPuctE3zdb+aBW/rO5jW0oqKt554X4NAD6+CcUrj9jX0tyT
         eQGw==
X-Gm-Message-State: ABy/qLb9lPRm/Je8Pbduw1PACj+xieHV9pgxM2SmQm0ICWPmmGIpHZws
        HIAR7Xo1cT8moxR4en/Y9fQkJdQjKvj+rz2/qSk=
X-Google-Smtp-Source: APBJJlFfyo1VeLVTMmveZGk8VWzob7RBhzpRQdy0YdoC7dNYC1g+Tudd5fNIXvS4lFxmdvfit55dn9pS8dyFMYvQAhA=
X-Received: by 2002:a25:cf57:0:b0:c90:4ee8:31c2 with SMTP id
 f84-20020a25cf57000000b00c904ee831c2mr9567986ybg.59.1689475916109; Sat, 15
 Jul 2023 19:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com>
 <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com>
 <xmqqfs5ro8v7.fsf@gitster.g> <356tacvizwbtwigdkz4byrrzsyjuktcb7cxaibf6wjocffgycp@iwhmszuuvzpl>
 <CAPig+cRMXJkrEgyVtC0u2QK=5QNnJOQnXBU_rE+JiGufEYH9sg@mail.gmail.com> <dk2fndv5aqshkgvfq55mrr5chdouenszedugyjoezcuatrsmn6@vqyih7nbqwbu>
In-Reply-To: <dk2fndv5aqshkgvfq55mrr5chdouenszedugyjoezcuatrsmn6@vqyih7nbqwbu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 15 Jul 2023 22:51:45 -0400
Message-ID: <CAPig+cRUOMSUzb95nnDPRnPN0TyDY93E4EdMp9zxTmnOfc8vKg@mail.gmail.com>
Subject: Re: t2400 on freebsd12
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2023 at 11:02 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> On 23/07/14 12:19PM, Eric Sunshine wrote:
> > I haven't been following this thread closely, but I wonder if the
> > `grep` introduced by patch [3/8] of the cited patch series is
> > problematic:
> >
> >     grep -E "fatal:( options)? .* cannot be used together" actual
>
> Thank you for this insight. It didn't end up being exactly this issue
> but it seems to be a grep issue nonetheless. I've submitted a
> patch [1] which should resolve the issue (I tested it on a freebsd12
> VM locally).
>
> The TLDR of the issue is that grep 2.5 (GNU or BSD) doesn't seem to
> recognise `\s` (or its inverted counterpart) as ERE but newer GNU (and
> potentially other) grep versions do.

That's great to hear. Thanks for digging into this and submitting a fix.

(The FreeBSD 12 VM I created with the idea of investigating this is
now unnecessary.)
