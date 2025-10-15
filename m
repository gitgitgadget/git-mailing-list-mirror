Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B0302151
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507966; cv=none; b=ROJBo4kX4qzulC6E9W20MCw+F452nb8HMt7axvkj8Bl70wrH2AH6MG9Wpv4z1xm1DsCjZKfFF8y/XwsKE4tsX8UItXcvne7Pn8qFC/Ka/btHt6jZh2g91MbnD2wJagF1AXIBv8iWcz7W1s/WgtEGc91aBzb7K5BTnkA6SqFvmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507966; c=relaxed/simple;
	bh=RPqZQ96/3v98xZOM7nug9af6GSkbpu41j9FYpfrh1oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5Eqlv6IcG1rAeCMgIhF/bX5stqq+lWWSBZEFRpaZ317W1qlmdyRZB3gn0OBJEfE6rUjz0SYWKMwPlOyJffKy7JBPV8lOrpRtlZxthXjM2N5mTeqZ0SWxsdFXtT5TFiM6ZJjKUHjegBazoqfyQs2kb79Ron9yOMF0ALxtqhsnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HvK80EK8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XiT9BRUB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HvK80EK8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiT9BRUB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 449E314000FE;
	Wed, 15 Oct 2025 01:59:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 01:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760507963; x=1760594363; bh=XdxK2v5nkN
	6f+Gaaz2s3eWc//Jpzh3V4k+FPnqHGB28=; b=HvK80EK8Nm7sVunGfcwKdtv06A
	Hg6ndE2vSERTJIY74jtLoYMD9wfZhYIaCnmyzZhuPO68MerbkHXKjPF8jOo0lM6A
	BE/073UDlcxGHgspruKwGlIEfqsaOzeyHk3BR/YyKSzvtczsTI60Xf6UUbzlJ+s4
	3kNV4atRIsNVnpmQ4jAyfIX+tgRPgjepj8BjNZxWDOtpMpgsZkGwE/dqp7d6xa7A
	DN0F82ZoqNocEnPd3biQCE/KjXjnN/LoVBSX9poKNboNkz2odvzA9lMHtdU8w7d/
	h8sgf+phCTPU3FLtGLbKBjVW8S7AruGpz9w/yCkYmfFjDnbPKBqXNYKMlBQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760507963; x=1760594363; bh=XdxK2v5nkN6f+Gaaz2s3eWc//Jpzh3V4k+F
	PnqHGB28=; b=XiT9BRUBIcSAx9Xhvni9vA3AtbcoN/9kFA7ILNOy0apqAN02gtg
	rOJFOX5DtPwHmtISdf05aLkYdq3SGc+mdXVQgQfCJ8qsdMg2l6VFDcDg6eUhqXzw
	CosdOwTUFc65G1Hkvn0hijjqC20hXyFVG2SappbhT1A3nXTElu2m7v6wZdzWGvFq
	5j3r0AXiP4thMoxqelkwa/IF9vPQjQ9QT1AhQBFqAHuYGFsy+ZxomNtiJZVgpbxg
	QFheoomchRq5T5qS9uVpgIeOs5jbyA1KJkjHScGZZLmmoDmr3grgf7jFz98Wd1AA
	EiZzilVEJET2Qu9SUiksdNeQipOlGuKhiJg==
X-ME-Sender: <xms:OjjvaBeRHd-Wd6MXtbBn-SMZZaev9YJq_2KsRFfsmdM-lYpmZfQXEw>
    <xme:OjjvaGpo9_TYOcTw-b44INZ6qf3wp3FyoFccz2HO7wYhbCWTmE70lg-72zdrLSJzD
    xjiFKthMurdnF4zUy714L65yp9wZkucuMdI_RpZX-HAqfOVivj0Yw>
X-ME-Received: <xmr:OjjvaH65XPfJAUpCrjs_GIex5_dCvBaI43RwblQx1RajqNSFXSE8ZXxNdIhytB9_CuIxk9NMASCO4UPbiTDMgr7ocxN724XlwoW5AYPbAcK2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggv
    lhhinhesghhmgidruggv
