Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED122541C
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802715; cv=none; b=PdxGa8RHQ12kyxQTfIulqKUHFVFD1HBcBJrCeGuc3GCDYTQb8pPAMHDLCMVb3+xAPllGWQHCMDp0E5sa0AJRv+PxVKHmofMam3gSWjMRCD5azcQsONrr1bHX3A3UfY/dv5sr8mUXJbanQj4bBKoXno6wHT7fMSS8OevD3TdMSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802715; c=relaxed/simple;
	bh=cqAz1eFTz+p/ou3vauMzmR4f82icFtEYPBU02MCdn7w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DOz5s43e3WyeDmqe8ZrotMuhAy2q98XodJdQrcvoDn3d/9u/vEAwgOyJrCNe6qNEwbOaCDg3O7W9xjxiE8HR75UK16Zn8Vxl0lHwnPSdf0bEDoiASVbOD2FffaGVFBMIVtXoXC2gZVqC1nJTAwfLNgCoCljSeDCUk2ijLynyk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kQrPJZFM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I2Wn1F9W; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kQrPJZFM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I2Wn1F9W"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 062E41D0009D;
	Fri, 30 Jan 2026 14:51:53 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 30 Jan 2026 14:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769802712;
	 x=1769889112; bh=cqAz1eFTz+p/ou3vauMzmR4f82icFtEYPBU02MCdn7w=; b=
	kQrPJZFMUtYAynXfryLRPAnJUpShiAnvGKBDYHbTNCn2MYj19Sfz285A6apHZZRw
	IcWmhvDDr4fFMoetqcVQyHFAcZYLIMwz9O2M/O4vD9gu2vm9gGstAPsDhzEsLh7a
	0RyRqmycLQ4U3nSVLRGvGPQmwtCP+MN4fiEqkJeQxsq8rS2UMXN4DoBisNtgsWmu
	xw3Vnu75n27Iq0foK/2+tWJ9sMOLn4pa09cR8IXXX4hxGSLRxBASCAXtFkGF+twu
	yYXcENQkLA7TWbEuVHeiRACOrCAIJOJAHMquCTTA8/mf05v/H/2OzhXqCwYMGyNe
	QZSN82kCm60qQLLTp2gnDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769802712; x=
	1769889112; bh=cqAz1eFTz+p/ou3vauMzmR4f82icFtEYPBU02MCdn7w=; b=I
	2Wn1F9Wdlz/DDGfIn4ED/LbQMoF0Nwc0e/DE42pXMm9klB50hd6NsYFZ+Z+52XOB
	PyDBGRVYv3mUchOPdLZmedf5QDLVlkemUOnFQvmWfsB1jp7Sjx3KFagikkVwkCW9
	VRWaXu/hYOMRaiIRKA4qnxBbYVB6n0O/7XMFCKpeZuzpAKAShyYQqtJBJB0ADm6m
	f1YjT6wMvbumP/RimwWK7PAVX1xoRROW5KLuL848YLSd5xBPM3DOyLbLQU3Ij7a4
	ReHezCki1lDl/T8daARp6e12My77CClY3IbhEmCXF+XhhDjobt3OBTPVo55q7XAy
	HMm1i+EFh+1DFZ6Ld03hA==
X-ME-Sender: <xms:2At9aatWN043uCDJViF-6_O3K2CGsanJouianwcbq0yCJSzHUqrVOjk>
    <xme:2At9aaRcoBCImBx43_8D-alcsVCUOdCGG5KQgDvx8sAh4t1TXvRfZgYjLkfOnVZjm
    6h3yZDLNASKrWC-RS0ZNtUIm62tyFG5V2sGZYEIpc_jD6L6f7Tniw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhhhhhhrggrrggrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2At9aUZnPUf8EA1eG2wuNjeZpEaZ1QHZ2dF0_DI3jWcfPu_JMOCLBg>
    <xmx:2At9aYtMY0yv0d-BQ7P2hOrVjVg57RhHhiymaxR0V6DonK8_rzpwCA>
    <xmx:2At9aWNIpj1oyOz-JfwVLav9Hk3ClmDY-vUa53xi847PLw2WzFhqIw>
    <xmx:2At9af7iScnQNE5lNNhPmUc6i5HaMlyFn0Ix0EcMfTY1gFxO3kJeNA>
    <xmx:2At9ae0WZAIcvRZDe-8yhhEhMVvdsgDzLUYXpE0hKxumm9cVxMeGajOq>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A64F1EA006C; Fri, 30 Jan 2026 14:51:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANOCvevvNm9F
Date: Fri, 30 Jan 2026 20:51:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Amisha Chhajed" <amishhhaaaa@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>,
 "Elijah Newren" <newren@gmail.com>, "Jeff King" <peff@peff.net>,
 git@vger.kernel.org
Message-Id: <e01f307c-3d7e-41b2-b62a-f61b1dd17640@app.fastmail.com>
In-Reply-To: <20260125201500.63904-2-amishhhaaaa@gmail.com>
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
 <20260125201500.63904-1-amishhhaaaa@gmail.com>
 <20260125201500.63904-2-amishhhaaaa@gmail.com>
Subject: Re: [PATCH 2/2] string-list: add string_list_sort_u() that mimics "sort -u"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Jan 25, 2026, at 21:15, Amisha Chhajed wrote:
> Many callsites of string_list_remove_duplicates() call it
> immdediately after calling string_list_sort(), understandably

nit: s/immdediately/immediately

> as the former requires string-list to be sorted, it is clear
> that these places are sorting only to remove duplicates and
> for no other reason.
>
> Introduce a helper function string_list_sort_u that combines
> these two calls that often appear together, to simplify
> these callsites. Replace the current calls of those methods with
> string_list_sort_u().
>
> Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> ---
>[snip]
