Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EAA12CD8B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921242; cv=none; b=EpkpW1k2dI4Bcp8ZWy94H0W/qcUK2jFid4kmVs+8NgycEFMBTHMuZJcx6CiLb4NySc7ccjf8hkLwAqADDcxQdUqMcYJztRM73wyBrSo1Hy+vp+BMtzvtIXrxPYB2whBP4LcSVb7E/38/G4sU4umPQAXDy9RXo5R4P55J0oipbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921242; c=relaxed/simple;
	bh=t5QH3HG+87TwuRgmxXT6HKSyAVF35iyikLDmjqDtF5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWyKW9VDFC83DtW1DwZBaESHWymrWSUmgBz1vZ0lkjulXE/S3SHX+TFtbGCWPhQIJdgbPMS7pYwnKZTkLZWgCoF1Wb4jTYFs/ruZycTqjITCf4DKIyzKm/4alraLPM0JcU2Z04oENCBglI0GJvmJTIywsIG+kLWL0EfhjXAQ+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pK3pVx95; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK3pVx95"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70f91776fcso2020029a12.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774921240; x=1775526040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lz/Z1PcwgK48GHqcrGOdLrQZpdHqJTe+7yjLpy9yAtA=;
        b=pK3pVx95jwfxh74qU4vzPXy2XzJXokyIxFnKkwn8/FKV30Nrm47lyFEQ9JTZeZgbfs
         5z9O097EU9+MQoJXIx8Hujb8dFTmmPPSF0NwNPs5QTqOHw3JaHUbGMcy8MrBj9LuH5g4
         dho6RhHgCxK7/beqN0nPrDKyFZ1CYIu+QaCWAJMw7dNT10Qn3mxuTeHoCVAurK7ZlAGS
         G4kNUUpSrLRLArXO0H7C9onjZyvZZBCLbkdiwmbtActuF4FE3WxLeje/7J4y6zmLLw6h
         ZWXPsDVjfczZMfLnazk4oCVSjp7kbA3soUGVskYYJ8Wtbz1PhV2LKrXYHVh8Qxc2w1R5
         MTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774921240; x=1775526040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lz/Z1PcwgK48GHqcrGOdLrQZpdHqJTe+7yjLpy9yAtA=;
        b=McWMgLr+yXm2LKJjbZXK6jgnbSvasXY3raZ0jFQ1QkpwOXhU4fzIlqxPYhMt4KdgQJ
         wa8qyCN9dOUEZCGuXC7XNYZSc1jGrKkKulJ8+DzrS9YLT/vjUqJbg4oSOUco3xOuynsT
         5ptsSlKzJwxX4ntqpTy7bKMvyWPhwHG0UqPC/sTICMgBvBH1znaLON6HpafERK4oaBDg
         unje4iDsKj32qc0/TeYfU8bHjEcSf/zMqPyrMRZRFPTyGbGxq/1UqN9QU/dJ46pNE0wN
         K/sVzmLn+ty6jcBfTLhedoggztEDVePNpO3ntoY5kYi9BxVxvaRWbLGsFgUbX+bNf5op
         9YEA==
X-Gm-Message-State: AOJu0YyHezwG/P69ofbJ3hNuT6apGcuYyerhUOlZCPbEbOljT+NgYdGN
	97LO/E+6EZzkbPx8inSt9hMglyG+j7v3g6jmErGkQd/3RzB657xcpGYy
X-Gm-Gg: ATEYQzzUVNbyryHL+J599mAIjYBEgcpIMNEZ9CxJyWdM1Vxr2OXX+6io//iC0/BxtO2
	SPXowIkDfhhyz1slKRJJJa7RPlu2y5k2y6KWfx8VzhOz7K1Ht52982D4M4ax5UpEpYRtj8r52cj
	13ZpuhTw77fZ6xGhuJFUzsmtPHboqSahBfeRRWdnEAiE7a5no0X5aaBVRchFltHP25bGs9SaxfB
	ONFwDXjR+Yx200A1COsw9E8c/B5cD0pXUzaTZcEYvOzRfO58fBLp1/ZPsGIffxSv2iC5Loej5Ph
	X29T4BYFNDRosJ8FDfJn0tjLzjKLfqBM8HixGrBv4hUgK/CnvNMid6jqtJZclmJOAJz6Ts8oXQU
	YbftjFEUyxTaOKVm0YuXtKhRF9X81QDph0N3twq/zUX6DHJwAadptNeGxAnC9nYQUpgSEG9WI0t
	rhCZqxsU9PxSwu5cKxh9lHNEDNUUWUu7hnETUAdhtW7PLlClPL+EbD+Qol/a7TDEsyYAN+pvuW+
	FCq+UBs0LcBgVS7V8MbZsCwqdmiHAwWIBjqpQB6J01EBg==
X-Received: by 2002:a05:6a20:3d08:b0:39b:edcd:d92f with SMTP id adf61e73a8af0-39c87849172mr14895999637.11.1774921240166;
        Mon, 30 Mar 2026 18:40:40 -0700 (PDT)
