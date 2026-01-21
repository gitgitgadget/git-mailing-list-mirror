Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242DB30ACF1
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012486; cv=none; b=aXFzdNU92rNoA13efZ2xAlAl8OLsSrgIWMxstIUU8yICGoDKulMlalgpkoi+OkQ8QhVdr+YZwxv7Ign7HprsDWen6tpXoJocxGI7F6VT5XRHzXPL60WuuUnYZg9Fgq4Xu2JMHtuoF+GNhW4tDUb7l62q7e8Hixg7UcaxeAumfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012486; c=relaxed/simple;
	bh=WC0enFde44zzt+4uSHzarJt9T5y2rSnXB4N7rxiZpec=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gV2YYFxgUAiKDatoXo9fEU2YVB3PeUodALsm2YBb1EGkif+vLBraSr9q+zmTolVndewWL6hnC8G9Rp8NxqtT1MSYa5KL2oATpJiqYd4tXiKCdJaDf6nv4z1LwRqWaIx6f4k0BMP1fYcUYW42SWLalxXJlcrxnDuVc4xRJKMSEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoGQoMvb; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoGQoMvb"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-432d2c96215so5502781f8f.3
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769012482; x=1769617282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOdx3x8Su8tu4LyzfOtnOIWZweHcvEvtqF3VmlaRvoQ=;
        b=FoGQoMvbZ66mRqNmw2x3K2XyuXXR9Q7ut9gzvfGi9UIJc0EJrzAA0mehDhJW/RurO1
         0xoTVhFQqqRTxEATb/H3stNFxAqCL70Mrzx7Cj0OHi4gDOjPhvCZKjATX6hlKm2/I2uy
         jqjb6OirGHOp2ZE6nBAqzkjnd1sYCt2FGcoHxFmcQHaFKoQEXELSBMLo84LF0y+dWSqn
         aKN3BJXC490kAqJGhzoMN1vUvUs+9TifH2FLY//fqVrc4Y9hJxY/7ablidBEIRf2pttz
         P9ZhYIAqFQRKSy1dNejjLJaa5yEN8H/octpykWvD/d3TC1pw38I3MVNj6LtcxTQ79H+N
         saIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012482; x=1769617282;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOdx3x8Su8tu4LyzfOtnOIWZweHcvEvtqF3VmlaRvoQ=;
        b=YUJ+qCtCeJugqcAJ2Vv8ck5YNdWcik6bB54M/VoM8rp7753nx5lnTAlEWf5vWGxdkB
         dmehLzUeu82Vs2x/t0RepRFQqzIWdI85rTokZoy5nK6HWHZbp23ecDM+Jvhz89VPamMG
         zR+s9thHNCH4UYzDkO8z70lja19CHeRLyXmuITY5VQ1cbZCzZXrFygJCBOn3zmoIJNo2
         uSNomhkjw1TP8+nG/+Vm6UbipPw07SWWzjbZz2lTE1BBleUKFEf+PClg4XxRtFShAS/0
         PiEFoNFp/5UzqwnssMDFDpiffPVjqa1MCbr6iipJ23mify1bXf/ON8YJ1Xg1EzUXxdgQ
         TYIw==
X-Forwarded-Encrypted: i=1; AJvYcCV1fVGsmUVOr/J3w4L79++3JErYaY/N7x39ZQ9p1ZrRV+APJOEZFzNY6kBf2xu/191Rbd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwapvfjoFvbiQdzYHecEDpj5hhgnyiEP4RgZd1FY1Iq2bsy4RaH
	qUNV3keGr4erXPi4EvRmTshciJrvKLBp7q78LzEeGDP6Comb7tYL9Qhh
