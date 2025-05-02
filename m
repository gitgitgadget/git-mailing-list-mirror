Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259218AFC
	for <git@vger.kernel.org>; Fri,  2 May 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204399; cv=none; b=XO6RoLJvOWr2DyW8P8mkBX7mp1B6em7hM17rVf2x3OZDgcSOtxMesh0ckixAGPl8YJIF5FQz4aGGS0N/2xqeh1HjVQAz7EDL3C6d7sK4/4vQvobXViTL7XmJkuVthUTNOg4guqYMci7kDTamxKHBsz5CCoAwhKce4eqHBBE9nEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204399; c=relaxed/simple;
	bh=ES33826o+Ycqbfos0yInhZ6XX2E1A3cSwPF24qs9eXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ecs0/F0Cf/fh8bKOPkwY2203kNqqafdiOXsUbtJkGaYeFr3F8UMXM4TwCuo6AG7w/9VivXFniISJgTFcmL63RrU1BLrchU4C+KRxkN9uaiHXPyGzNppe18LN3i5Mj2jpIfTRhv4fZY5ds9i3PN7VgQw6fuLvyezVpG0ogbcZt5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XPlpFji2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uT2JHdls; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XPlpFji2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uT2JHdls"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8ECD125400E6;
	Fri,  2 May 2025 12:46:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 02 May 2025 12:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746204396; x=1746290796; bh=9tMLkbMGac
	lM+9LbnwRS9e3W4pbBCQToKQYuEiv3SZU=; b=XPlpFji2cOnbdat2uMOHDvaDKH
	BMyZjm0fqGVdZz8MeTT8OwMoG3F5F1qH8ls9RLdfPxfQ4PKkJoCzXZASd0+I+ASF
	TzDq/34ywuL6Qr86vPR4lSK4w1rPJvcTDOnWQzwU1o5rQiJDSGzBfk/NC1StbafO
	PSIKvmip2gTsDEpdDW0wCzsXOpxX8S0yK2pzbbx2FrWgOzvmUvDGAFfRjE0zh7+7
	HxdOAUL+PHRBG5S+ysmBz7iy+JWgIylHyhs4dFLLUnWANl2+ve3jc0Xjh+EnOfpI
	Ef1+xDw7o9kq6EMd+Kc5kivmOodzzftVbPIQrCyZDfBI5itscSTx0rIobYAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746204396; x=1746290796; bh=9tMLkbMGaclM+9LbnwRS9e3W4pbBCQToKQY
	uEiv3SZU=; b=uT2JHdlsHbAN4xXS9XApEw/xoh96jAfZgi9VMKH5GDEHGXMAr20
	0RUpq7TenrrpPs0swqlWeCmd5KttXfooPMZSDkPNOy7BSrR/kasBV7PlpDKMKu4c
	3l7YdMl/q1JC+thIEwXvBFGK8vrSnHMcbAoHKlxh/Pm+KEyPRtvG/tASyMrMIyuv
	+rp7sqdce2NW4rXZOz+Q9jxcrrgHXeFg2QkGQJdthikdejpPUzKs+aQ8fAW0x/se
	7/4N0xxMhiEronwLJm/ltYh3eeh0Dz8hGC454CwkDwmaAVTAW7SksF6i1Tcl3NQr
	iy+69zLejAEn1lm1aiT9qVv2ZBC2AuGfDJQ==
X-ME-Sender: <xms:7PYUaJ1jPPxlM2Cfu-FpiNMSGqeHPE6oPXPXxYdijx_Rx1Wd5B-FPw>
    <xme:7PYUaAGU5-kPB8eTXAh2qmXGwV7xD_-vbrzG6vk_c4FD_Xy9VdDztsowWJ9c1ci75
    LvChXV_G8K7r8ANAg>
X-ME-Received: <xmr:7PYUaJ5C3-xX78ZFh5XMPe7VZWu179PQag1V1wMws-IPrsIcUN_8iCjyhk6JGau_M3SqU3z-7ZTRXl1T-YpsX67S0YnHhMJjHKWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7PYUaG29dCPTD0CSO826rvpQy6kbXgXacIFu8nh-ziXeeUkva-VNPA>
    <xmx:7PYUaMFZpF0pmzcQPMW77WKRh8s6AEGVsWgQUnkM1FyJEcezqc6_QQ>
    <xmx:7PYUaH85cCTWFpYmf07QobybGi3OXn1dGW4k8z8j6s9Xzw993PIGIg>
    <xmx:7PYUaJkmIu2f2efUvwFWcOtROCWyj5e7xZHRmTiQ9YkFqd_iYkp_QQ>
    <xmx:7PYUaHmY88jLBR8mlaJaMxkfMncSOmu7OlGOtOVL6LE9ngveCcssDnxT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 12:46:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Nominating "whatchanged" for removal
In-Reply-To: <aBSLejDoqomUO3xE@pks.im> (Patrick Steinhardt's message of "Fri,
	2 May 2025 11:08:10 +0200")
References: <20250501213452.370729-1-gitster@pobox.com>
	<20250501225958.2947677-1-gitster@pobox.com> <aBSLejDoqomUO3xE@pks.im>
Date: Fri, 02 May 2025 09:46:34 -0700
Message-ID: <xmqqselnufit.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 01, 2025 at 03:59:56PM -0700, Junio C Hamano wrote:
>> This does not go far enough to touch the "Git 3.0 removal" list in
>> Documentation/BreakingChanges.adoc, but is a preparatory step
>> necessary if we ever wanted to do so in the future.
>
> I'm a little confused. These patches very much feel like starting the
> deprecation process for git-whatchanged(1), so why wouldn't we at the
> same time list it as an upcoming breaking change?

Ah, yes, I was overly eager in the documentation change.

To make an analogy of what happened to pack-redundant, this
corresponds to c3b58472 (pack-redundant: gauge the usage before
proposing its removal, 2020-08-25) plus 4406522b (pack-redundant:
escalate deprecation warning to an error, 2023-03-23) rolled into
one.  We are gauging the impact of the removal by inconveniencing
existing users a big way, with a tiny escape hatch to make them feel
the pain, so that we can hear their scream better.

We are not there yet to announce the decision to deprecate, like
fcf31daa (pack-redundant: document deprecation, 2023-03-28) did, to
those who do not even use the command.  I think it may make sense to
hold that WARNING part of the change, leaving it to a future step
that touches the BreakingChanges document.

> Or is the intent
> rather to figure out whether anybody is still using this command so that
> we can then deprecate it after a couple releases if we haven't heard
> back from anybody?

Yes, exactly.

Thanks.
