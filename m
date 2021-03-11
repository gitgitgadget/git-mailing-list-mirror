Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1105CC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 04:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D7364F47
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 04:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhCKEHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 23:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCKEGu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 23:06:50 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242AEC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 20:06:50 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bm21so43378249ejb.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 20:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yn9JVaq9qmJFOwDUd5ioHdlXoe3IFUsOgCoVmlQrj/U=;
        b=BIPcZreQHL69dYzYXG6IlgmtjQJdR+5lqWIDmAHhNnbHRGsOcQhS9DX1xD4wjTubTS
         JeJUbiSk8JtpOKKbUh5xUKidXDtboEj7epN1/EW7xxw6aL+CDuEEX3ffMmtzgSMrMq+N
         JKB3/eow5oIv8MgngpDskdWVCLSz3mUV00pU1Cf4MigqOWvEmGQEEG3bg5DiEjbyALsJ
         Is/b5IyimR8P/suVPF0P+R8LhXR5pnOV/d5YCJOeTQo+j45w4/BjdlslDaqCGizxHHZH
         Ohm9Z45fth6/MUURWVAqaBy5liIOBvrzHgbiQVTokOCH4VFv3pljNodl43sWYGh0l7O/
         6uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yn9JVaq9qmJFOwDUd5ioHdlXoe3IFUsOgCoVmlQrj/U=;
        b=bCVE3qc0jgMQBPG38sFcCE0qhtrFhZlNwdgWnpLDJqNOmKGOH+6FcaP7fV+BDogKeQ
         9REQ9AicNJa41tyrGBw7rYNyG7oMvoAT6eNQ32mjcaLP7/0qHNaDV1k2HkzsTfaYJAcd
         Oa6JPv19+247ZWD9tCa3K1hRcIhMmFOz8BWdpZKVi0NyhM8OxtcVHBtzOYsfcL2rrBLr
         ydgDBxffjAC9Qzg8bjXXt/V3dS3/H++rixXZHFH1jBua+MJrzjJ6JG5GJBEjUZjsIMG6
         X/aTOJ6SH//gqrGW37NLxJ2Oy32rrPfXkb3nVMpSbdv/Up4uwwQJbD270+IlUzxh6fVu
         k/aA==
X-Gm-Message-State: AOAM533hfwmp1PqfcT9WSmJAhM2VF6bAeiMaToJkRNvLq1GZj9L4Tn/f
        Tw123BAox5eyxaqjc+I/alqxau2ZrR23KRrDkaQ=
X-Google-Smtp-Source: ABdhPJyKdCfXYt2jpS9hdM5Km4cmaN5A+NCznRTKn0ZPYphG5RVAJpKlS2WEP+N9ByTNYfPHgoZex/AVH/A6HvjadCY=
X-Received: by 2002:a17:906:5849:: with SMTP id h9mr1118446ejs.551.1615435608882;
 Wed, 10 Mar 2021 20:06:48 -0800 (PST)
MIME-Version: 1.0
References: <CAFufNaq=FCfvBGBhnjatdn1KUoQYV=Y2zOWWMFWwDLwTR-ujrw@mail.gmail.com>
In-Reply-To: <CAFufNaq=FCfvBGBhnjatdn1KUoQYV=Y2zOWWMFWwDLwTR-ujrw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 11 Mar 2021 05:06:37 +0100
Message-ID: <CAP8UFD0rKtx8R1jYe+_fjJq5FDKLnkvpt_+BAPUQ2VxaU_JyUA@mail.gmail.com>
Subject: Re: GSoC'21@git project application
To:     Krushnal Patel <krushnalpatel11@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Krushnal,

On Wed, Mar 10, 2021 at 8:08 PM Krushnal Patel
<krushnalpatel11@gmail.com> wrote:

> I am Krushnal, a 2-nd year Computer Engineering and GSoC'21 aspirant.
> I was going through the organizations and git caught my eye. I was
> really impressed by gt as it is due to its daily use but after seeing
> it listed in GSoC'21 I specifically want to focus on applying to git.

Great!

> The project which I look forward to contributing is the git submodules
> conversion from bash to C.
> I would like to have a discussion on this project with either of the
> mentors Christian Couder or Shaurya Shukla regarding the next
> procedure for the selection process. C/C++ being my primary language
> and being decently proficient at bash, this project is perfect for me.
> I am ready to work on any pre-requisites required for the selection
> process

You might want to read the following pages:

https://git.github.io/General-Application-Information/
https://git.github.io/General-Microproject-Information/

At one point we will likely have a specific page that lists
micro-projects, but it's better if you can find one by yourself and
start working on it as soon as possible.

You can have discussions with us on this mailing list. Public
discussions make sure we don't favor anyone and we don't repeat
ourselves too much.

Best,
Christian.
