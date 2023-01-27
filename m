Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F687C38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 22:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjA0WGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 17:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjA0WGO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 17:06:14 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385AD61BF
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 14:06:13 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g9so4213758pfo.5
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 14:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+dDWdWN5UoCW/3Z+9arYMVPbAz5wY7scMHE9LSuIqE=;
        b=J8WBfTrzHyFc9QgGn6TzrM1usbMi+KAMISGc5AOuCYmAflDvtv/2W0r6PP1oOZvAHY
         8N9WcZeGJIs1yvj9nBApG114wMrbnowciFynHlTZB/hf5Ce7Quup9bYG+3aq4KKQbUka
         /lGMr1Kl076OOUuRYFSTG9JEjl8Ie9H0+JeqnGzVmVSu7u6NwIRQ7u2BrZv91Vfxl/zV
         lvIeZt6BN1evqT1kzv4ylCUoOQxuVbPjSruvbEOS5C1X4nLHpYF+Cgr2Z3uCW96jrW+E
         pDEVPpIRcjVPtl4lczfk46kCXE81QoV1iazSvCpI5R4ZIT8IJ5KJrbWrmPgI5cPQWwxQ
         c6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+dDWdWN5UoCW/3Z+9arYMVPbAz5wY7scMHE9LSuIqE=;
        b=NqhlchOVNiLWihfPWa5bdO3Z+YypLU8sUoHtSlRPmjjn2xvD950J0/g8dzNZ/l4mGt
         a0xNHxvAxWWyGiuVEZWp+KOwFkKmDEgTLCt2oDjjLWylpihuezR5j/urKU3QYVoxuNGc
         pwukqOGFO0va6+NbbWLC/FZKqZGh70DGifS3zIXDR0GrGouNf02NCuNMhMR8+8BdXlzG
         FC10kxEbkdOmFFmxHdGfSBFJRN7g+9OmA8tdWIMPyMA/rHkTFeBzFRZc1SNGAVB/2MWJ
         VpEKimSq5gTet0xM94vMGcDt/XWs6snFFvstIOxZyb9wOnkpuXZNyNboBH1GC3c/QTn1
         34nA==
X-Gm-Message-State: AFqh2koUTD5in3Yvc39Iq/u2g2+ZuEN73Gt9O85its3ZQg/TZTroyFT/
        EomUJFaxZk+YibR/HH0/Y7Nj
X-Google-Smtp-Source: AMrXdXtf7r0hMBQjHxyjcPaErQtDFD7UAmmVMtxhnXA22/a0I4bAjUbpnS5jk3fQMfCkaSiIljpPZg==
X-Received: by 2002:aa7:8c45:0:b0:584:6bbd:d78c with SMTP id e5-20020aa78c45000000b005846bbdd78cmr39791227pfd.34.1674857172694;
        Fri, 27 Jan 2023 14:06:12 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 144-20020a621596000000b00590ede84b1csm71089pfv.147.2023.01.27.14.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:06:12 -0800 (PST)
Message-ID: <65b1735b-7ea6-5f7c-e1d9-6c986c7beb1d@github.com>
Date:   Fri, 27 Jan 2023 14:06:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
 <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> A user reported issues with 'scalar clone' and 'scalar register' when
> working in an environment that had locked down the ability to run
> 'crontab' or 'systemctl' in that those commands registered as _failures_
> instead of opportunistically reporting a success with just a warning
> about background maintenance.
> 
> As a workaround, they can use GIT_TEST_MAINT_SCHEDULER to fake a
> successful background maintenance, but this is not a viable strategy for
> long-term.
> 
> Update 'scalar register' and 'scalar clone' to no longer fail by
> modifying register_dir() to only warn when toggle_maintenance(1) fails.
> 
> Since background maintenance is a "nice to have" and not a requirement
> for a working repository, it is best to move this from hard error to
> gentle warning.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  scalar.c                | 2 +-
>  t/t9210-scalar.sh       | 4 ++--
>  t/t9211-scalar-clone.sh | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/scalar.c b/scalar.c
> index f25d5f1d0ef..ca19b95ce46 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -262,7 +262,7 @@ static int register_dir(void)
>  		return error(_("could not set recommended config"));
>  
>  	if (toggle_maintenance(1))
> -		return error(_("could not turn on maintenance"));
> +		warning(_("could not turn on maintenance"));

Should we do the same thing for 'unregister_dir()'? Unlike 'register_dir()',
it doesn't break immediately (and finishes removing the enlistment), but it
still returns a nonzero error code from 'scalar unregister'.

>  
>  	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {
>  		return error(_("could not start the FSMonitor daemon"));
> diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
> index 13a4f6dbcf4..4432a30d10b 100755
> --- a/t/t9210-scalar.sh
> +++ b/t/t9210-scalar.sh
> @@ -104,10 +104,10 @@ test_expect_success FSMONITOR_DAEMON 'scalar register starts fsmon daemon' '
>  	test_cmp_config -C test/src true core.fsmonitor
>  '
>  
> -test_expect_success 'scalar register fails when background maintenance fails' '
> +test_expect_success 'scalar register warns when background maintenance fails' '
>  	git init register-repo &&
>  	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
> -		test_must_fail scalar register register-repo 2>err &&
> +		scalar register register-repo 2>err &&
>  	grep "could not turn on maintenance" err
>  '
>  
> diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
> index a6156da29ac..872ad1c9c2b 100755
> --- a/t/t9211-scalar-clone.sh
> +++ b/t/t9211-scalar-clone.sh
> @@ -174,9 +174,9 @@ test_expect_success 'progress without tty' '
>  	cleanup_clone $enlistment
>  '
>  
> -test_expect_success 'scalar clone fails when background maintenance fails' '
> +test_expect_success 'scalar clone warns when background maintenance fails' '
>  	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
> -		test_must_fail scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
> +		scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
>  	grep "could not turn on maintenance" err
>  '

Similarly, it might be nice to show how 'scalar unregister' behaves when
maintenance fails in the tests.

