Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833527FB26
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180365; cv=none; b=sKY9POXK5/2FSutGotHajeAyeNIxv/j5uNAp3hcSsvW7nx08ljF004iT9TzrmxKxAjRf8q9Q02cJzrhlz9mRMGRMuYfIC/qharamThurDs6Wxa2JFjrscGBsIhEBj9S+DGDV1Yxx3chLsD01K+5Xhd6glbj5Hd5w76sosPUI+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180365; c=relaxed/simple;
	bh=k5gnp3Lw2IAUAiCKQq2LusGi08K0tZ2Btd4l9cOMMZA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oWuESpkGbmff5lv2ZixBXeiUFpFPcXPmfDungxZiImU3cxI5ixE7mIaj14w/eHHEN8yl331fI+dGZq9/dnUhV7TqWXTlweD8AlNYlNy7S2G1jR+yr3Ll7W7OEVxIUA2jDSu8T7mTH2D6gbP5fHncurBNcepXZJuvry7S6nKf8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBQlsrdS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBQlsrdS"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2332867f8f.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 06:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762180362; x=1762785162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CpwOrCSYKo8ydQt01Wu2O96QH1SoUGB49CqG1tUI1U=;
        b=dBQlsrdSvIYamuoRYs0cNg9esgYCRuU6DTnRG6aj4LuvfSeI2LNgzjbS5ucLZ2Gob0
         QffzlCJVoDbAVLjvNkfTEbTBuGMMxax8TC3xDB1+hdDupaw/Xsg72xpcAuGr0+r4Bbc5
         XzfBA3idKx/UpUP4Kp83NQLxtoJXp9LEVGh61XmIZI9oiIm7kgaf7swjOIHi4DIfZx8o
         jRyNgz0uKrydOgznd76XtAyrcXYs3uYH+30aRbzDltWFeOz1EcvZNYfhtk3mvxJvY8gl
         GmNMZhQ944gwhKyfJi9p8rZu+Eaqv4HyB3tJbbFW1TeGEkpK+ikvUXjTYFRS2+QPqIeX
         9bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762180362; x=1762785162;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CpwOrCSYKo8ydQt01Wu2O96QH1SoUGB49CqG1tUI1U=;
        b=ACmrjQzH7Yz+bmDI8OAhlIrolXe5iZhIUbZVPP4nJ237030KoRggRTWxPRJKcRd7F7
         WgqJ8Cj8jYegGUfJxUP03Eh/zceySVIp0fIYcfr4iUsXV7tWiFhBoMPlTkTKP7bT1N/C
         O4svjHxo0eMhBL5W+DlCw9wOfl+G8MUNpJyCgVMQjvgKjb95NL7mFx3GWFIf/J6e8zqH
         VLD/FB79QkzjFSZGvEgRnWmnwTmky3700LfvWE8kAeBrz5KnVXe6wdvUcw4vpzV3Yi4y
         eZXHiF3P+E85i6B6i6dEjBt5+i0CAkvxcJQoredyhOE0I99m5bR5+BEChzTzLHeRcKvX
         VDGA==
X-Forwarded-Encrypted: i=1; AJvYcCXY64Cark6Oyk6dYP9Lss2K4YQCuYz1Hy1/lUBwYb/QFDUpILUDZAxCy8JxEDxdAgAsZs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxix3J+qJOTNXkefPhMlBRxn8/2DmJ7lvw+FaYoJ/a3mqYy9P9k
	TexRk1Ous5ds11yAlqEWZi0gM7xPG5Df5zZIREscrIy7yS0p5QQHJXccl2QTj6Fr
