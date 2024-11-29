Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C01A2846
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732909881; cv=none; b=kdEFlOeJ5UwPwBvxXGI2ba09K3RoSs+CHimBrkxLa13FvyWC8PAKgC5oPtLtG/OlrlYKhnJ6afaA4zkEQnLut0PyEhzgtJrPISAAnYnU6Drva+8GEEfd4FgmtSnuuMKNzC3U89OTGvnZxsDZOf3pQ0ChlO5O/NyGdyz/VLFxsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732909881; c=relaxed/simple;
	bh=ZpMuyw1sCxf4QWwYanG9+r4rEDj0MzB6ZEqJ6FCy24Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BMR2vI0kW7ejeCcQti6miL0LPhCElUBVzxpixA5sGDSwkDNa9s3ZTMps5I87ZdXLWxeDGqIkANa2ldm+6HmrQFxxyiwzaypCGZkxrp3tEETXlbd1unw4UPsU2HJ44XWjwA8NhgA5NK1ZLAXbEYh3xodPbfYpKqVvmM9mf5YihRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QDCb/JE+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsoMtD3R; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QDCb/JE+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsoMtD3R"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3750114005F;
	Fri, 29 Nov 2024 14:51:16 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 29 Nov 2024 14:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732909876;
	 x=1732996276; bh=lpHJZ1Ys3+QCc+u9Oot5TEhK7teI9wpQ7PaqmDWDBgk=; b=
	QDCb/JE+kFKnBKbWQjsaiTZ96SQXAKg7D97zIaayXMHK/fv2440w9ZfT8rRxSS3j
	V9ScUgIg8Ins0CS8FDXoYpQrisJFoCJ+004Jk3snOCju6yWKfY+YymNxUoIttV4w
	JuQe+8kbG6u211ozI2PgJq0Ql7Qmkp7chBg7aNb5E+2j9X+ud579xmt54RJToG4r
	Riw63WOo1xNvCEQd/UmBCaaXkAc+nlpnyntUVrq/UN5lAQqxFkUC8fv0bPGBJgUx
	LuPaUUzRfUzTCIHZT5WQvkh37AsDI0pGXwSG+CFzw9HV92FkuQZsllef4sW7Of8B
	5M7f9du5zXwUoSeYF7/6tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732909876; x=
	1732996276; bh=lpHJZ1Ys3+QCc+u9Oot5TEhK7teI9wpQ7PaqmDWDBgk=; b=N
	soMtD3ReoTX3czBxysLLVcAJ+tzzgtQIuFmGav2xRNfEgJUaa/ICIrrWtHUfYEt8
	wVuuIYaAt4Gj1wanmV0dkL7PgVkWWn4E2D12s9nXzGvYIrzhmc59B4OuqUXunk8L
	aBDnc7nPD56s9HomW3KYvurG4AtKy+sX7idD/Ha7byMS6MIYi/kA1sneCq4VKxUL
	PjyD8OaorLfPl5mMqfIJTkXOPXAMunc8JUznPelT+5MLNMxs7ORVvbdhIUac/neB
	f+avOy0reIECk746wZZSa1BXMmdgSlRfchV3MYU4cCFEcmE7ac637N9X9zKsmaI9
	m48m++WKeOA8chbnSw62g==
X-ME-Sender: <xms:NBtKZ5pGyenCowA2grsdFXx_5cnsrZX_3KGVMUkW4DiMlmgY6uF0xyY>
    <xme:NBtKZ7qHD0p6zjS2I2VmdE7ES5FxCLZJN3DJ20naItmeuX2oIEMqX9c6Jh6qeqYLQ
    G0joH4VqZCxSzKBmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeej
    keelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheptggrtghhvgdrshhksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NBtKZ2M-Zt-FHaWPfk28q4-eU6qivHHMFdP_xmIXXfFS-_2lNNnphA>
    <xmx:NBtKZ07uvJw3Jj3_QnwII8pDVpRcvCczPW5QOTTjKuWxcOTDPmPwAw>
    <xmx:NBtKZ45PtwrG-alX-qpsO63Ji71uchmS1R4mQP8d3MCl7Ez7rxahRw>
    <xmx:NBtKZ8gPVT1t_ZwS6fbTkl5xvMwYfmJ3BadrfeaOSVobGgoqiIOY2g>
    <xmx:NBtKZ2Q1-orZqR63P5UDLX5IB49XpLpoL07hS79AwD6fAJYrcyCOnymV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8C4C2780068; Fri, 29 Nov 2024 14:51:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Nov 2024 20:50:55 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Peter Kassak" <cache.sk@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <1b5f05ce-6e91-4f90-b3ff-f7cedfa32586@app.fastmail.com>
In-Reply-To: <1c026a82-d24b-48f0-8206-47c2eeed1442@app.fastmail.com>
References: 
 <CADYnh+Fudpy9kfg8npUMutMjzYNDy-XxJCCJ_9O4kLoB807_3Q@mail.gmail.com>
 <bc028fc5-c0e3-4d31-9790-86bdd3911cc5@app.fastmail.com>
 <447bb623-28be-4667-b571-935ff7d163d0@app.fastmail.com>
 <CADYnh+EUNUaTDB9uLSgZkvWGHrpqrrO4XMrjmHzdH-6WXqZLqQ@mail.gmail.com>
 <1c026a82-d24b-48f0-8206-47c2eeed1442@app.fastmail.com>
Subject: Re: Extremely long subtree split duration
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I don=E2=80=99t use this command and I am an outsider to the code (to al=
l of the
code in this project).  But the commit that introduced this apparent
performance regression does a lot of `git log -1` calls. Very apparent
when I ran it since I got a lot of stderr output about missing note refs
(since I use them in another project).

For what it=E2=80=99s worth.
