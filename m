Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6733FE2B
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092868; cv=none; b=d/UThj25MjAd1PfMTK2JuwDaHfazMDBRD5qNQc0wQcPYl4nz40hkqDv4627K7yWSp9MY6RJwTOyPNCT+4gA9Tr1/RaTOYbxcs3Kv9A+zmn7xRidLnS52/qY00H2ixNEVGGIZkTVFXA5St4omrPOjYPXhJoPAGjbixO+O8xO1bhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092868; c=relaxed/simple;
	bh=Lt9S/FC+60b+Wt9+BHeFGzjvIVgPdhsMR/NGdJ7Xzok=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X/PTN/cxXGkr0EyH8OHKaBOZy0elSA9ZcVHREoJ77lvkz5VZYy7Ms1pWqO43EQBtRmOKTv2/89MU+tD/uT7Qs1FSPZAPBZJwdZdeOvfpCwo4qCGgC3vzR0QaxpD/IO/X0ZiqpzdI1M0WMXlCdn201fsD5SSAMKr1fbiG5y43OPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKVuAaF2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKVuAaF2"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b884a84e622so79072566b.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 06:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769092864; x=1769697664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fbSuDHPOJBvMg7zMIJSPiF/dA/5/BsbQR91l72egemE=;
        b=IKVuAaF2/XTLND2L2Q1PmT8a+JqGrWgmqVXQK8eInbZ0dCKdxT/+SUDjNNdolsJ0k0
         KQ0g2usyq3UX+4KPFEJJJ4Y4USw0hltoym1VfxbNHR949FUodWpNUOU7gy/ksZVv7yar
         fvmlSqVVeo/K2+/ENdp5NwZlifH7MbDjs1nrw0b8ZbnNzzOen/3WtpOTtUM1TzXIXF0n
         kS62SANRLjb4tPCWpYL5SM0RHAfuAJvepxyt/aSw96vSNYbbvNoVdgGqMstOqzvMmxL7
         eWpUg3HZsZl/+HPcvl0qYW+K8WdpU7R5lhoeSFTk4H0ySsh63IQRscuR1kjxltR+fNqd
         68RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769092864; x=1769697664;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbSuDHPOJBvMg7zMIJSPiF/dA/5/BsbQR91l72egemE=;
        b=St2CfrOr/uRsgT9xbH+fNtgPfu/+Jfb2LvNHhMzIjfV8pYFUK3+5RGvru2WcGYj8/T
         M01g/jbJNalG5NuvnJof+505ZDPELAIkNxqPcjZJ5vrXBH6ZW0fZV6sJX9pTSC6YAKN2
         eR5Tw0uGo3KF1rOLzINHW2utWujinT60IhBTVuDtlooHi+uW3OPsXeaaodsHI1DaLHJX
         1g4Js4DNBpqfAZ4trlp5YGVrGAA3GoczoZnJpnxx59ce+Rab8fHeakOI8ctXysnGPF1a
         Jn75SWK5HqQVRlpEE/EAbmxCM+qhszonwNJn6j7fbzEGFG3bcefD4aeYq+BFidIf7L8D
         MayQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0/dIm/TGmhw4hRLzrvpQKawgCBMakxXre7XvRJSqu+2oesugJOHbjKxir03FS8AwO6I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVvkVQbxsxdFqaq+MlUKQm7s5oNJJms/tKeRszEaz2cVPpCD1+
	79pTiwtEEpFspiXni+S2EyhsuuTcmp5tCTMRnS9UVb+9A9b8Jh2PqZ49
X-Gm-Gg: AZuq6aKPQv7sEhN6RsVxsI0/gCSHZaKyJy0oSRoJR/v9quZA6iU58nHelbX/aepUcjZ
	9ZYh1pVs3P2ELPzBqjGzE9imQZGWOWCGEYLUNdP5E5Rkpb2mCZRu+758Ztoi3AH4W66oentjsDL
	NbL0X1AP+BieWJ6yv+R932PDiu0sQxaB8XC0hQjiPIC8lhpqi/74dMpaJYCqL2PRofiQJCl5ERw
	YWFqZibn4oY8aVNk3pJv68UKyBG7pvq+Lg0+jzFc0BB+Q3p+c77kONZqEIqZN1pZzE8TS1UfmkS
	d2SszxP7OucUT82iotpJj/SgQQ4c/AuiSolHl7hvTGgaSVgVy+PijhDeX27qBWzFoFANi5hqXax
	EyoYym3OZJ4ADCweVyY8Znlii0c58zFpBdhkg8bji1SELxpkmPieH2AHrwrp2BhdzcvE0WCHQMi
	gMEzak1tmsHdXe5hMnzhUll9Ez6+zLKAQYViLVbxkCz+hjGwQvuavZ6zzkev5UlJIvEw==
X-Received: by 2002:a17:907:1c83:b0:b86:f7cb:2da8 with SMTP id a640c23a62f3a-b879300374dmr1964067166b.59.1769092863881;
        Thu, 22 Jan 2026 06:41:03 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b884006d3bbsm74018766b.32.2026.01.22.06.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 06:41:03 -0800 (PST)
