Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B5C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350205AbiHSSpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349974AbiHSSpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:45:43 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B26F3F321
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:45:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id c4so3124809iof.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=yYLLWzrFV0mGfExH3lc+J0gxuN6b4+IHWFS3ciOUrJs=;
        b=Y/qCWRR7dWVt+3DPgcM+iiqWivjcK48pWI8gxjiQYAMFdtgVTPhsHRzyiLqrc0YlDs
         ERL1VCmdHqOHDCYOM9FcE4/rGtMZzF75N5yCRgCg7fRtUZi2fmbnja1mRoOx3Kc/DQwr
         hTjBYCWXdvElpn5vU5EsSXeVXmaP9CHTIUJp4zF64jwz/TZE0Cx0aoQD+QcEdhlns3+j
         lRucuz060HFj6z3P2CTEvn+Db/jwcrOPGtKb3UAinTXVYAukQp6D0jP+n9MvGhKBuF1m
         WRnlYoyRNfPWmG9Yy9MioDed4njincsadMWIGuMly9rZ1mrAYvNQHuwlxjkBkFdkvTJD
         QavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=yYLLWzrFV0mGfExH3lc+J0gxuN6b4+IHWFS3ciOUrJs=;
        b=ZvR9odS272K3mzEh5DPSVYZxMlYoAwTMaSJcQiAp/LVUDDvV6BBfPlF/xlLcSG96NO
         F/ZrAIOinhEYUY0+v93hv2cy4bSKuup3AbkGFGturRC3iAoVt6P32Xr6WnApTqEKUOD1
         7djXghQ5DTE9NFpXUCbQQTxVVc4/eehy8XDXC7kUNnjoHS6qJEX6RpDu3Xd7w6Bl+zQv
         oVXgimypdVPFDoF5LFJSVpKpitQRjetx4YuGFqGlfx/atWOUiuy+01aS4PtxFvrcopwk
         23kotG9mMSLZiuVzIrolY6HRzETAhANMq+8zTpplNTIR9c/gDIVII38oMgbMo0T92yiP
         iZCQ==
X-Gm-Message-State: ACgBeo0gJB+TrBWxmARD3DSbtdQ/Ahe+sBa0qV5zehRC/gPZtM/5hDRk
        W6uE/xyW6P6Z4+Bo5gb4Y7xV
X-Google-Smtp-Source: AA6agR42688ZDqzN0sgoQ9TqYig28ReyFFJaEqJTGBvvJZsdEA+NRoSTe+HM8SLWNAqM67xu5BJ6lg==
X-Received: by 2002:a6b:5f08:0:b0:688:9846:2f61 with SMTP id t8-20020a6b5f08000000b0068898462f61mr3863427iob.65.1660934741905;
        Fri, 19 Aug 2022 11:45:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55ca:650:1968:6180? ([2600:1700:e72:80a0:55ca:650:1968:6180])
        by smtp.gmail.com with ESMTPSA id k10-20020a056638370a00b0034286300316sm2032401jav.166.2022.08.19.11.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 11:45:41 -0700 (PDT)
Message-ID: <6b1e154d-e90f-aed9-64c4-6e6845abe25c@github.com>
Date:   Fri, 19 Aug 2022 14:45:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/8] scalar: enable built-in FSMonitor
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
 <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2022 5:40 PM, Victoria Dye via GitGitGadget wrote:
> This series enables the built-in FSMonitor [1] on 'scalar'-registered
> repository enlistments. To avoid errors when unregistering an enlistment,
> the FSMonitor daemon is explicitly stopped during 'scalar unregister'.
> 
> Maintainer's note: this series has a minor conflict with
> 'vd/scalar-generalize-diagnose'. Please let me know if there's anything else
> I can provide (in addition to [2]) that would make resolution easier.
> 
> 
> Changes since V2
> ================
> 
>  * Updated prerequisites for FSMonitor in Scalar to include
>    'fsm_settings__get_reason(the_repository) == FSMONITOR_REASON_OK' to
>    handle cases where the platform is supported, but the repository is not.
>  * Gated enabling the 'core.fsmonitor' on FSMonitor compatibility with the
>    repo.
>  * Replaced 'die()' failures in 'delete_enlistment()' with 'error()'s.
>  * Replaced 'BUILTIN_FSMONITOR' test prerequisite with already-existing
>    'FSMONITOR_DAEMON' for FSMonitor.
>  * Rewrote Scalar enlistment/repo search in 'setup_enlistment_directory()'
>    to avoid unconstrained search and respect 'GIT_CEILING_DIRECTORIES'.
>    Added tests to show the new expected behavior.

I wrote a couple "thinking out loud" replies, but the series looks
good to me without any changes.

Thanks,
-Stolee

