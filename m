Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05727056F
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155395; cv=none; b=acYzqbMhjMQPlv7bG6gUq/M83opJCugctSz9ayvxyCn/RM2fLCU0LYSgi5v/TpDDrHRXSDnVwiQYamDcpLhvp/mWLswnZlKFFfuYha6ZPbbHoRU0Up8Z0zYwu+9fUHdXIhHKJTx8uQTQkaizVucFP9xZftEj6hOFYucIllrSvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155395; c=relaxed/simple;
	bh=g3eTIzRkWMa63zHXC+TE8FT32UGdi72MlLy4MAShwLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi0cVunXsvylpEBwiUmIaT+mALpWVXEeonTa2aljTsdZmEuyLuz/O+xnnQghP/MxrlFZ0wVSDiO5zTTJjdmOHhogmOoMG1NtQnJXH1kX3lappSx4+lQF3S2Vq+hKo4fyiRs6QR5gZwemqSse6407eVloumaRTUDpgnRYgUGaEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9q2tS2D; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9q2tS2D"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-712be7e034cso10036807b3.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752155392; x=1752760192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BFMaZgBv8F+CyhnEECpmK9UTJSFV/jP6MRngQjAlgQ=;
        b=I9q2tS2DsRhrpnaU5CA+6FbhqdUUAtq0UxBVEURYxh4aATwZclYrsRr7vG90OAiVEU
         e1tCzJy89Se2H2hodzRlCqLKBgvIqFg1/jHQMKFce/Y724oy5VqSHA+PtteEumOhr6gC
         wgVhr7oU3mki2d+1lgKmCHhoihV68zoqkCN3LehZmeGXvQH7VwauHlGeoupYm03XbRiJ
         am2g8lr8IgYMeDkT4uV6qg2KdwYWU+2cct8zL1/FPfMQCl5y6dwuzOdgyXg41MwSG5hT
         cpf54V+nrsWM1bfHShI23NsdcOtIjjrk2GOk/YS2APKPaGuycAEcOK4TTQQRQY1PzbL2
         Dclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752155392; x=1752760192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BFMaZgBv8F+CyhnEECpmK9UTJSFV/jP6MRngQjAlgQ=;
        b=TiINCniOsJLn03Ek8P31YOSKBc92cgua8lBy3wcbxvXmssA/X++oDR80guWpS8pJcU
         T+5hk47nTzJl2sOHF3xDZA/2/qDIah1yGXW6OwVuVytBsjQTCDr2MTDuikdQCBB3wIG5
         LPqm96SAJeWqsoCstY3jua1m51/gNKpfvNu98oVr+MECZixpDTGOigxcmwIcZvixGWIe
         wYK+I6NGu98Jx6Dx3R9YbwXPZjF8YGkajrFyRwqvSz9veT1Po2JNqT4OlcOi+8f4Ki00
         r18UkdLHLFpGoDTUujK8mga0yEau8kNuoTRpvCsnlvddrhuW889fCy8twGjq1fi9hHj4
         pVHg==
X-Forwarded-Encrypted: i=1; AJvYcCW0jOpIcJtRMRwhxO4srDyzRBkT25A7MIwm7dnGlsHcVRrKREWB5iS1+XVkYeQ+K12EGNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6E19YMlTME56HwpzYZlzEZj/k0r0RHN7UexXhKDCt0pXidRUz
	3qkadJKJkg/soav3jUpqdMnPw0Ygb2xCO/tekHkhjlT+1wZDwwWah4BI
X-Gm-Gg: ASbGncsSPCFyogci7NjcrRftWAZTLfjwIpZcW61VdUOGAEgSjDCZEaFDzH3ChZZaJIL
	OaKZHrIIa4xijlNDOLk92XtEO9yY+MlK19fcMrVRY82ORVMolBw4QB/HsZiYQo0f8HFcugvDDZ4
	wqO1JlAE4EmcaCk9iV6BmNMbPuPCzBkUyPcqpid8tDm910lV0kOz81BYjFXCH8/plpdwKfKWjX2
	ccocfRAHEOga5RmNG1z5/ryioStYAvWVuO/g87fVVkZMGvuxNJfDbQnkoYW0V4kN79grY4l+p3C
	9eroKDR9qDyya4hVcVlgHcvOnXi3I3fYjubKUnyoyMepk7rYnlIwIelODYyVzYFuLyqYORuQk3c
	CLe6OZFPyp3vIDr5Zu49VE5BvChtcf1kfbqQhjw==
X-Google-Smtp-Source: AGHT+IHa0UCWQWHiZ6BHka6Nxqk1qgZ0w1rjO+yI7UEpaGoxh/pD78F+eY5SxtT1d0Bh/zuvL64wRw==
X-Received: by 2002:a05:690c:6602:b0:70e:6333:64ac with SMTP id 00721157ae682-717c4656a02mr37155517b3.10.1752155391886;
        Thu, 10 Jul 2025 06:49:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c538:4e9c:cfeb:f6ff? ([2600:1700:60ba:9810:c538:4e9c:cfeb:f6ff])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61b4cc4sm2855197b3.67.2025.07.10.06.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 06:49:51 -0700 (PDT)
Message-ID: <afb68948-218b-4b56-9faa-29578ef9c73c@gmail.com>
Date: Thu, 10 Jul 2025 09:49:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] bloom: enable bloom filter optimization for
 multiple pathspec elements in revision traversal
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: 502024330056@smail.nju.edu.cn, git@vger.kernel.org, gitster@pobox.com,
 toon@iotcl.com
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/10/2025 4:48 AM, Lidong Yan wrote:

