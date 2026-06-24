Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633731A572
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340983; cv=none; b=Pds09CIqkXr12/8j4Rx6Al/4V9Kn8nRXsdS7rp8MVI1442KUb6GnurDfzNacRQvaKdPUA5ZiUzSbXrXm7lvTvsEq29PjJwStny3S2uvUMzoZ8VG94olVA9pTD2RHbOXDFISE2Q4ygcoViI2LBESmJrv+nqrvmyu9DH8NDvpjYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340983; c=relaxed/simple;
	bh=CjTHJt8gHXl824HAmHOZkzCAqXCmEJJx1KeXeH02NcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ctt6hAzRMZhgIgO2pFAVeJ/JjLPoU+5buK1SBTlS3LDpKgw6WuIQdfGp3I2piquc8zERy+UYonv3iNpOGo33OEJlqOe/MetuFYwFHlTEPEz/+t9pHAI4aM87DmBiPCGJfnaUJbp1CIV6uNldL9ig5m67UELDeUdW9KUj/oljZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RdwFAR1k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HK0wh1BU; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RdwFAR1k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HK0wh1BU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0022A1D0007E;
	Wed, 24 Jun 2026 18:43:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 24 Jun 2026 18:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782340981; x=1782427381; bh=DRg0qnSZXl
	RBODG+LAY23Ov4mWG+TcNbZcOHTIr5DNE=; b=RdwFAR1kiNEwoPlVbq0jOB9RC9
	uf5mUIG310/JpFHgPuKnRK0qGR2glLeV1NTPtuFtDx53z5DornCWDIonBx6ESndb
	plaqXXVLcZkoYv/YICpZmsaz0ILatPpx8kzzxQ32HGw80x6ZtdMe6lxusZ5DiUQb
	Iai5OCTR+qUdqDRnhYOFLF6upom3tolTvQOt2GwqcErbXb2ro73uweKFHuLkN7St
	+gCYCS5nXlqKQXh4geQdIakb636PBTJVv85HY8JIoRteArMDHa3BINYzrH30jVs5
	uUb6wc6cmUTe3uz3/6vqfH7MRpO04ePxhL/2/fGkC6JyGeZ/405B5qMcFEyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782340981; x=1782427381; bh=DRg0qnSZXlRBODG+LAY23Ov4mWG+TcNbZcO
	HTIr5DNE=; b=HK0wh1BUhsqHSA0v6iU1kedAm0dne3GMoVUOLj16njNsLF8xukN
	DduaLKFAnwHjkQ5jyBzJj3mar0aIrg6+mitEw5SThC2H1lJG/cWQ9ZxlVY3D3Dbj
	D/yMu3dj/XpuAMgQUcBBNIIM0rfL+JgiOgQ0CRiSARCqUJ5rweUoJOtD3bw4I3QC
	rDtFTFkDfAryoZFisg4ydYxMr9kq0VLBAaiS+f9cGNEliBJLrm7sdQlIwEU9ybPq
	9X2S5jvauZ5hXHYphdPB3Q7Oos2oKESSYSUFNZySpXp3JDzT3HTraFpJLSdpT6Hh
	HZxab/c1KrFAGoOdcrPFgBOfDbQX1K8EIHg==
X-ME-Sender: <xms:dV08aolQt3b5WbOmrV1Hr5yNw3JGHcpgvL6lJFAu_ZlYV-QyiIBI1Q>
    <xme:dV08au0g463rLtuGB2KV5rrUJQneZAc7MViRJ3wqC2Mk7P6yURISpv7w46HlYmpq7
    W7YrwKB_Df_IjuPZmD2xvrpakY7HEG20ZOVFqyJLmbmHYgyYZj5PA>
