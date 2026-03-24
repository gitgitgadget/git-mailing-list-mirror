Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853F35A939
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349380; cv=none; b=pIul7Y8FstR9dufvlaOSroKaTaazMyi5xGM6yTcBiF8FF+3Lpeb6p66ZKUErddsZ9tWKug51uW/RfLGvFYEc9SR+9sFXqdyBYRgfc1npWBtMliKiMLIDL7QQsKxtxqvPFa0JYQ54OZ5Mg/El2ehh9A2dF6NxSyt1Pv5sghoxW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349380; c=relaxed/simple;
	bh=NeyyCk1ZxeCrFdd2+7zHST9Hd/BdYqIkUwpNKyp/2Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNLoQ8AALoyVAYRwlvn1F1xE+tSz/iU7NfMonLCo52lSOgPtETYk8HhPT1O5dJyRRwHDkFYBc8kEczbWEQ6CY70laVuP+06D/nmEWowsVKlkuGKAPch0dsyOKxk1RvWSQd0fLhYFzSij4us8V03+NoA+poBR773FAt5tp6u924s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUkU2rLF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUkU2rLF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b6d9c981so3504696f8f.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774349377; x=1774954177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wtbn9c0pBwCceO+GEQ826wzOyd4/fr6KIB9Sj8HVYxg=;
        b=mUkU2rLFrS1n6br9a8j7ltDxajiLqyk+FTdl6KpZeGGrIJtDPOKhsHelHjmGSggkM8
         ZD/BepzpSm7JlZbWJqsW9M/+bbAxhLg0PMn5pDY4C5Hsn9R6bt/gurZBUNK3CXgATAIk
         63U0rbjP/IlKDzyiROmOw5fJWVB03kgiEOD3Zp3H6Pbl6sBfmj/moSL+nj5EJvpxNg7S
         YHxF7YcvHk5vmkvjbYGvLIDQuAhpPrbEb26e3BP/HQ921xWgfoCi19QkxbNpntbHCzm/
         p25LSaKJsYR7/531S2NBqx5DN35mHzrqT3rbbtFpxqBoGIizgBUOU18Nwo0XvquBDZjJ
         YSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774349377; x=1774954177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wtbn9c0pBwCceO+GEQ826wzOyd4/fr6KIB9Sj8HVYxg=;
        b=WAEi3WMKJMk0Hy4amLV4msLhhGh0iEdKVHifB8qdRUOusRbygA0ihyefByAc3t6Jhf
         eaq70HsLS/UmQXNSla3zs4Z92PtdBe0ROafI1bnv80iAe11iVH+kAr+G54Xx+nC01d2Q
         bE+5eaq9bT58Cv9ylQN2VhAUi6k3WvSRLy7/s6zwiZvKswOBxqgaajzkAX0SEWaB9x3g
         ujuL703UsYSkqJ04KlZRRfyEeRVl6XCjKAadnFMterycHW/8qCpv9fI2W52jOjd3OlCA
         RikoN6tycBtjYZY/2/PqFBB4HivWvqWHUIR7vMfJZ4sHOctyiEbHAjl2eyMbsgdpT/pb
         eURw==
X-Forwarded-Encrypted: i=1; AJvYcCV3JWE+XhMPIWliwNSUNaIm2lMd+wbnSG/7tY/5ozf0d7OpxkuCR0V5y45hfAOAGdMihjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDwFEFTFFOT4aXvQA0JV4v0424h5aokLXzI+gMzr/0pqBty4I
	DWCv9aZot2TzU7poKSmclITTRj6TuMGLdlkaVX6sQJbtM1Z0LFMHkJVI
