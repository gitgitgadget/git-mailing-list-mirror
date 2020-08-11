Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F02C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D362065C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 08:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeNsqa8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgHKILF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgHKILF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 04:11:05 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA9DC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 01:11:04 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p16so9868866ile.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=FFoBzYbsRcSselw1sGnoIGlV+V4u/DmDbs0gJtp+4OM=;
        b=ZeNsqa8dau37Py3EWVXoI5OC5KADCIhIskdXwDrLF7aqrro2dHOvMU8BIensiYEubw
         09ZoldQvqx5ESBCv3nQvY3CdgbQ4Q9AkO5Gatpbwnzz0NnyoYUXk3eMYTCjcGimYfgQ3
         jaz6CSFImv86CPiAK5+ZDe5LwZldJHeOYa1w5SpRYqCX/lStlx17tnb5BYVTpcD8KJvp
         2XallA1o0SzzefkgtU8HKmBJ3WjohzS8GBIqn3mjIsIvw/0/Fc6kqQwiHDVhCdXPmm46
         qDFMCDKtK0mgouBdAw7FJ3hm1/GYqHBC5Ae2x4O24x6Kgr7KrMjJOfbwvn9fdTUj8tpd
         UV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=FFoBzYbsRcSselw1sGnoIGlV+V4u/DmDbs0gJtp+4OM=;
        b=sfq7MO1zGYjLlXPWX6NHLPvUNU5/duQK7TmVaYP8a9lqWRPxm7Z2bUMgJTEcgFM1JG
         qE7HIYTdB4GZUnWUT3cX/eo6Varag4rvkpXPcnEaZzH04zLUtMcO6B4Lfnh3EbxKhawA
         Susck7XRJSiyApXEWD615FvgV0wo2oC07U33yKALYKusfA8ZJM+KfhCy+VhlYdB3WRm7
         Fx6YXY1Fs4SrZ1Kl2CIta7ONJSs9ESbvTAgi9fajX+Tl3NKVwyI8MnQjYtBhcqszpJiZ
         s24uWxJmMe14JmRnRGjb+XN8y6evUeIR65+HsM1ZB7vurJFXyA7HVHkmnZ8yA0/7iLF2
         iijw==
X-Gm-Message-State: AOAM5312HkS06OA548q2WLVR2tJQbGpxXR/2glSAMcjMwXECoumH1DWx
        DDrY4jgPYv80Go9ietEvqCTYUOrCvL4MK1TqYcLNLw==
X-Google-Smtp-Source: ABdhPJwaliaYRrKR9w2kS95pEN2RBVjbwqfN8PFfq7iih8nup+L5vuAV6zbRBPNuNiY7Anz7qQGpzTq8dv6tsBc9Hmc=
X-Received: by 2002:a05:6e02:14cf:: with SMTP id o15mr22036305ilk.239.1597133464095;
 Tue, 11 Aug 2020 01:11:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:9bd8:0:0:0:0:0 with HTTP; Tue, 11 Aug 2020 01:11:03
 -0700 (PDT)
Reply-To: equityloans79@outlook.com
From:   Equity Loan Company <pcho7941@gmail.com>
Date:   Tue, 11 Aug 2020 01:11:03 -0700
Message-ID: <CACj6q5A+EeDHB0EAZmALp90Ai0nAjQ6Ynr6ugCoT_-TWb7HLuQ@mail.gmail.com>
Subject: Loan?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-- 
Hello, I guess you need loan how much do you need & the duration
period you can pay it back to us? thanks. Mr. Green Rodriguez.
