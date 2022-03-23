Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8240FC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 07:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbiCWHKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbiCWHKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 03:10:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB31D0ED
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 00:08:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e5so711568pls.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=caaH0KFcXOVgVWsSga0VCjpy33XPC2KOezpaZwdAglg=;
        b=nye9wzZO2yWmf3avUdUH+lpSzQ4UYiEHw4sq2+2A9TYwJXwZgH6mdO1P/A1nq0NJzG
         PcSU6tOoXH4mjS/LLqlS6uxzi7/z3RmSRa4NLbJTLkxGIRVPoF/+acZ8pGsqYBXzJttF
         Wz/XXJ3iRW1F9ozeabhtjRFHXnIwPhD01YmNjdG5FOpVxaZZgl9YUwWPSymiiUae34Vb
         Sk7j2SFXoS1MIEhjniR2QPowAFxydH8Hj64Nse+tII3TnSOmxiMxet20xnigtlal5Hnt
         0lQmvt71By9QiF22oT1rn4EvOianmkp3p1+BeA0Dvso5TMlMIcZqYtKUCxjxP6JO/uXH
         d34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=caaH0KFcXOVgVWsSga0VCjpy33XPC2KOezpaZwdAglg=;
        b=Bz+nSCp6idtLMP3iNT3/eXcgz2oUaZneF7+aS+TWcLpNio6fnEQDe3zoHjNI1aC6RO
         kRXRulXeSOvymD2KLRAHJmWaG7mNaLLSuQXStOmk2Z8368iTyU9xzMqqP2+tghEmWPDi
         6asOrnfOml0AVc/RzQCO4KNUtrcId0BbGNe68iikd66kKFqEtvrQ5deHT1KTqL7mubOO
         LAagnLgLphbgzPyg9jA032YyKZzDud58DyIMlYQdlDMQIcS7reSoh69zTvrvx6FU4ISU
         hnOEJuYeNFhQ+YAHDdQbEX2CLKZI6FxPTimCVqlmJ54Fovn/P07Qhq11M87h6QviV9He
         F4pA==
X-Gm-Message-State: AOAM533ZzdskZU6GA0OW6DUgrgvicjQSx5Uubv+GZNUeBzCAXo7qjDIn
        vMAcvPA9zauA/kqfo3fUWHXdBpDMaDovqw==
X-Google-Smtp-Source: ABdhPJzYkerBtcyF8FDtLJPA8CjVSBCT7C//Hyt/0PkimXqkdfHPDWFdRn9dx0YcLI/3ziA1rmTsRQ==
X-Received: by 2002:a17:90b:1642:b0:1c7:2497:3807 with SMTP id il2-20020a17090b164200b001c724973807mr9672547pjb.176.1648019331829;
        Wed, 23 Mar 2022 00:08:51 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-86.three.co.id. [180.214.233.86])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm24785375pfh.84.2022.03.23.00.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 00:08:51 -0700 (PDT)
Message-ID: <29e64add-59ca-df77-a717-58c09c686336@gmail.com>
Date:   Wed, 23 Mar 2022 14:08:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/5] bundle: move capabilities to end of 'verify'
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <1b2130426bd7bd6c0bf5c56be2bf66a4d81f0b27.1647970119.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <1b2130426bd7bd6c0bf5c56be2bf66a4d81f0b27.1647970119.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/03/22 00.28, Derrick Stolee via GitGitGadget wrote:

> -	Information about additional capabilities, such as "object filter",
> -	is printed. See "Capabilities" in link:technical/bundle-format.html
> -	for more information. Finally, 'git bundle' prints a list of
> -	missing commits, if any. The exit code is zero for success, but
> -	will be nonzero if the bundle file is invalid.
> +	Then, 'git bundle' prints a list of missing commits, if any.
> +	Finally, information about additional capabilities, such as "object
> +	filter", is printed. See "Capabilities" in link:technical/bundle-format.html
> +	for more information. The exit code is zero for success, but will
> +	be nonzero if the bundle file is invalid.

That means, nonzero exit code for corrupted bundle files, right?

-- 
An old man doll... just what I always wanted! - Clara