Received: from ?IPV6:2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b? ([2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cdc16317csm289913b3a.22.2026.03.30.18.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 18:40:39 -0700 (PDT)
Message-ID: <72543649-7994-4220-86fb-e3c84faf0b6a@gmail.com>
Date: Tue, 31 Mar 2026 07:10:35 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to
 --batch-command
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, christian.couder@gmail.com,
 ps@pks.im, toon@iotcl.com
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-2-siddharthasthana31@gmail.com>
 <xmqqtstyf4lj.fsf@gitster.g>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqtstyf4lj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/03/26 07:42, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> 
>> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
>> but this option needs to be set when the process is created. This means
>> we cannot change this option mid-operation.
>>
>> At GitLab, Gitaly caches git-cat-file processes and it would be useful
> 
> Would "keeps interacting with a single 'cat-file' process" be more
> accurate than "caches"?  The latter gives, at least to me,


Thanks Junio

Make sense, I will update that wording in v3!


> connotations that may not be necessarily true, like (1) there is a
> pool of cat-file processes waiting for Gitaly to connect and serve,
> (2) a running Gitaly may decide to disconnect from cat-file from
> time to time, and then reconnect to one of them when it becomes
> necessary again, etc.
> 
>> if --batch-command supported toggling mailmap dynamically with existing
>> processes.
>>
>> Add a `mailmap` subcommand to --batch-command that takes a single
>> argument: `yes` to enable mailmap and `no` to disable it. When enabled,
>> mailmap data is loaded from disk on first use and kept in memory so that
>> toggling back on does not require reloading.
>>
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
> 
> This is over-crediting me.  The idea to unify the two commands into
> one may have come from me, but that is at most helped-by but it is
> perfectly fine without any credit.


Got it, thanks for pointing that out.


> 
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
> 
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index b6f12f41d6..a53926d2bb 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -54,6 +54,7 @@ static const char *force_path;
>>   
>>   static struct string_list mailmap = STRING_LIST_INIT_NODUP;
>>   static int use_mailmap;
>> +static int mailmap_loaded;
> 
> Not part of this topic, but in case less experienced developers who
> are watching from the sidelines wonder if we want to add this
> file-scope global variable, this is perfectly fine.  Anything under
> builtin/foo.c are meant to serve a single command "git foo" and does
> not benefit from "let's sift globals into classes that belong to
> different concepts in the system; most of which will be per
> repository, so make them some part of the repository object"
> movement as much as more library-ish parts of the system.
> 
> Until a specific command starts working on multiple repositories at
> one time, that is.
> 
> 
>> @@ -692,6 +693,24 @@ static void parse_cmd_info(struct batch_options *opt,
>>   	batch_one_object(line, output, opt, data);
>>   }
>>   
>> +static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
>> +			      const char *line,
>> +			      struct strbuf *output UNUSED,
>> +			      struct expand_data *data UNUSED)
>> +{
>> +	if (!strcmp(line, "yes")) {
>> +		if (!mailmap_loaded) {
>> +			read_mailmap(the_repository, &mailmap);
>> +			mailmap_loaded = 1;
>> +		}
>> +		use_mailmap = 1;
>> +	} else if (!strcmp(line, "no")) {
>> +		use_mailmap = 0;
>> +	} else {
>> +		die(_("mailmap: unknown argument '%s', expected 'yes' or 'no'"), line);
>> +	}
>> +}
> 
> OK.
> 
>> @@ -725,9 +744,10 @@ static const struct parse_cmd {
>>   	parse_cmd_fn_t fn;
>>   	unsigned takes_args;
>>   } commands[] = {
>> -	{ "contents", parse_cmd_contents, 1},
>> -	{ "info", parse_cmd_info, 1},
>> -	{ "flush", NULL, 0},
>> +	{ "contents", parse_cmd_contents, 1 },
>> +	{ "info", parse_cmd_info, 1 },
>> +	{ "flush", NULL, 0 },
>> +	{ "mailmap", parse_cmd_mailmap, 1 },
>>   };
> 
> Mixing style fixes to existing entries in the same patch that adds a
> new feature by adding a new entry to the table is annoying than
> having a preliminary clean-up patch that only fixes style and then
> the main patch that adds the feature.


Agreed. I will avoid mixing style-only cleanup with the feature change 
in v3.


> 
>>   static void batch_objects_command(struct batch_options *opt,
>> @@ -1127,8 +1147,10 @@ int cmd_cat_file(int argc,
>>   	opt_cw = (opt == 'c' || opt == 'w');
>>   	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
>>   
>> -	if (use_mailmap)
>> +	if (use_mailmap) {
>>   		read_mailmap(the_repository, &mailmap);
>> +		mailmap_loaded = 1;
>> +	}
> 
> Hmph, interesting.  Two points.
> 
>   * It would make it easier to follow if these two lines are made
>     into a small helper function to be called from here and from the
>     "parse_cmd_mailmap()"?
> 
>   * Can we somehow make mailmap object itself slightly smarter so
>     that it knows if it has already been asked to read the data from
>     its sources?  It is a pretty dumb string_list, but from a cursory
>     read of the code flow, it seems that mailmap.strdup_strings is
>     initialized to be false in builtin/cat-file.c and then one of the
>     first things done in mailmap.c::read_mailmap() is to flip that
>     bit on, so the "yes" part of the parse_cmd_mailmap() might become
> 
> 	if (yes)
> 		load_mailmap();
> 
>     with the helper load_mailmap() that may look like:
> 
> 	static void load_mailmap(void)
> 	{
> 		if (mailmap.strdup_strings)
> 			return; /* we know read_mailmap() flips it on */
> 		read_mailmap(the_repository, &mailmap);
> 	}
> 
>     The first bullet point to introduce a small common helper will
>     help hiding such an ugly implementation detail there.


Thanks, this is helpful.

I will introduce a small helper and call it from both places so the flow 
is easier to follow. I will also avoid publicating the load check in 
each callsite
