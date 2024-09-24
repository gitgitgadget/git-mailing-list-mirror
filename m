Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDF6EB4A
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157780; cv=none; b=N2L/gtxwu0Vg9+dH9lTbiD+gmqczztSmYF2Id6QL9Qc5rBtN/7sJR5pVNkvReb26CB0mvr1AEhLhYbytzK4MzVVDgQLuJymuNaoSu13PoU85YTDd9zPuzXqTUw3vGdIjNxfFrZOq0LXG+Akk6pAiSkajzzmi1QACve3hDWyCmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157780; c=relaxed/simple;
	bh=GYG+BUwlsfyjfw8gJkhxptJwsX0EAFb/a59GcwcNmt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOe1jrbdKIf0Igd0u9ojDMbglPgpn7mBAXdyJA2j/ybi7ZhweS3rV+m0Tf7gheKyqXfagj7BCNVO8J3HVUfwdNHIwDaHUmW7F5V6J28F0ecYn6zhf3QpF1GZjodbCDIyhw+QauY7rvVhzzXGGhxsrHq8BkEwF5mE4COLqQbl5HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nUlDBFS0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWHykwuC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nUlDBFS0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWHykwuC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0292D13802C1;
	Tue, 24 Sep 2024 02:02:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 24 Sep 2024 02:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727157777; x=1727244177; bh=KDIDKmuKu1
	6yPLkesBnjZ6zSG8g8I61JKIM4+vUSQWM=; b=nUlDBFS0YR+5ypUSUFAYFL6V6L
	xOFKDfCF5HAiHelIo0bmhesWe7jpF26eC6s1abDEfsfxQPTd07OSQGORVLYtWs+1
	Quxz2G37XP3N8rjKHJA3Pfn86+WnRdvi4Lfux/B49sH7MFejhlc+OMd1ki8L68AD
	i/TrWO5pgpKwtCPRD0sb9iZPHIO2JzY/43AAyWQDRGf1Ag9gVFt5MyLtSxFe27mj
	DKqBbFQN4gyrx08OXdDnby88BazY8uXYqhOztoSOnsnYv92CKrUfZ/zRUKsSrYLq
	KUXueYVb8w3XKWaA0Q4k0qzJ5LHrN8wlJwRFvgu7+taZ4TaBe15Sf6MxgKJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727157777; x=1727244177; bh=KDIDKmuKu16yPLkesBnjZ6zSG8g8
	I61JKIM4+vUSQWM=; b=CWHykwuCe1jb5/cWKqBRskw7FCwy3vQh4p0/sH69ITky
	ORmxZaVdvzFKlqDrvGMjvm6oVjLROnYb445bRDz+zMf9erloseibnhkPJUZyWDz4
	iHvvKzhgS0SstozwXrgPDgug7cZp1xELnlABu2QvnuluVfMkiyka3by23dw+aSlr
	7rUraQuSWld1ypP0T2uqRy8pNxjjsw2E4LVI8/l6wsBfJVWSZ0lR92ZWUGU4YvTs
	NAh7Pp8A//WHsLQzOMmqNmpKYqqevoToe7XnPoRS6+YNijOYpgxcLtQbTu5dCcDJ
	87M9VmWzDttZuBUsaDhJo2FglTo5CRhiS2bfNWmeSQ==
X-ME-Sender: <xms:EVbyZtOIOZhmEG51wMRqIvdLHLCLdcJ09NdjQh4JpfqQ-J1zabxOhw>
    <xme:EVbyZv_v5uW2N9da8fpp9Wvx4KboqA-hEPeZ15WDu2EjafK7eg_5DRcxqxzosyJyR
    9r10n0gFlEAPetR-A>
X-ME-Received: <xmr:EVbyZsShZ7ctJNJdyjSGULU3gXOjdTdXpEzFh8aR52aDUA82wpk06VCnmTNpvPTZ0wjvYZQwDPI1urIGLXhl51I1dH57hdOVt-srxAIOY3XsUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudelueel
    gfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:EVbyZptkCZCJJjEmPjD9_qoWwZjPQOeCAW2MjgAPe1fP0NMc_xPVCg>
    <xmx:EVbyZlfciin8a4_bmXemQg9JS-12m-UluG4R2WtZU0CFUZTDokhHYA>
    <xmx:EVbyZl2XMIXGOhdMolCJTvKz69kTXL2KIs6nK9zr3oesnefz8uTipw>
    <xmx:EVbyZh-SBwCJVqL6f1ophGxIYOC8_1tGCceRYjbxKRGjs2YsxQ8Cqw>
    <xmx:EVbyZp6rX-JuxcpNQlrqzz-hpL0-IWdynLDBD68Eefm9rNIpBGxOdvXZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:02:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5f536b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:02:22 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:02:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
Message-ID: <ZvJWCauoFpjYcpKs@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <e6ded75f630ea309d5b76126560a0ec3d526bf71.1726489647.git.ps@pks.im>
 <xmqqed5cajd5.fsf@gitster.g>
 <ZvJSyT8OsUVLln4A@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvJSyT8OsUVLln4A@pks.im>

On Tue, Sep 24, 2024 at 07:48:57AM +0200, Patrick Steinhardt wrote:
> On Sat, Sep 21, 2024 at 12:37:26PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > In a sense, it is on the borderline to handle st_mult() overflow in
> > this function for a topic whose theme is about allocation failures.
> > 
> > From the point of view of callers of reftable_calloc(), whether the
> > arguments they are feeding the function is too large to be
> > multiplied or whether the request is too big for the underlying
> > allocator to handle, the end result should be the same: they
> > requested too large an allocation.
> > 
> > So I wouldn't complain that it is out of scope, if use of st_mult()
> > that computes the allocation size is fixed as part of this series.
> > But as I already said, I am also OK if we leave it to a separate
> > series to tackle other potential callers of die().
> 
> I'd leave it as-is for now, but I do have it on my agenda to address
> this, as well. I already have it as part of my third patch series in
> this context where I completely detangle the reftable library from the
> rest of Git to make it a reusable library for libgit2 and the likes.

Well, you know. I reroll the series anyway, so I'll just make the change
now.

Patrick
