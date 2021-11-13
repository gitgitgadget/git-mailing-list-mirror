Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3384DC433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 10:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0957C610A0
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 10:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhKMKos (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 05:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhKMKor (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 05:44:47 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA7C061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 02:41:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so7752957pjb.1
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=eNOOlTjVVAw3wwsjWIHNEDiHuZGcxhtycmYUjrl+oAk=;
        b=eLPPobUowicSwg4ijs627fxysh++cv73cFd8eq08i2hpYcWKNOCtXoyGk7yKaLSuBX
         GlJk/BSYog7Y8QiZz8XXb4lF+aUpFUd9by78s6AfoXByC6zqP3HWZKozx34FrnLGJrrV
         PYA80ynDiRSaJTwKW3CXH9UOKn0k/Inceko+2q/xghCAsSZ/tKnGq1PC++UXQVWeWuIL
         gfbf4snpvBKLI6m5oS7QEESF+NP1y5xfcLPNj0oHlHUlJXomW3mH76RgdzhorNyAAvV+
         7WFctZpVWWoL6TdH98EH+qDys9j57P6U769LHRmiLlaWfhekL4ECT2qUHN/JpV47ILmp
         Q8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eNOOlTjVVAw3wwsjWIHNEDiHuZGcxhtycmYUjrl+oAk=;
        b=aFAVk74PnMdOsDlbxlk/mQBeeVidRJvFSe6RVCnPK0znzCZdvT/wHb+1xSCWLFDX9/
         gWKLBmmku8js+LLGm/5q+sO7nY09vxcKFIOHZUIRSQpeB8n1mZKLLMfgp3OWK2/X1dQw
         nk+c1LkQMM2Q4+1zFxCBNcr1Xk+O09ZY/KB0GO8NLIi85QxSmDnIADU/Wfpy8D4LLp4R
         Ukw7YrJT9AHB2Mt1vL8/XJ1u2CPRNduDJwW1i7UdjZgcpRGA4XDLxAdf4eguqWbQ+ytD
         wbmf+uoXZ2TtXzut0HAvRifJmgkjQnqMhh5olxfcwhzZLuNK13nCYm80jbSawqLXFx90
         nRng==
X-Gm-Message-State: AOAM530xTa1COFdlZh8PSWIrqYEVI82H1FGmTI6GW1VPWYV3pvPmniTL
        eFxuNZlzTBSpAX7J6ohR37vQglrqtktJRg==
X-Google-Smtp-Source: ABdhPJxvpSrt/7SlhOPjIjxizuYmUKhDxNEc1XWZavI394JqLYwj/IcaX0aFDxaEmJdASmOu0YEq5A==
X-Received: by 2002:a17:902:b08a:b0:142:51be:57e2 with SMTP id p10-20020a170902b08a00b0014251be57e2mr16032596plr.53.1636800115289;
        Sat, 13 Nov 2021 02:41:55 -0800 (PST)
Received: from ?IPV6:2405:201:4018:300c:9885:5ab1:360a:7fbf? ([2405:201:4018:300c:9885:5ab1:360a:7fbf])
        by smtp.gmail.com with ESMTPSA id k20sm9682757pfc.83.2021.11.13.02.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 02:41:54 -0800 (PST)
Message-ID: <547972d2-36fe-4acd-b9fa-747320addfa6@gmail.com>
Date:   Sat, 13 Nov 2021 16:11:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Anything I can contribute?
Content-Language: en-IN
To:     Deng Kaisheng <kaisheng.deng@u.nus.edu>, git@vger.kernel.org
References: <AF2AC77C-EA0B-468B-9B31-24CCC3DF70A3@u.nus.edu>
From:   Saksham Mittal <gotlouemail@gmail.com>
In-Reply-To: <AF2AC77C-EA0B-468B-9B31-24CCC3DF70A3@u.nus.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My name is Saksham Mittal, and I am about to enter university. I have
experience with Linux, MySQL, Python and have learnt C as well. I would
also like to contribute to git as well. I have spent the past week
trying to look through the source code and am going over the
documentation as well.

I am also quite eager to pick up some bugs and try my hand at fixing
them. However, I am finding it difficult to find bugs people have reported.

Most searches of the mailing list for "[BUG]", "bug" etc. yield scores
of results for patches other people have already submitted, which are
likely being looked over by experienced maintainers anyway. How do we
find issues in the mailing list, especially ones that are better suited
to a beginner?

Cheers,
Saksham
