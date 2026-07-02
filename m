Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC6348896
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014595; cv=none; b=uirbGjt+FM/hH0eZes8b63ZwLLi433J29dlOW1MCoJm2Y7tBkzaRkNvgb12gpqhJlPER2a1UCcwiKXygfi2KGjuMgeyv8a6MhUY/DPmuFpZrHNEID6xRJBPAoCL9i+T8ZxPDGtiTaoIOlD318Wj//iOctqMxMFBVHlOaT4oslJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014595; c=relaxed/simple;
	bh=6qhITYIzKs4gR0zNmlesphqAMG7g9LtVdICwH5IIjJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxLUpEFzFc/V8vLaPfZHBbtdzuIu61fAqMQtdfzMW6/nIeKZ8lxfW0BlnHfUfpmJDMxnzconzaGKfnmUwEv1O67yUR3IsQB9uCgVlD6E9QMOTBYQljtnktupWgBQK6WhYeXjSz7AN4lwWgPu/K1djWaentIO8+momWzH5HUttpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlC0OknW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlC0OknW"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47488efcf30so1304282f8f.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783014593; x=1783619393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5AJqp1W/b63o2+EP6+OtNR5X7lfstqN7t0eECTabck=;
        b=qlC0OknWKAFme3AbovGETWP8YNjXuqZIwUtCpz5O2JpR/F/u4YPiqlLYcGEvDsd4tq
         vcsY2rrjrqICyF7rwHCXwpqG/yf1ksqjexTqDEbY1DcdLKtgFIy/3IaBtShmObXpe6fj
         Yfshk4rwOl5i0Ds1+iee9+gL8lcPiJEW503m4uPnz/JGKRbH1q+R4dkx3W/Eahpu0GT+
         OOHzdlvDHLhh4fWoWj5v+rfRXdSMMmSHhXyVq773JKcTqAqb4FzquAGvflflm/YG43kE
         67i4/Ymd3Y5Mwii/5EvmLeSjXaC7N9xi0XOXqs5pDg2/i7v95jJO5vDKDyFK2SlH795F
         N8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783014593; x=1783619393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5AJqp1W/b63o2+EP6+OtNR5X7lfstqN7t0eECTabck=;
        b=pytfMz6jJ9oQE1XTrunqeifRbEijrFjLYqg9HXzyrVryhwY1cEVolaSF+DSr3JzYP2
         ytmX+Y023LCLtGr4LZO8fWjdzT9dBh7K19T5eel+i8p4ENI1DyBb/WFLp64Aqkp6hQD3
         AZbFsZU2eSLpqwjELY9jXqYhBKd0JQGRW+tp4Ir2UNt6aiQAocPJkozIhBE15iGOoP3Z
         YQqiJlR10WlzwzlNDmmav9CKglkqAiVP/rc5bJJ4E/WyQ37T7kiPmwSGWNw1XaTGDiTq
         KbF3rvwzh2rw1RK5eXFIXNQL/DoZgHRLezvYOuYOHMzfuUXA/5Z0sWhN8kCool1VOWQg
         V2pA==
X-Gm-Message-State: AOJu0Yww6wf9cr+AtcRDXtR+0L4JS4z207pdRORswUqjRD+T2o3i7Z+T
	bxPkt8eZqM74RlL/5c8ZToWYECSi2hugBr+LFB8zsvwDm8WhKh26thK0
