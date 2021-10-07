Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DEEC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B34C61077
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbhJGNzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241883AbhJGNzr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 09:55:47 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F012DC061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 06:53:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l13so6181632qtv.3
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mlInlNA9sPjQ/eRof0fPV24eDNPiiBnCS7PQEqEgCsE=;
        b=jqE9fDzIPY4yAf28Sz2vhYrA8XWtB95ygM089bd6jzR7YrufCJl/lyYxWaekOGb1tz
         5/56arsIn/3WRcn+WvmxuCUU1XL+oZHSZuqkk63dlJCR/3SBTi/F+n+7Zzv/xFJHgUlP
         e1XrGtWxGl+B/t0bmOkPttRPreW/GfiLPK2hnYbFJupNQMXNl0EYP2ujUwgIPV9RjzLK
         +cMNEmQ4wd3VFCi3QBZLUWJaxnUEG1ZgiFdey6CTIUXd6TK18pc3+K836+j004TFQotv
         T5PhBkTzL4dcPBaCnsd98TZe5vxe1c5n5nblLy3DT0YBCQgx6gkEUAMm9HIPiZncwSp6
         R6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mlInlNA9sPjQ/eRof0fPV24eDNPiiBnCS7PQEqEgCsE=;
        b=HOGU6OxxOr1c71jRkcqNO0MC6jjUxo2gu6D61j1uJfsJlAGZPhXXFgKgBY9tKX6nFM
         vSGNN0N40L0lz+/be3ECmeu8mtx2OsWp0E/Kvmpc9+bLoWXiJqZjzTK+FyygvJVJN5AJ
         mfvR8NCPDPk3r4uQ9HOtU1rPEuChv71q4NWlN0/+p7U8tckWrHIF3bbCUkB5s2WhbIJO
         K8yh2pqZg2i/Ply6Y/Xil7iXzROUeJ9FvLFywMIi6MUp91oDS/qL1ZrVSMaQ8G/rU7E/
         if0YLUaKg+Bs6mRm8qfuWHnTv0JOotHmmHG0/Ohbp8d9fivyuYKToUTUNgaEAUDHTQLL
         qtLg==
X-Gm-Message-State: AOAM530pNxg7LWhZ/xblLE5h02CG6hUsNXxrbVhujhViWfnr4YmilGov
        fPC82IVJBlPCQC1kxE15w/4=
X-Google-Smtp-Source: ABdhPJwUDOvYxoGrOQXYDb4J4KQBi+sxwzH1wfAYxAKRhcrayHWFG+vEC86mu1VtGj1eDZ29V6sqgA==
X-Received: by 2002:a05:622a:11c9:: with SMTP id n9mr5094899qtk.295.1633614833090;
        Thu, 07 Oct 2021 06:53:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:40be:181f:1763:acf6? ([2600:1700:e72:80a0:40be:181f:1763:acf6])
        by smtp.gmail.com with ESMTPSA id d82sm13689800qke.55.2021.10.07.06.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:53:52 -0700 (PDT)
Message-ID: <3bf4e767-294e-0f30-f0bc-ffa706a86835@gmail.com>
Date:   Thu, 7 Oct 2021 09:53:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
 <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/7/2021 5:50 AM, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
...
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 886e78715fe..85d5279b33c 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
>  test_expect_success 'merge, cherry-pick, and rebase' '
>  	init_repos &&
>  
> -	for OPERATION in "merge -m merge" cherry-pick rebase
> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"

I spoke too soon. On my machine, the 'git rebase --apply' tests fail
because of some verbose output that does not match across the full
and sparse cases. Using "rebase -q --apply" works for me.

Thanks,
-Stolee

