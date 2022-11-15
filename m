Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD95DC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 19:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiKOTA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiKOTAy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 14:00:54 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4382FFC3
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:00:53 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso9099499otn.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHQ4gB/P8d+E6zV4K7Ve1mcYfZMYLa75azo7CJitYcM=;
        b=XakY3GFshoPYoJuAfaH9xfQzuUHoijWYgBvkqzCI+FgeVvR/GBrB8Ws8CVuAuS1kei
         nVCAAABRg2+ZYPh1Z4fNHtTAooHjvA4cHsGuXPysHmg1j5NSETYLKeVLsvY/TY9dGz+G
         YxMyFXQ+vDf4Q6doUn9p17XFpI5I3LEi8MGAOghbYyt3z9tmXUtrtS6EAuBdxi/H48Wj
         hhiTOeE54xWZLied4kOdmkH/XRgfx8hrBdUw8borrcEZ5hYN0ewgA6I0gmDyvwBmYDJY
         B2aXipNd1wdvUD2qVqXoOaFhSu2XStz55TAVnLcdsCUuNXrzn0xIOcpYB/lzbvkUAcrk
         A0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHQ4gB/P8d+E6zV4K7Ve1mcYfZMYLa75azo7CJitYcM=;
        b=nvgiFsqfzxktiefksQ4P73EKqKB6K94Zcdg6BmkyAC7UGQkWHSs4KG1y2KBvSxiPUN
         hO0xhsY2X2tIluEQ4+juBYavGQKokRXmGtHyzSe7BuvlPcWe2Fg+qQvB0o34RoMV5Xkz
         zLMD7BgOOMOhkgqKbZ6+RwNy7e3vAvpmyHfL7iz1bw6f7w1Qsz8t6591jpaaJIma8Nne
         x8LZCKEZxK6NoucdBUhgDPcfNDK0bgBgz2nJbHsznROcKR1OEgyS4TKH3djmagplDl8u
         FRgg45fu+b1b+Hkmq7v8L+m3xGK1pDb+kJdpI7rI6iiIgcwMOgQWMG1+e2MAyQ/PviZX
         leRQ==
X-Gm-Message-State: ANoB5pneo6VzByJYRixj2GrdldV2gLXSOkjC4qI5J1MGSEbSwYIdsEry
        nVzCSDIJ6h1uwLRqUm5CdogEWcwNXLMI
X-Google-Smtp-Source: AA0mqf7vup7myWqq8sCXxf2ZiKu3IUHi+jptuIc1Wl/hfOoS2tFtIDBUZalgxSaIfzRKjTm5F4XhAQ==
X-Received: by 2002:a9d:6197:0:b0:66c:4ed7:fea9 with SMTP id g23-20020a9d6197000000b0066c4ed7fea9mr9180794otk.57.1668538853051;
        Tue, 15 Nov 2022 11:00:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:cca4:48d4:db05:d3b7? ([2600:1700:e72:80a0:cca4:48d4:db05:d3b7])
        by smtp.gmail.com with ESMTPSA id q25-20020a05683022d900b006619f38a686sm5678793otc.56.2022.11.15.11.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 11:00:52 -0800 (PST)
Message-ID: <d8b732c9-ae41-bf1b-3bb1-6682493bee70@github.com>
Date:   Tue, 15 Nov 2022 14:00:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] builtin/gc.c: fix use-after-free in
 maintenance_unregister()
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        git-security@googlegroups.com
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ronan Pigott <ronan@rjp.ie>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15/2022 1:53 PM, Taylor Blau wrote:
> While trying to fix a move based on an uninitialized value (along with a
> declaration after the first statement), be0fd57228
> (maintenance --unregister: fix uninit'd data use &
> -Wdeclaration-after-statement, 2022-11-15) unintentionally introduced a
> use-after-free.
> 
> The problem arises when `maintenance_unregister()` sees a non-NULL
> `config_file` string and thus tries to call
> git_configset_get_value_multi() to lookup the corresponding values.
> 
> We store the result off, and then call git_configset_clear(), which
> frees the pointer that we just stored. We then try to read that
> now-freed pointer a few lines below, and there we have our
> use-after-free:

Makes sense why this needs to be pulled out to a larger scope, but
also why it's so easy to make this mistake.

> +	struct config_set cs = { { 0 } };
> 
>  	argc = parse_options(argc, argv, prefix, options,
>  			     builtin_maintenance_unregister_usage, 0);
> @@ -1551,12 +1552,9 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>  				   options);
> 
>  	if (config_file) {
> -		struct config_set cs;
> -
>  		git_configset_init(&cs);
>  		git_configset_add_file(&cs, config_file);
>  		list = git_configset_get_value_multi(&cs, key);
> -		git_configset_clear(&cs);

That the list depends on the configset and not exist as an
independent entity is non-obvious, but I'm sure is rooted
in some kind of memory-saving optimization.

>  	} else {
>  		list = git_config_get_value_multi(key);
>  	}
> @@ -1592,6 +1590,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>  		die(_("repository '%s' is not registered"), maintpath);
>  	}
> 
> +	git_configset_clear(&cs);
>  	free(maintpath);
>  	return 0;
>  }

Thanks for drilling down on this. LGTM.

-Stolee
