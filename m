Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0CC239E7F
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345435; cv=none; b=KixRAjxDidcatOIt1IeZSapRnf+jt4h5zu7ujBHtLnjJJm1vd6UViDWc3x38Tau5Pv4wcbygGWYjruXgdTwR7yoofmhVGJUxlorM9NopB69eUZVfPLMbFZ3wqqwlMekLGEAGdb+oexqy3hkobazKq3LMLN+x6Z5FVTABDCYzb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345435; c=relaxed/simple;
	bh=paGFxoIqsiyO8YOSnsDwTMWKHHD0/2Cza3V/mP5VU7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rz+4KXYlfJH5O1DHM2Fy8+wuuiDyhS0/bg9FB+cT8JawHQgrCjbfAG2Os5FCOTO+IT1+re9M2YlUM3c/VX0V+GN/ZpM3BbyEa6VRmUNLksK8kHIK49QeNZAD7GzLAPyeB38U79xZ/YSvCZVUUrWLFaJbS1DeIbL3xEiJpeq1wTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CRg8fjNY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CRg8fjNY"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-709233a8609so36897226d6.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754345433; x=1754950233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqRJwUF7WEPHcFYs3y8FiKk+XpvYmCdb/rxKXdn710U=;
        b=CRg8fjNYViQcziV3Fh5wn8bm4SPkaba/ZkWxkGdt14WfBDnZhxCWBrd8Xs0M1IG3rJ
         QvEcHpiyiZl4Mx0YxX7vqIra78mlJu0UTZi+g9tInyYmhUs+pff2gG8Wh0b5piF01cJ7
         LXaM78gsIoU3920AaURU35+UdY5z+fSCFeUNBH+rDTTYppJ0qc6PfWHOUf7RI+ue/mY/
         Y1/omiui6hgHPumiL38eFkNluhgLZMSsy9KfNTTLt+C5yKim4EFwPB5W6Il+htqOQoOx
         bZyxMqxYozRyq64wted8Tlt5tTEGJbGi5lIy54WHQr4lVzXhBJInb3/m/hChoKJkD0Pv
         BelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754345433; x=1754950233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqRJwUF7WEPHcFYs3y8FiKk+XpvYmCdb/rxKXdn710U=;
        b=lWFsVRJKyzOWXO5ovKT69jNL9ZRiOuDjbQl87XXw3+ErsPPfS8CcAS5QXybiR0uDZe
         GSPudBxBYJYo7PpsYtZ6basbJ6adO3XZCT0NzPhF8kx3mGCqQXRg1K5v2PK63ksBQpG0
         54tVJBDBV684Zvt9L2142LDE2yhjN/HjwCfR4aK8b6vk2AIa9DSEl1YsFHC9dtt8cgmC
         ihVdCW1odZbkgc4nIzoydaXikWpNUwLNaHU4BJ+6AYRaGqsQjx0pKD25m5ipDCggw+BH
         IltcAG1Mm7fjlupX9a7BTPC+fTi5VFCmDPMo0xnpAIPxvkr8e2wk5Pw5NYGxhYy2StAr
         0n6w==
X-Gm-Message-State: AOJu0YzJHbzUbREXdJPDT/4wlom7adgFNwu3FEIkwiVUoWfJGbDtrbnx
	OUbx+vtFkODd/f7VH4rv1SvH3Oy+cBaDc9BrxONTynXi/S035QJMVYPdGAqvI4uH+y6PuBhn2WN
	JKTD0
X-Gm-Gg: ASbGncstxgjb43/zqyWJBW/qlNXy6+8xntxWlhIXzDNQ8LfjZ8NcboC8RmqFmzlLY8V
	eWChlHPtc7o+EQuxvy/uDHLHxy3WU65KGzRed/2me2aRZmbbWuE05PSOWznE/NU/ZGiq72jPHTT
	IIMWndgFm/TwayO7ZAZAxy73AllW9JOEtXFyI5Byujd+12t7mrE3gDoulUxRdq0gAijUlp6wtq8
	X0YvHmZbMArM1/twyd67d4yR5TYGRIbYWYEqtvyXJ98WdyX3L1/kHqAdFT2Pej8I4jmjf6KJInm
	DPKyb0x6yZaI5ZGkAg33BPhrWV5Bj2Nag3lYFu3FIiKWDL+Fgf151uj/+OooX/OGH6OrpOf8O0R
	VSd36pyXZd8ojfghps64jgrTgA6xOTM8zMK92SfMjAHe1pDOniGcMtj3nJQkGKHeuirTcSg==
X-Google-Smtp-Source: AGHT+IGUUDsL4Apn4GFZ+FflfpA+/TCoIeEEEOjIlsEFZ7Fu8Dc6W3Ck/xfsTYkMt63l9TfxBOu1TQ==
X-Received: by 2002:a05:6e02:3289:b0:3e3:d252:c0b5 with SMTP id e9e14a558f8ab-3e41610bc90mr228320315ab.1.1754345422283;
        Mon, 04 Aug 2025 15:10:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50a55b8948asm3427897173.50.2025.08.04.15.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 15:10:21 -0700 (PDT)
Date: Mon, 4 Aug 2025 18:10:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/9] commit-graph: stop using `the_hash_algo`
Message-ID: <aJEvzR4wuve/9ltU@nand.local>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-7-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-7-850d626eb2e8@pks.im>

On Mon, Aug 04, 2025 at 10:17:23AM +0200, Patrick Steinhardt wrote:
> Stop using `the_hash_algo` as it implicitly relies on `the_repository`.
> Instead, we either use the hash algo provided via the context or, if
> there is no such hash algo, we use `the_repository` explicitly. Such
> uses will be removed in subsequent commits.

Seems reasonable, and the implementation looks straightforward to me,
however I wonder...

> @@ -129,6 +130,7 @@ struct repo_settings;
>   * prior to calling parse_commit_graph().
>   */
>  struct commit_graph *parse_commit_graph(struct repo_settings *s,
> +					const struct git_hash_algo *hash_algo,
>  					void *graph_map, size_t graph_size);

...does it make more sense to take a 'struct repository *' here instead
of passing both its settings and hash_algo separately? Is there a
scenario where we would want to parse a commit graph with a (settings,
hash_algo) pair that does not match that of any single repository?

Thanks,
Taylor
