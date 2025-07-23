Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6B2FD58F
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282459; cv=none; b=rVBfzDt5CNJChj7JVcdWvzHZ2FaUvnhbiz5I12aMMxx/mYGQUYbLkN5Mpp38NedVfc0GhUD1b9CBlj//8ne1RlT9VXQCcm7wTceNFpWP1k5mOelmLvxZ6wrYZdVCkalHwGm+GRYs8cjF99OLXLDxd8uWzd6P4amlq0uY5XKnGTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282459; c=relaxed/simple;
	bh=NliTRiS65uuSnv7mxdxjp1JHEqi04oG/Jb8GkHd3l+o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iCQlahJbl2QNUglJZDnLhFEblpYFL6F5H8DMV0mTC94sf/OR1xxcR4natfsOtoJTxHO1yPO6JwbLbHUn20lOVN+IYN8EQOxasKGDBWNza3Su9blzv/vBSyc+dY/wTla9/FctPgfhGITIl/Wo91eF52ubJhzR35HZ/qiBdV8Ey58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNJnBHPK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNJnBHPK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso34342425e9.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282433; x=1753887233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvzEKExQI70Gf01aNM3mUirGcHB7glEEqpefvq8KJmU=;
        b=lNJnBHPKWwcj3FOIj9WqzniTHZZEFFIOjsukQaOWKToSOkGcYP7jXSTvTCEVwTVHsq
         asChxAw8SjSV92PmQtk1bL+X7jqzxLaYmSOyHItiMEd5K0GdfClPhvyfdol8OBcBTgpC
         2u9IxvPgnbHvdVjZBgGxeG2p64fT9Jw1w1MWr2vXwltnRsd0uJVuSYUFDHIpshXGMK29
         dF2mniIKQkbAuDf68h7vmebunWppIw+jfdOQXiR2nCW8Fpy211bhN8oJpBGpcU3KSlSA
         kFmWu6ij44pkDLfwoKOE+I3chO/eKUaAXEz506v7Y7JcYVv5+aU9tmFsCghbDHJd54iy
         JoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282433; x=1753887233;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvzEKExQI70Gf01aNM3mUirGcHB7glEEqpefvq8KJmU=;
        b=KEEmQrClXwz8vXoDb49u/kjoy2rDHae5OOz4pq0OV4d49q4IqdVWxOrWTKVxHlDcJx
         6bikmZhPjTVrRID0hkx98ENqTK8QVnPR6x1GgWsTa5bfKv1VCR1rYkO6UvV9fH05w5Oq
         +oifU0RcLv8R078GoMkUkxTXaD9MlbRtxLsjL28lqlfCt6PgxvQVM/6WaaufKgvW17at
         U61sx6KLzBt7MFVtaE5Cs0uhpPwx5rXfG5fnUtPPW0193oxMlCRdDGuaPvBAsgqCymY3
         WuKsW1RwIOYR/RaNMpTtcnAMHQ3RCsrudX35Y5RfQMA6wi0gcUJh1GjTehZch8iVYY1b
         CbTw==
X-Gm-Message-State: AOJu0YxUv+UKh2NNr/r6EHtRaTmQ2Sh5PoyYxoPZ6VYlP3DOpWm5giky
	iY6ZaGdcXtwfIgUyWHMPTznb5ZyWj9HZ4eVSK/p4Y8Vdt0sHiaoy4apR
X-Gm-Gg: ASbGncuUpebLw6JJw+ZuKbGxb9ix33PJI7jjFqbqK/LmeUEanlUB9zX/sMoAqNUn5WB
	aoDthdSbKwTF939FoqCI8fbEqibS0FHE/5aiACgSJ1ku1ghi5IXasAPXbf1StCfbZSe1Pa+rgcU
	LM2wtZvEpqutJ/cFx9LpjiLpaYH7/gmKry1wltxSVY9W+9Th0YcHkPc7irQuIj0TMqXxOn0jvPx
	yF80iFmyYAlSKUfq/oCttZ9Lsg7ckRZmyVU1VaBnfp4vVa3ps32JQhUeHexCR/wEf54a1FkbfOS
	Jfd4bpRxFCVRTONbLXuI2B95LXbCC6QKI5WqpB+gfTEEjlxqjknyW0v5CefVprxWmER0U6Og0ij
	6Wnfv5nUKE6HegPgCFWAG4cuAZ51nQX95ChCJxqt9zPXJdE/Vj6ETR+IvyQ8C5sZSmqBSNDFwOc
	GI
