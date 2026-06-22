Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD2343896
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152474; cv=none; b=GdjnFSfEhTwGwmoUpdrbwGXrg/C3Z0y1vACxrjvXGyxmB5HXmSy6VGrcg772aHmOX1ciov0QOJlmOwif1m35K6tUQ5OZvgV8ZsAQz9g7p/iTJT4mHL/us+6uDlQsjeaJTdbxRcWl6XAcshcCL008qfbLtX9iKTaciqa7PauLdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152474; c=relaxed/simple;
	bh=/WPNKpXVAcG6LCyrugVwsEvo5VDlLLgvt4HO6U2m3v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOA6hrNGuNWQrqP7eso2UnJzcOS7NHhExQVOa42GFcXEw0t9URx4UQxgZVBN8h75wJXA0h+gJhx24GI8p46t+iqZDBgtRxHXxKN0j1PY5h1e6e9LNmpYRWVmXlInvOlj4NGBShBO+FKHyvQcvaPm6+hgXuQaLWY45LNaCj7XBzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLklthcM; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLklthcM"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91587626a3eso568049785a.2
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782152472; x=1782757272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83X/SYY1cnUgnhDUeMS5IySlsJ4Y9VQi2lG+OWwW6k0=;
        b=FLklthcM4yBlkgvR0VNIvHMzX9C55G8Y2S1abCAIiaYHxycJoNFMFrdr5e7fgOd5EX
         PDH7mZ/Zl7DOFu3OOYakwLv7g496FaDNyuSIG3s3Sc+Y7KJnaYZ5HHsVv8/INcFFjBCY
         /BA3goJg7q0YWIcR1hDETCTSdTX8gweEWRHDlAWbbIVZ/AdsuaeRyOjN9Zo+bvYiOovu
         W6T+ZfvO1fw3cEWInhltBf31UjFCf0+e83miU/exKnh34dMKSl/NZh38ZO0GPxp9IXjP
         GUOXrK1Tv0O3ZKAd/5ffA1ZVnwKU4W1b2fisM2w3CIngGlnXaaWP3rG+1wjJcLrIyeLR
         oWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152472; x=1782757272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83X/SYY1cnUgnhDUeMS5IySlsJ4Y9VQi2lG+OWwW6k0=;
        b=ofE9T+5aqqIqfKSbIe1y8UTaGfGCszlhCm/GYW4TQwu2OXUCpvmhaRNqUxrYMDi5bS
         lv5LjMzHjqyFANxZ4SsIHPadJCsxPCPPiD5NF68E5SY6sTjegMHrIb1byRbCkjjkinjT
         csiSFi2cV70Ujd6e1UsjTVqEZCe77S1hjeh7ovSYCxj5GFl7XFNUEou+KQ+VG8DPr6LE
         CpKNfLKAbZpjZbQZbudvfpWPDje+xbPKhJT705DoqxAT5Q33tmjMzRT2lQph9OdS+Qgk
         5i2PYxD+QGXCQCaa6EyAm+PZ7x+WL9ywIclOm+WejhGiEuzH7mcM9n1g5gowQNkKg82P
         z2Fw==
X-Forwarded-Encrypted: i=1; AFNElJ+kKQBgEc4jCbv3DOvOLAGwQz6Pj+6DF8zUqoZIHmP1ndsYwpvKG21zJNBtVw4lg7T89P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjlXIJtG/tNcpUuGhlYqPqmEy9kCIQEcK0ZxwHxm5FKj3iyge
	TvwQhIiQcw1sUEjw2fZ/SnuTHbeQFBNeDR4QdaAisLjNi1Zlx3Z3nxdO
X-Gm-Gg: AfdE7cnIWjGdK/hwGNnsG9aJWhU11DzwMJqIYUSI6Li6/tQSxJu7M0WFw/HNr+iMVLK
	tRBIc4SJGYcp35pr+IVJk4iZoTYw+71xFWJIX5c0Y3wVHDHXMXAZ4Q7lnejaRPgHyBaUdP+2OuV
	gLm0e4yBwutC1o5eJU5bnAQ3DJq9JJ5lF5dtxO6jp8sRk3dOJnK1vSsx41GRxyJsQ2Bruy2D7F6
	2s2gvS5qbkJEJo9Z3UnyBJi1FK5TwTwg/P2eeE60MkeTHcf52LuW1gO1ZmmE+RnvlxbZp27GCpr
	0Rg3BCsbWjLnutz5ECGUrZtuGgN0PM+3iowcRrZSO5zI24jsqPs1zvA7GNUyyniDcxW8mmopcxq
	yrGaqBdtbem83De7kDBgPDPMIfGd9KLGFw1Dal1oZvmnVbl+nuBHcaNva9qCoWSJWpCbvI2k8Vl
	wMjrS0dSmjzoFG5p1IDstaQEoYqadm69oYMygxtUj42PT80XW4gxhnn2AjBQ==
X-Received: by 2002:a05:620a:4626:b0:915:a953:4b93 with SMTP id af79cd13be357-920d1ce41dfmr2253283585a.3.1782152472291;
        Mon, 22 Jun 2026 11:21:12 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c3257sm43700885a.29.2026.06.22.11.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 11:21:11 -0700 (PDT)
Message-ID: <50dd5fb1-6b4e-448c-977c-cdc476f7fe40@gmail.com>
Date: Mon, 22 Jun 2026 14:21:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 6/6] Documentation/technical: add paint-down-to-common
 doc
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <9cbfc67d724d91b9abc3621f03a3c97208c76a70.1781951820.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <9cbfc67d724d91b9abc3621f03a3c97208c76a70.1781951820.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/2026 6:36 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Add a technical document describing the paint_down_to_common()
> algorithm used for merge-base computation.

I like the idea of documenting this so it's easier to understand.

There is risk of drift from the actual implementation. You may want
to add a comment to the method in commit-reach.c to indicate that
any change should be reflected in this document.

> +Termination
> +-----------
> +
> +Termination happens when we can prove that no extra progress is
> +possible. We are done with the main loop when one of the following
> +conditions holds:
> +
> +  1. The queue is empty.
> +  2. The queue only contains STALE entries.
> +  3. Side-exhaustion: the walk has reached the finite region and one
> +     of the sides is fully exhausted.
It could be an interesting exercise, but potentially wasteful, to
add this document as a Patch 1, but reflecting the old algorithm
and then to update the document at the same time as you update the
code.

The changes in your patch 2 would impact this doc in terms of the
data being tracked by the paint_queue data structure instead of the
nonstale_queue structure (though those details are not currently
handled in the current version). The change to the termination
condition would come along with patch 3.

Thanks,
-Stolee

