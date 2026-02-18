Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8312DC352
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431013; cv=none; b=axJ9CaFY+Hn/raVQJCm21QB24jARQmlDDKz7emQFarqHtsoQ817iH2LBOEI2mXBKGFazCPhLZRNyx+qZtn4D+uY7r4T7BpMVizMnr5tRjxEZ6gXRxda+nU5eMFf9Qp2jD9+MP9pu7X6g0Dq/IwCjWtI+9a4/uRly+Y3GgRapvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431013; c=relaxed/simple;
	bh=89ZBoH9Lo4SamYf6EERWznwWDXzwQG2HNQhpJjMlb2I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lA10MaojG+hDyfnbATm+5JakpndZsZFj2gv5oN8okiM5H8srn+cNanGdQaNmnCCFP6npx5xEspj8BOBhiUMf/U8jjyvJ291G5Vc9G7yGjJVQdWOsg3sv+f7+bRaidsYkHZd96PbC8ANUroNS8/okGEq4jxza1UCNyHdXaBu6mTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=vNGYQ9VY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=avAyxg1M; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="vNGYQ9VY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="avAyxg1M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B12A87A006C;
	Wed, 18 Feb 2026 11:10:11 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 18 Feb 2026 11:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771431011;
	 x=1771517411; bh=89ZBoH9Lo4SamYf6EERWznwWDXzwQG2HNQhpJjMlb2I=; b=
	vNGYQ9VYd7tTgbOthYX/tRr3LNZeNuscVwrE+GYAygLuDFNJwN/8FgW8b7bIiFx5
	CSsYAcGjrRWgAH/jRFxTIWONsRLeNIeJOQG6ieVKztYPbuOXncG3KnJyTynRP5IY
	9nr/I/xXFQd6ICsmXyUVKtDeqON9fhkG99nDMBh3P+QWaBpw/8XFhipOLDtEzB/i
	/kLNjiaRUoehCEH15/y2h7iDF7J3CTFkwpfDUYCrg1cGKbuquCaxYZcnDxNBtOrF
	5Mw24kTjPqi1loZLWLH9i5lIuNsuEpn/vHBdRtUTbpwSb9EGvYbDnEEE6HFiS3n9
	5X743FIq5wZinBWlWyMXww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771431011; x=
	1771517411; bh=89ZBoH9Lo4SamYf6EERWznwWDXzwQG2HNQhpJjMlb2I=; b=a
	vAyxg1M+LdgttXYqCZ0X/b8uVS95R+DNIGUxaph2nC3G2Ln6RLdFojrYHL3EqEB0
	m39JC67DrWpsFzDlx3XanDIr9AZnM7MEV72wnj6lcBSNrF4+2iZV680JnMr3oq1G
	2TJUBaJwCHJs0xh2KqljbTE2phQuePIdMja3Ubbt6YLUO1l/A91L/5K5SLfAZJ7Q
	uN6niACc/MilJBxNCp4A9HYu/kpDN/REUztGrZtXM0FU8M59YctIBjNww3XcJoF/
	Ymd3vfCFsJTt7b3jz/XEvNDCw273gcPt64pkaIaBoaoAWhSQcncuUskgp0/qwJJp
	omrsK+eWy+/bfEhC1HRog==
X-ME-Sender: <xms:Y-SVab_gNnfUPAF-vLTYhmsVZgVcQK3L5ljJy0rAxe5AYya4DLHGQTw>
    <xme:Y-SVaSgf7L0xL_5PUfh-ioDKuTibbx0PB6SmtSbVvpmSMUHk5CHX9z6gbeVrITalq
    4hmkxS9pR8IURCdsM1rANWM9U3KhqS3OLCkrprFkLvX43kPMzqNLdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:Y-SVaflLKgGyCieRDL9WsNxrENxqPc80AiQqYmyvhyXkR-kvOf3ehQ>
    <xmx:Y-SVaQod8E-DuU64uqMNuGJLyIdsH1k3q6resDY2TtsbBkZXpQh59A>
    <xmx:Y-SVaQGPzOGyjnJwmKAQMfy7fNV-yxKcrdq_NQAozqzqpkQCGKOq-g>
    <xmx:Y-SVaUwXFu5onfV89sxLkbqjAFFWUjDW5JzDU59b2YTxjyTsjYcHSQ>
    <xmx:Y-SVaS7WFuG2ufeFB_ajh1UPaI8eZoDKlk4tACE0Z2cbtXo_M3exAMVb>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5BA251EA006C; Wed, 18 Feb 2026 11:10:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1Ljo1cD_StZ
Date: Wed, 18 Feb 2026 17:09:50 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <5cab5e92-268b-475d-9f29-13127c0641bb@app.fastmail.com>
In-Reply-To: <aZK7jmvLwu1evxUp@pks.im>
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
 <20260213-b4-pks-history-dry-run-v2-3-756ac376e9e5@pks.im>
 <315801b6-bc9e-42b4-8356-12fd8b83223c@app.fastmail.com>
 <aZK7jmvLwu1evxUp@pks.im>
Subject: Re: [PATCH v2 3/5] builtin/history: replace "--ref-action=print" with
 "--dry-run"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026, at 07:39, Patrick Steinhardt wrote:
>[snip]
>> `HEAD` is mentioned here because it could be detached `HEAD`. So you
>> can=E2=80=99t just say the current branch.
>>
>> =E2=80=9Cthe current `HEAD` reference=E2=80=9D seems a bit much. Is t=
his less precise?
>
> It's not, but this commit doesn't rewrite any of the description, it
> only deletes the sentence that becomes out-of-date now.

I thought I would unceremoniously bring it up since you are the
only/sole author of this document. ;)

> So I'd prefer to keep this as-is if you don't mind.

Yeah that=E2=80=99s okay. :)

>
> If you feel strongly I'm happy to add another commit on top.
