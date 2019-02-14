Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57A5F1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 10:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438237AbfBNKOq (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 05:14:46 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34024 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfBNKOp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 05:14:45 -0500
Received: by mail-it1-f196.google.com with SMTP id d125so1224432ith.1
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JqzbchHzsYGy4ap98NlIxuqGcHcm7k9aW6g8lh2P6pc=;
        b=MqxiK8gOU4QHlknQfDBfIuT1J4i+LlKQLn/x/jWkn9Nft3WUBhKlj5rUZylSYNAFaI
         9Dpaxwj5ChyTFlV2QDoiIUcoZLnAxX5lpt4IBrpBddEONtQVJ8wMLu16GUkURiVEx6hs
         YAXDwh+Y1k23u/iGoYIiJ05nixxuA2FR0yY/XwJJSpWaSKMQqHpfKK4ZO9Bk1wC2MN6J
         /MEArq02P8a+vjiOW4gl0iiPRakleDYXV3IVT1UP3Y87o6CofsyvFcK/vabEmmZcB80O
         +YKf8vsS1SqftyW6tvxMutw3EdWEmLfwUFbtRQxnRqE/QHrNtn7OF9EOxk30yblLi0HZ
         IUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JqzbchHzsYGy4ap98NlIxuqGcHcm7k9aW6g8lh2P6pc=;
        b=o6j1EvCpVMokhEKI/aW1IpnREuLW52rGtEUS+/lew+kpfOcBbwXkGsIkVkv2YCHxQN
         4iOTyu1i0ZoS2jXq01PMVswvMSnbUU+yQPtYKzzuogpuWGItKOqRr4c7OC8Mg7P7aVJY
         Qz79EUtZQzRPEh6Rg52g/w6obLTM4Pb/JSY5Lwzbah/MzVSkG2+I3qb0zbetKiKPHalZ
         Du1YNGBAOqIwsujhlRnKbTqutlZ1MH0+a8pJMAO08QAnESo7VSZgnoiJUmgQzheWEMiK
         9YQLK43QTwLfzZj+0OYGBdVDQdL4SQ3TO8jMw2rT31IUCkA2G+pL5w/pUL7b60c47A6p
         UtDQ==
X-Gm-Message-State: AHQUAub/bGjsNeOnj+jnd6E61/4mYGNF9HNXhqlbw2t4A2K+TVE2b2/E
        FG9+CaJoPkY7r9jSyx/TN2EJ1l18LLhRelSSWgE=
X-Google-Smtp-Source: AHgI3Ibk1EByZCQZ/h9cAE4QN/BagB19NhvymGpT8XdO020y5igDKXlMtu1yQxwHsFvI15XuF5x7EkGkCixU15R3lHA=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr1418821ioc.282.1550139284660;
 Thu, 14 Feb 2019 02:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20190213120807.25326-1-pclouds@gmail.com> <87bm3ek7qr.fsf@evledraar.gmail.com>
In-Reply-To: <87bm3ek7qr.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Feb 2019 17:14:18 +0700
Message-ID: <CACsJy8DWXcBk3f3heZp5J7dhTM3JL4MeVco56j4WtJNeskz9pw@mail.gmail.com>
Subject: Re: [PATCH] read-cache.c: index format v5 -- 30% smaller/faster than v4
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 5:02 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > Take a look at stat data, st_dev, st_uid, st_gid and st_mode are the
> > same most of the time. ctime should often be the same (or differs just
> > slightly). And sometimes mtime is the same as well. st_ino is also
> > always zero on Windows. We're storing a lot of duplicate values.
> >
> > Index v5 handles this
>
> This looks really promising.

I was going to reply to Junio. But it turns out I underestimated
"varint" encoding overhead and it increases read time too much. I
might get back and try some optimization when I'm bored, but until
then this is yet another failed experiment.

> > As a result of this, v5 reduces file size from 30% (git.git) to
> > 36% (webkit.git) compared to v4. Comparing to v2, webkit.git index file
> > size is reduced by 63%! A 8.4MB index file is _almost_ acceptable.
> >
> > Of course we trade off storage with cpu. We now need to spend more
> > cycles writing or even reading (but still plenty fast compared to
> > zlib). For reading, I'm counting on multi thread to hide away all this
> > even if it becomes significant.
>
> This would be a bigger change, but have we/you ever done a POC
> experiment to see how much of this time is eaten up by zlib that
> wouldn't be eaten up with some of the newer "fast but good enough"
> compression algorithms, e.g. Snappy and Zstandard?

I'm quite sure I tried zlib at some point, the only lasting impression
I have is "not good enough". Other algorithms might improve a bit,
perhaps on the uncompress/read side, but I find it unlikely we could
reasonably compress like a hundred megabytes in a few dozen
milliseconds (a quick google says Snappy compresses 250MB/s, so about
400ms per 100MB, too long). Splitting the files and compressing in
parallel might help. But I will probably focus on "sparse index"
approach before going that direction.
--=20
Duy
