Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AADA280CFF
	for <git@vger.kernel.org>; Wed, 21 May 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847832; cv=none; b=APIgzPs7QPGQtP4C+7rgHizdG+7ALn9OZet4xoH9s6yhFUW53+39oUF2TA7a/KCnkrbSfpuumwWGpZ39S30H9BRcwGrsWnmPaOvBfveme8u+9bWYILd7H9hjvUAU8aEAZczVcPhfaZgBpQKRMEreE/mzje4qlvKqTkJUF44fKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847832; c=relaxed/simple;
	bh=AcpMpLTS5Rj0t19LNEQIQERwk/kWWFZWZb4IgN3ay5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqPhNNKID8+sc6U9RxAkMpHAsUOJVX5f71RhYRzfCbWNTqcFCTuRwiB9q7oXOzQaZOuk9P7rMpVaYinE7zx3s3Zg4g9UssStsJ3ZDE2UPFgWVF70rLjBhDcMwCeDe134qUEulHWFKxSYF7GNyQy1O6bL4JMYb978vpc7P8FMBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNjU2Yws; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNjU2Yws"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70ccf9a4ab3so39375957b3.1
        for <git@vger.kernel.org>; Wed, 21 May 2025 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747847829; x=1748452629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NedI+BADFKj42hDmlwQnG8MZHtP02gKJeED0NR3l68s=;
        b=NNjU2Ywsyz+waAy2aQITFwP6waAereFZzVXWL5Ba3l/30nQcQdtH+7AQWsBYEA67L6
         IwB+o6r9OXecLayqv1rQs8D/URnW85xERCtYdqBSvfzs4nQ24CGrzNttg+u0E9M3iR6x
         YfQYYrix1hFGpuFcZwFsaqobnAHZls418w5kqDEt6+xU41I1+9vKbhhUcJfbduMOj38U
         Gsog6m1Mj+URnRAP64vsminx+sLIu8dBFTpB2Dsga8mvel8nBqw5wZ7o/20Qs0YG8b7c
         GV6vL+ld85jGkm/q0VA2iXueAUNi05A7VjXePWgRJ9iPtEPbRXyCe7W/ptVr96z0IRHj
         JYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747847829; x=1748452629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NedI+BADFKj42hDmlwQnG8MZHtP02gKJeED0NR3l68s=;
        b=ikWxlcP6PUrt5dTassXaiHF7NsVHlElggzo/GZbjNJamKPsHj1vZbI+dzMZnSTKWn/
         7Jk9Fepf3SGTJ90smMWQahTFmVot9tREQm/gwsWkAJeTfTs3tkvnogdIDvQs3MtuuN7b
         kjFpKwFIiJ6qakpbNOrSxJF8K1+YlrZ7BG6By7XLKI30DXT17J8vKDU+fOXA589oSA1c
         ALJ2flQag0JLUNw/ap3bep9XFqACmVeX5ju8S0UkUw8cuWaOhlPwh9NgX4rYSgz4dQT1
         LJ8LQpxivx2Wjj48KmKfTBnuQ4SQYuqQkt7vnQTVG6QuYfQ2VKRegpKYpRavpecxsOsb
         lABA==
X-Forwarded-Encrypted: i=1; AJvYcCX+1Iic5fXMXRqQsX26bEr/GzfubStGr8S/Bjry8cSycGPg6+vEHezNV0oQTcmNJBS0fSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFsIf5KXcO+8iB3UUVJrvAfbmc8+REQDwGIbdhRuwvkBKgt16
	vzux7wYpV+8H+y8E1W9MAHqhcxhV9YSKA3/MO8Y6h90g6ff9CaW6rjZg
