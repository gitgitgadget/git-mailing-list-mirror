Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C029E10F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921363; cv=none; b=S6Zy8VLBaXKTS/CTOJe3Jxr27Q3L4w09zyuOqVmsmHp/dQuVm+Fhsa0pxBnC411yBjrect7qHrqK/ubheiM6z12Qo8QRpG0GdoVJJ9HwJWo+vYmt9jXRMzvluhpZ4tjvb2qkKzDHIK2vtV/OphFALIQmkz+f4EKATL8t+AHkgLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921363; c=relaxed/simple;
	bh=17zmyFnKErUNeG23qcynCKDc9QyD8tey4+IFgSKeeY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpkLwjGyRhjihgTA85Y1Pmu6j7d2jfs5LTVm+f7d+FvV14GU5yfoBor0qLCeVjzQYYBudKm+mHwpj0vXi+ZrK9NdHc1EvwyxYw5Zyf1ijVZ8iJp68Vf9E0qu2m9zMOgMsktUuUoEdYlrERheHMGS8AyMMqk+esNORntO/WQ5FjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcaemURz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcaemURz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3591cc98871so2198631a91.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774921361; x=1775526161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ly3JQ6PqWC0OV9fDlOiI5zOdEP+lVe1d1ltTrnG7lQ=;
        b=UcaemURz6GcU8ofzZReBSW1Sg6ASnBUtO+JaZJI8PG6q4CQ5JSNSbYg/cqW8rYlZAJ
         IMto1FT8kywR0PvEHYLVSEfq5fBzUE2j9pJ2RmaxNCPAnazebwg5F13Qn/Z91Dv6NOm5
         7ap8azxYie+JjjU7D6JoZYNJrTDt5F+leD+2K1/sGg4lviqVYSOkUQdAn6e+U7D3vYO3
         Q4B69xObKaZ1NxDGgeftb0Zf7Qrb+oUgockoHsb9lBfwIVxdBj5eQIfKqHfyAU+oNu6s
         o2coVe7JtboGv3cRFZk5IPsrCs+0n4LkRQHVIQ5Oxn8uihA03cihvWH/jpHq02KEez95
         onDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774921361; x=1775526161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ly3JQ6PqWC0OV9fDlOiI5zOdEP+lVe1d1ltTrnG7lQ=;
        b=N1kaBvRue+cagDlnWxd7CyLgBu+xp2zLmSEesqXKErgUbKPur92hG4icl2TAXXlQWl
         vyBa2CZUyevNjZZdcYVvouWCcdTtRCiu+TPmuGbTUTSCNdLarzXmQl7nP7rxqjvb5UK+
         dkAsXzF9suH2dA+c/3C2rXu/KKDiDfe7XnFORJMfnu082QdcQqcAhzY3aKmdgbc7XslV
         VS7Axs4L4f2wLs8O/PyF0c1MWUfoOzR5+sQqRNmLZ54Z8GFgTtjgQ9ZoMMGPjWEvbKKL
         +5nHNBFce1pIYnCHPMF2po87wEzyGHl0KAO2nSY0W/zrSh+IMFKZeYFffTumsrAnl4HI
         OUsw==
X-Forwarded-Encrypted: i=1; AJvYcCWJarWqMve/zWNWP+9P6DxZFCfX7DPKsOdz//2vCqJyVBTurx/XPgE+JLACTx80KShKnJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzycvfjIm0J9bvdlIW8BjXTn7BpYYDWqv/IET1k0un87D7uWMhF
	FmEJouv17eYDdGzAGUGAXohvDKIMpFger3tJraQpghPFJYsJYZrrJrHT
