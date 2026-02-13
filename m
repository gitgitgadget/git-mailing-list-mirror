Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446B3C2F
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005733; cv=none; b=fFWSV54HeHx9T2lnwJUtD8c4RLTb4vl5YN+pxcNjOz9rvAVIi4bPXIOOulRCswYl2PCWv9q47apethx9hWTBhASp7S4IQ8m0oaHlHSw5ItVHa7Jr8kp3PhaPQP/DiEszHmqqcpGgWqN7R+qSSsVn+RuKGLquFFlOace51pL8opE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005733; c=relaxed/simple;
	bh=PyjzooAbgGNqFILkROMlGdMCoHoAIExBZU7kX1ReyrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=my9FOPda3UcaODgfybxYOc8sJWoYAK1TtbVl0tSo7r5uW6tq6RajLhkUBXrLd+/Gv3A/m4dh+XMqaiaaMuKYCu669qV4X0h0hMoXhqVbZIVC3dyLm5rK9In/Uj9dsXg81MfvKRRZ+LFNkUseKxptyvbZ/F3BZ9VuhSBW2D9z9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HPa99vwb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwVitu24; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HPa99vwb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwVitu24"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 664D87A008F;
	Fri, 13 Feb 2026 13:02:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 13 Feb 2026 13:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771005731; x=1771092131; bh=JmxboOPoja
	KnU32M1cwJqM3liFMesFlHZY7Rbf/GP6k=; b=HPa99vwb9qbD4pkeYiU6iSG3sk
	wxKxE8POf6xyhEtJyb8XIPW/UcVfMx4wFvDDgNcRGCxvAJOJ6qBgEMNf+2ryUSw9
	yZKc9LbHX5LR4vojwu0fOCv9wnLD8aTbm0lK/SapiX+NciDTD/65C0aQL+tjht4f
	CyrASKzdbCpZznqO1pIWnkNMWakjuX9dCHmjeozh2V8xKTvmRH5Gc9/7yC33J8Zt
	5GbMAIIexRqUMfXwaikOTjTiW3MV/dh/Rrcc5iUi9vVDCIkwNE3j2x9WQwIgK7xl
	FKNe/5y5IgF7TI4z1ox6TxBiF+dPQYFZ9pKYv9h/KC+8LUHe6+mBcAcgwf6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771005731; x=1771092131; bh=JmxboOPojaKnU32M1cwJqM3liFMesFlHZY7
	Rbf/GP6k=; b=HwVitu245us51c6GyeQeLBP0WVre1MGQ2KU2Ha0R4Shr4R75DiW
	9kTmfW4A0yR95F3QXZxcZl3D+IwvJNxF3KzwCfFoWqd+5nEpqu7nuR9gOxYQij8h
	cXo9ubIwLaTS4wsq8I7uM0tzPJocb1gMWql8R6xD557SYgfWnM/GsHG6BLqBnRxV
	44r1+EF3ULB/vfUdcU8yJTWMZx6+l9yf/toM/wGwt9s1QW+D2PyR3nuUThrFX1K/
	x+UbqMGMQYrybWS/U3fHs8NC7lWLCJM8S/tLNqz7KZI+MHjIhxe169cPPcSG8eAF
	jt6c5BPiOhTIjPvDvKSXMLyDbanNDYTNlmw==
X-ME-Sender: <xms:ImePaXG5KXi3tMQxQMNPBsOnlhMCB0IdM0_w0VMsnwAw87miy3ltxg>
    <xme:ImePaSkBBPv-13q51WbA-9lsl85ZUWK-RrjkaCtgOo7m5C5zVWZTTAaTSc-HeamFl
    4ezQUX1rKgLE-HVPPSt0tWCafpBsKcc2FVVNIBii8DX8yze2UDbVw>
X-ME-Received: <xmr:ImePaSeY2RAeNuBJ577i8n-73Jj_SI_CLs5puQ3Jus3khJh3nQGNSncss-ty9qyIr_U2s-ZItMLh6e2UT0cJbL_a76-pDwPgPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphht
    thhopehmrghilhessggvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtoheptggrlh
    gvshhthihosehstghivghnthhirgdrohhrghdprhgtphhtthhopehmrghthhgvuhhsrdht
    rghvsgesghhmrghilhdrtghomhdprhgtphhtthhopehjuhgughgvrdhprggtkhhhrghmse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhurhehrhesshhurhehrhdrnhgvth
X-ME-Proxy: <xmx:ImePaYGlMbgsbtomB8IKYYrtMF4ioqm9xLrJuuutJYgvlhyYCHndrA>
    <xmx:ImePaQh5jEgUTzAbn35R1MmnLb_muBlibt4oHA8JVYhaQxFgBCI0JQ>
    <xmx:ImePaU0jHlkziiZQ2BGViS6wPNHKU-HB3ogWQFNL71lPUID_CxFZJQ>
    <xmx:ImePaTdv2R515MvvY3tX67SYQ4tpfFYKST8CbVGBndlEvh-ZiAtnqw>
    <xmx:I2ePaTgyyghy1T8S0Dy0qhJCya9i1Un8iUBg-EV__0KskBRBO4YV_C6c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 13:02:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  Matthias Beyer <mail@beyermatthias.de>,
  Christoph Anton Mitterer <calestyo@scientia.org>,  Matheus Tavares
 <matheus.tavb@gmail.com>,  Chris Packham <judge.packham@gmail.com>,  Jakob
 Haufe <sur5r@sur5r.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] doc: add caveat about round-tripping format-patch
In-Reply-To: <0484697e-4c1a-4f23-9cd9-079d92dc8bfd@gmail.com> (Phillip Wood's
	message of "Fri, 13 Feb 2026 14:41:43 +0000")
References: <V2_format-patch_caveats.34b@msgid.xyz>
	<V3_format-patch_caveats.354@msgid.xyz> <xmqqtsvllfdc.fsf@gitster.g>
	<0484697e-4c1a-4f23-9cd9-079d92dc8bfd@gmail.com>
Date: Fri, 13 Feb 2026 10:02:08 -0800
Message-ID: <xmqqbjhsmsin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 12/02/2026 23:19, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>> 
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>> ...
>>> All of this is covered already, technically. However, we should spell
>>> out the implications.
>> 
>> I've read the new text (without formatting, I have to admit) again,
>> and did not see anything questionable.  Nicely written.
>> 
>> Shall we mark this for 'next'?
>
> I'm happy with this version - thanks for working on it Kristoffer
>
> Phillip

Thanks for reviewing, Phillip, and thanks for writing, Kristoffer.
