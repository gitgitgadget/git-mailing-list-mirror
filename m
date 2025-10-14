Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188625A64C
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462616; cv=none; b=hNFuMUT5RCr4ke9VlyHJzNL7wiPglA1i6IJxcHKUip/RNHLNY239Fk31v2csuTx2hWPbCcR/odCTU5iy0YrqHs5i+zt+/2ugEEzUDvrAiQFYMFZZ5ovazCWZfKWdM9g/r4qoxxmnNBdj7Gq057sWFQGcmvuQusf4AZJ9Xoor9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462616; c=relaxed/simple;
	bh=wBznVvaQfN+fGW+Dm0CgHU17J9s8Y9TSBiA/NfwYshI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fcd8yovN8K0P8zq+I3DOsWPrTShBYwG0hg2uYw73a875V7iS2PEN6GnvXl6QgoSPYfTkpoVu9vLz8fLn3Nb009QpEm+tRwZ9ud3GDEAZl7+gwW2CmZmb9Idw+hafsdbum00TxdxDe+2e8lJWfKpHL5NUAp+E2XQErGvMRIWboOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VUGCf/Hy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Olh/5C1l; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VUGCf/Hy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Olh/5C1l"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 99B351D00118;
	Tue, 14 Oct 2025 13:23:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 13:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760462613; x=1760549013; bh=yuZFBalQij
	qcRJatL2dDm0irXYlIHJ0P6dsFLZmkRv8=; b=VUGCf/HyKu4b4B1utwSNJ6Qrge
	BUgUVCDLr8ExDxufNN6gzLFEDOrotBXyG6d38Zk23wtlo1TrzcAqO+Kz4eiO3K9n
	xk+5nyuutR8EuhcvBKjgMX1xHDKWtZCQii8hJ+59FMrMSmTweyYSz2nNBI8HOhIA
	PPRqQLBeA8KDuBBb2JbVd+o6g0wfbH1G20bcqPRS5E56559fnmDaZa6ojW9/CFiA
	+hm3rMK2c0gJy0SOpIAZVP3EALnjQ/3a38u2L9Vdvk9KGZGkdueG84hx8Hr+a/HW
	z/qblytx6VW9YaF4RtIGER1gvWsOmaYjChbdtW8hRbjaiagU+zmPG+PeIMvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760462613; x=1760549013; bh=yuZFBalQijqcRJatL2dDm0irXYlIHJ0P6ds
	FLZmkRv8=; b=Olh/5C1lDBsddcEQ77JHjenajbBuWIg/UNaJwhnUDtS7GY3t0V/
	/AXdlh/Fm1UtOmOwRSMCQkgMIViKtSpvR6opFN5r+SW2kgpfVizn1QdgwqjTJATk
	Yw04bZP6hkDLI2z/NQNHLK2fPVCJzCz84K5PcVjk7a3LH04TfmfmdIYTZ5n+/tH/
	oBIyJ6d9AmzN9t6n4KOH8eNbttKiKWFIQ38ZkMoJmXoJcZwNgvxUgFRGLITvkLY6
	6Gl5YqHL7QfrTdCyL8uD1jHShoXesA1SozJm/75rJOiRgTtvd3q2guzxiH/MNVk1
	bUPQkgrZHZnNHB04wzF+PovDWyfMPgj5njg==
X-ME-Sender: <xms:FYfuaHcRMuFdqrKEPsZubim8FLGKdL1SFo0xvJsjZIBsIBpzJOOSzQ>
    <xme:FYfuaEMa5YzufE0JLXh8WptOrcDyY4m989aywUIHysc7YVlFWvayFCv9USMJ56pEq
    NANMBdfKIEhusTSquhQg1fz8fSPXt82BdJlzmRMv94nw17j9ZhcIw>
