Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2428286D4B
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969071; cv=none; b=Hue6qXBq3mzwUXI1xOiBahScEDS/6CkNCjMLRnN+IYF8o5dkYMaJKJOx8Lc88zC3ahm7OmNJXov430P3FqOR2rEQtqmtCP0AdGEWWQfZo6d/c8bocTTNjntfCNCNeu7XevHlGFaGaJsuBZ2Zbb8EdNLn8svYFoqLL3gqx9zuhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969071; c=relaxed/simple;
	bh=pWWzIn2AhjM2VAP6PZVvPEHMvXRaZk4cUbXiVDbggLg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tNIVwl2liTIItBIuD2NiVlekaj56OdEPz1f51b8E0Zc61TX58gAOpyTWPmUSopahYCS4k869giCJN3rLVz4zuRMlOnA8g1AbXuI1RBb50+hi9zXF5Hcl8Acky8exjxEzyWhmaiYaenM9zjsenoQgQOGTvDOD1+XIMj3kSp34uyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EFdjrqGJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gnTd6YIc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EFdjrqGJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gnTd6YIc"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DE18E1D002DF;
	Thu,  4 Sep 2025 02:57:47 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 02:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756969067;
	 x=1757055467; bh=pWWzIn2AhjM2VAP6PZVvPEHMvXRaZk4cUbXiVDbggLg=; b=
	EFdjrqGJU41JC+SIVpbDK6FpY5Tmy8dfnbSdps4qB9w+YB0MZsWXU0t+xt89mOtH
	oA0hCq4vawBGb1PjfoHkVE7Cp2u8nLsLt314JULPU+p9dKNCPREAfqd4vi221SIh
	n9cczBBHZLbP+DF3tsJz7H97m0JQ91UQBz96JUPUCR/Eb6EGxQxjEdjnOE9D2Iy2
	vu1bwXi6j+Jwl8AcQo2GHTA1xuZ8bGQER2nSrqYs4DLTyGnV0m/RXe68cfBXOrCm
	R/vddoiieKWFQWSwMQc0K2KKA5X8cGL2rNh9agCTr8g1Kd90/Zx4hu91mv6kFmPZ
	+15uiQS8HCHlg1LtBEfgAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756969067; x=
	1757055467; bh=pWWzIn2AhjM2VAP6PZVvPEHMvXRaZk4cUbXiVDbggLg=; b=g
	nTd6YIcvrnCTFeL/w0FmeFUWzuOktzi8OJzX3jfBKLbSq7MWOpcD4PISlaDnAxRJ
	AripgptpFF2rvDmVAU/UCTW/K2/dmutfWLItIlSFBFsrICMp4T184sVudKjvfOUd
	uxqE4E/d7MZ81Cvq6MOqc+m2Vd9Kh0xIRXIKYzd1zAL0AZ2gMZ9o9Pgg5U40PzcC
	MlgReIqR7SO9Nh4HQjmMz4yCz3IClBXnDjQXugmZ+RpzgstfyMOD78nv0vhvXaN3
	Umvt3trHopds0UeOsoxis7+AayEJAYpSX7CnhyznRhcvBHWo3LbPqb2dy0dE5A2H
	hAsPWYjaCedGEkGaG/BBw==
X-ME-Sender: <xms:azi5aCY9I660jUglLzqk9tYzy8rWu0l5H4RwsQcjFl7M4ee52qh95CQ>
    <xme:azi5aFZJ72g7A-Sqb0D8UvCAnibfqzif7au2ixBy3hCRRMbUsld_ZaFHhov7Fxfs3
    48kMu4VW-JAP0wnNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeghfeu
    tdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:azi5aCjeBXM9bq7rUUjCvAs5RFqeRnAvOXQlfuKTsOMUFVp3pa-VWw>
    <xmx:azi5aMe8OGnuNzdl6yDk7BmpqL_IeNMEuyho6A2Nciwwea4UyGwbqw>
    <xmx:azi5aJp4za591h1sKHwviaS_Z3n9JtVDTSNMHgI3rvrIJkQm5BteRA>
    <xmx:azi5aBDJuUmtb4mzRqDIRKAXWHX3n4NxB04NuRQHyU8GglP5oAW__A>
    <xmx:azi5aHQlFDZ7KIM2XbWLFmdVOWu-adxmiqFxDhHF5LOs_fXYw70fAXyP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 627D71EA0068; Thu,  4 Sep 2025 02:57:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMHZM2JIZMZV
Date: Thu, 04 Sep 2025 08:57:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>, "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <9845fa17-1b15-4aed-9dc1-c1af21709c2f@app.fastmail.com>
In-Reply-To: 
 <CAPig+cTN9vwoquOKCRz9TXRLtwHaxF-mL6xbbXxUmoHxZkW5rA@mail.gmail.com>
References: <cover.1756311355.git.code@khaugsbakk.name>
 <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
 <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g>
 <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
 <15bb8d07-675b-4ccd-8345-ab5861319faf@app.fastmail.com>
 <CAPig+cQdwr-a_B++=2+q4mV8oZ7VLTYEQ9wnVP84jFYkTHFtHw@mail.gmail.com>
 <20250903214415.GA1915988@coredump.intra.peff.net>
 <CAPig+cTN9vwoquOKCRz9TXRLtwHaxF-mL6xbbXxUmoHxZkW5rA@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 4, 2025, at 00:11, Eric Sunshine wrote:
> , even though I didn't specifically mention it (though I probably
> should have)

I thought Sunshine was supposed to illuminate.
