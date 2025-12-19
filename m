Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B533F39F
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147125; cv=none; b=fJ18UCHoebTq/K+OBSMl60gCxUna8wFNM/ay8XfwRFzSj9RHyBunQk2prFVNKs72HNiwESxcNXW8a5O+DHCyrkFA4Ywgio3uL5HUOY8070vzukzVmYiTxQUsuxIACD3sSsa9Cq+xllvKmzch2kAMJb5LoNAAL4i87SbTiZJE7sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147125; c=relaxed/simple;
	bh=mt+plnwlMVjBTVQKRp7cWx7fbVF2fUK/PyrbqWqqtdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eET4/GToRNUTg/SQRwt4Awpqy+VxBqVvioAeoH8cdvrVOm3xKTKWtmXxb4WJ2NBTQaEdQBODeVShowmMc7ziUdeKrwaK8n1ZnlC9KHmFqcjiI4JH0tmouguIzXwDtwg7VL4sxU8UAO2ng6mLzC7JwuF8OoP234vG0Dd0xTm5bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mYFDsd9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t3zR0HbU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mYFDsd9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t3zR0HbU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9D5577A0091;
	Fri, 19 Dec 2025 07:25:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 19 Dec 2025 07:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766147119;
	 x=1766233519; bh=jahvqqJ2XN6/oDj9X2BHnP9JbdjiKbCp649mmMEGwR0=; b=
	mYFDsd9do4ceeHR6I2NtLELx83JDEJy4ph+rchRklwpUKmCUXEy1mGbEk2qcN5mC
	tejeqDkDRwoIEx0/18D3/3McspiWTGDp96XduiowUtvMfv+dhgvwhbnzYArBJk9x
	tHSDJ+HN8qFc1ur4v4cotP4VxUEVrT6sMSB8X09ffSA5rkTUpgReRgmFLfoC2zyO
	wh20g/CtLezJuENby/hGT+rPNjq+Om0SlxFzRp2Jqc+4C1XJ7WPxWWp2lRWt/wNZ
	Ihsih8Qw0A2nUOk9Bd86XJxRVCPpg26LbofDWLSlR9s+L3pbcMguZtNloaVrFgo9
	uRpSR7DrsmCrhq9/G50PaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766147119; x=
	1766233519; bh=jahvqqJ2XN6/oDj9X2BHnP9JbdjiKbCp649mmMEGwR0=; b=t
	3zR0HbUjTNH0kqBVgjGKwsvY7Z2fA/LfApd4ew9wOwRwO606Ki+1VOZR3u8pfgTW
	54WS/EFrYQoinG55LSDZ52HDTzEf8M+3bBQmjf05dkV/2KeVUu1f81zy7XMYUilC
	qcz2TbW5lWisJZ4B9O2GwdHj3JvkXPTRLF295eMHJ6oc71GlRGCP6jdy3EBwJp8O
	7vhej5K0h/mihmy/Yysb3r50mCWt6/GGVbXrIGRldYz6L22WJjqTRribR91RxE8Y
	VcoVoJfelzly+xouEONbCAZX2owPHu0zyod9psjQta8Xku/ApJd51+Nf6hpSB4O7
	mdxROrVqh+S12wN4dKk1A==
X-ME-Sender: <xms:L0RFaerc05HbhOFvKnjciya9418xJx_OvINGSzjoqGXIb1GWu1khTA>
    <xme:L0RFaQWN2Pq8y8pDBZK9cvsBJ7qr5SQpuUzmw941GPijBdqTESMbAOuCw5DBvl9q8
    IRTf16BwTNolnW_DkQUQwsJepU6tuI_lUZkTPk_XmXiJZkCwnmj4g>
X-ME-Received: <xmr:L0RFadDjRfzFNiSKM5MsLl1F3cSZEHuFo9yr8xSeuavWVeKRPtnfxtYP-m0MIs9gaQ_RlVZXcEurxqE43Wcg8GSJwJ52zwCYzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L0RFaU1PHHwk_N6uU2eqcPvAhCDDpeu8PhR55aytDMJOHqfCiNYV5A>
    <xmx:L0RFaf3Avo53q0N9qAIUE3g0nEEzrSfPb2CD9Ny5fdsHT1iT30srqQ>
    <xmx:L0RFaZCYBwf_16uK8EMlk6eO0dhHNlEzcqn5vWF__RTZfXWWUT2Opw>
    <xmx:L0RFae7LFWT-pmu5qjBOoitgFpXIwrInQXx4j8UYjR0_DqCx7TGvSQ>
    <xmx:L0RFaa_b74iiTFHRrDlYvNz8VmfiEt0iLRnBk3sre1mciPhEZKSe1FPb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 07:25:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  "Aaron
 Plattner"
 <aplattner@nvidia.com>,  git@vger.kernel.org,  "Patrick Steinhardt"
 <ps@pks.im>
Subject: Re: [PATCH] odb: do not use "blank" substitute for NULL
In-Reply-To: <4d084712-dc9a-4824-b840-4d78831d9da9@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 19 Dec 2025 08:39:31 +0100")
References: <xmqqpl8cxy0j.fsf@gitster.g>
	<a31e054e-0eb2-48b9-a802-3592a737d1e3@nvidia.com>
	<0e860421-8f8c-4bf9-8ad8-82fe269a7a9d@app.fastmail.com>
	<aUPbgCSTgWJAe0wu@Carlos-MacBook-Air.local>
	<4d084712-dc9a-4824-b840-4d78831d9da9@app.fastmail.com>
Date: Fri, 19 Dec 2025 21:25:17 +0900
Message-ID: <xmqq4ipmwtea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Thu, Dec 18, 2025, at 11:59, Carlo Marcelo Arenas Belón wrote:
>> On Thu, Dec 18, 2025 at 09:02:59AM -0800, Kristoffer Haugsbakk wrote:
>>>[snip]
>>>
>>> This project typically does not use that trailer/tag.
>>
>> While factually correct, I think the "why" is more interesting in this case.
>> anf the answer IMHO is: not, because it is not needed.
>>
>> % git describe 385e18810f10
>> v2.52.0-25-g385e18810f
>>
>> shows that this bug is only present after 2.52.0 was released so unless you
>> are using unreleased version of git (ex: some development version, including
>> ones that are based on "next"), there is no need to "backport" this fix, as
>> the next version you will use will include it.
>
> So the Linux Kernel (presumably) uses `Fixes` for backporting and/or
> does *not* use it for commits that fix changes that have not been
> released yet. Got it.

I do not run, and I am not involved in, the Linux Kernel project.  I
am not sure if "is this fix something backporting folks should care
about?" is the criterion they use in their project, but if it is, I
think it does make a certain sense.

I have mentioned my displeasure with use of "Fixes" in _this_
project before, but that was primarily based on the fact that you do
not really know if a proposed commit really fixes or makes something
else worse until your alleged "fix" cooks sufficiently long in the
field, and I find it distasteful to make such an unsure thing easier
to mechanically process.

Thanks.