X-ME-Received: <xmr:FYfuaFhu0pCC-KKIOImm4ENH15c8hl1xFGgMEx_JFgJNq9iIwl9a4ZAEmz8RkAa7Auw6VqqKdrZzkzRa7fFTKFMP6sJIZjOSH7Wa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghh
    ihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:FYfuaH0Z_JrV8OZIo24qwIxN55uWux0Vw12qlz-Lb-iP3-VR2u_xfA>
    <xmx:FYfuaPhdug6nnL7fSyMNO5MbOIkzca7FGdiK61xWJuZz1hbIkfdogA>
    <xmx:FYfuaHcg_bSlsNpW2cpuBrpkHa4fFK-87S1-sJwGbKuZq40Ub9autQ>
    <xmx:FYfuaCnQkCInRhJsFcxU42yAmfL1E_URw07LzkFAlUHRnBzNQRtJtg>
    <xmx:FYfuaDe8tbhXH1rja4Oujr_aT5tdnl1JBmdehpZuX5iLSYdbDcavBYGp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 13:23:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] refs/files: deprecate writing symrefs as symbolic links
In-Reply-To: <20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im>
	(Patrick Steinhardt's message of "Tue, 14 Oct 2025 10:17:14 +0200")
References: <20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im>
Date: Tue, 14 Oct 2025 10:23:31 -0700
Message-ID: <xmqqplapxur0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +* Support for `core.preferSymlinkRefs=true` has been deprecated and will be
> +  removed in Git 3.0. If set, symbolic refs like "HEAD" would be written as
> +  symbolic links instead of as a plain file using the symref format.

The second sentence reads as if we are talking about a newly
introduced feature, but I cannot quite rephrase it to avoid that
impression myself.

> +Note that for now, only the writing side for such symbolic links is deprecated.
> +Reading such symbolic links is still supported for now.

Double "for now".  Let's start the above with "Note that only the ...".

> diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
> index 08739bb9d42..e9272bbc0bd 100644
> --- a/Documentation/config/core.adoc
> +++ b/Documentation/config/core.adoc
> @@ -290,6 +290,9 @@ core.preferSymlinkRefs::
>  	and other symbolic reference files, use symbolic links.
>  	This is sometimes needed to work with old scripts that
>  	expect HEAD to be a symbolic link.
> ++
> +This configuration is deprecated and will be removed in Git 3.0. Writing
> +symbolic links for symrefs will not be supported anymore.

Or spinning it a bit positively:

	Symbolic refs will always be written as textual symrefs.

> -#ifdef NO_SYMLINK_HEAD
> +#if defined(NO_SYMLINK_HEAD) || defined(WITH_BREAKING_CHANGES)
>  #define create_ref_symlink(a, b) (-1)

Perhaps we want to say NOT_CONSTANT(-1) here?

>  #else
>  static int create_ref_symlink(struct ref_lock *lock, const char *target)
>  {
> +	static int warn_once = 1;
> +	char *ref_path;
>  	int ret = -1;
>  
> -	char *ref_path = get_locked_file_path(&lock->lk);
> +	if (warn_once)
> +		warning(_("'core.preferSymlinkRefs=true' is nominated for removal.\n"
> +			  "hint: The use of symbolic links for symbolic refs is deprecated\n"
> +			  "hint: and will be removed in Git 3.0. The configuration that\n"
> +			  "hint: tells Git to use them is thus going away. You can unset\n"
> +			  "hint: it with:\n"
> +			  "hint:\n"
> +			  "hint:\tgit config unset core.preferSymlinkRefs\n"
> +			  "hint:\n"
> +			  "hint: Git will then use the symref format instead."));

I've always called them "textual symref" when I needed to
differenciate them from symbolic links.  I haven't seen "symref
format", though.  Do we have an official terminology?

> +	warn_once = 0;
> +
> +	ref_path = get_locked_file_path(&lock->lk);

Was there a reason why we want to first warn and then attempt to
lock?  We are afraid that we may die before we have a chance to
warn()?
