Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766EFC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 18:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E3B20714
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 18:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQLF0KLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDYSLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 14:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbgDYSLc (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 14:11:32 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1EFC09B04D
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 11:11:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 23so8919677qkf.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oeh24Bfue4agnCZa0c1y+z9h23/DJtYEM5avj8Jrr5Y=;
        b=EQLF0KLaVoBz68E0/NJPTInMmv5vY9/IJHFXShrDVXeNtE8LBUj8gRI5GRdKLst4Oc
         vdCnO5nLRz/jbxQhYMQXE1PkiND1ivgh6XDXRW4BmeiVx4axqmF33R3llv1s1lgEA0tT
         6G7s2PmpyZQ9HlAWkrUTfeSuHZiJRJGHW/z3vTjSpnHpVBriaHzerMgZa0H7Jq9QpBvh
         C4YwjPkbhJqzizMJFxMyHC9ji+4U0tpvjqKePvZY/LA+DIbbIkjyozR7VApkijaJIcdM
         wGD6cEC5ZYMi0WvcPgq/b7zozE78xuRj42WMB1C4elK5QDPytSl8mmxhh7+9tH0lEdmu
         eAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oeh24Bfue4agnCZa0c1y+z9h23/DJtYEM5avj8Jrr5Y=;
        b=B0QUV7uOnBW76MNRiUlC3hI5NLA7KAFMG5Qo3htPS7XdbhLxbKZGUAYGZs85F+yJdj
         0Pe0HpUMcpO26QBH99Op/2CRj9utFLmOaT5MNuWjixUJ8botIhOa+WYIAPhblZ8T+yZ9
         Iz5USYS6buwJCmFTPumBOna4+WD842MHhGDJR+DDKXbgsTSQ4sMc6rtN5/uyOtkyW/sl
         ePz5zB+/kk/UksvED2VRy7yyMDtL4oqWRD2JgCMcy+RDJ/J0+hQibfqRCU9+//TR5ZMT
         6oswqWnhVYm7Bp1ckn7aqurUXtttuuUDePSXxGTfwNPrENdtfDe7IqT/v0hX//k2l2k7
         U54A==
X-Gm-Message-State: AGi0PubjWv6+nHHDMnIFBZi9takjMOD/BdxkjP+T/VNve5h/OS96d5kd
        A4bWjjlHG0XTkHeoV6JRoQR1Lz9BpbdtL9ccdb9KuA==
X-Google-Smtp-Source: APiQypJqTFcylygalL8yPe+qjJgr9ZrTwCJOyxVHFp5ImbXd5K1bOTZiLUYpBL4WX3z8q2TzIPRYNsXCiOKQawxXF7w=
X-Received: by 2002:ae9:dc46:: with SMTP id q67mr14953054qkf.431.1587838290943;
 Sat, 25 Apr 2020 11:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <70ab1f03dd5413256166bf9db47be47b746ea6b1.1587700897.git.gitgitgadget@gmail.com>
 <20200425170740.GA6421@camp.crustytoothpaste.net>
In-Reply-To: <20200425170740.GA6421@camp.crustytoothpaste.net>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 23:41:19 +0530
Message-ID: <CAKiG+9X7o1x2CeRv37BXEsUJHPZ2CYb8XzPyKw-E6doNP93Wgw@mail.gmail.com>
Subject: Re: [PATCH 1/8] Introduce CMake support for configuring Git on Linux
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sat, Apr 25, 2020 at 10:37 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-04-24 at 04:01:30, Sibi Siddharthan via GitGitGadget wrote:
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > new file mode 100644
> > index 00000000000..73703bd321f
> > --- /dev/null
> > +++ b/CMakeLists.txt
> > @@ -0,0 +1,528 @@
> > +#
> > +#    Copyright (c) 2020 Sibi Siddharthan
> > +#
> > +
> > +cmake_minimum_required(VERSION 3.14)
>
> I don't plan a full review of this series, but I wanted to point out
> that this version is newer than what's in Debian 10, so this isn't
> practically buildable on many systems.
>
> If we wanted to add CMake support, even just for Linux and Windows, I'd
> want to see it functional on the latest versions of the major distros,
> at the very least.  Ideally it would function using the system packages
> on all security-supported versions of the major distros, since our
> Makefile does right now.

I know that version 3.14 is asking a lot, but without this version the
script would
have a lot platform specific stuff related to how hard links are created.
Windows -> mklink
Other systems -> ln

This is why this version was chosen.
I would also like to say that this CMake script is not a replacement for
the Makefile.

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

Thank You,
Sibi Siddharthan
