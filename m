Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A104C2AE99
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512019; cv=none; b=uQUbFrIZzl9o9GD2RF9oINhtfXrlGS6ccEKVJ4aXCvJ1sFo1mwYNcerYnz8XawKts/IqtgupdPAaJVfveuqZgPZMRhKmfoCmo/zgFcZ399AWjoPAhi/m+WOItVv8LJs0wEjuA/wkpTLF1YwAFNi0gPkXKSaJZ1ZC4Xpsb2S+DWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512019; c=relaxed/simple;
	bh=Ympon810XCjxCV1AWy6HwyrbRUvwC1W5hdZHU9kAE94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1wHVPpPB/AN6VKpXP/cEtCAlAZyV2Ft6jbB976ola8VxLSlnqt68YAoY1PwUIwwrrRyTGPJK4YA+PyPgF/2x3KcdI6ABeCcDobgas03Owwykqg8yi74TLaoAAokwwqGI8qL4WboPWH+3Xw/vsh/QbY091ucuYmxP6eTOiMx1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIFOZrzO; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIFOZrzO"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso3196795276.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752512016; x=1753116816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OW/NDjno88nvzF6F/0wDIIVAjJoCJaeiMh8nM9q4KHY=;
        b=fIFOZrzOPvvtESRlyfCzlEZRP5BGB6vtjXIr7Jlac4t5M68bi9Naq020j1NJQz0l2I
         vroDfJOW8/NycjOKbpSx8AOWt4cMkdwxNzkL13Hz+C4z1uuU7UT2vUcJKBxe+J8mTzFK
         bpPRdsNZqXIiCt6rTv56/3DOrNrCZUm25dVuNqimUUK/2jq4Tl2SVob4MhH4DYDVIgcR
         5d5+rYzPb2KA/pgiyaaCRieQfPfOHk2jVwKeTnPB3x2pThFgNdchtFKOBdss04vUlpkX
         iGMaiDLFb7XwfZ+PIP3KUIZzwvbH2yTfu947NzaRB3ZTLkyw5Fv2kJOFFC3KGglyUnDt
         BdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752512016; x=1753116816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OW/NDjno88nvzF6F/0wDIIVAjJoCJaeiMh8nM9q4KHY=;
        b=U73G3t16etEgE22O7P5gN8wxMOlvJzcmy6yJalNOscs9t72ZRM9ZWK1bS/SsXOloxI
         BXlUjWSh9+lzMTCqMVpzlpQGWbzgHHQ/GMpoMwae0MI7cf5UxL3+cl2D6VVYy8IKx/h/
         gm9XqyZ8xVc2BYniT6mTmfxXDyRSvft6SNDVK/WfzG55cOO5TT8FG1x7QXFkoACVhPXP
         Is02WFQn4bMqVl4GswdFAmERRO2WcDUNbnC9COg9b9N0MEYRyDqLfkgFp7E86dUP2Yh4
         p9QFmOJJBI9Fml7qabeAlHeyUZE3G2OlIOUvghz4zXNHHUpjc6yltTAfjJbfnfwzgULI
         T+1w==
X-Forwarded-Encrypted: i=1; AJvYcCUPKwYPAAsdL+TCta59GB891TkAsuVhpatoiSWwjDadsSZLQHQfyawxs3n1R7XNGa5seIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JR73Y4JTHEgYti8VmHZ0LXWbe7ZqtONk0wd5s+3iuzyMcYnS
	PC4xubku3/ByHFt+RYfu5ZpNp33asEBXxRPkrrbZLT15bi2T+qmm+2O5
X-Gm-Gg: ASbGncsNqCZpu3vOcjGiJFCDvhS2TFFloKzRhJe27Ee2ndg55pwN3w2XM5iuN76K4cA
	60PJgDhaTsQIgFN+oWr0Rjd4FjFl9YHK/bKDvcoNGisL7WDtxGgKDW7r2Z5zvdJoyUtO2xYs0Qo
	ZetjP8yaosc+4nAYZS2XdD2KNfvDSkPBJ45MV5holnAv4cy3s41XtGuMMSHH4/6lS5OCcYcUegt
	+kicoQ7CHgzsJSTsoCdEkpKE29DgaV2GDyzgnqvHJhcu5gFg1QwiNjhZUNv+FYgLGXnPKiezZys
	uCbhFBY6J8k/L4Hq0EHIUV8voM8A/iwi7S7hQKk6iySYMumL/Uzn72Nfep5LZcvHk2XTVcJO0TN
	R3xdLlJhQP1t/jnEfXcB5tCStSrf8XQfG70Gxl3gFTUU16oI54w1ZrAh++P3CDNGdBgPfaYEFO2
	kkhg3razfyVw==
X-Google-Smtp-Source: AGHT+IFGCLJUWo3N4XT+I8IjzXZtgHEUANo/wK8o2Lolvc42cLVpjc0r5BG2mr0HGI0H8HTs5kbH4w==
X-Received: by 2002:a05:6902:18cd:b0:e8b:9c25:d18d with SMTP id 3f1490d57ef6-e8b9c25d3ecmr7365251276.25.1752512016520;
        Mon, 14 Jul 2025 09:53:36 -0700 (PDT)
Received: from [192.168.1.237] (70-237-88-18.lightspeed.rlghnc.sbcglobal.net. [70.237.88.18])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7ae66a49sm3059048276.18.2025.07.14.09.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:53:36 -0700 (PDT)
Message-ID: <0969e176-b9c7-464d-8e97-cf5cd4a06347@gmail.com>
Date: Mon, 14 Jul 2025 12:53:35 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] bloom: enable bloom filter optimization for
 multiple pathspec elements in revision traversal
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: 502024330056@smail.nju.edu.cn, git@vger.kernel.org, gitster@pobox.com,
 toon@iotcl.com
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250712093517.17907-1-yldhome2d2@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250712093517.17907-1-yldhome2d2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/2025 5:35 AM, Lidong Yan wrote:

> The difference from v5 is:
>   - extract convert pathspec item to bloom_keyvec logic to
>     a separate function, which simplifies the prepare_to_use_bloom_filter()
>     function.
>   - fix few bugs in v5.

Thanks for making these changes. Including your fixed patch 5, this
version looks ready to me.

I wouldn't say "fix a few bugs" but instead "fix some compile-time
linting complaints when using DEVELOPER=1" to be clear that the
functionality hasn't changed but the code is cleaner.

Thanks,
-Stolee

