Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374511DA10D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456927; cv=none; b=Qma82SnZmBnaVVABTckNJAodQquR8Jq2aMvPRH2fJV7CGEP0c9MZR0KV47FXQauW6xqlKrsisvn4WHZOQIvhPpKepYHopWHYXgZ5seOE8KZx8YNgy0dA2yeRkB32FXjtyUUbPMF0agwe77xTVNOAOJHKUxMb8zmNqIRBff73MZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456927; c=relaxed/simple;
	bh=PptNEq9DPUPA00se/38nr/TIRLtQa4yqDaLeuufdR94=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CSTONsjbGTBjqhkJzGZJxJF+6N3sqdeRzhec4MgFvh1DLu1qtUXCG85fDDcRqclIfvngeboZZsmO9n7TmdR02Z60QQpsxkkWRR0g3+WUUuuVReFseWVHF3QDSCmMrCpa9L+tGCZhrgGsJ739SWrjI+q7g0EEiueB8KrW7KOivQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/3stRHF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/3stRHF"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86859e2fc0so747995466b.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725456923; x=1726061723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8SboGucwtrAD1rb6XnrWnSrr2JzxJvcbZxScueJNE8k=;
        b=b/3stRHFf+OLK2c38Wa5ZwI0BwJr3fMcZYJApRmq5XmGv/qD1gA+ZUYhsM0yhscvyT
         St9jZmkK18WRjconFyBt+Mq25HfEKwdOdG+SM2JlX38OQ/zmBZTq7NUGBSZhxalcSjQZ
         91VGPQnCc/18tYNLh2gBW0ozEkS9Uhq+xTSgye3m1uQTSxScZXE7yKxhdPOrl4Nsn+HW
         z4eI7PfyFVCgB0KQDki3oFuqqDMVw7tHfI4IHCJtQs4u59GXJk6CLIfKvEXxLtFzeuj8
         cT1wR9ocBLwE/hqeCb7/bjTS0F0wQEDEAdMskHfWoud2R1alJSeac9nYsQYTy/OvHspd
         kD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456923; x=1726061723;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SboGucwtrAD1rb6XnrWnSrr2JzxJvcbZxScueJNE8k=;
        b=eK/5p2mk+PuTgB3VIFeL2b1rUgookv0gptEFPDw0vehofJ5sM0Nqrc6PBgCn+bdaIq
         sMZqhY0AgBkKKHhDVqESRMtm3ppiP/zZ7W1LwuvkibeUiBVObYX/29jzPL7jus3nkpmG
         IV3V4CqlkPymi9JeVUaGMW5D3ZMzWvwdLEdezgvTraR1z1daRt6suQkBa/V6IKWzBFME
         kxlD+1WkNBo+BRSe35SGJQ3PXuB7EOFsH2AXbLfv0PliORiRnLfSywcVHIu49saB0UV3
         mBgwrzMVdB+J6BNoZ/qrWHGfyC5DkH5ndIrOotyRMLdvM/A4JNNk6Pw8+UEJbvqOew0d
         YnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5oedYUHPYFqN1wDI4xK5/tSdNR8z+sb8/1sGY5JB8v3Y/NMISJ4F1IDAlxbK4xyy+ALo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkTqO88D1RQ/xGWx94EV7fHUUTHQvdffh6uASahoOH0uu9P3vI
	hBvDHJTXbVIhT1GjHkuLqfpNV2llbBr9NsUCx1bZWCQNwKfexF2K
X-Google-Smtp-Source: AGHT+IEY2o4FH5ufwFBt1S3Ef24ImPZPJlqdN+lSZZcuf/m4nZ6rOXQMzFw30bNtyU4zU/4XIqN3ng==
X-Received: by 2002:a17:907:e8a:b0:a8a:195a:e725 with SMTP id a640c23a62f3a-a8a32ed935bmr333526666b.36.1725456922574;
        Wed, 04 Sep 2024 06:35:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892333a0sm803554766b.220.2024.09.04.06.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:35:22 -0700 (PDT)
Message-ID: <e435e05a-376c-4928-9852-6925df855399@gmail.com>
Date: Wed, 4 Sep 2024 14:35:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 11/14] t/unit-tests: implement test driver
Reply-To: phillip.wood@dunelm.org.uk
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1725349234.git.ps@pks.im>
 <8bd5b3e2b2989a30b597da2103eb8d9699cf3d7f.1725349234.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <8bd5b3e2b2989a30b597da2103eb8d9699cf3d7f.1725349234.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 03/09/2024 10:15, Patrick Steinhardt wrote:
