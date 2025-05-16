Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137E14F90
	for <git@vger.kernel.org>; Fri, 16 May 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401506; cv=none; b=ndh5DdlzwF4pviujyRul1I78lxgmilW6rALQPjhfljzS3EnGzfjOiXvqYT5FMD+YpsKOwpl99/TVQZt74xYfg2su5yoRo1dLylRRDOKYQzYhTsIT710Sg/ABhPtYsspVfXW3imlUsve5JRFE5hXoEv9bhFwJYWbn8FiWUqy9msI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401506; c=relaxed/simple;
	bh=b1K41SBDMhT0CaOJzjAme8vQlykI1DZZ9aOCox7QUwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBRkgJ/rWWiPOqY95SwtHH5dN4M0l49Ayd8zInqx8iOmQ9zndhk/0qbL3iycsl83mPC7Jj/Ta8iHVzkTkovut9PsfyVWWjTEIKrbdzQJAkBo7rqBjNwsd1fhlTeg+qvoqZwZXuWgD4LUZINMrCrhTkGA3aanzyJ1guGs2vomtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV5gM0Jo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV5gM0Jo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0618746bso16967385e9.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747401503; x=1748006303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zQS/7Of/o1HixbGdqFgSkx44+Ady5eRMH5awOWkYwOQ=;
        b=QV5gM0JoNguptDTpTWsG1UHW5EQP/71UiEIuH2fBv/FRKe6Rp2HAQszM5U+nJu8NQI
         DlF4K0iUY+RDG2vuNxBS3lwLX9aA3AZAua9iayRCbNVzjvHNtvBYazUlgusB2kl0hXsQ
         5r9DSnIpDcpxdCRLC0HIqIg9AbYMf7B1Nylrz6KJsmyePnn+2OJwlCya38hKmQbAE+5k
         nfvfMlAikEu3zAMcEZLoMM5T5cq+PK45UYj9hrrSn2/dj5BwT4gc5DIpkOPAlB+oNdG3
         snMFMbo5DTNulUjYLNeIbNTg4udwSnGRwB8vMbSw08+mVWRKBWe+BLIKTdQyYS7ma4rp
         iyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747401503; x=1748006303;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQS/7Of/o1HixbGdqFgSkx44+Ady5eRMH5awOWkYwOQ=;
        b=Schbnagfti5YjOAh2h5WKKL2HJwX86FCtsi4a9qBqqKA1dFBsx4+WNwSG0yDE0P730
         aOxSNwpLDRHHJrJOHHFd+PdJZ8mZWMXh8x7T2232sCZFxTnSAnPfRVtQE48MuR4s3yEb
         aJeGT9dhSSQhzkxE+1i9Uff6dc1LzTnHkffDC+bk/u9DxVklV3hpWSg5Dubs+Av9YrZy
         MgnQAvpM9mt+Ejkm2eC8OKrpr0BpMfQst6bwDBfpo9b5DtizCmw35j7z8KH94MB9uDiQ
         h2urgKV61jbKenRzs+oZBRwCVSpLfd9JFAP5xLt6bjWrTXDxz83zeuH0C8nTes/r4I/O
         C7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNLVHYge9MXViTL5r8r/r8xWDU0VlJoX7ngB3uxeIwN/jhjkJO/ZpvVAflXZE4cdBsWXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOFCwvSctIv5+oZ9GvMFBhgoYYNDHdiiDIw9bEz64Es5L6NTt
	5fZqrkVALQE5VS1mBHDLWZmTI1chfTW79nwxwrvLx1xQRtCLiGuFPI3N
X-Gm-Gg: ASbGncur8ygg1oqC7EXjQ9s8YRCjOzNxejRgxROtJmuBsW2aVZvpzWsQ/pUchGeX4Bh
	3Qx1pwG5GeMlN4WKctxh+J223y17usyOCISkQ8gqGJ0/+OT/aoco+2wv7rutg0u9QKBxhXrS6Ek
	+rEgSLJ3FMpbczbXvn+E4pRMNWkzacBkCkbP1xDWcauVKgLEe4Nx2WaNkf/7kh/MacXiXvQEAdQ
	QVGEvHuy5w/4nUuC2pdsizsZVd30aeAGGqupW3IeuhbiqhX4R7MHEFkt/SmfkqlUuVR7uswP5Lf
	sL7W/xLXNY72YDhSDWz76zU/eP5MYl7/ABbD4vulkGVHXrQ6CwZvsRT3DgPJ/k7Jg0r+vvHGHa8
	//TV1tQWEhfGtvUCcPwaTGZeHoIU=
X-Google-Smtp-Source: AGHT+IF/j63V3o/05sjjn1P3Poxw1DuIqep9Ghe3hLrPgmEqmirimswXtW+5sJyyJdcu0j1AE2FWLw==
X-Received: by 2002:a05:600c:468a:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-442fefee29dmr20813975e9.11.1747401502721;
        Fri, 16 May 2025 06:18:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583f07sm32654185e9.31.2025.05.16.06.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 06:18:22 -0700 (PDT)
