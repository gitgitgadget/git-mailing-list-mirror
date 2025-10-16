Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1C21CC5A
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649490; cv=none; b=pU4ojSeZ7BaDML8IlDunXouhi9JjX1OWR814w8LiYTftjBV6Re3E+ZzqIp+iBlLPA+63N9vWdA3TrbsIQU26y8zsuUuOH+hthKK3WqyjVVaDKQ4BQbJ7bPatY0OD2Idu3VzJyH5bHtlQ/f1YCB1ZelW7E1I/GahJoRv1yJO+u3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649490; c=relaxed/simple;
	bh=t7aFPdT4QxHnMp/Glqbtn4oJasWzrS+KRRcZ87lwyQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uHQc/zDsX/LuUbJBzGG+ObafBOj1q+HWvfBYJjlXtpysWWvjBCF1qqn59gYQHGsaYprVal//OfKl23meBZxlOPCMykHcLlZ5It8+T0HlWg635ZZd9Ib34MKBGvshmBXgo07UlK+90Pmuj7eJi1dehczTUDJom0SPE/95DusrXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uw7+DbnQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=taj1W67W; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uw7+DbnQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="taj1W67W"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29FAF14001B0;
	Thu, 16 Oct 2025 17:18:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 17:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760649487; x=1760735887; bh=7X6aOYCoPO
	YEzxl9Asu1pChCsZVLX1WjoRmJAR8F9wk=; b=Uw7+DbnQ4Jf2rY3T1Qx4MSkaNf
	zZPcxlgMS4WJruMfHx9TrFRpHfciCjvLlR0BOsuL2OHXHAHVdTw/sIlqAVLz+Zxq
	Uh1Wk2tq4PBfPwRP0rFX67w9QV6DEkIvlA3aXFO+j0QEY2BPOSgrWS8z/LZOp2wT
	jj7Y2+qHbE7T6ApPfpm0QYJ/pFKP02y4MXSE+9gOq7q/VN6fuvlVWvYH7gtZB7TF
	iDEIq2V0HVHfTGcyqBEQwXct9HJ6RAWMJxgmrYLD/Jw/fiAKtwTx/EX9F7UySgGm
	rAfbvoZ5IiUAKVE2FW9011n0FNJb8GqCkoQU2CVjMMa60r7LU672oZzSwd3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760649487; x=1760735887; bh=7X6aOYCoPOYEzxl9Asu1pChCsZVLX1WjoRm
	JAR8F9wk=; b=taj1W67WetGjt8PNOpDg5C3KW1UABc6RII//GyGBgVHxgKEak2M
	0RY63/jvp165ssmkzK2WcC27S61dYlXSgyA4gHoaASUwI7CzCdq+ZKn6LWSinAyq
	jjXa0PB8Li5gLvh9HCR3EFalHTaTnNzLP204JfkXuVxadbyDvSOZ/hPG1R0E/tYp
	v8v1VagcqxTrEP6i56LXSPf8wRaZzfcSiJgLMjbnv6580k4DVWLikbT9riJHW+Kz
	FM2PPINKW3GPQBF3LaA5azS1VkPFC4OfhzKAD1VVtTVkATz8w21roFrzcpihzxhj
	8jrAkAyn49XIt9YjwqMDy3Nz/GikDBZv38w==
X-ME-Sender: <xms:DmHxaE1bsYDEhbt54uV0HGO1hr3bVJbxta3wThx20Sd4Z7mZX_6Kyg>
    <xme:DmHxaGgFWcZHM7ZN8idYmBCIAPR8IZnQfn1RGpTDstdbL5b0v-tEjsX7w6tkbcQX1
    2NEj_gk12mUJWMLr7ampI8t-adVjNmjR9M2rstZNv02_WMjpBSKrQ>
X-ME-Received: <xmr:DmHxaKTFIM_N3vIB_n2lJtpCw3GlC_iigcmSEXDJBIRrFBKAMQfNnoAuYSraE5E3QM1-MUmWr3mfVmsag-CJnRf5lvBIxmXaTYJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshdrsghothhtohhmlhgvhieshhgrnhhsvg
    hnphgrrhhtnhgvrhhshhhiphdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DmHxaHgCgPab7envr1IItuyEfiNra66rpl5nwbYHxgNTrw0CAyZ1jg>
    <xmx:DmHxaK5Yurdb04IjJItsEbs3OXtDhLB_HwWzeccnQETt0phnpol2cA>
    <xmx:DmHxaECX_VSRH0s53ofvVmAEUTz0IszUUoeKlL9M6TZPCLgLh-tYSw>
    <xmx:DmHxaBbwr2J1hCDXMJVRY_k7dwEf_Ocn2kTKuZKC9gqWCY3HbNx_1w>
    <xmx:D2HxaOOdGXENsdPGy2zWPjpGQLBY5D99NeiIJxfg2E98PNH6B19VI0BA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 17:18:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] add a message-id header to git
In-Reply-To: <7205e71da08f22db757b5dc0bcf3fef27db40ea4.camel@HansenPartnership.com>
	(James Bottomley's message of "Thu, 16 Oct 2025 17:00:40 -0400")
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
	<xmqqfrbi37v6.fsf@gitster.g>
	<7205e71da08f22db757b5dc0bcf3fef27db40ea4.camel@HansenPartnership.com>
Date: Thu, 16 Oct 2025 14:18:05 -0700
Message-ID: <xmqqqzv21r76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> So this one's a bit more deliberate.  If you import email and then re-
> send as email we can't keep the same message-id; the internet RFCs
> require us to keep message-ids unique, so git-format-patch won't output
> the message-id.  That necessarily also means that the poor man's rebase
> you cite above will still run, but it would drop the message-id header.

That is one more reason why I do not want it in the header, or "-m"
to overwrite existing message-id trailer.  If I received a patch via
a message, applied, and forwarded it out of a commit I previously
created from a message I earlier received from elsewhere, I would
want the recipient of my forwarded patch message to be able to link
the message I forward with the original message, probably in the
mailing list archive where I took the message from in the first
place.

