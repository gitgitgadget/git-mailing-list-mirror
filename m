Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D76C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041112098B
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgnVcZ89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgDVSyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgDVSyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 14:54:44 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B4C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:54:44 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 19so3569281ioz.10
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6OKkTyiLxMuxr3/YB9jzFwYw/DqbWn48gULVguikgQ=;
        b=CgnVcZ89ekpJ+Ih4CsmJVzSvwQJ78D3P55dPBQxFmWDswD9tojUi6pTlWXtGV8ikcG
         phWh22+yp2YemdyVE0/fLr3z5Dba2bNQpNeW9KFXmALKcKZXDIkpKd9ETc3Nflz50KKb
         EQ4tg46Uka1LZFPLVuF1/sPERFEvjLsLqDv9NuzYB2NK7wmskTlJrFogJBoyQE3xXIgH
         ggdR3tAM5L1EOCQ7u7+lc79DG8/7TUWhTQckzpWkE7Iv5Gum3VLrNYD1PVzwfyAhHwar
         uwwSFUD+HlwpAqhLDk5RyItLFsItDL/8HDIXJY9WV2ZOUSQUI+URZI7jBLa/h0IFXjyJ
         PINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6OKkTyiLxMuxr3/YB9jzFwYw/DqbWn48gULVguikgQ=;
        b=m9OzZ5X0CdZMqBbPWZzClKPXy0aUxs5ZX9lUY7l5oeg9jXMJHH6OB7mye91MS8/cHI
         QFyr7ULS9XugVox5+0IWzqBB/OOv2c6IWv3mUQZLrU688tfagJ9UvSStIAYgTmRALKGD
         aQje2hKnoL9kseV5qQrVIx+yt7eS12FK5O+rmRLJEPILZ7xYlx0GY2nlcCiswivSdYIl
         l0crbxhF2QhGDLnS78Bz6nyakpqiq/m3UXoGGKNxG6wqJNosFtleOdzrkJT1coKf0y8H
         dQmGEJUA4h94n7XKi1JPN/hgygQeFk+35lBZ1DdBQJDyY4hC1dNSoadgNoSQ55GHr3/U
         4tvQ==
X-Gm-Message-State: AGi0Puby9O75C9kU8hcC83zfXBANm9uwC3l8YWwLqR+shJ5Vz+AbK6eY
        +8nehgd9uT3PxM4iInhzNiK+2UtCzfJ9EzLWX8Q=
X-Google-Smtp-Source: APiQypKQIL3heGH65d0+8WaL0rYWI+BuulrByZsSSjQSZ1yTtBEgQPDJ8qBbzBJAcfoU0DfDiV/hqceR4vbG1CU+R+g=
X-Received: by 2002:a5d:9648:: with SMTP id d8mr116419ios.115.1587581683793;
 Wed, 22 Apr 2020 11:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200422153347.40018-1-jrtc27@jrtc27.com> <20200422164150.GA140314@google.com>
 <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
In-Reply-To: <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 22 Apr 2020 11:54:31 -0700
Message-ID: <CA+sFfMdPDuZze76OnwPDm7VjcvSu-nW03+kthHM4trs5KRJ6SQ@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for GNU/Hurd
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 11:48 AM Brandon Casey <drafnel@gmail.com> wrote:

> I just wrote a test program and tested on Linux, Darwin, and Windows.
> Linux and Darwin both succeed to fopen() a directory and fail to
> fread() it, as expected. Windows fails to fopen() a directory.

I just want to be clear here, so based on the above, Linux and Darwin
should _not_ need to have FREAD_READS_DIRECTORIES set.

Windows, as always, is a stickier subject. Based on the above, Windows
should not need FREAD_READS_DIRECTORIES either. It's not set when MSVC
is the compiler, but it is set for cygwin.

-Brandon
