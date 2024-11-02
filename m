Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF2175D47
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730558236; cv=none; b=HB3ElmJfMe9aLOKniB2PzrXv4p5BSD6bCPmERtQy1aY84SrsXYaoMZ0z6cx+FajFA86n+5STrtn9Rw2Jw6ixaT1WuLDB5sNnrTu443s7yeFHFEtOM6dKcIOM/ZGptTHHE59tZJ+lIb+QWoSV1N+2aCLUurO6qsVFFVb53VRsbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730558236; c=relaxed/simple;
	bh=12KaIPn8QH8qFhHQ2JT3kcDK8JLIh1qL+O/vPlwEUm0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tdSh/FNNF2O8BfECzN9dcQrBb3lbg9Gwmf/wWkIpwxjoKIq7s8HnrhYmyAAN8kVO2AucAwB9EqftPLCzcVSbabIlqH/10FSnf6mILtvEDmhGIJ3lSXCka/th8G14b1QVzGEMhLsGmb03i1Os2bgAc5V/X1MwfkaP2I0pwr4OozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RkuRatjF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dq/mae9R; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RkuRatjF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dq/mae9R"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5281013800ED;
	Sat,  2 Nov 2024 10:37:13 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 02 Nov 2024 10:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730558233;
	 x=1730644633; bh=wX3rabE1e17f5FLtoJdLHtYtJWp3bNbrNu867MEP6vQ=; b=
	RkuRatjFbSQfXdkXW3Jr4fW6+3KSdd65S+SE+ZUqMcEu2tWosW8Sqp+7ecFlGUpt
	bOMD79FOEQPe2g8unZQAYHN1kAaO5CjDXfxYH2G43sv7KIVw/75NUjkWRK5AlFKm
	BZ3FXkIofpx3vX+TMG9j98zGmT8w5Q9BqUuytbRz/1K3ZJqftJFfJUL1DDVY72AE
	IBWdHGarp2zPbL1iZImVPMwUnYRhEUPqDWj00Ye1Oz+wQAHjkax7AwkQKawAZqeF
	X/zaKiQ3FkbsSJYNxgFn+kJ7X5gUe1hf8LbCtDn4US3mg+cYwUjTYtdNEkxqRMhO
	3JXSs1hc9Rjqaa3QfyMUow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730558233; x=
	1730644633; bh=wX3rabE1e17f5FLtoJdLHtYtJWp3bNbrNu867MEP6vQ=; b=D
	q/mae9RY8Sp+yaghCdP9N6Ks7dvEIc7GXcPYqMQOq8AZ/mTv1JtpsQwIbUaZMGxT
	x9+z+OjLgr2kPk4BTAypYZf775q64gv8OKuXTgtr4GsWY4+99dj6ILH43GvEXWDN
	4COMNK4B9v/rUNdK1dEI8Tpv/BkruJykiKNueRyF8PTzGpxhmIzaUPGY4cqR5a17
	epY4J5mzKSc01OxTW7aph+C9FbMG2N2mQWILLHH7LRfwjt4f6rT/mEhl4MMHMWKC
	NVv10jPOSqEJBq+cAzIZKK/WySW+4KCCtOQz06Vgq+1zHo0iuH0LQu7o0+TG0mqG
	PLDy7XB14TfQZrOsbA2aw==
X-ME-Sender: <xms:GDkmZ_VlYlMPIlYcB3K52s2qGAgaSzk5zHVm_SK6k4x1QSQXt6-EQ_E>
    <xme:GDkmZ3mjUaT_d95IQg7-qs3QRkMe12a5NUvREIN9iMd7eWuRQiwr-K29yp2GaFqEY
    OJeCYpNBOkko4SWuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeluddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepudeuhedtudethffgtdfgieehfeevleeileetgfeftdeileeujeettefhve
    ekkeefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegtugifhhhithgvfeesphhmrdhmvgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GDkmZ7aojehh50s83wGqVDJWdYmvE8NfNraJzodEPg_q2qQau6a8Mw>
    <xmx:GDkmZ6XFj-q8RD9MoMY72LrNk5XPAUn7c2S8pr0RkzuwpUmWsJPMXQ>
    <xmx:GDkmZ5kpKZFLpTCaNQZwbuPSRmFZhXjIq5btjMqSQdLAh9sjBxBghQ>
    <xmx:GDkmZ3fI2FH7GMlxvLOZUMaJ2bJoz76gtYHjqQaPY5MiuTU0kkoW0A>
    <xmx:GTkmZ8tVygOmVPbPImiPFPzZVwEtHNSr3gkLwihxjMCGv86NYcDFJ6QZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D33D6780068; Sat,  2 Nov 2024 10:37:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 02 Nov 2024 15:36:09 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Caleb White" <cdwhite3@pm.me>
Cc: git@vger.kernel.org, "Taylor Blau" <me@ttaylorr.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <3249fe48-f777-4aa9-9ee0-2c84272ed278@app.fastmail.com>
In-Reply-To: <xmqqzfmj2zp9.fsf@gitster.g>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <xmqqzfmj2zp9.fsf@gitster.g>
Subject: Re: [PATCH v4 0/8] Allow relative worktree linking to be configured by the
 user
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 1, 2024, at 08:14, Junio C Hamano wrote:
>  - The notes/amlog I snarfed from the broken-out repository of
>    Taylor does not seem to record the message ID
>    <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me> Perhaps
>    I was looking at a wrong repository?
>
> Thanks.

You can find that amlog on https://github.com/git/git/

-- 
Kristoffer Haugsbakk
