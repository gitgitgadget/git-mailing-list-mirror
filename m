Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4225A2C8
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760179785; cv=none; b=D1jMTGiykSjdxxh4CKeGSklUaG9+znsYAkcTrUHOvgK+IkZKTTrdEjptvufv0774Xoc2LLa6FADi6yNqIc3MlmmxsxVuTP+BjRoWisN6ibzjbKS2KIFqtaD5kYlKc6yYsqEulxNkbu1XuIqzHLL7PI7Rn2bw8fgb0JCkJgJFxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760179785; c=relaxed/simple;
	bh=oL0Go1vl5EhTJ+Uf64c8JJx2AYaecrBRfr7EMTOHHww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTrScsLjlX4z/boijlQeS3/DbODKfCmveHff4p8yCO0Ibolsf70n1eLyJLSxVLcSBD0ON7zG/mqGox6Xj5tSYKDOx8/6M5cXm8SepLXkIGqkVIiP19y8oSqvX5WmkLxWv64wOoAofjlWZvRukWHVh4csLWedGcNmqzKbS8UqMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NbcDgUpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x6XhekOZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NbcDgUpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x6XhekOZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3161DEC0096;
	Sat, 11 Oct 2025 06:49:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 11 Oct 2025 06:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760179778; x=1760266178; bh=r4SA2C0U6i
	29jLARqFTVhtQj36VnzRokk0K/PQVUbeU=; b=NbcDgUpBBZoxokMu+B21w/KDy2
	BbvFTlCFpeKxP4I20DDXnQLj3LHpPuxpGOfQhKgG+JEoq37mq3/KzFUGb2S1GDtM
	JlNKJdm8cfHJU/sYF60exR3MRlGqQqTiqWSCxbGjCOfyw7rfAt/uLJiyfLQ+tFZw
	6p7wNGf7zB3KtdI6G/F7qmFjGkdvfUGQPYi1Num7+oXxJ2v24AxITZcGgg5wGuPB
	5HGy20f2di/eG35tTWYyl95TvtuKjUmRozt4YFPkRTk+vp3TBnWMlykDGt7xDb04
	AOA5k1XANVws/1CjThmX0XeEC3rKk1BVka7tGdLPoIbeorKRe2DTbYm7tdNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760179778; x=1760266178; bh=r4SA2C0U6i29jLARqFTVhtQj36VnzRokk0K
	/PQVUbeU=; b=x6XhekOZbpjVEWf58CtPABf/rhwBHC6BcpMbfbb75ODArwwt2ax
	0l2y7Z4GCCWypWaPKeOkLTaIJW0xiK1UgiEZeYuhhKT/fS5hFztCUT0fLcZq+yTE
	5FqYWa6K+fB0lkqGsLpBxVWYj1zNsJJxOKsTl3NUcufIVuow4XwW8FT2yBjgvAVo
	C1+9e2fI+ERjFlHKkvzSYTY9rIkFJ6mH/8iriDbap2YhdDXtZPSr6ZD0maXROzNR
	SYMhwotax7hf9aglCuHmAjj0iexKcsqG9keHDBBsocWNeWfmosO19oQse9mZ4cfX
	Xy+dpi+NAUoNRtE5XuKtDJMSbKnayP2ZJ1w==
X-ME-Sender: <xms:QTbqaJxHgszuldAkBSgvilBUoUlCUTiKd53bPz-0tDFRkzXNmQPKEQ>
    <xme:QTbqaAudcB1MG0cGkzbeT3IwXbiSf5LryFcK5UanqqRIoqGfAs7x57fP8_Gr1Rnr7
    vcs2XjAN2IDh-F2Sd0kYkMgSX8lDWdsbi0puPknPARw4c4NvXRx>
X-ME-Received: <xmr:QTbqaAvIrDoU9BiMaai-PIQEkqyHNPDtQFIR5oHEHxrSAggotUh7Z8UojNU712ozrINBCXOhOnIVBO3zeH4l4PjyOuKpGQImRrW8cl3x0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudduieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgt
    hhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:QTbqaFOSORQU6Y_sMa9gAM8IKSWYSjKI9NfqD70dTH1qAqCb_unKXQ>
    <xmx:QTbqaO1a355bqNuKV7pBbY621-oD112ycDJxsJ6_9RINnyJPnGxsMg>
    <xmx:QTbqaBMm2LN5z74XPtfcVWXFSpCtsloKxUDXlbE5k0rHob5IGEnwqQ>
    <xmx:QTbqaO1RlMaA6RVIFjaC7Mr_GFHAuY2IUIp6dakdZ4c6Y-VIsfqbPw>
    <xmx:QjbqaJPW6BA1efuX9aTFyGlkgPPOpN0FElKE5yT0ZFhDGObJJE5jY01k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 06:49:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4422008 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sat, 11 Oct 2025 10:49:35 +0000 (UTC)
Date: Sat, 11 Oct 2025 12:49:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] refs: forbid clang to complain about unreachable code
Message-ID: <aOo2Os8Q0X3WaLM0@pks.im>
References: <pull.1984.git.1759995982220.gitgitgadget@gmail.com>
 <aOia55_sjFQjw1UQ@pks.im>
 <2346bcc7-b60e-0ad6-14fe-c0b49e427921@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2346bcc7-b60e-0ad6-14fe-c0b49e427921@gmx.de>

On Fri, Oct 10, 2025 at 03:49:37PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Fri, 10 Oct 2025, Patrick Steinhardt wrote:
> 
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index bb2bec3807..cb402a2a54 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -2115,7 +2115,7 @@ static int commit_ref_update(struct files_ref_store *refs,
> >  }
> >  
> >  #ifdef NO_SYMLINK_HEAD
> > -#define create_ref_symlink(a, b) (-1)
> > +#define create_ref_symlink(a, b) NOT_CONSTANT(-1)
> >  #else
> >  static int create_ref_symlink(struct ref_lock *lock, const char *target)
> >  {
> 
> While this is correct, and "closer to the root", in my experience it is
> better to have work-arounds closer to where the symptom appears. In this
> case, it would be directly in the condition of the `if ()` construct.
> Therefore, I would prefer to keep the proposed patch as-is.

As said, I don't feel strongly about it, so this is totally fine with
me. Thanks!

Patrick
