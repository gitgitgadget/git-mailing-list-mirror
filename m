Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4374BC43217
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 12:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154D323A03
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 12:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbhAIMpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 07:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbhAIMpI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 07:45:08 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62669C061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 04:44:27 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lt17so18261418ejb.3
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 04:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKCHI1XFV8scrn+8na0OXavkEseo5Wl3DExg+vgnjYk=;
        b=eQxWp8QaKOGn6x5oo+LTr1hVb4GHy/M13lJQRsq67FOsP5HPkmgyhg4DhEPc6aad0y
         JHLNbX75Q8BIaHXp9lxxs1N3y4PJtfGUzb2o1nTAbb/Zuosm0d5d4dKrBqwh0aH809yh
         a+HUbO/Rf4BiQFx4i9FsivoY3S9OQL4PyDD3M8VqIsi4jDvPTkqbSOoY7BvtG5PZyOXh
         eolSkL2zc4pwEY18/vJm7ensjG7Dy0BCPrC0oZWcd14QtT8cvknG47cxcu+eZsekYTQp
         Op9vd57sx0kkBAdhgMJnh8+AhlF5zOXOZCzy+xvYADIxLuQJFGWRI06Ru/PCZyKMBFVq
         z/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKCHI1XFV8scrn+8na0OXavkEseo5Wl3DExg+vgnjYk=;
        b=ZR4akao9j5XrClfzSoroM3ObgeoLc3s/WwtnCMuIoQagpAY8PjN0bKoyUX0MxMD2KP
         X5HZBdsUMN6yT483GcNdh06W23YIPNK6v/yd3YatvEHzoWhqmNaADupkHCecHL/Ee0qk
         WZH+5wfR+iiXTe7qwB5lPWn9CetIHEfQwW3qihDjNTtHnUmxsIjsKRHGY0VabOVGqFG4
         JvZ1MwFvJgg7KhtaldlAik83xpcYvsLzKWYUf3gzWU+gpn3gGDHGdCzdFmMUz8CJtYXS
         Eh0TgJYM2kY2dcswGEZKLu0hZfNJ322Y5FRfzkdj5CG14GFqD02T+SSXX7bsm54FIF8c
         VIsQ==
X-Gm-Message-State: AOAM530sYoFOP8Hdd61ZmAqBGoNvzxDCXplT1x7+9z5qTdgnp0F+0Ock
        wBfSY9uYqFTkgYHLj0V8pucTV9VedLyG4kyCtrk=
X-Google-Smtp-Source: ABdhPJyL0rHr8aDKXfUW/YqqUzURuCkaUBdmsRL9yc6s8mSXKFchO1Wam3QrNq/zakZxc74QPdtUYxPqF4iPUyXuoOo=
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr5565163ejc.216.1610196265388;
 Sat, 09 Jan 2021 04:44:25 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8mmox3fZTRO7W44whHhT0aPcNUXxrBVg1R7ttwUfVgy1A@mail.gmail.com>
In-Reply-To: <CAH8yC8mmox3fZTRO7W44whHhT0aPcNUXxrBVg1R7ttwUfVgy1A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 9 Jan 2021 13:44:14 +0100
Message-ID: <CAP8UFD30et-kL8dFoWvh7aPf4AKbzGxSzTuA=B3YNHZL_1axFA@mail.gmail.com>
Subject: Re: Git 2.30.0 and failed self tests
To:     noloader@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Jan 9, 2021 at 12:33 PM Jeffrey Walton <noloader@gmail.com> wrote:

> I'm seeing a failed self test with 2.30.0 on Alpine Linux 3.10,
> x86_64. Alpine Linux uses Musl and BusyBox, so things may be a bit
> sideways because of them.

When a test script fails, could you try going into the "t" directory,
running the test script with -i -v -x and sending the output?

> *** t4129-apply-samemode.sh ***

For example you could run the above test script with:

$ cd t
$ ./t4129-apply-samemode.sh -i -v -x

Thanks for testing!

Christian.
