Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF846447
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816043; cv=none; b=DpLlEPE8M0dxXASBzfaDwXmARIye0iRj/1UApIYjev56e6A6xBAWPMhOs6YB7iyNEVd4jwTnC074oVZDPOA0hy+MKswlpaSPXPfwTWRKxwFggJ4HhReEmOuIwzQjAKfnj4Z8xjvqNX8RQ7q5kbjDI7sFaFqVU9qzT+EwV/HkvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816043; c=relaxed/simple;
	bh=bc2xu21wjrp7IIx3m2JhR4G0zCZX8spe0WRzKalszF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5CHtfY7H4AOZMKbuI8YFItfS2TUyud8mLcFzCiwWJ0cJfw2FRUffWxuYosnx9yxP2yeymaCLjQncIxeGE9bZq0CQiuiFbJD84Fj/bJlGRVLEKvMljRrYnUd56BBUvKXuXgiUJ77an/mV7DUJ4AzZ67mslTVTyTSmgDnvI2y6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYVAER+U; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYVAER+U"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so489675e9.3
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753816040; x=1754420840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AB1tlHOEkrQ1kjBKKrqNygxOcSIEEjWuEo6zO9fINVE=;
        b=XYVAER+U9HWCQM/S/GtLv1Vad6s+mRLu9pTSMig5JL4XbAaazaDt/mYQPMMbYQPVln
         k4MejyyoKURLf41fXr2Ck3KM/MG9nByJRuHmdvBDiZDzCAsONegwW/m5y/Lh8qx+TqVx
         7zblfL77F4LXD+7od3RY8GPAOhcLfPHITZdMuoXz8tEGK+clx8JdkiWxDlk6kQazMgfM
         FB030r9UPf2rCXZdKyK9Ov2pOiQq+sLieAAExr0wfIzT8CVsEbcsuA6rphDPjh7bwpgr
         vUDy6CVq1l44lh8PaTPRIoA48+vu7R4EBPu0FU/j1lSDUTdFzwt9iuaEKnZV7bsign63
         LGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753816040; x=1754420840;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AB1tlHOEkrQ1kjBKKrqNygxOcSIEEjWuEo6zO9fINVE=;
        b=ABHpylXZK20sYCVu8BX9smyrYcOUuHpd60Bfv23vyXhAVacQgrwj7/wUCesWsRePNB
         QVg85HENzqOSXr5iGqOF/0OIGlFHZJbC2nO8nY7VPuA5UcG/snUA3GnduuPhY2uTiPrL
         Mk99RHnhIM7NWVCLSwxZMKzQ0O0yukdqxJEpc1Qwy4SqtP6oaGBQqsPss0Yy1U2Zf3sm
         p8PBpJwiu5B/T/cnhJHRA5NTzf23VBTY/46EYYZ7G4z0Kd6q2vpiVKnRv1KhczSpyaFQ
         FjxrVEpuAD2a2MDlC+Zq8JdojjXECWdhkG4bWll4sqYE3Fwm/QGnC+8oSs5r48x/mJzL
         yMZg==
X-Forwarded-Encrypted: i=1; AJvYcCVzEro8uqN23FSDduuEUOFtxveO6le+F5tUeCDLL73xBReadK9zAD6bpO6JEU+PmxIbGCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnlwBpkihgwVdaVPu1NsXDRkA3IPA1ObraTNI3lJublg6MkUs
	Qw990U9QJe6X7bPlZZ+KlAVpmnnobn9YsJogawPqk/WssRaqxML4nqqi
X-Gm-Gg: ASbGncsGPnxQnarWxScOr6Zam5Nice78HEq2dm8XrB/AnciAQJ1Cx0nIstyTQaAnP+B
	qasv+JL+b6OAe6DLszdQ9MVtty8NRUV80FxwCSR7s5uJ0+Jxd8MKTz/CChzCY7Ei0EESy+h7yFI
	neK5HUlF8t3xauoIiO282bF4cXDnE4yYei71wEbDzfHfxxKiZOGwRhOUwg6Vr8hfaKj828Diut2
	O7Ssh/KwhJfyiW7D2Z5CFAq+Q98wtDXkYk6M3d2qWKVaxtkrAj0EXrlw1p36uPuQ62Iea3RSZbI
	+NzS2MyiWI146YeIy/tLg9/YmzvBJELYNuEhl2caLf/Fe2BjczZi7Gf2WK+H0NmmGMrqFkvoPLa
	H28MLmurLgoozQUrLTbQEOhfWTWZ3tldL4fn5NXumZFwkiyfLEtemoreRYohuSQIzeIfSzD3PLU
	lU
X-Google-Smtp-Source: AGHT+IG93lrvaY/QKhequXAykaNbmdFhOyHl2U2JEe9kwClkrP3L0syV17RW7iL+aNQVR+Tc0SwJPg==
X-Received: by 2002:a05:600c:540b:b0:453:5c30:a1fd with SMTP id 5b1f17b1804b1-45892b9dd1fmr7798735e9.8.1753816040068;
        Tue, 29 Jul 2025 12:07:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054ef47sm208225995e9.8.2025.07.29.12.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 12:07:19 -0700 (PDT)
Message-ID: <23428022-ab13-4a3e-90ed-ff91ef93f051@gmail.com>
Date: Tue, 29 Jul 2025 20:07:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH 1/2] environment: remove the global variable
 'merge_log_config'
To: Ayush Chandekar <ayu.chandekar@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, shyamthakkar001@gmail.com,
 Junio C Hamano <gitster@pobox.com>
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
 <c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ayush

On 29/07/2025 17:19, Ayush Chandekar wrote:
> 
> @@ -26,14 +26,7 @@ static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
>   int fmt_merge_msg_config(const char *key, const char *value,
>   			 const struct config_context *ctx, void *cb)
>   {
> -	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
> -		int is_bool;
> -		merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
> -		if (!is_bool && merge_log_config < 0)
> -			return error("%s: negative length %s", key, value);
> -		if (is_bool && merge_log_config)
> -			merge_log_config = DEFAULT_MERGE_LOG_LEN;
> -	} else if (!strcmp(key, "merge.branchdesc")) {

In the old code if both "merge.log" and "merge.summary" are set in the 
config file the last one wins

> +void adjust_shortlog_len(struct repository *r, int *shortlog_len)
> +{
> +	const char *keys[] = { "merge.log", "merge.summary", NULL};
> +	
> +	if (*shortlog_len >= 0)
> +		return;
> +
> +	for (const char **key = keys; *key; ++key) {
> +		int is_bool, value;
> +		if (!repo_config_get_bool_or_int(r, *key, &is_bool, &value)) {
> +			if (!is_bool && value < 0) {
> +				error("%s: negative length %d", *key, value);
> +				return;
> +			}
> +			*shortlog_len = (is_bool && value) ? DEFAULT_MERGE_LOG_LEN : value;
> +			return;

In the new code "merge.log" is always used in preference to 
"merge.summary" even if "merge.summary" appears later in the config 
file. When you have two keys setting the same variable I think the only 
way to preserve the last one wins behavior is to keep using a callback 
that updates the value as the config files are parsed.

Thanks

Phillip

