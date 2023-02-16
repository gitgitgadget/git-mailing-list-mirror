Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9825C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 19:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBPTQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBPTQt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 14:16:49 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AF24ECDC
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 11:16:48 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y4-20020a17090a2b4400b002310ecae757so3261281pjc.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 11:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y8kAn3tFg2O4a0PCAYe+SLUXQAzOXtkxhXTjilvnjM8=;
        b=j/uE7cbqN3yPBAUCzlS5brt+mTigzwjuzpKxRjjS3dHrxwKTF/gqgXhjOsr/a4I5oJ
         4zGs+dXC+3m5rxLSP7M3GiRtM/ZamBzd4NUZUiJu/RQYGJr70NNcz77OZpcQUYH4PSZG
         o45RgQc+OnqyV06rwVcSIIDz5M58mKw1fdEuY4+vgmk7d8Jz3g+kgM3N9aCvzGwh/mmd
         ru3+GF64LW2WYN/Psuw2BSX5KoM0bly9yEnd7AZFALd7NTLaan3Ssix4qitEOJxx3z6Y
         3fqyktqUIs+4sHnbpd/iVwjDPEXKefhMCXFVK26wikb8C/F6e5ivcehFe/Itzu99rXec
         MnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8kAn3tFg2O4a0PCAYe+SLUXQAzOXtkxhXTjilvnjM8=;
        b=WNBgDH8GM+fkX5TVNiR1kH4epVUSrUWWePoAxuPrOAGYDbbYZRKL8h0qqN5TbHw75C
         hu5mxMxtp9h4G+LzbdD5B8VnCrshBruL3O7zU3uZ+evQ54UTtYXfMV1Ul7GRrYsuEUqC
         fAMJEMwa5qdpA9uRdCO+1QYPQmFO2rK83M/BXag47wZ4LRnPPIPBIToFsPYLA+oMXMqd
         ZfWdA3gvAX3SMOlSrmnasJ9l8YOKiIj9DkIVyXyaeZJcFkBy89XUm78JK9TDA/KA6HUy
         OM2e1Aghpj85IZEnw/6JM/IE0DRNN8YbuaxEf3il0YjhSb4saDYCTOpzUHQa4L0YJY8k
         oGnA==
X-Gm-Message-State: AO0yUKWVJlx6pg8RDdsFihL4VtB7PTdmHoVzQGeNPn+LEJX3073sMxVB
        bzwe1xTbwlOG728jwzihLlaOIqwCxd+1stk=
X-Google-Smtp-Source: AK7set9Ohf53pKjQ9yqXS03knYeR7MegcTllQOvIFZp9Vuf9oD8fQhlt/tteDs6DW6CQhYSgGGqaFmIi1WOiMVg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:3c42:0:b0:4fc:27c2:840d with SMTP id
 i2-20020a633c42000000b004fc27c2840dmr185825pgn.12.1676575007604; Thu, 16 Feb
 2023 11:16:47 -0800 (PST)
Date:   Thu, 16 Feb 2023 19:16:43 +0000
In-Reply-To: <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230216191644.315615-1-calvinwan@google.com>
Subject: Re: [PATCH v3] credential: new attribute password_expiry_utc
From:   Calvin Wan <calvinwan@google.com>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  static int run_credential_helper(struct credential *c,
> @@ -342,6 +352,10 @@ void credential_fill(struct credential *c)
>  
>  	for (i = 0; i < c->helpers.nr; i++) {
>  		credential_do(c, c->helpers.items[i].string, "get");
> +		if (c->password_expiry_utc < time(NULL)) {
> +			FREE_AND_NULL(c->password);
> +			c->password_expiry_utc = TIME_MAX;
> +		}
>  		if (c->username && c->password)
>  			return;
>  		if (c->quit)

I see you null out c->password in the expiry if block so that the
following c->password check in the following if statement fails.
While I think it's neat little trick, I wonder if others on list
think it's better to be more explicit with how the logic should
work (eg. adding the c->passowrd_expiry_utc check as an inner
block inside of the c->username && c->password block).
