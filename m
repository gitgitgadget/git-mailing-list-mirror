Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9820AC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 00:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhKWAnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhKWAnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 19:43:09 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05989C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:40:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id q82-20020a627555000000b004a4f8cadb6fso1268722pfc.20
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fySS6m0qTrd9jmSFtZp9bmXh0pwfyTTbDkcHF6I58PE=;
        b=MGC1ZnjI2lWsjQ4b3JSeUtlNcobOv3CcpjGUKQDUSIwji+iXBrHZTJPETlIXiox10x
         e/R6n3aEWG2GMaObvwjgG1ZWAVRLmdxMBJaMM07aA2lw96zzJTDoHHSPbeQQto15cMJC
         oJWTGYpFXJALIlrHKpD3PNVNgfO5jLpOQ4z99gH/6zCO335CR8JWnSCooHVaxME+aXJN
         kLouzwjGnyOE4xc7+/FEJHLCHGA9tBvU77Xwf00DF6TYrbU6UEkxtvJLqrBExT2qF4Dq
         OaE+tD2+gTKOpxONvmyC4Mf5ToSboVL3GjQqmhMsPSLAQGaXZfKzKXfoWMnU43zA+FkY
         5jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fySS6m0qTrd9jmSFtZp9bmXh0pwfyTTbDkcHF6I58PE=;
        b=ZGBVuwxHueTkkMN/sntbh04I4ad0EZbE3UdI7HXyLsbfN3hmdOeGsrlACcJzb+W/Q4
         qifz3sZt0c3a3V/4Y623oGCf0iA3W0Tb/o7AnONpvyHXJ9X9Y/KED8/ql+W8JXA8MtAG
         dZMCj5iZPB5Xk0c3T3NlOBFnFy0JNM23YuJq4WbO4TxGpAZJx2KMUaJZu2TzUKU+E44r
         6ZBpyzHs8T9dTv6eMuLBM0sVuxYnKPuH7FDc2w1vi71bF9XSiwbSY+iD1ZjcRklCNGg4
         TEGLGeiSvTHVyLSf+YvtMyeLe8KitQnL1ct94lDfj84vKnFO2cDCuCntdvD1Hy3289Ay
         zwrA==
X-Gm-Message-State: AOAM53254L2TP3lgLCR1yYf+2/g7wUbrSM62UAFmjbzJUJENVu0/6Rd3
        vtwzCM6MKSQa4vq1CZUGi7jOfVHIRo39cA==
X-Google-Smtp-Source: ABdhPJxm+GP1uqQ2aE6IsQotj31vfvJYQOMuPJpdHivitsNYUOWdgYY777nwtkiq37o+kdRCTkDz7BF+MQKRBw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4b04:: with SMTP id
 lx4mr1340689pjb.11.1637628001502; Mon, 22 Nov 2021 16:40:01 -0800 (PST)
Date:   Mon, 22 Nov 2021 16:39:58 -0800
In-Reply-To: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
Message-Id: <20211123003958.3978-1-chooglen@google.com>
Mime-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
From:   Glen Choo <chooglen@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -3259,9 +3259,12 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  	closedir(dir);
>  
>  	strbuf_setlen(path, original_len);
> -	if (!ret && !keep_toplevel && !kept_down)
> -		ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
> -	else if (kept_up)
> +	if (!ret && !keep_toplevel && !kept_down) {
> +		if (the_cwd && !strcmp(the_cwd, path->buf))
> +			ret = -1; /* Do not remove current working directory */
> +		else
> +			ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
> +	} else if (kept_up)
>  		/*
>  		 * report the uplevel that it is not an error that we
>  		 * did not rmdir() our directory.
> @@ -3327,6 +3330,8 @@ int remove_path(const char *name)
>  		slash = dirs + (slash - name);
>  		do {
>  			*slash = '\0';
> +			if (the_cwd && !strcmp(the_cwd, dirs))
> +				break;
>  		} while (rmdir(dirs) == 0 && (slash = strrchr(dirs, '/')));
>  		free(dirs);
>  	}

I don't think it's appropriate to implement user-facing concern (don't remove 
cwd because this will confuse users) in library functions like remove_path().
remove_path() has other callers e.g. midx.c, and possible future callers e.g. 
we're working on adding a command to delete corrupted commit-graphs and this 
library function would be extremely handy.

It seems more appropriate to check the_cwd from builtin/add.c and builtin/rm.c 
instead.
