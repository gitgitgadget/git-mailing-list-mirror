Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EC2C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 07:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227A22070A
	for <git@archiver.kernel.org>; Tue, 19 May 2020 07:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHXCzZOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgESHNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgESHNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 03:13:31 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94853C061A0C
        for <git@vger.kernel.org>; Tue, 19 May 2020 00:13:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g9so10763402edw.10
        for <git@vger.kernel.org>; Tue, 19 May 2020 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iZ0jOvEJMUUv6VRdkrWQrkYIM8beVZHtrR/OcAra0/A=;
        b=XHXCzZOtDRSbtE3dBZoNudcwKQvgUaCUUhXs3SG1C3wwFHVHwZey2Sx/XjK+GNCyj0
         48flgfdwEbAxy3Rzo/IDZqnfvowIwG7sMoBUD3958noPwSNErcbZn4S5TpDLkOYde6eG
         e43vE4iCirdpvFElsf/P6/7N5LtF3iOwN/NXpzKVEfTDAMiOETzCYjt6xS/9HP3ZMkT4
         tdKa5gIOJzpiFXnId/xKOBjcrb0EsxivvN1QD7rMZkViVhVtILC/tnYs7IBQbEWVXAX0
         76IFLyD4WQtt4Oaiqyc76KvKSYBYDqd/VHreIwFxC/A0J3szHmlKrV4l2F82nKDFonH2
         U/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iZ0jOvEJMUUv6VRdkrWQrkYIM8beVZHtrR/OcAra0/A=;
        b=VML2R8s+Othyni+QwzJ/WeBwPdhjCQ8cFKEjoJPScSaDGsRgZB0nfwce4OicFB0xO8
         e51cNRAZUxBsI0ph4y7/BQL69DlvXXvOvzFB9aQIJkVONssbMfMQukpFYv5XH8kUvkue
         UACBmA3QZXnbwC7Dfb0M+JHl3eAkuvlUrNsSvgs4iTIbVphPDYhUpV7AcwBB4ywG1GPC
         FwkvzfqJECSvtrdqTqyXxaZXjbKaOQIf9laS3aiIAYtteMP0AuJYJaqhHJCtrYXbZacU
         ddgd3AnGh58+04RYdcYdzrLR82YfGylo83CnuEjhNpYTu/b/1w2e+YTIlM8n/4yOQmd4
         rTpw==
X-Gm-Message-State: AOAM533rLpGxaDkeqE5Zu3Ai7w+S0mzE0NEGI49hQNyexY7Utr+fX62e
        eo/REkybXl2ZiXYxE64p8GgTPDq6qlFe+3wiyag=
X-Google-Smtp-Source: ABdhPJxODANQJDFUFcOjpQiIUYE2Gr9u5CLgBFhCKXKJ2uNG0QlQLBueqxatLbsQ8jp/Weukpj5HBxobZI34W0q2XoY=
X-Received: by 2002:aa7:ce17:: with SMTP id d23mr13235343edv.387.1589872410185;
 Tue, 19 May 2020 00:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200518100356.29292-1-dtucker@dtucker.net> <20200518141311.GC1980@danh.dev>
 <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com>
 <20200518153025.GD1980@danh.dev> <CALDDTe0BvyXYz39n0EqGnJgdfHMziwW7V5xQO_H=+OKm20jfFA@mail.gmail.com>
 <20200519005645.GD1999@danh.dev>
In-Reply-To: <20200519005645.GD1999@danh.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 May 2020 09:13:19 +0200
Message-ID: <CAP8UFD2vYwnwgNWX3tg5w-7kCg3kzNscVbnk0DJfSD4UV-D0hg@mail.gmail.com>
Subject: Re: [PATCH] t5703: replace "grep -a" usage by perl
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Darren Tucker <dtucker@dtucker.net>, git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 19, 2020 at 3:00 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:

> On some platforms likes HP-UX, grep(1) doesn't understand "-a".
>
> Let's switch to perl.

There are some other platforms where Perl is difficult to install.
That's why we have the 'NO_PERL' Makefile knob, and the 'PERL' test
prereq which is used in some test scripts like t0021-conversion.sh,
t2016-checkout-patch.sh, t2071-restore-patch.sh, ...

>     We can also copy-and-paste code from t4019,
>     to avoid introduce perl to this test.

This might be a good idea.

>  t/t5703-upload-pack-ref-in-want.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref=
-in-want.sh
> index a34460f7d8..92ad5eeec0 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -49,15 +49,18 @@ test_expect_success 'setup repository' '
>
>  test_expect_success 'config controls ref-in-want advertisement' '

At least you should add the PERL prereq to the test with something like:

test_expect_success PERL 'config controls ref-in-want advertisement' '

>         test-tool serve-v2 --advertise-capabilities >out &&
> -       ! grep -a ref-in-want out &&
> +       perl -ne "/ref-in-want/ and print" out >out.filter &&
> +       test_must_be_empty out.filter &&

Thanks,
Christian.
