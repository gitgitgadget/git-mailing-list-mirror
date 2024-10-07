Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D84158A36
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296315; cv=none; b=EgiDH4Cbc88E17QUbvRbdYiwaocak2YQz3BtibU0udw7rFXeXuGXQe0S1aLxIYFRJjDFs62Qy1rQyPJJcJ5TvO01FYdelRVtU+0aLFphdt8hSJoEjpdJY16Hf+MogQrpqvk7qxaG1zb8LJnG4oU+0oWX+hqVH7JCqBDy4VYTpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296315; c=relaxed/simple;
	bh=cP+n96u+mux4LBcs/eq0Dka5ZpBnUiH3Kf94Y+oaTf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6NdluJUXgVD8L+K4MqKdSg38FQ8WQz4whWRaF1xfqBAewN3TiwaRVZThE4jrIAbsw+mOcN+HLFZ3BrKcDClwuCLrdiB6lyBMdzuuSjOvPWxLoVyNZLXpvd2Lvu4Ht0W3y2In1hgX73ftECvEjKMR0dkn/Hz/P2geNZeQhRHW4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m/dN+BAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qP73HgSW; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m/dN+BAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qP73HgSW"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FF7C11400E3;
	Mon,  7 Oct 2024 06:18:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 07 Oct 2024 06:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728296312; x=1728382712; bh=SlHpMQQlUA
	u/2dMCfMWitYphPb1qzfg92JCX/Xgczhw=; b=m/dN+BAbICdIOEOUqSF17IMds4
	oIban0VmTRughPUaw4Mv0TMOiKcJTRRI56W5t9/YbL11lT70F4dU88NqjL2XD2zT
	66CYSkztG9iwxXrQ/8PhT4XDVgBiImRIlZJXjEq8wp3G4158tF5PEhHlGbL0S+Au
	daWsHBaE/gHmDbRUFoAYoPRPJsg88EQYa3f0r1bkYeMawjG1njYsEJZ3YkdW6LE8
	9TrrqvOyCJJQWmWFpeYEHyoQuxn3cdTyUDk8FimUMRoDiOADcsLCNOL7MPjhhhrL
	XNEB4kufKjPN75VXxF4sqGwncVe8iFzkVVk/vVziXrnrXOdS7h2FsZ2sY7bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728296312; x=1728382712; bh=SlHpMQQlUAu/2dMCfMWitYphPb1q
	zfg92JCX/Xgczhw=; b=qP73HgSWDFwTzz3VqERljtWxD0SaxWJj47rrIqe1OW/S
	Xwn/QYetO2CPO3wU/UhpBCpK5/JxA2W6ZZUcwiuXIbRK/F8+iolgTnzSaIxfx88C
	qjZtQk690gEwInJBvAq6W+OlhpFOODjNOUGZYKOJBnCzRE9Em5wJIS12y3WfLrsm
	nEdUKWcaipUFaQG5hwNjJvoe+beFJz5R8XMpQVCPw5FC5P973EY7hbqwP2/K7xEv
	HhwnDkQrh8MOxHScdCKCkE0lznZPQ0cX6dbUk5HWkdz7BHIuApr2uYF2F++wFSrc
	c7Tkl7fhf3LNjiG1VUxYOq/FTeZXZ8eoPNlpIbqmRA==
X-ME-Sender: <xms:eLUDZ7cnmBErh6IR_iUXPpFg4h8p0VBincH0CsRIZg2fpok1ZA-xHg>
    <xme:eLUDZxNvIciPiSnRjl9QjLcZJaukZ8iRHiS2gNvhjSIyuOYwb8WPD0w1Gb_Fphjzq
    zZnCzp0CN-_aB2m6g>
X-ME-Received: <xmr:eLUDZ0i16xbDsMvgF9K5u9UtkkDLg5LZyC3FTturk2r38eYJNDHnfk_lqRxWDtShDihjw4w15LDJR2A6_dDiNTsPIkjG9IlmxngnFtamRmsJqVXVQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhn
    shhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:eLUDZ89LflrqP4j5eYiOc5okk-yYU-JrLXHQjmPRc1TG49GIu1x0Wg>
    <xmx:eLUDZ3sF-qCmNg_KK5dc4m1_H_9wGGN_dHluJa9DsuxUryYkIIxNFw>
    <xmx:eLUDZ7Fzq2OmeQADqHsgIaCHsl1K2tdja1aV1EH_gL27BsStE6wZPg>
    <xmx:eLUDZ-PZuhFKHW24ZGM_iJB-kxE_FOBgIUEgA-US_yxOLDoxKPUqzA>
    <xmx:eLUDZ9UjpMZYulpGGzNUB_DfjkPynGT5dmI8Gh2m8-wImfcQgrhOUMkc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 06:18:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24612f69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 10:17:33 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:18:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 05/21] t3404: work around platform-specific behaviour
 on macOS 10.15
Message-ID: <ZwO1dC_NXwR7nJZI@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <00fd829833cae1d192d6c42237aa13427156e3ea.1727881164.git.ps@pks.im>
 <CAPig+cSqeKJX99jbxouJZHdGZuyAgNz-wOgt+0C5OPvW3MHgLw@mail.gmail.com>
 <cf2ad192-928d-4bc6-974f-da5b217fba30@gmail.com>
 <CAPig+cSuXojVPeVE_0HFwrQQqYn-SwCvHQ9yG+c8H1dgaH00pA@mail.gmail.com>
 <xmqqcykghj10.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcykghj10.fsf@gitster.g>

On Thu, Oct 03, 2024 at 04:19:07PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >> I suspect that the problem is that we use "\t" which is non-standard
> >> rather than a literal tab character in the sed expression.
> >
> > Ah yes. The `sed` on macOS 10.15 would have been of an older
> > BSD-lineage than the more modern macOS versions, so that makes sense.
> > It wouldn't be a bad idea for the commit message to mention something
> > along those lines.
> >
> > (I always use literal TAB with `sed` for this precise reason, which
> > may explain why my eyes skipped right over the non-standard use of
> > "\t" or I just wasn't paying close enough attention, which is equally
> > likely.)
> 
> I also learned sed with old BSD behaviour to be portable (I somehow
> thought it is not just "old BSD" but outside POSIX if you used "\t"
> and friends).  Checking with
> 
> $ git grep 'sed.*\\t' t/\*.sh
> 
> shows that t3305 also has this problem.  The ones in t3404 are from
> 4611884e (sequencer: notify user of --update-refs activity,
> 2022-07-19), while the other one is from e1c52539 (t3305: check
> notes fanout more carefully and robustly, 2020-02-03), both are
> relatively old.  If people are not reporting issues, it may be an
> indication that sed implementations of BSD origin may have died off.

Probably. Curious that I didn't see issues in t3305.

Patrick
