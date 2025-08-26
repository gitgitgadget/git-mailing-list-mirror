Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6B288527
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168823; cv=none; b=IY786+V40DuMuLUc3v73rKcaZ6UqvNjqliW9BDro8Ukttpqi/lGWW8JyEuYY0oACEa9pYJ2QSGsT/hrCJVaAPu6SExRoYTv15arnRp2rGx3GRfzNH575XTYPDVKg9ZqmriKkQA9C76eAV08Yr4X22rIYAnIrnOL2jFG3PUBvCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168823; c=relaxed/simple;
	bh=sGMlb4O8CJ+2S4V7nJZAVSmKY7I5NTPvFR+HGsThn80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G+0YyVIMF4G1ooXrdYe0aWTzazGA+GlvDEayrMsI5cgHTlM9E29y7Zkc/zEPfp1M3wHabegxKINxkROzEJ4VfB5AZ+W4ExSKuTkG3a9NJSKUjvVwI8hAmHjY+n5XYn3lq/qI8VerhsJ1f0GW7RFjBB5gGvl2FoR51HVu4e2L8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IXCKcdmE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLKSkvmV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IXCKcdmE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLKSkvmV"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B22614001E2;
	Mon, 25 Aug 2025 20:40:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 25 Aug 2025 20:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756168819; x=1756255219; bh=sWQbw456CU
	rET7Yo5dIGLchQE5EsQOyK5sX8CG0N/3k=; b=IXCKcdmE5Hc3g9IaJYv5kWgyV3
	CZxD0hTGfL60aD9ZQVUL4i2kdeWYtqFEMKPHlkDFyTW98EeKuFdSd/MBRHWHaaUh
	q9GUsPWLsjRWHqyO4qeSQ5dPtjuDIeQFpHIMXd33M8EI3eVBGiV+6aGJyrGGbxNX
	ST/vDONpso3UqDBly5v1y2Z5jW3evKSTpZPpdmBp6kinuVHkmFXaT+i+lIVu6o2K
	j/ZS8jeYCtIc0SsJRCXa07yA4fgyi2yJgQ9wKPRKptjNlApe4Mjz5tcLCYyC2Q+q
	Fhg/iojOS8rYk9YYsd1poQE7sSqYxhz3+k1geBOu68VUwHyK6roZk8nHQg6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756168819; x=1756255219; bh=sWQbw456CUrET7Yo5dIGLchQE5EsQOyK5sX
	8CG0N/3k=; b=nLKSkvmVIuA9S0MnB52yYhGaAKERB8dcyKUJOMv+rKC/wSPdWiO
	j71athjJiR/+sg9fRjL5dTR0X/yRAUUtUg1tmKXIqYJz6D93iVG2tZZKf+Xa6K10
	AHSPgLVVvnIVvu3q7blV9Q1Fw/6XDb01aBiDpB3Y3p/TDng1iBfop6LyTDUZIMXP
	HE1IMj+UcDCS0InCYBDk7TdzKBSMEsiZelJ4wLcWLcO9dLQQ2M792kVDaqEOPqTl
	m0NsgKerVhzu+ZNQmUhyM9zgCVUiXhgMnipf7Glfha9Aq1wkdQGxxMxpxS6bMFH+
	Yv+PtetynWA3uQtZAuen5hVESHY1JWui8BA==
X-ME-Sender: <xms:cwKtaDI1PXRCy1M-3HvTxqumWqDUKNiiaUiR8M-_gQ_bxwQdhKRC8Q>
    <xme:cwKtaBug3E_oZF9nzW7hvqQyOs8y1fMpy2eD61W2emBEha-zaUEkeuWGpQ8O36SWv
    q5RhsP-Hl92xtd1rA>
X-ME-Received: <xmr:cwKtaIR7zBTZ5-0lnFGdfu2oCxd1VwdhCBE4A22r-e-T2aj07l1Ncm7ffj8ffWsPcb3UG1QEo5QT4m6BvLILXoWGPdqa06VeeD7Jch4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cwKtaPNk-pQSct4mGXtoByul3eEpungTxNaNJdcb9EAX3zzp_CChPw>
    <xmx:cwKtaFab6X3eA8BDqrFYbsvUZgnHTco5p06Cn708TWjZbJlmwJ0e3w>
    <xmx:cwKtaBx7Oc3bDq1z5hxzo_N_tjtttLkOsIlSF_xSvBABzDFQt40QAw>
    <xmx:cwKtaIJ5EefXXx-4p45XZM6ATGNxR_dBel3E6LguZjTyo4_CJnIbgQ>
    <xmx:cwKtaPyIr7EK4NgpMBI3xJI3JajdV4io2OVQeT87SxH1GMkGDp301FfM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 20:40:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/3] meson: wire up gitk and git-gui
In-Reply-To: <aKtLCAq9Y-59cIbc@pks.im> (Patrick Steinhardt's message of "Sun,
	24 Aug 2025 19:25:28 +0200")
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
	<xmqq7byzfh0w.fsf@gitster.g> <aKtLCAq9Y-59cIbc@pks.im>
Date: Mon, 25 Aug 2025 17:40:17 -0700
Message-ID: <xmqqsehencem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> If this is proving to be a blocker we can also change upstream to not be
> a separate project.

What do "upstream" refer to in this sentence?  Meson?

If you are talking about "gitk" and/or "git-gui", then such an
alternative version of these patches would not change the picture an
iota, wrt "the limitation of the tool should not force the sources
that might consider using the tool to pay the price---which might be
proving to be a blocker", no?

Not that I am saying it _is_ a blocker.  But the above sounds like
making things worse for no gain, so I must be misunderstanding what
you meant X-<.

So, ... confused.
