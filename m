Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10C33E37B
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224155; cv=none; b=NoapltXGUP13Y5QCcp6zVDhQ9WD8u0WGUC7iI3L/2QfQtrtpSeRzNvnCATQZlgWAPo8B2RrgeQ3s/idhQZXzc1MFeVK4/sxFm3N5r9YyF9Nc35jW9amRN8aQhpN2wyp8HBotpKBJKW29NNDM5R5V74DLDd3BaZs08RjtyuJRIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224155; c=relaxed/simple;
	bh=SYlFQl8EpLgDSuGr4qPS+vNLeJoFDL4wxG/iDbpuW0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvOqikZdAWS37d0h0rXDL+aGXXFEaUmhI0ZDwDtHe0sTBJcKPdiMPzSYAZGMUikVUbrYUiH0PWBibCxvCbzS/TAwO7J+O9lttRxxkjKkiwOxxMOQg8yUHRSs0eHVf+3OaQFd2VHa5+3jWPHPFL7Y5IhcmDiEHY5m4u9UfR84oAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW3IvCIq; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW3IvCIq"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43590777e22so38480f8f.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 08:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770224153; x=1770828953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oX96azEFZi7R2pQQ1lSXwv+ELP22SIBxRhLs+j6KjiY=;
        b=ZW3IvCIqHmUTYZvZtPAOtmpsldA1aRR/lN3CGbkouqUleRS8onuqNnJfDyldTZh3aF
         2FL8pw3xEC/OwD8M1OkSy+moB5vZJi4vqSnjs+9TPn8VVJ21U0CWe4BMJUrWn0bUWvh8
         dOqDZT3GLmAg+cvh8PgMLlbIJTDJlm+gXpcp9HO7yqNHRoVmsi+zC1c/pddm4BXceYYF
         yaE9ler34S24ChrdFTVgXfm55dZXhWb7K27VpZ6p+oRaKWL0a/EDAMY22dkY45U/OSyt
         aE7ZSNt2uLR6MXBsfU+A5kviekceRyNdJZVMxNoLbmwNAdU9yQR2CqUVFd9SQJzlWqre
         sNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224153; x=1770828953;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX96azEFZi7R2pQQ1lSXwv+ELP22SIBxRhLs+j6KjiY=;
        b=VX53ytvcv6G1UWUyVkuO4ve51M0UHEtpeX/QpbtQKq9vdg/8GYsO0CclwBKF9UTIA0
         5nhfJ1UOPkm2wtyt+5xdtCa05zUathwxQO6JFTdszDzJGkyb4V8rfbSwQBctOY3yteqx
         JfKdP5bRiLClzQH9k89XakG9mFRaZGBX2/BAsnm9keT7XkUEhdK6APcjbqdsw7dvbHdk
         4IO/4YMV5rhllMtQ60gqDlm7G9C3WtHe1d+MuIzcfXalQNfCJNhsNc2LzsVxgHP7BoiL
         1+i/D84VzLuHARBVR1QDVd3G8LioZVBC3Eqqxzk4f3lRgABXMwPnmEIfvVNEUDah2qxt
         a0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/jlJb07I7GmggR8GcVL7bZJAH8xnpMB3JAR8oZYtRAFxKRDKXwmrDIcREwEoqp1SSk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GcqVP2mvubfocie3+LPpT6TfRKD7FD7xiwrVjHdT1L3oKXyH
	p7j1GcTq1sWBladSjbjzfIO6HrtNNeUxwXJAUt8Xfmr6EcOkSbdz0NDo
