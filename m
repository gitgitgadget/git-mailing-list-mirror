Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F566FD5
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510003; cv=none; b=U+IV388Nt9HTdMmLu/Rb7ZuRxxr2grDxh2da+J+AZwQZmRoRaen8n33ibREA/G/ZoQKt4vHhNMXlqO+flRVi/xqu8VQt5pBx0jLOa3h+/zTRI7omVRoH56NAkmkTx8m9cEDhkEX47Kzs9oywrJU2VzAOHgYP8bX5aX3C3UKrIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510003; c=relaxed/simple;
	bh=SelDd1kOgwji4ghM6J+OQFu+ZPUQ//0FCFkVamp05V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTr8plwLZaOI8WA2nLdX3wxBlsp1bBiaiJS/v0HCseelL8tUQ5suHzpItXmdG90uSGqu2SWzLZwvw4fxOnt7k7PnUeSp84TCG5uq5RKMpkAKFfACOwXTz+Ubo6T0TF5eOBQQxsbBIDBZ6Taf4/tPjExhRi/23v9D9YpsuFH5WxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmaJJH7Q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmaJJH7Q"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42155143cb0so2650355e9.2
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717509999; x=1718114799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hsMwbMF4h3txX1T3n1KO/7YiNfiBE0NThhD4Y+4GjMw=;
        b=QmaJJH7QLSnxNva3ONvF5Xd59P7K8RJ07S5J2aON/ukf4Z0gGE3TfIRW8X/Bv2hfhd
         BXgt6mVvk4Z7T8894MZMBOYPNlIOV9adtxrRcKrvyKtokOPbgV2Gh9bEfg8+VW4eWbz1
         KnpjBuWfFtgr5FWzSy3oFgsbszlcDNPP8eYDpKX1fcn98pDMVtds/k2+VW7YQwsTTC6r
         qNDOY3RyhcrDSKWonGnTZR/mmy+KfTTvh1VwO85XgAMxQBebBu3vsbWbNCK2nC8mXds3
         5U8kDyPNanSxYQJ/BHiAuxhCR7gFqYylyw6CeQ6Fy4oW1xpIVQ5H/f3EnFgfBDO6+hkh
         D/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717509999; x=1718114799;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsMwbMF4h3txX1T3n1KO/7YiNfiBE0NThhD4Y+4GjMw=;
        b=qGNsVauPbtt8tWXDq/SezMzFNEhOhjvTefPlVPA3qxH8T+8eipKIzn1NsE5nA+S7nG
         +t0jMNTTqK3F2nLEQVZ0AdCvns6xhQC8mpcuALdEqgih7tlOEfeN6v5QiIubYUh3DJG9
         j+08IPOcbuBi06+aaCheb6L08FdXmu8fpjyPVys7N9T0nMU83Xl4CJHBkXQx19R1y4br
         nzPsFVwyfTtBX03M2doGZd8AeWsheaX6N72CJv8cANZY4Cn7pEAnC1XGtDBETMC3LEzi
         EmwHZNIPkX3uxCrxvzWgEDBMqMqFyEhw/YgL+eKjwHo6w45fpL/bZ+313X4VhMEPfUys
         A3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUOTsk1zttvd6VDowr/ZDlC4y67aX312eDt1X1JzB5YZzRV/Over1xZLtCsWZELJg3sqdCoCWVl51Sc00tvFhWIWOxi
X-Gm-Message-State: AOJu0YxovSHn9qn71nOzRPVqWqxvxIiy1hmCan6eaEq+sIno6SA9Mg5s
	EO5OtOrLY4zR8G9MS7CZlUsiuTrHGVvVuxfT/4fVd3QOGuTNWu1l
