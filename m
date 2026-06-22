Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E8175A74
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151943; cv=none; b=eG8WSMdJhQbv/04CkxS7OQaDZGhKpKWSeuhCptsrX7ED2xIeLEOvFM2NFcHKre0vquOWj0pCZ/f30IdKE57wWkZKLiYItoLLrRnLqMMf8nahHeGItt5CbKW7eQgk/q2Y8HG7lVdxkZJ0CCGyVZGSDEumIIHoNkURlpicryMCnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151943; c=relaxed/simple;
	bh=LYkn3LhKPwcwggYZrmMsxmP5fsj6oUuwtBNeY0e4Yho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzrJwOTDV3fVWeT3tsUacHrwY+QlUyEyTZRHtnn8XeOuPyFvTE+fjbqx69xjGa1Q9v//RRUASrMVqPtX4NpIJiUgMJOKQnBFfziHexurD3BuFWhgvS4HgrnxekfmKlqajweu9jfWq41Xxsn0TuuM7h3tL8dnV7m9vZkqnrN5UeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxMHDzfv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxMHDzfv"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92213351918so282723685a.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782151941; x=1782756741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqtzdSk8S0pW7aEc7jC4au7/Tsu6JFfySUTgV8zO2c8=;
        b=pxMHDzfvRkp3OMIEi9i1BYR0d7/5YGFL5YEhtoTcI0eYQxkROAIWMOZdwfbdkmLxOy
         oB/R1mLoD9KVCV2wIWAoUsoKkWNO+T/7UmM5tTRN+3RvtVglRrttJPwmirKE90W/RV/t
         sRovAnlH7w0kmfF26qeM8lQ+Jpp8zEI5kVM8Gd67bjY7bdq+YUhj69TCtJAnmiMglzfG
         duOqIpbK0xBdSu8sJK39GADGaMJTk7mvBg0a+JiRMTTIS8f9ij/EWqkDzNglpS5NXKup
         KAgkxVeg4BMnR+Wm7gwrB3VQoX0DI9ERBk/zvRR2mFTJVRZKXlQoBMXZkjqTjPM8V/ct
         EZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782151941; x=1782756741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqtzdSk8S0pW7aEc7jC4au7/Tsu6JFfySUTgV8zO2c8=;
        b=VY3GCErEpBpBS2C/43KqXRX7cMg4/Z5bzCIYN+vtp6CP3bRPFSGvKVHtf7yJipVdDp
         SNXAyL8wO33V/QmeUIcpHAYXKarftiIpJ1uTJVoD30bZk6Lt8WYtxX1ZKtqJQ4M7Q2Hj
         KCF3RbO2XlqszO78e9soBZJsI4TC50MaUFu4FI5EkhfBsJDGF/GDyCXSAz8BDKW+yF7o
         xNCVmUVnW/OP5q0Z/pCozcEjxKe1mPI7FeqYyPYhWV0kpK3kUfVGa3MpUYMkjB0uwh64
         NWBeTsHfcG+zh5Lf2Y4lVuNWiKWVcasr89w6U+mc82+0z6KUyr77r2R1nHCAR8IqItzk
         lEwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kgoY+bqeM3WKBe8NWHCwhXyjuiX80QSvYFkEjwjx80zIZatT+cNgvDLo5zyWBlnsw1VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIqjmkITb+UAp1JTELQyO+Rd2HuA+5fE8g4Ik5FgH1c9gtVcVs
	/s/P7k76g8xKNjs6c5hFAqdk+b3Kxha/m3R77bawkYedkI3fl7241Kmv
X-Gm-Gg: AfdE7ck2PW118NEOXmG91B5zeIM8amd9xefrN3a3Ogr1cxitVK/2+ZzOqoeHnDue2Tt
	5YTZczcWEv24W0Q0mb9k70z0+ySRALLHzVIxNqbiK4VVy1FJoSXx9Pg6ylLTJHzmdN6FhVbCpG6
	OYrTeMaYGpgst9xNcfwuMT2ItzuL0GrFHw8PuYtRAS/HM8ejgmSRbTBAAC5suSheaDBOTAFIX1t
	CJNXFd+6Vcq9BCs/L0rWCYDIOp1bKEKPuyeHx7pDEidBu7GykQ4tlQ7wvzMi8kG4h6vmk2AiVU7
	9T3kNlPWNX5IHlbF1ipam80N0yfKvUM3+/lvG+c/I1OjyeSaTC7q3jExM+1UUwF8i6KEDm0Br8B
	S/iVvI7hV8LAJe0i6gxi6dWcz4cLiBVnMkXnpz8ymHBV6ivNPBF2XXZ3LJMvfbIZ+mmLIXhXCBY
	DHivhufJQqxMh/6ueKx0CTehsKvXXDeYd4eKFO5qK46ZTwrvaNtkLxQZ0aDCOT+RIwy8DN
X-Received: by 2002:a05:620a:440a:b0:925:eb05:d194 with SMTP id af79cd13be357-925eb05d30emr139522385a.57.1782151941285;
        Mon, 22 Jun 2026 11:12:21 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39188csm44378885a.6.2026.06.22.11.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 11:12:20 -0700 (PDT)
Message-ID: <5c43f6ce-4dfe-47dd-b96a-80de57ecf108@gmail.com>
Date: Mon, 22 Jun 2026 14:12:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 3/6] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <ed12a5cb5b76925cff08d2ab61efeda382b4477a.1781951820.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ed12a5cb5b76925cff08d2ab61efeda382b4477a.1781951820.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/2026 6:36 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Add an early termination check to paint_down_to_common() using the
> per-side counters introduced in the previous commit. Once the walk
> enters the finite-generation region, terminate early when one side's
> exclusive count drops to zero -- no new merge-base can form without
> both paint sides meeting.
> 
> The check also waits for pending_merge_bases to reach zero, ensuring
> all merge-base candidates have been popped and recorded before
> exiting.
> 
> The INFINITY gate ensures correctness: commits without a commit-graph
> entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
> which is not topologically reliable. The optimization only fires
> once the walk enters the finite-generation region where ordering
> guarantees hold.
> 
> On large repositories with commit-graph, this yields 100-1000x
> speedups for merge-base queries where one side (e.g. a PR branch) is
> much smaller than the other.
> 
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  commit-reach.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/commit-reach.c b/commit-reach.c
> index ba1e896f0f..fcd1ad0167 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -201,6 +201,19 @@ static int paint_down_to_common(struct repository *r,
>  		if (queue.p1_count + queue.p2_count +
>  		    queue.pending_merge_bases == 0)
>  			break;
> +
> +		/*
> +		 * Side exhaustion: a new merge-base can only form
> +		 * when both PARENT1-only and PARENT2-only commits
> +		 * remain in the queue.  In the finite-generation
> +		 * region the queue is ordered topologically, so
> +		 * no future step can add paint to visited commits
> +		 * and an exhausted side cannot reappear.
> +		 */
> +		if (generation < GENERATION_NUMBER_INFINITY &&
> +		    queue.pending_merge_bases == 0 &&
> +		    (queue.p1_count == 0 || queue.p2_count == 0))
> +			break;
I mentioned it earlier, but I think this check should be in the
dequeueing method instead of in the tail of the loop.

But I think this is the correct ending case.

I like that you broke this out into its own patch to demonstrate
that this is the key performance boost. It may be good to have
some performance test numbers that demonstrate that patch 2 does
not add any substantial overhead (timing should match previous
code) and in patch 3 this single condition gets us a huge benefit,
though it requires the data tracking of patch 2 to work.

Thanks,
-Stolee

