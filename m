Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D22E9729
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860760; cv=none; b=hoo3yd748+xiL2fS5AQH+ltwUZGBmqFVEVle9xhQeC/Mm+AtaKy29qHfB4PJf4m55xvKd+5aeQhrI9ZSoaD7eHAp1yxxoaULOAnJOpHjNxgwflI5Nwb2S5FtQneG/L8tlpi5o9txeREhuPGkDtvMwNzgvP0y0l7rj/w024u5A3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860760; c=relaxed/simple;
	bh=gOp/oll8lRIGAaUHbGTwXiyDkxm4y9p4qOJzCWsQrAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McQjh5RcZn0taUsBC23SsSL+ykdv5JytSvMpNqc3QNJgbJJvhd3X31/wLUACBF7yy18rPkofRGLPm9rtmfinDiMMf+wL4aPb3U6a6YU3FqebLV7ALAVpmNwkTb+EHAo1Qb3+2N4ylEGFJhtPJSFf8hBUauqIXIHFN9EBeZsjL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtlSSc8p; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtlSSc8p"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46391f4c1f9so2483731b6e.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771860758; x=1772465558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0hRJX+voydgeydElKCIyhGq9fJBtaaJxeqzrfVv7qk=;
        b=BtlSSc8pp+4H3QtzlPtKxd+j7KJ+rmA7uynTbJaYxk/DCoIk3ftazYG2PmEKCOAK7g
         85lu/mEIx8nrfQQv0FHMKPJHKXKzthi7xiA0FsaYKalAFce9UEfpZePIodo4zbJlAY/k
         +GBhKkr5TksKRRNQXhdMavR83nDsoJ2edR7N8ubJ5FmO7C1oQaQKXwzC0Lb/I1hu/iVl
         5TyLUagi8tp8G7QcohuIGiZKf3fm1xEAGQZUc05xrV9gzWcu1PtkSzuqEj/WTMX6eGn3
         7EGOJajO9BPPmpvsvCAZZ/nTLffzxva7mjR4F7UA6ydqQnXkiKVP4adTQoiQ+L1k670Z
         EXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771860758; x=1772465558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0hRJX+voydgeydElKCIyhGq9fJBtaaJxeqzrfVv7qk=;
        b=nn7WAsClyhrmQxgmwv2RRYju8FocxJY62WehQQf9KOt2UxmaC6/8e7Hw8rOq0DdXPL
         riDY/g6GhTHSEZWvgfpJUYDJ8EWYjwOesCN+2uq6/81uWbF6tvQq300zEqQWS1kJHU80
         NUxbsZjZ0Ry2JHbRw6yLiZsWt4e6Vd1JEa7umM2EQVRdB2bYaOd+G5f1FeKKwqxndm7y
         DzziJWVF8h+JpuTjCPFoVowMYj+/cn489IocEhGpYwVGWMuZK70kSWTPaM21tHSQWLqo
         p4jsvezdTbVlkHqYRPrhMlRFMIQMf6gg8DMvrNvkSwK9HjFZvYTJ7AyJSA4P+QFrlyqH
         7R8g==
X-Gm-Message-State: AOJu0Yz0iZTtSzwCIskoiojPbenmK1/8kwgINOcHnef33zQ+crc1Xffg
	oAReOAWmO2qPpfIGYYwopOSRuYKFCj0+fYet72kWA6ICirKYmMWNWneY
X-Gm-Gg: AZuq6aIpLf+tc8AQcmE9iX3tPKMTPmr9XXt/mBH+YlZki8uYsJYUGkTdWo2NWU9cUdP
	qL1OQ5STXrNOW/JcvZ6ckQqC5EWy/CcVwmuM/8sTB+If8w+00fZoXmqOTHJbHk1Pe6oVpx4W3pt
	v0YTv0naaKriuhEOzRPNTLToITdtj8k1bW+aHwknS0a4UAcawhCRPuJcJ93SkxINWy+ymZcidO/
	lKI+nPUjWFahzsDikkUaMBo9am6gQuZloABssTUyrGwu6Wmf1ilLfhxw6yC25UbkYb4BHPM+jyt
	NURqiF1HCBPsY6QMoXYBqsXuyO3YUMLMxCBd4JFL8Jnog6w3u4NZetvhE2PClJzz8VQHeyocxjM
	5zyRA0MP3fIqWXqmoyB7YxPhnvkK7WoeHZoeaqKlNcHtOW4XN7BmGGE9CGvu+XazHEl8CpvwpEI
	cYNKUxQIQZ8uIZAfGh
X-Received: by 2002:a05:6808:2e47:b0:463:ab56:9ec5 with SMTP id 5614622812f47-4644618a552mr5582249b6e.16.1771860757668;
        Mon, 23 Feb 2026 07:32:37 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a013cddsm5162718b6e.8.2026.02.23.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:32:37 -0800 (PST)
Date: Mon, 23 Feb 2026 09:32:36 -0600
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	lucasseikioshiro@gmail.com
Subject: Re: [PATCH GSoC] repo: Remove unnecessary variable shadow
Message-ID: <aZxyju3B4NHp4c_t@denethor>
References: <20260223135248.127935-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223135248.127935-1-jayatheerthkulkarni2005@gmail.com>

On 26/02/23 07:22PM, K Jayatheerth wrote:
> Avoid redeclaring `entry` inside the conditional block, removing
> unnecessary variable shadowing and improving code clarity without
> changing behavior.
> 
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  builtin/repo.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 0ea045abc1..5540bd25d2 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -412,7 +412,6 @@ static void stats_table_print_structure(const struct stats_table *table)
>  		const char *unit = "";
>  
>  		if (entry) {
> -			struct stats_table_entry *entry = item->util;

Yup, this is indeed redundant. Thanks for cleaning up after me.

-Justin
