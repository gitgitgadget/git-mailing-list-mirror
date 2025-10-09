Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC572625
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050626; cv=none; b=rDiCTAoVjTVJanB0mjMKUZLHPitqCNf8a/EaltIDiNXfXI1heDpwJGWyCzoUL1R2vTg53y6fNPxZiyurRrdy7o6nmK1I+K3jI7ozqpe/85oyPTk2G2iBVDwZr1jkvrssCUU6UQq9ltV4EqFahclbAfWB5/oeYhj7XmcNsNqG5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050626; c=relaxed/simple;
	bh=SCwNKebcJP6sArbguHkIGauaosK5USIGkhZipWfbBhI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GfhqqNvFev7OWJB2esvpKNysnMCbWao2aYf7l6wQNrRRdUv+abX84GURV46zu7tbVRHehALZsVTyna5pIErFtrcTrCd9x8yIhwdHN346w5OT/LC2feMyuzSlg5Paev9Ow1MmdJCRs3ijt9x7Pra9YVO6eQNJ9wGK2/4O6NLes/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BXqnSKvI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uyrkAex1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BXqnSKvI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uyrkAex1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B878B14001D7;
	Thu,  9 Oct 2025 18:57:03 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 18:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760050623;
	 x=1760137023; bh=SCwNKebcJP6sArbguHkIGauaosK5USIGkhZipWfbBhI=; b=
	BXqnSKvIwf+jUCZq0JysI7pSj9s5jKBMKA4FAlYLSjuI6h4xt7ZeUMlbkkepKrlZ
	CaKM4czwpx4JZnHBm9X0fPv32kuch+Ap4IckDM1WCQLBFqNtXBtLi6mYzwePQ2Mq
	Nr0oeGyqEJdchH/wyiWyziQgqZIHDnxSaD8YTsEzNJoFNmWL2wARsS2bjDq6thwi
	wFydefH4ZhpPIL85FxPohSjDZleNgHIocziPwJzPFxqICY1Snj4DzdW38zLy928o
	Qtyn7IvyahqehJFasphiNTaamHxh7Y4MuP5T+bcKdkr/aheKR5NHA/XJGzPGDS0/
	ApxpRyXN2ItBuzjYUSlE/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760050623; x=
	1760137023; bh=SCwNKebcJP6sArbguHkIGauaosK5USIGkhZipWfbBhI=; b=u
	yrkAex1KRjlzWy+2JaH4Qm2I/PX0ZysskONt0QI9T9/2RSb8/4s1vqwmuGsfdPcK
	ZrG5h1N6ER4R8uSMA5OAKkHUdebk5Ymh2nFHtAuAkySZo0XOu+phH6szNAWBcuXC
	M1NquEvQAN+WsgU+yZt/tSqX5Hod+69T+8tPpYVJ3rcIqRJosLN5FA1hB8FDxyyJ
	iMpH8pDn9xmD/7/TdN9n3CJqR6hE8e6qZSLur/dzwkM9t3FJadMucS3qmwICmDYi
	O3qtIm9CNtyTKCvDutneZYGOx9CX6y/iCx+bkmj1ymuSmxSY5vfIblXuq2ij/Rnz
	ij2x8mf35YRJjrH8LI1gw==
X-ME-Sender: <xms:vz3oaLGR-RHfhfcZI9oZ7apWveglWwUjuf6aigQzLP0zBcf8VEyywds>
    <xme:vz3oaDLi4oh1fAALTpZchoPvBvSjaAwvTF6JtED9IqzjUSOytRdS0Imz5BEYstLp9
    tTGcY7G4bNBRIGA1wGpKGCf4gVjN2IUKuBp5s21RYSzWLlwb3Vi5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vz3oaCO_l_BeC5cCXkfC62AGHvhAe1nQ38v3L62DWI7PJvqHUu2LCw>
    <xmx:vz3oaMYhMKMjNXoi_4eYYTCPeOUKpbvup56aMipQokPZVir6t5rYWA>
    <xmx:vz3oaMxYSRh9OAA7MHn7i2A3xx1Wqh6st6k9e4oCyN-WROg4cZAJHQ>
    <xmx:vz3oaHL9PhwNc8-XZGLSG9aTVq5N1NYIeDuWqbzRy-fWaO6ig_eTXg>
    <xmx:vz3oaIAuNZM4nqU8mDcwumzWoUwHvRyWywc6GznZD3mUIyxoMRVAFPq0>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 308A81EA0062; Thu,  9 Oct 2025 18:57:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: And9clSpnOi7
Date: Fri, 10 Oct 2025 00:56:42 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Johannes Sixt" <j6t@kdbg.org>, git@vger.kernel.org
Message-Id: <851d8c3a-b812-494f-b981-fa1bc0990428@app.fastmail.com>
In-Reply-To: <xmqqjz13d9fy.fsf@gitster.g>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com>
 <aae39545-461a-44f0-b01f-bb40b53b1858@app.fastmail.com>
 <91ddb8c2-ae3a-4b13-a23b-e5cca172ee09@app.fastmail.com>
 <xmqqjz13d9fy.fsf@gitster.g>
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025, at 23:58, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>> By the way. I thought of adding a stderr warning when using this opti=
on
>> on git-rebase(1). But I don=E2=80=99t think I=E2=80=99ve seen that us=
ed in this program
>> before. If so, why is that? That=E2=80=99s more in your face than jus=
t adding it
>> to the documentation.
>>
>> Is it about people parsing stderr, maybe..?
>
> Standard error stream would be buried in other progress things, and
> it won't be seen if you are "rebase -i" interactive, in which case
> the first thing you see is a full-screen editor with list of
> instructions
>
> (where we _could_ add new warning text).

Ooh, that sounds interesting. >:)