X-Gm-Gg: AZuq6aIxHRzHk7i5Xipd28Pyne1j8kfD5tO9N4d3NVzSrqU9EUeRC82TQt6pH0dUt+m
	IKZODyQ9VmoWLlRY+fMjjI4k/Iby+AhKhvu76OioNJrGA6cF28Ci+gMf+u5jfkFvLUoG1WFpaSr
	j3uJn/HZjlRM5WwoOYMUOC3aXe46MuWQJAeeXFXXv58NhCkbn/gYKouMdoOchTI7NHyXZeXG7Eh
	bNXAMsCDdSjKhBPGuxMyyrui/873nRtsJ5OHw+ZKpt013EGZV/1VSsQIjlZB1Ijx4BW8I6CJcxy
	lBSH10SfV628+aKeaC9tyX+ujjxOPjpinto8vezsQ16dZOP6jBo1sN7avwGK4z95al74rxOqLt3
	YybI9AL2PO5rJg3C7ZLwcjBK4DnmsID44Wx0PbNR+86vJ9HJE55KUIJaDQ+NGAsIbgi3poX1nNO
	iVjoWIKpzTxYbJ2zxvMYOpj6gUFNdi6lG/LSSb7aBfrG9p5+m0PrckL6nA6B/S7xww3A==
X-Received: by 2002:adf:f048:0:b0:436:19f6:31b0 with SMTP id ffacd0b85a97d-43619f631fbmr2712103f8f.4.1770224152851;
        Wed, 04 Feb 2026 08:55:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e37e78sm8191782f8f.10.2026.02.04.08.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:55:52 -0800 (PST)
Message-ID: <534b70cc-e1e9-432c-932c-73215d9a4632@gmail.com>
Date: Wed, 4 Feb 2026 16:55:51 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 2/3] environment: stop using
 core.sparseCheckout globally
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com,
 karthik.188@gmail.com
References: <cover.1770127568.git.belkid98@gmail.com>
 <8645b4f5952a98ed32180466fc40a184c61081b5.1770127568.git.belkid98@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <8645b4f5952a98ed32180466fc40a184c61081b5.1770127568.git.belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/2026 15:42, Olamide Caleb Bello wrote:
> The config value `core.sparseCheckout` is parsed in
> `git_default_core_config()` and stored globally in
> `core_apply_sparse_checkout`. This could cause it to be overwritten
> by another repository when different Git repositories run in the same
> process.
> 
> Move the parsed value into `struct repo_config_values` in the_repository
> to retain current behaviours and move towards libifying Git.

This looks good, I've left a small style comment below

> diff --git a/builtin/clone.c b/builtin/clone.c
> index b19b302b06..0005fd7118 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -617,13 +617,14 @@ static int git_sparse_checkout_init(const char *repo)
>   {
>   	struct child_process cmd = CHILD_PROCESS_INIT;
>   	int result = 0;
> +	struct repo_config_values *cfg = repo_config_values(the_repository);

We normally have a blank line between the varibale declarations and 
statements. As you're adding a new declaration here it would be good to 
add a blank line as well. The same goes for dir.c and sparse-index.c below.

Thanks

Phillip

>   	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);

 > diff --git a/dir.c b/dir.c
 > index b00821f294..0e05b3a383 100644
 > --- a/dir.c
 > +++ b/dir.c
 > @@ -1551,7 +1551,8 @@ enum pattern_match_result 
path_matches_pattern_list(
 >
 >  int init_sparse_checkout_patterns(struct index_state *istate)
 >  {
 > -	if (!core_apply_sparse_checkout)
 > +	struct repo_config_values *cfg = repo_config_values(the_repository);
 > +	if (!cfg->apply_sparse_checkout)
 >  		return 1;
 >  	if (istate->sparse_checkout_patterns)
 >  		return 0;

> diff --git a/sparse-index.c b/sparse-index.c
> index 76f90da5f5..cb4c99dcae 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -152,7 +152,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
>   
>   int is_sparse_index_allowed(struct index_state *istate, int flags)
>   {
> -	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
> +	if (!cfg->apply_sparse_checkout || !core_sparse_checkout_cone)
>   		return 0;
>   
>   	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
> @@ -670,7 +671,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
>   
>   void clear_skip_worktree_from_present_files(struct index_state *istate)
>   {
> -	if (!core_apply_sparse_checkout ||
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
> +	if (!cfg->apply_sparse_checkout ||
>   	    sparse_expect_files_outside_of_patterns)
>   		return;
>   
