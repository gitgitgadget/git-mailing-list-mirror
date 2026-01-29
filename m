Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC1A239E7D
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685867; cv=none; b=HA9xme3Gm2xUDwoRLZM/tGnFLufIrWS4J1fWKLxVhzq97Nq0SFW/Q1XFaISOlFgXrARXa3Pgxomb0XBPlRG3mnrGbZPtBmb61ehbJG3wjbX62F3ADpUFLPT4lRGcTt15qBxQPfJBPTkr6VmuzeH/jAoraayw0BJL46C+pTvcdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685867; c=relaxed/simple;
	bh=hkYquxkLnRoZzQqhfF3gYQMGWC0H75Di4a9/rSgzW+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWvYOYXuaFl4/Hal9l+8FH5O0gmHgbMToMyuQNHbV176hXkDP9YqHEQ4eslNueXVHivKaCh4JJYyqZt+K908sj6NFlVuJG0PUD59Zn2YcyZd3t/UPr+G2hXJ6R0KixSM5i6XcGE15TByu4Cl+WQNLTKgxkPhLrDHerhBy92CmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZTMPMVt9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBxT5UsK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZTMPMVt9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBxT5UsK"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2AB307A00EF;
	Thu, 29 Jan 2026 06:24:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 29 Jan 2026 06:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769685863; x=1769772263; bh=MZcin3jgM5
	u6xabecfQ/ZIddI5r+EYRax0PtWw/TurQ=; b=ZTMPMVt9kGgWLxHaqAPqo7qj1N
	bUd0riiNthS0/TqEJAZshciQ7J3i9PBe3bMCcYjF6ovkKhNf7Z4tr+CvCbnPbInm
	6ePTRXJs1it0oFKFf0zDrPgHWcjfUzKlXDUqM7auiCm2OGgCXa53odK5RsMCdPE1
	eJoWwpgzkpyAFtQsAx0x2PpgK3hOJqYplclFPUIXYIU2Hn7DSFxkYc21tEXwstGy
	+h82qPZ+5b2bNX5nzvIk25zECgIO4KlKDwQ09wQXN2vbiB6JUnJjWHEsmQ5onp1M
	OV6+IyiG0Bdh5Izs6VoTOOqXS+J0n1QwATujQ2QwIT43mys0dOK4VP3bCwOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769685863; x=1769772263; bh=MZcin3jgM5u6xabecfQ/ZIddI5r+EYRax0P
	tWw/TurQ=; b=gBxT5UsKJj9wXKX9pXKq2M8GnarLudMGEGzuSOzUUkQxju+P3Rn
	+xbjfiGXmdFVkXxyvYpGrJT+X1LOO68GIszH1ksn6KrvCubE9aSaXDDDgJ9tqmSW
	u4tLlTgpwbr/BHWZ8eEdQRyfhEtLfVvPsyCKCzSjV/HF0/gYqsNw1TeoU1iyXKtH
	AqkzspXHWs3frmOAHK965Js8xzBGU7TMGafTJV3XhwVmt0J6FhFwTXuYYnuJnXq/
	fwczm7Ig1q9fIr4Aka4qJ5sUvAywkz3Yo8/s1c2BtHS1nh+tYcq1OCjOTkNRxv7/
	74suloBVDo87a5tlIlGCeph34/Dd+7g/uFw==
X-ME-Sender: <xms:Z0N7aQh_ahWDXvXLA-oagwYk-Ed192wjyU4ABSWtfuWQTgpBNmKHvA>
    <xme:Z0N7afDlbLAtRVEw9K8QV-P571VBMW8GiKRzF47vbYnV_1Mf70VryNIVIGrF1iDrj
    VXSWPUcfpbKzF1wvUl9ziZpeIQj24oTf9ndyk8HgC4E0UxXRnKvaw>
X-ME-Received: <xmr:Z0N7aVt9fEIsYcEvRujz-Q0ntJ7yv9Edfn4CI9YKSeXvKBbOzQzCDIswdfPBav-rBWkWFoIF-JL2gHC7WWLjnXc8e3gmGc2QZOGX2uUp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Z0N7acZqX8krZ-jXpPJXLXMb-Y3N_PjyROU58Ja2MnVePzqmN_JTmQ>
    <xmx:Z0N7aQXY3IOltVQKIE0JPT9DvY_Y5qdy_6nnXGO6xR3daCWvcFxKdg>
    <xmx:Z0N7aY5jUKf-GQxbmekqCO-Gq25nEfX8FFk9FqT7flqRLoWi5QTD2A>
    <xmx:Z0N7aTiqKD0M_ySM3pVflv9-xnOMrKo_z_TKAv99THnKNQQ3dDneqA>
    <xmx:Z0N7aYQqFI9Mqc9wJ06Y-yw2iM0r9whmhB_BEQuPltGo6GSBGYvsEQCP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 06:24:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a021cd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Jan 2026 11:24:21 +0000 (UTC)
Date: Thu, 29 Jan 2026 12:24:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] odb: store ODB source in `struct odb_transaction`
Message-ID: <aXtDYY0Ao24Mpgyb@pks.im>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260128234519.2721179-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128234519.2721179-2-jltobler@gmail.com>

On Wed, Jan 28, 2026 at 05:45:16PM -0600, Justin Tobler wrote:
> Each `struct odb_transaction` currently stores a reference to the
> `struct object_database`. Since transactions are handled per object
> source, instead store a reference to the source.

Makes sense.

> diff --git a/object-file.c b/object-file.c
> index e7e4c3348f..196509b252 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -728,7 +728,7 @@ static void prepare_loose_object_transaction(struct odb_transaction *transaction
>  	if (!transaction || transaction->objdir)
>  		return;
>  
> -	transaction->objdir = tmp_objdir_create(transaction->odb->repo, "bulk-fsync");
> +	transaction->objdir = tmp_objdir_create(transaction->source->odb->repo, "bulk-fsync");
>  	if (transaction->objdir)
>  		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
>  }

This makes me wonder whether we should first refactor the `tmp_objdir`
subsystem to receive a source instead of a repository as input.
Otherwise we "pretend" that the transaction is on the source level, but
we ultimately still end up creating the temporary directory in the
repository's object directory unconditionally.

It wouldn't really change anything right now as we only ever write
objects via the primary object source anyway, so the end result would be
the same. But it just feels like a good first step to me to fix this
conceptual inconsistency, and it shouldn't be too involved either as
`tmp_objdir_create()` only has three callsites.

Patrick
