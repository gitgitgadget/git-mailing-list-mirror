Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129812F7479
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925060; cv=none; b=jgRuznyLlv+1QcijYpyh2lANoeL4hKmGoDHJ/z3J2/a4wb+/WtJPlBbxvTY0YI1FwN8WLmyucx3MlVHASeyCJnSmg0cdf/ni5KylIH7xroF/NLLx5dJfvdOMpY1XFeKUVXttiHyA2ahCQIqKoGyyZRMLTtT7wRSl7UA9tiu23LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925060; c=relaxed/simple;
	bh=65ZpKwbuw6m6voUfDAvRQ//lRhYzqhPtDc8/GmDh0s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBzXQU148WdkU/UvZs3IwaGvy9BJuQfa2sHcrerXr5QkbxaSQJr/m2MBj3eBUkJmaZm8p9dnjL7sw/4Z9mQor6Xc0FVwVtneyrMghes3WgLb0sCZpe0EF8PJO8QHJrFD24SuGT75dG1IeveHMX8afVSF9SSaZYxndmtYoC9NjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQrJwoBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZiSaMY0p; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQrJwoBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZiSaMY0p"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 005601D00029;
	Wed,  8 Oct 2025 08:04:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Oct 2025 08:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759925056; x=1760011456; bh=EXsjQtVpWV
	ELgYpMjPzWBr3slYLkfBPcfVTDIaAqMUc=; b=EQrJwoBJeceBwnbvQ8nuZyeCxe
	xQDp91dQSaVg9lROWIV6Q5d40fCZfe2jb74XzdSzcY7dUfRzfFDpXjCgh4+b4FiE
	KRZvPxdKj2AZWcblUZQdg/YZS5oQzXgpIc6C+UbbZp8dIXQX28dQ+uUbFqHoAwXM
	7n7X5daAUN6lsuuozNLTZ4f33fH3/1rOa8qaNNYh3nq+gzRqxAELAwmsLXgD1HbR
	YskgrrSwqLY6LdMcMhSgWW93A4P6CAksTN0ZRTawcJIoBLRo2ZNN3f80509XPQ+/
	uzj9DdiWR+QsS3/GVWOVbPZMWeJES707sl80On5bHBZHQJbFDzOfqoQIPPdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759925056; x=1760011456; bh=EXsjQtVpWVELgYpMjPzWBr3slYLkfBPcfVT
	DIaAqMUc=; b=ZiSaMY0pXybvDaZ1QXmxK2OsIVgXAAGXVi+RdOTdy5YzZAjZdGW
	120dl0lBfO1cSE3+iQ/nRfTK+mYiGvgR5rOIW6xobnfmL1ANzIfm/HegB83U0i1H
	usRPwhwQqgTGUjC2okQPWabxncfgzQ6tEONYVIfWkzUZkdXaSgJnznPtNqh6JBj2
	R0WEY3mhzZlw7LP1OZ3tlMmb5OcClKA6nKNjRIpbZcfxYDVj8uF1SBU8jbfAXSwF
	+9AlRACd6FGQBJR/eZ6DnhuXcouyPxiEnY2dQKEcnOCIZch2Hsl6v5/oWjApgnx6
	T8HDH7K0IXPg8ePr8BCs8iBd8Spl0B88LBQ==
X-ME-Sender: <xms:QFPmaMJQI7tOCxyQ_EOjVpOjJN9T30X0QHnaERGoEBDN97XscSLdUg>
    <xme:QFPmaLOp2KX99qCiKMWL9T-tIapc-fgBUaJCIF4bqgLzdpGivM_xh8Fz1nA5uoKja
    nxaaRJtX39i91CwD3ZbN09UFArf0l7bLSA6JGnKtQaqmK7LuUOIjw>
X-ME-Received: <xmr:QFPmaC7RR4SsYsAPUa0QUV4MhJU5x19W4tnXQBSbt6CWH_Wq2z1DxGE9DoGpp0U_AoP-KXtqPDxawjs4HF3xfIVaM9IKE43xj5IHb-yt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgeejieelffdvudfgleeuveevkeffjeelhedttdeuleetvdffvdefledtleekveegnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthhhrihhsrdhtohhrvghkse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegvrh
    hitghsuhhnshhhihhnvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QFPmaF6C1Ac2cGSVJr9yW-0skvCUGvqycEHyIWOymzL1y77MUQpyww>
    <xmx:QFPmaIGEgh1q116ElXiwS8_Skq0m1ixEh6VTzpqVr-fnpcvFb4w9Dg>
    <xmx:QFPmaNVOQrlVN7zGspoSjH9RfxF4EYB10QB5pW0vjpAdPMSoNnmc2Q>
    <xmx:QFPmaEU_LllbckjIjTkBL9vUnmyJqtk1666F0Fqn0U_Lv-yR7nGHvQ>
    <xmx:QFPmaBdtAbcmSuJeifmmAJXjqNg2iBG002zaeopBpQpBCrWG9wga6H0S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 08:04:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2b72b88 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 12:04:13 +0000 (UTC)
Date: Wed, 8 Oct 2025 14:04:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Torek <chris.torek@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] ci: improvements to our Rust infrastructure
Message-ID: <aOZTOs5Z9QyfRXYO@pks.im>
References: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>

On Wed, Oct 08, 2025 at 08:27:11AM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> this small patch series introduces some improvements for our Rust
> infrastructure. Most importantly, it introduces a couple of static
> analysis checks to verify consistent formatting, use Clippy for linting
> and to verify our minimum supported Rust version.
> 
> Furthermore, this series also introduces support for building with Rust
> enabled on Windows.
> 
> The series is built on top of 45547b60ac (Merge branch 'master' of
> https://github.com/j6t/gitk, 2025-10-05) with ps/rust-balloon at
> e425c40aa0 (ci: enable Rust for breaking-changes jobs, 2025-10-02) and
> ps/gitlab-ci-windows-improvements at 3c4925c3f5 (t8020: fix test failure
> due to indeterministic tag sorting, 2025-10-02) merged into it.
> 
> Changes in v2:
>   - Adjust comments for `encode_varint()` and `decode_varint()` based on
>     brian's feedback.
>   - Some small improvements to commit messages.
>   - Not changed is the default column limit used by Rust. I think using
>     the column limit of 100 used by the Rust ecosystem is sensible, but
>     if there is a majority advocating for a limit of 80 I'll adapt this.
>   - Link to v1: https://lore.kernel.org/r/20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im

Sorry, I noticed that threading is broken here. An update of b4 made me
lose my custom patches that implement shallow threading by accident. The
next version will connect back to the original thread again.

Patrick
