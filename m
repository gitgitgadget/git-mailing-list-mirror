Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF7430BAA
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477336; cv=none; b=NRjgVseA7EBilrgHdTKq58jpSvRIy0ezMZ+hhLTrwvRJ4Pg1/FgynNUe+itp/VRJ+VJLyCW58d16r8q7b2e4RogOEZiyiMDH51m8x31H2hyB4r0MIjKO62me05j2p4fhVNnVm7VFTRkPg3NCuDh5i9Ys6mNOmUEtRa989/E0M0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477336; c=relaxed/simple;
	bh=/DDWhePP6G6O9Q8ezkm0Zdcz9NjcEpidFDSWmqQCQNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fasvJLLqlYr5l1ui/vWYdgmnHN/XOQt6ZSWELK4UrmP+fLxxKQNpETeXAmL/o0Y3tOtLpYAg+WF0mZ0mVPCt/2PzkiFAJ29bWud3rFtiVI0egwbDHar2syY1wUOIoLOY7nEeMJwFaMucSMxTOF1nB0ZC5/4Sv74L+ebqQ1W4wKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=icbLmlZ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wVEuN+nj; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="icbLmlZ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wVEuN+nj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E0161400168;
	Mon,  2 Mar 2026 13:48:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 13:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772477335; x=1772563735; bh=Z4Th52s/Wq
	AV7ToO++JMhwCq9lQ4tDJ/Q5NglLF3P18=; b=icbLmlZ3RkTFOTYRuou85QmXUf
	unPk5zZKQVVl3b6+xmvVJuCsbvCa9W1a6OEdipVX23EuULgqU8wl9421TWPrnjtR
	N6sU2eUAvR0D8+SkaBxqgwV/Gf82erwqDPB7UrM0ve/8lcnFa3Al/NUqVf0ncY8Y
	cRjpo9jBJIAb+Pv9K7BWRTwKYvTFGP2riUlRe7LvvvAeokozKbuMgMaS6vUgpEgu
	ikCMihkD2mOlcPU7OZFUgK9rJ6R7effGZFqlZ2bX2J6xcL4o2t+mbw/Y4KGiI3Uo
	2HLiFFJK9Z92uOL18frvimgH7a3u5ma4buv+HDLDkWkCFjwEz/I2vOjl/17A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772477335; x=1772563735; bh=Z4Th52s/WqAV7ToO++JMhwCq9lQ4tDJ/Q5N
	glLF3P18=; b=wVEuN+nj3Su1/MHLqTgJ9WEKadNIWTo6ii/wPMOrYTKuhD9C0EI
	bZA0jMixs/PF303F8iKfSpJGYytXlEZ6BJxeaEDD6xsk18M1UtI21dhUKhqx7CVA
	ILwHcpfyO5m2HtIxlnaKWvgjXfyjOp6kIm1TVzqKmNWnOyjHO69NN+debiE50h98
	uxhC4CAWAUxtzSr4oLBut2YpBLy7WBhS+xYEWb9RQeKSTXzgMhNdhX7wVGfGiXHd
	e476tXhmVY5yyy1eD+VTpPFeHq4XKwGgYW2JCQl50cvg9RDnm7pCbD5mrGbx61nF
	vkDAombqxn/TlKSOycZ+Nq/Qdb5HN0Q1V4Q==
X-ME-Sender: <xms:ltulaSuUeshSE6C9QoboaESrdip_5cS00FFBNAXKjsy9ybMJFYL-tw>
    <xme:ltulaWizXO0iFwH7M-75NOmk89R0gwU5gygngNKFFh2-_hICBmwAeAYVQhgY37_V5
    TjaKP7ZUrixV0g86AWiBEGBJC8OO9U-DKV4x6_5gsXMycqbV2w5xQ>
X-ME-Received: <xmr:ltulaT-RFIFQGD0PR5WVbLJFt5zkZD0G3EPllvvIvLUoSpUGWdpgTA7TDY_gN38-8Uigs3ijTJ1Y58DHYj_CZsKOK6F4Dm-eWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ltulaZuPPW1CDI358Ddm257bXiU2j_wBjcQQHN2cMfK4RWmkhoC1cg>
    <xmx:ltulaXr1XccvPOp9vIJGf0o5aiwQ-oMO8jb5YUUqKJT3yOSS1h0cNg>
    <xmx:ltuladoevUZxU_j7w16S41pMAbDpBO97hSzgE2zGLSPGO-mj9GneXA>
    <xmx:ltulaWZP-Qd3e3GDBB7UPxBvjOG-5yX75R-jEp-ROMJzzSwQVQ0t5w>
    <xmx:l9ulaYS92XKFtX4hmA5kHA_uG9NHR6TDG87SQpKZaVB360c-f8hTzRXH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:48:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 00/12][next] Specify hooks via configs
In-Reply-To: <87zf4q5fiz.fsf@collabora.com> (Adrian Ratiu's message of "Mon,
	02 Mar 2026 19:04:36 +0200")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
	<20260301184500.1488433-1-adrian.ratiu@collabora.com>
	<xmqqy0ka2n53.fsf@gitster.g> <87zf4q5fiz.fsf@collabora.com>
Date: Mon, 02 Mar 2026 10:48:53 -0800
Message-ID: <xmqqbjh612zu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

>> Please don't depend a series on 'next'.  That will make your topic
>> taken hostage by _every_ topic there.
>>
>> Besides, the ar/config-hooks topic has been in 'next' for the last
>> few days already, and it is time to go incremental updates.
>
> Understood. I don't think there is anything breaking in the config topic
> v2 as it landed, so I'll create incremental patches on top of it to
> address the feedback I've addressed in v3 here.

Thanks.
