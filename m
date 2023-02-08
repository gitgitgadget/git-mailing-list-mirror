Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435FEC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 14:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBHOWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 09:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHOWl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 09:22:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02039FC
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 06:22:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u10so10379771wmj.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 06:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Myme79IlO+hs3G3VhvW3/rdtFh2C1QcLifyBB4ayrLI=;
        b=qXNkNpGnj9f1+4qFQBtQoRSC2blvpSEH5asKZH8qgZeWY+i6YgCp4VAr5MzM7vP9zC
         MQ28cco8u2YuEx07UTq67fdnZv5QubPyhZSPNSiGID9WYGPToatzK0BP8lKXqsqL2MJQ
         C4Mq0yEotziF9IHib9ygc0mpSurac4IdFdVgD+D0YB23ez9V17LJSfszVJ0kWis7uWrY
         VbfQ42h24ZLCLThVIGni3KzLobGBw27vTyW7BimeCNzdh++Ns7h+pc0riX6/WURNQ4WL
         1H3+62rBjmpHrg/4yEnqjJql6OqoahTm79ow/+C9rC7t+obmV7BeiCiBU7VITEh6Vp+Z
         pDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Myme79IlO+hs3G3VhvW3/rdtFh2C1QcLifyBB4ayrLI=;
        b=NjpfNAib49HOYEk5eJFbl3FKVGOpZL4MxIEzVODFRyid75zERMSQQgjUgo5soS/Gvw
         GHMWUHODkKmxBRishnSmVOUyuruCol5ZhAAhNfjQlzyu0SnZMRDz0wTbv9Ga8GY6ZzYV
         LNwC9KKD8oufBj/Hhr+gke69pfXmwO+wMPK7MiMMNntKAI6n9V3/RbGX0psfHqP6fWzV
         pzgp2zkKN34UDXOyrBsIqaczdQU/ZJ7I7NeA/cbyRqg3uDi5133AHWVSlg8YbDYoVKtp
         7Po7KprgV3kwlGmae4zVVegkX/+ffGpiX9E1adfwOVjs9975KBto+gaxVL52GpPQVuKH
         solg==
X-Gm-Message-State: AO0yUKVrwf+SS2uSGYmWOfNVR66GK6e61bnywLneFSm8zhIqwTpkSVhK
        EM9tfJeTJzjhjqgFPxfKy70=
X-Google-Smtp-Source: AK7set+S1m/4TPRXFSdPl5X6BX9zhZ7plGtR0n04bOWGhRgv35V+HctLusxFzIbbW9Fo5j+ZE67YzA==
X-Received: by 2002:a05:600c:3298:b0:3dc:4d94:62de with SMTP id t24-20020a05600c329800b003dc4d9462demr6600886wmp.14.1675866155591;
        Wed, 08 Feb 2023 06:22:35 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b003dc34edacf8sm2391682wmq.31.2023.02.08.06.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 06:22:34 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <c9b10e8b-641c-ff29-95a4-2ac3f3219c0d@dunelm.org.uk>
Date:   Wed, 8 Feb 2023 14:22:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 6/7] diff-lib: refactor match_stat_with_submodule
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-7-calvinwan@google.com>
In-Reply-To: <20230207181706.363453-7-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 07/02/2023 18:17, Calvin Wan wrote:
> Flatten out the if statements in match_stat_with_submodule so the
> logic is more readable and easier for future patches to add to.
> orig_flags didn't need to be set if the cache entry wasn't a
> GITLINK so defer setting it.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>   diff-lib.c | 28 +++++++++++++++++-----------
>   1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/diff-lib.c b/diff-lib.c
> index 7101cfda3f..e18c886a80 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -73,18 +73,24 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
>   				     unsigned *dirty_submodule)
>   {
>   	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
> -	if (S_ISGITLINK(ce->ce_mode)) {
> -		struct diff_flags orig_flags = diffopt->flags;
> -		if (!diffopt->flags.override_submodule_config)
> -			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
> -		if (diffopt->flags.ignore_submodules)
> -			changed = 0;
> -		else if (!diffopt->flags.ignore_dirty_submodules &&
> -			 (!changed || diffopt->flags.dirty_submodules))
> -			*dirty_submodule = is_submodule_modified(ce->name,
> -								 diffopt->flags.ignore_untracked_in_submodules);
> -		diffopt->flags = orig_flags;
> +	struct diff_flags orig_flags;
> +
> +	if (!S_ISGITLINK(ce->ce_mode))
> +		return changed;
> +
> +	orig_flags = diffopt->flags;
> +	if (!diffopt->flags.override_submodule_config)
> +		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
> +	if (diffopt->flags.ignore_submodules) {
> +		changed = 0;
> +		goto cleanup;

Looking ahead to patch 7 there are no new uses of the "cleanup" label so 
I think it would be simpler to leave the code as it was, rather than 
changing the "else if" below to "if" and adding the goto here.

Best Wishes

Phillip

>   	}
> +	if (!diffopt->flags.ignore_dirty_submodules &&
> +	    (!changed || diffopt->flags.dirty_submodules))
> +		*dirty_submodule = is_submodule_modified(ce->name,
> +					 diffopt->flags.ignore_untracked_in_submodules);
> +cleanup:
> +	diffopt->flags = orig_flags;
>   	return changed;
>   }
>   
