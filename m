Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F020C32C
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890325; cv=none; b=LnzkMysyWJuFVolsa58CzOQwWLV5jbvop5LPpGU0kb1JCpqG5DvgcbnikwzHYmgN2MtyKT37Enze4QEaJ6e2HeCPytW9YKG4ugnCUvimhIP79G1tH2dEKvD+LheUfFUdvIiEgo0HizUCo85Cx76+hoog1DqvqBk/OVj3NcQaROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890325; c=relaxed/simple;
	bh=U1Bup2IOCo1dxnjJCEz1id2H3vHZ9d3t1Hscj0Hq7NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNbzRTErS0DCNzfRYYkneojWFNhuls/8PtU3iACz7NK66uuXeYJ5GZ2HQSzqn1kOm/QITX+jO5dlWrtoKOnS/3yggFfAGhA2TpxA0cn0HcjcTS2mDPihrcqIFdi2D2d9tmsEpndg7gglfP9HSas7mkIGDaXA4U61UO9JyMnXpDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pIEjkyNn; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pIEjkyNn"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso2782526276.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729890322; x=1730495122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRTXLyYuu6Fed92fsJyBt7pfpmJgQbA+t15+peGFjJI=;
        b=pIEjkyNnNrthpj5VECWaKozBPH7hLYlTgRv2EeY+UjWVQmQwTjVNcUgMSpNAmMF+nY
         mVaBymC8GC4XE2Dx5NaJwzJlPmIJs52yfCiNrWBdowD+neVNktrqRTxWdULbwD4lqrcI
         PE1rnvjcfjDPLoyrtihofh/OPZY84NfTBOnj0XmC03L4/HSmE106UgWqeptoz5usYkhq
         kTGFVB6jE7ahOoIRcoLiAHxRJN++h16HNSwsdBrcQU4bPCXhZP26q9exPyXCiwhEMtSQ
         MpxRmrp38mpu0rszwszZPrEeH27POUlTcZGRYBDEx6C6NBAWhiTNCv6EABBJUK3WWQ8c
         Axiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729890322; x=1730495122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRTXLyYuu6Fed92fsJyBt7pfpmJgQbA+t15+peGFjJI=;
        b=NJ6jU1UdbJJLJKdMH6viyTvlSZ+v3y1/3urd07/u+FJGm+NH8iQS8tE/OxGZVQUcX+
         l1F/IFKTszx7r6XAXqZUACJtfxBjc/+CjZIInSU7/5579fJsLXHzCVonwNfpcjimX+xj
         Z0kkMxmOQ0hJil4B+yFC+XlgGLb2zTtpP/cmMbljX7LsNr2zfVSJ2JUSy7FCdW1GgN84
         5YNFkQo2qHukrjUnGzJgvsGB2QxPAenKPY7cBvghOssGULV88oHlPW722zezNdW9vQsE
         /ATeN1v3U7rjiYHNDQv+QP1L9pw+KYDaChs4Iw2De4o7KtQ3+SXetW4qxZwbJYhtdtfX
         nZeA==
X-Gm-Message-State: AOJu0YzQ3P7HPdlJYo4O/QIAHEKD3WBU2EFCg/JKw78OKM7HomdIev+Q
	aAlmqj8OjnS8F0hIXWDr7tOlXGzKCy4tlup7wcrzxrBCzjEwY1zv3wPODpLiH4M=
X-Google-Smtp-Source: AGHT+IEba9TOj8+AxwlMMTFUT/4iyidhxO/PocEARej1piCOBYNAeBsUiLa3C0Xemb6oIP4SXnOhKw==
X-Received: by 2002:a05:6902:2b87:b0:e29:10ff:bb6 with SMTP id 3f1490d57ef6-e3087b84388mr895903276.23.1729890322676;
        Fri, 25 Oct 2024 14:05:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a03bf55sm382832276.60.2024.10.25.14.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:05:22 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:05:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	shejialuo <shejialuo@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/5] Optionally link worktrees with relative paths
Message-ID: <ZxwIEcUKMELmxeMh@nand.local>
References: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>

On Fri, Oct 25, 2024 at 08:57:17PM +0000, Caleb White wrote:
> Caleb White (5):
>       worktree: refactor infer_backlink() to use strbuf*
>       worktree: support worktrees linked with relative paths
>       worktree: optionally link worktrees with relative paths
>       worktree: add test for path handling in linked worktrees
>       worktree: add `relativeWorktrees` extension

The previous round was already merged to 'master' a few days ago[1],
after merging it to 'next' and saying so in this[2] WC report.

I'm not sure if you intended to send this series as a follow-up to the
state that was already merged to 'master', or if you had intended to
send a new round of changes not knowing it had already been merged.

In either case, can you please send a new round based on the current tip
of 'master'?

Thanks,
Taylor

[1]: 8e08668322 (Merge branch 'cw/worktree-relative', 2024-10-22).
[2]: https://lore.kernel.org/git/ZxLI06smvMuf%2FcT2@nand.local/
