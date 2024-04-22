Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F01534E7
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800646; cv=none; b=WCoodNbsx3NvFcnKZXPhWu37yS2Q5Znai3Y2FrZkOFQ4FhYwHHbhJSMOZseG/jdF9RJo5rCebE/AM4OzJXc4cGdn+AWWBP4qnIEfb8wS0v9G8/GrVDv7YFpKTQ0z3PayhC8vmC2CkPD7XYgS76ERdCl2X8qFNGibq5jk9iqmNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800646; c=relaxed/simple;
	bh=dWXnhJMpqORo8tBpCzL7CSo+ga2/WwYEajKVNYkLNgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s8q1knZhW6EYySnFJraOjsIzHN2ChTaeh9dONbaTKBtGV0ua7dC7twOye01f+iA9qqXM3wpIinA5attoS+773418TN/KDxH0Fbwg/zHo+Z22y5ivWSWB4H34hpdTRbo1dNxZQF7DNtRbtFcirJkHsGlf1Vbs06ZWCPylprYVgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkHJaSVN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkHJaSVN"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-346359c8785so3908586f8f.0
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800643; x=1714405443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9fbAXLbJo3R727S5Er55HPnxCKNlFEkNKlXCe1vHabI=;
        b=QkHJaSVNGYQcLVKqCNK4824KAlUkFaLqfdZlLzxzc9H/DXxIc+AvyxSm/lPExH3j3b
         O6kBk/gjyJTay10MbzpUsP3pJTq3UPMXI3DMKbUKUxJLOMcqyswJk/pZySFtndp2JQXZ
         IVgjsaSwrEAw1fQUICfYf/fTM/vu5ogeo5kOQyqw4ZqDHrXsEdLMKA0g844Q/DLrrLt7
         eJupQfudgSZou1H0SpT5cU7jw5ICTTWWd3WvwT5uGrfO7/UI+Oc/PuWPOdwJzhaD/k1A
         sg1iTZdhvDupZeNOrUVSlS1pcTO6IvMJ8YLLnqvn2F6I7iVLHo5UT7CJJBlohdL9koWW
         TClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800643; x=1714405443;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fbAXLbJo3R727S5Er55HPnxCKNlFEkNKlXCe1vHabI=;
        b=kgdB/6AXapyvJS6F26TWI7BUPMjjlH499UX8CQEPt2bCozjuEkLhKGWB2OEEcEcEp6
         AGBGwewYMeovlE+CevMY3+H53yn2K0htSOqEFG8WFiyqDGgLK+yxfuPD0ynQcplBkRmV
         OVv4Jo9a2YboSptiL3OOXv+YPxvuctz2zvLLkqpwYQeCxAJfqG8GotEzvujiVawTcs1k
         GdqY1ZteeRXGyMgIDG1CVr/phF+lX+ZAGDL3ekNMfjzPsyP+jqZmbPv3i9LI3ZI5NMiY
         gLcFEMr9U9PVmkE3bzzPeaR4bmxsPCt81An+hS1WW04F1jjYqekch9wM3a/8LK9TaGiv
         K/4w==
X-Forwarded-Encrypted: i=1; AJvYcCXEWt8lglZtR3SroJca/C+COWGtKE0p778RZrxyq2LUKrGHNv8ZDiQ5AlogpdQBIwLptTQ79XRucU1Wi2gBCh9vgsyQ
X-Gm-Message-State: AOJu0Yw9clyA1q/xi8MGBk4Ro0PNMfMg6x6RamCgHDO9CrCHJxsqLCMW
	TJRcUQWoIVqFeErnTUDX1K24vdcdReZUyJne+9WaLrwjTe6yR6lc
X-Google-Smtp-Source: AGHT+IEn3Eu/cKyjAlbwpn6aJpvIOC97S+XTX3PAhdva+XfcF6TfuDT1DFHHlIKWJE5Yir/HY4ERHA==
X-Received: by 2002:a5d:590f:0:b0:34b:3374:bc26 with SMTP id v15-20020a5d590f000000b0034b3374bc26mr1245036wrd.65.1713800642363;
        Mon, 22 Apr 2024 08:44:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b00343826878e8sm12367136wrq.38.2024.04.22.08.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 08:44:02 -0700 (PDT)
Message-ID: <55f1da17-6f07-4b25-9cf2-0de69bfb5005@gmail.com>
Date: Mon, 22 Apr 2024 16:43:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] add: plug a leak on interactive_add
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
 <a886c086-4b2e-4d41-ad40-b3fca20de42a@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <a886c086-4b2e-4d41-ad40-b3fca20de42a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 21/04/2024 11:29, Rubén Justo wrote:
> Plug a leak we have since 5a76aff1a6 (add: convert to use
> parse_pathspec, 2013-07-14).
> 
> This leak can be triggered with:
>      $ git add -p anything
> 
> Fixing this leak allows us to mark as leak-free the following tests:
> 
>      + t3701-add-interactive.sh
>      + t7514-commit-patch.sh
> 
> Mark them with "TEST_PASSES_SANITIZE_LEAK=true" to notice and fix
> promply any new leak that may be introduced and triggered by them in the
> future.

This makes me wonder if we're freeing the pathspec properly when using 
'--patch' in checkout, reset, restore and stash.

Best Wishes

Phillip

> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>   builtin/add.c              | 9 ++++++---
>   t/t3701-add-interactive.sh | 1 +
>   t/t7514-commit-patch.sh    | 2 ++
>   3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index ae723bc85e..b7d3ff1e28 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -150,7 +150,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
>   int interactive_add(const char **argv, const char *prefix, int patch)
>   {
>   	struct pathspec pathspec;
> -	int unused;
> +	int unused, ret;
>   
>   	if (!git_config_get_bool("add.interactive.usebuiltin", &unused))
>   		warning(_("the add.interactive.useBuiltin setting has been removed!\n"
> @@ -163,9 +163,12 @@ int interactive_add(const char **argv, const char *prefix, int patch)
>   		       prefix, argv);
>   
>   	if (patch)
> -		return !!run_add_p(the_repository, ADD_P_ADD, NULL, &pathspec);
> +		ret = !!run_add_p(the_repository, ADD_P_ADD, NULL, &pathspec);
>   	else
> -		return !!run_add_i(the_repository, &pathspec);
> +		ret = !!run_add_i(the_repository, &pathspec);
> +
> +	clear_pathspec(&pathspec);
> +	return ret;
>   }
>   
>   static int edit_patch(int argc, const char **argv, const char *prefix)
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index bc55255b0a..04d8333373 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -4,6 +4,7 @@ test_description='add -i basic tests'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY"/lib-terminal.sh
>   
> diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
> index b4de10a5dd..03ba0c0e73 100755
> --- a/t/t7514-commit-patch.sh
> +++ b/t/t7514-commit-patch.sh
> @@ -1,6 +1,8 @@
>   #!/bin/sh
>   
>   test_description='hunk edit with "commit -p -m"'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup (initial)' '
