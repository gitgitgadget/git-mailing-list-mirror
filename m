Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E230B53A
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557604; cv=none; b=ndZUHcx4ceWIQQEAtEDq57tbJ/nm0AP/9MprJaBanlZqOxxJFPxQcB68PFhXU5DMASkPy4QH5ovCeQHmQvYk5LtjvQS275BPmaNIX3ErfpNcQWH7W+Az+TfRDLbIFrOdrnQnzzwSJkhzNUQEynCcORij0y3i4xfvRfjUYsY1+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557604; c=relaxed/simple;
	bh=XJjohJ+OSPn8PsOdTWVmS0zw6TbV5h3S6Its8dBUyms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjXh1Bka7++7Gkw33HNkdP5CFzLTUnwnN8e4qMu8BTOQtuqa0wqddzbPXA+fXZfev9GQ8Lm4ICIEA6qyScapgGeJvJV9FjSfuyLoeAKyKO3Rq7Tm3HcD8ycOHSW+rQEHL0r2+2r0r8oATKIkyPpRQcOupFhVLWvSYNZ+kYiXaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjXavDtz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjXavDtz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfbbdbaf3cso151372985a.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557602; x=1775162402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcOhsp/avk63DBWYI3EUSowje+yWyfwIvwCW0xEUumU=;
        b=RjXavDtzfg+PQDJ+VGUyXOkqh5tRiKvGrMp3VJErsuAkZWSTS52NNzX4JU7nRlVCMt
         SMXbB/PKPXElBQG1h4dPH3t/O/zYsbscWEyPNAXEX6ms+FbW0SRKokOqPn1vbaP/LRf5
         Y+ULFH1+xChF1QqmmuaMoqtANS4KuwOzDRNZJnmwfO8o3C7aJnwf/WoMisr8UnbOzu1r
         oEZ8pqXE8jMVNJYSZJOOWl8IrorXsd0+D/X6Un4UNi/J7dC1+sae8sMn6P1De7fa//uH
         u+oFoouXkFd5sann/qSCT2yLRpjpT0JZwXnkTgP359dIlCUlf7OXEqKYbt2ZYM8TBMFP
         cDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557602; x=1775162402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcOhsp/avk63DBWYI3EUSowje+yWyfwIvwCW0xEUumU=;
        b=D5W5JshN6Ltud3qnyyotz5DJoT00pJX9cHaVIB4uQBd14r/8rw9kYuQQrizI6fgBkk
         srCQfOF5xukJwegbutcye1E6ASAVWCy1JpYidudnPYsq/WdgbuxDCxibrVmFY6Q9kHfD
         AFs2jONe0wlZcN7tW2NAvALn4CJpMHu6C72B+ReGTfGMlEbaGadNdnfQwxhnoW1zKeNd
         0VZ3Fj3x+Ty8huqdQmOfYB2kXg3xlEOxpJXTyxCz6lhFSxXGzTffioq9M86QXJRkiqFR
         Xt8E7wKz4tuy5lGMUfHWA+Uz4gI43LbY0Y7s/Sui4oB0xu43VVo9DSd1yulJqW244d8s
         pmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSVLeQYem0PI0xUI4MXrEep6AJn7SVaWQ3HLm+Jc0zOjzrtkK/CpXMnQgBKq8EwlSjhRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jCB1OBLBoPFi/VxlBuM5y1bqZy/JdhC3qUuWXbBiOwbZKQFn
	UIAbpZeG4Jf486cl5owSv3fdPFEMxCiy0Ws2ESgX1alaZu7gA8dKcJhP9D1PVA==
