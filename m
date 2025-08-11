Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA12E11C5
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927075; cv=none; b=h6cVtwxcD1POuRPF9n7l9LyIOBpl7nAs9eo7gH+SetW2H/7OqxM/3il4syAWdb0NOXC5ym7gOweefgtmqIgsgv+tVp3ithUZtGlvhsht0aUgQZgNMOeZ8SDZwqJDLi0gZpOmi5tZFE1c8f9XIS26UU1G6/Gu7v52AixWu34Hsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927075; c=relaxed/simple;
	bh=EZvAbmdhnquOOluwuka3iUD2bi/oz6VYOna3147a/Is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ie/kS9AXUUgAGpJry3155gNImdb4nT53HFWyb6LFcb2GoRMK3DJ3ehg8obr1vDOFLlJ/an+2aVpR1+qqi7oCRW/cP8LKm3psLfSXfMFomLBKi8Ub85YtHkgNie4SdGFTgRaRDCiH/dHNq6yR87BKopDxuZ7sMAUuZ3seS0tfYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XCt2ivBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QWw+FPEC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XCt2ivBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWw+FPEC"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C589A7A007E;
	Mon, 11 Aug 2025 11:44:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 11 Aug 2025 11:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754927072; x=1755013472; bh=x7XzYAtTcA
	5cGdnmfFN1P6eVVDHFhCP3vFMGImsrXzU=; b=XCt2ivBMjlVW+fzf8Vd14m7/2r
	dAjjsUSIQl3XTRlfmZoSmLi3lAwUSKYnhu8GtepXtppkx0KdKHN+Ah4435kliaSU
	KGBptli10tMfT43m62EpI1GFG6W2f009QBR+vMD7FWP+SLp+PeBZaNmhx6+MddL/
	zMOcsQ2CmSxzVWr+/Qwr8Xuk6z1T1RFRzZEbnhVnYzbyFBHDQfWTyR8zyhqC2LX0
	MWHay0PY8fCw3qIarg7HamXOx5f3R0DEh9vf0rcGUC9zGcU3HkSG13jOKNDxIF1j
	BpWzt7ovHzao/rtzl011t2AjW8Lcy2wLy9wff3lIYgSVXY82VlSWAA8P8mkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754927072; x=1755013472; bh=x7XzYAtTcA5cGdnmfFN1P6eVVDHFhCP3vFM
	GImsrXzU=; b=QWw+FPECk/dnBVj2GA13rHJtRYx0/WasQuYy+4lWFhPH92S/Yho
	QSyuIqDfij78IYG1aAat0wXIoykXD+BkIDlWNVkYdYvyALN9rxeItf0dLuURUbXR
	UMg+ILUnnpIBehf2vC5Pf+ocrBvtoJjMGWy8pByfthEy/rLhXySNOyprjO/mJJB/
	SGU+u8kJyi5TWJBEJxLvWzM4jTB/pNdYFTQgwrM7Oc0MEWSMlCZkr19nPJ+9tK7S
	qGHbZdkNreTuzr0Z5ZrHpO8c8BUrndezS7DK/PrcglHdbBoDvP8pwfw8/5jJ0LVM
	aTsH/pP5/aGMAGnIfHGaggCgUoRLzi2gj9w==
X-ME-Sender: <xms:4A-aaKVGEjD7JMztpqmfZTAFja-IWzdE1rRYeyoR1CTyH_Sy-XGD9g>
    <xme:4A-aaMHo5l_qSUvo4fzmG_KLkRUlfiqP0ykfA2LR5VZq7KJ3XA5n6JLzIed5Th6uG
    7M_7DH56wKFnaxIYg>
X-ME-Received: <xmr:4A-aaNdRWWXWdctUtjpXOo0jvUSvO40qSrwIvOVQGe9UgJWEtRyF6wQ74EqDnjz2B6BJNfFl83hvOrwugwbdq-G-rvYropPFl1Efmyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4A-aaFoQXBRBHkoi4mtm3Px2_T6TsypA7FhjJDtqxH5mr0UjcHmLiA>
    <xmx:4A-aaOBQRtOztEgZc0YVgOfcF_aiDqtlwtSAJZg6v5xMEjljvbj_yQ>
    <xmx:4A-aaOfQCW3mPcrqqqSGJP-LlKy-UD_HektU0Wod8sZJTxL495R-6A>
    <xmx:4A-aaOsbP4v4m4lOWlVgWGmFiViuIC0s8L7UnucaHbGe894vmymhSQ>
    <xmx:4A-aaC_vCmeDgtFCAUfxA12U_czc96Bq5lrT3IyWawngogBcWMn20bxG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 11:44:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  oswald.buddenhagen@gmx.de,  ps@pks.im,  karthik.188@gmail.com,
  ben.knoble@gmail.com,  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,
  jn.avila@free.fr,  sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v9 2/5] repo: add the field references.format
In-Reply-To: <f97b712f-95a4-480b-8ed0-174e4f45ff81@gmail.com> (Phillip Wood's
	message of "Mon, 11 Aug 2025 15:41:30 +0100")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250807150239.6987-1-lucasseikioshiro@gmail.com>
	<20250807150239.6987-3-lucasseikioshiro@gmail.com>
	<f97b712f-95a4-480b-8ed0-174e4f45ff81@gmail.com>
Date: Mon, 11 Aug 2025 08:44:30 -0700
Message-ID: <xmqq7bz950dd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Lucas
>
> On 07/08/2025 16:02, Lucas Seiki Oshiro wrote:
>> ++
>> +The returned data is lexicographically sorted by the keys.
>
> What's the reason for this? If I query three keys from a script then
> it is much easier to parse the output if I know the keys are going to
> appear in the same order that they were on the command line. If the
> command re-orders them my script now has to check the value of each
> key which results in a bunch of unnecessary string comparisons because
> it cannot determine the key from the position in the output. While we
> were producing json output there was a need to de-duplicate the keys
> when that output format was selected. However, we no-longer produce
> json and in any case de-duplication could have been achieved without
> sorting the input keys by using a hash table, or, as there is a small
> fixed number of keys, an array that records the keys we've already
> seen.

Very good.  Thanks.
