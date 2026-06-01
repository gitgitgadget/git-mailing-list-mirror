Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A13AEB4A
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323063; cv=none; b=nI+K7xXLZMrNU6PudWdZNAM7rRcwpmtEUfZg58kjsrMsszjoQ4m75jPuAA7+Ek6i2s9Yb/6b3Kdri+TNH3+tNKZRuUGR1w16ZzRO8fW/s29bNbFiyh2WBnWlM7flw5ZqznK1sSmAqIX69mfVIBG5Twz9cyztr/kMxikiozyvaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323063; c=relaxed/simple;
	bh=uz8iQs2hA5G8Z5MXNVIB2MxC3b31Psk6xyDp3Qje7Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcKn9J5PEUtJ8c/SbojNN7aRoT+03Qdrapsr1Q5wRCUDuTSXxNJTc9yMzOPZoUiao91AeIimTPUlgdhvpr2uwuhVxUU01Y2P3GGAN4c1T4M7Wry9vYkDNMPplsjBkkaTpK8yCX6Ajjy+g0PNh8dz+ScAjkUty1kYZyf+7DIQod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbIiwLIk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbIiwLIk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef5146b56so1749613f8f.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780323060; x=1780927860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BWk9+dZw5GrSK/OBrZdSCNXQWdrgzfhnBZttEEt4wGA=;
        b=ZbIiwLIkI/n+KwnRLZNj1cWPQdn5U4m5oGTAdjpfrrreFhetMk8aceVj5GHApITOqQ
         O5TLuE62P1DQ1J0XButXhi9e6DC47MagDqT1GvmplN/M2CgP/9sArTEITOvczcjYUCDz
         5ca+yYXwbOQlVgPOn5EFzhSt71OL3xEbtsIPh1FJZck1O3duNwC4Em0cLUGACtWJjZDF
         iNkweBoHdn1Y6Rj4LrkH9iVjt3UIjItyW1W1a+8QGQCMXDE45ZGwY3BYNMx6Cun+3ZxF
         1OLfA2K9/P6MdNMkNof4fWjZDKznoQSIgaOAFgwTdWKUl2NC2+T2fyK14aCsmdH7d6iO
         AO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323060; x=1780927860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWk9+dZw5GrSK/OBrZdSCNXQWdrgzfhnBZttEEt4wGA=;
        b=VS5QCmtU7xftf0QAbjOFJlUWDzKunxmKNCLd7skL1Q/csldpoQTNATsE5uxqKWcbwB
         k5kxS2zyilJcdO79OJhV/oTbOWxaRzGZdrtZp6Vn4G903l7xhZ+FpLnmjcMk1SDcLstF
         QZRpnN0uBQ3Mq4LNiauQmspTR7u9bkkvno24VB4Pm35QHBo+r36iUHUCqujM0rCjNCMu
         D+a7VFYHlvhVhEJQDUZwXt1ozeAuOY/ZLpcaeRBm0mLOX/iPnpzwlGouC8xC82Yu1rqy
         bXrJaKpeh5xdAvjdsDoC1sF6gJfxoa3mp8d5dHGYajK7oHa1cJZguXrfRo74kS/6SL6U
         eQlA==
X-Forwarded-Encrypted: i=1; AFNElJ+59Fw1xQ8tRB4kIYqVnSNwgRg0wbXDgVpFYrL8K60q3lX3J+s4lrxryXqm6/JcCkCDwhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcf/Ko74RM9Xlu4a9wiR24iiNoIOw+YFu7H78QI68rNZ/wtW7
	kUik+jGw5EtXcBmo+8q1Oj11m/ctKDoeocnuJH8li66P0lY2MBOKaCdT
