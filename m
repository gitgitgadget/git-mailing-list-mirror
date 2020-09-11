Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D097CC433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7179922208
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3vXDsQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgIKTAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgIKTAC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:00:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191BFC061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:00:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f142so10872295qke.13
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AVWr/SwVQq/ptDW5kQeAr7S/+z2mYqzuhzPcdoFeEGE=;
        b=c3vXDsQh9GYBA7UoHsbYMtUBVupmoRQ8LFHwxn9LBW4icgrMulff1n9sjiyedL4bUt
         MpbGfb3tnMn4QG4EQrShX4a4B/Hr5zpKfqc/j7cXtnfox1yb8viN9jxmkAfh3IeZsXcH
         wygH+EFtHoF76q2CMMD4JwxFIDVerVX07i3zc7GYN0eNNZjLRiySsc1vJ+BVFoHSTrzm
         i5nJIC2W5/AxA10VvkYzsBsihHT3BPOaKv0CowC2VMDAwz0pHVPZK63tGOT3sXR6iMWb
         21vDV2XSyYAS9hFj8Ou01E7dfcKAxL7K0eeTLxxJ6M5vbPX5pR3oz9RsaG8X9WV4lr08
         sfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVWr/SwVQq/ptDW5kQeAr7S/+z2mYqzuhzPcdoFeEGE=;
        b=K0y66TL3eW8Zj6nk3rQ8zfnWXpfExj9qxy79IcWCWUyNdLyltGJVHDggr4dTXxBx5q
         03TnaW7PhOLpGhncLn0ZkwjF7oWQJvxxa9GqB4lfZAyKptCtv7ia8nrfY1R7U/3D1nC+
         UhuQQACW7UyuN5rC5me3i6La/dQL+i7HZ4SbYyTpI59wPOvc8GSoDIS9BMY5d/GKCQX2
         yf7AqonVt6EGg0RjeICq6qY1R5Y/LoJn5IpYeDkd0pBAe6nYhDzC57yrnYZyaWfdotX7
         FbXPWI8ODQ7/y3dDXVGZsfBeqV2NHpT9upBB6sp4v7/Pt5jLEVYfgE34kY+q/yuapdC3
         6nSA==
X-Gm-Message-State: AOAM533foHi1yTPUN2UvxHdhaVNLe2Vm3EWsgOaqCDaH9iFCz3BIkDRa
        5cZwRNnsiwMepXRQlasD0eI=
X-Google-Smtp-Source: ABdhPJw0JV4FUaRuzntymNkabolLw39B8PZPAHrAPEUdhGTxNxXLPU+KYyESkST73ivy18Yl2TkE5g==
X-Received: by 2002:a37:7286:: with SMTP id n128mr2783546qkc.423.1599850801247;
        Fri, 11 Sep 2020 12:00:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3846:6663:b768:1725? ([2600:1700:e72:80a0:3846:6663:b768:1725])
        by smtp.gmail.com with ESMTPSA id e26sm3737071qka.24.2020.09.11.11.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:00:00 -0700 (PDT)
Subject: Re: [PATCH 2/4] clone: call git_config before parse_options
To:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
 <51ef776f8523d29dfe03d15f0d1958f5c456c057.1599848727.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <48b160f0-0cb3-e120-dc11-1d5de7e02af1@gmail.com>
Date:   Fri, 11 Sep 2020 14:59:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <51ef776f8523d29dfe03d15f0d1958f5c456c057.1599848727.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2020 2:25 PM, Sean Barag via GitGitGadget wrote:
> From: Sean Barag <sean@barag.org>
> 
> While Junio's request [1] was to avoids the unusual  "write config then
> immediately read it" pattern that exists in `cmd_clone`, Johannes
> mentioned that --template can write new config values that aren't
> automatically included in the environment [2]. This requires a config
> re-read after `init_db` is called.
> 
> Moving the initial config up does allow settings from config to be
> overwritten by ones provided via CLI options in a more natural way
> though, so that part of Junio's suggestion remains.
> 
> [1] https://lore.kernel.org/git/pull.710.git.1598456751674.gitgitgadget@gmail.com/
> [2] https://github.com/gitgitgadget/git/pull/727#issuecomment-689740195
> 
> Signed-off-by: Sean Barag <sean@barag.org>
> Thanks-to: Junio C Hamano <gitster@pobox.com>
> Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/clone.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b087ee40c2..bf095815f0 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -851,8 +851,21 @@ static int checkout(int submodule_progress)
>  	return err;
>  }
>  
> +static int git_clone_config(const char *k, const char *v, void *cb)
> +{
> +	return git_default_config(k, v, cb);
> +}
> +

Introducing this no-op seems a bit premature, but as long
as it makes your future patches cleaner, then it is
appropriate.

>  static int write_one_config(const char *key, const char *value, void *data)
>  {
> +	/*
> +	 * give git_config_default a chance to write config values back to the environment, since
> +	 * git_config_set_multivar_gently only deals with config-file writes
> +	 */
> +	int apply_failed = git_default_config(key, value, data);

However, you change this to git_clone_config() in patch 4. Perhaps
use git_clone_config() here instead?

Thanks,
-Stolee