X-Gm-Gg: ATEYQzy6+XqCif5+jGtcTEUn8Bo7daeudSWgn7DPuSeWNgSqL4YoeagDPIHBkvYy0Ea
	obk6/5F6COGSudNzZrpETdGKMYFA5bs2RbVmIJ1F6WbLhirxacSiRZvpULfWRINiQGbgl8J/Y9f
	Kkz4cTRqN4ugdjD/tEZEOLQ/id7N1P0tz5sgInJpD972CIH0KXMldGQ2BYL2SEBZxfZVj+NQaZV
	HqoTBpuUzfYo7tWmbMWsBMb9gKMj6UBoJBGeeZ+Q2wKnrT8d00IEiPG0ZCY1cnEhonlEbxmiMBO
	l3x/4RwFBYHlM2qj2ANF8pEXeDNUcZdTLVkJys04TEWp/llG4rfbvIKNFFk46FBK1laUMnj3uId
	mr9hhHEl2yICZpyrF4unMguAi5gAmjEY0ZmCr85aM/1F5swXAe7cNW4m9+K9G3pa8nBNourzz4n
	bKdPuteSNvIRueWFz3j/SRbvEtyWPEgG+SB5XZe6rSKWGiS9okP91o2YGnnX8JatDISDwQxw4i+
	EEYzNSUbnwhdgvp256nZ5LS4MymtYDYOPw=
X-Received: by 2002:a17:90b:35ce:b0:35b:945d:752a with SMTP id 98e67ed59e1d1-35c30076feemr13194377a91.17.1774921360828;
        Mon, 30 Mar 2026 18:42:40 -0700 (PDT)