> The difference from v4 is:
>   - for the bloom_key_* functions, we now pass struct bloom_key *
>     as the first parameter.
>   - bloom_keyvec_fill_key() and bloom_keyvec_new() have been merged
>     into a single function, so that each key is filled during the
>     creation of the bloom_keyvec.
> 
> Below is a comparison of the time taken to run git log on Git and
> LLVM repositories before and after applying this patch.
> 
> Setup commit-graph:
>   $ cd ~/src/git && git commit-graph write --split --reachable --changed-paths
>   $ cd ~/src/llvm && git commit-graph write --split --reachable --changed-paths
> 
> Run git log on Git repository
>   $ cd ~/src/git
>   $ hash -p /usr/bin/git git # my system git binary is 2.43.0
>   $ time git log -100 -- commit.c commit-graph.c >/dev/null
>   real	0m0.055s
>   user	0m0.040s
>   sys	  0m0.015s
>   $ hash -p ~/bin/git/bin/git git
>   $ time git log -100 -- commit.c commit-graph.c >/dev/null
>   real	0m0.039s
>   user	0m0.020s
>   sys	  0m0.020s
> 
> Run git log in LLVM repository
>   $ cd ~/src/llvm
>   $ hash -p /usr/bin/git git # my system git binary is 2.43.0
>   $ time git log -100 -- llvm/lib/Support/CommandLine.cpp llvm/lib/Support/CommandLine.h >/dev/null
>   real	0m2.365s
>   user	0m2.252s
>   sys	  0m0.113s
>   $ hash -p ~/bin/git/bin/git git
>   $ time git log -100 -- llvm/lib/Support/CommandLine.cpp llvm/lib/Support/CommandLine.h >/dev/null
>   real	0m0.240s
>   user	0m0.158s
>   sys	  0m0.064s

Thanks for these stats, though I'd recommend trying hyperfine [1]
which with this setup would let you run these experiments as the
following:

$ $ hyperfine --warmup=3 \
> -n 'old' '~/_git/git-sparse-checkout-clean/git log -100 -- commit.c commit-graph.c' \
> -n 'new' '~/_git/git/git log -100 -- commit.c commit-graph.c'
Benchmark 1: old
  Time (mean ± σ):      73.1 ms ±   2.9 ms    [User: 48.8 ms, System: 23.9 ms]
  Range (min … max):    69.9 ms …  84.5 ms    42 runs
 
Benchmark 2: new
  Time (mean ± σ):      55.1 ms ±   2.9 ms    [User: 30.5 ms, System: 24.4 ms]
  Range (min … max):    51.1 ms …  61.2 ms    52 runs
 
Summary
  'new' ran
    1.33 ± 0.09 times faster than 'old'

And for LLVM:

$ hyperfine --warmup=3 \
> -n 'old' '~/_git/git-sparse-checkout-clean/git log -100 -- llvm/lib/Support/CommandLine.cpp llvm/lib/Support/CommandLine.h' \
> -n 'new' '~/_git/git/git log -100 -- llvm/lib/Support/CommandLine.cpp llvm/lib/Support/CommandLine.h'

Benchmark 1: old
  Time (mean ± σ):      1.974 s ±  0.006 s    [User: 1.877 s, System: 0.097 s]
  Range (min … max):    1.960 s …  1.983 s    10 runs
 
Benchmark 2: new
  Time (mean ± σ):     262.9 ms ±   2.4 ms    [User: 214.2 ms, System: 48.4 ms]
  Range (min … max):   257.7 ms … 266.2 ms    11 runs
 
Summary
  'new' ran
    7.51 ± 0.07 times faster than 'old'

[1] https://github.com/sharkdp/hyperfine

Finally, putting these performance numbers in the commit message will
make the results permanently findable in the repo history.

> 3:  c042907b92 ! 3:  60a3b16bbb bloom: replace struct bloom_key * with struct bloom_keyvec

>     -+struct bloom_keyvec *bloom_keyvec_new(size_t count)
>     ++struct bloom_keyvec *bloom_keyvec_new(const char *path, size_t len,
>     ++				      const struct bloom_filter_settings *settings)
>      +{
>      +	struct bloom_keyvec *vec;
>     -+	size_t sz = sizeof(struct bloom_keyvec);
>     -+	sz += count * sizeof(struct bloom_key);
>     ++	const char *p;
>     ++	size_t sz;
>     ++	size_t nr = 1;
>     ++
>     ++	p = path;
>     ++	while (*p) {
>     ++		/*
>     ++		 * At this point, the path is normalized to use Unix-style
>     ++		 * path separators. This is required due to how the
>     ++		 * changed-path Bloom filters store the paths.
>     ++		 */
>     ++		if (*p == '/')
>     ++			nr++;
>     ++		p++;
>     ++	}
>     ++
>     ++	sz = sizeof(struct bloom_keyvec);
>     ++	sz += nr * sizeof(struct bloom_key);
>      +	vec = (struct bloom_keyvec *)xcalloc(1, sz);
>     -+	vec->count = count;
>     ++	if (!vec)
>     ++		return NULL;
>     ++	vec->count = nr;
>     ++
>     ++	bloom_key_fill(&vec->key[0], path, len, settings);
>     ++	nr = 1;
>     ++	p = path + len - 1;
>     ++	while (p > path) {
>     ++		if (*p == '/') {
>     ++			bloom_key_fill(&vec->key[nr++], path, p - path, settings);
>     ++		}
>     ++		p--;
>     ++	}
>     ++	assert(nr == vec->count);
>      +	return vec;
>      +}

These additions to bloom_keyvec_new() certainly help simplify some
of the code movement I was talking about, but there is more that
can be done to simplify patch 4. I'll send a couple example patches
in reply to patch 4 with what I mean.

Overall, the patch series is correct. My complaints are stylistic
more than anything.

Thanks,
-Stolee

