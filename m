Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04246FD5
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510206; cv=none; b=HcNx+vMg8FE9yODpuTYe8B2f0bAcW/0j6GHWkTuCXQVhahgO0UcnfAWHvNpKoEjWo+RpWr+ejklA+pa5kPDiaco6v2w2IoqamehzLDlSbouiEYA3EWFGzRlBm78E+LeXd80615q0HFthbnYhFBsZlvDgWhszamNi6hp17RiP6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510206; c=relaxed/simple;
	bh=iJba3+givpUKRmgFT+qRapKT2ruuYeAEnq3B8OI77Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NK1zMszRJptqXGNKNxBb8SO3pKYpanxWkoZGMhmQhTlioH5abf+/ZJ7lcsZB1qDkqFLs43nQ7PHlzn50/WRjfIFfe8fNOBAfcfLkSBR18HXjHlkEgyE0DDNdVnfKI3o5b/rMGMzk8MXhcIEbENt2mv7JY+Jye3YE59f8YyZOvhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGPBHUDz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGPBHUDz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35e5c6600f0so1985257f8f.3
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 07:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717510203; x=1718115003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rBkvpeU4Hj9IErIMmBFJlAagzjJLF8DSQkO2QOexnxk=;
        b=AGPBHUDzfM3pjuvJ8rzJluNuScVA5vTp5wZOFirk61OGEO/1vI3KTYhyH0y1ymXwSz
         GVVIk0AQMqkixVvw81nkIHTksa4qNWvAjZjgeAFA4Ez7+qajsLr0MeRfe65n37YfTzBY
         dNSeSFuz66Tq/aUAcr94lDjqzLfPuKSRuM37/xRFBgKbx7T389sUCyMv0fEqQtA/Co1N
         edCMnNR9IHHVTsaZXQCPpPbFi5SAdlp7yVc1xgq6m2YhKlW3tf7j8mfp6eBuvmAqYov2
         VIPoMKOSdGZCbyqEqMtbLDYuQUHDrDnUshlNq2ee1UR+Wl57Z7wfrhvp5bExX8S2+uBU
         6/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510203; x=1718115003;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBkvpeU4Hj9IErIMmBFJlAagzjJLF8DSQkO2QOexnxk=;
        b=TUXIK3cws4qFK4xN80kflhsuYmrZhA4QL+FBijzq6meX1zri2hi60s/3hlmIC3ptAC
         m0VkODk59UHX36DRkfjqZug6octJuv7/caSfiOnqM+Zpk8koAF3rKtFF+RNwV2b+8DrY
         ezH3RRQLPcOTLXkfQStj7xUNKxnahu/tcnVB3wHnxZgXnO8Eq7GH/Xa1V5YiAhV9tKpO
         bqbrnSkPDSL/ZJWFd4nXVfeDcsgkmlw5ljVxqxuUf/olCBm3Oy6SV5liYOHFY5JnAJwT
         vCC1VXtniL+9lBAZ2y5+APbqkPAFti7nJ/FIku6KTcjI+Bh37aCvOkCU2Ih3TtdupMhg
         85yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvNrpnx9rmzzt3V1y7n1PT1aU4oTzRyN8+4dzZBJaMY58e6kLjg6AwzU4FIHieNKZ6LwetmUIC3y8lrKAxwqmxvh68
X-Gm-Message-State: AOJu0YxTLDRhvYu9PUFm3/ere4GThu0EyLG5GsWtJPxSjd2jfr3I+NmN
	1IdbJJkH+qZditjKB/+eqYtHDtVt+MTjrwLQjohyYVuxRZS9KqqY
X-Google-Smtp-Source: AGHT+IE4nETX05tqdNLm3b8frpndvzOPoSwuIUW51hnNmzWISqGfDePgCBqB/qooOqRyEqVxkufgOg==
X-Received: by 2002:adf:e9d1:0:b0:355:3dc:1f26 with SMTP id ffacd0b85a97d-35e0f289290mr9319891f8f.37.1717510202658;
        Tue, 04 Jun 2024 07:10:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:124f:b55:b414:cf29? ([2a0a:ef40:641:9001:124f:b55:b414:cf29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062ecd3sm11900296f8f.74.2024.06.04.07.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:10:02 -0700 (PDT)
Message-ID: <30718fa9-6197-424c-a58c-8bf3c909cb25@gmail.com>
Date: Tue, 4 Jun 2024 15:10:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 25/27] builtin/rebase: always store allocated string in
 `options.strategy`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1716983704.git.ps@pks.im> <cover.1717504517.git.ps@pks.im>
 <f548241960d1f41e010516d68df9107528567514.1717504517.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <f548241960d1f41e010516d68df9107528567514.1717504517.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/06/2024 13:38, Patrick Steinhardt wrote:
> The `struct rebase_options::strategy` field is a `char *`, but we do end
> up assigning string constants to it in two cases:
> 
>    - When being passed a `--strategy=` option via the command line.
> 
>    - When being passed a strategy option via `--strategy-option=`, but
>      not a strategy.
> 
> This will cause warnings once we enable `-Wwrite-strings`.
> 
> Ideally, we'd just convert the field to be a `const char *`. But we also
> assign to this field via the GIT_TEST_MERGE_ALGORITHM envvar, which we
> have to strdup(3P) into it.
> 
> Instead, refactor the code to make sure that we only ever assign
> allocated strings to this field.

This looks sensible

Thanks

Phillip

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   builtin/rebase.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 11f276012c..26068cf542 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1063,6 +1063,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   {
>   	struct rebase_options options;
>   	const char *branch_name;
> +	const char *strategy_opt = NULL;
>   	int ret, flags, total_argc, in_progress = 0;
>   	int keep_base = 0;
>   	int ok_to_skip_pre_rebase = 0;
> @@ -1177,7 +1178,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
>   		OPT_BOOL(0, "fork-point", &options.fork_point,
>   			 N_("use 'merge-base --fork-point' to refine upstream")),
> -		OPT_STRING('s', "strategy", &options.strategy,
> +		OPT_STRING('s', "strategy", &strategy_opt,
>   			   N_("strategy"), N_("use the given merge strategy")),
>   		OPT_STRING_LIST('X', "strategy-option", &options.strategy_opts,
>   				N_("option"),
> @@ -1488,13 +1489,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		}
>   	}
>   
> -	if (options.strategy_opts.nr && !options.strategy)
> -		options.strategy = "ort";
> -
> -	if (options.strategy) {
> -		options.strategy = xstrdup(options.strategy);
> +	if (strategy_opt)
> +		options.strategy = xstrdup(strategy_opt);
> +	else if (options.strategy_opts.nr && !options.strategy)
> +		options.strategy = xstrdup("ort");
> +	if (options.strategy)
>   		imply_merge(&options, "--strategy");
> -	}
>   
>   	if (options.root && !options.onto_name)
>   		imply_merge(&options, "--root without --onto");