Received: from ?IPV6:2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b? ([2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba590d78sm139216a91.2.2026.03.30.18.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 18:42:40 -0700 (PDT)
Message-ID: <49662ba7-3685-4745-8f23-7a9ba44c7966@gmail.com>
Date: Tue, 31 Mar 2026 07:12:36 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to
 --batch-command
Content-Language: en-GB
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, gitster@pobox.com, toon@iotcl.com
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-2-siddharthasthana31@gmail.com>
 <CAOLa=ZTqk3rG21e5H5HLDCw6MWK2ndgi=4pC0ZUWn98z39SSEQ@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAOLa=ZTqk3rG21e5H5HLDCw6MWK2ndgi=4pC0ZUWn98z39SSEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/03/26 15:14, Karthik Nayak wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> 
>> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
>> but this option needs to be set when the process is created. This means
>> we cannot change this option mid-operation.
>>
>> At GitLab, Gitaly caches git-cat-file processes and it would be useful
>> if --batch-command supported toggling mailmap dynamically with existing
>> processes.
>>
>> Add a `mailmap` subcommand to --batch-command that takes a single
>> argument: `yes` to enable mailmap and `no` to disable it. When enabled,
>> mailmap data is loaded from disk on first use and kept in memory so that
>> toggling back on does not require reloading.
>>
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>> CI: https://gitlab.com/gitlab-org/git/-/pipelines/2416081861
>>
>>   Documentation/git-cat-file.adoc |  7 +++++
>>   builtin/cat-file.c              | 30 ++++++++++++++++++---
>>   t/t4203-mailmap.sh              | 48 +++++++++++++++++++++++++++++++++
>>   3 files changed, 81 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
>> index c139f55a16..af32e929a8 100644
>> --- a/Documentation/git-cat-file.adoc
>> +++ b/Documentation/git-cat-file.adoc
>> @@ -174,6 +174,13 @@ flush::
>>   	since the beginning or since the last flush was issued. When `--buffer`
>>   	is used, no output will come until a `flush` is issued. When `--buffer`
>>   	is not used, commands are flushed each time without issuing `flush`.
>> +
>> +mailmap <yes|no>::
>> +	Enable or disable mailmap for subsequent `contents` and `info`
>> +	commands. When `yes` is given, mailmap data is loaded from disk on
> 
> Are there any commands that the mailmap wouldn't apply to? Would it make
> sense to simply say
> 
>        Enable or disable mailmap for subsequent commands.


Good point, agreed. I will simplify the wording in v3 and avoid listing 
specific commands there.


> 
> also we can s/is given//.
> 
>> +	first use and kept in memory; passing `yes` again does not reload it.
>> +	When `no` is given, mailmap is disabled but the data stays in memory
>> +	so that a later `mailmap yes` does not need to reload it from disk.
> 
> I think the first sentense here jumps directly into the the caching
> mechanism on using `yes`. It's more important for users to know what
> `yes` implies. So perhaps:
> 
>      When `yes` mailmap data is used and disabled on `no`. The first
>      `yes` caches the mailmap data until the command exits.
> 
>>   --
>>   +
>>
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index b6f12f41d6..a53926d2bb 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -54,6 +54,7 @@ static const char *force_path;
>>
>>   static struct string_list mailmap = STRING_LIST_INIT_NODUP;
>>   static int use_mailmap;
>> +static int mailmap_loaded;
>>
> 
> Nit: should we use a 'bool' here?


Yes, makes sense. I will switch that to bool in v3.

> 
> So we use a variable and not simple rely on checking `mailmap.nr`
> because it is possible that we do load the mailmap but there are no
> entries. I assume we could rely on `maimap.cmp` being non-NULL, but
> that's getting into implementation details.
> 
>>   static char *replace_idents_using_mailmap(char *, size_t *);
>>
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
>> +
>>   static void dispatch_calls(struct batch_options *opt,
>>   		struct strbuf *output,
>>   		struct expand_data *data,
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
>>
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
>>
> 
> The rest of the code looks good.
> 
>>   	switch (batch.objects_filter.choice) {
>>   	case LOFC_DISABLED:
>> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
>> index 74b7ddccb2..f66637cd86 100755
>> --- a/t/t4203-mailmap.sh
>> +++ b/t/t4203-mailmap.sh
>> @@ -1133,6 +1133,54 @@ test_expect_success 'git cat-file --batch-command returns correct size with --us
>>   	test_cmp expect actual
>>   '
>>
>> +test_expect_success 'git cat-file --batch-command mailmap yes enables mailmap mid-stream' '
>> +	test_when_finished "rm .mailmap" &&
>> +	cat >.mailmap <<-\EOF &&
>> +	C O Mitter <committer@example.com> Orig <orig@example.com>
>> +	EOF
>> +	commit_sha=$(git rev-parse HEAD) &&
>> +	git cat-file commit HEAD >commit_no_mailmap.out &&
>> +	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
>> +	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
>> +	size_mailmap=$(wc -c <commit_mailmap.out) &&
>> +	printf "info HEAD\nmailmap yes\ninfo HEAD\n" | git cat-file --batch-command >actual &&
>> +	echo $commit_sha commit $size_no_mailmap >expect &&
>> +	echo $commit_sha commit $size_mailmap >>expect &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'git cat-file --batch-command mailmap no disables mailmap mid-stream' '
>> +	test_when_finished "rm .mailmap" &&
>> +	cat >.mailmap <<-\EOF &&
>> +	C O Mitter <committer@example.com> Orig <orig@example.com>
>> +	EOF
>> +	commit_sha=$(git rev-parse HEAD) &&
>> +	git cat-file commit HEAD >commit_no_mailmap.out &&
>> +	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
>> +	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
>> +	size_mailmap=$(wc -c <commit_mailmap.out) &&
>> +	printf "mailmap yes\ninfo HEAD\nmailmap no\ninfo HEAD\n" | git cat-file --batch-command >actual &&
>> +	echo $commit_sha commit $size_mailmap >expect &&
>> +	echo $commit_sha commit $size_no_mailmap >>expect &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'git cat-file --batch-command mailmap works in --buffer mode' '
>> +	test_when_finished "rm .mailmap" &&
>> +	cat >.mailmap <<-\EOF &&
>> +	C O Mitter <committer@example.com> Orig <orig@example.com>
>> +	EOF
>> +	commit_sha=$(git rev-parse HEAD) &&
>> +	git cat-file commit HEAD >commit_no_mailmap.out &&
>> +	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
>> +	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
>> +	size_mailmap=$(wc -c <commit_mailmap.out) &&
>> +	printf "mailmap yes\ninfo HEAD\nmailmap no\ninfo HEAD\nflush\n" | git cat-file --batch-command --buffer >actual &&
>> +	echo $commit_sha commit $size_mailmap >expect &&
>> +	echo $commit_sha commit $size_no_mailmap >>expect &&
>> +	test_cmp expect actual
>> +'
> 
> Shouldn't we also add tests for how this interacts with '--mailmap' and
> '--no-mailmap'?


Agreed, that coverage is missing. I will add tests for startup option + 
runtime toggle interaction in v3.


> 
>>   test_expect_success 'git cat-file --mailmap works with different author and committer' '
>>   	test_when_finished "rm .mailmap" &&
>>   	cat >.mailmap <<-\EOF &&
>> --
>> 2.51.0

