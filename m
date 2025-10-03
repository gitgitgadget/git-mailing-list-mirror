Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965C23E356
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759523953; cv=none; b=cX/qYEjdA03u1XQNjwvaQSZGA+BSJ8IqZX4VnUcIdGBteJo31evFPH0rKh3BH77kYboEc/ETtHhsk9ybjcbL0Gdgm9w2noYxh+kpV+SmGaIMBvr/8xID+c9wKWD02i6ItNhJPmCrP+do5ebmVA9N4LNKbZ3hPc+1tpGjnVnIRkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759523953; c=relaxed/simple;
	bh=WPhcJ32Al4g8fBmsA7B42FMCruHOyLs/jhdz5WhmuQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t/6A5FJaKmVlxF7w6gO1pR32dRvovHU0gFsTvScRqWuH6L7jCVesCAXvVY5qAwMP0VTIbW+lBomfj4Wj0nX7iRUvvlgMAn3pfMZUQGCFFc7HmRKnjBKqU7Ib1sdZMBWdN6GL16/yQLAzY0G9SF+wow8xTKDTI0Hs2K9OJr+bs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PezxMS1k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ScJoZ8tc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PezxMS1k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ScJoZ8tc"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 07227EC0689;
	Fri,  3 Oct 2025 16:39:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 03 Oct 2025 16:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759523951;
	 x=1759610351; bh=ZMS7Y9UDtUUt24dVPcisVm2DbjuzFEhtyAyDgG63smQ=; b=
	PezxMS1kr3DA2x0ELlX2mDLVU2aSV862zxVuEREmLPY9yNyg8LacgFYSj0tOqBts
	Ut8UNRdg95v93A918QQIEVPUSYXzXQt8BUlg1WbsJw3ip9cUZm20BE4h/5+a3EAk
	ZYJpcPa4gE7PhJOaic7785nfZjjZGXJiE3f9VoqAQx+1pWmzN5Pl4lYjonBhIVUE
	FEYnyUnbH+WtgLC/x4wViE8b9E+v25mQI5+UB2bU0b3WE/tbder0FhUQAgKpALZS
	f8GrXXPz9I5Cco6jbrHqO3DX/H34trWa0uDgpQgGjMAEkJ9sZjrxMtJh7sKddR70
	3Q8ZgB7uv2rg5lyPlpO7Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759523951; x=
	1759610351; bh=ZMS7Y9UDtUUt24dVPcisVm2DbjuzFEhtyAyDgG63smQ=; b=S
	cJoZ8tc/zlg37UZo1KOPBLJcSLR9B4TLGt1FV0Jdcrf+dcJ5WsVKsxQXc9iOU1u2
	3JEgHxp8DB8rS/VlADkygVp1Twse2AgZF4AhsWU+AbGJ0vzCPpn8ogqnOH4+8T3p
	A+vxCfQY8Thr7SJXWuagOFNaG/bs3xR7qjzXF/sAUibXes/1/4icEt2QhAghq87u
	ehiZFy3fBXH5hfIsj3vUP8Uatml1oRdSUU1y8QtAyJBj92MBpZyyBVyh0znLXUE2
	4qmE9vz1Y93iigJDbG4nm/y6VjLKmctVg3dqAH5GhnEkRvEDt1FQG7hWMkXvp1T+
	CIdDNfgmflxtnwVn3TB3g==
X-ME-Sender: <xms:bjTgaIn5Re41TpHienYAQf6WPM2LGIrtnyItsq2_HqPPg0iZcGewAw>
    <xme:bjTgaO0Vd400KdlE_mwvqP0ougqij2IOtjyK-OCM4mo-VBJYcWOHo-UCAqqPOP3JK
    6NRB0RxasYRaMoJwlB5AwdUQdyJnVKK6jCojoZzBSfRRQ7K-R_Plv0>
X-ME-Received: <xmr:bjTgaLpRzWMMR9RUmxe7SbXdf20LPVguZonD-TLAGa4Iz757y0WwNKhkmPfjXyrBTMcB7rkpzk7Q8DtOQxDUGqi528eMhbGlxaI5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepuh
    drfihinhgulhesuhhkrhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bjTgaDf2cHKtdSgzQZXZlsqpLEKZRHU8HQvGX3ieKS8lZxFDH1CdRA>
    <xmx:bjTgaCp1Q5E5a0xxLdmE5PTNu__m5pmphJlChHQbzgaVupnt3jaNSQ>
    <xmx:bjTgaMHsSjLTgJGqy29oTr3HNoCSzkQqCfvw03d1Ve3LjYjunxmWOQ>
    <xmx:bjTgaKtHc-Ik9vY8v3-i57vIX2waoqUnRMmlQfA5i7qt6VFW8zPf-w>
    <xmx:bjTgaDGpIiFZ_lOnaGw2LNhtacHnV3ewmJIh6Cff_fPEonoNWsO-9FlL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 16:39:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "Windl, Ulrich" <u.windl@ukr.de>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] add-patch: roll over to next undecided hunk
In-Reply-To: <737e78f5-6337-4964-8385-9c35897f5dff@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 3 Oct 2025 21:53:00 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<76665b6f-cb92-4694-bc89-5eb21197df34@web.de>
	<xmqqo6qoufqp.fsf@gitster.g>
	<737e78f5-6337-4964-8385-9c35897f5dff@web.de>
Date: Fri, 03 Oct 2025 13:39:09 -0700
Message-ID: <xmqqcy73u3de.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Weird that one can switch between use and skip, but there's no
> way to revert back to undecided.

Yes, but Phillip's "if you split the resulting hunks will revert to
undecided" topic, together with "you can split one hunk into one"
bug that is caused by the "permitted is never reset" bug, if you can
navigate back to what you already decided to use or skip, you can
say "split" to revert it undecided ;-).

> This should be easy to fix by resetting permitted at the start of the
> loop, no?  Patch below.
>
>> With this bug, however, we have gained a bit of useful feature, I
>> think.  Even though j/J should not be offered when we are at the
>> last hunk for a file, we do wrap-around to the first hunk.  I just
>> checked the original code before the C rewrite, and even though it
>> were written defensively so that incrementing the current hunk
>> number to 5 when you have only 4 hunks would take you back to the
>> initial hunk (instead of barfing), because we did not have this
>> "permitted is never reset" bug, it actually did not allow you to go
>> beyond the end with j/J.  Today's code seems to have inherited this
>> defensive adjustment to stay within the available hunks, and with
>> the "permitted is never reset" bug, we are taken back to the first
>> hunk.
> y/n/e on the last hunk roll over, which makes sense to me.  Their
> movement part is not mentioned in the documentation, by the way.
>
> With the patch below j/J are stopped by the floor, as seemingly
> intended.  Not sure if the (now accidental) roll-over behavior is
> better for them.

Yes.  Even if it is accidental, people are too used the roll-over
behaviour.  So at least we should always allow J/K and probably
allow j/k as long as there at least is a single undecided hunk, if
we were to do this fix, and make the prompt string to match.

I only am aware of this bugginess in "j,k,J,K,s" but that is only
because I did not look at others.  I wouldn't be surprised if they
were even buggier.

Thanks.

