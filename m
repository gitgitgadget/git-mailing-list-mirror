Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DDFC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AE761A87
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhJAJQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJAJQS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:16:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053FC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:14:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y8so7370380pfa.7
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PZobYGgSwB6u2G0Ax13VSSfYlHrwMYadTqM87lc3Npk=;
        b=NFspnPLbzuR3Ct8tXp20yYVJ4fCvbL6a7Xd5WAKSNAvDk3IZ5ngI/7DBsK/MLIuwPj
         gNUQ3vAh8JtyAYEXRmHjhy3NmSjkMVT8vO9tuZJXA/hS9WBVZBI2lPcXvTrmnJpZ66/V
         MZZjdFsP6QLnTt7W2x6K676Zxf2Ik00N7Xh52OpWBX+E2u0ckPy58B2mI9yWA5sD4GmQ
         lFudXsW8NL5k0orVFDgsxQtDUXyfGB4AUsEMU1jRtkyhWrEhBHkqTbtwt4DXk6f7lvqE
         BSuCglUyKIrResZ9r50UulDNtgW5LPT/Sco+5TnKvf941a+yqN1VwsyrPU5M9bUE8n2+
         5L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZobYGgSwB6u2G0Ax13VSSfYlHrwMYadTqM87lc3Npk=;
        b=UgxYjl2WS5QGLO2IDoUQAdFDacCki8cAK/2uSg/LdmYErqf/oEBW+FJiJTg05KM2rs
         qzuKALBNLrPEwv1DnHISx2yc7DdSC4t1hQ7R6Vc8/dTmcqFVEwnEbyvhKUKnUYj111Xk
         hICXtMLtDps4/YqIWOKV1z0IHR3WPo2hpCJkUDF6N9rS+T0UmYhs/CjUmOkCHRKlZLdi
         DRkjfxM80d9O2scbz3rsfmIVpHkUm8ZSo0IzgCA/xTSOq+Nv5MKA2TdtjrLhVFF/5UOH
         YsH9yAWSLHvMK8dT2iYZbXsaL6n4J9fCDnLPnxXR1A6HGZ+Z3lT/+Psw9LHYwHrfE/zR
         KppA==
X-Gm-Message-State: AOAM531WJaHakYLrYsB8bVcmSC6hTQuyvCk/MaiSIl/GXuWLGAXXODCa
        r/D5SCzLGvCL4A6Nu24fU7Q=
X-Google-Smtp-Source: ABdhPJzGhRMT8oNXHrBZeNTNzkzZQUiOFc1DORYyXv7u7tU05u7lwnWVNPIzI+oXdJthqEkQXjZ/xw==
X-Received: by 2002:a63:da49:: with SMTP id l9mr8689394pgj.277.1633079673622;
        Fri, 01 Oct 2021 02:14:33 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id z11sm6048723pff.144.2021.10.01.02.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 02:14:33 -0700 (PDT)
Subject: Re: [PATCH 2/7] sparse-index: update command for expand/collapse test
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3de9e873-681a-2bcb-ed56-fc247177cb37@gmail.com>
Date:   Fri, 1 Oct 2021 16:14:29 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/09/21 21.50, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> In anticipation of multiple commands being fully integrated with sparse
> index, update the test for index expand and collapse for non-sparse index
> integrated commands to use `mv`.
> 

We can say "use git sparse-index mv instead of git sparse-index reset".

Why is mv used for this case?

-- 
An old man doll... just what I always wanted! - Clara
