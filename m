Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA43922DC22
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846048; cv=none; b=Qyf+grC7JtHmJ4YHhm2gR4XnHR1lzuB3jHPJ3kqr2sCu4a6sT7H6bBkbdxwT2h0ZK91bGAr/SK+E/ASVHc7l6NB3BrEj9n76XJiTaSKUKmLrCgKbi7i44hyQZ94MEQOW5CqhCoAFaxGjZKgc6WOerInlHEZBNcWytpwys/lxNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846048; c=relaxed/simple;
	bh=wcTlo3KfBPaEfAC8+yhyiVly0GVok7Ww8+Uyns/Sd98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGHlPOA+3n6YEzDlk2LmibZa5WIbRXFMD54F87iGztaJzWxQUCsOqk7G4tVe4IBBAUsF7pkYOeBWSq821S8bNnwVYaTVmhaVabZKVdIIZf9gNsiPm/fsHgCK8f46qZp2a5wUAfIqR6bcqCSPFQx/ezeVk6N/L2MAvqhEaw15T2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cHWTPCQi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OiuzSBMl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cHWTPCQi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OiuzSBMl"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF52411400CC;
	Tue, 14 Jan 2025 04:14:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 04:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736846045; x=1736932445; bh=jkYyoMa/YD
	AXSQatsixv3ttAFS7vQlVj4rLypyjJSRc=; b=cHWTPCQimh2T9YywL2yOeOnPBH
	zrsrs0WmToynCVe33HvtW7jObqEbjk/gSupGeLP4QCwvM7Y4p6u6s/dWY0WB0iRo
	9Ao2xdtI8QC9pmVxSiQs1FGyz7AflgPo39x7m/SK8+Ap1+DuWjensXJQ0k+PtnP9
	G/AL+xbI3O59HdvFYqWFS3IjzCKI1Nqu0dQ9AjJGxCCtidxFRyaVqYy0TElIpV7X
	us0E2/ayzmy7hNDy4O+3d7WXlM4DH7SwmYSy/Ovc4q62araviatF7N9jy2GAhLsK
	O6eaFfMLFnvy7upPziZq5H8XMNbKw4sdkvczIwdyYIjsbBEk4vVBrPB94Dtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736846045; x=1736932445; bh=jkYyoMa/YDAXSQatsixv3ttAFS7vQlVj4rL
	ypyjJSRc=; b=OiuzSBMlqjn3t6BwSt9wMJkrBEcsXEZKBDQ/N7gFvDXrQrGeD6U
	DdoK9FPMwRYlybV2L3M7NQCPuynSYa+eXZ0hIuSwHLkMR5AHUwP/qIERg8qkrbkm
	u3Uike6CIUS3osCjhywTZ2Sf1z/DXPktls3nvoxw+WTK7px7YzpcVaFDRvQ2pRzo
	6x2hS04Y8l5pj9xNgEwR4V7r1/opXHQcRmbRooPOuRiMBmrB7i3d21Gmy0aD3mwA
	S3kpvpFgGSxEIbXuuwukvCwLkRv+iA4a/B0dFJ4Ii83QOn+htrzFEoK0QlJxl8jE
	MazVVC7vPsn8PTC16FPFh+87HF5dv7+QR0A==
X-ME-Sender: <xms:3SqGZwK38jzNTvfOufSVfVo3Tv6d_D3JzqkCL6-CHMY1ZSRUebCOEg>
    <xme:3SqGZwLUkb0g-F-UYRlY0bAmc8XIuvNBG7n0WNBc7J4squZERb-CzguFMlTv-kaHl
    KSfwfXsqdf42zWMbw>
X-ME-Received: <xmr:3SqGZwtpyeBGk27_nqK5vfqgEWGzU0hrZFxoNf2s-r1SJIh2moP-HngCQ10E5l5M9a94rKRSqUNyT_zWWZ7MWCghVqxjRwpu7p-Zrl1Mm6ZDjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomh
    dprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3SqGZ9YHKU8HgQzaVnetnTIYzpU2e-vUcTdTs521jDMq1dw6SMAVLQ>
    <xmx:3SqGZ3ZeDpt_P29na-5T8RIFRY0aoN0aP0TkJyA7K88RVUuVxkWXLQ>
    <xmx:3SqGZ5DYqtc4r_7sMmmYfTHcRIlXc05msjlnXlnP7yic0hGlReBTPA>
    <xmx:3SqGZ9YmrUmv5N1SBJ9vsijPA3ReMlRPLlm3aT1i6qYuALRqS75VNw>
    <xmx:3SqGZ2V6UOYh69INS3_4sun3N6d45oACoZFmW-Os8-KEYV7Ix-t_pDL3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 04:14:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2852702 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 09:14:03 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:14:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Evan Martin <evan.martin@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 5/9] meson: wire up generation of distribution archive
Message-ID: <Z4Yq2uxzOz_6vuQ7@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
 <20250113-b4-pks-meson-additions-v1-5-97f6a93f691d@pks.im>
 <xmqqv7ui8uoh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7ui8uoh.fsf@gitster.g>

On Mon, Jan 13, 2025 at 09:55:58AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Meson knows to generate distribution archives via `meson dist`. Despite
> > generating the archive itself, this target also knows to compile and
> > execute tests from that archive, which helps to ensure that the result
> > is an adequate drop-in replacement for the versioned project.
> 
> My reading hiccupped at "Despite" that does not seem to say anything
> contradicting to what follows.  Did you mean the same thing as "In
> addition to" there?

Yup, will fix.

> > diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> > index 95d7d41d233450774a6580c0de332e7b8f69eb4e..1f0fb4098da392511f02a34cdcc84f3889771001 100755
> > --- a/GIT-VERSION-GEN
> > +++ b/GIT-VERSION-GEN
> > @@ -19,6 +19,11 @@ then
> >  	exit 1
> >  fi
> >  
> > +if test -n "$OUTPUT" && test -n "$MESON_DIST_ROOT"
> > +then
> > +    OUTPUT="$MESON_DIST_ROOT/$OUTPUT"
> > +fi
> > +
> >  DEF_VER=$(cat "$SOURCE_DIR"/GIT-VERSION)
> >  
> >  # Protect us from reading Git version information outside of the Git directory
> > @@ -33,7 +38,7 @@ then
> >  	# then try git-describe, then default.
> >  	if test -f "$SOURCE_DIR"/version
> >  	then
> > -		VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
> > +		VN=$(cat "$SOURCE_DIR"/version) && VN=${VN#GIT_VERSION=} || VN="$DEF_VER"
> 
> It used to be that the contents in the "version" file was the
> ultimate truth to be used as-is, but now somebody may write it with
> or without GIT_VERSION= prefix, and this one place is now prepared
> to strip the extra prefix, but everybody else who has been happily
> reading the "version" file is now broken until it is adjusted in the
> same way?

I think it would be fine and that other callers don't have to get
adjusted as long as they haven't been writing files like this. But
this snippet is going away in v2 anyway as I approach the problem a bit
differently now.

Patrick
