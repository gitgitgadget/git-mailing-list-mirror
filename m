Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DEC2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 22:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBFD20B1F
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 22:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmW0DOlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgDQWJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbgDQWJe (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 18:09:34 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94988C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 15:09:34 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so2336153edv.8
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI3LY2dRYFUFR9Ne/JRF/HJqI59WF3e/JNSraYT1PhM=;
        b=GmW0DOlXXEdihH+iKnd1hRhGm+AAomlEgwPc6C5soPimyE6YybZQtLXnR4VJOYJvlA
         QtE9iMV5iUTUJecojM5UBy1HMvzyBbohHIaHba5yLn4uxaitruiUIWvRklWzgcBhmF30
         peueQ5A8v5tvuQmMqNZPJ7S6e4iXRpftD0BPXVmHZAuuX1khqCmILvQsTKH8f6DvUqkR
         PCPhyI9XJEC7fjRajbVTzI3LLb/OALPkgYVYoHBcqQiYafd+Zi7hvfHb3Jk4krgQwSjn
         nJgHBE4uQDzh53ggGc4V9DpIQpeBY6tw9p3Vqm8Rha7f850F0TLz7YNsFq58TFpF6lR3
         w8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI3LY2dRYFUFR9Ne/JRF/HJqI59WF3e/JNSraYT1PhM=;
        b=DWITj+HDA9jUS0HhjGfnC+HnF83lLWsHSNMxmcb0kLBIoo/PfMeMIQ/o3pGW6CVDbb
         TnLqtDzboaM6cGHpS6mSmJjBG67JKZvU2HnM96KGxi8h5zy4rS9g13yT5KM+S9xFEeqY
         D6fT8/AsCtCpWUATgkZlJXleVbpd8JSi9hnh/jZBDKy14HLkadKAQWzqcmztUrijmas3
         YVCvZFvS/BtIcZGks7nO19fXPDiVx7fazFQHLS8CjMLV0/bECoT3UCzDpyhzEejC4TjR
         ghZdYbTKwsJ8yhfG7Ie5epNKmkQAlswDqM+piW48hRNaI6zo5CIQVyosChQQU58k5OUv
         /izQ==
X-Gm-Message-State: AGi0PuaCpDK6sSpt33gKTptCVeVev9/Z3Vmu+75Slb8ViWVKOHOzYEm+
        i5402ovUCAbwj1kstw7WU91PKCqXwiYhojc2Ph8=
X-Google-Smtp-Source: APiQypKopTPdZFKL/V3G/+GGqjIanyCIpZ5rlvKUh0aY1ldUeKy1rbyh+1Et+3vfElkP9Idwwrlg57cvEpCy/3SkKyA=
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr4941082edm.87.1587161373250;
 Fri, 17 Apr 2020 15:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 18 Apr 2020 00:09:21 +0200
Message-ID: <CAP8UFD1y7D_gSharBE9+CVyQKg3qhXMvtzBjkdYA1Aj3hocBMg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] submodule: port 'set-url' from shell to C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Heba Waly <heba.waly@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Apr 16, 2020 at 11:05 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:

> This is my very first attempt at the conversion of subcommand 'set-url' from shell
> to C, thus making the subcommand a builtin.
>
> I have based my conversion by looking at the way other subcommands have been implemented
> in 'submodule--helper.c' as well as the subcommand 'set-url' in 'remote.c'. The approach
> I have taken is as follows:
>
> 1. Create a helper function 'update_url_in_gitmodules()' in 'submodule.c'
>    to update the URL of an entry in '.gitmodules'.

We usually don't add a function that is unused in the commit that adds it.

> 2. Port the function 'cmd_set_url()' in 'git-submodule.sh' to 'module_set_url()'
>    in 'submodule--helper.c'.

So it seems to me that you could squash the two commits into one.

Thanks,
Christian.
