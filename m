Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6B1EFFA3
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765043; cv=none; b=tTI5NEnSGyxwblf5H6tWyZvWQf4ZLcLkcWKk/u4ApnCnf4QIX9UH28YCXof1/xNvIBmcne5Hv/Vr9hTJarQg5lNOt57xGIgRwKMz5VqL+hEc4ODFE8FNKnt33mQzGnEdCAWHyiujfANBcphcTnh2Hh7xhBBbGfvVcHwEjof6N04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765043; c=relaxed/simple;
	bh=YoPJ2V5xlQ5ujF73Vs3oYnarc9RVm+YW9qnFVtL7wKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX3MJGlb2ZHW088FEF0SSGqXc74zJ/fCE6HKDAN4/w5DNH4tln+c2lssfmw9COGnM/t55FBY8tUSuZC+osA9IbxVWjZqxWVI6HufLHFfRAHcpU4s0R/Vi/LMp9w7BZYqG73L3zGIOXbLpA1yy6m2ZuaOFABuvSz2njLQjBlEPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bqPLVQ0U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkltJ/Ig; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bqPLVQ0U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkltJ/Ig"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92C8525402BA;
	Wed, 12 Mar 2025 03:37:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 12 Mar 2025 03:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741765040; x=1741851440; bh=RT3TcTNJrs
	BLRgo63x1n9oMSmkG6YXH5VVgstSNL8c4=; b=bqPLVQ0UoIIMAa7ZMRf0kQavBM
	ynyOpseATcLi+EKHgcc3Dyzjc41d4rKsrHrsTV4VFQmnoeer7NIY88dbdTJo6bHp
	GefT7cWds4/2xaMpXs6+PCsr9W0yPyOxpLpJGCkSGoRK3hFwNb6TSPb7qsJSSPm/
	OqFsb4I9C9eBt9ftMX1kOhasnRgl+nXVPMFoX8aMIY5ZmHdXIoSxWGqZMXKxffdz
	PP1KLjKpXenDXAzgyp7leL+mF1w8VV+CArXznyI6bckylo/4tiBbPpGaBYENFqaM
	Pp9D0PZGRznpCiZ132IgLkb/BGXnNSfJN0bEjxfuQevPlfFmYlLZmX8PJQCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741765040; x=1741851440; bh=RT3TcTNJrsBLRgo63x1n9oMSmkG6YXH5VVg
	stSNL8c4=; b=QkltJ/IgP5sYb2hBf1E68HQuP1r3X0mDbkg3aX/5UaQRMOJa/yy
	c2licAtTH9DrHv+opVzbAeV41TeicsSatAys6pjnV6geyZW46zoTYwfuU2D26Zqn
	SfViydN39M9erp2BhAYmUGcdZYrlfwJR5rRSUg/nmAcumT4s07cpbRMemm1MSkYY
	KsE9aMZTJT1hZE/a7onZ7l+HKvbZjYbwg2PvNCG5Dkk4f2H2HlxsVLoqVVMbTWl6
	BJN2nmRrgcecoLJydro8+3PW8F1staxWEFNyZ9illiNaodbPPh5lhip/KLKGA9nT
	npZxVChbMWXKjRU3UvauMYOzgvHblLNk6oA==
X-ME-Sender: <xms:sDnRZzFhYtf79ovL5XgQtBQU-EvNQ3x82xbAg_kWyjnSJYa6pec2dQ>
    <xme:sDnRZwWEV3dpAIkXS67JAwe_LoTbwuH42dkCQLHrOkS1r06uNhV5sN2125CyzSc-Y
    5wOUzo4LdKBJIfouw>
X-ME-Received: <xmr:sDnRZ1IM3HJ66DBeU12Sfp9aRKKf0ewpapy5SEHfaWzAnK_WNhFNhCrv2ZfagakM5w9y_ucQ8cuXukw1afjC3AGgxIMkFqNd5Evqk4GNYP4HQaguOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeggeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtg
    houhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:sDnRZxFXPldv8nRsCgsUBB5QDZ3Ns-JuQRJ62OFpjHKyCAcuRG7Mbw>
    <xmx:sDnRZ5UctGWgji9DIyY20sQAMnCYMT6-2vJ0gUTnaC04mgF4b7XMgg>
    <xmx:sDnRZ8OloC-a2OG3RP898S-yaPXCmJ5qpt230tPEEZROLhuSkbQZlw>
    <xmx:sDnRZ41Xtfgtonwy0QhFE6a4Uu5Nf-oA9WQYOvSlR3b6ncvmRbwr2g>
    <xmx:sDnRZ_xqE0Ckahs0aud487JJXUStkHhL17ASm1PzwXLTedR9ZWLr9nyU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 03:37:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25f5943f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 07:37:17 +0000 (UTC)
Date: Wed, 12 Mar 2025 08:37:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <Z9E5qXQ2v4lu9hom@pks.im>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <xmqq34fk7hb7.fsf@gitster.g>
 <nfrfyg56nq7m2bcko4v4tsfdklrafpkybc6uhqgo25swdeebh3@a7aneoylg46u>
 <xmqq1pv32kvp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pv32kvp.fsf@gitster.g>

On Tue, Mar 11, 2025 at 04:44:10PM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >>  (4) The traditional "rev-list --missing" output loses the leading
> >>      "?"; it is replaced by "missing" as the <attr> name, i.e. such
> >>      a record may look like "<oid> NUL missing=yes NUL..." together
> >>      with other "<token>=<value> NUL" pairs appended as needed at
> >>      the end.
> >
> > I think this is good. Instead of prefixing missing OIDs with '?', we can
> > just append another token/value pair `missing=yes`.
> 
> And we may want to avoid excessive bloat of the output that is not
> primarily meant for human consumption, in which case perhaps a
> common things like "missing" and "path" can be given a shorter
> token, perhaps like "m=yes" and "p=Makefile"?

I would prefer to keep longer paths here:

  - While the output typically shouldn't be seen by a human, the code
    handling it both on the printing and on the receiving side would.
    And there it helps the reader quite a bit to get additional context
    rather than cryptic single-letter abbreviations that one would have
    to always look up.

  - By keeping with long names we also avoid "letter squatting" when two
    attributes of an object start with the same letter.

  - I doubt that the couple of extra characters is really going to
    matter much given that most of the time will most likely be spent
    reading and decompressing the objects from disk anyway.

Patrick