Message-ID: <18b5d932-8a5a-4f33-a803-ef6f0c7d2750@gmail.com>
Date: Thu, 22 Jan 2026 14:41:02 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [Outreachy PATCH v3 2/3] environment: environment: stop using
 core.sparseCheckout globally
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com,
 karthik.188@gmail.com, Toon Claes <toon@iotcl.com>
References: <cover.1768681947.git.belkid98@gmail.com>
 <fd95169de42891452b430814476d78c706e4a7e2.1768681947.git.belkid98@gmail.com>
Content-Language: en-US
In-Reply-To: <fd95169de42891452b430814476d78c706e4a7e2.1768681947.git.belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Olamide

On 17/01/2026 20:59, Olamide Caleb Bello wrote:
> The config value `core.sparseCheckout` is parsed in
> `git_default_core_config()` and stored globally in
> `core_appy_sparse_checkout`. This could cause unintended behaviours
> when different Git repositories running in the same process access this
> variable.
> 
> Move the parsed value into `struct repo_config_values` to retains current
> behaviours while achieving the repository scoped access.

It doesn't achieve repository scoped access though because we only ever 
populate the values in "the_repository", all other instances of "struct 
repository" are initialized by config_values_init() but not the config 
settings.

> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index e80fc1b694..5fc8c51ed1 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -139,7 +139,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>   	repo_config(repo, git_default_config, NULL);
>   
>   	if (ctx.sparse < 0)
> -		ctx.sparse = core_apply_sparse_checkout;
> +		ctx.sparse = repo->config_values.sparse_checkout;

Using "repo" rather than "the_repository" here is dangerous because only 
"the_repository" contains the parsed config. This applies throughout 
this patch.

>   
>   	result = do_backfill(&ctx);
>   	backfill_context_clear(&ctx);
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b19b302b06..b6b19e83d1 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -623,7 +623,7 @@ static int git_sparse_checkout_init(const char *repo)
>   	 * We must apply the setting in the current process
>   	 * for the later checkout to use the sparse-checkout file.
>   	 */
> -	core_apply_sparse_checkout = 1;
> +	the_repository->config_values.sparse_checkout = 1;
>   
>   	cmd.git_cmd = 1;
>   	if (run_command(&cmd)) {
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 53cccf2d25..525edb5e9c 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -482,7 +482,7 @@ static int grep_submodule(struct grep_opt *opt,
>   	 *	"forget" the sparse-index feature switch. As a result, the index
>   	 *	of these submodules are expanded unexpectedly.
>   	 *
> -	 * 2. "core_apply_sparse_checkout"
> +	 * 2. "sparse_checkout"

That should be something like config_values.sparse_checkout to make it 
clear that "sparse_checkout" is the name of a member of a struct, not 
the name of a variable.

> diff --git a/environment.h b/environment.h
> index aea73ff25b..3b5ff7094a 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -88,6 +88,7 @@ struct strvec;
>   struct repo_config_values {
>   	/* core config values */
>   	char *attributes_file_path;
> +	int sparse_checkout;

There are several other sparse checkout variables like 
core_sparse_checkout_cone that we'll need to convert in the future so 
"apply_sparse_checkout" or "sparse_checkout_apply" would be better names.

Thanks

Phillip


>   };
>   
>   /*
> @@ -169,7 +170,6 @@ extern int precomposed_unicode;
>   extern int protect_hfs;
>   extern int protect_ntfs;
>   
> -extern int core_apply_sparse_checkout;
>   extern int core_sparse_checkout_cone;
>   extern int sparse_expect_files_outside_of_patterns;
>   
> diff --git a/sparse-index.c b/sparse-index.c
> index 76f90da5f5..6dd8dd679d 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -152,7 +152,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
>   
>   int is_sparse_index_allowed(struct index_state *istate, int flags)
>   {
> -	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
> +	struct repo_config_values *cfg = &istate->repo->config_values;
> +	if (!cfg->sparse_checkout || !core_sparse_checkout_cone)
>   		return 0;
>   
>   	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
> @@ -670,7 +671,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
>   
>   void clear_skip_worktree_from_present_files(struct index_state *istate)
>   {
> -	if (!core_apply_sparse_checkout ||
> +	struct repo_config_values *cfg = &istate->repo->config_values;
> +	if (!cfg->sparse_checkout ||
>   	    sparse_expect_files_outside_of_patterns)
>   		return;
>   
> diff --git a/unpack-trees.c b/unpack-trees.c
> index f38c761ab9..2bdfa1334c 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   	if (o->prefix)
>   		update_sparsity_for_prefix(o->prefix, o->src_index);
>   
> -	if (!core_apply_sparse_checkout || !o->update)
> +	if (!repo->config_values.sparse_checkout || !o->update)
>   		o->skip_sparse_checkout = 1;
>   	if (!o->skip_sparse_checkout) {
>   		memset(&pl, 0, sizeof(pl));
> diff --git a/wt-status.c b/wt-status.c
> index e12adb26b9..a2e388606f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1764,7 +1764,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
>   	int skip_worktree = 0;
>   	int i;
>   
> -	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
> +	if (!r->config_values.sparse_checkout || r->index->cache_nr == 0) {
>   		/*
>   		 * Don't compute percentage of checked out files if we
>   		 * aren't in a sparse checkout or would get division by 0.