X-Gm-Gg: ASbGncuYuoLnIp9/i8kuFgheDbRiYdMgvmAIwQwvpsjEWrdR3xJOsKSM7bsWtYNZXP7
	H9Owh4ZOrhsjH32r0GWrkIk6m/da7oLumHbknCIRLFD1+SJKqeES+HFeL18qkSlosBJ9p6QWxGU
	/5w6Dlv1TGDjAAmYxcXeMTwsBdx8rle5YV4aqx5m1VivgSp6bFWAQV029dhQx6QXeMFsodH5kVJ
	QEbNU4VQj2E1t7FY6AFOrC5tBWE6jYcuffTpJsAICTyCOQsx3f5KI/eO6KemLRtvENvcu45ntYq
	DhR1QfkyENtsLWcFNuo3z/dDSyTszeEVq+nU1gyNIIYOpoqBBSbrAjs2vblaLYZ+EV90uKi4bHx
	x7SW4aYLR4FBjV4Mb6feL8QoqfmI=
X-Google-Smtp-Source: AGHT+IE9g+OhFdQ9I0GhBDVkpapbql+0XkfxFBjWeUnSWRdzbtYR/P6nPIlaGTVkpAfyPdqkT+UHEg==
X-Received: by 2002:a05:6902:988:b0:e6d:f287:bf3 with SMTP id 3f1490d57ef6-e7b6d44f287mr24945371276.28.1747847829207;
        Wed, 21 May 2025 10:17:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:d51c:763d:85e7:1777? ([2600:1700:60ba:9810:d51c:763d:85e7:1777])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6ae034c8sm4096264276.57.2025.05.21.10.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 10:17:08 -0700 (PDT)
Message-ID: <9c26d844-6ac5-449b-a5ff-a842ed6ba8b9@gmail.com>
Date: Wed, 21 May 2025 13:17:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] name-hash: don't add sparse directories in threaded lazy
 init
To: Alex Mironov via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Alex Mironov <alexandrfox@gmail.com>
References: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/2025 7:40 AM, Alex Mironov via GitGitGadget wrote:
> From: Alex Mironov <alexandrfox@gmail.com>
> 
> Similarly to 5f116695864788d1fe45ff06bfad7a71a8d98d0a

nit: we typically use the "reference" style to refer to other
commits, use 'git log -1 --pretty=reference <oid>' to get output
like this:

  5f116695864 (name-hash: don't add directories to name_hash, 2021-04-12)

> make sure to avoid placing sparse directories into the name_hash
> hashtable whenever multithreaded initialization is performed.
> 
> Sparse directory entries represent a directory that is outside the
> sparse-checkout definition. These are not paths to blobs, so should not
> be added to the name_hash table as they must never be queried.
> 
> Signed-off-by: Alex Mironov <alexandrfox@gmail.com>
> ---
>     name-hash: don't add sparse directories in threaded lazy init
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1970%2Falexandrfox%2Ffix-threaded-hash-name-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1970/alexandrfox/fix-threaded-hash-name-v1
> Pull-Request: https://github.com/git/git/pull/1970
> 
>  name-hash.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/name-hash.c b/name-hash.c
> index d66de1cdfd5..03123a8779a 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -492,6 +492,9 @@ static void *lazy_name_thread_proc(void *_data)
>  	for (k = 0; k < d->istate->cache_nr; k++) {
>  		struct cache_entry *ce_k = d->istate->cache[k];
>  		ce_k->ce_flags |= CE_HASHED;
> +		if (S_ISSPARSEDIR(ce_k->ce_mode)) {
> +			continue;
> +		}

nit: for one-line blocks, we usually skip the braces. But I think
that it might be better to reverse the logic to get something like:

	if (!S_ISSPARSEDIR(ce_k->ce_mode) {
  		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
 		hashmap_add(&d->istate->name_hash, &ce_k->ent);
	}

This seems to be a performance-only fix, and it might be interesting
to see if there is any impact on p2000-sparse-operations.sh. Those
tests don't focus on many sparse-directory entries, so that may not
demonstrate any meaningful difference.

Thanks,
-Stolee

