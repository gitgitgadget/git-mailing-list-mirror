Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A76C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6682320708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cecvOQY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgA3Wgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:36:55 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39592 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgA3Wgz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:36:55 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so1956504pjr.4
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YalUsbI98AZNhfgvzHA5kR6evW0Z+MwdN7hNBd7XXyc=;
        b=cecvOQY7VoVkfnvJX6Dt6rPXnKyp8vVLVeKgVsciRgtUu+8WxKMKH1mC2v2ObRxghQ
         Bp4+bgYxLtxSJYXc9lrYrzO5dqzIxGKZX+OOjb8Ws/RWElNnIP5pTBG9Q8WpUpGudoD3
         V6s9+VHFmW/wwugfM4jTU0PpPbsgiFEjUbDvklXzUr8/yZNjakuMKlU39jRCC/Dt5MMh
         FxcYS8lrlY4jtY6T0eOG1YNEOL6Kka4gO4HNi+rlYGe3smWF9wCwTG6bdR5PKnY8UFV7
         usSi6+GaHnNrPv/CH0lGCsGWzCu8dD10CSBgoouN9A4iMjDraycTiLDGcCDJmK1x3fmG
         L+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YalUsbI98AZNhfgvzHA5kR6evW0Z+MwdN7hNBd7XXyc=;
        b=Pc2YyT6Q9SREioH6IppW2pYflz8+OVdB1RgjPeLmor21XzD+p+oQsj2mDKBJIxNq1M
         9zvGuEQ0qP4oTb6AT4Of2S6VXsgyJLE9Dig7p/4BwuF3ShBVr+J+nJ3Yv5pLRB8inT7b
         gS6HJrbDdnTqFTia8LsWxkdaXaPZ9A2ZKBVz6vUSPfqMgxDB43Q9fPVaO4SiUa+3aUME
         i/ecjQCAXnEfWwN343qVrzJB0LoSKcrwp07LYJbnSNuP33wguyritjNac7JcYFXewXT4
         y9DsRWyrozZMbgBqScEkK353K+CJOf3WJRAxJbcXzE7YLl2ROriDIR+yzDTDytVF9LW/
         VGBQ==
X-Gm-Message-State: APjAAAXvtfYVER/LdTO+ipuVKN/tPituObHB2tRigvIJthhUSrctASFv
        RYkZE5v576TgiAhrqi/6pRTt3EDyq6Sc0cIQ8zVCcA==
X-Google-Smtp-Source: APXvYqxKHiIGcFC6qpLw71PVVp512py+SF2rm5CBBXm9KZJf154n9beJvjxKw8CwQtUZE+AEv/i2vh2mr7gVDVa4Kpw=
X-Received: by 2002:a17:902:ba93:: with SMTP id k19mr2691322pls.197.1580423814755;
 Thu, 30 Jan 2020 14:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-11-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-11-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:36:43 +0100
Message-ID: <CAN0heSr3WTtGh=gWTiXYEoSGGHPF_YniA9xH989=OtYfM2-Evw@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] bugreport: add config values from safelist
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> --- a/Makefile
> +++ b/Makefile
> @@ -2465,7 +2465,7 @@ endif
>  git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>
> -git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
> +git-bugreport$X: bugreport-config-safelist.h bugreport.o GIT-LDFLAGS $(GITLIBS)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>                 $(LIBS)

Haven't looked at this patch at all, except I've noticed that something
is up with the dependencies. I think bugreport.o needs to depend on
bugreport-config-safelist.h. As it is, the latter may or may not be
available as bugreport.o is built. (Reproduces fairly well for me with
something like `make clean && make -j16`.)

I'll try to continue tomorrow. :-)


Martin
