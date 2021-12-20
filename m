Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF498C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 17:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhLTRcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 12:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLTRcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 12:32:09 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F12C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:32:09 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so13426181otu.10
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nRnh3JwdhUIxHdXubao2r8b3eQwqMz3qgjTeJrS5kjs=;
        b=OnXVIutM3EaGishINS46ciHD0jGDu0ObJ6uyPeKw0KGc4tZxr2DgqEX8rcbCiIh3Ej
         jU02mnm5SHq0fAw1DKMFHlnmoi+FQKCOMgfcvbxxgYbaz7KipPRwvrNhchCfAGe77Ql5
         uU7qBemlYe9PE2g4L8YpClaAfk0x5j7wPixx9e7uLvl8QQ2eLsoNPrIfAIIlfeWfBNC6
         IAYgSRvIH/0jkJE1bQXfKOr7jOzcoz2F7Szz1+w/eG/Gms8SaTPRCL0HVYqXK1qP5P+m
         5L/UvTagkDYoUty5MVor0Ih+JzGFcVWnf6yJ0E0+tCO4iX+h6YMEV9IzZ3B1IxCPPwqG
         KVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nRnh3JwdhUIxHdXubao2r8b3eQwqMz3qgjTeJrS5kjs=;
        b=Yg8D+nAgUsyW51r6g8Y0Y+EpdwzA4MQaVPXLnCR8IsJyikAzAnmYgR1SCEo8Evj/1V
         OhoHXAWazjhqJwjiK6/66v43VrJLFY4og1bzlMZroW19lUn+QXUQbF7Yjvcb/IZrgAq1
         dWcS0Gl6gpK2wfJzBo5qWa7xIcdSQCdrEX1Jr/XotIxL788yWdprU8iSpNdbWFkGuEWY
         +ieb+jRFxlRHOySPII9noDY8f/6rmjZ8TX0A1De0/kRo4/21TK+W9QsBKV57yNihG+8t
         SDmZhaMXRhM52lKeH45x52luAxEeuDPco45/BNreudAt7jRlZBy/R3SKDV1n0mb7Xpyp
         WqhQ==
X-Gm-Message-State: AOAM532i2KFwC76cTAGdjVokCOLXYSng0XHSDCDKiwWVp5E+GPz9kWTA
        TWz95BAwQe36BwimTH23Qu7zQIgWx3w=
X-Google-Smtp-Source: ABdhPJxarsn03p+A8Jy+kpygJoAkQSgTqZaud3HLlqXSC5HRFaJdNdlHPEV1XgT7vGylOiQvv50kaQ==
X-Received: by 2002:a05:6830:2321:: with SMTP id q1mr12103213otg.106.1640021528482;
        Mon, 20 Dec 2021 09:32:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id i3sm3115698ooq.39.2021.12.20.09.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 09:32:07 -0800 (PST)
Message-ID: <6d72a020-ded7-6ef2-825c-ce6421194b26@gmail.com>
Date:   Mon, 20 Dec 2021 12:32:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] config: add repo_config_set_worktree_gently()
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     sunshine@sunshineco.com, allred.sean@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 10:57 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>

...

> +	/*
> +	 * Ensure that core.bare reflects the current worktree, since the
> +	 * logic for is_bare_repository() changes if extensions.worktreeConfig
> +	 * is disabled.
> +	 */
> +	if ((res = git_config_set_multivar_in_file_gently(config_filename, "core.bare",
> +							  r->worktree ? "false" : "true",
> +							  NULL, 0))) {
> +		error(_("unable to set core.bare setting in worktree config"));
> +		return res;
> +	}

As mentioned by Eric, this portion isn't correct. It fixes _this_ worktree, but
any other existing worktrees would become broken.

The fix would be to detect if the core config file has core.bare=false and then
to move that setting into the base repo's config.worktree file.

I believe that if we do that change, then the rest of this patch series is valid.

What do others think?

Thanks,
-Stolee
