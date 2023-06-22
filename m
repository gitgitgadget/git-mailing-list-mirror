Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A82CEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 15:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjFVP7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjFVP7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 11:59:07 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB119A6
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 08:59:06 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3420dccf277so26824975ab.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687449545; x=1690041545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS93xfx9+1ZuPXZHxivij9y+R/j3rtnGXNixI73fQ4k=;
        b=HXMcBHEQ/RqTbvzu/y+HbTKLJk8nHUG/gGwrjyt+nTYwbsSoaOeNGgEsvFOOMOEqTP
         eswNi7KYD6ooeWkEM9/4ho+0otkX8kLRycSUSdhxzgkGWqJ5yQ6MEHqSPn1oePAs1TwL
         U8OZ7i4cXxD6n0lOJkxcqadZeqA0P82zQAeiQef5f9xuYJ5+ZNkqIpC8R5fSDhlcs3gJ
         YVXvzlvUG6s61gsPvewcLoeadWeJDdr2Ypa28pEgKht5WFDIxxSGWoPKgN5kY1IOYxYw
         iA8FPel2xRU5it4rmmtukyT1JzcMYcLKisdcddZgG/HDWK9jz3plB6SC9ZJ+rRJKi+I7
         n2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687449545; x=1690041545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS93xfx9+1ZuPXZHxivij9y+R/j3rtnGXNixI73fQ4k=;
        b=jMHtCHc7I4URkKNOCAwNGwzyVkjVC6h01GMFuLndNGetQ9Oi1QCDHZ0PL0IHkQUP4o
         rsYiBYtqX5KsdKKIJNmRvCR6sd6ANsxyKnRNOGjp+r2QBWZIuSvpMLGfLqvfMuPJylU2
         PC7ILsN0CkO25ivxI1RqWhOrAZIj9dbu6KYdt9HKOtBjLlaOZToMScqj0gXqsVE9iYgM
         RUrKNvngJP7VXUglcAFG2EyxJ4wDe0dHR8nbqgaP1/23BEEsIvgAe0TQoDewt8h55Qqz
         RhPveVO/cfBXAmtTfuX+mK8W3F2aOSJnlSnqiFRJHgXXCmk+zAnLQr+wNXDidzOQutI9
         xJsQ==
X-Gm-Message-State: AC+VfDz/vyCiMTqYo/2/1M4g3wC41pA5hDSoWU2fa7+nW3EBmfJJ+TIt
        ZpqHzFXKJ7DlvLJenPm9RcyvfLkLXIYs26puUrYECbu/FqSa
X-Google-Smtp-Source: ACHHUZ6JUaxY4krH2xhNMjELPgEj8h/TukhnGr2c1l/V3L/ZFNYCa57LJ7h3yzpSIKXzodfvcT+g5Sw3UV0UuHWB7t8=
X-Received: by 2002:a92:da90:0:b0:33c:1e76:c405 with SMTP id
 u16-20020a92da90000000b0033c1e76c405mr9255795iln.31.1687449545461; Thu, 22
 Jun 2023 08:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJf_aa3Xz7t31bzWbvcAkNW=K7Qga_awLuiipE6MSe7Bgv5_Zw@mail.gmail.com>
 <43c88a0d-2f35-4a9f-a6e9-a32360dfe42c@app.fastmail.com>
In-Reply-To: <43c88a0d-2f35-4a9f-a6e9-a32360dfe42c@app.fastmail.com>
From:   Hazem Alrawi <hazemalrawi7@gmail.com>
Date:   Thu, 22 Jun 2023 18:58:54 +0300
Message-ID: <CAJf_aa1WF_fKeb2JJ9CnQiEthx4YE9KD8fuD1Q09aX3n2UbMYQ@mail.gmail.com>
Subject: Re: Newcomer
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I've already gone through this tutorial so please feel free to assign
me any good-first-issues that will help me to explore Git much more
better.

On Mon, Jun 12, 2023 at 10:25=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> Hi
>
> On Mon, Jun 12, 2023, at 04:45, Hazem Alrawi wrote:
> > Hello,
> > My Name is Hazem Alrawi, CS student
> > I want to deep dive into git codebase and begin contributing to open
> > source but I encountered some problems and I have no idea how to solve
> > them, so can you please guide me to fully understand what's going on?
> > here is my prior background
> > -C++
> > -Data structures
> > -Algorithms
> > -OOP
> > I used to solve Problems on different platforms like Codeforces and lee=
tcode
> > Codeforces Handle:HazemRawi
> > LeetCode Username:HazemRawi
> > I've solved more than 1500 problem on different algorithms and DS (You
> > will find them listed on leetcode account)
> > What is the prerequisite I have to learn in order to start fixing bugs
> > and begin contributing to open source projects like git?
>
> Here=E2=80=99s a tutorial: https://git-scm.com/docs/MyFirstContribution
>
> --
> Kristoffer Haugsbakk
