Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C670302753
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393285; cv=none; b=iZtrk0y4R891xFvsi+vzbqWATya6Kye2txISOFDTrgQRPd2tXiuCfCB4MvJTTCX/npTffNxZwXJ5lznQ16BjET6+AKf5Ns3/xz3VzagWyG1XtpxwYoIPoqeFzeVFpFOi/MYbjQ3+nEY+ib2HLArpCPXWLBgFPSNsVD8UKRvnLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393285; c=relaxed/simple;
	bh=oXsAQpNYLztWzXMS8ZfGS+4uPYp1q92MmeQSLdZo5R8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OxKSzs+BDvedS2040oNy4m5qNO83Kwqip5Iq6YLnabTEx6FZl1KzjPYq3YQf7gdGqe3wTMXcXeySgkMbFWEBwo+gYf2E00d3fD2xRyCMRRG5vjccB0gmg3wfk9IINy6R03kL9no+kHm+p9SN9jUrHlsFuFFI5t+tWFG7Lj1LUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MQkxUw+c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoD8Mltw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MQkxUw+c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoD8Mltw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F28B1D0013C;
	Sun,  1 Mar 2026 14:28:03 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 01 Mar 2026 14:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772393283;
	 x=1772479683; bh=oXsAQpNYLztWzXMS8ZfGS+4uPYp1q92MmeQSLdZo5R8=; b=
	MQkxUw+cRKY0BLbcsuMpDaBq7+e3D0Z+mRCcRbfB0MoJVALmvvL5rk8bGDfjfKta
	aQBo0W2u8dTqUshSBvNm/6fQkcnUAEcIXXSkY9ab3URjue8/fndSrniZ65mhY2p1
	RGgD96KeT4QxB3lQazJLMGZ5V6SJq4M6598X7O2ynwlX5LTCeW6qehZCViNNVkRk
	PYBFPRcEHNMLrd51QT0yKKk7wSJFpTuxspVKUlUNj/fUp6K2uvcOQBA8sZ3YXGuf
	mQLkemZOol3b7kSdj8NpN9gE1vpKaD8/HGCMkbtgOBiWBQQV/9MaQ5dhU03XiR12
	Qc4JP5eOzQkc6DmdfCuccw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772393283; x=
	1772479683; bh=oXsAQpNYLztWzXMS8ZfGS+4uPYp1q92MmeQSLdZo5R8=; b=H
	oD8MltwcpBNXr+V8hpal5K+ze5stnpudvSrUj61PAQkulYHgvDGVn8HkplRZ9veK
	UuqdcNMJtdb7DPdhQC5DjbYmvT44qHANVr+320n0OpX/CUqzsuF/eMDEmz+txZbk
	wp6LXXmb1NMz7ft7ieUoHrdAdL7WICKyg4vzM7px4SyHbRXMOQLCaqdUYi29Joo9
	FHjti6m4n6whHwf+/S9GkVpLHkNHBqOpBH3xZ6UVSB+yEXzV78emNMC4usmJZBK6
	fL4CjWB6B5NkBCrLD8cNnGaAiWfCb3zLUIkV/N9DKwa2JdVArJa3ilXY25pz6F7l
	D89A7oyLHgc0fgLQgGbSQ==
X-ME-Sender: <xms:QpOkacTYJk12mpfLjce5vihnf6vIDaBk3uTkfTFGfMnW9IMm8VH9yFM>
    <xme:QpOkaUk3iWgiPobTke_7nalj-95HOoY8WbrqPMOR7HbroI488rtvIcwrii1KmJSAg
    lDVq1eAIxLJShTLdRpa0ryT396D8f_qhtd4XBLolQW1NYWWkFcqItI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QpOkaS78bK0nsmRCaFlIoZNwWePQqZ-wgSafzifrEtMsgqmTGdvL_Q>
    <xmx:QpOkaZvBgPnbVEJOQLnq67ATEJeEq13s2R8n1_o1BylzxeV1-byxEg>
    <xmx:QpOkab7m6HucmLN_hBMBEFW2I1I2ut35BoPXbCQzhAlv5eg6Omh5Dg>
    <xmx:QpOkacVAN8ub90-dItIV2X3z60lTlx1Tq6Fb7df7iPTQlS9zvZZv6A>
    <xmx:Q5OkaVfnGIbn_rzE8dEWkVbajiILTNtvDndKEEl_4zcG2hICzOJ9e6Tg>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D12481EA006B; Sun,  1 Mar 2026 14:28:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHbM2ju-kMHV
Date: Sun, 01 Mar 2026 20:25:05 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Koji Nakamaru" <gitgitgadget@gmail.com>
Message-Id: <0a861662-3a6f-49bd-b2c9-d90736c1f674@app.fastmail.com>
In-Reply-To: <20260301190647.41248-1-haraldnordgren@gmail.com>
References: <xmqqa4wv5xsb.fsf@gitster.g>
 <20260301190647.41248-1-haraldnordgren@gmail.com>
Subject: Re: [PATCH v30 0/2] status: add status.compareBranches config for multiple
 branch comparisons
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026, at 20:06, Harald Nordgren wrote:
>> Will replace.
>
> What does this mean? =F0=9F=A4=97

That he will replace the branch he has for this topic
(hn/status-compare-with-push) with this new round.

>[snip]
