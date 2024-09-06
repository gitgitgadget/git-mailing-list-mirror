Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD421D5885
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651972; cv=none; b=oo4G+mvg6M/LN/OO3ShEYQqgmFnRBWXP68+qgBoFUnMBckyPEfJrjwejxioah25vasXj2nJtV3txIw00xBUN+rjNuZvfntB96+c+8vo9LvuHNXsVh76vyhXHSjQ3LxUVEQjw3hVzb1yEShWKqf9cDmR8OmZJg3BhaQ1JB/aLWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651972; c=relaxed/simple;
	bh=g9PZ/mjAOyne8pDLHz6Kzwz+luTE0sj0WXTeaXn5Wp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gREF1xJQX6gQpyzlt0/02/w+aMLAy/P+m1LIUTnXkolt+h5LjaXwtA0AdsdUFyKiyIAKkuaIvfjkv1+xfZ9At3B3h9fdpFQZGqF+H6aHNcNp7cuAYs973IceBGnyfNsDrl0IGeHNp9zuTSIYX3TTaioAsdmze3VPsWdXxL0C+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltvQP6q0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltvQP6q0"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2da55ea8163so1863279a91.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725651971; x=1726256771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iAbahpKK49XSKYvFKQo4bESfZ95gT7DdpFKQlnV6iQ=;
        b=ltvQP6q0pRUVf+Eq7/k//JT+oDdBfhrVAfim5ptDAHXlx0Oq/ZecsuNdm17nIs2WuX
         snBpVt+5u318z4O5Gk3na39m+RTOFu+/HUKErdUvVcKmDVIlYPkMagCFKFJqDW8pdjLm
         2XLPEMV2rKvEJZWjO+phtSHXJEBKvOSe7Dg8YqfN31W0e1FiHyoPuyFPt9Sd1frVHInz
         PXbt/ZJfRWbEP9eSb4ZODeUBV0b8OlzbhXgALRRGY8/FztmnG7pJAhg3c7G01k5ygFDn
         kew5+5TZKwHLI/YbNaPv/14jNifb1xojsS5o8e0h7DmVd4kRr39xUua8RUWwpNn1asoo
         gPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651971; x=1726256771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iAbahpKK49XSKYvFKQo4bESfZ95gT7DdpFKQlnV6iQ=;
        b=nljc5WimIHs58pAlqpI1CNEsII4Uu8HqznaHt1G5GGNyuMTWdqbmsFGVPe0pimBtUK
         v5TtY2KrqakcQEqP/HsDFKYuyLN6jN37+y2oWMfsgoMl92S0Z6QHGpbz2p2Hvr8QJoBk
         LoSs7LoE0h4mGFerQnSEyKl7u+uabQG0mleJVfzR7wIBPPk1TY0WBCJUW0xfjJwCL88f
         7cljOKT66oNWrQY0DdCesiTeVgYxVUl52sAsDFs+Z3nZs0MP4fta69jb4vHkLx5PMmYo
         talz29EEepZQWSZlK8smVL3xnMZg48NUo7rI3uTh7ZfGq1vYTVcnVSFB13FWoVixca0J
         xTCg==
X-Forwarded-Encrypted: i=1; AJvYcCXpeU3hSV7BXdVLg07ttK2VELzvvAVlNJPqzJmJQMqcH559wRHX8UqfY6nBk7kRcVXNI7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6invR+56Yv9X+8dePVEARlpEKIl6YoYuCDGxEPx+RQpTFppF
	wHilmanH8Tkiz5ObfXgHlF+c2KFX3lizlrudlHxZm6FX8eBSm8+Z
X-Google-Smtp-Source: AGHT+IErIji+7picuouW9ECHRyq7mdLODFKgvYfzZQKa+LRnKgbte2Yk1PrB38IeRyNguwjyJZzPYw==
X-Received: by 2002:a17:90b:384e:b0:2cf:cbc7:91f8 with SMTP id 98e67ed59e1d1-2dad50fc904mr4245029a91.19.1725651970451;
        Fri, 06 Sep 2024 12:46:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d? ([2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc08d397sm2003004a91.45.2024.09.06.12.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:46:10 -0700 (PDT)
Message-ID: <eaeb9ef8-d033-48ca-838c-25d1522e7afe@gmail.com>
Date: Fri, 6 Sep 2024 15:46:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scalar: add --no-tags option
To: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1780.git.1725545614416.gitgitgadget@gmail.com>
 <58ca5257-2e56-830c-c85f-79e4c9e80858@gmx.de> <xmqqwmjoyfwh.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqwmjoyfwh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 11:13 AM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> None of these suggestions, in isolation or in conjunction, seem big enough
>> to me to warrant a new iteration; I just offer them here in case you want
>> to iterate on the patch. If you want to keep the patch as-is, I am totally
>> on board with that.
> 
> Everything other than "prefer repeated use of -C instead of a single
> subshell in there" (which I think worsens readability, even though
> it may save one process), I agree with your suggestions.
Thanks, both, for your review comments. v2 is on the way with these
suggestions.

-Stolee


