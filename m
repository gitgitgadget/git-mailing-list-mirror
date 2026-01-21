Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7992B3D6484
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769035977; cv=none; b=cFO8FsuUNXEStTPt8H0vKpPl01r9Y/JgOvbSHSuEM7esbvVS40+/0U6kW+6vIY1lvAdsIs7a1NxuREPvrabSuct6Xi+HeAeePnFy8NdljSErO2uF6f+ucoTk0jomq0KA4AuqWNRzVU1mnm/TnNoeki6LwAAMG5fqOjx4fFMnHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769035977; c=relaxed/simple;
	bh=1ala9atMhXJcBwQl27Ay25vE3ZwXJlq6RzytJjWluBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dOqvcNm8wNamxCUf67BTo41obiXiF20r1sch1Icd1sEb+t6BqoQPXxSFKsqNMFGLEkjENyCB9gIy8c/jg+44tvLg+rzlcJsc6IdRiIl2G6PFwl6Vf96zfbRl42AHo4w1CWrfgGadxU516Vf0Tn8Tmvrd6KUk+tq8Abe1rGmZ4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EgEf7XSr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ihZvU7JW; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EgEf7XSr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ihZvU7JW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC9947A0043;
	Wed, 21 Jan 2026 17:52:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 17:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769035969;
	 x=1769122369; bh=Tq4gYy0dcI3ynzLIsw+mGr+MaGBPLPRqthxWavbquEk=; b=
	EgEf7XSrd3zZF4dArIua38OigeIFjRbLxi2fCUd/xgc1k+AMvCjizU3DFd9VSVhe
	9sYYFcKAETzhcQxVlKDAbmWLZju4TSY/hYe2I4AKu+3jzXahRd36OnpdgOLYHCwy
	kRJ2I22JNNyRgft4oqoPMsXpmsl+R6PYP3Ct2twfnT+5TcUNEvZ/awOZnFqMkqB5
	kc0oQlWbbVhIk5iie5JJfIq6TjAv6tka5mxZlGpgfKadYbQQHPCSMo9U4ZHZgY23
	7/+W+6kUgR4gqolITXobvr0FghYCOBokAJk7H133YLWvYz0lQMZaOOUqgieRjEcq
	eyqnQDSfDSQ9ahhBK+2vnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769035969; x=
	1769122369; bh=Tq4gYy0dcI3ynzLIsw+mGr+MaGBPLPRqthxWavbquEk=; b=i
	hZvU7JWOMpOUFYh/+pN3yzPsqP7Ps+PYZIZfQVRztj2XQVOh4KQ3Y/c/Irn1BK+D
	p7rBKiSEfxAKLJPX4EVeJdFuLg2SqrzNHiMD8KZrrolu0Uqm2FARnJaENxkQpdy3
	Fv3aFPZawMbBIromnAYXcTuGZVZk+f0IkXz5mqBJqzPJVYQ6rQtzm2ZMiFWjCG7N
	ZDddKn5Asgz3TlmDLsQ4L82ecsH4GTN/3f5g/bR3BwsOe2Dfh7nuQDv1z2FWalrU
	9H0gNMJwHRxPC5BqwbPZWg4xfW84S/Txs9JR6Tu6FP+LDof6LWcAapuOlGSoaGyw
	9ISPf5u2lsQYIz45fn8Cw==
X-ME-Sender: <xms:wVhxaQkr9Oe-BkQDsaz9OXFVIiaSGXr9884isp4bPMb2y4w9yZNgTQ>
    <xme:wVhxaWtPGbfSEseJDxBYEQb97TnRxsZ9UI6KyxnJso0lYbYXtOYmU05Rsri636jNS
    54Z8JdffyRL951n8Tj58OFje3pPPUe85nHqVFIU5MtAW_BoIloVH8Q>
X-ME-Received: <xmr:wVhxaW-F11ZCCclJ3KmvZgM58PM-7bvCu3Y20pAlboxARa5oDLc84w062kbDA8J73Ni-MMiX_Et8w2gDP-XQ7UAsXYnu1IDS2Ll3Pdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrd
    hfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wVhxaYO0mmVbICWuVQjiX-NhoR7ip6Mihpy9A6Tma9Xao7obNelUmA>
    <xmx:wVhxacFK5njZN2DQhipisre7_bNZewNSsapzi-w9abRUZ8HCTWWe0Q>
    <xmx:wVhxaeSTH62Sa0oZN7lEgdCWy9kuvT3XbXmkyuxxag1KbWqLLu_6Zw>
    <xmx:wVhxaRsYunkbs4JDHH7_rmpPYt9ZIAzQ6mlWnev97XK6SWetbxZuhg>
    <xmx:wVhxaS2IGcMgUe7J5bmYwgE2e6Y8J2kVnD57YWwVl1lJOIVmm0tX8Lsq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 17:52:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  jn.avila@free.fr
Subject: Re: [PATCH] .mailmap: fix and expand mappings for =?utf-8?Q?Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila
In-Reply-To: <xmqqfr7yr3qj.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 Jan 2026 14:38:12 -0800")
References: <gggadget.24e@msgid.xyz> <xmqqfr7yr3qj.fsf@gitster.g>
Date: Wed, 21 Jan 2026 14:52:47 -0800
Message-ID: <xmqqbjimr328.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> The latest release candidate notes say that there is a new contributor:
>>
>>     Jean-Noël Avila via GitGitGadget, ...
>
> Thanks.
>
> This is bad, as I thought "via GitGitGadget" name will never be
> exposed to "git am" (in other words, GGG will always use the "From:"
> in-body header to protect the author identity).

It seems that I invented the patch text, inserted it into some cover
letter that was available nearby, and applied it, so GGG wasn't
involved in it at all (GGG does not give the in-body "From:" to
cover letters, so it is entirely my fault that I failed to notice
that the e-mail "From:" that points at GGG was used).

