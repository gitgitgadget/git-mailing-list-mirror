Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E548223719
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803101; cv=none; b=kCwvUIooCxp4IisPsfD0EsR+h9Bxgr2XVv7FGzMrQX1ujbCo0UP0N7QP9oAnDVwQnVFU/ePUSumqreCyUlp1uDHhXHs3AzGlB5bbtBEi7lQ9+muMbgAieVVLsp6dfdFqNOh5d15AV5tfOilH3wCqeXfpEqm6Y47QasPXrU8Wfi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803101; c=relaxed/simple;
	bh=69IsnRWsapEAotcoKBaiaRbydsBoTCYapXupshfsW3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVwAsEeMWw8j/cbUF5SKaO9AwKKj2iwgBUd4EnQkrJ8DZb9OOgLbXirBaknkn+3KigZv5h/vc1t3WAomkaEilMOiT2QWrModQLAigzR9XuuT8/S5sxsBtLDGDF/rP+I1zqp63rixsbJXaCARc84Cd2HqxnQo4LnqokY2l7+gLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7nMnY+2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7nMnY+2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so30233965e9.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739803097; x=1740407897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PY7Ta8n0V8ZRQk8Ebmp/E+yS7yU0+0HV8mKNrnMSC+A=;
        b=W7nMnY+2k5729Q+ANwNf91vPQihYZRpntPEqInLBX4FNj3lMRiO69dmAmc7PLg9tud
         ++MRyOfpQo63Ef5LzCfAoqrTHq45NjkfxaXHITrt06NDj6FGQsS9zz0GXwPcQs5o/Wad
         d5ByoI0UE7P1q/IPX0m8ZmaySCrx+5GHUdN/mYLPNUGWfELQxCVYg229eErEozhgOekD
         ArT4QBAe7l5h0tDOylD6ZCLhyRKnuNpxMPHoAI+O+tJ8BgXr3tnn5/i/7bCDkkTUay+p
         klyRJWwqom3g2v+HckXKZLMGt2a79FTUBme/aGMGVqF1olSYdSjWcezXYWm3/kanxeM4
         xgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739803097; x=1740407897;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY7Ta8n0V8ZRQk8Ebmp/E+yS7yU0+0HV8mKNrnMSC+A=;
        b=J7EoFY0xjAqzpqAvxqzbrfQhy+6Nwrj9cQIajy3xgE3SHQngBGcQCKvwe7pqqO//SR
         S41TONBGIy9KX3td8OR88BbUuq9MAfnSTJSLTKi0olHk3eI/aKBDrBZ073c7FrVSmua4
         DtEdf8k6tglwKROs9gD4WVy4CcnV/jodQrCKbVuerCWbN85xjDNrtcn8JcdgennWBTRp
         0qhuqpLbfJNQ7mmFAfex5s6cZ8K6G9Rtwm5BfpjrAk4zClIaa3L6cbpU+slhvf4AUYNR
         kmBrIc0+AnRSiyWvAXXSUwy06VCt+V0DuAomyOjQEy8Sbq3FuRr3pGia3hP3DuTlcP6g
         c9qg==
X-Forwarded-Encrypted: i=1; AJvYcCWc9jwOBF3Leim2QRSRhOZo56G1sAcog6S8KkBSf3KFIgppsEBtFFdgPCv6Y0Bb76G6OtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIF0tO89/7V3YehPjdikx65IOsMfu3sj2dhhJhg8REzMJFYnp7
	qpnCxkGNR3lAl0MAwPuZOw7XftJAvhWyyIgZH4o5xOe0AAgUO6Bt
X-Gm-Gg: ASbGncug2nQU5kZFXCZcldf5on2Te81koyPH1IqXOumDlD5Osa29yn+eOjDioIgzgri
	mE0IJo8nRScgYHWPxymFvvE+xOBlDp/P33kH2ZJDB/jHhalpvbVu3hQwt4b/oPU4PAhAgaHdTX+
	sLquzaqMmgo6uAMNPddCDG3umItVsIm69ZsXR9KPz0W8PtgXLd28v2/IimetEE2Fw3mv5ogU7qL
	vHHgD+wHcVA6140kHowb7Tds5H4GFWRvF8Era5G/FQ5Qhjm02wQQeXuq7T78jTOwYZprbmmG4u2
	42bW6bj+RWlvVBC62NTVa8kC0JPJCqYupLx9yA+IbRZSP60UtK8FxL9hkNDVAvJiSsm15Q==