> The test driver in "unit-test.c" is responsible for setting up our unit
> tests and eventually running them. As such, it is also responsible for
> parsing the command line arguments.
> 
> The clar unit testing framework provides function `clar_test()` that
> parses command line arguments and then executes the tests for us. In
> theory that would already be sufficient. We have the special requirement
> to always generate TAP-formatted output though, so we'd have to always
> pass the "-t" argument to clar. Furthermore, some of the options exposed
> by clar are ineffective when "-t" is used, but they would still be shown
> when the user passes the "-h" parameter to have the clar show its usage.
> 
> Implement our own option handling instead of using the one provided by
> clar, which gives us greater flexibility in how exactly we set things
> up.

That makes sense

> We would ideally not use any "normal" code of ours for this such that
> the unit testing framework doesn't depend on it working correctly. But
> it is somewhat dubious whether we really want to reimplement all of the
> option parsing. So for now, let's be pragmatic and reuse it until we
> find a good reason in the future why we'd really want to avoid it.

I think that's fine for now. Using parse_options() gives a much nicer 
user experience than clar_test() as it supports long options and has 
more flexible support for option arguments. I'd expect the code that 
implements "struct string_list" and "struct strvec" to be pretty stable 
so its probably safe to rely on those.

Given there's only a couple of options it wouldn't be too bad to 
implement the parsing ourselves if we have to in the future. We might 
need to do that to support the libification work as I suspect we wont 
want to link tests for other libraries against libgit.a.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   t/unit-tests/unit-test.c | 43 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> index 3d12cde6dae..96fa64de71d 100644
> --- a/t/unit-tests/unit-test.c
> +++ b/t/unit-tests/unit-test.c
> @@ -1,6 +1,45 @@
>   #include "unit-test.h"
> +#include "parse-options.h"
> +#include "string-list.h"
> +#include "strvec.h"
>   
> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +static const char * const unit_test_usage[] = {
> +	N_("unit-test [<options>]"),
> +	NULL,
> +};
> +
> +int cmd_main(int argc, const char **argv)
>   {
> -	return 0;
> +	struct string_list run_args = STRING_LIST_INIT_NODUP;
> +	struct string_list exclude_args = STRING_LIST_INIT_NODUP;
> +	int immediate = 0;
> +	struct option options[] = {
> +		OPT_BOOL('i', "--immediate", &immediate,
> +			 N_("immediately exit upon the first failed test")),

This is unused. If we want to to behave like the "--immediate" option of 
our integration tests that's  hard to implement by wrapping clar_test() 
which requires "-i<suite>". The simplest thing would be to just drop it 
for now. Otherwise as the most likely use for "-i" is manually testing 
some tests in a suite we could require "--run" with "-i". Then we would 
have one or more suite names which we can append to "-i" when passing it 
to clar_test(). Alternatively we could include "clar.suite" and wade 
through all the test suite names ourselves to construct a suitable list 
of "-i" options to pass to clar_test() but that would probably mean we 
have to parse the excludes as well which makes it all a bit of a faff.

> +		OPT_STRING_LIST('r', "run", &run_args, N_("name"),
> +				N_("run only test suite or individual test <name>")),

It's nice that this option name now matches our integration tests. It 
would be helpful to show the syntax for "name" (I think it expects 
<suite>[::<test>]) but I failed to come up with a concise description to 
add to the help here.

Best Wishes

Phillip

> +		OPT_STRING_LIST('x', "exclude", &exclude_args, N_("name"),
> +				N_("exclude test suite <name>")),
> +		OPT_END(),
> +	};
> +	struct strvec args = STRVEC_INIT;
> +	int ret;
> +
> +	argc = parse_options(argc, argv, NULL, options,
> +			     unit_test_usage, PARSE_OPT_KEEP_ARGV0);
> +	if (argc > 1)
> +		usagef(_("extra command line parameter '%s'"), argv[0]);
> +
> +	strvec_push(&args, argv[0]);
> +	strvec_push(&args, "-t");
> +	for (size_t i = 0; i < run_args.nr; i++)
> +		strvec_pushf(&args, "-s%s", run_args.items[i].string);
> +	for (size_t i = 0; i < exclude_args.nr; i++)
> +		strvec_pushf(&args, "-x%s", exclude_args.items[i].string);
> +
> +	ret = clar_test(args.nr, (char **) args.v);
> +
> +	string_list_clear(&run_args, 0);
> +	strvec_clear(&args);
> +	return ret;
>   }