X-Gm-Gg: Acq92OGDdp+r76y8OVSgzEAQCEhjC0rgO4ks4Lf890X/QUQq2BBIwC+gM19pUElsykt
	GeuLr3V8t0lU7QmGMvK/AQBbyU/nBX/PA9cmpccG5HCmTNGStPIDkJyx4+VPWRLDLbff4WrlFj2
	vUkoghCecSQMtpmaF0XzR054UHNjSP1O/h0f+41h1xidTofzp0siiQ3eCQcmbJzv1G7iBIfunOy
	GfXugic5FyS8NNwdKVvdetcVIk7DVp1+7AGo5ZKdsV6OCYiAtmSlNwXb5xyDARrMgQWz9usBucA
	d+TjYHbo85455FfhivGr8+xbbgmNHkxVB3cK6SuwNDLDjASPSnNXfLfn+2+4kZBW45EBq3tCiey
	rINmlZPSzveDFm05b9Cu8+uy6UK4/6J9RVWC7ZfMuDigOMQsMjcow5N+GC4z7NUQ5oDmm38zcJD
	JN4u+ZAWCJ6chjhZGD/QzdhK2pyH67F0v15WPH4d9rvMrxZiCxR51LienkewftaZfqMYLAZIvKc
	VoghnIj2dIU7Rng/eOSlSR2
X-Received: by 2002:a05:6000:4a0d:b0:44f:b82f:2d18 with SMTP id ffacd0b85a97d-45ef1347ab2mr20681879f8f.11.1780323059722;
        Mon, 01 Jun 2026 07:10:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a065esm26386951f8f.5.2026.06.01.07.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 07:10:59 -0700 (PDT)
Message-ID: <f1b662d5-f9bb-4274-ad42-3a2227d2a060@gmail.com>
Date: Mon, 1 Jun 2026 15:10:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] rebase: skip branch symref aliases
To: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
 <0ab0a717441e9fc7c494da194065a948a35a7f01.1779946921.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <0ab0a717441e9fc7c494da194065a948a35a7f01.1779946921.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2026 06:42, Son Luong Ngoc via GitGitGadget wrote:
> From: Son Luong Ngoc <sluongng@gmail.com>
> 
> rebase --update-refs records local branch decorations before replaying
> commits. If a decoration is a symbolic branch such as refs/heads/main
> pointing at refs/heads/master, updating it later dereferences back to
> master and can fail because the normal rebase path already moved that
> branch.

Good explanation, thanks for working on this.

> Resolve local branch symref decorations to their referents before

s/referents/targets/ ?

> queuing update-ref commands, and skip duplicates. This keeps branch
> aliases from scheduling a second update for the same underlying branch
> while still using the existing old-OID check for the single queued
> update.

That's not quite what the patch does though - it only checks that the 
target of the symref differs from the target of HEAD. If a symref points 
to another branch we still try to update it when we should skip it.

> Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
> ---
>   sequencer.c                   | 63 +++++++++++++++++++++++++++++------
>   t/t3404-rebase-interactive.sh |  2 +-
>   2 files changed, 53 insertions(+), 12 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 1ee4b2875b..4a83d1337c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6445,15 +6445,22 @@ static int add_decorations_to_list(const struct commit *commit,
>   				   struct todo_add_branch_context *ctx)
>   {
>   	const struct name_decoration *decoration = get_name_decoration(&commit->object);
> -	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> -						       "HEAD",
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	const char *head_ref = refs_resolve_ref_unsafe(refs, "HEAD",
>   						       RESOLVE_REF_READING,
> -						       NULL,
> -						       NULL);
> +						       NULL, NULL);
> +	char *resolved_head_ref = refs_resolve_refdup(refs, "HEAD",
> +						       RESOLVE_REF_READING,
> +						       NULL, NULL);

We need to use refs_resolve_refdup() instead of 
refs_resolve_ref_unsafe() so that the return value is not overwritten by 
the later calls to refs_resolve_ref_unsafe() that are added below. But 
that is the only change that is needed - we do not need to add a new 
variable, we just replace refs_resolve_ref_unsafe() with 
refs_resole_refdup() and free "head_ref" before we return.

