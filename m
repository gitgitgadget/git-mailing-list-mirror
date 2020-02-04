Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70426C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330D62082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0Z1lvC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBDVz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:55:26 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46021 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDVz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:55:26 -0500
Received: by mail-oi1-f180.google.com with SMTP id v19so20100670oic.12
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 13:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9so/utzb+4kg60kiBTyD49/VtHbmC7fQqqhExVLdMw=;
        b=l0Z1lvC0xKZpLt+DTlx0ey2DiBddc5e68o/0yBKexcKZ6CTNMK7gy8vk1n4IIg4Oeg
         LoNoiMRXluVaYmcYW8ua1K+iNruu0fj0OratXOsdZC47TPhVToh+vvqjqxOHpjDbg7B+
         6ChKZetcEnCvTFLQG6uX+Q3JstnFVYDae8/3OCCyAssOeaTg15S4zyEOnOMfzypbV08M
         IUl5EuW1Pl5t4bNktBajtw5OtLZPPQJK2a7XlBx+Pn9UMz9avgmrllDJ0XD7jcyGJLh4
         wdj17SGT82nFG6eHWpSQIJ7553+ra5BCazly/Z09jIhhZ4fiRyPg0ye5smnuA/W+QZ6V
         Gkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9so/utzb+4kg60kiBTyD49/VtHbmC7fQqqhExVLdMw=;
        b=cKQ0FL7Z+KrcSXNgo4rarPCPcoTvFDR2dxL7Slrl803fnn/nSeaYkc06AxY7RhsK0B
         F1Y6LutJEqpE7vlBkbVf7Tjf27PCJgoFu8JTgza60N8sz808z9s0p34eO2IbgM3ELDk+
         6Q97+yHKykLEqCR3KPVD4Jw49JcA53ofF3VkK+o8tiQLeAXGRpVhtjlrES9vF2m+Ya/9
         QKm3+9aZ/qRZbeYG1m+kSqhTRJiHhLphenuT59AuHM5cp8GlEEKVwidpl4WkFIpoHAzD
         HGMQLsR4uF7qdSbDiKztfg7D96UjInBW/LhLTpIEoFpQilllSL+Pbb3qUdUaP0hEpMjT
         SSfA==
X-Gm-Message-State: APjAAAUpflAaATs43tCJ9uIl7LSoxqrJFMYj4jgMEiVdWjpx4NENg888
        hzSxk7Zw+vuiKR87iXE36fo9wEisRzh9SctosIw=
X-Google-Smtp-Source: APXvYqxEmndILNRJFdOApPquDiQl+dCMJyrMhCyiw6LFMlWr0OhLWVbvZmvO41wjZE+CbrnKFAK+qTB8zikXhGSGrgQ=
X-Received: by 2002:a54:4f14:: with SMTP id e20mr752194oiy.84.1580853325000;
 Tue, 04 Feb 2020 13:55:25 -0800 (PST)
MIME-Version: 1.0
References: <CABdb18jnV752=rQg=TvWjtAJoxoxU4XtSVf46FetxAxf6mRo=Q@mail.gmail.com>
In-Reply-To: <CABdb18jnV752=rQg=TvWjtAJoxoxU4XtSVf46FetxAxf6mRo=Q@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Tue, 4 Feb 2020 21:55:13 +0530
Message-ID: <CA+CkUQ8dCPt1ZB7iGVv64Q4bSmw-VH++jB-NfTY_T0J6Tk3fyA@mail.gmail.com>
Subject: Re: Install git 2.12.2 on suse 12.4 from source code
To:     Ashima Matiman <ashimamatiman83@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 4, 2020 at 4:32 PM Ashima Matiman <ashimamatiman83@gmail.com> wrote:
>
> Hi,

Hi Ashima,

> I am trying to install git 2.12.2 on SUSE 12.4 using git binaries.
> After the installation, I am facing issue while executing the following command:
> git clone http
> git clone https
> The error is :
> fatal: Unable to find remote helper for 'https'
>
> Can you help me with finding procedure for proper installation via binaries.

It looks like not having (lib)curl-devel installed when you compile
git can cause this.
This problem may can be solved by installing (lib)curl-devel, and then
rebuilding/installing git.
You may also want checkout this[1].

Cheers,
Hariom

[1]: https://stackoverflow.com/questions/8329485/unable-to-find-remote-helper-for-https-during-git-clone
