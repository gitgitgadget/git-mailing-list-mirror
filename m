Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121429B78D
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424099; cv=none; b=rabeZIyNQvaW49lbrGIyc9UxpfCEgsK3PNcN+TVqQgDeQBtdKPH56i43XnmbGkjf6EW+Wh9DqrYxE0mPym/puXZ6QZtrBQzo/ceDyq6GVuVZ2zDnammDSA9oWgNKQQAMXrU76uAAw2aTHpDazqHPEBwzN2iUa6W+88RcZnNs800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424099; c=relaxed/simple;
	bh=VENuU8ZeJhmUNZmpYS6BYBu5yhqhwlZyA02b6/X00dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0Ughamhk7VpyQ5eRPQgOjxtMXZLGyoksnxej/xYHk2Y6SwinPfWTjRcmqu0dnaXJtBXvlVncsqwZIM5LO3yjOyleI/JZ/qbtyWxkjCnt8FmV66jIKZRNATC6D4w+EoR9bnykGuN4aTKHfn/mDhxNCZ3Uo7uUBSGnj+b8WqCTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k3K6WAw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=btp5mNpR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k3K6WAw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="btp5mNpR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 42D7F1D0016F;
	Wed, 18 Feb 2026 09:14:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 18 Feb 2026 09:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771424096; x=1771510496; bh=zkJI2lBO2y
	Ka0xcuUXgAXMOdEsMQm/CnhALbObbXN/o=; b=k3K6WAw8mIcC2hZet1QF1+NaLh
	wlqyID+StIQc25Oh++iAmsDuUqCa36K1D5d7K4evwqY5p2itH3pYMhVsbv5lzfuD
	aLCnOUS1fKt2TcBwyKkObYH5rHA0p8wgd3wenPBLDSdQwlIWjipkVv+P55fGiPe3
	EqmAMrTtzbLUMqfOn1d0SM0FLNtL5glRBI6EDnq4Iv+16GSNhw/uOBC0K+2tdNLz
	H0c/zaxn8vXBmsREEMmWqL02z9i7j6Fr5oul4GBPIRaD4QBKXayjtFvRl69zSbu3
	eE6JW1jIHDgDLo5x0V78dr+Tu3fhdEihwbQQ0g8qqh9lA24VjJQ54h6r1+WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771424096; x=1771510496; bh=zkJI2lBO2yKa0xcuUXgAXMOdEsMQm/CnhAL
	bObbXN/o=; b=btp5mNpRhEZ/TcLlxh/2XrCTKmows7KVhVrQsksjJnj0zMP/PJo
	GvaQGQ/4UGQJHUbuOf/8lXU17HBJY84wqANgH27gmFGHNUetpXc8AzGyaKpVw3EM
	enwioemQ8N3H74GTiZKdHiA2iOzRNySQKlXOjYEpk71iQaNvFYldIoR9CNVt9QMH
	pNiEFQbIzV2QAKR8fGUWfXHM8mtLzuBhnug0BnwFHUMoMp8v03YLTdIIEo7uegkB
	LF/SDpGOh02LGdWZxONS95inqpUZygjn863BIGX0WWt7zRNrxxKg77W470gwgL3+
	PLZ9cRRdLEz0b4WJVLZWzgOUveTP07Dz5zw==
X-ME-Sender: <xms:X8mVaUdEE8k8ExA2r5QS53Fs-pzmeGPUmzJzn9TAuPhbkGObDjf1HQ>
    <xme:X8mVadHCLItoah6Da81W-eXpqis-dwjMZZ4WT3laH69n8nJOi4ZXaTJ9f8gzxuKre
    bdcvj8qITCab2ehc0Z05Cb84i-1Mceoz0y62ErQSaArlCsG0QDztD4>
X-ME-Received: <xmr:X8mVad1L1fJSd7dDyt_VlFhXDfJ_oPQ9O3Hsre2IQ2LwuwANQlOfiTbf4jHrVRaGuAE-3p9jSGlaljZhBpDUyJIpiGnQmhUAL6X6PtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjohgrqhhuihhmsegrmhhuthgr
    sghlvgdrtghomhdprhgtphhtthhopehmvgesjhhorghquhhimhhrohgthhgrrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:X8mVaVkFVyKMPewC9bYqsil5ZkRW1N4Ktp3pT9fyHOfezCKKjcUR2Q>
    <xmx:X8mVad_5_B7fMPf5M1OWUBZhIRJ1Eqaogq6kzm7g-x4ZgH9tEQrp0w>
    <xmx:X8mVaaoXxTnBEFzKIpaIbF9R_EwLScPmfoLcjyPTviEDnUoz8YTPRw>
    <xmx:X8mVaWkXHz8gZzVgavjp8xzGh7y9molQdGDqRWMg-oilDu-ZgOkERg>
    <xmx:YMmVaT4bEITUPfpH00gAMkZ5b_kjXrUTufZNgFmiARo-E0MfRrmKKH8S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 09:14:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5e865fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 14:14:51 +0000 (UTC)
Date: Wed, 18 Feb 2026 15:14:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Joaquim Rocha via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Joaquim Rocha <me@joaquimrocha.com>,
	Joaquim Rocha <joaquim@amutable.com>
Subject: Re: [PATCH] apply: strip ./ prefix from --directory argument
Message-ID: <aZXJVtgRYQAnxNnE@pks.im>
References: <pull.2198.git.git.1771002510709.gitgitgadget@gmail.com>
 <aZQhnIcPa9sCPpBb@pks.im>
 <xmqqzf579kuc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf579kuc.fsf@gitster.g>

On Tue, Feb 17, 2026 at 12:27:39PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > While this change here fixes your observed issues, the next person might
> > run into a totally different one. So more generally, I think what we'd
> > rather want to do is to fully normalize the path. How about this
> > instead:
> 
> Sorry, but I am confused.  Why isn't "don't do it then" a good
> answer for a case like this?

I guess that's fair, but especially with command line completion it
might be easy to arrive at such paths. That may or may not be a good
argument, I'm not sure myself.

Patrick
