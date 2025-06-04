Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC44290BA2
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046197; cv=none; b=SsPS8JbAdDPfoneQxz6XCXWC6i/l7ujvSi11FIfkGDpIrgtuEuMVTjrkdbH8mLX2bx+sgDamiuamfjZgHLIO91zgS/FlqLR7yI4b0gqWSOC2B5ag7AW6Mn0AZb6Fmo0myw+274GcUTViWKgJnSoILJRysGlaY7KXR1Hvf2E3i0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046197; c=relaxed/simple;
	bh=jzum6ufO/A5iHc4NsVzsCT+/hrvGZp/xgw0qnT5b3PA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kXKe007CleB5VFpVOFpi3yaXRvRFLnqWu9Dyq/uaQJkHMCV82WVuqaSZ34E8ibszWTnb50RcQGWtpYWRnXL2RXoexUhXXZZOXK6bzySwar+6E/d+8JUMjwIiuOkNYNxUVkxg9/h/4Uj7Rzm0MjrA9GTv/Zx+UqohwkyIPaSziAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QpJTnmNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nflz6kKH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QpJTnmNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nflz6kKH"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id ACA4B1140188;
	Wed,  4 Jun 2025 10:09:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 04 Jun 2025 10:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749046194;
	 x=1749132594; bh=ulGOW4LYElD1EDw+xJxDWRT0279Mwojz+MqzAF5koDQ=; b=
	QpJTnmNFyZnIlaNE93OASZ9MB9PtUATRO6gSNnbf+N1cetae8i3QId6zu0q/Rxxi
	5AL+tRWmhz5BHrHZYv5eNBt231NKBzNRbwY/JUoL9O1vURXcVSP37Cp90wema/WO
	CYA6uEdXxqs1ChzXsoAXGSZ0AfXiOne3AaC1fi2/6wEXO5CjBZ3GGgtJgrFF03hi
	FeUwcwBCN98PkcaMGcyO4j7PxeLpugRXb16sCSQNJVARN4fM27JAZjdPUexVRem1
	1gyhjoan6tBVVQTUyRhkxgIs5BRhFn7XtcS2RR2V5vuIaunTWhYj6apz1WnfAY8O
	xp0mw/A8cskQdhydign40g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749046194; x=
	1749132594; bh=ulGOW4LYElD1EDw+xJxDWRT0279Mwojz+MqzAF5koDQ=; b=n
	flz6kKHhX5eOfFwnR66vvmmDgOcuhVJ6F+fu5J7bIQvyR45uHmerrXlYXaSVREtu
	IVfalWsDOYyGwGZcUOfDOJ/bAfh4yaOMSzZi6QJgUfmEXT/fgNMGeY5mRqtuJjzf
	SJfCL18kxjsV/UMd1WgHbsjkvpzKswtrbyD8P8rPQxzWGabzLCG/z24pVWeW1xc/
	9VQauSmD7SrndhiNc6+kmOpmN/E/S8RacaQ8HcMrh8OOAZB9QwzTrdqXfGZrQtZ4
	n0FPBqEKC7IzebbNzuQytKWV26JSPX/5nsI2CN5spXVyNIUEQTxY6W/8oi8QcE1V
	oDdPEy+v6K0HuBDOYQW5w==
X-ME-Sender: <xms:slNAaClGVBDcs1rhSXjJehITeLeaFNcGFs62iCUwQAA0H2DJhBjUTqQ>
    <xme:slNAaJ3RrC7KnLeEerB4KSfUYb1aRrVS5Llw33RhceOCMb1t-iuVkwMUPuqHgfoj_
    jb2E3JrRI1nIYP0Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrphgvnhif
    rghrrhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehprghtrhhikhdrfigvihhskhhirhgthhgvrhesnhhuthhrihgvnh
    htrdhiohdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:slNAaAqmBH7Y1ruSlt0ItGMlQeu3G7vq0jo90SpcY2wjx76YFpByEg>
    <xmx:slNAaGkaQ9fIcVTUBMeEcGuKojTgWsyo88E1kDXD8dHX4kt_7O8j9Q>
    <xmx:slNAaA1ZXJTmdQ0Uy0Hn28s82hfYdL-21qrNwhFXIDQNaRcC_7kYTA>
    <xmx:slNAaNs0NgKgrzhmGAgO69m5ayWEnMs2WcvFWyBoaSaNyPejD2fd2Q>
    <xmx:slNAaE9LHW0ZNvRGNcV3vR8YupWWQz5z9BdUBh-ohMY0w_Y6D7DAgcSF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 427211EA0060; Wed,  4 Jun 2025 10:09:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9c60b7143a8053d9
Date: Wed, 04 Jun 2025 16:09:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrik Weiskircher" <patrik.weiskircher@nutrient.io>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 apenwarr@gmail.com, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <0c65723e-fb52-43e1-8bf2-32bd421163a1@app.fastmail.com>
In-Reply-To: 
 <CANMzfzjhe=mxrcxgyXYqOD3GJ0UdX=xsP7oq3H8OGPfuwOphow@mail.gmail.com>
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
 <fe7e918ba1831fffead46791441da350223998f7.1748882439.git.gitgitgadget@gmail.com>
 <CALnO6CDk4cP1Mef07F6Z8Sm-1MxwWWd-rYEfL-e5_Nnq50B4ng@mail.gmail.com>
 <CANMzfzjhe=mxrcxgyXYqOD3GJ0UdX=xsP7oq3H8OGPfuwOphow@mail.gmail.com>
Subject: Re: [PATCH 1/2] contrib/subtree: parse using --stuck-long
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025, at 15:56, Patrik Weiskircher wrote:
>>
>> Here we mention "-S", but that flag isn't implemented yet, right?
>>
>> Perhaps something like:
>>
>>     Optional parameter handling only works unambiguous with git rev-p=
arse
>>     --parseopt when using the --stuck-long option. To prepare for fut=
ure commits
>>     which add flags with optional parameters, parse with --stuck-long.
>>
>
> Makes sense! Changing that. What is a good policy to resubmit
> something? Should I wait longer? Sorry, very new here!

=E2=80=A2 Force-push your branch to gitgitgadget
=E2=80=A2 Edit the PR description with something like =E2=80=9CChanges s=
ince v1:=E2=80=9D to
  summarize the changes
=E2=80=A2 (`/preview` comment)
=E2=80=A2 To send the next version: `/submit` comment again

I think that=E2=80=99s it. :)

I don=E2=80=99t think there=E2=80=99s a need to wait if you don=E2=80=99=
t want to.

--=20
Kristoffer Haugsbakk
