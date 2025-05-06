Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BF1C84C5
	for <git@vger.kernel.org>; Tue,  6 May 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521757; cv=none; b=epxf2UTvYcQz0UIzG7bFTckZbqtwFvboI5TiHy99rAU1zKKXcxwehrblmpXP1t2E2f4ov1QnuW7B/Wb7PnM2scJT9dEh7NwppWDJfuAXARy/8yZmYVa/+k91ejWGCHhXTwh5kWo5AZ4nz4tY2pr6NmT2vElqvSY5fhKeELSw2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521757; c=relaxed/simple;
	bh=59qsiuxF1JympHLsFqWr3hgTl9Y4HCiU/yiMyR1stAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwBEW9Hr1njv/ZB9P15a6dcJ84zQe3JsP1zv9f8IP7WrqxYrSFzrOn576+CgIsszdPaWKPsJwbbAOm8PY8Z5H6aMiCZBqp/xzDLGjvewkn5QXfcFWXyuRUOA7v2/Iazu8O7riH1LeGGj+uVW96C2JJyj52aHDFQhkzG7qKJSsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuWhYETg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuWhYETg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso43292685e9.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746521754; x=1747126554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EZWfTScf5BMf2zIEhjGyr70wL2bIfidzNaZxSmLtHxc=;
        b=EuWhYETgi0QQEurOXxiP3vNqS06VAxj/2Y2cChpURR4VKvcZaalY22BGnjp96dj+Vr
         a5el1CWdhO4joFG22zbysePkylCK2UO7K5lGZqFfKhvA7OHAd4DK1T+cApvQwz1p+mcR
         dXCvhy4Y4JYIbRWBPTBy0/Id0LIGGtBbAAd+aPokrMdJEADWk0UuFNGPsu2ufUVjfOnZ
         Fw7YLOfHpETdZuYiCUOpsjbVLsI0W4Oc21fUXHwMrKpKMYB4iySikg+IiV9Ne8iVqTot
         snR7snXag5FjBb3mFaXjbkBmVKEd+cztf6Fm4Ocbfaxe5WFrf8riIhy35m1/xRgASwXc
         Hi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746521754; x=1747126554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZWfTScf5BMf2zIEhjGyr70wL2bIfidzNaZxSmLtHxc=;
        b=cmA7k3a+I0A3uWdeVPBD4Avbi9BzS7fLEeC6d5iYtCS7uGR4R8yz8Yx3CxTSMICcO+
         WJrCKrWOAZrJNdk4GET394UumqLB6Tc6mzu6HSGWWP6lG3/xnJws0NYwI8ZjgGMR3Dug
         0xSaWosyHg6futQ5+wrmwSjR3/39AUyD2szZe3frJe7HY6IKfanE633+64nG2tTVVtwN
         00oK7Nter7/8YBddR/kcIuQKdAXWeSNCk6RpYza7cvk4BYEVedehi8XVPmJlhGHl0xyV
         ENM4qh38CHAA+M8GKJyhQqqc+1X8trUfmdisF9ei6vTuCIP1RfVPROjYRxf7q9VcHkPw
         dwig==
X-Forwarded-Encrypted: i=1; AJvYcCXnBzJOry+A3mp9HSvhoVN2M84Zqy+w1IGupLtdSR0FRDpb5+uAHlSVWswrv+9k0uacgvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUP4rZzRtUrBSpQ01GkWgoTCMr6Q9Sj4qZhzHwDuY7CyMduBy
	mcAjhNcv9D8S7Vh/hvVA2G3605nU2HF/hgQQhE60KBs9lgosPdpF
X-Gm-Gg: ASbGncs+Z/G4Avcke13TSRZHCJ1X3aN4fiL8tRTkZUnxXLKsaFVeE9GpvdWHKimRdUz
	Od1PkuAFE8WJ8bpdW4MSOxqojM56mQTk2G85NAAnfdKjupf/rZ4x1Git8cQIJ8lYNCiGXm9LPq1
	r3lORfiplfRKiNojulPt5SPr3Czl8IWFP7so2oPKg8AqsFlLsLq8Lx5nntjVEqj4f6rtJGjQh97
	7cal0cYmnrenq0ZljPIpYpTHjqbdyA9CwuwCQGj8MXczL8wypSygEdM52mA5FiGUShhoQSVS8vW
	ZUS6R5G6H7LmAZ473CB4x6UB/s1Tj3YHjYUgJzsN6aAkB+lXF7Fv2zAAKGrGfOZ1rUXyQe+Lc8R
	/lH4JkrA2uPAzLANN
X-Google-Smtp-Source: AGHT+IEa1pZIat0fCWe1HH9iYtUrI9HH0pkc5EBGugvg/b9J3KV5NtsWSE7OE6ZTQ8MZZBflNDnrXg==
X-Received: by 2002:a05:600c:1e1c:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-441d050a63emr20885445e9.2.1746521753559;
        Tue, 06 May 2025 01:55:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28796sm206100075e9.33.2025.05.06.01.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 01:55:53 -0700 (PDT)
Message-ID: <c5591cbb-7eb9-4b69-85a1-ae1678983b14@gmail.com>
Date: Tue, 6 May 2025 09:55:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] add-patch: respect diff.context configuration
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Leon Michalak <leonmichalak6@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <8b91eef8120b8f92db953ec983fddce8a442abcc.1746436719.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <8b91eef8120b8f92db953ec983fddce8a442abcc.1746436719.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon

Thanks for working on this. I've left a few comments below but for your 
first submission this is very good.

On 05/05/2025 10:18, Leon Michalak via GitGitGadget wrote:
> From: Leon Michalak <leonmichalak6@gmail.com>
> 
> This aims to teach relevant builtins (that take in `--patch`) to respect
> the user's diff.context and diff.interHunkContext file configurations.