X-Gm-Gg: ATEYQzwcTo3LA4t+zbl9hY9Ee3rPirYFhlK5uz2xFADUtnIWtvvWyovDX0dmOOGpehR
	40E30r4UwW4NBRLPrNmY5w0lUmTkswp5il918b4mkNQaudnTdGbY+osmdYVfNQSLcpzF7l7Y0FF
	+FdE90G/j7KblG7cvpcpIwZ++LDXDIzNNj45AivczPpDPrP28cj6zKjy8AFzxPkQUu1U6gQku5e
	MIyW9GPCKM9l2f9VrTIB9wYYT45aKDTYSXfWDd17hNqEeT4jKGVSiFd4qaaEIlxzF2KF9xnU5im
	KDRbUTQ8YzLL2wdLAh/Q8xHysMSgqPDuxty464M/pi9JA+23ofv3xGLv3UdhMxUIigr3HqUBqtP
	n5xB9x3A0lIBklTizlD+QzUoBLt9cqmLAyKLSw5n3dPxea0P3qyOSmdHv6xArcPsftFPfnXePd9
	cuEN2ddbJfV/sK1IV2KT3cEfm6IPlyZCtcGCpiSRPMupHZbJrNZYJ7G9mDM8pr9Qj4Q6WLq7uN2
	uV5MA==
X-Received: by 2002:a05:6000:3102:b0:43b:4909:203c with SMTP id ffacd0b85a97d-43b80577b22mr5251985f8f.21.1774349376511;
        Tue, 24 Mar 2026 03:49:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm37589265f8f.8.2026.03.24.03.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 03:49:36 -0700 (PDT)
Message-ID: <d366fc82-efcc-46cb-9536-cd38b1fd18d4@gmail.com>
Date: Tue, 24 Mar 2026 10:49:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rev-parse: use selected alternate terms too look
 up refs
To: Jonas Rebmann <kernel@schlaraffenlan.de>, git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>
References: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
 <20260323-bisect-terms-v2-2-8d6bdb2c9c7e@schlaraffenlan.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260323-bisect-terms-v2-2-8d6bdb2c9c7e@schlaraffenlan.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonas

On 23/03/2026 22:49, Jonas Rebmann wrote:
> An old/new bisect will name refs "refs/bisect/old" (or new) accordingly
> so the hardcoded "refs/bisect/bad" (and good) yields no results in a
> bisect using alternate terms.
> 
> Use the current bisect_terms to make rev-parse --bisect work in an
> alternate term bisect.

It would be clearer if the commit message started by stating the problem 
that it is solving i.e. "git rev-parse --bisect" does not work if the 
bisect is using alternate term names.

> 
> Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
> ---
>   builtin/rev-parse.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 01a62800e8..f20f0554ed 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -10,6 +10,7 @@
>   #include "builtin.h"
>   
>   #include "abspath.h"
> +#include "bisect.h"
>   #include "config.h"
>   #include "commit.h"
>   #include "environment.h"
> @@ -940,11 +941,14 @@ int cmd_rev_parse(int argc,
>   				continue;
>   			}
>   			if (!strcmp(arg, "--bisect")) {
> +				char *term_bad = NULL;
> +				char *term_good = NULL;
>   				struct refs_for_each_ref_options opts = { 0 };
> -				opts.prefix = "refs/bisect/bad";
> +				read_bisect_terms(&term_bad, &term_good);

If we fail to read the terms because there is no bisect in progress then 
term_bad and term_good will be NULL and so the next line will segfault. 
We should also free term_bad and term_good once we've finished with them 
to avoid a memory leak. It would be a good idea to add some tests.

Thanks

Phillip

> +				opts.prefix = xstrfmt("refs/bisect/%s", term_bad);
>   				refs_for_each_ref_ext(get_main_ref_store(the_repository),
>   						      show_reference, NULL, &opts);
> -				opts.prefix = "refs/bisect/good";
> +				opts.prefix = xstrfmt("refs/bisect/%s", term_good);
>   				refs_for_each_ref_ext(get_main_ref_store(the_repository),
>   						      anti_reference, NULL, &opts);
>   				continue;
> 

