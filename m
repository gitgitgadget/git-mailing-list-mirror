Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B438ECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 13:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiIWNIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 09:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiIWNIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 09:08:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E5A139BC8
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 06:08:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o5so191060wms.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xowdi3xTk6sUaxe7m9llh2XCKV0Flalg7AriSk2FZQM=;
        b=AiRCT+xOy47XKKTUgehyrChF3LTD7/czmKWpYfDAOTbpIjhm/nhe2jLcFds/Src3hn
         WL2pV5/ctgyusCzlBc/4BhqphgZTJtg504DkR6xD3nZQbFCdqLeqI0uO/EQUpxxeTowD
         zYT7C7nN4vmpIge7RTGMfYuXZHm9bj0sAcTfRzqfMFhJa44Ll51W3bQ0gEMuTDYTYSSj
         j80OVEDE/3mxMpaT8tTC7FYToy8Wtuq5Ns+0zPUPyXABU1YJWKSqwuEHRWnqte+u8rgG
         ItQTRk92xmewls+aejLtKyvl9p/+i4GFdH1Tx/QQq9ZETTMIUBdVHJRZMZRAlVTJDBrQ
         nbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xowdi3xTk6sUaxe7m9llh2XCKV0Flalg7AriSk2FZQM=;
        b=mt+dw9QHByqHEHDMiKlbwWOawHQJWdJllnzHfzTFDZVDOsZyYGaxKXcZKm29tpV94F
         rY773H55KNwu09xok+U8XdTUtm9tGKp4h1sW7nwPMgy9apRgNZTkzGvnTeMMek3drO8W
         cBMmesg9KlJgJrQcqVdoS7yjhgSILcgstmuD/re+nBE3BftFKFxSBuPhtYr4A69splf3
         IF13kM+6dB3Yhqhwb5R3e0KbihXudoQRrLtA8uxPleDKntIo6UNgNW+6xTqnmal6cXAR
         X3jA+WJAPf6tWJmj8SCfL76o+KBIT2aeB8ldW3mY8Dlz+fqfS6r9yLb0Q4xP4h1eMoyL
         hrcg==
X-Gm-Message-State: ACrzQf2af3jF7S6mPKyoViuGweb2y9W51mSkYZY9VOpHOYCPUYevcx/5
        8OuJSoZwTtyiyuFiTdIFxNc=
X-Google-Smtp-Source: AMsMyM7LkGFZc874HJImpw40uCvfd6caxA++YRD1KKWD1qQ8IakfLwZinA+lHUpIYTuTDiNhs7rgxA==
X-Received: by 2002:a05:600c:4f8e:b0:3b4:ab30:9af4 with SMTP id n14-20020a05600c4f8e00b003b4ab309af4mr6045814wmq.84.1663938515815;
        Fri, 23 Sep 2022 06:08:35 -0700 (PDT)
Received: from localhost (84-236-109-46.pool.digikabel.hu. [84.236.109.46])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6b02000000b00229e0def760sm7429838wrw.88.2022.09.23.06.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:08:34 -0700 (PDT)
Date:   Fri, 23 Sep 2022 15:08:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/2] maintenance: add 'unregister --force'
Message-ID: <20220923130832.GA1761@szeder.dev>
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
 <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
 <69c74f52eefd906c38494759a02e137e4d7c01d8.1663853837.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69c74f52eefd906c38494759a02e137e4d7c01d8.1663853837.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 01:37:16PM +0000, Derrick Stolee via GitGitGadget wrote:
>  static int maintenance_unregister(int argc, const char **argv, const char *prefix)
>  {
> +	int force = 0;
>  	struct option options[] = {
> +		OPT_BOOL(0, "force", &force,
> +			 N_("return success even if repository was not registered")),

This could be shortened a bit by using OPT__FORCE() instead of
OPT_BOOL().  OTOH, please make it a bit longer, and declare the option
with the PARSE_OPT_NOCOMPLETE flag to hide it from completion:
'--force' is usually used to enable something potentially dangerous,
and therefore should be used with care, so our completion script in
general doesn't offer it, giving the users more opportunity to think
things through while typing it out.  Though, arguably in this
particular case it seems there is not much danger to be afraid of.


> @@ -1538,11 +1545,23 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>  		usage_with_options(builtin_maintenance_unregister_usage,
>  				   options);
>  
> -	config_unset.git_cmd = 1;
> -	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
> -		     "--fixed-value", "maintenance.repo", maintpath, NULL);
> +	for_each_string_list_item(item, list) {
> +		if (!strcmp(maintpath, item->string)) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (found) {
> +		config_unset.git_cmd = 1;
> +		strvec_pushl(&config_unset.args, "config", "--global", "--unset",
> +			     "--fixed-value", key, maintpath, NULL);
> +
> +		rc = run_command(&config_unset);

It seems a bit heavy-handed to fork() an extra git process just to
unset a config variable.  Wouldn't a properly parametrized
git_config_set_multivar_in_file_gently() call be sufficient?  Though
TBH I don't offhand know what those parameters should be, in
particular whether there is a convenient way to find out the path of
the global config file in order to pass it to this function.

(Not an issue with this patch, as the context shows that this has been
done with the extra process before; it just caught my eye.)