X-Gm-Gg: AfdE7clmtoksMfNvXenTg+JUNvunpjXHS0Bc+OVM4qQJ7Sg6W6itR9HRLHpsnL30WXJ
	634AopaZUucCx2rcomdlKGJsG1N2VSrhwvPZqLBMB99eiXbzgqvx6P92c+uOk8DarsZp+5sNuHX
	ab6E+zyYxzZ4UVPpDvXaQGLXiy1kQnE2KxUB7yDZDl8qnF+nRAZogvaDaRzSkjSBbWciojAf8zR
	VmXimH5fbbHF+btXQFdH1aMe0LTjFRTpuutGqMzrHg+iYZHG6ioRh/WahFIb3zeu7IwQsqh7YDt
	B/ScN1xMyIDFYWUh7Na41wxXQoNkz944q6HIMxGQkbIbaq+7fGFx48KF5kElYkdA0YHsd5WDlHK
	yWefs5+rM++eFlQ9XrRIaLvkKgCZxsgy/ahrthujc9OfpkFUvRfwLow2LllDzmOU9vWJuRQouO2
	GyWSNSiAFQ/F+qphxAL5ETscZVHKcGoairUmaqWqp7h6SF2sSboR76VYG3R8QqF/7zj7x9B68MY
	g==
X-Received: by 2002:a5d:5d82:0:b0:475:f0f0:9ef8 with SMTP id ffacd0b85a97d-4775b930513mr11259486f8f.61.1783014592409;
        Thu, 02 Jul 2026 10:49:52 -0700 (PDT)
Received: from localhost (20014C4D24D2EF00922CFDE3AC17C2E9.dsl.pool.telekom.hu. [2001:4c4d:24d2:ef00:922c:fde3:ac17:c2e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd53fsm10713207f8f.37.2026.07.02.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:49:51 -0700 (PDT)
Date: Thu, 2 Jul 2026 19:49:50 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/9] t4141: fix inefficient use of dd(1)
Message-ID: <akakvnoAswZx+DNI@szeder.dev>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-3-76b4d7bab3d0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-3-76b4d7bab3d0@pks.im>

On Thu, Jul 02, 2026 at 02:00:56PM +0200, Patrick Steinhardt wrote:
> In t4141 we generate a patch that is roughly 1GB in size to verify that
> git-apply(1) indeed rejects that patch. We generate that patch by
> prepending a patch header and then executing `test-tool genzeros`
> without a limit. This causes us to print infinitely many zeros, and we
> limit the overall amount of generated bytes via `test_copy_bytes`.
> 
> This test setup is extremely expensive, as `test_copy_bytes` is
> implemented via `dd ibs=1 count="$1"`, which copies data one byte at a
> time. So as we write 1GB of data, we end up doing 1 billion reads and
> writes. This naturally takes a while: it takes 6 minutes on my system,
> and around 40 minutes in some CI jobs!
> 
> We can do much better though, as genzeros already knows to handle an
> optional limit of how much data it is supposed to write, which allows us
> to remove the call to `test_copy_bytes`. Furthermore, it has already
> been optimized to generate the data fast.
> 
> And indeed, doing this conversion drops the test execution to less than
> a second on my machine, so that we can drop the EXPENSIVE prerequisite.

EXPENSIVE is not only about execution time, but about resources in
general.  While the modified test finishes quite fast indeed, 'git
apply' uses over 1GB of RSS.  Therefore, the EXPENSIVE prerequisite
should be kept.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t4141-apply-too-large.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
> index eac6f7e151..dad67779ed 100755
> --- a/t/t4141-apply-too-large.sh
> +++ b/t/t4141-apply-too-large.sh
> @@ -4,8 +4,7 @@ test_description='git apply with too-large patch'
>  
>  . ./test-lib.sh
>  
> -test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
> -	sz=$((1024 * 1024 * 1023)) &&
> +test_expect_success 'git apply rejects patches that are too large' '
>  	{
>  		cat <<-\EOF &&
>  		diff --git a/file b/file
> @@ -14,8 +13,8 @@ test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
>  		+++ b/file
>  		@@ -0,0 +1 @@
>  		EOF
> -		test-tool genzeros
> -	} | test_copy_bytes $sz | test_must_fail git apply 2>err &&
> +		test-tool genzeros $((1024 * 1024 * 1023))
> +	} | test_must_fail git apply 2>err &&
>  	grep "patch too large" err
>  '
>  
> 
> -- 
> 2.55.0.795.g602f6c329a.dirty
> 
