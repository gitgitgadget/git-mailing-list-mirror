Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC0CD98C7
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 06:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbjJKGHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbjJKGHS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 02:07:18 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4219B
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 23:07:16 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7d532da4bso10763957b3.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 23:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697004436; x=1697609236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UuypEZHM+DjG7/T6b7nOsilMuhjVVjZ26CCOc5Q9ck=;
        b=LhqMg5d9pUCQgH4l/Bf72R2rRz7aRRYb4TQnswMPQcZ4xT53sf56rn+UA36DuVbF3Y
         KIPF4fb4A3S9Y7RBcHjbYkWQl987yjWJ3zmnT835GbQB0mCWUihDXKHQSEbo2lqxtHT+
         AShhvlS2ZTp8W7UsY4aSNa2M+dKHy5Xq31lVUeJEICNiAAt2bh0AdtXrW+wXEVkGcAkf
         sIIhYyUdxqDl7uC1mEb6prj2k/N0Ka00Er3yty3oik2Svr1LdFIAoo2/nGszqcgyI+zx
         0l1SG41lcTh77jYxgTIoNctlZX01KmzzxZwxF6AsAZyKN+hBxzUQpRaCxH8JSWCSOwmx
         N4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697004436; x=1697609236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UuypEZHM+DjG7/T6b7nOsilMuhjVVjZ26CCOc5Q9ck=;
        b=VTWZXwGpGTGu/5YbAO6EBAEFSpR6YT6bq5hk58IpTQausD11xFLQ1RXtblD2fMudYa
         5NIMnHto+ms+yBDZf4jmFUZKNmCyHLduZKODh5wqxy1SAjrjYZ5YZ5SIIWOP/ArnNODO
         xGlDLL02n3acNPCiiww7L8tsiXujZaS+kWqQMKFRI9/bJQD1BQeNiLhDUSp7kUIOLtqC
         X1Qpcf5RyPXCwVslW3aBb5bSZKAB53qsyT459pGEEAzSXEDNN2RfY/iUFpRD/j83aGHL
         kfv7AIqU0CSwHv2etMCmEv4fmwZCJNIvMTcrTg6Sxa/MsK3HIFXoW7E/saA8szp/Bg4f
         SjYA==
X-Gm-Message-State: AOJu0YyGc4I+RG7MvGmy9dekLz+51PeY/FLWfcGlNzGOpDkHnHheyZnn
        JSka2JzR1o9UsAuovqWJpeW19KPx1CbQcAAEGSV3IFwMLcZb6AQ=
X-Google-Smtp-Source: AGHT+IHysnnHhB0kXypBYV0nPu6ne5jt47kckB3G5jizzRN0LC1iIE4oGgatmEaUMPOhAZVIPl4SGP2yCvER+AzOSmQ=
X-Received: by 2002:a25:dbc4:0:b0:d7e:8642:f0b0 with SMTP id
 g187-20020a25dbc4000000b00d7e8642f0b0mr20553400ybf.3.1697004436019; Tue, 10
 Oct 2023 23:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANhBNnvUx=KG2RkkJEamr2KHerXoDrvW2qe5zKq_xiV1t9V92g@mail.gmail.com>
In-Reply-To: <CANhBNnvUx=KG2RkkJEamr2KHerXoDrvW2qe5zKq_xiV1t9V92g@mail.gmail.com>
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Wed, 11 Oct 2023 07:06:59 +0100
Message-ID: <CACS=G2w+_o_85DBrv2vpR6Ym8R7XeijJDbaB1y8a5xkNztyoRA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     Doreen Wanyama <doreenwanyama20@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good morning, I followed this link
https://github.com/gitgitgadget/git/issues?q=3Dis%3Aissue+is%3Aopen+label%3=
A%22good+first+issue%22
We're not expected to pick something too tasking like working on heavy
code fixes, just pick a project you know you can round up and
contribute to. A project that doesn't involve plenty of major code
manipulations. For task submission, you'd need to learn how to
navigate "git format-patch" and "git send-email" commands(If you read
up on these two and their applications and you should be fine), or how
to use GitGitGadget pull requests to send code patches directly to
this mailing list (https://github.com/gitgitgadget/git)

On Mon, Oct 9, 2023 at 7:32=E2=80=AFPM Doreen Wanyama <doreenwanyama20@gmai=
l.com> wrote:
>
> Dear Git community,
>
> I hope you are all doing well. I am writing to show my interest in
> working in the project titled move existing tests to a unit testing
> framework. This is because I have always been intrigued by the work
> the git community does and hence I am interested in being part of
> this. I have gone through the links provided about getting started on
> this. I spent yesterday evening and a better part of today trying to
> understand the resources. As of now I would like to start working on a
> microproject since I understand this is the first step. I am finding
> it difficult though to start. Someone to please help me understand how
> I should go about this or how I should go about finding my first
> microproject. Just a brief explanation will help.
> Thank you in advance.
>
> Best regards,
>
> Doreen Wanyama
