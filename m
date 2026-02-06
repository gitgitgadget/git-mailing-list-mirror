Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199535E521
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388431; cv=none; b=eVvM8O5fPNf/NHskHNBTrd4QnD26kk9mTMupUzU/fM8USy6BvsUmWevvVnzg8Mi3/CkSKet9j8P17NSxPPQ3a4UbNsff6B+6GqQBUrC9HyzmLRVIDtKCGlCDxfs+e5ECHiH6WK7UeAaQih8+TGXupbHA+nojjPJCLt/VqE0Viu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388431; c=relaxed/simple;
	bh=6k7LQ+w8AYbeY40e3hMN7T4w7cuisHpix36U1ArB/hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWcuAGel2fDCBrjLgL0P4QB1aHmlY0S2V1IweL2LV8UcCfsv57n9B/r+Gpy5Tff2kwy5DDuwZKs7y/sv1n0zxvU266CTMMW4q/1lLyJ4VoYsBjgyh4rGY/hb7hVv51sxWbkXTyfnXL/q4GZTAkwM7klC83/pIVBUVsZPokaV3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HooE/Kk4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YMJsD94H; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HooE/Kk4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YMJsD94H"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD7687A0199;
	Fri,  6 Feb 2026 09:33:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 06 Feb 2026 09:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770388430; x=1770474830; bh=yRPwlRDDvT
	zD5kPbeMILJ8BRoBdoRp3p9zMfV+3UPPw=; b=HooE/Kk494i0g+OCKk8nEL0IB6
	XSS5WYxpeqKuudqLSELPMcADZ/Kbko4zH4179I+tjUQhFFKqcevO3SiFh9cWTBop
	UbAd/O00gLKn6EzFzBaMkgi7ozQPp+/JPr9IMUc5uqr6BP1Zr55pXcv/PtCeQMOX
	YdojdncW/IFex8mtSLXPmpJbtTc/PDj33AZDJv8jBud8V23qhTchKtgxxYs/btgv
	cZN7Qp88nfjCrcXc6YvluMEtCo3TD6MCdSJEL/zbByLzA6yMaBurTfIQc7F0bnV2
	eIFTXlqjF6Ddwp1vSN9vB27i4MyRzurhBZxTlOabCP2yXSI+Gosgl3LiOb5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770388430; x=1770474830; bh=yRPwlRDDvTzD5kPbeMILJ8BRoBdoRp3p9zM
	fV+3UPPw=; b=YMJsD94H9Al1DUJ6Bx5mqKdpm/7E653C5neiWg+yqwJ5xXOmlSm
	0RBsNDv9n5KUB39okkvPNlhEpyMOk3xNj/HXKRlrnsmET82zVdoQkn8/SxhtUgaA
	m9USfDARHjQQ29oAjxYRwrGU8YYOTRvv8308wQk6HV2WWSGQ82Jd4HwUCZLQWX1M
	JYGYwAaU63sFHf24dtJ6rAEiWDAuQDaJP9i/Vo1rzK2WSBTH1DICcJHKeE1FBhDm
	T0e2xhuOT5xNP4GO6ebrXD22Fh+4JFvDPk2UxssWpRsJUO+1oZv894Gc/OneIuUy
	mwqfOybcnomvRR9CUeQPYRm7g2yAcl4LTlg==
X-ME-Sender: <xms:zvuFaX6ZrXLQNSZFO40W0SFvtVws5s2iitDyhYW6lZZtUg3-6occJA>
    <xme:zvuFaT5PKPN_woQ0M2KZ5IgjTtfLw2VrB6UWLNNNWXCU7EDjM19fMNhnC_bRHqvlx
    MaUJgDlwVEfez6D4qQYq5VyG5_V3Hs82Z29qUxwoH--mXTUv8B9tw>
X-ME-Received: <xmr:zvuFaTd_bf41Id6sZkcHd5BtXg3ToxWcO_lfZMtnh527AXOWVSQ4YOSZ68nZ7Q-_XKDh2MJQYfL8ddaT6tezkKUGeRbijbqKCMRVxui8O5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:zvuFaXCivobf2wCo8ANSy_ImsUt7BxB67NzPbWGFP0jN07R855_FCQ>
    <xmx:zvuFaW__nDEiS3wF9Cj99IMSbokYfHFix4NGzBvCRJLbvGbc4AytYQ>
    <xmx:zvuFaSLKQDiXqOiSkgpbZMvbbPUw9JvU4e-EqakusrwSrnRB1djhYA>
    <xmx:zvuFafivc4SV3_pCmhIf7saf1UujmunqWF7pSnkxY_SCkSScYY70ew>
    <xmx:zvuFaQc_o1hmTU8zWi6PzBtlQNlEYor3vcP09zv_ktAjSmmWcj7_If22>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 09:33:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d134e6a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 14:33:48 +0000 (UTC)
Date: Fri, 6 Feb 2026 15:33:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 4/4] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
Message-ID: <aYX7yZofAhc3xYkm@pks.im>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-4-3b30430411e3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-kn-alternate-ref-dir-v4-4-3b30430411e3@gmail.com>

On Mon, Feb 02, 2026 at 01:26:33PM +0100, Karthik Nayak wrote:
> Git allows setting a different object directory via
> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references. In
> the previous commit we extended the 'extensions.refStorage' config to
> also support an URI input for reference backend with location.
> 
> Let's also add a new environment variable 'GIT_REFERENCE_BACKEND' that
> takes in the same input as the config variable. Having an environment
> variable allows us to modify the reference backend and location on the
> fly for individual git commands.

s/git/Git/

> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index ce099e78b8..ed3191e8f6 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -584,6 +584,11 @@ double-quotes and respecting backslash escapes. E.g., the value
>  	repositories will be set to this value. The default is "files".
>  	See `--ref-format` in linkgit:git-init[1].
>  
> +`GIT_REFERENCE_BACKEND`::
> +    Specify which reference backend to be used along with its URI.
> +    See `extensions.refStorage` option in linkgit:git-config[1] for more
> +    description. Overrides the config variable when used.

"for more description" reads a bit weird. How about "for more details"
instead?

Patrick
