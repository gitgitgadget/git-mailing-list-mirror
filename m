Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B76156C6C
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513144; cv=none; b=WwU2zfELBvECjFUq7gHdB7Dj6W+NR7ETqDVcxxJx2yFjIZ09zznQQGhDf3bvDDnRzPldvQMbBGb1N25xHvpuuw3+ttN8ZVUn51T4EyefiS1D8kb+SvcVam7mjIMIAyH0rJuo47wQvQe5cr/owpLsfELE14Wv0/E4kFz9jMj7lHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513144; c=relaxed/simple;
	bh=jkhK7J/bnhV6ICSM/kIhvMBj/QZAHOGjulfDpcSFl7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dxAXDlURtBTbStK5V72/Wv3V/bqx/6XQRLz3ormFE0I49rpjNUIacjSNxGXm5LgPg7V6hAOpQKn9BjAgEs0FpJKJjdP0vqf9TgUGaK+Aj2ENneCAZKL7brYSy5mwP+OICC1LgFaOaKN1gJwMktjoCXtainm+StcUaAiKpJ2a0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YT2g2/VP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GMPa5ryN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YT2g2/VP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GMPa5ryN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 80C39138011C;
	Wed,  9 Oct 2024 18:32:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 09 Oct 2024 18:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728513141; x=1728599541; bh=UgR9UUgopp
	DmL+L/mbSTLkJgka4LPXravysNyP2HMLo=; b=YT2g2/VPr6sYmkPDEE3evFd3JF
	pDkKtm+SWfFPi5abLwHQCa5IPyz8yqlWrc6MLUc6GO8QzcDjPe+vcYY/jak9dIB6
	f9kVgI2rxZw7dFPeAtKoq35882Hh4TCCYZ2gdowE09yFb+hhtlX9w4fGEYRGKg3S
	AHv5xDW4lJesprAOx4tLN4GCaBkmNS3OV1KQrtm7hv8IR873mnjtRLTllc8CORfn
	fBKERjdkpLYnnqmuhKCtKYxeUKfW/pQK/y8jq6vZj0DzJ15Izo9sgzM2bUnx/5qc
	Rh2pHXrOIVJoA8Bvg/nXjn51ggW00x0Dv6fXu2gfqMQ7kKlbwGv90c5lWT4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728513141; x=1728599541; bh=UgR9UUgoppDmL+L/mbSTLkJgka4L
	PXravysNyP2HMLo=; b=GMPa5ryNUzTk5szvh2iduBnFEi3iqxHm1tneurgq3KH8
	ZAf+BSnIzL2M7JgTHkh00q2SmfcU2OzDbclrCanB9DDH4X9v4YO5A2woEtMBgRgu
	9RL+NWMvNMEw89Mxd+pACRkC38zBYBA2W9wXxvVRSVqBg3g/IuS62sopOmFlkek0
	TBMTgFB85I9yFu0e9K3uKLTkdi5LvY28iyGGiaKF4NMhu0eTuqqF4lUEbHA+JeuH
	WeYOxi62tl48n0Bc3fuoaxBgDSx1uNvrikHLTBDMBLbZ725yuyM4H5E87P4F4U6l
	LfuidJKtace2lDVgmXx4waItTb1pP13lpaLEfefVjw==
X-ME-Sender: <xms:dQQHZ8eyJ7SIvzQmNikp3xm_TXXR61izrMm_oYFInoGfmObclKa70Q>
    <xme:dQQHZ-ME8Aj8rwGgrSf8y9CBQtiOpGBL6Ns5f5DtRGWUMb5nAMm4ifthS2fwLI0LT
    FM3ah4ol-on66qvAg>
X-ME-Received: <xmr:dQQHZ9heOsXu3pCIg0wgx12aW5Y9UB8t9rF0lccEqVyLtvaDla1K60t7tWCYgKfQZzfKw9quLEOOoY64cqNPI5zDMRf4Deqtka0y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dQQHZx_eE2_41Hxpvsf-q1kxNST7GC39D3SICrsNdC_WHJx-grqc8Q>
    <xmx:dQQHZ4sx3Qd7rpJiwZT6X6nZzvxdRM5qVX2z_REbazHMC8s9f3Rz6w>
    <xmx:dQQHZ4GWu8rxozm6eukz3mD83lAdEnDB9vwCGhBr0AfUzuWYZwqXHg>
    <xmx:dQQHZ3OMoOo7zgz1MBCi30FTBBuRIzfW1pLJygbaPdL1Ek795NpZNA>
    <xmx:dQQHZ6IWfgRpprEsH6x9wVIh0liZuSzchxMr6HgMidHh9iAZ1yMELgaG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 18:32:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] clang-format: don't enforce the column limit
In-Reply-To: <zmqyj3v2h3hswoujpz2er5luvjipjl3i4ts6xjdeb43wp42xf2@i5xee2lsmriz>
	(Justin Tobler's message of "Wed, 9 Oct 2024 10:45:45 -0500")
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
	<CAOLa=ZS+naxOzJUkLLOZk++WVZ2dt3eQq9VmW+G-5O1ZLgggUA@mail.gmail.com>
	<zmqyj3v2h3hswoujpz2er5luvjipjl3i4ts6xjdeb43wp42xf2@i5xee2lsmriz>
Date: Wed, 09 Oct 2024 15:32:19 -0700
Message-ID: <xmqqttdkoqks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 24/10/09 05:55AM, Karthik Nayak wrote:
>> The current value for the column limit is set to 80. While this is as
>> expected, we often prefer readability over this strict limit. This means
>> it is common to find code which extends over 80 characters. So let's
>> change the column limit to be 0 instead. This ensures that the formatter
>> doesn't complain about code strictly not following the column limit.
>
> The column limit does lead to quite a few false positives. At the same
> time though, in some ways having a tool point out all the instances it
> occurs does make it easier to review if any should be addressed.
>
> If the goal is to have a CI job that we generally expect to pass, then
> it makes sense to remove it. I don't feel super strongly either way.

Is it possible for gatekeeper jobs to complain only on newly added
violations?  Then it is fine to have a limit with a bit of slack,
say like 96 columns (with 16-column readability slack).