X-ME-Received: <xmr:dV08aroAsGcAk_9I5HWnr5wIpP1OA-2m2igCqZFE2hmxbUITL_QUSHnfvGMvqtwTFZmLGRQsnQsoUq71wh-rctviJKnouSNWEfUSnKk>
X-ME-Proxy-Cause: dmFkZTGjQKKmEi6eAIusmWUpcMufxSFCbj3c59W2toC+r5o/9V854qwEAjqghq28triCYX
    mmV6RxUIFJSIaF3rmJVMtROCqPbOcuPhk5qZbST1Jqi5h4QdOOEYHzFRyLfx1T79EIi85a
    iC1fxBmoZz4O60eAO27pSU72eamzK/ZWlhFzysYioadrWDTk96ct9TyCiXbMZcVDEw6DTi
    ztIftaQZ1fCogGlU8xT0RBUKC3IAI1wap7DwO5E9Kg0BPGCurH8LKxHA/OP/zCFangw+9p
    tG+Jrqdqk3Bv8NzS6Y/vieCGvEJKbia4jN6MMIB5/ScCg103i4klB3JngyKB69QhnKPFeK
    BUxFPwN99rDWqDnVHEpgbA5lzecIXY3e6SAnkC1Ttukn4Ikjgf2IjhNxG+0cWIjF5NPC+N
    vaWd+zvkzi9CoTunsQhkDXFVGzj6mYwrP7dvfnraKtBk2PWNegUAXlQoXWj05Z5+UB/c0Z
    eJTdWG4XOMsW8cYYcH7VDdMVH/IM4WM8KyI76y05QvYQHkW++dUbqxR2/h373rJE8FfCDr
    Q0fr9gPXZhbKMx+aVqANEFV1NFt38IMmtLRYN2R9E6QYQh2H1PF9UHquIFYIbbK34dnYW9
    uHcX5tHB5pSUdIMU+/w4FKaEVr+8AX+6dfsOKMP0a7hESc+SrfKy0aWcbMKA
X-ME-Proxy: <xmx:dV08ajd5LxdTmu72r82WdlQGyD2rMYTvmK0KvfjsN7_OVZsLQxdcYQ>
    <xmx:dV08aio8E6SijZFvjjpGJo4mPbgcmVXEZoQlufSkO3iK9F46xiok7g>
    <xmx:dV08asGnjFV2eC5Aoc8DxXkkdIVBIQIQEg8Y5nVX-aIjVnsUMr9aTQ>
    <xmx:dV08aqvmcVfGCVBYWgeD1FuOAQAb9E0EgyW3qCKGeqt0jt7axtizVQ>
    <xmx:dV08anKTG5VU6FhuM0f-Uqx_r_kTAFeQzvbNHwjTFn5BHCxPDsOGVtVM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 18:43:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 2/2] push: suggest <remote> <branch> for a slash slip
In-Reply-To: <49de5a925de506ed9a141eb72927b2548b73af22.1782338114.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 24 Jun 2026
	21:55:14 +0000")
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
	<49de5a925de506ed9a141eb72927b2548b73af22.1782338114.git.gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 15:42:59 -0700
Message-ID: <xmqqa4sjh85o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
> index 80b06a0cd2..cfb294305d 100755
> --- a/t/t5529-push-errors.sh
> +++ b/t/t5529-push-errors.sh
> @@ -54,6 +54,37 @@ test_expect_success 'detect empty remote with targeted refspec' '
>  	grep "fatal: bad repository ${SQ}${SQ}" stderr
>  '
>  
> +test_expect_success 'suggest <remote> <branch> for a <remote>/<branch> slip' '
> +	test_must_fail git push origin/main 2>stderr &&
> +	grep "${SQ}origin/main${SQ} is not a valid push target" stderr &&
> +	grep "hint: Did you mean to use: git push origin main?" stderr &&
> +	test_must_fail git -c advice.pushRepoLooksLikeRef=false push origin/main 2>stderr &&
> +	! grep "Did you mean" stderr
> +'
> +
> +test_expect_success 'suggest <remote> <branch> when the branch has slashes' '
> +	test_must_fail git push origin/feature/x 2>stderr &&
> +	grep "hint: Did you mean to use: git push origin feature/x?" stderr
> +'
> +
> +test_expect_success 'no suggestion when prefix is not a configured remote' '
> +	test_must_fail git push not-a-remote/main 2>stderr &&
> +	! grep "Did you mean" stderr
> +'
> +
> +test_expect_success 'no suggestion for a trailing slash with no branch' '
> +	test_must_fail git push origin/ 2>stderr &&
> +	! grep "Did you mean" stderr
> +'

t5529-push-errors.sh:59: error: bare grep outside pipeline (use test_grep)
t5529-push-errors.sh:60: error: bare grep outside pipeline (use test_grep)
t5529-push-errors.sh:62: error: bare grep outside pipeline (use test_grep)
t5529-push-errors.sh:67: error: bare grep outside pipeline (use test_grep)
t5529-push-errors.sh:72: error: bare grep outside pipeline (use test_grep)
t5529-push-errors.sh:77: error: bare grep outside pipeline (use test_grep)
t5529-push-errors.sh:84: error: bare grep outside pipeline (use test_grep)

