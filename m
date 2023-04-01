Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C50C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 17:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjDARRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 13:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDARRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 13:17:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492A1A94A
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 10:17:15 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r17-20020a05683002f100b006a131458abfso10962559ote.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680369434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVUFEYmiDvHXH/zcYH+Olte3gab4L9N/RN8GZ2vYsRs=;
        b=KguCs7xzfMZZDKSWQPBhat4rtuXmbhGfkSdUGNJBbcjugCpNHEPIHGlB5pPB8gXJtj
         rbRsMWCXMHweK2yNfoIIpNfPS3+MCgGEzRJwh3FD97DhDxwXRghwfxYm5yER9J6xwtC7
         gBYTGDVcC+JaGlxEBquOjD+Rj4xWthnjVIOKco+FMF0ryhM01RtkHB/Ubk8/nJHCtz8g
         mPB+FhRhAcu0Q+UGs5c7GhJaomMFRL/Hefgk/XLNrFe3WuHSk+JFKTUaVBTEe+6UU9bH
         lshwVxwxII9wuELomL8AH3DJPiPrt5tpNQgXZqsENmO3WwiLpJwmJKg0OopfHGc2m3Ne
         mHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680369434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVUFEYmiDvHXH/zcYH+Olte3gab4L9N/RN8GZ2vYsRs=;
        b=bUNtrcy4y/WLBa4eKoCIRUyFOUvRHYjEziHlCKofYPRlZ30kVJxdZY0sGSmqGzTTMx
         Oe0Y4/43gnCDH1s5Lp0X5oVWCjzKqd1dSZOYmmuqV3nL+vbeiWkopzh43HbFBqJIgXgG
         s1fhyLHeRNMfUU7scs/AJOc05geXXKFU+RIaWp0abQHJ5QAxC2E1c2Dl1oyVBvH/g+19
         1ChSSOfUFKTDn+NXV7uN3D/znXR6wJhTJmulvGqRvZXK14DWC2tzhDM8KiHN19P8EcF9
         EQQeBHLxVmSg6vjKB9rWzjfNyqwYEWTW2kBj6kdG6pGpqvKjJtkUsJ+XJkulkWheFfRq
         xQog==
X-Gm-Message-State: AAQBX9dyEegsCIKB5dANWKmNiifmtMT+TqiiOUDH/JK7puy9sip896nt
        mMBNLbYfbOriHnvQ8ToybDX9Ti5uc8DFFIe1yA+WCuQAwRk=
X-Google-Smtp-Source: AKy350YQIFCtz0bl94CiPwSt6vSQwLC7aCI8L6Ef52pA7JPCPdkPAKsKy/hmDr9UPOdEe1oDsX0c4OvKhbSc2Fb8FlM=
X-Received: by 2002:a9d:6485:0:b0:6a1:561e:3381 with SMTP id
 g5-20020a9d6485000000b006a1561e3381mr5413849otl.0.1680369434307; Sat, 01 Apr
 2023 10:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+MNPvgceR3s30LaCS716NGw+8S47CQZTqFno=vE2XAuiBA7Kw@mail.gmail.com>
 <xmqqa5zrbmap.fsf@gitster.g>
In-Reply-To: <xmqqa5zrbmap.fsf@gitster.g>
From:   Matt Gardner <four712@gmail.com>
Date:   Sat, 1 Apr 2023 13:17:03 -0400
Message-ID: <CA+MNPvg9JX8S2fOcH9NEq=d04BcCgbf5Qwc070WWwjXpUsd3Sw@mail.gmail.com>
Subject: Re: macOS git grep change in required character classes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the grep that ships with macOS is GNU compatible?

$ which grep
/usr/bin/grep
$ grep -V
grep (BSD grep) 2.5.1-FreeBSD
$ grep -E \\btest\\b test.pl
sub test { return; }

So, it isn't quite true that it makes it like other tools, especially
the most analogous tool, grep itself.

I think it would be a reasonable expectation that git grep and system
grep behave in the same manner.

On Sat, Apr 1, 2023 at 12:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Matt Gardner <four712@gmail.com> writes:
>
> > My best guess is that
> > https://github.com/git/git/commit/1819ad327b7a1f19540a819813b70a0e8a7f7=
98f
> > is causing git grep -E to require BSD style regular expression
> > character classes.  I don't know if this is a bug or an unadvertised
> > change in behavior.
>
> I think you diagnosed it correctly.  The story is "Once upon a time,
> we declared that the regex library of macOS is so broken and
> unusable.  We used a fallback definition to work it around, but
> unfortunately the fallback library did not support multi-byte
> matching correctly, which made some folks on macOS unhappy.  So we
> let Git built with the regex library shipped with macOS starting
> that commit, with one side effect that patterns you would feed Git
> on that platform would behave more like patterns you give to other
> tools on the platform."
>
> So, it is not a bug in Git, it is a deliberate change in behaviour
> with unintended consequences X-<.
>
