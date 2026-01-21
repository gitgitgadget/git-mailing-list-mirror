Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434943E9ED
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033691; cv=none; b=qvoWM2fdL/AYciKw4c43joa9YE6HKrAAoRrQgxW9aFqT9MV87c2jv/9RGfoZdrqx2cOe8XpZELb9JKirSrGGW58hS4Rdz9I60ZLeueQWNtOQ+VcrM2fj+IunmyGb17ao4yhZAGN1Z+BeHC8M3YUI/C1xBO1ZqOaeXc4yzZ21/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033691; c=relaxed/simple;
	bh=RLqaeYkZXtGdPfe5aB510Q8bLAo614mYGNqIRw6E++0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XWeNhg650iXDPlp6hqIyCT0ejdVFSMAarXf9Comme+pL6szhPtQ95X6Qne+Qmbkbso0Sv+aM0RhEjDaU+x/aRZ6Q6E1+Ode89eDKDrdpuYh5zXNEvi3yFCZWx8c4/Rcr9wP0iCxyF65m9V+JTqrph9ZpChkUqFuqGCwAgLp6WgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MIzkc2BH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iRTv35WT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MIzkc2BH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iRTv35WT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2785C1400172;
	Wed, 21 Jan 2026 17:14:48 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 17:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769033688;
	 x=1769120088; bh=RLqaeYkZXtGdPfe5aB510Q8bLAo614mYGNqIRw6E++0=; b=
	MIzkc2BHXEJdiV4MHZKm/xLQJtDhNCmOfGIPZdr2a8e3SXZCbISweCt7or1m2FPi
	z1hZrUPlaDRXGQGOI95d23zMSpv/BZz2FUY/+BTTsZImualE/tw9IACPC/rDnyOZ
	ruxpiOk4VtlTPFsrrQ7ezkb+jBta8+oZwjIf3SEUmy7CjxkCyMUXE88cmkkoXzFb
	OeaDIuMwnRrMDUnWlf9N8H2Nn+PIBvVzFnppMTI6Ak4NTjQqv0XvSP611c6h7r3h
	F0ouXseIGz+HQFrmMs8xZrOxrqe75M3DhNUEBpWs6cqt/e7uKgvjBR09rXs4X8VS
	A5iUDJu1ycGSz7cfXX/gMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769033688; x=
	1769120088; bh=RLqaeYkZXtGdPfe5aB510Q8bLAo614mYGNqIRw6E++0=; b=i
	RTv35WTJqvOZxIF7seyjzI14kCLTTXEDwK33iro4GEPZqtQbc2hpNL/qJRtSDdNU
	zBC4WUOGihHoiUMVqNeX4F29gt/7bCKJBm1zmeLyTxa+b520n1f0KrG58JM7xNnG
	o0XhzgqFJPdfRKlLUPePoV2U2sMcAASZV0QHgVke3Q2A9sejawzP21O6ujz7ViaP
	q2lhts/dmgnYM43A0kek96HmG0pp5Fr0TqxNG4lCR+mqsjlLPihOKzQBzazgd/ji
	jF1NqO2w1i0RaSwvDtCI3q+3W3gGhan9Qf4a+RYwROauIVwq9WC/NmtLBninblOk
	kdHzj5XNGUF0bOocgszWA==
X-ME-Sender: <xms:109xaXFJlzPhg0IT__1DMm56_88a5qUGndvgGqBZv5cuygsqrpNySfI>
    <xme:109xafKeIHGHLZP0ZC5BojGgwYjGmWclGMYtoZ4ghXycgcF4Oivcr4kn11KyaUK8X
    xiP8KYDfMY97Bzp8KiT7nNbzekKC2mtWbs-zQ_sZY0mmLstfGqygQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprh
    gtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:2E9xaWaYbIxySnoD-hFcd4IJM_xk3eUjL8hv6bKhKWYDiFcgRbVsCQ>
    <xmx:2E9xaTalGcL7becq-_KlVmak0ly9iTR6hcbyjGZBZOdlRFsb38ho8w>
    <xmx:2E9xaXlqYPkorX_TEPeVeCrl6PwCJ6RO4ucCSIwAf5DrmvVk7VoKxA>
    <xmx:2E9xaW0J-sNxZiHNJ97eXy1Pr6jJTB9snN-RrDFcj9IytYBMQy_FrQ>
    <xmx:2E9xaULUXyzLi3cPzwTLA8KvG1jXn0xV5-VGkXeO4bWc4uuxY5e6S3bg>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E4CEC1EA006B; Wed, 21 Jan 2026 17:14:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfSC1qETFHyR
Date: Wed, 21 Jan 2026 23:14:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org,
 "Jeff King" <peff@peff.net>
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Josh Steadmon" <steadmon@google.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <376ae697-efcf-41f9-b92d-e62ca12a77a2@app.fastmail.com>
In-Reply-To: <20260121215436.1473800-12-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-12-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v7 11/12] receive-pack: convert update hooks to new API
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026, at 22:54, Adrian Ratiu wrote:
> The hook API avoids creating a custom struct child_process and other
> internal hook plumbing (e.g. calling find_hook()) and prepares for
> the specification of hooks via configs or running parallel hooks.
>
> Execution is still sequential through the run_hooks_opt .jobs =3D=3D 1,
> which is the unchanged default for all hooks.
>
> When jobs=3D=3D1 the async muxer thread reads the hook stderr and writ=
es
> to sideband 2, so run-command's poll loop is avoided and there's no
> need for ungroup=3D0 when running sequentially (Jeff's suggestion).
>
> When running in parallel, run-command with ungroup=3D0 will capture
> and de-interleave the output of each hook, then write to the parent
> stderr which is redirected via dup2 to the sideband muxer, so that
> parallel hook output is presented clearly to the client.
>
> Suggested-by: Jeff King <peff@peff.net>

I don=E2=80=99t understand why the new (in this round) trailer is here. =
Wouldn=E2=80=99t
it be better to put it before your signoff? Now it looks like Peff
suggested something and then Emily and =C3=86var signed off later.

And I don=E2=80=99t know but `Helped-by` is often useful here. This is a=
n old
patch that he improved. To me =E2=80=9Csuggested=E2=80=9D suggests that =
he proposed the
idea for the patch or something.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>[snip]