This is a good summary of the intent of the patch. I'd maybe drop "This 
aims" and instead say that the various commands do not respect the 
config and this patch fixes that.

> Since these are both UI options and `--patch` is designed for the end user,
> I believe this was previously just an inconsistency, which this patch hopes
> to address.
> 
> Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
> ---
>   add-interactive.c       | 16 ++++++++++----
>   add-patch.c             |  6 ++++++
>   t/t4055-diff-context.sh | 48 ++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index 97ff35b6f12a..ad12dc416598 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -41,6 +41,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>   	const char *value;
>   
>   	s->r = r;
> +	s->context = -1;
> +	s->interhunkcontext = -1;
>   
>   	if (repo_config_get_value(r, "color.interactive", &value))
>   		s->use_color = -1;
> @@ -78,6 +80,9 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>   	repo_config_get_string(r, "diff.algorithm",
>   			       &s->interactive_diff_algorithm);
>   
> +	repo_config_get_int(r, "diff.context", &s->context);
> +	repo_config_get_int(r, "diff.interHunkContext", &s->interhunkcontext);

This looks good

> @@ -1014,10 +1019,13 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
>   	if (count > 0) {
>   		struct child_process cmd = CHILD_PROCESS_INIT;
>   
> -		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached",
> -			     oid_to_hex(!is_initial ? &oid :
> -					s->r->hash_algo->empty_tree),
> -			     "--", NULL);
> +		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached", NULL);

As we're running "git diff" here nothing needs to be changed because it 
reads all of the relevant config variables itself. This is why the 
existing code does not worry about adding "--algorithm".

> diff --git a/add-patch.c b/add-patch.c
> index 95c67d8c80c4..b43ca1600738 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -415,6 +415,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   {
>   	struct strvec args = STRVEC_INIT;
>   	const char *diff_algorithm = s->s.interactive_diff_algorithm;
> +	int diff_context = s->s.context;
> +	int diff_interhunkcontext = s->s.interhunkcontext;
>   	struct strbuf *plain = &s->plain, *colored = NULL;
>   	struct child_process cp = CHILD_PROCESS_INIT;
>   	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
> @@ -424,6 +426,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   	int res;
>   
>   	strvec_pushv(&args, s->mode->diff_cmd);
> +	if (diff_context != -1)
> +		strvec_pushf(&args, "--unified=%i", diff_context);
> +	if (diff_interhunkcontext != -1)
> +		strvec_pushf(&args, "--inter-hunk-context=%i", diff_interhunkcontext);

This is good - if the user has set diff.config or diff.interhunkcontext 
then we pass the appropriate values to "git diff-index" or "git 
diff-files" which unlike "git diff" do not read those config values 
themselves.

>   	if (diff_algorithm)
>   		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
>   	if (s->revision) {
> diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
> index ec2804eea67c..9c024200ade7 100755
> --- a/t/t4055-diff-context.sh
> +++ b/t/t4055-diff-context.sh

I'm not sure this is the best home for the new tests. Normally tests 
related to the code in add-patch.c go into t3701-add-interactive.sh

> @@ -49,7 +49,53 @@ test_expect_success 'diff.context honored by "log"' '
>   	! grep firstline output &&
>   	git config diff.context 8 &&
>   	git log -1 -p >output &&
> -	grep "^ firstline" output
> +	grep "^ firstline" output &&
> +	git config --unset diff.context
> +'
> +
> +test_expect_success 'diff.context honored by "add"' '
> +	git add -p >output &&
> +	! grep firstline output &&
> +	git config diff.context 8 &&
> +	git add -p >output &&
> +	grep "^ firstline" output &&
> +	git config --unset diff.context

Eric has already mentioned using "test_config", I would go one step 
further and say that as we're only running a single command we should 
use "git add -c diff.context=* add -p" to avoid having to change the on 
disk config at all.

I would also recommend using "test_grep ..." rather than "grep ..." and 
"test_grep ! .." instead of "! grep ..." as they provide useful 
debugging information if the test fails.

Given the way the code is structured with the config being read in 
add-patch.c I'm not sure how much value there is in testing all the 
different "-p" commands. It would however be very useful to check that 
"git -c diff.interhunkcontext=8 add -p" works as expected.

I'll leave it there for now, I'll try and look at the other patches 
later today or maybe tomorrow.

Best Wishes

Phillip

> +'
> +
> +test_expect_success 'diff.context honored by "commit"' '
> +	! git commit -p >output &&
> +	! grep firstline output &&
> +	git config diff.context 8 &&
> +	! git commit -p >output &&
> +	grep "^ firstline" output &&
> +	git config --unset diff.context
> +'
> +
> +test_expect_success 'diff.context honored by "checkout"' '
> +	git checkout -p >output &&
> +	! grep firstline output &&
> +	git config diff.context 8 &&
> +	git checkout -p >output &&
> +	grep "^ firstline" output &&
> +	git config --unset diff.context
> +'
> +
> +test_expect_success 'diff.context honored by "stash"' '
> +	! git stash -p >output &&
> +	! grep firstline output &&
> +	git config diff.context 8 &&
> +	! git stash -p >output &&
> +	grep "^ firstline" output &&
> +	git config --unset diff.context
> +'
> +
> +test_expect_success 'diff.context honored by "restore"' '
> +	git restore -p >output &&
> +	! grep firstline output &&
> +	git config diff.context 8 &&
> +	git restore -p >output &&
> +	grep "^ firstline" output &&
> +	git config --unset diff.context
>   '
>   
>   test_expect_success 'The -U option overrides diff.context' '