X-Google-Smtp-Source: AGHT+IHNHpYA7hTb+vgg88bgpEwHT6h/sgWoUwyMAdl05Et1uPF2cVOCEX6us2xCrmbfWDFeUtpj1Q==
X-Received: by 2002:a05:600c:4e88:b0:439:8bb3:cf8e with SMTP id 5b1f17b1804b1-4398bb3d119mr16564705e9.20.1739803096434;
        Mon, 17 Feb 2025 06:38:16 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8217sm12614917f8f.90.2025.02.17.06.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 06:38:16 -0800 (PST)
Message-ID: <30c13b14-945d-4984-bb49-9fd93a4dedc9@gmail.com>
Date: Mon, 17 Feb 2025 14:38:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] builtin/diff-pairs: allow explicit diff queue
 flush
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: peff@peff.net, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-4-jltobler@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250212041825.2455031-4-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 12/02/2025 04:18, Justin Tobler wrote:
> The diffs queued from git-diff-pairs(1) stdin are not flushed EOF is
> reached. To enable greater flexibility, allow control over when the diff
> queue is flushed by writing a single nul byte on stdin between input
> file pairs. Diff output between flushes is separated by a single line
> terminator.

I agree with the comments others have made about the documentation. I 
also have some comments on the implementation below.

> diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> index 08f3ee81e5..2436ce3013 100644
> --- a/builtin/diff-pairs.c
> +++ b/builtin/diff-pairs.c
> @@ -99,6 +99,17 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
>   			break;
>   
>   		p = meta.buf;
> +		if (!*p) {
> +			flush_diff_queue(&revs.diffopt);
> +			/*
> +			 * When the diff queue is explicitly flushed, append an
> +			 * additional terminator to separate batches of diffs.
> +			 */
> +			fprintf(revs.diffopt.file, "%c",
> +				revs.diffopt.line_termination);

As the user has requested an explicit flush we should call 
fflush(stdout) here to avoid deadlocking a caller that is waiting to 
read the terminator before writing the next batch of input. Ideally the 
tests would check that the output is flushed but I think that is quite 
hard to do with our test framework.

I think it would be easier for callers to parse the output if we always 
printed NUL here. Programming languages generally have a function that 
allows you to read all the input until a specific byte is seen. If 
flushing always used a NUL terminator the caller could use their 
equivalent of read_until(b'\0') to hoover up the output (using '-z' to 
do this would change the output of --numstat and embed a NUL between any 
stat data and the patch). Using a newline as the terminator here means 
the caller needs to look for "\n\n". That string occurs in the output 
between the stat data and the patch and can also occur in the patch 
hunks if diff.suppressBlankEmpty is set.

Now that we are calling diff_flush() in a loop we need to set .no_free 
in our diff options and call diff_free() at the end of the program (see 
the comment in diff.h)

Best Wishes

Phillip


> +			continue;
> +		}
> +
>   		if (*p != ':')
>   			die("invalid raw diff input");
>   		p++;
> diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
> index e0a8e6f0a0..aca228a8fa 100755
> --- a/t/t4070-diff-pairs.sh
> +++ b/t/t4070-diff-pairs.sh
> @@ -77,4 +77,26 @@ test_expect_success 'split input across multiple diff-pairs' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'diff-pairs explicit queue flush' '
> +	git diff-tree -r -M -C -C -z base new >input &&
> +	printf "\0" >>input &&
> +	git diff-tree -r -M -C -C -z base new >>input &&
> +
> +	git diff-tree -r -M -C -C base new >expect &&
> +	printf "\n" >>expect &&
> +	git diff-tree -r -M -C -C base new >>expect &&
> +
> +	git diff-pairs <input >actual &&
> +	test_cmp expect actual
> +'
> +j
> +test_expect_success 'diff-pairs explicit queue flush null terminated' '
> +	git diff-tree -r -M -C -C -z base new >expect &&
> +	printf "\0" >>expect &&
> +	git diff-tree -r -M -C -C -z base new >>expect &&
> +
> +	git diff-pairs -z <expect >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done

