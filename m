Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B452CC2D0E4
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 00:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B0221E9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 00:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSByfywJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgKMALz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 19:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMALy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 19:11:54 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFF1C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 16:11:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so652128wrt.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 16:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qq4BsgvxROnJ1lIRCxtq5BlMNScmKtRdMA8I9EJPK0w=;
        b=CSByfywJIWV1B5MBT0ayuZHkgbdkrM1FeO+5pBgGYRabwd0lvXfQSVJES95eygbJc6
         zVwBmAaC4c0IHKPutJhU9bKIUmNM5QWiCnPigulTuZgX6vkRMWwK2h8GxohShglTXsVE
         1OjWerXBPMT5Zon0xff0WcoAWGssdTyAvkOMtmPAjA9JCHirJvXyovIfPEy6NxSPL+U2
         thKhfQhlv1W2VAPRZMCmZ41LK+UGG0dmSWzqTOE/oAU/PmupvzIhsIUR7shisURtVgz5
         r51V51ndWUdzzUpf2crlev9R2DEj752vEmsWxnWXPV6jUh8xjIMAqhfmRkS2uG2PfHTp
         9b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qq4BsgvxROnJ1lIRCxtq5BlMNScmKtRdMA8I9EJPK0w=;
        b=CmakUNA39DOGAES2OP4WWwJ76h1DS3Tp1vmJ07SE6dSQ9do5uz9MKacKC/6kr/iIDE
         idrgsk8ZQi1N+Y/M2xuq/U5ZqI8jXMk5nr0ayw6F6+ag49a1LVlu/Tk31t/se/D9zFEF
         ImzfE82Jx3iM7Q6qUMNDPZhvQ+0UYXUi9piOt4yD8wOjRDoPgFBFbF7GClofgUIsGv4J
         Rr6rfEnBRk7AA9fAgU+J02NmI4VuKgE3YMNyvIvuAQ32SE0xUPxKYl50+GhvrN8O3cYv
         cG3Q4eHSIkXFWHI/Lh9lRjTJXaKxv/H0Je4u72PSWzeWH+wvHHi9AXkzD2Lpd3RjDS9B
         DCPA==
X-Gm-Message-State: AOAM533wFgdUa1xAukJ230ShMT2JyFtHir+gOKB6sT9vm7ZCGGvi5IA6
        nDiyo6Anv7cFFjGIYs2PLDPc7WB2gt23hacKcPA=
X-Google-Smtp-Source: ABdhPJz5rTUSCsDuc4bI8CH3Upf8RL7MmC0otoCBvX2B2iY85X4KUJ1nM633TmQktU1BWxA/9QK6pZFcWXagOenMCss=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr2361838wrr.319.1605226313329;
 Thu, 12 Nov 2020 16:11:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 12 Nov 2020 18:11:42 -0600
Message-ID: <CAMP44s3DExJ-F=MKhKyupr5M0RDvr8kJzxXbWeNzNjUN1bzXUA@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 5:55 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> This is the big one. This changes the default of init.defaultBranch to main,
> reflecting what many open source projects already did (which was followed by
> GitHub, Azure Repos and others).

I want to plant a big red flag here for the record.

I am against this change.

At the very least in the manner it is being made. I started a separate
thread [1] explaining the reasoning.

In addition to the manner--which I argue in that other thread should
be done for Git 3.0--I also object to the reasoning behind the change.

Let me know if you would rather hear my arguments against the
reasoning here, or in the other thread.

Cheers.

[1] https://lore.kernel.org/git/CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com/

-- 
Felipe Contreras
