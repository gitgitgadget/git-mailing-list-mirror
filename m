Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED629C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EC62068E
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 09:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="XtyxFTHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfLCJWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:22:02 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:43430 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 04:22:02 -0500
Received: by mail-il1-f169.google.com with SMTP id u16so2487689ilg.10
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 01:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iotSFIcc/NeNgvpSCH0PwMkP0W8hfZZqDEHWJmtqZk=;
        b=XtyxFTHrKiVG3JEyb1ndVOb/WUXdwGanS759CbDkiqWdtPdP6fJafu8vXXZ2ISzPFS
         6qz/s9rPTLzDheiWwMaeJu/lbG2Gp3QTDoijseQChbc99pMsszO8Dptqrs/Vx35aKi7q
         8pyjtmKZ7+xYfKqiGzmZlQ7MfLZvuSNSyLU0k96DiEJKBGQE8iWnQLNkQbW8lB1aBwmK
         PNEs8OnR6d0E25aGfvM3wJ3z42LadF8ETQlNcGleQwglgNRNGKS7lAxl1aET8CXY3zJU
         n674H00eFqoVCeTkg+qzD1bDAhcLIB7B70PRduKjqMDuSchha0rbPeyEazpofyv/tkxu
         Etgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iotSFIcc/NeNgvpSCH0PwMkP0W8hfZZqDEHWJmtqZk=;
        b=ukPEzqXILHSrLdKSRqlAURnGkL301cTqLabPz/edaOnEZZC8wJY61zxiY9snUBpVkA
         lYwLWFfJottFYbcpWxeHJqnZZAkVjlqcmXuk6cczxx3QRaUTpQOCs1NTA1oY1zGVjbLD
         rdE5OdZhobMZ5scdb40DW6O6WTQRmktP6+luWj4e2t+qcNyHpFKgeX26BUleJYkzmAEF
         8TE6HQaqBnEhG4OJQmwXsWFVet/qicREtPFB9f0wMzmuERs9T9nqjxnkkRb259Oa1sRz
         53Tdnukh41Wv2brl9W5ph7eaf63cnIGrq544rcQlKdjRkj1NPxLDnFVp0glMVIc7lYa1
         J3gg==
X-Gm-Message-State: APjAAAWGsPiVNrJ40/WbMBNDc+PV1hRNr5NZwRAyFZSXWk/zTPILB78h
        wZIqTiy9aEi+51Y81kQi/souSrPwJKRK3SB844sWiaSOj7s=
X-Google-Smtp-Source: APXvYqwvKwtgC1CHzYVTVpPD3dQ+KSEw3O538MNoEbrEuQf1NCQa44UOqDsomIf+RkdNY6WkZXgseTI6W03NPEodYog=
X-Received: by 2002:a92:901:: with SMTP id y1mr3645535ilg.274.1575364921537;
 Tue, 03 Dec 2019 01:22:01 -0800 (PST)
MIME-Version: 1.0
References: <defeb7be75f54e8483ce529b2571478d@nokia-sbell.com>
 <5e27e2a9f6374742859b4b87d85c56e9@nokia-sbell.com> <1af00173f96243bea760baaddeb15777@nokia-sbell.com>
 <CAGyf7-FW_8RjVPEtmKiNFnF5QNZ4f+kqZ_BAGnGu76QcR=F25Q@mail.gmail.com> <a755356230794fb58bdd48dd74714aee@nokia-sbell.com>
In-Reply-To: <a755356230794fb58bdd48dd74714aee@nokia-sbell.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 3 Dec 2019 01:21:51 -0800
Message-ID: <CAGyf7-Fn-XRQhGCLdr+WxBAWKywQH2_s8XCsNUG7Vpgyu2jjUg@mail.gmail.com>
Subject: Re: one bug on git
To:     "Lou, Pengfei (NSB - CN/Hangzhou)" <pengfei.lou@nokia-sbell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 3, 2019 at 1:08 AM Lou, Pengfei (NSB - CN/Hangzhou)
<pengfei.lou@nokia-sbell.com> wrote:
>
> Hi
>    Thanks for your support
>
>     But your idea was still not working as my wanted , please check the result below
>
> [pelou@hzling29 try_des]$ git log -1 --raw --no-walk=unsorted 57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15^ 57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15
> commit 9d00cc608993840e24f65c7b79ae10f85c2d72ff
> Author: pelou <pengfei.lou@nokia-sbell.com>
> Date:   Tue Dec 3 17:00:47 2019 +0800
>
>     2
>
> :100644 100644 d474e1b... 9a7456b... M  lpf
> [pelou@hzling29 try_des]$ git log --raw --no-walk=unsorted 57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15^ 57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15
> commit 9d00cc608993840e24f65c7b79ae10f85c2d72ff
> Author: pelou <pengfei.lou@nokia-sbell.com>
> Date:   Tue Dec 3 17:00:47 2019 +0800
>
>     2
>
> :100644 100644 d474e1b... 9a7456b... M  lpf
>
> commit 57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15
> Author: pelou <pengfei.lou@nokia-sbell.com>
> Date:   Tue Dec 3 17:00:47 2019 +0800
>
>     3

At this point I'm not sure what you're looking for. Your first command
has -1 on it, so it only prints the commit for
57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15^, which is
9d00cc608993840e24f65c7b79ae10f85c2d72ff. Your second command omits
the -1 and so it prints both 57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15^
(9d00cc608993840e24f65c7b79ae10f85c2d72ff) and
57cf56b8c1af9115a7f8e1c1c8f07e4d657e8b15--in the order you asked for
them.

What output are you _expecting_ to see?

>
> So you mean it is not one bug /issue, and  adding delay was mandatory for this case? Actually , I found it was still be failure if the delay was set 0.5 seconds.

git commit records timestamps with second precision, so a delay of
half a second means you can still have 2 commits recorded with
identical _to the second_ timestamps.

Bryan

>
> tks
> Br, Hercules

P.S. Please don't top-post on the list. Respond inline adjacent to the
part of the message you're talking about.
