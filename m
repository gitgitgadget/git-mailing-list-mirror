Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC771DE881
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046124; cv=none; b=a/GgZR9B1tAjEf2QmCVb93OJwFQtKNRAYhklAmSmB12OnpWgRbjwI3pDobR1mNs+GrVowq/dlmVnr+7QIQuHosnOwzfAnqr9CisSj9ekC7nu4mOQ4U6/n9Lu25wHCULLXmRcA7pE5t/T5bEyq+05+zlbcgzxN5bBoif7oM4gvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046124; c=relaxed/simple;
	bh=E2EFPJW3LHaduGBiqdJoaT0Z2CR87bhj9xJdEm+9Ejo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TDbL8OV3JaZHjMENsPEnoP5eR2cl44RmnRHGk+IKb2gqtUjusIGDyTHDZersbbfG62dIs86cJltt0toDePoeSYHmjZ4dWhu7QxTwlwKpAVIeAkBejFel+O8T5uv+3THe1IDt4IfNWrxXS3iNJs2Tp4a2bbWEw0UGg7e/R/6j7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iQnonTS0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FexoHkER; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iQnonTS0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FexoHkER"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6354A114013B;
	Thu, 16 Jan 2025 11:48:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 16 Jan 2025 11:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737046121; x=1737132521; bh=aRc2gvRrl4
	SYnDWRnwymaSNXuOXA61lNGBMR/kdF6tg=; b=iQnonTS0oOibvKpMtt5p2nuoV6
	54ZF8zTHXwRSXnhkmoNCS6zIeZcESYtG5PqtQEEF0vVlsbzIjEdR/dmUIh2DUh4m
	42Krg0GFARysnKwHrYrW33AP/5jskwwf94+L/rWNqvF28w6Nw2BtxGWUmUbKse6o
	fmdM4Ij4RrGleOL98zjM/0dmweZgwua3VZ7+bODjkaS9opuU297JOqG1o/JgNp30
	IckuU3AQKxcBNzRub50madfMMGgr8GJM7mAebm8ya9l52IQQtBDO9JztDZ/iCTte
	p0cW4W0Q1z+ZlbX9a9qFzFug0zfp7cOjqE4IdVIOtKyVhIEc+xeDUE4dQoPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737046121; x=1737132521; bh=aRc2gvRrl4SYnDWRnwymaSNXuOXA61lNGBM
	R/kdF6tg=; b=FexoHkERvnuF/IwTOkG5neQC1tbn45GQL0UIB1ZcBaYjSErlVQI
	FlNW6puzd91ALoSXlHgKhNnC3c4EC0E68UwNHi3ZFC4Pxjfu6z0k8OI49UHTVlF2
	SoGgPOOj469eJRBPv3N5k5DfGQtKTElsf7arc63+/sancO1WlttlE5SvFNzoH76d
	G9NGoglzNukD734wyWGKCXm6LvPLCwlM9aJ//qNdlZPiGfoP0Wn4y4fAnyTNYjSX
	TH/OJr7qu0fYeVRL7o4Ap39yQHbZtF/uH7mGVAkp72lAPAH6QR0ANYAQutqti0zk
	O6pNRG8bfzIO9ItE+F8QB3mXcKbFF5LvBeg==
X-ME-Sender: <xms:aTiJZ_LH6cbbtHXa2ArrVXY2od9w4qR-rFVjIwyo0GRJQRGEFppb8w>
    <xme:aTiJZzKqOzJYaF2n8BHDnnAa2k-9iNcWnZZD1KEdoTJOR89lH-_AgldGEKJeUwEWy
    PQMxKeSJuS7IS8XJw>
X-ME-Received: <xmr:aTiJZ3u7yDcVHfDcr2Q0ji66wCDxIjG5CyjBJIFqHhvUyqFU3GP_4TMhlgSFKbDPAi9NOVdhNIWYtH4Im4MsYYt9_KL5iTELA68F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aTiJZ4bBL924czVplLnr6Pn_Yp8GqH871cy9LshjeFqbE1QONasyMw>
    <xmx:aTiJZ2aO_-zxbsfPUjcKg2vBb8fE3LpS1PjLC-QZ-hBiuW0tnx5CSg>
    <xmx:aTiJZ8Dhrb1RQqWWIWUI0JPKWCjQTxbFPnlotNakRZbFclBiRdNRXA>
    <xmx:aTiJZ0YweQvoPFyEwJZb3Rfupk8DwVBsZt_nJDtdCdnIElsgFcMIHQ>
    <xmx:aTiJZ9xbSMJOO2c49jR55KQm6dc-hiBzBfIY2D8QNZ3BHZuELYUtlGYF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 11:48:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  shejialuo
 <shejialuo@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #04; Tue, 14)
In-Reply-To: <Z4jeQSLmARruE5l3@pks.im> (Patrick Steinhardt's message of "Thu,
	16 Jan 2025 11:24:01 +0100")
References: <xmqqzfjt2qye.fsf@gitster.g> <Z4jeQSLmARruE5l3@pks.im>
Date: Thu, 16 Jan 2025 08:48:39 -0800
Message-ID: <xmqqfrliu2l4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * ds/backfill (2024-12-20) 6 commits
>>  ...
>>  source: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
>
> I had a couple of nits and expect another reroll, but think it's close
> to being ready.

Yeah, this one is looking better.

A new command with a new test script means it requires a bit of
meson.build adjustment but I think that is well under control.

>> * ds/path-walk-1 (2024-12-20) 7 commits
>>  ...
>>  source: <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
>
> I had a single nit, but don't necessarily think that it needs to be
> addressed.

Thanks.