X-Gm-Gg: ASbGncvnf/yGDjRtEAcUQmVC5+Pr0XGuMtnBmjCYKf63BFlGsijgsihyBTcBXgCmYOQ
	E+j267Jx02nY/bwr+4ReqRSPhHA2S1imKLbw5RaN9Q1IcM9fouO08AUxCy6eKPm5+Yw3mAxWhwg
	l7/PHvrVOkzeLVWbj+i3llnKP/dUs6IcbBxeq9uCodi+20bmE6au/YiFgVB0M95rjijNIbGdSJT
	snSZDLcOZQyVfwUmOVZyc3K2FfQhPZo16/rncF5WrsyPMYzRYGsxlouzJFG+MOUnJzo3rOiLAtt
	/+fJy7HgslUJIWRR3tQrl8LAmffgQ9nAo4StUXtLwcV2yAdy3L9V4misB/x7AoGfG0XXqxRSfLv
	ZDUrRSJ8T/gMF+E6CeAzod8WOgAI/+hhB+VBdSqNpveRCp78gL07wwRzZtJZ/XZSRvJiKwKuRGC
	MogyqNyUa4HXMqkv4GnHHset/kVwpJcsnpgSw47sJpuxU++8e4ye2F/Vr7S+BmAPc=
X-Google-Smtp-Source: AGHT+IHazItPjrgUdDHUxk2nZ/20BqI5JS7hGJCNyz2SIzepwKHIdlKl1ttW+yVkhwgfQCQ3AWJeBA==
X-Received: by 2002:a05:6000:2309:b0:429:ca7f:8d65 with SMTP id ffacd0b85a97d-429ca7f904amr4950966f8f.37.1762180362120;
        Mon, 03 Nov 2025 06:32:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429cde45b96sm10468526f8f.32.2025.11.03.06.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:32:41 -0800 (PST)
Message-ID: <d0bee2f2-106c-42cf-8101-c76bb54ee1ba@gmail.com>
Date: Mon, 3 Nov 2025 14:32:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] blame: make diff algorithm configurable
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
 <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
 <920a6f3acbc86e72c6ea236f8dbd3d559398409a.1762034252.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <920a6f3acbc86e72c6ea236f8dbd3d559398409a.1762034252.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

Thanks for re-rolling, this is looking pretty sound, I've left a couple 
of fairly minor comments below.

