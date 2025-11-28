Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDB332903
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351376; cv=none; b=S0fHU3pNiqvEOBvipvyVUGEW4gSNrUMy6Fb6OQjPUM34dke9gLmLPUrtL8WEgdFzIac/DbYYfVi8H4UNGp0/7ouDoMzFAy/bmDNkGlx5zSxgYd8J4hXnn0UKlne6Kq3cak+sPLjWMuIvWa4E55RKxTIim/Fcb3Pi0CtAfsfVwNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351376; c=relaxed/simple;
	bh=sfwz7ZelXRUIDY64YUGLra5GCKhNZcO+s0DfM4Xdo4o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ag8p3pSykm63SKIWpPH0uOJc8ZqNONKhEUmD4wy7Fz7vry9ntxNIcya9N3zM4zxdvBVfB0z/z0LC8PfIlMtyR94k7SExjZPI8QmIMxK/qxSxnNs70XXVlE1ike1XUAeDVWplepR3ez8i55Jv/ixN5HAfaKaNsZhtJ6ydcmhSqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=n/Maei86; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r4H+38u6; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="n/Maei86";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r4H+38u6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 661BB1D003EA;
	Fri, 28 Nov 2025 12:36:13 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 28 Nov 2025 12:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764351373;
	 x=1764437773; bh=sfwz7ZelXRUIDY64YUGLra5GCKhNZcO+s0DfM4Xdo4o=; b=
	n/Maei86tWV0Rfg6NuxC+Z/xxYXeVi/ZulDuZ2cPYp8dh4JVJ6SxAyasXSBQ+nXl
	vx5ETlDG3sfl/nnIzkE/5Q6eEdlssuu35K34QAAnEyAnR8J7Z9aSfQiKnECwP1ct
	Fn1CVmf1XFpuj75vD7yPo/t8UlAJhR4/yawFsyWbM77RApQj7qDHeYYGlLbyS9Nt
	ICqY8IwMz3zuxe/WzVgYTk4z4+6m0IaiLsQwt+mzahqWmwT2AkLDYTD/kESVHCZB
	0od+1SDtj7Ao5d3RGv/A3y00Vz67qsVvpT0pSdL+bUObImu0CibuV9QHf/QL/261
	l4zuf/oVPz4coZRD8YAXkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764351373; x=
	1764437773; bh=sfwz7ZelXRUIDY64YUGLra5GCKhNZcO+s0DfM4Xdo4o=; b=r
	4H+38u6ILsrP7ZoRguIEC4qXQ+vwhAuCwkuV6pyctLugcit1wQ3rWipK8Jvfu2Ph
	QRlRYfQn5Et+nBe9DSMRPgUjdH8KAxiFYczaeOBC4VR3xzISunhHKrqJ9F037PeE
	deA+T5QMxoaA04tOMKH4zUxKsK/fc6AWoJq5GCX2lCq+fndx/rT/xAeYj72xNAWQ
	EZmiXRfS4bMt1sHFdMPvLQz1cRj08rsWm83JHzFsNil1yyXXZUjtaY7ha6oFAFFU
	Y0kXr6jznNU+BcEs23id8Rd7M63l/mNnZEm0wY/+GnSy3Hwm+4a7jhGHdUxPYiQQ
	GWpXr6HRCyszdv8p1KnsQ==
X-ME-Sender: <xms:jN0pafVPzc40eM8Aa149_Vx5ronsDser5QVUxzqp2_tlIwcqCkrt7jc>
    <xme:jN0paSb9q4q5l0ADlaq1X48UZO0P_eH5SQ_ZjwpwDeVhOC4_pvnN1ti7PEHdQ_fRe
    1sbmhFjkuxO8AQ9UARMP6ts4ULFp4sKhJxytFlL9wBo7k1BDatCpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopegrnhguvghrshhksehmihhtrdgvughupdhrtghpthhtoheprhhssggvtghkvg
    hrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jN0paU5cS7orXvHkC7mmV4Sp6u53Ss2TZXbPU5ZGapvid0-xUXBx1A>
    <xmx:jN0paXaLjUiYzsgi9APuKo4vAhVjPfS7uS4hoDbjkJdnL1rMTqgdeQ>
    <xmx:jN0paTgibinMvtkxRRqp8ZN1SFLdDk7WFWvBfjrFj1QnQ-DLjb-uQg>
    <xmx:jN0paY87P7Z7xaTZJjXjLtRWfpI325ep0wKjtpnYa2_5dtFmLOIW4Q>
    <xmx:jd0paVN7QDWGPN9smeSt38PC2skAEMhvl-OYiCJRK_ogMfBtJOLYBjI3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 67CB91EA0066; Fri, 28 Nov 2025 12:36:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArU5Rl7MVZ7F
Date: Fri, 28 Nov 2025 18:35:52 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, "Jeff King" <peff@peff.net>,
 "Anders Kaseorg" <andersk@mit.edu>
Cc: rsbecker <rsbecker@nexbridge.com>, git@vger.kernel.org
Message-Id: <a7de959c-cedf-4a24-a45f-a28939ab5125@app.fastmail.com>
In-Reply-To: <87y0nq14xm.fsf@iotcl.com>
References: 
 <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
 <20251103154726.26592-1-toon@iotcl.com>
 <4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu>
 <3b24b6a3-61cc-4b9a-a823-f1e58fd9919b@app.fastmail.com>
 <ceacc47b-9d29-4e32-9d83-6bd68279c83c@mit.edu>
 <20251120081611.GC1283645@coredump.intra.peff.net> <87y0nq14xm.fsf@iotcl.com>
Subject: Re: t8020-last-modified.sh failure on s390x (Re: [PATCH v4] last-modified:
 implement faster algorithm)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025, at 17:45, Toon Claes wrote:
> Jeff King <peff@peff.net> writes:
>[snip]
>>> --- expect=C2=A0 =C2=A0 2025-11-19 11:29:03.492349022 +0000
>>> +++ actual=C2=A0 =C2=A0 2025-11-19 11:29:03.648355864 +0000
>>> @@ -1,2 +1,2 @@
>>> -b5 file2
>>> -b2 file
>>> +da1857e0652b6f264c0038d684ddecddc273e506 file2
>>> +da1857e0652b6f264c0038d684ddecddc273e506 file
>
> Kristoffer, thank you for reporting this bug. It seems there was a real
> bug in git-last-modified, which was uncovered by these tests running on
> s390x.

Typo. r/Kristoffer/Anders/ :)
