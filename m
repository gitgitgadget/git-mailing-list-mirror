Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A826B973
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841662; cv=none; b=ewwap4GCiQ7RkG0RVJwye27aO6p3rWuMM0VH6UmQ/LfaPYvrcLdKeWbY0TEEpib81NwuoTl8vsZUDDMn+CJ6JC9fAIsfQyRzj6aNCh3H8HlmxANTmgwXoh3Y5tbXL8dDukMzPTeEclWjHpVHXnkgocJd5Ip656JDrypQKKwYmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841662; c=relaxed/simple;
	bh=pWs+AP9Xy9rtB16Rq5jtPJX7PfHP0PFJkFraTViJ0Ds=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iZhxZ2BbBB8KPVm4drpKhvI21LpmKn4ZBhT/Q8igmQQtBzD5GVhu2yv3WKIDg2I1W0r+yyA35pGYwwfXe9jkepz5222tZXjzY/Y3+wTV/SGcMhoHtFBjrM2QEjzoGgj2PHG4C7HvsZTUgmEZWBygdPDKgXut50/PkkbPrLq1X5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dRAW8//D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jxFc8s7Q; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dRAW8//D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxFc8s7Q"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3158E7A0196;
	Wed, 25 Jun 2025 04:54:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 25 Jun 2025 04:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1750841658;
	 x=1750928058; bh=pWs+AP9Xy9rtB16Rq5jtPJX7PfHP0PFJkFraTViJ0Ds=; b=
	dRAW8//DO4LP0azJjMQDezJI0SI4KjmqctyCtBpvvLOT7ld3InJzh0DydfeCeMDq
	+dvhzba+qFcl4tTUNSM5JIUmxeHAbPZrfcjaWy48OzgcU0E7q9BvTYGZi8YzlF+H
	6Kv07fNADOdT7F9PSvS2fpj4UNtkR6AjmWbY9m8Ir93lP1xeD2TT6t//kszFyjz7
	FUoVwBRl/8AtNzfL+ocEqSQLtvPTjaY1piXUvFFi9AeK6C3HH061kmIi6KmjauzD
	DRAw9E4EMcoYhXUbRBnr7P7CJFlmcJMUO8mWkNa6YfeOMxB4+VNFGOL9sjO1z4Y0
	tlpxAT8T6SDdgHh91aO9Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1750841658; x=1750928058; bh=p
	Ws+AP9Xy9rtB16Rq5jtPJX7PfHP0PFJkFraTViJ0Ds=; b=jxFc8s7QKqYODxjiC
	lAZ9UIDdBjKuuVJghgiVf07PrCxouVNJFzwocuc1pN36LbEljesknNaIndT/9N1d
	d6uDvIdZ5JWBUmq5VNteaZ44J4HLXROt8w+NQKvhxiy5I1n1UoA/2mXCQLDdc5dr
	JBpIbPEho6GPilFNja7M2/GA1631hUSoZFGDbrDmxYZkUVp124eN+dAvFk605Ct2
	VWf4QXmKoJYcu723rGtz3DpGB1EWxGDrp+SxEfC/vBGf5bK4NhSPwUi4ffQ8ko9w
	s8QzS66XtlDMAiPvMbWPjtZ9v0IAJtmNyMu4BV20wb1bOY/U/4NWxp7sUD/Bn5Oc
	9mM/w==
X-ME-Sender: <xms:OblbaP-zqsuDk7pK8-kQI16ZH4p4xQd34Eib5v4OJoy4RKX7Yy1BCOs>
    <xme:OblbaLvZb24d-o6XoSTOlzWaAif9E6nMpmW_ytsVX010ZNQXLKsulz8Pc7lRhBdch
    Mkte9dh7j-cGeCibg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefh
    feekheetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OblbaNAOAl1bq6PBmKBzpXjNfgGj6jY3ArGhgdF1_88N5qLzaOxLcQ>
    <xmx:OblbaLea0r-ORoo91-DSxl-kbgceyTArGt2Fgpu1sqazyBHwBL4M9Q>
    <xmx:OblbaEMOpHI3biGXPLelB32VLmhhrB8HYXLBw66SjaVsGBOf9JB20Q>
    <xmx:OblbaNngVPUOQ7OEX9VIsk5tw-ALWZhfVr0_QfWFv4Co79n8Czyj7g>
    <xmx:OrlbaC1azW_kcb_nKcg8ixuz9NLHsEK54uovd05vGZ_ZHB_ZvNukYbP0>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C435E1EA0068; Wed, 25 Jun 2025 04:54:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T38185b1eafdd6744
Date: Wed, 25 Jun 2025 10:53:56 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>,
 git@vger.kernel.org
Message-Id: <8515698b-4ab7-4901-bacb-1c47180c2530@app.fastmail.com>
In-Reply-To: 
 <CA+B51BHEB24JNzOroTxFodxiuPJ1=Vj7KRFevrm2YatnTVuoYA@mail.gmail.com>
References: 
 <CA+B51BHEB24JNzOroTxFodxiuPJ1=Vj7KRFevrm2YatnTVuoYA@mail.gmail.com>
Subject: Re: bash: unescaped `>` character when switching branches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025, at 14:59, Ondrej Pohorelsky wrote:
> Hi,
>
> Our customer has found a possible issue when switching branches.
> Output redirection character `>` is not escaped properly when
> switching/checking out to different branch.
>
> Steps to reproduce:
> 1. Create a new branch and switch back to master
> ```
> $ git switch -C 'issue#1234>/tmp/dangerfile'
> Switched to a new branch 'issue#1234>/tmp/dangerfile'
> $ git switch master
> ```

It=E2=80=99s too bad that git-check-ref-format(1) does not disallow `>`.

It would be nice to have an opt-in extension to the ref format check
which disallows `>`.
