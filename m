Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF34143748
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237358; cv=none; b=AixDMEFb9P/1YWHKCY3LrPc4oL8DgcwgnjWmnAzij7Zfcb0sDuju4/W2BMLWdA0q8xjEc933e1LLRB44DkcPx7u/0/5y1l1AWElOEbGgR/mQQXBOm+rjgzYLFUoi9mdFndkv0g0HcLbD+F01o1md5xB/zZLYOxbSOFveKUZEDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237358; c=relaxed/simple;
	bh=cTljCD3yBh1qbpl/tbvLMRfqDl0e0qPcURlIQs3fRhE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIwZMu3NQKhsa/6j7rxTCrTzjTz1n54XEI8j6fsghUs98MZdHXw1AN/Ew0/M60usHv4Cv0hcKwZAkXEwgyXoQwTREEx4a4QyjsioCRRwj4NDlU9y7qgfJXcCK8Y4JX5juzJTMCp6uOTwLHvgdzqvNRqAeXmVT1UAppcHgXz8D/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtp+U3ut; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtp+U3ut"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225489a0ae6so13425ad.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742237356; x=1742842156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VPLkkd66LuHl9bDve/ITvpG9oAjR6YWTZoW8zRQ8x6Q=;
        b=dtp+U3ut81IUzKLbbDg56HaLM4FtnUPsxQ/GNBDmqm7olBYhrp5/SUoo1KF58NTEwE
         eqQQDdjtT1b88/BG7exw6ajIPnPhXQMYtluow2BlPltspYhGzqV20peL2HBESHTON9l+
         uA+x1HsoTnUtKfi/61ecoEHqzaBZlntNar0TADfbBIEjagu8OubBfw8Z8bHnQvHc52DV
         VF0hyK3GA5w3i8sUtD7q8odHJDEgK7gU8PaFwxyzyitC3ip4sODbEuboXyOMjlQiW42K
         b+cLGE4A6qyJo4nZ2bROGdXhpjzN/PHheFbR+fRHwMB8K5RoPQhVOKPg/jnWn73DBiQx
         x94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237356; x=1742842156;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPLkkd66LuHl9bDve/ITvpG9oAjR6YWTZoW8zRQ8x6Q=;
        b=vXd3mbXnUeUNLG1ur9uZytHBDi3Rdmd/uGaJaK1gjPEJ9XlDIEjgOiqYgDE87pmU7Z
         lnprxcd0Y9mN1Pdv95kr/PSz1ezv6KO27LJf3GNE9Y+K1EBihxcPlrDYMTube3itL5h/
         FdzpEYoyAy6sLevIkM99nlOQwalAfRCZYWIQEAGUTbwkuUUyWLU3ikKnnXOa8rrN6MIH
         Geax2IC/+IfNxjuFHyAJq+aIUHPeAY66RDJrD0rR+tC03KMV/e0QwBrnkGLhsTMMH1QZ
         nX2Z1SdULnS4kOYOaWWmJ1f2VjzFhf5hqTBwT129/Hq1NW43gPdyTmXtZm6S+W89rFmv
         FknA==
X-Forwarded-Encrypted: i=1; AJvYcCX/rfm9v2IXcVtSfB1noMmr+0AefSpiXGO7xBT6cCUK5cXfy78GQJw1B12R/beY0B5wR2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3RnLSBZXYq4ehqT8SllkiE6oC0Xg/A5FoZojIez8Rj2T4cwa
	s+3LMVuyfFs+enRzNeTN1bltq1b7x6Y0O501How8MeSnDuMnVFPMgbEXD3xOm/I3r7SnbT/wJGl
	xnw==
X-Gm-Gg: ASbGncu/bZhXKd4KODfSEmExgLpU9npnfS1F+IRWSeyON1YIXXbTxHJZCiQNLXUK4UW
	4tAevio/lgWIWiHoe+/hnpi3ujF0Z5BaFg5sq1kI3HpwAC9DVBbUjDfSl5FxJyxj/77Sq7akqKR
	q3s2k+FK1TKMtIwIU9dlcZ4zykAAdU5Lf0m72J9ujB8i+TSEzEVEwTGQh6KXDIo7dN7Qp02oCHi
	aUaVGUVUwmC1qKr/xsYzm17VL7O39v9ndUAZZn92TH1umaLFh0V2v+MBRlmCi5x9CRLyuk6K00Q
	296ph2QdpkwgScmQlG7umKvmxeGdHWCrKz/dtargUOE=
X-Google-Smtp-Source: AGHT+IFZprYx9OWlVk2BcS6lsxTCmtb+RuJ/etMf4pA9UeDhNS8JVyfth/OXatHzBflyT/pGuvNADA==
X-Received: by 2002:a17:903:234c:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-2262e648ca8mr287145ad.20.1742237355639;
        Mon, 17 Mar 2025 11:49:15 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:6174:6afd:698d:3dc1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301535a53f1sm6631811a91.1.2025.03.17.11.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:49:14 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:49:09 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	git-packagers@googlegroups.com, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Problems publishing Rust crates (was: [ANNOUNCE] Git v2.49.0)
Message-ID: <y53krdpxppjsc7qnua6otf7e7vx5yxhiyzilacie5a6vsle3s4@qhvmyqyf63jq>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, git-packagers@googlegroups.com, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
References: <xmqqfrjfilc8.fsf@gitster.g>
 <4zi3re4viluih7qwvwlu7mp3j6e6gjexz2bppa5am45nnqkezz@7vtwmyrfdwvi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4zi3re4viluih7qwvwlu7mp3j6e6gjexz2bppa5am45nnqkezz@7vtwmyrfdwvi>

On 2025.03.14 12:43, Josh Steadmon wrote:
> On 2025.03.14 10:16, Junio C Hamano wrote:
> >  * Foreign language interface for Rust into our code base has been added.
> 
> Unfortunately, I've run into problems publishing the new crates to
> crates.io. Specifically, the build process for `cargo publish` is
> different from `cargo build` in that the root of the repository is not
> included, and therefore our build.rs scripts cannot find the top-level
> Makefile or any of the Git sources outside of `contrib/libgit-*`.
> 
> To prevent squatters from stealing the libgit* crate names, I've
> published placeholder crates, which we can replace once we've fixed the
> build issues.

I have some pre-RFC-quality fixes for this. I'll need to split them up
into logical changes, add some explanation and discuss alternatives
considered, etc. I should be able to send them to the list sometime
tomorrow.
