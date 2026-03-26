Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8C355F49
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558273; cv=none; b=mfn/K8aN6AJg3iu+jh2/yY5c+XWqcEjjYcU2SrjD2u9D9UyLMpPNKNbSu6wb1Inh4PA/6PzxVjKNaiAt6OXabOh++3s9jsXupqP6F2LKE52o10XYuQc8hICQ7acnQLqclmU8rFCtH+fhDEP0QhS7BlPO8eI66b6sNupyg6T+g+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558273; c=relaxed/simple;
	bh=4jqA1cSCN0rqhsD1QuNn3pYCDoqVIaNQivYPIQjfiPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDScy9KEtpCsyet1JtRB8jkbZ7qgDi5jP7io5Jf1V6YwvxfQSrnlTeTzGtb5vRBPB02a48b0WMjs3VKPzRgY+R44rIHEYclJVbfUxEDLDVtu52CQyQNhRDYaVXo4nrLMOZo77siaUuBDKDeIcpMSmQRRH9If1vtygPR3bX4iQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lheQWIil; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lheQWIil"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb38e86cf2so159244385a.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774558271; x=1775163071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DB5Lw/lXFCxFzRbPnzs91X87q+F/C2BkA9BvojBgKw=;
        b=lheQWIilAu+wqyb2OSiOz2mV8jDNQ5vp9FQrS/XccEkpVFZu/hDrYfx+Fjr6P+UXOA
         6unYLkJpOpqoPJcIDOdeWo2YubRgIejYrnVwhGgTI13prkEsTobDgn4chlMxqYGGG/T8
         KK0oUBfe3krViZ1Jqd+ciszFHfNdz+y2YZEhvAQXaq5U2UMqcwPjJvtc//2ZLYiumQcc
         K2FbiV7XzKsNvrScLtyxEOCs0Kz9R3KWvmUxJmf/nBuRULlNNOroVyLjbfbPWOqZQT1p
         m4LwhzZqsQsgzaB/Ryl7PpADVWdwKSfMafjZxndg6S8HXV59QU8/xGckfAr1iKXpJUVP
         ktZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774558271; x=1775163071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DB5Lw/lXFCxFzRbPnzs91X87q+F/C2BkA9BvojBgKw=;
        b=MW4N08m18Va+XxTs+P/5lfxocaEHetbn1YyzcGd7Cht02qdRrTZvcWxaE4VoipY16N
         tiUGGJVmp0zx/HxK7zEaWHrJstEVg9MyqehUY1JAIdvQYQsqZ2peUgtkU0BijolM7PtU
         W35FKDM4PD3SERxkxXzi46Yo2CzODSxaPW+lex9B6ZW8817yqlr0aBYP/jKJuBx7Wxz9
         K2VP2t5xYMJ5OHKHIJux+JFPtuzk28T6X6A8UMhnMvF1c4Q82pai/i9fBCVssI5nyQEj
         rGi7HKdKxdaba4k9vPmzpJ5ehrt78+Gpg7W3U19XKr+AjzAKhfTE/MEZi7uzVQKzXCKP
         Rw0A==
X-Forwarded-Encrypted: i=1; AJvYcCUuoxMjtAo/hgpTZhP6wfNEUykSnwYVXVh+G5iZJHhMJlNqhqOnXXD8CC2gTG+uHTM8vnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOP63GxV9ttfLxrZWHSAvfu5khILybGpmnMMXMzNm92L87dyD
	J/Vb0DM4acTp4jOTm7WIdT/BLxGOgLwzB2Ft7X6qpq0lhFv7TnDWfXqH
X-Gm-Gg: ATEYQzzZHQLKp3SVc+rcp3DlFHDGKrDjmHZKNCIckgqMuKwHfrz7cwTliIj6GIenafz
	n7XN9ms/5YEZBHZ7TbnwODLqbHO48gAuyYbeKpEWbNMHrIXz6HHACTU3eijNi0FMnDmPamuVOze
	sBugtxBap+T5addlFuHmFZMBuesE0p8IZnu1/1Ud6wIhORbLLa2S7hnLaDttofv4xuacUinhIDK
	rn2K2N9UzzJcgLv5BXI3QoZyqy8wXKz21Yg48dCnd9mg2GflJWqVJtWBHFJS8FO/ua/dCOHj9S7
	JYkUYaEHQUv2q/a4gQfNrmGFKGGnTFy1DGDURYGSplRvoh0zGkfuwVsWPgoOajIKw5SZ9zS0ALd
	EbXswEvcAeLsQWPaeuZg5wV5Q6mCY6QehII7yfF/k77CRF3HAUot/0dGpSndRbVeQ+CAliDK1t8
	REDoH7ebTYjT1dsngbWlGOF1W8Ie2SA/hSmDt77L9sUcoMHPzjelt03AD8w7LeJRUOLLzM+g==
X-Received: by 2002:a05:620a:460a:b0:8cd:c04f:c6a1 with SMTP id af79cd13be357-8d001037fd6mr1277349785a.58.1774558271341;
        Thu, 26 Mar 2026 13:51:11 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4ceb95sm331631285a.26.2026.03.26.13.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 13:51:10 -0700 (PDT)
Message-ID: <4511ea3d-35b0-4a62-8dac-250a86c0e0f4@gmail.com>
Date: Thu, 26 Mar 2026 16:51:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] pack-objects: handle excluded-but-open packs via
 `--stdin-packs=follow`
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1774482700.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/2026 7:51 PM, Taylor Blau wrote:
> This is a small reroll of my series to fix an issue where MIDX bitmaps
> fail to generate after a geometric repack in certain scenarios where the
> set of MIDX'd objects is not closed under reachability.
> 
> The main changes since last time are:
> 
>  * Clarification in the first patch that the added `release_revisions()`
>    call prevents a *potential* leak, not an actual one.
> 
>  * Cleanup in the second patch (where we convert the --stdin-packs
>    handling to use a strmap) based on Patrick's review.
> 
>  * Dropped an unnecessary "if (p)" conditional in the fourth patch's
>    `add_object_entry_from_pack()` callback that is unnecessary.
> 
> Otherwise, the series is unchanged from the original round. As usual, a
> range-diff is included below for convenience.
> 

Sorry I didn't get to v1 in time. This was an interesting series
and fixes a bug well. My only quibbles are about some minor code
style things, but I do hope you'll consider them. I struggled to
read a few things and the changes I recommend seemed to make the
logic more obvious.

Thanks,
-Stolee


