Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE52DA766
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032226; cv=none; b=IuX5RYYsmLFC5mJhiKErbsV994GsKyqSw11/2J7IBXhJrbH/ky42M7oXqFHsHI3pL09i+61GHSiINIHTU3aP1g77241h9nMUXZBssC2Js8kpBBDlHYGx6OeToVA1dE1WV3rc69JVeqefGXfCwdqFlVqh3VyuJGPadEo+pQOJSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032226; c=relaxed/simple;
	bh=6OH6imfJrwSEMr6YOg1E3YKK3QqsegYzdAv48YleG/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GjDD7JGvP4mn2gHbEEvgzSplbFx4/EcTPzN7FgKS9gQyhAmY1RjYEbQy+zk5jD1ysvv6xgr7V30PnZVBaC3z2+6+bfgziIM+E6RMxARZvyGi3yHEaBjXcfEJSv9sazuSGytvH3wSGBE7DRx8MX2MRNBn33fQEnv8PB42x7f5E3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyHl9aQ8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyHl9aQ8"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b3220c39cffso2099432a12.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751032224; x=1751637024; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7uFESK934Ks7phf8+o3fwdSKSYbp/0aAVaKpyD/3JE=;
        b=EyHl9aQ8BqZ8PPRT5LoBxOXLcwev7HJLK1utie+jueFP8FFaSnAZSX98YPg1icRVTP
         460DhF1uE9ir8MgSzz4Xc0ctB+lEDa4Nx8lqfn3cSjAcW3CSAjxZis7fKJbydTeVAtVj
         3rAPHW40oWCJgWthqgjx2nBRffPhOo90YZy9oK/5t/gdiyq+8ffm6aK96Nfvy6YEUS5z
         JwaSXvIIJK85j8pnUbBZEtWcA7jwrQ5b6yKyW6QrzizBgEdYtAseHp3LPpZndga1MZWM
         Dj4B0+01g6TqWIICG9BtFmnoAhI3Xo17lDywxx6b6htARDaemoafsbGSRDcL9a8tqejb
         x/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751032224; x=1751637024;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d7uFESK934Ks7phf8+o3fwdSKSYbp/0aAVaKpyD/3JE=;
        b=O4VdrZcAZKjwXTMHVtcAN0oQh/wtL7jt1qy2axztY/OOXf2rjpGpY4Y9ug3QXV1LEw
         jwyMrhRDgZ9HfQX+7jzgOLoMgaEpoE+8J/cZF/0Nx9PN32tOBRWUHyy2cpVzc6Ov1N+R
         uA+IQ7pcxLibNaemySOxA9rDOLWYvddBvlWWDCKVvfUSGhhLT/0FbJhL3YjrBrG8JDh/
         7p86uTl4CqAmTlFLpiC+Hbfq2710EkfWcUSqHhekCHhf7aVifo8wA3kjZuG38qbNWuuN
         rkT47Et4+BhzPlGTMAGN4g2w89uAyg50lka7XV1W3J5hR/n3e9EM5W1H/aPCGWVWR/7Y
         aBzw==
X-Gm-Message-State: AOJu0YyQfA22/R+UBYafMZywUOn/Obv4m6VslU4iiV5kqT3XND4QtEFP
	Dw9QsIohWmkM0XQfof1VPZXnhtEjcIjmYd8FgUubgTozLTOhZua1X0mrLqGD5Q==
X-Gm-Gg: ASbGncsS1KZdUylZma9F84IoiySQ2fGWmR236rKPdLKeJvJQg3tlG5DWmpp9Gce8uYa
	Qe8YPKW9PPMT6BMNMrKLnmsJP8FiiT8H4za73321bxFA0SuAP2TTBSWD66Ii0HE4yuge8ottlB3
	lALx8EOWzlZMg86Yl9Tt/+OtWkzZsvYfShx/2BSnxWBeD4j6hMmtH+BXqEwgawp77kqlHb/ajNa
	r6A7JSqqOg4XvQorLMDmf/eouB4Mn2eZ9VVATjhhWmWG4xh7cPIsfdjD0f4DpcBhD/4XN4vcPA8
	HhNogfWnRy5nIKS5hEwHMti+dUjV3orlmm8sVQ42Zo3iuScH8fF5Y/asd+MAGjLiOhNqkoHVcSQ
	XMvucm5NTiQliUbXntCHZd4sXTOs=
X-Google-Smtp-Source: AGHT+IGBHA9f5tNCmYNxDGH90HN0Y0p9M24tzv9spbAy53QqDkLN2S1upqKn7v/SvpMsAPWJwHHYng==
X-Received: by 2002:a17:90b:5348:b0:311:f684:d3cd with SMTP id 98e67ed59e1d1-318c910a649mr6230311a91.12.1751032224099;
        Fri, 27 Jun 2025 06:50:24 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c8b52sm16203855ad.244.2025.06.27.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 06:50:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
In-Reply-To: <20250625125541.3048632-3-502024330056@smail.nju.edu.cn> (Lidong
	Yan's message of "Wed, 25 Jun 2025 20:55:41 +0800")
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
	<20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
Date: Fri, 27 Jun 2025 06:50:22 -0700
Message-ID: <xmqqy0td8fa9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> Remove `if (spec->nr > 1)` to enable bloom filter given multiple
> pathspec. Wrapped for loop around code in prepare_to_use_bloom_filter()
> to initialize each pathspec's struct bloom_keyvec. Add for loop
> in check_maybe_different_in_bloom_filter() to find if at least one
> pathspec's bloom_keyvec is contained in bloom filter.

Oy.  That's too dense enumeration but I suspect are all "what the
patch does" that can be read from the diff.  The first sentence
gives "why", which is excellent.

You'd need to check in forbid_bloom_filters() that none of the
pathspec items have magic (other than literal), not just the first
one, no?

Totally outside the topic, but I wonder if we can further optimize
by adding an early rejection using .nowildcard_len?  Instead of
allowing a wildcarded "dir/*" pathspec element from disabling the
Bloom filter altogether, we could say "dir/ is not possibly altered,
so there may be dir/A, dir/B, etc., in the directory, nothing that
would match dir/* wildcard would have been modified", couldn't we?

> diff --git a/revision.c b/revision.c
> index cf7dc3b3fa..8818f017f3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -675,8 +675,6 @@ static int forbid_bloom_filters(struct pathspec *spec)
>  {
>  	if (spec->has_wildcard)
>  		return 1;
> -	if (spec->nr > 1)
> -		return 1;
>  	if (spec->magic & ~PATHSPEC_LITERAL)
>  		return 1;
>  	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))

This last check only looks at the first item.  It used to be OK
because we didn't look at a pathspec with more than one element, but
now shouldn't we care?

Thanks.
