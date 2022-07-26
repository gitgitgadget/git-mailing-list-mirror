Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7E7C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 17:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiGZR11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGZR1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 13:27:25 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC572A430
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:27:23 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c20so10931525qtw.8
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYIsptMti0Ky1pJ60TaiYfA1G3rPtOV5CC1Pxcc9FiE=;
        b=JObeebsl7kMixRJml6tm2IM8wrtaFfdZbhVh9f52ZFGKa7EzSQxp0LnuDLEp1x2a9t
         pOFIGHwfKbxiZpXkqhsr8y6lQGTKhgJjMXa6dpIrtLQhDPuW1FjFedO6VeX/tL3x2OKl
         CNE4visduxerAzj6DMhOZ+1twOdQJ8WPIGonaxbCw64L8qaxieu0Uw0rZtLe3fHeu39V
         H+JzhsBpfJDXu7yjJ2MSR4JBXEhX36E2GHlauT5KxwvltUShPACupHsHopz8f8di9z34
         1SBNXrDHRKxnKF7+ioFS2lH/WgBxOj77mrcd5RXWVQrcaVvgPF4aFY++lv487CPNp+qz
         bmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYIsptMti0Ky1pJ60TaiYfA1G3rPtOV5CC1Pxcc9FiE=;
        b=huWcY4eBUbIbU0D6PaaKC3fA/dUXKdEeEefXMydh0ObQojxc+63/SP/5kffaeQxqQE
         gIZVlm/PTm3b8z16mbIusve8Ev7N+lDmJvvUosd1RMtzjJO4tMHccE3z2eWmkRvFQpvk
         lrVviKNvX5VgY4g0tlpewlzu2kuc/kbQNdaEhnVgXcHbg5RDTO0seRbYW1r79Vw/cabW
         9nywIEc7W+xA5QneSICYyvIfq12+BTLXCulTC4Ho4TOU0OdRQjfwq+7FpGLt/6XggKL0
         rlV3W//I6iR4B3i1Z26kxvMMwfS06rGWCj7BJWs8IZu7RRGn3Krybo8sDpZl5GXRZlL+
         5pvA==
X-Gm-Message-State: AJIora+lemcSreRlsVHuB3LwXM5EvQRV321PqKVYbMxz0AS8GnoiPyNI
        MoVtwngBCVKW4pvWGn27teguGg==
X-Google-Smtp-Source: AGRyM1tvP+OO0SmnQYGC7LibmC0Kz2CVR4dR960v67NeiiUXbfSuqA0UdzFAVQMUT9w2HiCxRrmjuQ==
X-Received: by 2002:a05:622a:1a95:b0:31e:f660:6775 with SMTP id s21-20020a05622a1a9500b0031ef6606775mr15312825qtc.1.1658856442557;
        Tue, 26 Jul 2022 10:27:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d16-20020ac85350000000b0031eb51dd72csm9401639qto.85.2022.07.26.10.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:27:22 -0700 (PDT)
Date:   Tue, 26 Jul 2022 13:27:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] config.c: NULL check when reading protected config
Message-ID: <YuAj+eBajf6jkJPc@nand.local>
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 26, 2022 at 05:09:32PM +0000, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
>
> In read_protected_config(), check whether each file name is NULL before
> attempting to read it. This mirrors do_git_config_sequence() (which
> read_protected_config() is modelled after).

s/modelled/modeled

> Without these NULL checks,
>
>  make SANITIZE=address test T=t0410*.sh

I'm glad that t0410 was catching this for us already, though it is too
bad we didn't see it outside of the ASan builds, or I think we could
have potentially caught this earlier.

Either way, I think the test coverage here is sufficient, so what you
wrote makes sense.

> diff --git a/config.c b/config.c
> index 015bec360f5..b0ba7f439a4 100644
> --- a/config.c
> +++ b/config.c
> @@ -2645,9 +2645,12 @@ static void read_protected_config(void)
>  	system_config = git_system_config();
>  	git_global_config(&user_config, &xdg_config);
>
> -	git_configset_add_file(&protected_config, system_config);
> -	git_configset_add_file(&protected_config, xdg_config);
> -	git_configset_add_file(&protected_config, user_config);
> +	if (system_config)
> +		git_configset_add_file(&protected_config, system_config);
> +	if (xdg_config)
> +		git_configset_add_file(&protected_config, xdg_config);
> +	if (user_config)
> +		git_configset_add_file(&protected_config, user_config);
>  	git_configset_add_parameters(&protected_config);

I wonder: should it become a BUG() to call git_configset_add_file() with
a NULL filename? That would have elevated the test failure outside of
just the ASAn builds, I'd think.

There's certainty a risk of being too defensive, but elevating this
error beyond just the ASan builds indicates that this would be an
appropriate layer of defense IMHO.

Thanks,
Taylor