X-ME-Proxy: <xmx:OjjvaEqyFM7jyUCDQA7_kFi-yFfeEUS_RyBcyOFBBrmNzd8YQnoRyQ>
    <xmx:OjjvaBjhl0lYTILZMbPJkwZ2fRju-c5Tz617TchsMJgkEV5TxeSNaA>
    <xmx:OjjvaGLolyavWApruapxzs6eIeI6RvMj7XabL4Pv7iUWpW5M173wGQ>
    <xmx:OjjvaJAHoY0jGb_hdhv60zNJi15jb8uIeTUCJYE-h1oNSPVYp7snXg>
    <xmx:OzjvaJM7VwR-9qieekTDupMeswb8t3VGy_oxoTH39FootsqmmNcwnsz_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 01:59:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62b2750f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 05:59:20 +0000 (UTC)
Date: Wed, 15 Oct 2025 07:59:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] refs/files: deprecate writing symrefs as symbolic links
Message-ID: <aO84NamCzFXH1eUl@pks.im>
References: <20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im>
 <xmqqplapxur0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplapxur0.fsf@gitster.g>

On Tue, Oct 14, 2025 at 10:23:31AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +* Support for `core.preferSymlinkRefs=true` has been deprecated and will be
> > +  removed in Git 3.0. If set, symbolic refs like "HEAD" would be written as
> > +  symbolic links instead of as a plain file using the symref format.
> 
> The second sentence reads as if we are talking about a newly
> introduced feature, but I cannot quite rephrase it to avoid that
> impression myself.

How about:

  Support for `core.preferSymlinkRefs=true` has been deprecated and will be
  removed in Git 3.0. Writing symbolic refs as symbolic links will be phased
  out in favor of using plain files using the textual representation of
  symbolic refs.

> > +Note that for now, only the writing side for such symbolic links is deprecated.
> > +Reading such symbolic links is still supported for now.
> 
> Double "for now".  Let's start the above with "Note that only the ...".

Yup.

> > diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
> > index 08739bb9d42..e9272bbc0bd 100644
> > --- a/Documentation/config/core.adoc
> > +++ b/Documentation/config/core.adoc
> > @@ -290,6 +290,9 @@ core.preferSymlinkRefs::
> >  	and other symbolic reference files, use symbolic links.
> >  	This is sometimes needed to work with old scripts that
> >  	expect HEAD to be a symbolic link.
> > ++
> > +This configuration is deprecated and will be removed in Git 3.0. Writing
> > +symbolic links for symrefs will not be supported anymore.
> 
> Or spinning it a bit positively:
> 
> 	Symbolic refs will always be written as textual symrefs.

Okay.

> > -#ifdef NO_SYMLINK_HEAD
> > +#if defined(NO_SYMLINK_HEAD) || defined(WITH_BREAKING_CHANGES)
> >  #define create_ref_symlink(a, b) (-1)
> 
> Perhaps we want to say NOT_CONSTANT(-1) here?

We do have `NOT_CONSTANT()` at the callsite, as introduced by Johannes.
I don't really see a reason to change that now.

> >  #else
> >  static int create_ref_symlink(struct ref_lock *lock, const char *target)
> >  {
> > +	static int warn_once = 1;
> > +	char *ref_path;
> >  	int ret = -1;
> >  
> > -	char *ref_path = get_locked_file_path(&lock->lk);
> > +	if (warn_once)
> > +		warning(_("'core.preferSymlinkRefs=true' is nominated for removal.\n"
> > +			  "hint: The use of symbolic links for symbolic refs is deprecated\n"
> > +			  "hint: and will be removed in Git 3.0. The configuration that\n"
> > +			  "hint: tells Git to use them is thus going away. You can unset\n"
> > +			  "hint: it with:\n"
> > +			  "hint:\n"
> > +			  "hint:\tgit config unset core.preferSymlinkRefs\n"
> > +			  "hint:\n"
> > +			  "hint: Git will then use the symref format instead."));
> 
> I've always called them "textual symref" when I needed to
> differenciate them from symbolic links.  I haven't seen "symref
> format", though.  Do we have an official terminology?

I don't think we do. I'll say "textual symref format" here.

> > +	warn_once = 0;
> > +
> > +	ref_path = get_locked_file_path(&lock->lk);
> 
> Was there a reason why we want to first warn and then attempt to
> lock?  We are afraid that we may die before we have a chance to
> warn()?

No particular reason, no. Happy to move it towards the end so that error
messages are given preference.

Thanks!

Patrick
