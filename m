Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235201DF265
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174727; cv=none; b=NRbvdl9AXFFo+10FZjNeGhSEAF/Zg/iCjY9jYz6Ao2olsKn6hy3ypE6ta5M1fAQ6qIgFQjiyaSHChvajoLmsLrOk5a5TZQF8V3YOyPAOrAnJL2wGKIAfewnLsYz6euBS4LSySL7KeFwdGJ9RqIcRV3Y5TWO++ZAzkIZn1nyBifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174727; c=relaxed/simple;
	bh=qRVbi7s6l69hLNFM8xbDp3vabZappHcXey6os7J2xBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKBidYxKSOXXZru4eoqPVgH9XIUvlUXr5VNqFYMi9B72nreEe+wVc9xpP8wr6uUnDCQs5L6Ik6G6Tt19U0Z3zl6JfuxzyH2A8I9cTQ5fz2T97aU3iuUpwdIkw7eNeWts/JHQMzadZ5bYK4y9cr7Qcimr5HE8QCc2Ukk6zdASfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6ojdQjw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6ojdQjw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215740b7fb8so12465ad.0
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733174725; x=1733779525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vP4QaKg1xQB2768JCmuVV/RfttPylLqQSy68PXMXvAQ=;
        b=f6ojdQjwVg6C1cUHPqfJwIjI14McQzNgON/PUztV6xJlrLD+YwzRU6fXwlPpvtMd92
         4j9iqPfMerSVtCFK+A4dHuxXsPUPvtyrXzAxczLaAnUEUA83a4cHDIfoWrOBRFk70yRz
         G9huqzMpnUlBzkmKSaBfrB2KkWYK3H8bI3/g4Tqer+q/iS2o+fnc3y4T18PK3VlaEdHt
         dg1rdpx0LlhoFbMBBp/fAYqy+9IWz9u6nK+6VQM0M+VWO6pxdyqXILM8Pkl7fKOnj/jj
         /5mVdTmLdA38ABWldsiJWqkmPePWxNnB1V6N+GEtTpUgBxcj66rXoEVMLblP/eSOUwM/
         hjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174725; x=1733779525;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vP4QaKg1xQB2768JCmuVV/RfttPylLqQSy68PXMXvAQ=;
        b=RFb2In6TluM+oWE9j3Zq9w9Jbus0zJMEuS3Pq7boZY9ydNKhl9PYUskLegKMoH+IDq
         SCBEU/qBNuy6hMjayMUHFDHsxpL525IXzaG5DEDtwqMkMkkC7ZOkx4gVTqUFNu8PAB9R
         5KyPi9bJMiny1bJrBo5RFhI3Fd0OMUejXrk7nestWuuLv9B4CrLw1b+77IYkvz9NQ/Aw
         iTBKdEJUrMSj6lJv6eQZbYGRioHR1neEvqqzcCDulxLqTBcqo6iki5OLa9PXhOjV2A34
         tF2Dm1H+R64etCRSPOXkDlqxH1klVAVFzZQitgr/tB2xeQFTR9UY1RX/9X0H6QdNkEgx
         dDaw==
X-Gm-Message-State: AOJu0Yz1Ch88bKAcTOTuopgAuvkHHUypGbuy9FkEBAfa+piF8zNE/0lu
	oU3OUEGmICcdbxoUWtc9yrII6EbVerYzKARamR7qAyOYlbaaA2RWsJNJx8C7Qw==
X-Gm-Gg: ASbGncvFpwrA3Pe3t9JMTvHOV5x0vyXRJ+cMxQ+fH835kJmpO6RdnfKujJhPAbrhHdo
	qvM4dL5zgVQ+jOPbqPoLlVVhGBJXpYChaob6YRf8IsG+Lq8T4qlPRxU5VLKP3a/g7LNqWN5zqP1
	8LdvufJz4+hq83DjkaDcM1snUp1x4tiz9tJC+/UeAUViVoB++7jit412GeAG4KXgtwbGNQAOHgH
	Cr8clsYvolvC+Li1ZeIS3oO2PxtOwv+FmNvnKMwUrkoSDA=
X-Google-Smtp-Source: AGHT+IESOlphigcKe8tkLUDbrhhtObP47m3ZHQ96sJ/hcOsdoK+dsr6MezcqWlXfxSxo9wCB0yiKgw==
X-Received: by 2002:a17:902:f64a:b0:215:98fd:cb04 with SMTP id d9443c01a7336-215bce9bdeemr68785ad.25.1733174725169;
        Mon, 02 Dec 2024 13:25:25 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:bc36:4054:556:4546])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee947d0398sm4271192a91.29.2024.12.02.13.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:25:24 -0800 (PST)
Date: Mon, 2 Dec 2024 13:25:20 -0800
From: Josh Steadmon <steadmon@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, hanyang.tony@bytedance.com
Subject: Re: [PATCH 0/3] Performance improvements for repacking non-promisor
 objects
Message-ID: <s6adlnfgts43vamiyzdjbjk7bqwy4gvudskclr76uunkgyktbp@pziio343f43z>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, hanyang.tony@bytedance.com
References: <cover.1733170252.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733170252.git.jonathantanmy@google.com>

On 2024.12.02 12:18, Jonathan Tan wrote:
> This is a follow-up to jt/repack-local-promisor [1] (but these patches
> are based on master, since that branch has already been merged).
> 
> These patches speed up a fetch that takes 7 hours to take under 3
> minutes. More details are in the commit messages, especially that of
> patch 1.
> 
> Thanks in advance to everyone who reviews. While review is going on,
> we'll also be testing these at $DAYJOB (I've tested it to work on one
> known big repo, but there may be others).
> 
> [1] https://lore.kernel.org/git/cover.1730491845.git.jonathantanmy@google.com/
> 
> Jonathan Tan (3):
>   index-pack: dedup first during outgoing link check
>   index-pack: no blobs during outgoing link check
>   index-pack: commit tree during outgoing link check
> 
>  builtin/index-pack.c | 49 +++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
> 
> -- 
> 2.47.0.338.g60cca15819-goog
> 
> 

This series looks good to me, thanks!

Reviewed-by: Josh Steadmon <steadmon@google.com>
