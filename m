Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65F5C636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 10:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBGKpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjBGKpB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 05:45:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED31BD
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 02:45:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so10705988wmo.5
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 02:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWG8Jw0oJ9x6A5Hp95ssPs+hT8ksD4NiYlbp/Qq53yw=;
        b=KAuxNiSvZ7Oib3QuRvlbQ2M6sy8NTsDVS3N31DMGMPQGbHEFEcyMrXAHkQeOVi8rD+
         QJ0/KZXUfhLqbOKgc+6EKG8YDC23so/AAxovkeSj2pS2LMckF4QCiG9Mpm5v73o3wd9i
         5JyRy7m2veM1NnvRxs+FDeHCnPYFqQPFKePSfdhNPvpGL+neIOWKt5jYicWzFVCtMCRX
         B8qwJmcZqZQReeE0jcBXwCOkmizJ7W8K4QKiSB/5+h4aeVCeW+6vi6Uq8RdroyIEOKdU
         Hyti/QQ3Pclvu3bpXmAq4Q/dwCwUl5m/Pv0bCobgF2saehj+wa8tvXkkqgNecLIA+uze
         zGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWG8Jw0oJ9x6A5Hp95ssPs+hT8ksD4NiYlbp/Qq53yw=;
        b=1XK9754hAvt9JiyHaT5D/34ZvOruRKkx9zyZUpOSwcizfvZyRz6zpxWt/TvavThYKt
         55PMiwp1yYofLCHAcfkAVNLP2g6eewrArcL5hPWf73lypiT+klnwmmpl/v7tHc78TSML
         oalWa12bK7SlkKkZCwYbNPkcAfRBzUSdWBW9PG7cXEiZWu5P0IU/4iQEbEyK5lLDLd/v
         l4jBSUKwnCVoQ816OsAh0sD11uRFfiM1u/gnWe+H/Q3ceBfqJZDSx5RrfnTKd1/tCb6F
         yzgkCb/27lmHCLvSzvrBqXYNVgdJfo+WajhJHxczOP19qjuPJpT7CKcH0UvW3fbzoiMM
         rnBQ==
X-Gm-Message-State: AO0yUKUTfA4YVR9pprs6fm6k4YefZnAYmWyxkRt8AgijOD/ljAeub32Y
        C0vn2+ytL49NjT5nz84jy5k=
X-Google-Smtp-Source: AK7set+8tBymdMxkWSIb5nVfT9mO5+BP7yWcj4IgJRxz2V2aciPVNEAPTeWiZTIh/N+Pbt8l9ArF+g==
X-Received: by 2002:a05:600c:4484:b0:3dc:5805:9d75 with SMTP id e4-20020a05600c448400b003dc58059d75mr2601345wmo.18.1675766698774;
        Tue, 07 Feb 2023 02:44:58 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c2b4500b003dc434900e1sm12834781wmf.34.2023.02.07.02.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:44:58 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <fc671499-5650-0473-0850-41449d85e1c3@dunelm.org.uk>
Date:   Tue, 7 Feb 2023 10:44:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/4] worktree: introduce is_shared_symref()
Content-Language: en-US
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <d62842c2-1b27-4a40-f5bb-fc1dca5d2d77@gmail.com>
In-Reply-To: <d62842c2-1b27-4a40-f5bb-fc1dca5d2d77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rubén

I'm still not really sure why we want to make this new function public 
but the conversion looks fine. It does mean that the next patch has to 
add a loop to die_if_checked_out() though which we wouldn't need to do 
if we just changed find_shared_symref() to take an extra parameter to 
ignore the current worktree.

Best Wishes

Phillip

On 04/02/2023 23:25, Rubén Justo wrote:
> Add a new function, is_shared_symref(), which contains the heart of
> find_shared_symref().  Refactor find_shared_symref() to use the new
> function is_shared_symref().
> 
> Soon, we will use is_shared_symref() to search for symref beyond
> the first worktree that matches.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>   worktree.c | 62 +++++++++++++++++++++++++++---------------------------
>   worktree.h |  6 ++++++
>   2 files changed, 37 insertions(+), 31 deletions(-)
> 
> diff --git a/worktree.c b/worktree.c
> index aa43c64119..40cb9874b7 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -403,44 +403,44 @@ int is_worktree_being_bisected(const struct worktree *wt,
>    * bisect). New commands that do similar things should update this
>    * function as well.
>    */
> -const struct worktree *find_shared_symref(struct worktree **worktrees,
> -					  const char *symref,
> -					  const char *target)
> +int is_shared_symref(const struct worktree *wt, const char *symref,
> +		     const char *target)
>   {
> -	const struct worktree *existing = NULL;
> -	int i = 0;
> +	const char *symref_target;
> +	struct ref_store *refs;
> +	int flags;
>   
> -	for (i = 0; worktrees[i]; i++) {
> -		struct worktree *wt = worktrees[i];
> -		const char *symref_target;
> -		struct ref_store *refs;
> -		int flags;
> +	if (wt->is_bare)
> +		return 0;
>   
> -		if (wt->is_bare)
> -			continue;
> +	if (wt->is_detached && !strcmp(symref, "HEAD")) {
> +		if (is_worktree_being_rebased(wt, target))
> +			return 1;
> +		if (is_worktree_being_bisected(wt, target))
> +			return 1;
> +	}
>   
> -		if (wt->is_detached && !strcmp(symref, "HEAD")) {
> -			if (is_worktree_being_rebased(wt, target)) {
> -				existing = wt;
> -				break;
> -			}
> -			if (is_worktree_being_bisected(wt, target)) {
> -				existing = wt;
> -				break;
> -			}
> -		}
> +	refs = get_worktree_ref_store(wt);
> +	symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
> +						NULL, &flags);
> +	if ((flags & REF_ISSYMREF) &&
> +	    symref_target && !strcmp(symref_target, target))
> +		return 1;
>   
> -		refs = get_worktree_ref_store(wt);
> -		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
> -							NULL, &flags);
> -		if ((flags & REF_ISSYMREF) &&
> -		    symref_target && !strcmp(symref_target, target)) {
> -			existing = wt;
> -			break;
> -		}
> +	return 0;
> +}
> +
> +const struct worktree *find_shared_symref(struct worktree **worktrees,
> +					  const char *symref,
> +					  const char *target)
> +{
> +
> +	for (int i = 0; worktrees[i]; i++) {
> +		if (is_shared_symref(worktrees[i], symref, target))
> +			return worktrees[i];
>   	}
>   
> -	return existing;
> +	return NULL;
>   }
>   
>   int submodule_uses_worktrees(const char *path)
> diff --git a/worktree.h b/worktree.h
> index 9dcea6fc8c..7889c4761d 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -149,6 +149,12 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
>   					  const char *symref,
>   					  const char *target);
>   
> +/*
> + * Returns true if a symref points to a ref in a worktree.
> + */
> +int is_shared_symref(const struct worktree *wt,
> +		     const char *symref, const char *target);
> +
>   /*
>    * Similar to head_ref() for all HEADs _except_ one from the current
>    * worktree, which is covered by head_ref().
