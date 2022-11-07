Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009F2C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiKGTTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiKGTTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:19:06 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A22A25C
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:19:05 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id x15so8810867qvp.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3LSZ7wj2u5AHd73o3rhVEkiOJ4+sr60voeWV9DTQns=;
        b=Nowzi1QPQjfzg1wvJzEqotij550lJfgGQ3TwKy2U5NQiFN9p/Z/J6Jb8SpQspa6tN+
         KgEGzUja0w0H6Cz/7IDN47MsjoCvKSUf0TGsLXrsjNKPi5xWINNLsR8ep5mKq2ZHSatk
         /GergivbWOvU1sTxHCKcWXTPsPMhTqUf9CjSljWWj2x5EoJc907BfvjQujmEP1y5lzf6
         cyiP54QowYHvFEV2b54LD+SdmBCgx6L2ZFpE/DLqcjoxbCbjqD5/E7m1reBbI8wgE+0O
         1qMqnhMGI0Tvg6QwXRBjZYjPEcCZd5FM+aOUthEJ0sYEfQlVDENw66XnuRYZ8jvdIol5
         2f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3LSZ7wj2u5AHd73o3rhVEkiOJ4+sr60voeWV9DTQns=;
        b=gODTgvxtSAc+6ULnQ2j8xOssUPZlAw0XpXABXViaxLYW4thsd4PdDVz0yEdAGDS0yP
         T2zei6PL+mX0NH3NNe/Shvj0Nkj20/WAlwsNUmd//F7pj0WLotCIeqB91CkBcybT8JqT
         BJTBPRuwXy2Jgx3qlg8YI+8fP9Kl0nzdAsw3vhr1lbAMIwnVLvUobF7ulAV5KQxPoqza
         mT5hZRCkIKTPukJxQ4AyFjGeGkpPfDy7Ks/2DpYHiL2OCfmfP5lHLc6J8/Wg57wVHJhg
         vLKojCEpcWoIOfMfzoTWn2AmDU4BhcBec8GXN1Qt06qolVpoyfbU8aijzH+le87m3W/c
         D+9w==
X-Gm-Message-State: ACrzQf1++YwxbRRpBCwQ+evnKgbv1AL6djzb6noxEdF2jwZ3J4XybWyf
        94wKEANMa+41FLqgs0fV9gW2
X-Google-Smtp-Source: AMsMyM4vQhZdt2A8XQQ4TeDS42ojjUoKAR8RVsITTah5vgbE7Qf6AtpJ5EcUSZJ5Pw6UwlaKoomxuw==
X-Received: by 2002:a05:6214:21a8:b0:4bb:e31f:12c8 with SMTP id t8-20020a05621421a800b004bbe31f12c8mr41889444qvc.65.1667848744985;
        Mon, 07 Nov 2022 11:19:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id bp32-20020a05620a45a000b006faa88ba2b5sm7363401qkb.7.2022.11.07.11.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:19:04 -0800 (PST)
Message-ID: <19724e50-cb49-8c74-6807-93ac70a8adba@github.com>
Date:   Mon, 7 Nov 2022 14:19:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3 06/11] test-http-server: add stub HTTP server test
 helper
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <4947e81546a51883365d0087ce616b6b77e24a63.1667426970.git.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4947e81546a51883365d0087ce616b6b77e24a63.1667426970.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/22 6:09 PM, Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Introduce a mini HTTP server helper that in the future will be enhanced
> to provide a frontend for the git-http-backend, with support for
> arbitrary authentication schemes.
> 
> Right now, test-http-server is a pared-down copy of the git-daemon that
> always returns a 501 Not Implemented response to all callers.

Thanks for splitting this out. I ran a diff between daemon.c and
this version of t/helper/test-http-server.c. Most of the diff was
functionality removed from daemon.c, and the small bits that were
new to this file are either comments detailing how the helper
works or custom bits related to the test environment (like the
pid file). It was much easier to validate that these changes made
sense.

Looking good.

Thanks,
-Stolee
