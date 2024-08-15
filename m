Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7F15CB
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683587; cv=none; b=GklKHCJhm00VdUsJAuXDdLgbjqTnAJo5zqVlSSwS8dVyoV9/Ly16A9+7ideXibjJeOUtXt2TkCyzANAYrhGejQq7t6dqZgb2M87yReZ0RB4NvWMwELQdSR4guWO0QusWondJMInIfAOk4U8JY8llAt8PMgJVpWbM6wlU9+6nVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683587; c=relaxed/simple;
	bh=uFM7NLhRgw7vE+HHhZHlLd0JXmhgAjF6Kjv0py6AMoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVelUgvlB4fmQPYGc0bn5xBBANU7RtUbbjosWP17K3nZqBpwZFw7cnFQPq6ClItFluIAPBUJyZ3vyBs8H2U5EiUEVBIRz38+w9oNHEdzuj/RSaS8KB+3tqtMade9pE9jPBjfPjH139k0aOimF4PJV4Wj0z+3lq4PK+R0LhmARYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJTQD3dc; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJTQD3dc"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db157cb959so285703b6e.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 17:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723683585; x=1724288385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IjyaNrzWdPmWjUCPO/tf11UZ/6x28ja6wfGoX91IEFw=;
        b=QJTQD3dcJkdxbammSUHPNW5a2rKFUqAWFMG3+k2PRvPnhsW+6uW7I6cJTxSI5NDUXb
         ZKWdYeq0ad9/s6Q6MmcseJjzuqhT70pxCvyYXGLvC8QxrFaVfNbvsKEOZmZx5XShzkj5
         ZKg6cdfCjGnu3GioT49oATZV8sVmtvaxaruqYXvJkv+JyuKphu3g28T0Atde4N53NVS0
         mbLsUrMjsajM+lUf6LaQp7d0KnWXldahzhRYvnTspsggpbl0VZtvoPOwN+aXpsYJOlyX
         lixlY2KwqoAIQKqyzCdy0gbIqv/RyiGYRkPrJy8zL5l4TXUvkQQMuPRBNIdlSnuL0Uvf
         2Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723683585; x=1724288385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjyaNrzWdPmWjUCPO/tf11UZ/6x28ja6wfGoX91IEFw=;
        b=qAtscbRX2+U4QFkB5eiRkpIgvRTNvtuY8R2AwFO7vqQ4ckiM39l0kFak2MVA2ej9oO
         110Sk9zjxKpUlqw1XDIL6kkvm0m5poxqun9oGFXM1FIoUyHOzu06bLHLt+aukGMQcPYS
         IEISAvtxZwq95qQAi1u9Z8BJDEHgA0rOiR50xiFcPj8FqM6c3Gq0tipZ8P8w8Ir7hYT9
         LzHU14lKDwKs3u2kHYrYWAQSlfdUOFOQEuYRShPIwlNWEgE/rO/A+jwUUzgXigTNTIcO
         Dc40j4TkRYguz6jepjNZcU+ILNa/Tw4buRkH80GJ4ilmFRnsdeAvjHJS8OqNTXvP06WW
         dQ8A==
X-Gm-Message-State: AOJu0Yzzvcq0vxU1RpYisKlunyXYOLpAQ9EF3dCPLQFP9SMu0SrNkcMl
	v1Xn+Wdy5SgswH7mRKxzsdTqe6DbitSDH7tMkXgECw2gZ1dVpTqXuSgHvQ==
X-Google-Smtp-Source: AGHT+IFabgSnwT2KffglXDOhqpGHOP7VHVnbonxs2xI1fXky85BpwHFcXF8IgxwsTew1VJMff/NSoQ==
X-Received: by 2002:a05:6808:2118:b0:3d9:e1fd:5660 with SMTP id 5614622812f47-3dd299621famr4534141b6e.31.1723683585045;
        Wed, 14 Aug 2024 17:59:45 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33ef4247sm83259b6e.47.2024.08.14.17.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:59:44 -0700 (PDT)
Date: Wed, 14 Aug 2024 19:58:56 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/20] Stop using `the_repository` in "config.c"
Message-ID: <doivvzjzsrxngrafcywfxbs355epthuxdu5x3kxe2mvwnzgpf5@pgotr3bbyb4u>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

On 24/08/13 11:13AM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that drops the dependency
> on `the_repository` in both "path.c" and "config.c".
> 
> Changes compared to v1:
> 
>   - Various typo fixes in commit messages.
> 
>   - Rename `strbuf_git_common_pathv()` to `repo_common_pathv()`.
> 
>   - Reorder arguments of `strbuf_edit_interactively()` such that the
>     `struct repository` gets passed as first argument.
> 
>   - Document behaviour of `worktree_git_path()` when no worktree is
>     given.
> 
>   - Wrap some overly long lines.
> 
> Thanks!

After reviewing the changes in this version, the series looks good to
me! Thanks :)

-Justin