X-Google-Smtp-Source: AGHT+IH5lbJEzNPbWgFK0mx+P3+jJ7arq0vpSmt7LJsUzcJPAXLfSay9u0F1CFIAAsQm+j2jeru5fw==
X-Received: by 2002:a05:6000:25c3:b0:3a6:d145:e2cc with SMTP id ffacd0b85a97d-3b768ec798amr3167404f8f.15.1753282432441;
        Wed, 23 Jul 2025 07:53:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869182e99sm26277015e9.4.2025.07.23.07.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 07:53:51 -0700 (PDT)
Message-ID: <7d6ad7cb-e25a-41de-9588-6a3c1b0717e8@gmail.com>
Date: Wed, 23 Jul 2025 15:53:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
To: Justin Tobler <jltobler@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im,
 karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-3-lucasseikioshiro@gmail.com>
 <ldomqfgzts2fs3zuzuyfpsp4jsuec7a6ooisztqx6pe2373jzx@mqzh62weo2jm>
Content-Language: en-US
In-Reply-To: <ldomqfgzts2fs3zuzuyfpsp4jsuec7a6ooisztqx6pe2373jzx@mqzh62weo2jm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2025 20:25, Justin Tobler wrote:
> On 25/07/21 09:28PM, Lucas Seiki Oshiro wrote:
> 
>> +typedef const char *get_value_fn(struct repository *repo);
>> +
>> +struct field {
>> +	const char *key;
>> +	get_value_fn *add_field_callback;
>> +};
>> +
>> +static const char *get_references_format(struct repository *repo)
>> +{
>> +	return ref_storage_format_to_name(repo->ref_storage_format);
>> +}
>> +
>> +/* repo_info_fields keys should be in lexicographical order */
>> +static const struct field repo_info_fields[] = {
>> +	{ "references.format", get_references_format },
>> +};
> 
> Ok, so each key has a corresponding callback that is used to get its
> value. This works fine when we have one operation/callback per key, but
> I could see this being a bit inflexible in cases where performing a
> single operation could be expected to generate multiple keys worth of
> information at a time.
> 
> I certainly see this being the case with git-repo-stats where, for
> example, interating over references will produce multiple keyvalues
> indicating the number of branches, tags, remotes, etc. But, maybe for
> git-repo-info this will not be as much of a concern?

I think the fact that git_value_fn returns 'const char*' is a concern as 
it means we cannot return an allocated string. It would be better to 
pass a 'struct strbuf' to the callback and write the value to that 
instead. That way a callback can create the value piecemeal if needed 
and we don't have to worry about whether we should be free()ing the 
returned string.

An alternative approach would be to pass a function pointer to the 
callback which it then calls with the key and value to produce the output.

Thanks

Phillip
>> +
>> +static int repo_info_fields_cmp(const void *va, const void *vb)
>> +{
>> +	const struct field *a = va;
>> +	const struct field *b = vb;
>> +
>> +	return strcmp(a->key, b->key);
>> +}
>> +
>> +static get_value_fn *get_value_callback(const char *key)
>>   {
>> +	const struct field search_key = { key, NULL };
>> +	const struct field *found = bsearch(&search_key, repo_info_fields,
>> +					    ARRAY_SIZE(repo_info_fields),
>> +					    sizeof(struct field),
>> +					    repo_info_fields_cmp);
>> +	return found ? found->add_field_callback : NULL;
>> +}
>> +
>> +static int qsort_strcmp(const void *va, const void *vb)
>> +{
>> +	const char *a = *(const char **)va;
>> +	const char *b = *(const char **)vb;
>> +
>> +	return strcmp(a, b);
>> +}
>> +
>> +static int print_fields(int argc, const char **argv, struct repository *repo)
>> +{
>> +	const char *last = "";
>> +
>> +	QSORT(argv, argc, qsort_strcmp);
>> +
>> +	for (int i = 0; i < argc; i++) {
>> +		get_value_fn *callback;
>> +		const char *key = argv[i];
>> +		const char *value;
>> +
>> +		if (!strcmp(key, last))
>> +			continue;
>> +
>> +		callback = get_value_callback(key);
>> +
>> +		if (!callback)
>> +			return error("key %s not found", key);
>> +
>> +		value = callback(repo);
>> +		printf("%s=%s\n", key, value);
>> +		last = key;
>> +	}
> 
> If the user does not input any keys, we simply do nothing. I do wonder
> if this is really the best default behavior. Maybe instead we should
> error out? Or maybe treat it as though all keys were requested?
> 
> -Justin
> 
>> +
>>   	return 0;
>>   }
>>   
>> +static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
>> +		     struct repository *repo)
>> +{
>> +	return print_fields(argc - 1, argv + 1, repo);
>> +}
>> +
>>   int cmd_repo(int argc, const char **argv, const char *prefix,
>>   	     struct repository *repo)
>>   {

