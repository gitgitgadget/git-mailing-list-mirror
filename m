Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E576FC3
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749054678; cv=none; b=XMup0rPQnM0KaVPeZAlUhwciMzAuAZ7Bs7A0wVytp3lhzbVMZpjxpXTNgRWRqQYzGSeLQy3Q6EQfTWjw3YunKVHkPyvKdBxyi76dkLH8+qmziNZjbQwfZdzOg+XHhw2DhzHgcbfArgPbJAobKHW+1pJWD4gN6w+AlqOXu24nyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749054678; c=relaxed/simple;
	bh=XOE2W+XIMQtbPhCpvASJgzWnC6EgHS3MXmMfwVKvbV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hx/cQx4NNPCHXaGLuECFqDjkD4PnvYhWCHakL8gu1JrTks/tAo84cFBuC4ySs2g8yfEjfYRMD8d1KC6FyuvWZMxi3la33sYq+4AcprGm81pNWS4mC0FvHCiRxLpgLBOrM78ICGvJaflRp8nn9ripTnFF/KbRn98M9VS56l4lHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tayoWm4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L0wuKbAT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tayoWm4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L0wuKbAT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 570681380386;
	Wed,  4 Jun 2025 12:31:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 04 Jun 2025 12:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749054674; x=1749141074; bh=93jrdu6Uu7
	UOiKbv0LWrDMb8qXJrwvCG8Ap0jlIBHVE=; b=tayoWm4LJDUI1XHCkJdwHKaIMb
	m2bigavnchZ9hd+pJOjX7wAhUQphpIeTfOz17O23j8dLDPbqyN8mYNXIdzQ7GRjj
	Kgy1QgvYVBUgBlXIqPIeDHGkz1f39x42PqzGu2H7o8i9BOw4FBF7Hn4vpeeHGts+
	SHHLNw3WcTMXl71BQim/9HDLbFL53zZJ57TOhakLsGSGffSnU2+t2j0kr9NADKKU
	g92rqc2w6Gur8TvSmdIaBW24o6uXnNWNISjbrraNHzeSPL0R3/Najsb5wHj31g1+
	+e/xmsnR5z4McRs6WLU5tvuQyb+AOdHAZnLk0XVnsaW/WI1XYDmvHrGkkIHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749054674; x=1749141074; bh=93jrdu6Uu7UOiKbv0LWrDMb8qXJrwvCG8Ap
	0jlIBHVE=; b=L0wuKbATTwD7vlMdbOXxqz/6Nk8Rr9Eowv2Z9/EDPxT3UJME8gK
	uXXmrIxMNfqptsg0Lb3GpoTkZPOs8RIhBXxMLQOJ9hHBm9Sfi601PDQ+K6Q4pQHK
	Ia5oihrXhyuVUTVTKCsmBwdB2JOFfRTJCbwnVt8nKrcTvfjYtF6Tda3DaZQmZ0DI
	Fddm4v3XszYmPBpwp6LjFRbis4X4Qs6FfamONasr3IO8dkoVoPH9EDaZGt6syDCY
	cS0715FkPl2VBDbnS+S+rIKUFzKfDCotUJt/w3lr7i79I3G6kwNrLWD3h/3ztZwo
	ahQJqwykXp1XkDexb3AOeKSvZ4f/bjDBeLQ==
X-ME-Sender: <xms:0XRAaIeC_j7j9G4D84ADadj0eMMphL7D5v7s4u7KaLYmTEspGVQubg>
    <xme:0XRAaKP5DCqqolVT6CvkKZwPhk6SRnNswZmfQ6GwO2cpXakQDFYH4ti0g0EOLr2UZ
    WzIgbtGKFR2uUPkQQ>
X-ME-Received: <xmr:0XRAaJgUcwORQMo-ycc0WoHB1VcjLLug9vccdvAzZt8dg7Jc2y_NKtsICW4m8etm6GnPAbgYdKpsb0JG5rVSzYq0jVBYtP7ENUjJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughith
    ihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjrggtohgsrdgvrdhk
    vghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopeiiihihrghoseguihhsrhhooh
    htrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0XRAaN_Ag-1FZCUwGP0vzPghee2gf1CitPVkMo6aP1qJ9Vd63F2v5g>
    <xmx:0XRAaEs9OezZJX_HM1RDq1gtBYmhKPMnHnJ5Bq-djx96QUmvs-Oi6g>
    <xmx:0XRAaEEXew1WYk5MdzKqGFc2JtXgI84pkvWqmTJFjVSqpB1_W3o6nA>
    <xmx:0XRAaDPe1pTNSclpDOTfuksAz46q6oIoLGkSV7fvirty3WACR5YuQA>
    <xmx:0nRAaNnr0sYVyaP8m8mZq795nVdwKcbVgFhOfmDVZMWCWMRJTS9LrMpy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 12:31:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  "brian m
 . carlson" <sandals@crustytoothpaste.net>,  Julian Swagemakers
 <julian@swagemakers.org>,  Jeff King <peff@peff.net>,  Jacob Keller
 <jacob.e.keller@intel.com>,  Zi Yao <ziyao@disroot.org>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 0/2] send-email: fix threads breaking in case user
 edits emails and improvements to outlook ID fix.
In-Reply-To: <PN3PR01MB95979AA8114CA26405BE02CFB86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 4 Jun 2025 18:25:12 +0530")
References: <cover.1748274404.git.gargaditya08@live.com>
	<PN3PR01MB95979AA8114CA26405BE02CFB86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 04 Jun 2025 09:31:11 -0700
Message-ID: <xmqqplfjbh9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> v7 - Remove unecessary comment in the second patch.
>    - Mild rewording of the commit message of the second patch.
>    - Fix incrmented -> incremented

Looking good.  Will queue.  Thanks.
