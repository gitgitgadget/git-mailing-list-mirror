Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5117F7
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731024; cv=none; b=rK3fCpl9JmLAaphRjvzsg7QFlpPqXnKUf0FynHoI/Eipf8M00NkS2smT4ykmmozJimw7+IVFHZhXAnFNpPVreMRSrkn5wldcUfja4088skCYlKTNKk4+UHuSOIYZI8R3t/1d99kR3H1UTIxnOjDpjicdSFPxvS+6+BatPRgiM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731024; c=relaxed/simple;
	bh=pNefYlRXPDGg+hAn+vr9xczQza6YS0zIDwxIacwSlko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=syD0g1ytBiea03GxvwDIv5GqzkX7VVF+jNe7dYz0W6gkF4HHctkncn/55HvSrOy4tJoOOMHKScvbyjOKGyEijagT9Quc+o1Us3s2K0x8J5Rb5jMH/UBpVkjgFyrB2Oao2aRq2P89ciCt2DkNsR9lsGUmN6xrDwTKxE2n11bc9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BZfSqDdP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtLrD8WX; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BZfSqDdP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtLrD8WX"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A1A21138028F;
	Wed, 23 Oct 2024 20:50:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 23 Oct 2024 20:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729731019; x=1729817419; bh=+dj926RhcN
	BbKUzJM93I6eTmQDRN54GRQyEDQjuwj5c=; b=BZfSqDdPSFiGM+I2xAyE0L/4lG
	s1ZUDF5NYAgAfTyCIqR+YNNqaJZyBt5kZsS4Oq4uQMOl07SPQ/0OBMjbZUH2Yolw
	Ev2goK/OfoNxv8QhjfCXtefTRDtH+qrw5af/PTxgKoKjFJcIl1R2jKPXZFGG+4V6
	9hNiV+stcZTODCdw15rL0DByrltNGHVCe+QYxizLC90yEIhRgeEBlhfazNPap3QH
	iORXpbtqe+o5CPDZ4dEWyCwI68iNixiw/8SFnrbuLPASa/hn5eyy1NjcfZmj6cYF
	A5Cyf14PajP3AK9xpnh1c19Q8oVY863NYSNggkukxbx6hXsOt4l2RSvob1tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729731019; x=1729817419; bh=+dj926RhcNBbKUzJM93I6eTmQDRN
	54GRQyEDQjuwj5c=; b=YtLrD8WXU8IfKAUDpRdeUDGrhk8J8GNExucqico6sDDk
	VhKGFgW/N62zPwfcXqfaaBXVlac/EubnfYLkn3LSJAlCJZAzb/5nf+Q64fTZy/7f
	TaScIk5obVMJQ/5JtUMVdWmZCEmixdDz59AZdOch9JmHvwLaAHvOYuBNZOuX8LaH
	9GHTZyDATqT7K6a3QGvf1t3fOv9Je5R7Sq4eZ6AVzmM4u0P3LysCt1/Ijw8ebumw
	qpoA02G1b541BEILdm5v9DBW0SuFqTRhVLZPnTntulc36Ngh69KG2Ekp1iIdp2xj
	8lOyM6j19cD8XZnDP5fCXAHypAd6uxl7U1sPuOCe4Q==
X-ME-Sender: <xms:y5kZZ-FQLvinQhX2qPoBjCnyRYLPaCzkJzBgqnzDRyxvFIZ6xgOi9A>
    <xme:y5kZZ_WxxD2nWJX21qDK4whkW0iiwML1f1PaWS4KN-c9iYlh1YoeQmA1HHaE7uAyk
    4FaeWajv6mmAziQrw>
X-ME-Received: <xmr:y5kZZ4I73n_91CW87PjiWfDTSdCT4R2OXArGYDbBZEFXJETyyX7fCZLP305Ij1iYtW_RN8J_jaCDk_VOVW2HiRka6Ij7iOARnkG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:y5kZZ4GO0fdpBjhLmKyXpc-ePFKKvz4TKq4Xk5DqIaS9LednDVenKQ>
    <xmx:y5kZZ0VXcUM8J_PcHvT2wD-3L35Z08FgS0vW1UViRc975kVvi-OoVg>
    <xmx:y5kZZ7PCLFYUB5UYmdqwAfyIA2d8lU7VBl-5ATQqMMWOr-GMiKONdQ>
    <xmx:y5kZZ71JnREm2-eXfgew8xHq09FGbl0OktM5rPLYio660ka0I7QwkA>
    <xmx:y5kZZ-eHtBC4UlkZP6SOMW7omOxrxi1eyUHiwriDXd_W81tu0rWpwxWg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 20:50:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: karthik nayak <karthik.188@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in
 function names
In-Reply-To: <ZxfVwQxMlcJbGt5D@nand.local> (Taylor Blau's message of "Tue, 22
	Oct 2024 12:41:37 -0400")
References: <20241021124145.636561-1-karthik.188@gmail.com>
	<ZxZP01C-9RngukZy@pks.im> <ZxazVG65+W0qKLXh@nand.local>
	<CAOLa=ZSPmkdngn3=cksBM-syO94-zYANLk8FWBsQYpTR8XT9FA@mail.gmail.com>
	<ZxfVwQxMlcJbGt5D@nand.local>
Date: Wed, 23 Oct 2024 17:50:17 -0700
Message-ID: <xmqqr086pbna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> I don't disagree that writing "single" or "recursively" can be
> considered clearer. I think that the convention to suffix such functions
> with "_1()" is more terse, but saves characters and can avoid awkward
> line wrapping.

I am reasonably sure that I was the first user of the _1()
convention, or at least I was one of them.  The reason for the
choice of suffix was only because there wasn't anything suitable
when refactoring an existing function foo() into a set-up part and
its recursive body, so I just kept the set-up part and the single
call into the new function in the original foo(), and had to give a
name to the new function that holds the body of the original logic
that was moved from foo().

Neither foo_helper() or foo_recursive() were descriptive enough to
warrant such longer suffixes than a simple _1().  They easily can
get "help by doing what?" and "recursively doing what?" reaction,
which is a sure sign that the suffixes are not descriptive enough.

That was the only reason why I picked that "short-and-sweet but
cryptic" suffix.

Surely all of _1(), _helper(), _recursive() are meaningless.  If we
were to replace existing uses of them, the replacement has to be 10x
better.

Having said all that, as an aspirational goal, I think it is good to
encourage people to find a name that is descriptive when writing a
new function.  I'd refrain from judging if it is way too obvious to
be worth documenting (as I am officially on vacation and shouldn't
be thinking too much about the project).

Thanks.
