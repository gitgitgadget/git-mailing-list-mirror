Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5A320CD5
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277103; cv=none; b=YDCi12nSqrWl81ZOK/9auFhYsk9HNqeGXbODYX9Yhg392hqvhy8a3sEOw9eWeVwATLpE9tQqP97pi3InSMUisBS1pzBxaWQgAavDPyqPZ2KAZigM3H8O7gp2uWIUKldLnR1LrSME6OsCEHkWC5Ooisqk85EiQrRzXSRpAS1ZdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277103; c=relaxed/simple;
	bh=ARfwPtL1YKO2qhG01FKwxsiMwM3AHJu1gwZgRrXYiFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DbFj5AraFWVfLPa885y4wZGEqhztWujeJb3BqnkSvKDPfePEX4BFGOyA/GRRbVMxRgi0MeEatsdEBQtlwavPiS06YMUGv3pkyxwtsFQV5gpuTKL9XWSVXqc3OGMOsBkFOO5SX5iXXZngkVPnR3IIERaodniN3Htciacd+nkqey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UhbDS8+H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yf0+SQFI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UhbDS8+H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yf0+SQFI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A5BE7EC0538;
	Tue,  4 Nov 2025 12:24:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 04 Nov 2025 12:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762277099; x=1762363499; bh=U5pu556NQG
	0UsMoP+dyYC38wozxV6I7bPovbHKwvqQs=; b=UhbDS8+H2D4N+ThlJfMhQBAUdY
	bVNVCzEDFxMOngqqf0LzkGKXAwj45mYQyGv2MMnOuTe/ONyyimU0w7PLRUMe3iz3
	IIe1/Y0jqnJsS/sTBmvPCNDzeYBokjdbvSfclKPT+0YqBuQITGYY14TywdMPH++9
	L6cmQbkHT2cihTepUPPT3eOVQG4c1eFrNsHV8BLSxtAHJhjx5Gjd3Owp/v6KUOC8
	0MwVtX5a+lbDZJVF2gkQf2XjgEgRWhiHcQ+0yRZxBLvyhbyq5YJKiDKpx/Hg3Hyt
	48S7e+EIPIE58rGgD+WOJlx8buTAbsfE/YNm/7VerY5hqhCXUMZn+LWIhdWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762277099; x=1762363499; bh=U5pu556NQG0UsMoP+dyYC38wozxV6I7bPov
	bHKwvqQs=; b=yf0+SQFICqkcbFPHfdo+URL0lx3pfJPzmKBrjUR6ZJ1z1u16CTe
	6qFVKR2CpgoKkKnNH2rTgDSzX5C0C04F6hYusfoNe83aHvkUWo0kNclQ2Ct1p4/y
	gmYafNDUn9ce08uGaVEtxTWup9O3sdUcv4NqElKOnXvVENIa7oEycBfcKl4BUfsS
	JlrDi9Q+MRlOTQcH/8lAmpbmEOTR04ZtZYUxeYTyQVNn//ZuiRez4GExYeSDq/gS
	p6odbAfMY0IBJqFtf29xKObQeaF2DNzxMuqN7xhvk+I6nXoNwYth3A5qvE6xJq+L
	hsn4ESb/z1Eb7NyZNEFM/9L4YA8BqIq+cHw==
X-ME-Sender: <xms:6zYKabrJEBBSQkejUSTU3NlEQOdtD9aod3hZ2SawqFRQACOW8eYgCQ>
    <xme:6zYKae9vyBPCBUNO5NBncthe1HEaw_wFo3_XriDZSSNZfQ0IBVIyL0kReSMP1Ucsx
    jSD4Akr_z3C_-qDvqz91l6iyyW9F-SjW61TIPcWdXU8tyWzUWptNw>
X-ME-Received: <xmr:6zYKafcxsln1FoPyjUngNjhMwFPqIcIJpYEOxiMLU1E8GQOgKbslfpL7cLJwPvzK0cZDoGcR82wTE0PVKIRmdCxkYdyzcLiWNKJX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:6zYKaQJPpxor7nSII1v0nWHLK8jHZ9Cxc0BgUD2Tv1iTuILbiVjN1A>
    <xmx:6zYKaXjmGEp9_LT4tMeHwApnT3Gf2Tn6-8aV_Agvu70XfMdFhi3aIA>
    <xmx:6zYKaWT1F3ElRqK74U0Pz7eAqbQu-9UZPEcC5V99b1PXtre4qzKv4w>
    <xmx:6zYKaZUvH4nSDbYNhtEeNbEah-No7z-NoM_XhwLiSN7QnFPIJKWRRw>
    <xmx:6zYKaanhegFjS5MUMkySV3elhaLXUErAnAEhz9qrEKUCvczYLHH0g2KO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 12:24:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/5] parseopt: fix :(optional) at command line to only
 ignore missing files
In-Reply-To: <ec8d1764-649d-4edf-b0ae-a19ead5f6f9a@gmail.com> (Phillip Wood's
	message of "Tue, 4 Nov 2025 16:19:31 +0000")
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
	<9ec696eaac647aa01466b101129da2b12ef5dbd5.1762100242.git.ben.knoble+github@gmail.com>
	<ec8d1764-649d-4edf-b0ae-a19ead5f6f9a@gmail.com>
Date: Tue, 04 Nov 2025 09:24:57 -0800
Message-ID: <xmqq1pmdr9qu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Ben
>
> These all look good to me though I agree with Junio's comments on patch 
> 3. It would be nice to get at least the fist patch merged in time for 
> 2.52.0.

Yup, let me do exactly that ;-)

Thanks, both.
