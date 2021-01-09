Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9746C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 20:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EA023A58
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbhAIUhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 15:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIUhP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 15:37:15 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7CC06179F
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 12:36:34 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id w17so14052670ilj.8
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 12:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=eYqXs5TZaZr4DVYC3UQHPWbnMwr6xfgYm/R8SUu84t8=;
        b=ualpS8ljgkKG+ycJtAMJ79WIw9JOCKi9QAXzjFfx2elMg1Gt/MPbhpIadrawyNc6J5
         0rtDXU56hibf3J1IadG2qwYkPjBS9fwC0EnOXln713jIleaKlrLZzA7OQhqlhJuHtQ8t
         MihMDiBcmfDjJqPymODgVsuuiQ6cQYey7ivrcip/LU/3RebPNLYa+ZRO3TgqRJJPJAqs
         GxVZw36W9aloJqOdFv7DDV1SU2a6ZlWKFAr3zbfkh2AaioOv3YvjN/Z68NTJARdPBo54
         kbp1DOdVBD22srNg5kOGnHjaWb9ImOyI1BnS2t8dVtuWdk3yYupr5w61mjIzu0eA4asW
         wLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=eYqXs5TZaZr4DVYC3UQHPWbnMwr6xfgYm/R8SUu84t8=;
        b=siPZDew8a2OgQNi2Sli/Oc8hgei2DzkUxQ9eivTaUNazCLkboJJy9odpDJReYAkDgC
         admjwtztObrE+icEjI7AvhrQPFzd5LUMKagOL6VYAfynGxcG9S05dd3VKvsYOSvhn4Q9
         VkqVMgA49BlkXrnb2hYwHKVG+woUAIhRi5Em68Ynv3ARdgYUgZuMlcdvsbC8R5OC2HV4
         qfCfn7WPX/yE83WoGdnJMN7yl2OhyRzVnes4RYbr3AEdWJYSwcSZWFkygQQ5VaSwoOZS
         uiRg7aTqdeCZMYCWGWif8IQJYnVvm2z+grpQXdzW58ylxkFEZzkjM6IeIgYCGxFRQdFE
         S1+w==
X-Gm-Message-State: AOAM531ozBbPp4Q8CHXpgbxEGxZjjgF0O63+b5T/TuQ9UMwRyn57wI+N
        AOf+d/vAZym+hMA2yabnaqqLKc6jPaE5X4/SdFAKH5fb
X-Google-Smtp-Source: ABdhPJzVjXkBke6oteMRUnTAl8mK2PWN+YIm/gQBo0Y95Z69zEgjn/BBy8y6rWLq6vaj1tyOeOs55/JYOlT9r+KFdR0=
X-Received: by 2002:a92:8495:: with SMTP id y21mr9597420ilk.55.1610224594131;
 Sat, 09 Jan 2021 12:36:34 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8mmox3fZTRO7W44whHhT0aPcNUXxrBVg1R7ttwUfVgy1A@mail.gmail.com>
 <CAP8UFD30et-kL8dFoWvh7aPf4AKbzGxSzTuA=B3YNHZL_1axFA@mail.gmail.com>
 <CAH8yC8kdOrramqggwQ0HBLpub8_+7N+kuvfaCHRokamKFjer4Q@mail.gmail.com> <CAHd-oW48jK7o_L06FR515JvYNB0ZRZ25TR0WktfEpCzgQMGAGw@mail.gmail.com>
In-Reply-To: <CAHd-oW48jK7o_L06FR515JvYNB0ZRZ25TR0WktfEpCzgQMGAGw@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 9 Jan 2021 15:36:23 -0500
Message-ID: <CAH8yC8mMyS3-PjhcuizVzQGrAU_TyuNu4jdPZdpcmEBvZXjH2A@mail.gmail.com>
Subject: Re: Git 2.30.0 and failed self tests
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 9, 2021 at 3:16 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
> On Sat, Jan 9, 2021 at 4:42 PM Jeffrey Walton <noloader@gmail.com> wrote:
> > On Sat, Jan 9, 2021 at 7:44 AM Christian Couder
> > ...
> > Thanks Christian and Matheus,
> >
> > Attached is the redirected output of t4129.
>
> Thanks for sending the output. Yeah, the problem is that the test
> doesn't account for the presence of the setgid bit (which is inherited
> from a parent dir). Here is the relevant part:
>
> + diff -u d_mode.expected d_mode.actual
> --- d_mode.expected
> +++ d_mode.actual
> @@ -1 +1 @@
> -drwx------
> +drwx--S---
> error: last command exited with $?=1
>
> A patch fixing this issue was already sent, and it is marked to be
> merged to next:
> https://lore.kernel.org/git/b734425e3235651e738e6eac47eae0db7db92e7e.1609861567.git.matheus.bernardino@usp.br/

Perfect, thanks. It tested OK.

Jeff