On 01/11/2025 21:57, Antonin Delpeuch via GitGitGadget wrote:
> +static int blame_diff_algorithm_minimal(const struct option *option,
> +					const char *arg, int unset)
> +{
> +	int *opt = option->value;
> +
> +	BUG_ON_OPT_ARG(arg);
> +
> +	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
> +	if (!unset)
> +		*opt |= XDF_NEED_MINIMAL;
One thing I'd not thought about before was the interaction between 
"--no-minimal" and "--diff-algorithm" The code above makes 
"--no-minimal" behave like "diff-algorithm=myers" which is consistent 
with the current behavior where the only options for the diff algorithm 
are "minimal" or "myers". An alternative would be for "--no-minimal" to 
just clear XDF_NEED_MINIMAL and behave like a no-op if it is given after 
"--diff-algorithm=patience" or "--diff-algorithm=histogram". I don't 
really have a strong preference either way.

> +static int blame_diff_algorithm_callback(const struct option *option,
> +					 const char *arg, int unset)
> +{
> +	int *opt = option->value;
> +	long value = parse_algorithm_value(arg);
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (value < 0)
> +		return error(_("option diff-algorithm accepts \"myers\", "
> +			       "\"minimal\", \"patience\" and \"histogram\""));
> +
> +	*opt &= ~(XDF_NEED_MINIMAL | XDF_DIFF_ALGORITHM_MASK);

We can just use XDF_DIFF_ALGORITHM_MASK now that we've added 
XDF_NEED_MINMAL to it in the last commit.

> @@ -915,11 +960,16 @@ int cmd_blame(int argc,
>   		OPT_BIT('s', NULL, &output_option, N_("suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
>   		OPT_BIT('e', "show-email", &output_option, N_("show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
>   		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
> +		OPT_CALLBACK_F(0, "diff-algorithm", &xdl_opts, N_("<algorithm>"),
> +			       N_("choose a diff algorithm"),
> +			       PARSE_OPT_NONEG, blame_diff_algorithm_callback),
>   		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
>   		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
>   		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
>   		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
> -		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
> +		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
> +			       N_("spend extra cycles to find a better match"),
> +			       PARSE_OPT_NOARG, blame_diff_algorithm_minimal),

Given the potential for confusing interactions between "--no-minimal" 
and "--diff-algorithm" I think it would be worth adding OPT_HIDDEN here.

> diff --git a/t/t8015-blame-diff-algorithm.sh b/t/t8015-blame-diff-algorithm.sh
> new file mode 100755
> index 0000000000..5318e18cb3
> --- /dev/null
> +++ b/t/t8015-blame-diff-algorithm.sh
> @@ -0,0 +1,203 @@
> + [...]
> +	git blame file.c > output &&
> +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
> +	sed -e "s/ *$//g" without_varying_parts > actual &&

This would be more efficient if it was written as

	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
	    -e "s/ *$//g" output >actual

Our test suite is really slow on windows so it is worth trying to avoid 
creating unnecessary processes.

Thanks

Phillip

> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'blame honors --diff-algorithm option' '
> +	cat >expected <<-\EOF &&
> +	Commit_1 int g(size_t u)
> +	Commit_1 {
> +	Commit_1   while (u < 30)
> +	Commit_1   {
> +	Commit_1     u++;
> +	Commit_1   }
> +	Commit_1   return u;
> +	Commit_1 }
> +	Commit_2
> +	Commit_2 int h(int x, int y, int z)
> +	Commit_2 {
> +	Commit_2   if (z == 0)
> +	Commit_2   {
> +	Commit_2     return x;
> +	Commit_2   }
> +	Commit_2   return y;
> +	Commit_2 }
> +	EOF
> +
> +	git blame file.c --diff-algorithm histogram > output &&
> +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
> +	sed -e "s/ *$//g" without_varying_parts > actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'blame honors diff.algorithm config variable' '
> +	cat >expected <<-\EOF &&
> +	Commit_1 int g(size_t u)
> +	Commit_1 {
> +	Commit_1   while (u < 30)
> +	Commit_1   {
> +	Commit_1     u++;
> +	Commit_1   }
> +	Commit_1   return u;
> +	Commit_1 }
> +	Commit_2
> +	Commit_2 int h(int x, int y, int z)
> +	Commit_2 {
> +	Commit_2   if (z == 0)
> +	Commit_2   {
> +	Commit_2     return x;
> +	Commit_2   }
> +	Commit_2   return y;
> +	Commit_2 }
> +	EOF
> +
> +	git -c diff.algorithm=histogram blame file.c > output &&
> +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
> +	sed -e "s/ *$//g" without_varying_parts > actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'blame gives priority to --diff-algorithm over diff.algorithm' '
> +	cat >expected <<-\EOF &&
> +	Commit_1 int g(size_t u)
> +	Commit_1 {
> +	Commit_1   while (u < 30)
> +	Commit_1   {
> +	Commit_1     u++;
> +	Commit_1   }
> +	Commit_1   return u;
> +	Commit_1 }
> +	Commit_2
> +	Commit_2 int h(int x, int y, int z)
> +	Commit_2 {
> +	Commit_2   if (z == 0)
> +	Commit_2   {
> +	Commit_2     return x;
> +	Commit_2   }
> +	Commit_2   return y;
> +	Commit_2 }
> +	EOF
> +
> +	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram &&
> +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
> +	sed -e "s/ *$//g" without_varying_parts > actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'blame honors --minimal option' '
> +	cat >expected <<-\EOF &&
> +	Commit_1 x
> +	Commit_1 x
> +	Commit_1 x
> +	Commit_2 A
> +	Commit_2 B
> +	Commit_2 C
> +	Commit_2 D
> +	Commit_1 x
> +	Commit_2 E
> +	Commit_2 F
> +	Commit_2 G
> +	EOF
> +
> +	git blame file.txt --minimal > output &&
> +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'blame respects the order of diff options' '
> +	cat >expected <<-\EOF &&
> +	Commit_1 x
> +	Commit_1 x
> +	Commit_1 x
> +	Commit_2 A
> +	Commit_2 B
> +	Commit_2 C
> +	Commit_2 D
> +	Commit_2 x
> +	Commit_2 E
> +	Commit_2 F
> +	Commit_2 G
> +	EOF
> +
> +	git blame file.txt --minimal --diff-algorithm myers > output &&
> +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
> +	test_cmp expected actual
> +'
> +
> +test_done

