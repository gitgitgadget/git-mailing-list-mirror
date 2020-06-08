Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6A7C433E2
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814B8206C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzSD8Iyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgFHXOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbgFHXOO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EBBC08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 16:14:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o4so5227098ybp.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DVeyhaDZslU8hWra428cEWcISDNTbX+uU0nla65JDU=;
        b=WzSD8IyzkNJ5u9G5JBq6kWfvZbuCwNcXEMEgR5duHhIqVgvgBdagmqr/YRTRzjt2VP
         hmKXYGEKmEpnAPb7cznux9WWtX9hUo2GzI9AxniFPnBo6dBlpLFesRklLzNkkSmejZnY
         H/5NlQ2GmNdjh6FcxocbWADKJTfThP1qEJVuO/5RolXND2TnLWumYKf1hDyadbbCqugY
         sHVfmNGy2lerdlRwlRN2Q6kRaFfLyPEWAkgUjdIwGH/JjmN9LKHfEXkUqvQaYoKFFdt6
         7sFf4pvvxWTYmnoyAbFhFOg/+n5ICT04hUvk956L+l5TynRpK97aM9Bfu9WUPam2Kw+s
         Lq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DVeyhaDZslU8hWra428cEWcISDNTbX+uU0nla65JDU=;
        b=IMRDLX2lmYrSVb/RQJTU1B8bnWoxLp6p+KV/2xEYRR0HnSm+63SSHA4yf8puPqnVvS
         3TintXY5V2yEMFWjT1FiDFdZzjGevXhtDfjCGEkfO7gKfgtOp8Z+6OAjuR1dMiT4PKyp
         PX7UJ+d532noeUXgestrNQW3hb8kS00j8dG/EEBu0EATD89NfWSoZw2e2xoYo5RPmOAs
         R182DZF0Z1N2cVMb+LyKIh4r/7kih6RSPjxjPhfCBlHUv5mAuUASpiDot/yc55I9FBLU
         BjOIIKxUokmV/y9236SIATcsDMbF24OnDCM1EWHhnPyXe/ePFOLAoYNJvr8+WZamuGvN
         AecA==
X-Gm-Message-State: AOAM531Pif9vElL+sj/QnNAbxVHUm8b6trtFqFqu1dri87YRCSM5k92V
        65A/2VLrmq24p3Y01ORoLcegYEs2i7B8whSE3+A=
X-Google-Smtp-Source: ABdhPJyEk0cOcOl4p8hUtz7ufKFUPMS6yQiq1fTap7a7Bah7tqreuP8i0GUsIU0prhYaeLY9YKfiajcgU0YkjS0JZUY=
X-Received: by 2002:a25:5804:: with SMTP id m4mr1779801ybb.488.1591658053441;
 Mon, 08 Jun 2020 16:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAAXzdLXt4+-34+OhS=Jn=-VeORN3Y2jMzzg9+bhyn88aN4hm0A@mail.gmail.com>
 <20200605000039.GB6569@camp.crustytoothpaste.net> <CAAXzdLVk3jLzuB2vgKGObQDjPydpdiawKJJ+-NMa376Gu1zt1A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2006081935530.482@ZVAVAG-DN14RQO.ybpnyqbznva>
In-Reply-To: <nycvar.QRO.7.76.6.2006081935530.482@ZVAVAG-DN14RQO.ybpnyqbznva>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Mon, 8 Jun 2020 18:14:05 -0500
Message-ID: <CAAXzdLVmuONmow6cB-kko8-CkP2sA=UfpPBkiXqSCuTacGsFWA@mail.gmail.com>
Subject: Re: Change Native Windows shell
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 8, 2020 at 5:46 PM Johannes Schindelin wrote:
> That assumes that PowerShell is installed, which is not guaranteed,
> either.
>
> Besides, quoting rules are most likely different with PowerShell than what
> Git assumes, so you will have to take care of that, too.
>
> Finally, there are plenty of tips out there in the internet that simply
> expect a POSIX shell to execute those script snippets. Any user would be
> completely (and unnnecessarily) puzzled if those snippets won't work with
> their Git for Windows.
>
> In short: it would be unwise for me to accept this change into Git for
> Windows, at least as-is.

I found a workaround. It seems as long as PAGER or similar is not get, then
Git just tries to call `less.exe`. I didnt realize when I first posted this,
but native Windows Less is available:

https://github.com/jftuga/less-Windows/releases

So I am just bundling that with my Windows native Git:

https://github.com/nu8/gulf/releases
