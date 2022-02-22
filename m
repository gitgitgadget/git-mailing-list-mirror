Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4209C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiBVNuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiBVNux (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:50:53 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE9710BBCF
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:50:28 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id ba20so11065441qvb.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1dv1whm3Biw0ceixoUPWJ6+Bpjzt6C4EkkaVEDjMzW8=;
        b=B0qc6OwBJDiuHq9Hn+GlCOd1/EcNA4lt4cPJLg8EUm+tAnoV82NGoJO6788fT4PDhS
         3dIpjf40NYRhKAzVJldJac6FN296FprUs58daZJRmFkaYJOzg2XI0HOgkniWsG5oiLdT
         jRtq1MXTTZ6J0Xmkslo5nDDkTRVVEMq/Tt/I2qy443z0IIvsEusLZflgH1pOIhKZwmFd
         Ivq/ixwqFX/9offvyieN43mfGnuBrCuu+mlLY/h6ylA1Im1ASQyXi0NztLYz5XmBlXGF
         zFMRttHkBxrC0u3+KVTL+7A+kA97XOvLcsjULrIrFtUekfcGpeRbXL1fID5ye0HV8jKI
         9T0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1dv1whm3Biw0ceixoUPWJ6+Bpjzt6C4EkkaVEDjMzW8=;
        b=IKbSYHbMEQmpP+PcCRamJ8Yn7h871bPycoE9XrYTNdAwdOTEu7ft/CSGhyG6sNj97C
         jMAu+dOKXrdmTUnZc+SxTHHmIntRAscwe3PwsXvSL3BdKljJRpioVmpDuXC1etFPa7E+
         vaXrPYMArBMCWgmWvTC2AeRUBhx7aPurNO1ZCS/dLNTNvErKJvgn1opcdUnrYR/Tf201
         Fl8BcHzWp42NUS9oNMe4JQasN+GxVKJij981Q0V9m5VtyhPs/I8y3MUewxFVlmzdJOVN
         XbIKXpFB0BW7B69C+GuKuhApsvGzLqAsGzXob512mtL/6pvgDXZyb1BnFIk/i9XZkDik
         asFw==
X-Gm-Message-State: AOAM531gyz6rsEe37FZre7vf43QhtRruIlVRqxTQAdyttfws5MLt4ex6
        DH1tzKa98FYKKuHADghFAfZ36sfSJNFY
X-Google-Smtp-Source: ABdhPJxnosKs3a/mIUrClDYsI8zh4FFQNyv5qzipMcN3m8hL5zXR04TrudbHjun2k2T6lmcuiaSfFw==
X-Received: by 2002:ad4:5ba4:0:b0:42d:fa10:6447 with SMTP id 4-20020ad45ba4000000b0042dfa106447mr18513819qvq.37.1645537827756;
        Tue, 22 Feb 2022 05:50:27 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x4sm10748631qkh.42.2022.02.22.05.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 05:50:27 -0800 (PST)
Message-ID: <2e40461e-0b36-af67-33d5-a5d37f335025@github.com>
Date:   Tue, 22 Feb 2022 08:50:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] microproject: avoid using pipes in test
Content-Language: en-US
To:     Shubham Mishra <shivam828787@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com
References: <20220222114313.14921-1-shivam828787@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220222114313.14921-1-shivam828787@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/22/2022 6:43 AM, Shubham Mishra wrote:

Welcome, Subham!

> pipes doesn't care about error codes and ignore them thus we should not use them in tests.
> As an easy alternative, I am using a tmp file to write from git command so we can test the exit code.

This is the correct way to convert the pipes into something that
properly notices Git failures. The only issue I have with your
patches is that you should insert a newline after your &&.

(I'll include an example on patch 1.)
 
> This is my first contribution that's why I am keeping diff short with an intention to understand the process instead of making impactful change in first attempt. Later, I will send more patches to fix the issue for other files.

I think this is a great start! After fixing the formatting that
I saw, you should be good to start making more changes in a
single series. These patches are a good size.

Thanks,
-Stolee
