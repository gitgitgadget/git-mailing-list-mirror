Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53078C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 15:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjBDPRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 10:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjBDPRL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 10:17:11 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086212F7A0
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 07:17:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d14so6928951wrr.9
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 07:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1S3KYD1CBEZzwgrXk9TMEIG21nP73nW0yCKoXo0BeI=;
        b=QRjKJ+Q0MAZB42dMqYacM0gzZDCeZgcVTHcrCxzvLa0t72Nqnacoov9Ckq3wa+dJ6k
         CUyhbdre8z4uwtSAi4N7b5OJ6SJbGsSKKiJVtRrVxz4XvVW4EBlkAVpXkkAfQhMREDco
         v62riEKNRO9h+uOmU9FIPCWwa5Kg73KvoXu55Xegui6CUgM82QGNfalHqzw5RjTLyY5T
         WBJt2A6hqKSi8tWBRmZ5s+f6S/7bz3sDbQly8qo/4WawMgxBzfEZo7OflfHeIPnVuShr
         DbYn0Pg8xlMZsDHtTcYZOuiuRA94YP/Zp2aFR7TSfkpF5wsy21Cplgp3i11IGVwOS6RM
         ccnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1S3KYD1CBEZzwgrXk9TMEIG21nP73nW0yCKoXo0BeI=;
        b=JLu28WtyP2fOdJgXUbQhFgQSvCJIlVGmEoO+8PpN2LVOgKMP9cPYiaz+OarohlAGsb
         xUM2C8QXHT0ShBBWpnrGOPNOK6V2ci3/JEyKHOtuNUkVSzJ5N8RZ+YCGo5IPea6/cYZV
         bpQHZK8ZyjR1LOI0bVTTQYUma+lw1Wh638WpYv2ge8570KbjiW3Cd0G6s4oMFDxsTvud
         mCWs6Ez25NfrSEwzI2MhWSOas6BohdS+2M9rfYakFtucoz5Ozv/mjVD52a+bbK24rp04
         /uXfjlYij9e+tbBO4jvCOxgloOn5DU49OQgjRg2XsmChZm2W1tLTk4FQskPKfVj3hhdJ
         URvQ==
X-Gm-Message-State: AO0yUKU00rPAa7iT6xmde/uvZvZ21Kj9W7jkX8KGSaNoHc2AnIt4dWzn
        Lzs6ZZdQOPDf8yuxd14U5Jh/MkoKs+04dZ18ll+SkC93Mfnuxg==
X-Google-Smtp-Source: AK7set96CF3nKeTUdygzkYfxR9d/ejCDh06nuUQtjxaXKKhPJyBEZtZgoy8MfNvR9UIWLNQz0XeWDwggr/mcSLAhjiQ=
X-Received: by 2002:a05:6000:144c:b0:2bf:d8ef:bc58 with SMTP id
 v12-20020a056000144c00b002bfd8efbc58mr403297wrx.521.1675523819408; Sat, 04
 Feb 2023 07:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20230202202557.19297-1-kostya.farber@gmail.com>
 <xmqqa61vsniy.fsf@gitster.g> <CAPig+cTC4TUK2NXFmP6ymEYYjYAmCSd53dzFhKn0ido8x6uh1Q@mail.gmail.com>
 <CAPig+cR+1bxgitSmJ47PxD=CPxJjMh5Vm+zRdVU8iEo9pvtutw@mail.gmail.com>
In-Reply-To: <CAPig+cR+1bxgitSmJ47PxD=CPxJjMh5Vm+zRdVU8iEo9pvtutw@mail.gmail.com>
From:   Kostya Farber <kostya.farber@gmail.com>
Date:   Sat, 4 Feb 2023 15:16:48 +0000
Message-ID: <CAPRQfCZUwaE4mko46n0wQbkKjpg4Tqxbg6eKLm9rFrBRj6sVLg@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t/t5000-tar-tree: add helper function
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 11:19 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Feb 2, 2023 at 6:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > So, t5000 seems to be one of those relatively rare cases in which the
> > raw "test" command is more correct than the higher-level helper
> > functions.
>
> By the way, although the change made by this patch is probably
> undesirable, if you would like to try a different submission, there is
> a bit of modernization that could be applied to t5000. In particular,
> the "archive and :(glob)" test does not match present-day style
> guidelines:
>
>         git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
>         cat >expect <<EOF &&
>     a/
>     a/bin/
>     a/bin/sh
>     EOF
>         test_cmp expect actual
>
> These days, we would use `<<-EOF` rather than `<<EOF` to allow the
> here-doc body to be indented to the same depth as the `cat` command
> itself. Furthermore, we would use `\EOF` to indicate to the reader
> that no interpolation is expected within the body. Taken together, the
> final result would be:
>
>     git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
>     cat >expect <<-\EOF &&
>     a/
>     a/bin/
>     a/bin/sh
>     EOF
>     test_cmp expect actual
>
> Both cleanups can be done via a single patch; the commit message
> should mention both modernizations.

I would be happy to help and submit another patch for this test based
on your observations above. Thanks for the suggestion. I am trying to
get used to the development workflow of emailing patches and generally
getting familiar with the code base and this seems like a small but
important step in the right direction.

Thanks
