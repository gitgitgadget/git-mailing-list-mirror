Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A964C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiAaWCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiAaWCl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:02:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5ABC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:02:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m26so5022283wms.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 14:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=kX0RVZO7ZUGDTlkxUt0iB6OdxS0znvvSd326kS9ZMIY=;
        b=R4E36T+HCwBYAAzTlBScpID96VQjeLLxsEh1539V1ZBowusDVMMQtOy+9weVeVKLI0
         kgwAnqKfz370SvtZACV8LDcdhISA4mnHd4IIxd4v3Oj7i15gOI76liMx/eQw1s1R3CQz
         E0u+X7wvcVhkxs6XPbtwxHPHoXLzhwJhFafyt8Gsg8+HF9oFT9Nj9i+dKLzSMPmvEfyX
         db04DEW1ySsMsNG81q2TVqTHDndmOkmJdFXoHiQfyNS/jnlQQNpp9wlk3fyKZ8h1pXMh
         /TDSeLx0eAEq/XdsvuaMxngtoUuYkPld/mAl08X5sOvB6YICXn6JgIcl00k3lva5Yo55
         BFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=kX0RVZO7ZUGDTlkxUt0iB6OdxS0znvvSd326kS9ZMIY=;
        b=jnQboFPKs38gKYQzsRXwyZxTOgDhjdObhqISiKY/lwev8dHXScpX+cAgIYSKytTmZ6
         KUYlFd7eyjHT1TnRz1nCCPscarw4JJlGJNSoGS9meCjSMBVgM0AT0i9+CG+vzXvmuaMB
         FYQ6wUdsodM4a8MRaAddqhTWTvng3iRexjGMqxRTO0yiQKDkvjgX0TV3ZMfAtFJigHKI
         rwqdOHgF6cfIVTImRrTAslXcv2DpiwpkzMrdlIEu6ST1c4bFevRE+pJXrGzk/3u7+72+
         zzo4vbv1a/sdY7P/Aa+ED/Urw+2CzdlG0XWpy45eC3C1o8Myn/OKOGPNKxnj9nJmK11B
         p/eg==
X-Gm-Message-State: AOAM532JpAaXATMPwHGjNILeaMZ+msHJkeefVllpzgypxmm55O3vGsEm
        NgKLevA6OG0Sg4NnMg7HX9PMXJN9ehk=
X-Google-Smtp-Source: ABdhPJzB8wE4EZSyYf7dp5+eCdnhGCnXSSZ0ToYGznUNRGmXUe5KW9J4v3Ma88xh3tvj8SmbbWWJWQ==
X-Received: by 2002:a7b:c003:: with SMTP id c3mr20003594wmb.80.1643666559024;
        Mon, 31 Jan 2022 14:02:39 -0800 (PST)
Received: from [192.168.8.108] (netacc-gpn-7-193-112.pool.telenor.hu. [176.77.193.112])
        by smtp.gmail.com with ESMTPSA id a1sm13364185wrf.42.2022.01.31.14.02.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 14:02:38 -0800 (PST)
To:     git@vger.kernel.org
From:   "Herman, Geza" <geza.herman@gmail.com>
Subject: pull.ff = only vs. branch.<name>.rebase = true problem
Message-ID: <487ff4cc-7683-8282-d398-cda9230f2eb4@gmail.com>
Date:   Mon, 31 Jan 2022 23:02:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I saw a similar bug report two months ago ("pull.rebase config option 
broken in 2.33.1"), but it was only about pull.ff=only and pull.rebase. 
My issue is that if "pull.ff = only" is set, then even if 
"branch.<name>.rebase = true", the pull fails because

"fatal: Not possible to fast-forward, aborting."

But because of the branch settings, I'd expect a rebase here.

I modified the script in the previous bug report to show the issue:

--- 8< -------------

git init repo
cd repo

commit() {
     echo $1 >$1
     git add $1
     git commit -m $1
}

git checkout -b local
commit base
commit local

git checkout -b remote HEAD^
commit remote

git checkout local
git config pull.ff only
git config branch.local.rebase true
git pull . remote

--- 8< -------------

This script succeeds with previous versions of git, but with the latest 
one it fails.

My use case is this: I use "pull.ff=only" in my ~/.gitconfig to avoid 
any accidental merges throughout all my repos and branches. But, on 
branches where I do actual work, I usually rebase, so I set 
"branch.<name>.rebase = true" on these branches. Previously this worked, 
but now it has this problem.

Thanks,
Geza Herman
