Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F8C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 20:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIHUzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 16:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIHUy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 16:54:56 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA15E47BB4
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 13:54:53 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a9so9927206ilh.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nQGB71UzDomq8OKzxNQZTXFHTTo1Sp99Q3po4kNJLbg=;
        b=N+Ekxxg7qvraokQtFPMfdj13GKSdlEGwmKi91ie6VRsZNQiaYFHucrZaW/8/nMb99i
         RXdUe36YaDk2/Paj05LycfB25CCEAASf6rZ1jgtsXX4XRk9mFsK94EeCqgE+nML87hCl
         AeZOUWhVge9sgcv9j3+SIVP4QrrHFzkCWY1AisisAFs6rtYgEzq+e1o7MqYdQPJiEhfC
         UDo6zdgwKG+5fn7hLOGiBWUElGytF5Sq/qUgx4W+PUFWUSQ7eRAR089XwkXcQ4axmgGK
         Y638hbcMUPzdr/JUmlWWevTofX1yD1Ns/aScgpwYFta8PCFErRRtujWiVacOBo2fYZgu
         +l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nQGB71UzDomq8OKzxNQZTXFHTTo1Sp99Q3po4kNJLbg=;
        b=4DLUy19wtRxp9PmE9C7LNTT9kpXz1mOb0/KF1/yr7VLOC9RZb/W//OcTfTRHunIPOk
         /W7OpT2n/8EE1ctvFhstNG9mJ6SQuxro9gfe2ZwzCcFjytK88hC2GQX2tXRR0nJJnSQU
         o0w5orsjHZASNMo+XOvAdhAtRi7ZYcBOFL8HJPscKPr6QpyPapNMNkc8Z7zp6fPij96t
         Ozlt+yF1tuym99uhXOBp7YJOjT88w3bHgJsyLdJadO50kOHZFM7sEOTRY7bFUyTfnTy4
         jK3mgiMYCV8iv10GMdrmwBAcyKrYJUn3V10W34mMLTWi6a1DiN4cH+HhbrUJYFYPocUx
         Zn0w==
X-Gm-Message-State: ACgBeo013DXVJsl0Ghtm7IvsgXXIwnaHkjGjt/uOoXY7KIzRCI4BVJ+/
        bfOa/dVPUqzBUUswoCLOmi5Y
X-Google-Smtp-Source: AA6agR4k80k4JyAx/veajV712bjoT8birbhlqx/DXkTlK9se/iyZCkPIwNS3JiE+eDMPv4NkyBxfDg==
X-Received: by 2002:a05:6e02:6cc:b0:2f1:6cdf:6f59 with SMTP id p12-20020a056e0206cc00b002f16cdf6f59mr2589967ils.316.1662670492854;
        Thu, 08 Sep 2022 13:54:52 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f35-20020a0284a6000000b0035849fce643sm591577jai.133.2022.09.08.13.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 13:54:52 -0700 (PDT)
Message-ID: <dade8c50-3456-3538-e151-a1deffbb1c1d@github.com>
Date:   Thu, 8 Sep 2022 16:54:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 0/9] scalar: integrate into core Git
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
 <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/2/2022 11:56 AM, Victoria Dye via GitGitGadget wrote:
> This series completes the initial implementation of the Scalar command as a
> core component of Git. For readers new to the topic of Scalar, the
> roadmap/design doc [1] provides some background information including how
> the project started & evolved, as well as its current intent & high-level
> design.

I just took a read through this series, and everything seemed
well justified and cleanly implemented. I built and installed
this version of Scalar locally as a way to see that all the
build steps worked as expected.

Thanks!
-Stolee
