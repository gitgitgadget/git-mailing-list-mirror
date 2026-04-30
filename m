Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755E4279FA
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557249; cv=none; b=q6/+6NP+WrGFQQ8eB/8vKYNpVkNqsLHt6kQjIBF38aIiKojPcfYhbz8mN/S8wExaXWltUk3rc3Y57mfz1x/Rf1DxM+84br7hgdmbAk6vyiN1Ock/IzvHt9rIbqp5oPAU2lwkk5c4JY2htpknF2UKsrgLQD9NDRwmRNq/xKPlaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557249; c=relaxed/simple;
	bh=AZGBwEETPKU59CyAYm1WOyArD6Eo5m1tm6Nu31iar7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYbjKEqkBj89P1LunaorycSWP+0JtHLJNIQCCG9JNTDyBNotdCLz07hZ7D+R9XPmvoj5T6F85h8Y9gwHfl0Lgmyo6pnCIkTZr2lqucVE38I7IzxHOeIQ9dIV2JE4PryRU53TVemqdsfLMVZO+FAYuPdSQPzCyqQIMpK7rjPnnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJBIQ9D3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJBIQ9D3"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43eb05b1875so550077f8f.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777557247; x=1778162047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JhFGu4IMv+d8s3pXBDAkfAJGcMfCB3AOl/L4mM5heQU=;
        b=JJBIQ9D3G2QnkczVAtD1hochGVRLaJhOLqYZOirZTpwAGcvy6erdPvorTOGGUGBCFN
         ooLiUJ2Nx2cczl8iIoBm8MlngL3SoxasPkzEv6IbGkUKw5rjmYdjQThPAug31oMHh/n3
         PBq8JBsmq44VbzF7vwG+ZsUxBZgP14xigCblDr84C5soECsKZzGcoSeeVjeq5mQNpNJo
         uXmXxzfAZwfjmSpv6jm6GRAC2Oi6NGAGUtay+vH1GMNmkMRFluEA+/AQgMXDxR1KAV68
         TxD3EHfIlo7zFPbW8jMUoudH7PHRQYO+urjzZMRJ1o5fTJ2RzbaP4xSfqSFJcr5qjDNz
         rwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777557247; x=1778162047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhFGu4IMv+d8s3pXBDAkfAJGcMfCB3AOl/L4mM5heQU=;
        b=mBrbpcxIgcRA+zcMQg+qKctF81OUPf+PJBb+O8GnuM9ExGUMn5R3zOrUoNHat1cxQJ
         Zw+huBFo7+G6/oP2kSoU+dRJ7wYYdcydVzAZdEEIY/qHbUCFZ6d4bdsCloD2odLLfZZx
         uNuHmYrmM5pTydKXukOunUOCfhHyvg2fZeoM7zZ156IOMeOp7dAl5TnOeErKcLV6pDIb
         oXGXn9J2XyFzwvLyOaVPRnGUPnyt7cl0coxGMWIV68n93lzQqYA6WE23VGlCt1GtL8EB
         7AABexK8XkeYTgKQdNor0LpHZomnHzwfqaNuwIKHX9fLPEc/AnZh84i+cbp37dIWgPk9
         Ox6g==
X-Forwarded-Encrypted: i=1; AFNElJ+5uPup6LqQUQLSX+BXjWdqu7JhowL3RQeR/zK0ISKGfvWrRdR5Ta0IkgBFMAvYXepe7ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvG9UCUBe4PsJtKdbOYMZeB+wZudhtgVHWycyU5KSQP73dpia6
	jMZCKK8NIU3+L2/j1zjY2xBwtqyWY0BdCDKy/k0dz+DmkwpKw50GaYwd
X-Gm-Gg: AeBDietwfKH5YzvNuO/ldC6518OOXUZbn+cQtHmmJqbm4PX0TiLSbX0uOBiCOSQTJc1
	UOrB9pNnZ319apYYtnnimxYpAsSxQaZMqZf42fkdK51H2hdLkBivBYXhxEW3r9qu8erJwv7gRb3
	gvFIGYTy3mr+VA9yG1UjuEdbLPolvvHA2oy2wzlDTBYNCNVKYhrJucikqqhOOhpbG+qgtPJ3bCK
	IOYZY/EYZd9heng0UDQ3deiA2q0WXDX9A9qW0vr6WEDUzbQgNCcb6ETt0/Bypxr7o6wdHrkFkk/
	SGJAR3y+EG+NZn+h4i7jioElvqIjucmT/11T4b9ZunOu0owbNtor7Q1uDcFKokIjLttK0h8uO5/
	COMIl6QFDeh3a78bw5wPz5vnUmkBfWPucGEp7qtV8oAxO8zb6sNEzFqtNyUXn+RZbGSZ+vfccnz
	XgMTDaXCAT/1cARo6ht7jHQ5Swj4Xpu/x0bDjt29snijU3UtwzQbxUQBYT+FcQXkVgkW6aWsvRp
	F+HVTNCyeQh8g==
