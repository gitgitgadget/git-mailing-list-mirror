Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43B2C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7090820720
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C51Dw8lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBFTvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:51:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37964 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFTvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:51:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so2766298plj.5
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWVPECYcivAdzW3sVevetThdmZcUYTU9K3UCRUX4uJA=;
        b=C51Dw8lvHME5TbliwegYbwiiX2aEwe5VTHbSthWxIbBJPCBmmTfk3jpNoWkKw18XwP
         Bh1/t+d+s/RAzGfKWYwh2l9XMucw2xZLvHO3EgxRTXwqoXBLRvqq9tdjLT0VrsmJsbZZ
         C0i9j4PkzJbGhzqRGpMo1FMhgg3L3TompjN7DILcHJ9XBzglc7QOESz/9ahrCRrg5cc8
         0NXSE67VXR3DbFacWZ9VL+7qauEayH6yjj7DcMPybcwgnPezaAadDTpU9E1AvWZsXZQN
         7P04V7imBhX2QJlDxNzIj22b3uTwVWU5w+KJHtZk9R9bVciChYvS4nwrQNRzSrZ1i+/w
         oIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWVPECYcivAdzW3sVevetThdmZcUYTU9K3UCRUX4uJA=;
        b=KF3mDymSiqv3M4gbvf6AK+Ya1UEZ/2p/h+w0uLh6fEqyvWdXkFOvZOYo3doF+4uyzZ
         kHmcbOZp+Dga9UVCOMZfK/4ZTVo4WQhqm9rMSpSewRvZ28vMsYYn25BLccCrJ3W/BFiH
         mXZoKP+Yl5XbM8tyGB+E41WVmGPrAqsgCuARYf6hybkiAeZhiyIps83Lvqh2E4R+Xk9R
         V1FM6DchLeaBc904Nh0BrWYc9V/FHoq1m9OJLSk5klYNum7iYFSH6+tFXQAybDY03Tse
         Cogx9Id4HVb6tGN1F0gGixY99wAyHyzKi/zhbtLgyDP07PfMoj4EF8H4z+4adNkAhOiO
         WQ7A==
X-Gm-Message-State: APjAAAUquBxI7/f9YdhIZYzx3iuJD5/iRCumuJUrTL/ThFj8Pwl25qfr
        WvLsBPT4MMjRNMECmAAqs697eBt0bKSIkZo8/a4=
X-Google-Smtp-Source: APXvYqzzw21FaCWlbG7nnHWMn6LLa23JNwK5A7K15Gk53C7m+/qRKFE34u9Y1djONEyX02b4l86HNyYAiSq9GazmZYs=
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr5706445plq.79.1581018668451;
 Thu, 06 Feb 2020 11:51:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580430057.git.me@ttaylorr.com> <cover.1580862307.git.me@ttaylorr.com>
 <4c6425f0da9a6e5ae86530a12f18959ada07404b.1580862307.git.me@ttaylorr.com>
In-Reply-To: <4c6425f0da9a6e5ae86530a12f18959ada07404b.1580862307.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Feb 2020 20:50:57 +0100
Message-ID: <CAN0heSrRJYc8DoWQ+NHR5LJ1z7d1GGBni2waP0_Lv7gMYjPPEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] builtin/commit-graph.c: support '--input=none'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Feb 2020 at 01:28, Taylor Blau <me@ttaylorr.com> wrote:
> @@ -57,6 +57,12 @@ walking commits starting at all refs. (Cannot be combined with
>  With the `--input=append` option, include all commits that are present
>  in the existing commit-graph file.
>  +
> +With the `--input=none` option, behave as if `--input=append` were
> +given, but do not walk other packs to find additional commits.
> +

Similar to my comment in patch 1/3. Please add a "+" instead of an empty
line. This one actually trips up the rendering quite a bit of a lot of
what follows.

> +If none of the above options are given, then generate the new
> +commit-graph by walking over all pack-indexes.
> ++

This one's good.

Martin