Message-ID: <23e4267a-34fb-414d-bae3-7f607d3bdbec@gmail.com>
Date: Fri, 16 May 2025 14:18:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] merge-tree: add a new --dry-run flag
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
 <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
 <f11824317a8050764fe35698039f863dd842b0c2.1747182288.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <f11824317a8050764fe35698039f863dd842b0c2.1747182288.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 14/05/2025 01:24, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> +--dry-run::
> +	Disable all output from the program.  Useful when you are only
> +	interested in the exit status.  Allows merge-tree to exit
> +	early when it finds a conflict, and allows it to avoid writing
> +	most objects created by merges.

I don't want to bike-shed but to me this feels more like "git diff 
--quiet" than "git push --dry-run"  or "git send-email --dry-run" which 
still print diagnostic messages.

Best Wishes

Phillip

>   --allow-unrelated-histories::
>   	merge-tree will by default error out if the two branches specified
>   	share no common history.  This flag can be given to override that
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 4aafa73c6155..273ec171e988 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -490,6 +490,9 @@ static int real_merge(struct merge_tree_options *o,
>   	if (result.clean < 0)
>   		die(_("failure to merge"));
>   
> +	if (o->merge_options.mergeability_only)
> +		goto cleanup;
> +
>   	if (show_messages == -1)
>   		show_messages = !result.clean;
>   
> @@ -522,6 +525,8 @@ static int real_merge(struct merge_tree_options *o,
>   	}
>   	if (o->use_stdin)
>   		putchar(line_termination);
> +
> +cleanup:
>   	merge_finalize(&opt, &result);
>   	clear_merge_options(&opt);
>   	return !result.clean; /* result.clean < 0 handled above */
> @@ -538,6 +543,7 @@ int cmd_merge_tree(int argc,
>   	int original_argc;
>   	const char *merge_base = NULL;
>   	int ret;
> +	int dry_run = 0;
>   
>   	const char * const merge_tree_usage[] = {
>   		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
> @@ -552,6 +558,10 @@ int cmd_merge_tree(int argc,
>   			    N_("do a trivial merge only"), MODE_TRIVIAL),
>   		OPT_BOOL(0, "messages", &o.show_messages,
>   			 N_("also show informational/conflict messages")),
> +		OPT_BOOL_F(0, "dry-run",
> +			   &dry_run,
> +			   N_("suppress all output; only exit status wanted"),
> +			   PARSE_OPT_NONEG),
>   		OPT_SET_INT('z', NULL, &line_termination,
>   			    N_("separate paths with the NUL character"), '\0'),
>   		OPT_BOOL_F(0, "name-only",
> @@ -583,6 +593,18 @@ int cmd_merge_tree(int argc,
>   	argc = parse_options(argc, argv, prefix, mt_options,
>   			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>   
> +	if (dry_run && o.show_messages == -1)
> +		o.show_messages = 0;
> +	o.merge_options.mergeability_only = dry_run;
> +	die_for_incompatible_opt2(dry_run, "--dry-run",
> +				  o.show_messages, "--messages");
> +	die_for_incompatible_opt2(dry_run, "--dry-run",
> +				  o.name_only, "--name-only");
> +	die_for_incompatible_opt2(dry_run, "--dry-run",
> +				  o.use_stdin, "--stdin");
> +	die_for_incompatible_opt2(dry_run, "--dry-run",
> +				  !line_termination, "-z");
> +
>   	if (xopts.nr && o.mode == MODE_TRIVIAL)
>   		die(_("--trivial-merge is incompatible with all other options"));
>   	for (size_t x = 0; x < xopts.nr; x++)
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index f9c5883a7f7c..566a2b4ec737 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -54,6 +54,25 @@ test_expect_success setup '
>   	git commit -m first-commit
>   '
>   
> +test_expect_success '--dry-run on clean merge' '
> +	# Get rid of loose objects to start with
> +	git gc &&
> +	echo "0 objects, 0 kilobytes" >expect &&
> +	git count-objects >actual &&
> +	test_cmp expect actual &&
> +
> +	# Ensure merge is successful (exit code of 0)
> +	git merge-tree --write-tree --dry-run side1 side3 >output &&
> +
> +	# Ensure there is no output
> +	test_must_be_empty output &&
> +
> +	# Ensure no loose objects written (all new objects written would have
> +	# been in "outer layer" of the merge)
> +	git count-objects >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'Clean merge' '
>   	TREE_OID=$(git merge-tree --write-tree side1 side3) &&
>   	q_to_tab <<-EOF >expect &&
> @@ -72,6 +91,25 @@ test_expect_success 'Failed merge without rename detection' '
>   	grep "CONFLICT (modify/delete): numbers deleted" out
>   '
>   
> +test_expect_success  '--dry-run on conflicted merge' '
> +	# Get rid of loose objects to start with
> +	git gc &&
> +	echo "0 objects, 0 kilobytes" >expect &&
> +	git count-objects >actual &&
> +	test_cmp expect actual &&
> +
> +	# Ensure merge has conflict
> +	test_expect_code 1 git merge-tree --write-tree --dry-run side1 side2 >output &&
> +
> +	# Ensure there is no output
> +	test_must_be_empty output &&
> +
> +	# Ensure no loose objects written (all new objects written would have
> +	# been in "outer layer" of the merge)
> +	git count-objects >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'Content merge and a few conflicts' '
>   	git checkout side1^0 &&
>   	test_must_fail git merge side2 &&