> +	struct strbuf update_ref = STRBUF_INIT;
>   
>   	while (decoration) {
>   		struct todo_item *item;
>   		const char *path;
> +		const char *ref = decoration->name;
> +		const char *resolved_ref;
> +		int is_symref = 0;
> +		int flags = 0;
>   		size_t base_offset = ctx->buf->len;
>   
>   		/*
> @@ -6461,12 +6468,44 @@ static int add_decorations_to_list(const struct commit *commit,
>   		 * updated by the default rebase behavior.
>   		 * Exclude it from the list of refs to update,
>   		 * as well as any non-branch decorations.
> +		 *
> +		 * Resolve branch symrefs after checking for the current HEAD so
> +		 * that aliases do not schedule duplicate updates for their
> +		 * referents.
> +		 *
>   		 * Non-branch decorations may be present if the pretty format
>   		 * includes "%d", which would have loaded all refs
>   		 * into the global decoration table.
>   		 */
> -		if ((head_ref && !strcmp(head_ref, decoration->name)) ||
> -		    (decoration->type != DECORATION_REF_LOCAL)) {
> +		if (decoration->type != DECORATION_REF_LOCAL) {
> +			decoration = decoration->next;
> +			continue;
> +		}
> +
> +		if (head_ref && !strcmp(head_ref, ref)) {
> +			decoration = decoration->next;
> +			continue;
> +		}

This is just rewriting the existing if statement which has nothing to do 
with the stated aim of this patch - lets leave it as it was.

> +
> +		strbuf_reset(&update_ref);
> +		resolved_ref = refs_resolve_ref_unsafe(refs, ref,
> +						       RESOLVE_REF_READING |
> +						       RESOLVE_REF_NO_RECURSE,

Why are we passing RESOLVE_REF_NO_RECURSE here? I'd have thought we want 
to resolve the whole chain of symbolic refs to find out which ref is 
actually going to be updated.

> +						       NULL, &flags);
> +		if ((flags & REF_ISSYMREF) && resolved_ref) {

I think it is generally safer to check the return value before using any 
of the "out" parameters from a function call. In this case the function 
unconditionally clears flags at the beginning so it is safe.

> +			if (!starts_with(resolved_ref, "refs/heads/")) {
> +				decoration = decoration->next;
> +				continue;

This is the opposite of what I was expecting - if the decoration is a 
symref that resolves to a branch then that branch will also be in the 
list of decorations and so will be updated. If the decoration is a 
symref that resolves outside "refs/heads/" then we want to add the 
decoration to the list of refs to update to keep the current behavior.

If we do that then we skip all symbolic refs that point to another 
branch, instead of just skipping those that match HEAD and we don't need 
any of the changes below here.

Thanks

Phillip

> +			}
> +
> +			strbuf_addstr(&update_ref, resolved_ref);
> +			ref = update_ref.buf;
> +			is_symref = 1;
> +		}
> +
> +		if ((is_symref && resolved_head_ref &&
> +		     !strcmp(resolved_head_ref, ref)) ||
> +		    string_list_has_string(&ctx->refs_to_oids, ref)) {
>   			decoration = decoration->next;
>   			continue;
>   		}
> @@ -6478,19 +6517,19 @@ static int add_decorations_to_list(const struct commit *commit,
>   		memset(item, 0, sizeof(*item));
>   
>   		/* If the branch is checked out, then leave a comment instead. */
> -		if ((path = branch_checked_out(decoration->name))) {
> +		if ((path = branch_checked_out(ref))) {
>   			item->command = TODO_COMMENT;
>   			strbuf_commented_addf(ctx->buf, comment_line_str,
>   					      "Ref %s checked out at '%s'\n",
> -					      decoration->name, path);
> +					      ref, path);
>   		} else {
>   			struct string_list_item *sti;
>   			item->command = TODO_UPDATE_REF;
> -			strbuf_addf(ctx->buf, "%s\n", decoration->name);
> +			strbuf_addf(ctx->buf, "%s\n", ref);
>   
>   			sti = string_list_insert(&ctx->refs_to_oids,
> -						 decoration->name);
> -			sti->util = init_update_ref_record(decoration->name);
> +						 ref);
> +			sti->util = init_update_ref_record(ref);
>   		}
>   
>   		item->offset_in_buf = base_offset;
> @@ -6501,6 +6540,8 @@ static int add_decorations_to_list(const struct commit *commit,
>   		decoration = decoration->next;
>   	}
>   
> +	strbuf_release(&update_ref);
> +	free(resolved_head_ref);
>   	return 0;
>   }
>   
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 42ba8cc313..29447c0fc3 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1978,7 +1978,7 @@ test_expect_success '--update-refs ignores non-branch decorations' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_failure '--update-refs skips branch symrefs to current branch' '
> +test_expect_success '--update-refs skips branch symrefs to current branch' '
>   	test_when_finished "
>   		test_might_fail git rebase --abort &&
>   		git checkout primary &&

