Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F637C433E7
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 09:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB022083B
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 09:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7a7Mcnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgJKJZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 05:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKJZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 05:25:51 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3273AC0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 02:25:51 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y16so9064061ila.7
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DSuU+KR7Xh8NmlI9Kuo3KrtQ50TlxQ7K0ePii5kNG2c=;
        b=M7a7McnhU8OJPvoWDXPfuWccI1JOjun5QBGXH+ueM2+EfuBmZ7JWgOLPSrUsyPhJYt
         e20b01l2A8iaSijRzy/1Uy+MUZjuNazNgV8pwZWmdZLboJj9QVVyulPvTX8pdc23zOU1
         n9wwWqNw/xkYNK189rPlB4H3CB6AoZk6QkmTIrDICCGGJfGndMk61eZKvH1c+PlmUrhm
         i2xkTDdeWavK4uuVCKi9LUoxuI/NUVHeCCJHummEw8XPe8n1YA4GUDN+gAnUPTgqM1iA
         6m6W6T/1ba+rIetyD/kFXo7UiqFMdSB4RC6HUshD5EjRH0NRx/TRNSuaHNuGujCEB3sb
         3n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DSuU+KR7Xh8NmlI9Kuo3KrtQ50TlxQ7K0ePii5kNG2c=;
        b=NJpS24npl+DTaAokgw+ltig4IekyMejrJ1HHDhVp9uqRfFINTBi2Njxf5JK+03bsAB
         VZVEdzAaK/KVs26DtnwfpCrTXtv7+VWURnl2VNfMQ9VRansVjkuwcEF/SWZJo52f2lsy
         gX7YP9fCzNrBCBmb7+YF+e+RrSUHpK09aH2F15SdkaCYnFQizjaRnnCLrBblRauUUW12
         CYzZGqZHxODnKDJpdJkfrOBqgiozmKq8FuJEX6+OT+BiWubHbVDjB0U5q4h2IQS0ujON
         dCOgs3GCriqStZp0f6B0HJP0tSLHAXMvdUOxU7615FSZOISO+tUkJIV6TH7+hEpTsYrH
         MboA==
X-Gm-Message-State: AOAM530ipPMJRLGPBESwCqLZ5+hSNDSftb5lZ/x7VdaQecz/Wuz2Alps
        P3i8imiDham8u7w/YlICBvEWG3IaeiYZxhswCeT/Oo75Bj6m
X-Google-Smtp-Source: ABdhPJy3qTe3StDCUDDCM5DWO0bgTdKbV0GNATpsdF7LHoMiLjCK1NnHZY9meJbJmxac5NIhnWSStZbcSoX4YPPu91Q=
X-Received: by 2002:a92:d742:: with SMTP id e2mr15072615ilq.11.1602408349844;
 Sun, 11 Oct 2020 02:25:49 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Gabriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Date:   Sun, 11 Oct 2020 11:25:38 +0200
Message-ID: <CAA9rTuf4gP5hy2GNubxGmDy_N2R+WoNX99sDUOo-QNym3pB=dQ@mail.gmail.com>
Subject: Git hooks and stdin/stderr/stdout.
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

I have a question regarding git hooks and would have liked to get some
better understanding of how internally a hook is run. Especially I
want to know  what happens under the hood because the behavior kind of
puzzles me. So what I've understood:

When git runs the hook, git does
- connects stdin of the hook process to it (is that always the case?)
- redirects stdout of  the hook process to the stderr of the hook
process. So anything you write to stdout/stderr in the hook process
ends up in the stderr of the git process.

Is that understanding correct? Is there a doc describing this?

Thanks for the help.

BR Gabriel