X-Google-Smtp-Source: AGHT+IEaaDOQD+E9M9vF5VDKIwmkA3VzsEgs7IIeR1kmfgGRaxWhpd39Mhn2/60uhP26jV55rMkylg==
X-Received: by 2002:a05:600c:4744:b0:421:2990:7f9b with SMTP id 5b1f17b1804b1-4212e050597mr134454585e9.14.1717509999284;
        Tue, 04 Jun 2024 07:06:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:124f:b55:b414:cf29? ([2a0a:ef40:641:9001:124f:b55:b414:cf29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42148bc4cafsm33064985e9.40.2024.06.04.07.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:06:39 -0700 (PDT)
Message-ID: <be8a315a-3fa7-40d3-80e1-6a5c01afee70@gmail.com>
Date: Tue, 4 Jun 2024 15:06:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 24/27] builtin/rebase: do not assign default backend to
 non-constant field
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1716983704.git.ps@pks.im> <cover.1717504517.git.ps@pks.im>
 <e19457d20c80f9ce332f2d890a5089972e28f0cf.1717504517.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <e19457d20c80f9ce332f2d890a5089972e28f0cf.1717504517.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/06/2024 13:38, Patrick Steinhardt wrote:
> The `struct rebase_options::default_backend` field is a non-constant
> string, but is being assigned a constant via `REBASE_OPTIONS_INIT`.
> Refactor the code to initialize and release options via two functions
> `rebase_options_init()` and `rebase_options_release()`. Like this, we
> can easily adapt the former funnction to use `xstrdup()` on the default
> value without hiding it away in a macro.

Personally I'd be happy with

-		.default_backend = "merge",		\
+		.default_backend = xstrdup("merge"),	\

rather than adding an init function. I do agree that adding 
rebase_options_release() is a good idea and the rest of the changes look 
good to me

Thanks

Phillip

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   builtin/rebase.c | 67 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 39 insertions(+), 28 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 14d4f0a5e6..11f276012c 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -131,25 +131,40 @@ struct rebase_options {
>   	int config_update_refs;
>   };
>   
> -#define REBASE_OPTIONS_INIT {			  	\
> -		.type = REBASE_UNSPECIFIED,	  	\
> -		.empty = EMPTY_UNSPECIFIED,	  	\
> -		.keep_empty = 1,			\
> -		.default_backend = "merge",	  	\
> -		.flags = REBASE_NO_QUIET, 		\
> -		.git_am_opts = STRVEC_INIT,		\
> -		.exec = STRING_LIST_INIT_NODUP,		\
> -		.git_format_patch_opt = STRBUF_INIT,	\
> -		.fork_point = -1,			\
> -		.reapply_cherry_picks = -1,             \
> -		.allow_empty_message = 1,               \
> -		.autosquash = -1,                       \
> -		.rebase_merges = -1,                    \
> -		.config_rebase_merges = -1,             \
> -		.update_refs = -1,                      \
> -		.config_update_refs = -1,               \
> -		.strategy_opts = STRING_LIST_INIT_NODUP,\
> -	}
> +static void rebase_options_init(struct rebase_options *opts)
> +{
> +	memset(opts, 0, sizeof(*opts));
> +	opts->type = REBASE_UNSPECIFIED;
> +	opts->empty = EMPTY_UNSPECIFIED;
> +	opts->default_backend = xstrdup("merge");
> +	opts->keep_empty = 1;
> +	opts->flags = REBASE_NO_QUIET;
> +	strvec_init(&opts->git_am_opts);
> +	string_list_init_nodup(&opts->exec);
> +	strbuf_init(&opts->git_format_patch_opt, 0);
> +	opts->fork_point = -1;
> +	opts->reapply_cherry_picks = -1;
> +	opts->allow_empty_message = 1;
> +	opts->autosquash = -1;
> +	opts->rebase_merges = -1;
> +	opts->config_rebase_merges = -1;
> +	opts->update_refs = -1;
> +	opts->config_update_refs = -1;
> +	string_list_init_nodup(&opts->strategy_opts);
> +}
> +
> +static void rebase_options_release(struct rebase_options *opts)
> +{
> +	free(opts->default_backend);
> +	free(opts->reflog_action);
> +	free(opts->head_name);
> +	strvec_clear(&opts->git_am_opts);
> +	free(opts->gpg_sign_opt);
> +	string_list_clear(&opts->exec, 0);
> +	free(opts->strategy);
> +	string_list_clear(&opts->strategy_opts, 0);
> +	strbuf_release(&opts->git_format_patch_opt);
> +}
>   
>   static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   {
> @@ -796,6 +811,7 @@ static int rebase_config(const char *var, const char *value,
>   	}
>   
>   	if (!strcmp(var, "rebase.backend")) {
> +		FREE_AND_NULL(opts->default_backend);
>   		return git_config_string(&opts->default_backend, var, value);
>   	}
>   
> @@ -1045,7 +1061,7 @@ static int check_exec_cmd(const char *cmd)
>   
>   int cmd_rebase(int argc, const char **argv, const char *prefix)
>   {
> -	struct rebase_options options = REBASE_OPTIONS_INIT;
> +	struct rebase_options options;
>   	const char *branch_name;
>   	int ret, flags, total_argc, in_progress = 0;
>   	int keep_base = 0;
> @@ -1178,6 +1194,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	};
>   	int i;
>   
> +	rebase_options_init(&options);
> +
>   	if (argc == 2 && !strcmp(argv[1], "-h"))
>   		usage_with_options(builtin_rebase_usage,
>   				   builtin_rebase_options);
> @@ -1833,14 +1851,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   cleanup:
>   	strbuf_release(&buf);
>   	strbuf_release(&revisions);
> -	free(options.reflog_action);
> -	free(options.head_name);
> -	strvec_clear(&options.git_am_opts);
> -	free(options.gpg_sign_opt);
> -	string_list_clear(&options.exec, 0);
> -	free(options.strategy);
> -	string_list_clear(&options.strategy_opts, 0);
> -	strbuf_release(&options.git_format_patch_opt);
> +	rebase_options_release(&options);
>   	free(squash_onto_name);
>   	free(keep_base_onto_name);
>   	return !!ret;
