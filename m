Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975221422A8
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882191; cv=none; b=jK74F0GCV4VZLUkuabUbY6vBRnI6ZDSP6GAUzVPGpc6rHep+CVTBf+TQAXMqJpRxHiQcAo9E+fGD0xKk02Mw2rWUU2xHtn2KM+X/kRFet3Fvy/263GeScO0LRS9tC0P0K2N1M4vkR4cvCDjRJh31UU4zIwXp+xfQJZDiPjbOEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882191; c=relaxed/simple;
	bh=LL1dllMyryLh6433lLXHP2VeTMLthORQ85wBrDKM1RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGCGGAvj2qMMaEwe5lANitrkYpFpt2tPEKQol07IpjAF8oh+7+OtahRuUbWfH5swhtvcuS1sNxwjfXwuPcoQ/ecEX4e+qUQi8eAAfRemY2DWfM6VSPD4YgmkzTrWSjFLTegpX8slr+hS/bjwyJd+UKrFc7ZZhBfZlqW2iO7RtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRHodipf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRHodipf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2163b0c09afso31533215ad.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 17:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733882188; x=1734486988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNtPyY0iAAyoUQRY1TxyNVkteA9wDQwiN1bu1UBcywE=;
        b=MRHodipfhY+K1uxq4PcNcd5mdA0sJ+r2eAhcwRPp73PYCU0KpoVDE74MGs5OhYJiTV
         OY+QY9YRDNj1I5l6zodbVkG5dZtdImAD4TCyz+s0q9Xjm0rnzbwykhTS9xamFL/JGURq
         ks/VI8zVowwD0nrR5fiMU+sXVXmu5hET0pKYF71QAprqlHqUZVvOPQqj7QCivH/AJf+E
         9Kdtk4EMaBwhQknz68koLlSez9JqkJvdIWxmHrXXzJRSr2Rl0Kn5Hk/B9R8Zk5Nq8Gqc
         qZjD1Vi8nh4tTKS1XnXq/wOhAaypeUAFXPyUFHzSGYuX6erMhSVj+422usYqzNPHWXYS
         AsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733882188; x=1734486988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNtPyY0iAAyoUQRY1TxyNVkteA9wDQwiN1bu1UBcywE=;
        b=i9LAXHGmXFZx2K4O/NlzWKdEQK/lFQF+Murh/Y6GL/yeUog0NZ7Y9OOyEPvE7PyF0N
         WPy+LFTmJJ38DfTHfsHosAN60Bj3ehebiI8fvkbgiV4if2VsHq4LhYU8egrcRkl11Qd9
         s1N08K4UNuwNkueZPbZIeLVuqon/WPJ9ZSqW3xXelHK+JoZXP8fcoE1JBHD8oC2BPuGm
         C8h6egOtGCF+anQeWl9PhYnJ8c15/SbhlWbKWaDDrapmNPIrsBiCYEasY0zSb4LB1K6Q
         ZtCzOLkPDFu03R2DcmdLx+D+BoOFdKkaZDz0mqLpuLM10SSvx/RbSFoSHCQlDAHi5D6g
         Mxbg==
X-Gm-Message-State: AOJu0YwAH/SKp47Oxn/zI3xL3twhn4vnI5cZDg8sBLfxnPnhqkzRmRMt
	Rb0E8F8p5QtW/SegcobAi1rTsaedCy9iRSzHbNjBRf5XpE5pKnkD
X-Gm-Gg: ASbGnct0ESAuY7vWeJPJu9xZ7Gzv2nt9LS1YzR9NXp4dycqiWk6yBMe6Zvklnn8aQtd
	jjKR0fXdxVTWAfAw1IUUHypnN6wC2GXmob9hWrUjyeKgPvHBWRGNmdxBMIjkaew2KYmsfQ4OSzP
	fPrzjZKjShW7aXbs8WQMbeFc9F7h+zKynAd/dlFo/TzI9t+YSAvywgsejlU1uriK5LWLXylYUex
	0WezK5g+kTRZfvIUbmuujWIwBdSoQtlNJ6Iw6znS1DpQA7N
X-Google-Smtp-Source: AGHT+IFo7l1BqC/k6HVKvebNKstKwSduYWpJW6ruwFsKKUBAhqrYClKuf2J0eCkBekXJK1EVhzh2Zw==
X-Received: by 2002:a17:902:cecc:b0:215:b058:289c with SMTP id d9443c01a7336-21778398452mr22059065ad.8.1733882187818;
        Tue, 10 Dec 2024 17:56:27 -0800 (PST)
Received: from localhost ([14.191.94.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21659e7b7eesm36873135ad.9.2024.12.10.17.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:56:27 -0800 (PST)
Date: Wed, 11 Dec 2024 08:56:24 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Roy Eldar <royeldar0@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 6/7] git-submodule.sh: improve variables readability
Message-ID: <Z1jxSJKl8nwGbYa5@danh.dev>
References: <20241209165009.40653-1-royeldar0@gmail.com>
 <20241210184442.10723-1-royeldar0@gmail.com>
 <20241210184442.10723-7-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210184442.10723-7-royeldar0@gmail.com>

On 2024-12-10 20:44:41+0200, Roy Eldar <royeldar0@gmail.com> wrote:
>  			;;
>  		--reference)
>  			case "$2" in '') usage ;; esac
> -			reference_path=$2
> +			reference="--reference=$2"
>  			shift
>  			;;
>  		--reference=*)
> -			reference_path="${1#--reference=}"
> +			reference="$1"

--reference takes a path to some repository,
(see also git-clone --reference),
thus it can have any characters, including but not limit to whitespace.
I think we need to discard this hunk!

-- 
Danh
