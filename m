Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CCAC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 13:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A0A206D9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 13:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxZIz2hD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgD1No7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgD1No7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 09:44:59 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8143C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 06:44:57 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id o139so11396461ybc.11
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+wfH+1pd0E12XuGxnE+S/Ti3zZqcUWsmk7CkoUBcOX8=;
        b=LxZIz2hDWYG77HT0SO9ZHrSqsYu46OkJE+m/Qzw9xSKiZc8LPXaTxXCv+eSAQV8Fl0
         ZQX0PY24Aa19wgpqcw2otqeYZTKDX8g32mykJl4jcyAdfYQEXiWXX5MP4fNUCtde1Xpa
         tkJqNuMuti06jUw4EcRbcQsZ9G80Zm2cBz6X1kVJ+QgZMiT7GnvnM1Srg8nDdVeS8bUm
         IexPo1otZnOj8SArxt3tSyuPCUAXNHGEQ64YW/VKZzg1uBD0HjPoocE6sMCAqpNktQjM
         rwYhlJvHwxJU6ssfI5M6CBQta1RA+FlpcDh9WS9yi27283Xwx8jBajSzeEMRln3UUJz6
         B6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+wfH+1pd0E12XuGxnE+S/Ti3zZqcUWsmk7CkoUBcOX8=;
        b=pDQsvpgHIw/COb21s9mp2VUO9P7Zu+TlSHmd/AiGqSAEinNmwZ3/GDBQGlvXD+3ckD
         TZTGs8uv4njwJhz2OVdBH/J1hLRykELfesGFCvVtxl41bhjOglUIDlxzcCWPaI7z3dnh
         4DGUozxAGqgE4P6KeYUqFBKxQUxh2Aq8/fzWc+K0ewuFamGa+ZW3qDlQDveSLsH5Xoyn
         SC0l7yCoznCn4OPPJrCHmlnZ10p51Ei4Cf2h8Or2+bo0ioyZ8/nZu3pkek0naHUsEiJt
         tm99dx/IK5slzkH3TrRBJn8HYtD8jBkHIkl7bea2B86vZyW7Q/Vxbro3Wy1tFFMkzgoO
         mYfA==
X-Gm-Message-State: AGi0PuYoRpvJp2K9qZMbrd7kykwKqnnBE+7Hww2lO22NdMCCFKmNaGVk
        /zT3xGF4FiLjv7yBJYedksL37bpOzAAvRD3LEK3OgAuvFso=
X-Google-Smtp-Source: APiQypJ47oaBuL9uUIWI+ZovORkWUGZ0c24PLyIe/+tXM/lzmE8FYIhQCYoLQuWqjnD3mYfKWy3pOVLvIv8x6Z+1inw=
X-Received: by 2002:a25:bb47:: with SMTP id b7mr13681578ybk.200.1588081497020;
 Tue, 28 Apr 2020 06:44:57 -0700 (PDT)
MIME-Version: 1.0
From:   chaya shetty <chaya.s1010@gmail.com>
Date:   Tue, 28 Apr 2020 19:14:46 +0530
Message-ID: <CAM9H1uHoB1AQ_z+qrr2a0BXZpB_c=qg4kXVqB1QcnXyhQkAEBw@mail.gmail.com>
Subject: git svn clone throws Svndiff data contains backward-sliding source
 view error
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

I am trying to migrate my SVN project to git, using simple git svn
clone command. The conversion stops at some revision with error:
 0 [main] perl 2287 cygwin_exception::open_stackdumpfile: Dumping
stack trace to perl.exe.stackdump

So, I tried to resume the migration using git svn fetch. It runs for
few minutes and again stops with the below error:
Svndiff data contains backward-sliding source view: Svndiff has
backwards-sliding source views at C:/Program
Files/Git/mingw64/share/perl5/Git/SVN/Ra.pm line 312.

I searched for the solution almost everywhere and tried every single
thing possible to solve this problem, but no luck.
I thought I would really get some help in solving this issue by
mailing the issue to you.

Thanks in advance!!
The response really matters .

Regards,
Chaya
