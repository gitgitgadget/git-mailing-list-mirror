Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7204C5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EC921D7F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkj0FdLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgKLQmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgKLQmd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 11:42:33 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0772AC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 08:42:33 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id s8so5911125yba.13
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3QYTU3/P/kaDLmGJxPoIGL0is30+V+TPrwUl9XViplE=;
        b=hkj0FdLtgRzZO0zVgWxSoaIDrwDbd9r0vCQAgtzIGR/P/kZWtSemfHKMBt+Y0tlLNg
         ds6ZHTFqinCFd2cyec3REvkmadUJCAyY4PKK2KnLVDaY4r9iEOejMC/WrMRU0Fy7QFV1
         wbZwWLUD7gwlao9seP9YrH8QmvgfwMfLsKfeigESFEPcSHUDNijc0eciBTABlysDp891
         Nm1J2n14IE7HGdxxIz0V04nx9ig08Cv+sRITFepCpAbmLllEw3VNR9/GxJdR96+I6g90
         5KIy0m+Xmv2bnRfNgBbLmU1MM6rxU8LZGrzbuvyxPZllaL1+oyCbwdh7E72R6ceISHb+
         sELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3QYTU3/P/kaDLmGJxPoIGL0is30+V+TPrwUl9XViplE=;
        b=E1IZ+VkWpuBdYdodClwXjOIAMk2gYUDqtkxgp3jduGpUDm6vqnNPDpItKAiKSpzD+F
         X8bbR0bvGJOzm5P/Hs74ZNStfmh7hbOiNXRhXDk8Z5VdJy1qngy0aNEhPJNs+eQn6NIe
         1QQjZWmZTE+pJpb7cnUsGSP338Z3ydPvt/wjKtKJen5MBlDXHpG4coSyNBmF7QfPb3qt
         TGVzMNbb48zO59pSHiQPDiWo+gzq2SqCHSM4dX0uTQk03ob5IWZsooHIpYtTjMgHZis9
         TqL8t5u0utgZH1ukXOSKd4zPinbAQ0cfH2y1S43KuWp7Rdx+9dYJFQ2lYSAVbal6wk1A
         UEfQ==
X-Gm-Message-State: AOAM5316AEsEn41OJ/veMDa17nN/fwIO13Wmaglt6eiOBMazxmZjEfia
        IbtKGQqy1dBWXoALsmD2ne0tbv6IqCfs/spsBc48GVo+Aso=
X-Google-Smtp-Source: ABdhPJwTjWvBgEsAMBCGe/jXPb1hxMKD+Iom39CR8ZOJboCDwrey65ARBXGKdOsNY6vl6pnebGquC+fDjBXp6Yqc5hg=
X-Received: by 2002:a25:bc82:: with SMTP id e2mr362056ybk.160.1605199352096;
 Thu, 12 Nov 2020 08:42:32 -0800 (PST)
MIME-Version: 1.0
From:   email nans <email.n4n5@gmail.com>
Date:   Thu, 12 Nov 2020 17:42:20 +0100
Message-ID: <CALjz=4x=8dewN_Dx5jH+9M9Wt+g2cvJkxsx8E+a6QGxt1cAHZA@mail.gmail.com>
Subject: Git bash limited to 64 windows
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I wanted to know if this is normal and wanted, if git bash is limited
to 64 windows at the same time.
In theory this is not a problem, it is normal that there are limits
but why there are no explicit error messages.

For example, when I use git bash in Visual Code Studio, it produces
output error '256' but no message like 'Too many Git bash at one
time'.
If we do it from a terminal, we get no message.

From a certain point of view, we can say that it is normal if there is
no error because we could say 'who runs 64 git bash and does not
realize it?'.But in some cases, for example in Visual Code Studio,
there is only a small number that shows how many git bashs are
running.

Here is Visual Code's response to this problem:
https://github.com/microsoft/vscode/issues/109982

If you want to give it a try, here's a command that may come in handy:

for((i=1;i<=40;i++)); do start ./git-bash.exe; done

Thanks for taking the time to read
n4n5