X-Gm-Gg: AZuq6aIg6dJPEdK/xsnnPx8VJ4LmGdsiag6Y7vm5ne/ueX3DR6Kz6Xyh4VinVjS56uj
	65PS/f4POo892y/HOT1hOPTFFb7SLTeqaipujXBtNtj6DIJEYZA6xRd//bzWZ7EFPrnc87lHvH5
	bOsM3N2YAdmTzD76vc+bI/HfIRW8tyc/90YRDROUHLSQ077r6vaUii5v3gacHxJheLJAXDvxFaV
	UGx+gyAOq2aaMwRMjQkdogvrHCJkS0Ope+GZvtB3LUWXConCby0dunOVWdNdMS4S8ew8Qa5QdEt
	3+I8Ntjg5OrHyCzF4arJkcuFxJ9Cbga3cuC2+TR/CttULszps8F3YTOd1SHtzpiyk/cZvRBdZBk
	5CYxvZn5+8V0D4FfoJkUqCLvrixa1Oub6uiCRbSoHXxt27TYdgM+7w+ri8mmNIh8CxRTlFotrPL
	ArrHDFVHTZHb1+TnCkQ+Z3cAZbb7SmAFmmfED26QgiqRoHZDeASkXrmFBzDrsikqPyThoE15Q/x
	HCr
X-Received: by 2002:a05:6000:2485:b0:435:9851:d940 with SMTP id ffacd0b85a97d-4359851da13mr5164749f8f.59.1769012481831;
        Wed, 21 Jan 2026 08:21:21 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f12ee69sm14607408f8f.11.2026.01.21.08.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:21:21 -0800 (PST)
Message-ID: <67808128-5f41-4ae5-b224-a76048cd82c8@gmail.com>
Date: Wed, 21 Jan 2026 16:21:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 6/6] fetch: delay user information post committing of
 transaction
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, newren@gmail.com, gitster@pobox.com
References: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
 <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-6-e0edb29acbef@gmail.com>
Content-Language: en-US
In-Reply-To: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-6-e0edb29acbef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 20/01/2026 09:59, Karthik Nayak wrote:

> +struct ref_update_display_info {
> +	bool failed;
> +	char success_code;
> +	char fail_code;
> +	const char *summary;
> +	const char *fail_detail;
> +	const char *success_detail;
> +	const char *ref;
> +	const char *remote;
> +	struct object_id old_oid;
> +	struct object_id new_oid;
> +};

I was expecting that we'd pass around a struct like

struct ref_update_display_info_array {
	size_t alloc, nr;
	ref_update_display_info *info;
};

rather than passing a pointer, count pair as separate parameters. That 
would also allow us to use ALLOC_GROW() rather than reallocating the 
array each time we append to it which is rather inefficient.

Thanks

Phillip

