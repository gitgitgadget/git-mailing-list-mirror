Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9FD4F5E0
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883743; cv=none; b=NNLy3FWKJGbBJdr09oLPg7gkcHVOVxaqWvzqp+Vz+ojYdrvyj9eCokRfaZAIKFGGoatyhUMGN1P2Es1a4NGNXF0pVRGN1uptMiKYg5z3wvPAnYuxGvi/vaIdAN9cf3g4KPM5vKCCnJhPG6xS9vVCVV+JP/4Hzec4pXW5J/zf7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883743; c=relaxed/simple;
	bh=jX7okaQ0LReIO+ayDJb7YoZTD//E+XkGuQRWNaasLQs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gk3IigrnVxqzlIFQVT+qVic99ZyhZb2BiIOKL0f2oF6FJDmMqbW2dCDM3uYQJc761Bcu0M2qkOD+S4f8LPW6pHNH7nD8rFVlSkTPLsCCtz8UAZUS0UrlGC1T2gcYdTKN+Nf7g7gP3vrrxMuF9Gjo8/wjImDpJsijeiljgsO+cQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ml1.net; spf=pass smtp.mailfrom=ml1.net; dkim=pass (2048-bit key) header.d=ml1.net header.i=@ml1.net header.b=VwykDjaZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FY/arPwJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ml1.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ml1.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ml1.net header.i=@ml1.net header.b="VwykDjaZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FY/arPwJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B2F3AEC00A3;
	Wed,  3 Sep 2025 03:15:39 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Wed, 03 Sep 2025 03:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ml1.net; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756883739;
	 x=1756970139; bh=jX7okaQ0LReIO+ayDJb7YoZTD//E+XkGuQRWNaasLQs=; b=
	VwykDjaZt/XlIEXGPOvSrTdrylUTPIc9xL7UScUgkwMyjjeMllLCw4oRtEKZswKL
	2vrGy5ptxvzJMYNt4xfAIR/yc7xopSNJ7Sx5Qxui+ndj+4dU6QtdqRP3Vxyyd2zf
	dOrM/tOPYyRCst7eTQv+gUhf7z8U/rVwdpKR7IFivEHG4yDLs5/uRTeYTli5e6Q7
	DvFiaFx2ho6lUsu/GJodzHyioxpkSZtbq46TE3A7D00sBBoPQ58od8BAupT8W3wA
	icYKfWP1BLdmuvLZJCUPd2m0g6EB7+FNwNT9aGlsnGFsqIPXmhWYaBn1EiJVV29s
	Z0rb8gB4bV1zy0R+22Y3qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756883739; x=
	1756970139; bh=jX7okaQ0LReIO+ayDJb7YoZTD//E+XkGuQRWNaasLQs=; b=F
	Y/arPwJRKp1apvGRnZJNBvXsTGl/GdecjlzG3IiP7/CmOwq6Bys1ijG6LmfE39Wi
	2V6AzvpXExFK+J0Yup2B+SXXbAsQu4F0tXJ2YpRvV/UiuwsBk6Ij1hpDV5SxawjL
	LAZPsaeYtB4EYyK0iEcevftNVVKtmYt8zeK/FieuPvvwx5pogdIl95ZY8Rm0YKj8
	LX3xeqS7BEogG2ctU9JzVWzLmzl4TN5b6fl0MKZnoaZMSXqZegKUz/LYRTbq6Kt8
	1n44SESlY8zwKD0cRVZXXLFNF9EQEvG0GJOXUoiiDb8UuNE+pk4Q0lzupV8+kaCU
	auzEFlyPT6AJgod2/Is6A==
X-ME-Sender: <xms:G-u3aETt3YvIuetsVYCGsV4W7Sp_eBPM43TSSJUgq8Gc30V_6YTRJg>
    <xme:G-u3aBw6T-s8Wrb5Ec6mlDpw9Ix6841FKJdPjJXA408OlAJZK_zUWv7Nuwls-Dak1
    E7P-aLlcEkt_OlY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpehjohhrghesmhhl
    uddrnhgvthenucggtffrrghtthgvrhhnpeejtdekudfgfeegjeduvdegffeviedtvddvvd
    eltdeigfeifeehgfeuhffghfevfeenucffohhmrghinhepghhithdqshgtmhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhrgh
    esmhhluddrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:G-u3aGbN7MxMGTAiVnjbTe8TetJ0MoKw2VqMKYgD4o4lErN0Ccre3g>
    <xmx:G-u3aASUxjlVLimER1On4IcFEPUaGBEl6UTXf3Ia41jnQJ48du_Bbw>
    <xmx:G-u3aN4eyvheIUBkHY1VDr_vqoWNc-BcXEXpbw4s9jpwCXjA8_IU3w>
    <xmx:G-u3aFyiReyddZcjPG_7J5bLqvxXG9A9q2mwCNjKMEpjb7nefcRylQ>
    <xmx:G-u3aChoCcY6L3B_cwO_bFZ_0JtcxDtBtb8ulYZdhYJJ07UJgHTL95fm>
Feedback-ID: i470841e3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 74AA12CC0083; Wed,  3 Sep 2025 03:15:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaL8HUsuz1kN
Date: Wed, 03 Sep 2025 10:15:18 +0300
From: jorg@ml1.net
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <a80907d3-0dfd-4e68-818d-4092a2855848@app.fastmail.com>
In-Reply-To: <049579fb-6e42-4c3c-ba5c-71c5f843a66e@app.fastmail.com>
References: <74c5f07d-6376-4787-a5e2-bb09abc58ce1@app.fastmail.com>
 <xmqqcy88lsw3.fsf@gitster.g>
 <6597b201-8087-462e-adc0-0ddaa8a7402e@app.fastmail.com>
 <xmqqa53cioh5.fsf@gitster.g>
 <decdbc61-6273-4173-8044-31658f33e207@app.fastmail.com>
 <049579fb-6e42-4c3c-ba5c-71c5f843a66e@app.fastmail.com>
Subject: Re: Still using "git whatchanged"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 3, 2025, at 10:08, Kristoffer Haugsbakk wrote:
> On Wed, Sep 3, 2025, at 08:11, jorg@ml1.net wrote:
>>
>> Given the circumstances, I vote for keeping "git whatchanged".
>
> You can see the discussion around the whatchanged deprecation as well as
> other things in this document:
>
> https://git-scm.com/docs/BreakingChanges.html

I fail to find the discussion around the whatchanged deprecation in that document. There is mention of the deprecation, but that's all.

(But I can certainly find discussion around it if I want to, no need to send more links.)

>> Given the circumstances,
>
> What circumstances?

The circumstances that other changes to command line parameters (which might mitigate the loss of "whatchanged") are not up for debate.

Regards,
J
