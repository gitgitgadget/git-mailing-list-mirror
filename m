Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB77C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 19:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjB0TLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 14:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjB0TLa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 14:11:30 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A80252B7
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:11:28 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bp19so3300619oib.4
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mzAXn69vWdPeWtzI0s/Rqmlvz2oZ0NM8kSww/u4FNNE=;
        b=clWydlF24G21XSXl05ZoiJSRm2zJCtwhJy92H2jKYYPXi9FkwQEDDKkJodtsrcWrp5
         BxVvEnyjVSiIzLl85RKAXWHqFEoIulwH8HYAQyeIBFbJlAfd/BqBMhJMZEum0yLSI0aG
         Y9U431kgdtQL47Y7CXBeWwOQdMlmLg26bLCREzuVG1gH0nQqfwmK/vkaoBgaFEhbfayy
         R2aAT2awT137v3xbitm8nO9eaK9XkChsHw2/dKGxzYoapU6+DiIj2Nmpf1AIohnrQRqX
         a48a0wfQMmrnsDDe7/ar+LWEEM9UZPWjJ3TS1FzcsqGtfrcHb+E3V/af+7pz78Wgeo6B
         JxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzAXn69vWdPeWtzI0s/Rqmlvz2oZ0NM8kSww/u4FNNE=;
        b=cl8+sOJuUdl6XA+0V4iTlkH6SFgQHpLYfJSSOyqzI8jr9I8vSFCq/PcbNEThZpIlKc
         1HQSDlUw/n+QmPqIQ9Ds1zW7aCmhKyA0gMLXvuDU94AeWhtUBTWFHPsL58ZMnysSNmcP
         aOBx9GYqH7j6no6QnW2Nk1cauDGL7auohjLSpDhJHU3rDKOrjWvUVJqt/11Y2jrlk9ZW
         u7b54sYVGFbOZaHLSdC5/ljD+LECe1Jcug3W0c3vkYIrFGk0qll87pDYln/01mzUjzpp
         U1R4qpHbIXvII7y2GTHANvWPK9U95nI0iIUt9fkfP2FfE72EK2WRH+lWMIUiO4RqMxOc
         fPJQ==
X-Gm-Message-State: AO0yUKUL5Uvlk/8pXJJJjNe6LZPOsmdYBmcutpEb6WeXUgK/TLWnqExL
        5V/TA7TzLcRHe6NhU/i1waJJ
X-Google-Smtp-Source: AK7set9p8SpnbcamY2DHfvTUjjnlL8GQc/9vi4bNrqYXRu2wEpDgfSQUG82Vpi8bbLDI16YjpRlXKw==
X-Received: by 2002:a05:6808:b12:b0:37e:c952:2bee with SMTP id s18-20020a0568080b1200b0037ec9522beemr115859oij.22.1677525087962;
        Mon, 27 Feb 2023 11:11:27 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c838:390d:932c:3ee6? ([2600:1700:e72:80a0:c838:390d:932c:3ee6])
        by smtp.gmail.com with ESMTPSA id p129-20020acaf187000000b0038413a012dasm3095400oih.4.2023.02.27.11.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 11:11:27 -0800 (PST)
Message-ID: <0aa0562e-7aa6-9442-09da-46f303d76b08@github.com>
Date:   Mon, 27 Feb 2023 14:11:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/13] t2021: fix platform-specific leftover cruft
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
 <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
 <7bbc4577a57fc9cb9debc249af232282b6b3f24f.1677511700.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7bbc4577a57fc9cb9debc249af232282b6b3f24f.1677511700.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/27/2023 10:28 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

>  test_expect_success SYMLINKS 'the symlink remained' '
>  
> -	test_when_finished "rm a/b" &&
>  	test -h a/b
>  '
>  
> +test_expect_success 'cleanup after previous symlink tests' '
> +	rm a/b
> +'

I was confused why this worked without "rm -f a/b" and it seems
the path exists in all cases, it's just a symlink on the filesystem
in the case of the SYMLINKS prerequisite.

Thanks,
-Stolee
