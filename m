Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945CE40DFC0
	for <git@vger.kernel.org>; Mon,  4 May 2026 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931841; cv=none; b=NQuzDFDltiJcHMpfgUHzzqEzeLyg0rk++YZOgaChM7hcYP2f6F+f+UvxJWgum+jS6TmANIaldUCEJzz0WL19ctjTgsk5QRcEb+W7mA6RaslRe0NtwQ3wnHcIhlJ2Q4gaEXPDg7bmhXs01+YwHnFKiZ74Z8SwCm1L2d+7xT/wadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931841; c=relaxed/simple;
	bh=PdkwTOR4lVkFihdB3F3n1JK/9v0EMAtT1FRemEbxzhg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L2rAAuprmwlN7RT7ucePAoKjGVzLEZfo8h4zOb2XthhrD8mcRvCVH47RYlCYPKEDEq9UhIJclTmKUoIpki1sxzgJDzTTxMZpFt38uO1dTa5g3Yt8S/56CpvJVlYb2ceacQdiTudYRrg1IS4NxglMk6hmTU4rXTgh4NcRzt/iryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jW/OBVIv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFQKVUNs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jW/OBVIv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFQKVUNs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D82AE7A0076;
	Mon,  4 May 2026 17:57:18 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Mon, 04 May 2026 17:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1777931838;
	 x=1778018238; bh=3BOXLdOjgX4s+NRFuBgvG1PcK9c1I1l7CjuXbUrFhKs=; b=
	jW/OBVIvg5+C2Y/g7zkVN5tvEmGga8ThyUulN0q4rPn5Cqo/2ndO1SNRSOjlB8Kt
	EBncawEiK6LVAEFMn+ujEw0v4U14ax3LomLuCtOkEoVvDtfwMxnGceh1X1AfIcyW
	MibPmLDvfFN/BlGiNk82B4+pTa8VwfPhmzLkCxvi7Xn4gEyJmcfmBU/UI+Ax4zdD
	ZaCEUv3GVglWCkNxXlrJhsQdCge8nWI573PeThf/lNYRe3qKidGwxlC1Ej0Uo6Zo
	r6UuZtvmgF52CteyQWE8rSpAws9+gddSgjRQalQvvfmbGQdsqf0X7xbePsTFAimD
	9DmvHVYbInVdtzwV1aQ7NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777931838; x=
	1778018238; bh=3BOXLdOjgX4s+NRFuBgvG1PcK9c1I1l7CjuXbUrFhKs=; b=P
	FQKVUNsT8zgOlpQ0yRYLqGhDpLYWuWidLbZE9G5ffNFU3WIbfMfspSb83lSKUVpx
	Dd5MokuNQigjAzKhh3BmxomvNEEa+DyPDTcr6v2ERl72eMKqcnpXA5ZpV+cx+wEQ
	aSlyo2PPDxpFRVUARBxauCzwAtHJB2IpQKmkrEsj5G/MWN7JtPdzUyXjpLjMAbSi
	9til47VUTYdtp7uafx3++BgFQJy3OLW72gPro4iElhwDzbA23XhVKUGLKkOhh+1h
	pC0kfEWRko+X3VmF41WfwX+0W9s0irW25sEyBKuoql1QkzVyMGwjlH4sLKWF+WXM
	1yYhWLcHaf5F3Z+/IRutA==
X-ME-Sender: <xms:Phb5aZ_9xXhNglF55mqK2_ph1j-WIevBb0QQjrcWouELJvCf4MT_Eng>
    <xme:Phb5aYiqTNqmGEJDTrD_nqlI8aQEPlXTX8ybWhoxeS_Be6Ygi0-TG7afo9Bo6By8P
    Rvx3JSUxwta92LHLqIAXDNQFrtRaidrGkqQKlM4c4_K8ADVfl1cAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeekteekhfekieev
    gffhveefieffuddutdeggefhjeduudejffdtudeuieetuddtheenucffohhmrghinhepmh
    grkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrg
    ihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:Phb5aVgvO0RwCFjn2lhV0crNb951BfTJNXCQpc4-q28-HEtJ3CqAYA>
    <xmx:Phb5aaK5bTm4De6hgRe2b_eMIDh_TPwqXKON0VA2N6uja8RaOiKvGw>
    <xmx:Phb5adCfqhOsHZQz98hG4EBeuOhvfGjIHNDbElahZd3E809xamSkkw>
    <xmx:Phb5aSisKcJm33VZQgrqeBBkdimPMNeSreI7JQ5fTAp_iF9x2_3C-A>
    <xmx:Phb5acMf9cEN6FxMJMC_i43tSJCGp0a9lYeys8hK4eHR2uxo58RzEfOj>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3CB1FC4006E; Mon,  4 May 2026 17:57:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHDyktfZDWSB
Date: Mon, 04 May 2026 23:56:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "GIT Mailing-list" <git@vger.kernel.org>
Message-Id: <cccf9618-31de-447b-ab17-4fb8cee23363@app.fastmail.com>
In-Reply-To: <b04e98e3-0840-456d-a627-351f2378c037@ramsayjones.plus.com>
References: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
 <xmqqv7d4ou3m.fsf@gitster.g>
 <b04e98e3-0840-456d-a627-351f2378c037@ramsayjones.plus.com>
Subject: Re: [PATCH] name-rev: fix an 'may be used uninitialized' error
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026, at 22:26, Ramsay Jones wrote:
> On 04/05/2026 2:13 am, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>>[snip]
>
> Having now spent some time (well at least 30 seconds :) ) looking at t=
he
> surrounding code, then your final suggestion looks really good to me! =
;)
>
> However, these 'maybe-uninitialized' errors (historically have been) s=
omewhat
> sensitive to the level of optimization used in the compilation and eve=
n algo
> used by the compiler changing frequently from one version to the next =
...
> So, I wasn't sure if Kristoffer was actually seeing the error or had t=
he
> DEVELOPER variable set (which is why I mentioned it in passing!).

This is what I had when maybe-uninit. didn=E2=80=99t fail for me.

    $ cat config.mak
    DEVELOPER=3D1
    DEBUG=3D1
    CC =3D ccache gcc
    CFLAGS+=3D-O0
    CFLAGS+=3D-ggdb3
    USE_ASCIIDOCTOR=3Dtrue

I switched to the whole config.mak.dev enchilada and now it fails
as it should.
