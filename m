Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24351C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiFWPQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiFWPQS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:16:18 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D2A3A5C7
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:16:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q11so25682811oih.10
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ev7fkRSNWhOny5i8sV/ULVKWBJwssiMoSfbZHf4Av1I=;
        b=chS8/fpuuunQuGQ224Y3QbJoRv5NlHE+VsmxsNgFxeu5/aESGnLnpKWYXlWkShow5o
         qpipmBvGm4GxfSdyZ+RzkhFSI8vJkw4AsZYVPL3Ys8kgXdbXRXJFjsSpMcpDc5dRA1Fs
         Vaad6SLucctxZ9Sr9/XSiOUeSqn2QDh9pZyIhBRtU3DyRGRjqrLAJhw/7HtO76Z2Subt
         x3Al0pY8k8wZnq+GmgPbATkvi1pIvnA2Hb1oyi1hOZDl3878crPI00oDq/b8ERD3zUh5
         /eew1/S4LM/shhcn2jinKpShIeuTnlPf5rPtJJ1GfC+NOq2vL5u1g4Ab0ut1DUqPeagJ
         0upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ev7fkRSNWhOny5i8sV/ULVKWBJwssiMoSfbZHf4Av1I=;
        b=xFHJx5fEGl4qlCBseQLLvbqu89RIbOZa5oZ2RTsKSKEdZm8m7bxv8ojMPSUCLXDF/W
         qT5u6EXskdbEM2j3ohN/gaKt29ulgCsYExRxTtPoZ2Cnub6h3rvnSPxw9YOLve5wPBHE
         dEBzuRfsIh3mxeFtrLoNLipo9rzO6Dm8RZslQWP9pYp3Js8oOSyDCeMAnrOBmVB9eoje
         uhV4gMuMO+ZblgCnUIypfdu5mT2PE5h78JcsKnKEEjYJVh7Fb85mPq5cCbHpB15O00m6
         pAczlG1zzM4KcTEMUK7Bgb794XhDe3lYnhzsRf94QbKlUgQehVaUqQURLPPfYmb1UvFI
         u5dA==
X-Gm-Message-State: AJIora+DqBAjRN1WdfihvNloshB7hoOopcgAcGSkbragj/QWFNuHpExn
        IWOlZbXBR2hSBkyyeZdu7vkI
X-Google-Smtp-Source: AGRyM1vbx/Gg/TIA8wO5lk+J7ygejsFgi/foeLDUHBqCNgltzKIbZBXxGiHVd7vOzzZI9wKCOq482g==
X-Received: by 2002:a05:6808:10c8:b0:335:35ca:4694 with SMTP id s8-20020a05680810c800b0033535ca4694mr742224ois.245.1655997377269;
        Thu, 23 Jun 2022 08:16:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7549:2a5a:7ed5:f864? ([2600:1700:e72:80a0:7549:2a5a:7ed5:f864])
        by smtp.gmail.com with ESMTPSA id m186-20020aca3fc3000000b00328c9e63389sm12868404oia.11.2022.06.23.08.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:16:16 -0700 (PDT)
Message-ID: <4d181d4f-b86c-42f9-eeca-000ec4a06015@github.com>
Date:   Thu, 23 Jun 2022 11:16:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/7] mv: fix out-of-cone file/directory move logic
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2022 7:41 AM, Shaoxuan Yuan wrote:
> ## Changes since WIP v3 ##

It's good to keep the main cover letter body around, even as the version
updates are included. Sometimes reviewers come to a topic late and want
to see the latest version be completely self-contained.
 
After reading all the patches with fresh eyes, I think the code looks
very good. I have a nitpick in a commit message and some recommendations
for additional tests, but otherwise I'm pretty happy with this version.

Thanks,
-Stolee