X-Gm-Gg: ATEYQzwJ8dKgrHKOL/3DgXVBZXae2zRs2Tz1Ex8zH7MccsH7iZ2JO2xzJ89frG30Cq5
	YDWpiX8SdG43BIksoJ6zr72/ucPJ2p58mCHD9vgwiMLwaE+I+FV7meOSf8Beba0LI/KIjfyQwDP
	WZQKP31LEUdrDwBUiLbzBUJ9QvgdOHGSAjw8iP8m9Shjm3joTAaly+VNDOethE5g7sZoTUVs63g
	BXhGVbc6lA0W992gRjS1zqyKL2IbRD2Jh3RuKD3eoY9vOBSlJM+/LAvE4d5Y4SoUr2cnB6dF7ah
	qLXfz5RG8YcWze9382tBrRKvsM7VvMku4AMsjGktYFlK4DjJlntLf2Z8bp1qNQeVpJVTnToG3iK
	ajqkMlSRffJ48Utc17ijnzREEbe7NRf19RAxgLZL06z+b0Df5dYtFyZiDpPP9meE0a+63f8HFVU
	etdFxUg4IZfsQPfXzuKJ/eOD2XoHxT53qzs0yV5bS4Ffel3ptOWIi0zI15GdMJzsjQ5T4m1g==
X-Received: by 2002:a05:620a:1710:b0:8cd:9281:6be9 with SMTP id af79cd13be357-8d0140c9500mr368615885a.31.1774557601563;
        Thu, 26 Mar 2026 13:40:01 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm330453285a.36.2026.03.26.13.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 13:40:01 -0700 (PDT)
Message-ID: <9e320604-7367-4f48-a943-f7d22feb2672@gmail.com>
Date: Thu, 26 Mar 2026 16:40:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/2026 7:51 PM, Taylor Blau wrote:

> -static void read_packs_list_from_stdin(struct rev_info *revs)
> +struct stdin_pack_info {
> +	struct packed_git *p;
> +	enum {
> +		STDIN_PACK_INCLUDE = (1<<0),
> +		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
> +	} kind;
> +};

I kind of wish this enum wasn't anonymous. And it matters later.
Let's call this 'enum pack_input_kind' for now.

> +static void stdin_packs_read_input(struct rev_info *revs)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	struct string_list include_packs = STRING_LIST_INIT_DUP;
> -	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
> -	struct string_list_item *item = NULL;
> +	struct strmap packs = STRMAP_INIT;
>  	struct packed_git *p;
>  
>  	while (strbuf_getline(&buf, stdin) != EOF) {
> -		if (!buf.len)
> +		struct stdin_pack_info *info;
> +		const char *key = buf.buf;
> +
> +		if (!*key)
>  			continue;
> +		if (*key == '^')
> +			key++;...
>  		if (*buf.buf == '^')
> -			string_list_append(&exclude_packs, buf.buf + 1);
> +			info->kind |= STDIN_PACK_EXCLUDE_CLOSED;
>  		else
> -			string_list_append(&include_packs, buf.buf);
> +			info->kind |= STDIN_PACK_INCLUDE;
>  

It took me a while to figure out what was going on with checking
*key == '^' and later checking *buf.buf == '^'. We should probably
combine them to the same condition:

	const char *key = buf.buf;
	enum pack_input_kind kind = STDIN_PACK_INCLUDE;

	if (*key == '^') {
		key++;
		kind |= STDIN_PACK_EXCLUDE_CLOSED;
	}

	info = strmap_get(&packs, key);
	if (!info) {
		CALLOC_ARRAY(info, 1);
		strmap_put(&packs, key, info);
		info->kind = kind;
	}

	strbuf_reset(&buf);

This feels easier to read, for me.

>  		strbuf_reset(&buf);
>  	}
>  
> -	string_list_sort_u(&include_packs, 0);
> -	string_list_sort_u(&exclude_packs, 0);
> -
>  	repo_for_each_pack(the_repository, p) {
> -		const char *pack_name = pack_basename(p);
> +		struct stdin_pack_info *info;
>  
> -		if ((item = string_list_lookup(&include_packs, pack_name))) {
> +		info = strmap_get(&packs, pack_basename(p));
> +		if (!info)
> +			continue;
> +
> +		if (info->kind & STDIN_PACK_INCLUDE) {
...
>  		}

> +		if (info->kind & STDIN_PACK_EXCLUDE_CLOSED) {

This does help confirm that a pack could be in both categories, so
using flag bits helps.

Thanks,
-Stolee
