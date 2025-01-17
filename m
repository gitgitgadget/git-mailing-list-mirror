Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F61F942E
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106171; cv=none; b=kmtfLzuEjVkgYI518f+oVagSue3sQRZUb3HALGtcEdaCC7Xeq5DH2rwIG0T1M2pAbIIqN4rJCe4mUNbhOXMiy3vDVfE9JVsTWrTF/D1Vt0HTSv/mLT/KEwW/7caQkGjZTo+Sz15RB0r3x2s1CU3a3DNmX1hjNFiftz2qrC8yIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106171; c=relaxed/simple;
	bh=Mklt4tIkBFL39yXOlv30XtWHcYxQlzU2FtjC4HCGUQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK2RPwJX86G/YgH9dVV2hlndO6wZkkG05vDnAjVe6Rp0yZspiSfzwuArNvz1BLfW/rLI7enX9zmAKYbRs0yvnyPHegXrvBnapu8atS08tJXWAN7Km1TB4ugt8dUXS22Jj7Q2C1s1Chv69E+DGxenMmODIZLEFsMW/Jl+dJsNWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XZpdGQoY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rvqjusMl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XZpdGQoY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rvqjusMl"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id ADBDA13802C8;
	Fri, 17 Jan 2025 04:29:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 17 Jan 2025 04:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737106168; x=1737192568; bh=8HNrfE0U2t
	HqxuBgOWMO4aTtp54BGE+BHvTUbVRJSbU=; b=XZpdGQoYZLDCE884mD/E8/LwQo
	q1o0QjbFWnyl1eDWBrJTVz2VvgRcYlRWpK4oYfXCsu/+BHQnA3LCYUYZuzG5lDew
	bUNqSvJx0MlhoaZmCRQQW848togI/48vEOQECrP1OnceEX1JPbqFCxq4I1Khzert
	u/fNoxfO4kCV1s542do8GD9c+nfB3E5FMUwIi0/yMZeCYWOgVissAkFWhHsY0ygp
	bl2uojx5AzyqnC2P4hEQRWJChA1h2dlJkOf+ZiqaqlUL2BCMepgyc1m5lCR2uTOE
	nH4Jz7i3vrjfGUskz/tLaFo/kCwF9sz4Fuo1/4hOYh8NwkEsvjfKG6GLYR4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737106168; x=1737192568; bh=8HNrfE0U2tHqxuBgOWMO4aTtp54BGE+BHvT
	UbVRJSbU=; b=rvqjusMldy2T5iv6tA/pwEUX7wZoRPHcU22R68jw6V7C8AYEFF5
	ZmsfK+hMMaBveajFGi8iDBbWhjPXB/QJ9XSYjF1dnmg6zuqxmmh8j3YFQZO81YSC
	5h5Heqop79kjiKR5ro0hmKJQ0TEAoDutWVRlwVf2LYslDzQ16b46SUUDNmCAdSLp
	OILemB0mdEOsxihNPQPwMBiKXtTBg049ACyAckipnQkLxuCmdXfFEPREyepIOnGP
	/6Yi8n1qm3Ex6JUertvwYw1eL3qNeArZJSurQwyxVY1NvXW7QOfRO9gR0sAhl2wT
	r4ZqFVvoFGxHO8jJsn5qkJg1TH/86WZdrsg==
X-ME-Sender: <xms:-CKKZwiw8oWaQfi70vghsA0bGJDHtFZFcCgJJWzXz-PaOed1BwOiXw>
    <xme:-CKKZ5A_0pF2kNr_9wYVHwyPLVprIk62nw67emYaRC-5LDwGThAg_lOqceA-jzqdP
    lL9PFPN7s9j5824EA>
X-ME-Received: <xmr:-CKKZ4HIwGuwBVgr8hzXeEpIx8OuoO4S9dKUcWzeINCZlQzDZxG8FKW1z0UXtYGxXHBE_xieyVzwmlQkYPma1Eet0GIcdNyGskUF0DSuU4sgLQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:-CKKZxSxCA_d5xzY_en8npg5Fjmom6XedrS8VPH4lQwzYdcZShW4Fw>
    <xmx:-CKKZ9whfwgX5N1AWksGmc-z9TZmSSX5oGH_9fxRP2wvhl930-YiBQ>
    <xmx:-CKKZ_6uQ1a2m-YM7hez1ulVtuT4vmJeP53ZXUAEoz0SeYjswtGxLw>
    <xmx:-CKKZ6xHz5KsDaBuOBAHzwGk1YzUgiMl8yiQH0MESrknouqkMaGo7Q>
    <xmx:-CKKZ_ufCS_7K4bgdB5MaFyOqBPzim7FyyvMt9eqH_FjPt_Db1Rh6x8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:29:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb25c2e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:29:27 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:29:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, gitster@pobox.com
Subject: Re: [PATCH 1/3] refs: mark `ref_transaction_update_reflog()` as
 static
Message-ID: <Z4oi9i_EHLaPjk0g@pks.im>
References: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
 <20250117-461-corrupted-reftable-followup-v1-1-70ee605ae3fe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117-461-corrupted-reftable-followup-v1-1-70ee605ae3fe@gmail.com>

On Fri, Jan 17, 2025 at 08:59:12AM +0100, Karthik Nayak wrote:
> diff --git a/refs.h b/refs.h
> index a0cdd99250e8286b55808b697b0a94afac5d8319..09be47afbee51e99f4ae49588cd65596ccfcb07e 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -771,20 +771,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err);
>  
> -/*
> - * Similar to`ref_transaction_update`, but this function is only for adding
> - * a reflog update. Supports providing custom committer information. The index
> - * field can be utiltized to order updates as desired. When not used, the
> - * updates default to being ordered by refname.
> - */

Do we maybe want to move the comment over? The explanation of the index
field seems useful to me.

Patrick

> -int ref_transaction_update_reflog(struct ref_transaction *transaction,
> -				  const char *refname,
> -				  const struct object_id *new_oid,
> -				  const struct object_id *old_oid,
> -				  const char *committer_info, unsigned int flags,
> -				  const char *msg, unsigned int index,
> -				  struct strbuf *err);
> -
>  /*
>   * Add a reference creation to transaction. new_oid is the value that
>   * the reference should have after the update; it must not be
