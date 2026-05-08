Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296C30F95F
	for <git@vger.kernel.org>; Fri,  8 May 2026 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252655; cv=none; b=SpExRT5TuetQgg0TWP7gQPp0JuZIaAbbCYIOv/ekRVUfaUqj2Tce+x7TyfJHDxhKBbdC3iZXZYCuyXUGhEOaFc1OmogEPcH/A/ku+5+B136RkCVjDtPeLzRn3W4PR3Rd/m0ISlnJBFDOzdYDahjZ426WTlsdhPYa06/3KyGY+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252655; c=relaxed/simple;
	bh=C2Emta5Wn8iC1Alk2qG1wOPaI4hs+6YMNrRUYO2XZ3M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KAS5x9WMTOctObNrRUpeXW4xs1lgTtGz1SRzGI0xx2VKhMnyihnNdqYj6gKaT9gOFqKNKtqEshIkkuJ7f9vCPTI8N0yBdbGSXiCxqgXEqNCeibOir+ohPzkdgkPb+ymduWOgAUAOgy7MCqZd0IjJrThTM798AFt7JsxiY6vUiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XjsLwMps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HiEQBKPd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XjsLwMps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HiEQBKPd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59E8014000B0;
	Fri,  8 May 2026 11:04:13 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 11:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778252653;
	 x=1778339053; bh=C2Emta5Wn8iC1Alk2qG1wOPaI4hs+6YMNrRUYO2XZ3M=; b=
	XjsLwMps/38ViNRPyYS2AIXTaORfDa6Jpm1LaWnN0se1RwDIAy6a+BgNcPmEZwfK
	lrndB4CoHxTE+SqOHKj+XW7KTOZpsYJTPyzGraUvTfjeGvX929n9QaoczQI0uSC5
	KyiWNhDPpaWVAnmTnTvTLnPbsWWucvLAY415vP96hHEDGXpXSY2KM0KgKl3dhDUd
	H+6rTOIW1Lf89Jb3IWenziE5KWTC6kj+BMB1llKR4hrDnj4TJq7wD54HTKqfCGDt
	CfgKaFlY0kpHwZrxC44hAlNkJB1DNX6UeRqJMoxn7ZHz9OxvCjzlTfu+sA7A56TM
	DdsYn21c9BkI4dztiBIbPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778252653; x=
	1778339053; bh=C2Emta5Wn8iC1Alk2qG1wOPaI4hs+6YMNrRUYO2XZ3M=; b=H
	iEQBKPdq1ZN/4eTDBd1zbm0MmwgdUQKVa6Ypusuk06rBdHrxMT3Dvn0GK9XRtWgj
	eOPT6jTUPa42kMmGr2SNCy0cSWP8Iu5wuJS76JqfnJOLtBVshptvyFWvdk+ICYrY
	0iDo5j1uKD4qVwWT0xem97hXIRejzRmApcfhFskDZvv2FkC58pszs9QoO8Ix6au4
	VDGrnHKcIkKq9Hvfx0xxdx9DqKHJ5tC1U9UVaQTvuBKbrZC+Dy3+JxqTg+pIhpNc
	Fvp6HwRAsxm6eob1ij7OFkYhowA0KiFiqq2Q2+R4uOdBA58o8uyTZpcelTVf5+p1
	dMBR3UVMCH4pkx9FOEKpw==
X-ME-Sender: <xms:bfv9aVkNBRu5aofFnmRcvgQsQwfcBzljf4Ztm4hRU1mf0Izl-ptNMBA>
    <xme:bfv9abp4v2JuEHLFj8bL9KMolc1aGR2iWEVDTcqeL1m7OqlyEYmzJSsC5zkpXLI_M
    Hqfo-sK0GIEiPD4EUVhZOwO2Bx3Jyw0x8J0rO9XUy9-qkJbGhfr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehjrggtkhhmrghnsgesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehlihhnuhhssehutg
    hlrgdrvgguuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bfv9abTU4_9Yea2Qptd3YuAhuvFOQCaJ5oZ04n-8Zg77oAn6N9O7hw>
    <xmx:bfv9aWG4-LbovSv0AEOjeEJrGa0kG_clNycgBC6qnSqW6QP6shx_jw>
    <xmx:bfv9aYF2b9t3rnud8pwXscZUVJk5wDsSELVyzq2J-GaFOFBy2lLF6A>
    <xmx:bfv9acR5CT86_BQpLpBlrMAu_Dj5w73GeW3gqnO3ibmNBsDPNsYcsQ>
    <xmx:bfv9aYFRtjoO_MOHOV2HRKfOADmZqOeFvmY2BztPoSy_PMcJ7S3su3Qp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 310F9C4006F; Fri,  8 May 2026 11:04:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUgMtfrvVkyR
Date: Fri, 08 May 2026 17:03:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <36b0e906-4bc2-49bf-9485-2449d347facf@app.fastmail.com>
In-Reply-To: <xmqq5x5ulv41.fsf@gitster.g>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
 <V2_trailer_comment_lines.61c@msgid.xyz>
 <5302cfb4-f2a4-48bf-98ce-98b74e7a6568@app.fastmail.com>
 <xmqq5x5ulv41.fsf@gitster.g>
Subject: Re: [PATCH v2 9/9] doc: intepret-trailers: document comment line treatment
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026, at 17:48, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>>> [PATCH v2 9/9] doc: intepret-trailers: document comment line treatme=
nt
>>
>> s/intepret-trailers/interpret-trailers/
>>
>> Didn=E2=80=99t line up
>
> Yup, looking at [0/9], I agree.

Junio fixed this up when applying. That=E2=80=99s why I didn=E2=80=99t s=
end
a new version.

A by-the-way for others here.