> +static struct ref_update_display_info *ref_update_display_info_append(
> +					   struct ref_update_display_info **list,
> +					   size_t *count,
> +					   char success_code,
> +					   char fail_code,
> +					   const char *summary,
> +					   const char *success_detail,
> +					   const char *fail_detail,
> +					   const char *ref,
> +					   const char *remote,
> +					   const struct object_id *old_oid,
> +					   const struct object_id *new_oid)
> +{
> +	struct ref_update_display_info *info;
> +	size_t index = *count;
> +
> +	(*count)++;
> +	REALLOC_ARRAY(*list, *count);
> +
> +	info = &(*list)[index];
> +
> +	info->failed = false;
> +	info->success_code = success_code;
> +	info->fail_code = fail_code;
> +	info->summary = xstrdup(summary);
> +	info->success_detail = xstrdup_or_null(success_detail);
> +	info->fail_detail = xstrdup_or_null(fail_detail);
> +	info->remote = xstrdup(remote);
> +	info->ref = xstrdup(ref);
> +
> +	oidcpy(&info->old_oid, old_oid);
> +	oidcpy(&info->new_oid, new_oid);
> +
> +	return info;
> +}
> +
> +static void ref_update_display_info_set_failed(struct ref_update_display_info *info)
> +{
> +	info->failed = true;
> +}
> +
> +static void ref_update_display_info_free(struct ref_update_display_info *info)
> +{
> +	free((char *)info->summary);
> +	free((char *)info->success_detail);
> +	free((char *)info->fail_detail);
> +	free((char *)info->remote);
> +	free((char *)info->ref);
> +}
> +
> +static void ref_update_display_info_display(struct ref_update_display_info *info,
> +					    struct display_state *display_state,
> +					    int summary_width)
> +{
> +	display_ref_update(display_state,
> +			   info->failed ? info->fail_code : info->success_code,
> +			   info->summary,
> +			   info->failed ? info->fail_detail : info->success_detail,
> +			   info->remote, info->ref, &info->old_oid,
> +			   &info->new_oid, summary_width);
> +}
> +
>   static int update_local_ref(struct ref *ref,
>   			    struct ref_transaction *transaction,
> -			    struct display_state *display_state,
>   			    const struct ref *remote_ref,
> -			    int summary_width,
> -			    const struct fetch_config *config)
> +			    const struct fetch_config *config,
> +			    struct ref_update_display_info **display_list,
> +			    size_t *display_count)
>   {
>   	struct commit *current = NULL, *updated;
>   	int fast_forward = 0;
> @@ -877,41 +952,56 @@ static int update_local_ref(struct ref *ref,
>   
>   	if (oideq(&ref->old_oid, &ref->new_oid)) {
>   		if (verbosity > 0)
> -			display_ref_update(display_state, '=', _("[up to date]"), NULL,
> -					   remote_ref->name, ref->name,
> -					   &ref->old_oid, &ref->new_oid, summary_width);
> +			ref_update_display_info_append(display_list, display_count,
> +						       '=', '=', _("[up to date]"),
> +						       NULL, NULL, ref->name,
> +						       remote_ref->name, &ref->old_oid,
> +						       &ref->new_oid);
>   		return 0;
>   	}
>   
>   	if (!update_head_ok &&
>   	    !is_null_oid(&ref->old_oid) &&
>   	    branch_checked_out(ref->name)) {
> +		struct ref_update_display_info *info;
>   		/*
>   		 * If this is the head, and it's not okay to update
>   		 * the head, and the old value of the head isn't empty...
>   		 */
> -		display_ref_update(display_state, '!', _("[rejected]"),
> -				   _("can't fetch into checked-out branch"),
> -				   remote_ref->name, ref->name,
> -				   &ref->old_oid, &ref->new_oid, summary_width);
> +		info = ref_update_display_info_append(display_list, display_count,
> +						      '!', '!', _("[rejected]"),
> +						      NULL, _("can't fetch into checked-out branch"),
> +						      ref->name, remote_ref->name,
> +						      &ref->old_oid, &ref->new_oid);
> +		ref_update_display_info_set_failed(info);
>   		return 1;
>   	}
>   
>   	if (!is_null_oid(&ref->old_oid) &&
>   	    starts_with(ref->name, "refs/tags/")) {
> +		struct ref_update_display_info *info;
> +
>   		if (force || ref->force) {
>   			int r;
> +
>   			r = s_update_ref("updating tag", ref, transaction, 0);
> -			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
> -					   r ? _("unable to update local ref") : NULL,
> -					   remote_ref->name, ref->name,
> -					   &ref->old_oid, &ref->new_oid, summary_width);
> +
> +			info = ref_update_display_info_append(display_list, display_count,
> +							      't', '!', _("[tag update]"), NULL,
> +							      _("unable to update local ref"),
> +							      ref->name, remote_ref->name,
> +							      &ref->old_oid, &ref->new_oid);
> +			if (r)
> +				ref_update_display_info_set_failed(info);
> +
>   			return r;
>   		} else {
> -			display_ref_update(display_state, '!', _("[rejected]"),
> -					   _("would clobber existing tag"),
> -					   remote_ref->name, ref->name,
> -					   &ref->old_oid, &ref->new_oid, summary_width);
> +			info = ref_update_display_info_append(display_list, display_count,
> +							      '!', '!', _("[rejected]"), NULL,
> +							      _("would clobber existing tag"),
> +							      ref->name, remote_ref->name,
> +							      &ref->old_oid, &ref->new_oid);
> +			ref_update_display_info_set_failed(info);
>   			return 1;
>   		}
>   	}
> @@ -921,6 +1011,7 @@ static int update_local_ref(struct ref *ref,
>   	updated = lookup_commit_reference_gently(the_repository,
>   						 &ref->new_oid, 1);
>   	if (!current || !updated) {
> +		struct ref_update_display_info *info;
>   		const char *msg;
>   		const char *what;
>   		int r;
> @@ -941,10 +1032,15 @@ static int update_local_ref(struct ref *ref,
>   		}
>   
>   		r = s_update_ref(msg, ref, transaction, 0);
> -		display_ref_update(display_state, r ? '!' : '*', what,
> -				   r ? _("unable to update local ref") : NULL,
> -				   remote_ref->name, ref->name,
> -				   &ref->old_oid, &ref->new_oid, summary_width);
> +
> +		info = ref_update_display_info_append(display_list, display_count,
> +						      '*', '!', what, NULL,
> +						      _("unable to update local ref"),
> +						      ref->name, remote_ref->name,
> +						      &ref->old_oid, &ref->new_oid);
> +		if (r)
> +			ref_update_display_info_set_failed(info);
> +
>   		return r;
>   	}
>   
> @@ -960,6 +1056,7 @@ static int update_local_ref(struct ref *ref,
>   	}
>   
>   	if (fast_forward) {
> +		struct ref_update_display_info *info;
>   		struct strbuf quickref = STRBUF_INIT;
>   		int r;
>   
> @@ -967,29 +1064,46 @@ static int update_local_ref(struct ref *ref,
>   		strbuf_addstr(&quickref, "..");
>   		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
>   		r = s_update_ref("fast-forward", ref, transaction, 1);
> -		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
> -				   r ? _("unable to update local ref") : NULL,
> -				   remote_ref->name, ref->name,
> -				   &ref->old_oid, &ref->new_oid, summary_width);
> +
> +		info = ref_update_display_info_append(display_list, display_count,
> +						      ' ', '!', quickref.buf, NULL,
> +						      _("unable to update local ref"),
> +						      ref->name, remote_ref->name,
> +						      &ref->old_oid, &ref->new_oid);
> +		if (r)
> +			ref_update_display_info_set_failed(info);
> +
>   		strbuf_release(&quickref);
>   		return r;
>   	} else if (force || ref->force) {
> +		struct ref_update_display_info *info;
>   		struct strbuf quickref = STRBUF_INIT;
>   		int r;
> +
>   		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
>   		strbuf_addstr(&quickref, "...");
>   		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
>   		r = s_update_ref("forced-update", ref, transaction, 1);
> -		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
> -				   r ? _("unable to update local ref") : _("forced update"),
> -				   remote_ref->name, ref->name,
> -				   &ref->old_oid, &ref->new_oid, summary_width);
> +
> +		info = ref_update_display_info_append(display_list, display_count,
> +						      '+', '!', quickref.buf, _("forced update"),
> +						      _("unable to update local ref"),
> +						      ref->name, remote_ref->name,
> +						      &ref->old_oid, &ref->new_oid);
> +
> +		if (r)
> +			ref_update_display_info_set_failed(info);
> +
>   		strbuf_release(&quickref);
>   		return r;
>   	} else {
> -		display_ref_update(display_state, '!', _("[rejected]"), _("non-fast-forward"),
> -				   remote_ref->name, ref->name,
> -				   &ref->old_oid, &ref->new_oid, summary_width);
> +		struct ref_update_display_info *info;
> +		info = ref_update_display_info_append(display_list, display_count,
> +						      '!', '!', _("[rejected]"), NULL,
> +						      _("non-fast-forward"),
> +						      ref->name, remote_ref->name,
> +						      &ref->old_oid, &ref->new_oid);
> +		ref_update_display_info_set_failed(info);
>   		return 1;
>   	}
>   }
> @@ -1103,17 +1217,15 @@ static int store_updated_refs(struct display_state *display_state,
>   			      int connectivity_checked,
>   			      struct ref_transaction *transaction, struct ref *ref_map,
>   			      struct fetch_head *fetch_head,
> -			      const struct fetch_config *config)
> +			      const struct fetch_config *config,
> +			      struct ref_update_display_info **display_list,
> +			      size_t *display_count)
>   {
>   	int rc = 0;
>   	struct strbuf note = STRBUF_INIT;
>   	const char *what, *kind;
>   	struct ref *rm;
>   	int want_status;
> -	int summary_width = 0;
> -
> -	if (verbosity >= 0)
> -		summary_width = transport_summary_width(ref_map);
>   
>   	if (!connectivity_checked) {
>   		struct check_connected_options opt = CHECK_CONNECTED_INIT;
> @@ -1218,8 +1330,9 @@ static int store_updated_refs(struct display_state *display_state,
>   					  display_state->url_len);
>   
>   			if (ref) {
> -				rc |= update_local_ref(ref, transaction, display_state,
> -						       rm, summary_width, config);
> +				rc |= update_local_ref(ref, transaction, rm,
> +						       config, display_list,
> +						       display_count);
>   				free(ref);
>   			} else if (write_fetch_head || dry_run) {
>   				/*
> @@ -1227,12 +1340,11 @@ static int store_updated_refs(struct display_state *display_state,
>   				 * would be written to FETCH_HEAD, if --dry-run
>   				 * is set).
>   				 */
> -				display_ref_update(display_state, '*',
> -						   *kind ? kind : "branch", NULL,
> -						   rm->name,
> -						   "FETCH_HEAD",
> -						   &rm->new_oid, &rm->old_oid,
> -						   summary_width);
> +
> +				ref_update_display_info_append(display_list, display_count,
> +							       '*', '*', *kind ? kind : "branch",
> +							       NULL, NULL, "FETCH_HEAD", rm->name,
> +							       &rm->new_oid, &rm->old_oid);
>   			}
>   		}
>   	}
> @@ -1300,7 +1412,9 @@ static int fetch_and_consume_refs(struct display_state *display_state,
>   				  struct ref_transaction *transaction,
>   				  struct ref *ref_map,
>   				  struct fetch_head *fetch_head,
> -				  const struct fetch_config *config)
> +				  const struct fetch_config *config,
> +				  struct ref_update_display_info **display_list,
> +				  size_t *display_count)
>   {
>   	int connectivity_checked = 1;
>   	int ret;
> @@ -1322,7 +1436,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
>   
>   	trace2_region_enter("fetch", "consume_refs", the_repository);
>   	ret = store_updated_refs(display_state, connectivity_checked,
> -				 transaction, ref_map, fetch_head, config);
> +				 transaction, ref_map, fetch_head, config,
> +				 display_list, display_count);
>   	trace2_region_leave("fetch", "consume_refs", the_repository);
>   
>   out:
> @@ -1493,7 +1608,9 @@ static int backfill_tags(struct display_state *display_state,
>   			 struct ref_transaction *transaction,
>   			 struct ref *ref_map,
>   			 struct fetch_head *fetch_head,
> -			 const struct fetch_config *config)
> +			 const struct fetch_config *config,
> +			 struct ref_update_display_info **display_list,
> +			 size_t *display_count)
>   {
>   	int retcode, cannot_reuse;
>   
> @@ -1515,7 +1632,7 @@ static int backfill_tags(struct display_state *display_state,
>   	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>   	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
>   	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
> -					 fetch_head, config);
> +					 fetch_head, config, display_list, display_count);
>   
>   	if (gsecondary) {
>   		transport_disconnect(gsecondary);
> @@ -1641,6 +1758,7 @@ struct ref_rejection_data {
>   	bool conflict_msg_shown;
>   	bool case_sensitive_msg_shown;
>   	const char *remote_name;
> +	struct strmap *rejected_refs;
>   };
>   
>   static void ref_transaction_rejection_handler(const char *refname,
> @@ -1681,6 +1799,7 @@ static void ref_transaction_rejection_handler(const char *refname,
>   			      refname, ref_transaction_error_msg(err));
>   	}
>   
> +	strmap_put(data->rejected_refs, refname, NULL);
>   	*data->retcode = 1;
>   }
>   
> @@ -1690,6 +1809,7 @@ static void ref_transaction_rejection_handler(const char *refname,
>    */
>   static int commit_ref_transaction(struct ref_transaction **transaction,
>   				  bool is_atomic, const char *remote_name,
> +				  struct strmap *rejected_refs,
>   				  struct strbuf *err)
>   {
>   	int retcode = ref_transaction_commit(*transaction, err);
> @@ -1701,6 +1821,7 @@ static int commit_ref_transaction(struct ref_transaction **transaction,
>   			.conflict_msg_shown = 0,
>   			.remote_name = remote_name,
>   			.retcode = &retcode,
> +			.rejected_refs = rejected_refs,
>   		};
>   
>   		ref_transaction_for_each_rejected_update(*transaction,
> @@ -1729,6 +1850,10 @@ static int do_fetch(struct transport *transport,
>   	struct fetch_head fetch_head = { 0 };
>   	struct strbuf err = STRBUF_INIT;
>   	int do_set_head = 0;
> +	struct ref_update_display_info *display_list = NULL;
> +	struct strmap rejected_refs = STRMAP_INIT;
> +	size_t display_count = 0;
> +	int summary_width = 0;
>   
>   	if (tags == TAGS_DEFAULT) {
>   		if (transport->remote->fetch_tags == 2)
> @@ -1853,7 +1978,7 @@ static int do_fetch(struct transport *transport,
>   	}
>   
>   	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
> -				   &fetch_head, config)) {
> +				   &fetch_head, config, &display_list, &display_count)) {
>   		retcode = 1;
>   		goto cleanup;
>   	}
> @@ -1876,7 +2001,7 @@ static int do_fetch(struct transport *transport,
>   			 * the transaction and don't commit anything.
>   			 */
>   			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
> -					  &fetch_head, config))
> +					  &fetch_head, config, &display_list, &display_count))
>   				retcode = 1;
>   		}
>   
> @@ -1886,8 +2011,12 @@ static int do_fetch(struct transport *transport,
>   	if (retcode)
>   		goto cleanup;
>   
> +	if (verbosity >= 0)
> +		summary_width = transport_summary_width(ref_map);
> +
>   	retcode = commit_ref_transaction(&transaction, atomic_fetch,
> -					 transport->remote->name, &err);
> +					 transport->remote->name,
> +					 &rejected_refs, &err);
>   	/*
>   	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
>   	 * continue to fetch head and perform other post-fetch operations.
> @@ -1965,7 +2094,17 @@ static int do_fetch(struct transport *transport,
>   	 */
>   	if (retcode && !atomic_fetch && transaction)
>   		commit_ref_transaction(&transaction, false,
> -				       transport->remote->name, &err);
> +				       transport->remote->name,
> +				       &rejected_refs, &err);
> +
> +	for (size_t i = 0; i < display_count; i++) {
> +		struct ref_update_display_info *info = &display_list[i];
> +
> +		if (!info->failed && strmap_contains(&rejected_refs, info->ref))
> +			ref_update_display_info_set_failed(info);
> +		ref_update_display_info_display(info, &display_state, summary_width);
> +		ref_update_display_info_free(info);
> +	}
>   
>   	if (retcode) {
>   		if (err.len) {
> @@ -1980,6 +2119,9 @@ static int do_fetch(struct transport *transport,
>   
>   	if (transaction)
>   		ref_transaction_free(transaction);
> +
> +	free(display_list);
> +	strmap_clear(&rejected_refs, 0);
>   	display_state_release(&display_state);
>   	close_fetch_head(&fetch_head);
>   	strbuf_release(&err);
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 45595991c8..29e2f17608 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1893,6 +1893,7 @@ test_expect_success 'pushing non-commit objects should report error' '
>   
>   		tagsha=$(git rev-parse test^{tag}) &&
>   		test_must_fail git push ../dest "$tagsha:refs/heads/branch" 2>err &&
> +		test_grep "! \[remote rejected\] $tagsha -> branch (invalid new value provided)" err &&
>   		test_grep "trying to write non-commit object $tagsha to branch ${SQ}refs/heads/branch${SQ}" err
>   	)
>   '
> 