X-Received: by 2002:a05:6000:3108:b0:43f:e16f:3cc3 with SMTP id ffacd0b85a97d-4493f6212c7mr5304237f8f.22.1777557246447;
        Thu, 30 Apr 2026 06:54:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c7csm13451460f8f.26.2026.04.30.06.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 06:54:05 -0700 (PDT)
Message-ID: <8016697f-9eb7-4c75-be87-d9479186919c@gmail.com>
Date: Thu, 30 Apr 2026 14:54:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/5] name-rev: factor code for sharing with a new
 command
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, ben.knoble@gmail.com
References: <V2_CV_name-rev_--format.51b@msgid.xyz>
 <V3_CV_format-rev.66a@msgid.xyz> <V3_name-rev_factor.66d@msgid.xyz>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <V3_name-rev_factor.66d@msgid.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kristoffer

On 28/04/2026 23:25, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> @@ -516,6 +534,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
>   
>   	for (p_start = p; *p; p++) {
>   #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
> +	start:
>   		if (!ishex(*p)) {
>   			counter = 0;
>   		} else if (++counter == hexsz &&
> @@ -524,25 +543,32 @@ static void name_rev_line(char *p, struct name_ref_data *data)
>   			const char *name = NULL;
>   			char c = *(p + 1);
>   			int p_len = p - p_start + 1;
> +			struct object *o = NULL;
> +			int oid_ret = 1;
>   
>   			counter = 0;
>   
>   			*(p + 1) = 0;
> -			if (!repo_get_oid(the_repository, p - (hexsz - 1), &oid)) {
> -				struct object *o =
> -					lookup_object(the_repository, &oid);
> +			oid_ret = repo_get_oid(the_repository, p - (hexsz - 1), &oid);

It would be safer to restore *(p + 1) here rather that relying on each 
case block to do it.

			*(p + 1) = c;
> +
> +			switch (cmd->type) {
> +			case NAME_REV:
> +				if (!oid_ret)
> +					o = lookup_object(the_repository, &oid);
>   				if (o)
>   					name = get_rev_name(o, &buf);
> +				*(p + 1) = c;
> +				if (!name)
> +					goto start;

The pre-image uses "continue" which will increment p - why the change in 
behavior?

Thanks

Phillip

> +				if (cmd->u.name_only)
> +					printf("%.*s%s", p_len - hexsz, p_start, name);
> +				else
> +					printf("%.*s (%s)", p_len, p_start, name);
> +				break;
> +			default:
> +				BUG("uncovered case: %d", cmd->type);
>   			}
> -			*(p + 1) = c;
> -
> -			if (!name)
> -				continue;
>   
> -			if (data->name_only)
> -				printf("%.*s%s", p_len - hexsz, p_start, name);
> -			else
> -				printf("%.*s (%s)", p_len, p_start, name);
>   			p_start = p + 1;
>   		}
>   	}
> @@ -567,6 +593,7 @@ int cmd_name_rev(int argc,
>   #endif
>   	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
>   	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
> +	struct command cmd;
>   	struct option opts[] = {
>   		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
>   		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
> @@ -596,6 +623,7 @@ int cmd_name_rev(int argc,
>   	init_commit_rev_name(&rev_names);
>   	repo_config(the_repository, git_default_config, NULL);
>   	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
> +	init_name_rev_command(&cmd, data.name_only);
>   
>   #ifndef WITH_BREAKING_CHANGES
>   	if (transform_stdin) {
> @@ -663,7 +691,7 @@ int cmd_name_rev(int argc,
>   
>   		while (strbuf_getline(&sb, stdin) != EOF) {
>   			strbuf_addch(&sb, '\n');
> -			name_rev_line(sb.buf, &data);
> +			name_rev_line(sb.buf, &cmd);
>   		}
>   		strbuf_release(&sb);
>   	} else if (all) {

