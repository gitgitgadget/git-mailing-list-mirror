Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C482D0625
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313062; cv=none; b=YShRl/P7Rj1YJ3Lx/kKEGFs3SZYykWsoRl8rz7mOP3OXl6sjz3eiJJUTKFJUfAmfcgnUOEstGJs0qBuGnvWitqmJt8bpZ3ARZU2CjbJLrLHYMdI1kdcQnZjFlTNflP8eO+OyfNOJkd4SN+rZlLP+9b6cyNpeWcPLbAJ+4Tiou0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313062; c=relaxed/simple;
	bh=hGeUVbZ9FOz7DLNx6i5bl2Acf/S2yAwyNOn7wtKbSE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuJewrmACk1+ytkbIEKqumwuodnbM/jwAgUMBmkBsI9J9CQbsfBul6LCUmWuPu7nLRXT2gkkPRnPir5f8Fko9YW+7JcATBzck5uY6mW5pfbYwjVk+eu5tLTOSFnfYcebk/NNhJxPwIwLX2GdCK316V5TCcBimV/JCEAG+cfh03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZfR9mh6c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bpcDh/4e; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZfR9mh6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bpcDh/4e"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E7F21D00350;
	Tue, 17 Feb 2026 02:24:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 17 Feb 2026 02:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771313060; x=1771399460; bh=Qtjs7kvmYJ
	FEmbBCpE5g+UPO9uGjFUkk66STyvVKjk8=; b=ZfR9mh6cPhDa1s9lmrtpfA7eqF
	QjJFPU+N5mrPlORhgsGQZ8DvKj4BUKRlR43/zYt9lk9+k7e0S2meqbNslz4tV7v1
	rJZ65Pj9T6HpeCaYaHn9phO2Bg04ooqTYCyzyw/jAc2uMGXIuoNII3qqvFPmEWE3
	Nl4Z8OMIl0B1LXUIJqNk6zE3+Fy4b7ijT8VYOjIoCVEHLzqErI7wvGqQgGQWLan2
	E/ykQ9kOUwT+iORKaM/HT0LLwxznq1cj/uTdtrPEeSsDyw798YdsplAYDUmN5McG
	uKMbfjYvVFHOc+ozQ74xsx9VM0sQ/D53/Q9dSwCxMGGN9JmhgDRr63mqOgPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771313060; x=1771399460; bh=Qtjs7kvmYJFEmbBCpE5g+UPO9uGjFUkk66S
	TyvVKjk8=; b=bpcDh/4eneI/BnAiwKdvZcoxZ6fJIhlSI5tMwi3yV8z6/A/cvJg
	DN2Jr/MM75p/sdTPmsr+dg1YZ/IIbghfNaNB5ciKqSgRqSr8JDFSRxgQhgzk+oXl
	A6RRMPazNJhyh/ke+tlwiTOS7+mW1j7wRxuDoiu9oauWeWpQCTAHjcn/XW+YawCr
	P2WvcjJajCHGTZShbYkXP2UxDuxo3kGrxT92e/SA/lxmUJd/sGeSobjMoMJt+mrO
	f/omXdLk0m35E6IwSefE1xbNTGVLCrlEWecXiJn9BjpUCG7W/EdSezIBm7ZLLYCk
	cdPDn72tbv3JKO07fR+yhza+UrzY8sRnffg==
X-ME-Sender: <xms:pBeUafiilSoUCPHUYOXIrFylfmJshw90o65hwJo9XM3gEZ8S8NxRqg>
    <xme:pBeUaTD070Gu8tAsCZsLn1HLoiylKhwConzOAVtHk3s0CyGufL57hFQ7q-LAi7RHL
    Hr_QbD2agbSZ2vcloeQS1Bbg6pFrZYATppVBijDkbV31TEACc9XSSI>
X-ME-Received: <xmr:pBeUaUEmuNKwldTa-ssNdL56ULWcZC2dLhodg_5atinfkakpzWY1jnov5qrhgtXERtLY5r-gyEIi6s719S-MDS_458bW5mWvXnzW77UdOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeludehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pBeUabK90qVBsBx-kMKlQ9I3fALauy2cEkiNMw5bUKSri3iVJpb4BQ>
    <xmx:pBeUaYnmgdpcgg3yYZi_uh9xVMJ51b8bLUOxqtsKLog6tXlNvULodg>
    <xmx:pBeUaTSMUGHgsNS1g_M8wReW0YdonGudNc0ssd7nMB5SjToRLJl4_A>
    <xmx:pBeUaaJ9Ha1hJKfBnJs6M3JSyvQ_txc09aSKZCvz2Q32e-M7iSqHug>
    <xmx:pBeUaXHg64dvn8vI_1I_hxxGLvTPOpXILTtJS45BxB2Z_7Wv7rUV2Gfo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 02:24:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b2e0d44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 07:24:18 +0000 (UTC)
Date: Tue, 17 Feb 2026 08:24:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v6 3/6] refs: receive and use the reference storage
 payload
Message-ID: <aZQXnwc_90cwPaZ6@pks.im>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-3-86a82c77cf59@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214-kn-alternate-ref-dir-v6-3-86a82c77cf59@gmail.com>

On Sat, Feb 14, 2026 at 11:34:16PM +0100, Karthik Nayak wrote:
> diff --git a/refs.c b/refs.c
> index 77b93d655b..11d028232b 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3425,3 +3426,40 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
>  		return "unknown failure";
>  	}
>  }
> +
> +void refs_compute_filesystem_location(const char *gitdir, const char *payload,
> +				      bool *is_worktree, struct strbuf *refdir,
> +				      struct strbuf *ref_common_dir)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
> +
> +	if (!payload) {
> +		/*
> +		 * We can use the 'gitdir' as the 'refdir' without appending the
> +		 * worktree path, as the 'gitdir' here is already the worktree
> +		 * path and is different from 'commondir' denoted by 'ref_common_dir'.
> +		 */
> +		strbuf_addstr(refdir, gitdir);
> +		return;
> +	}
> +
> +	if (!is_absolute_path(payload)) {
> +		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
> +		strbuf_realpath(ref_common_dir, sb.buf, 1);
> +	} else {
> +		strbuf_realpath(ref_common_dir, payload, 1);
> +	}
> +
> +	strbuf_addbuf(refdir, ref_common_dir);
> +
> +	if (*is_worktree) {
> +		const char *wt_id = strrchr(gitdir, '/');
> +		if (!wt_id)
> +			BUG("worktree path does not contain slash ");

There's a trailing space in the error message here.

Patrick
