Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75800332ED8
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176917; cv=none; b=C7TUgaKZlbt7SMHu0QUxfHPnGyjRpblUo5SBe87V2r1ozrqUgbcZMeen9SeOkLUHDnm+1HcE/rGDfYX7o3mQSHKtlVsKa0hnDI2FBIWrLZL1JN/pszAMgCb42X1vEAf4WaraPwbYRyyHFdG/YQxMskfKguPUnbWgbo0nO6kn40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176917; c=relaxed/simple;
	bh=Bcjl2Fhy2Ix8+j0wdWmwIVPyyTowGl3dPMqQ6lxzIck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7SyJmvFtaNrUlhx3lVjxlrw5KpsGmeJ23v2jLSQKcvx08yupNn+PUxivhqzZ/A6w+TWVc8JBXkHVW7XV3lYfOx8hzEaWxuYFDpbevR6G49eoNkwoFVIOKtBZwttbTpHmFI+xBuq3/ycU17x791a3h5CBP5k5RGxB/C98/UPgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q52FwfAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eleBLCZl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q52FwfAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eleBLCZl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C95DEC0469;
	Wed, 26 Nov 2025 12:08:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 26 Nov 2025 12:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764176914; x=1764263314; bh=Z36ZncB2Ha
	IYTzhsJ4VRBiNC2QrEh64c1wLRhV7aeGk=; b=Q52FwfAH4zetjBtMBurdUqOQiV
	49ufk7H+hcTBHYCAzr60NGzg0NKbozv2qUJKUKiVelo0NbuylJFhFpQiWYPFJWdP
	cs1OMR69Hoq7kk60+G0TZcS504V4+fUAS1He4TxoMLy4Tg1+cBL93ilhT3KBlUy0
	J6XuJVR22VIZO8XRyL8GHk9vjFB6yLdZyL4RRnmrbBRfcj+4zgZW9t1H4gvLGl3x
	VLQdatxK5gZ1rehuLoE4e/9pUzST6WWBMfzw4B9yyJdy+nNVb3doomSJ0sGSRf+j
	6Z4l3fSyJMYx1BLP69DLK+Kg0I9o7s425veZwm/lZOGVaNDuEpxRDHwFfbWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764176914; x=1764263314; bh=Z36ZncB2HaIYTzhsJ4VRBiNC2QrEh64c1wL
	RhV7aeGk=; b=eleBLCZl6kGeNaw/J68E8UGgmMh6Osg8Ny2hTwsKgJBzrGT5Xai
	tG6/KSdhzRnASlBMzde/3T6iOHNFI/MkL1deHlHZrsJuHM8YaLl47A9/NoFU7Mw5
	1aYjuBZaWS8+rWH+H347FhHmkTulXbLkHKUlyL3jbEgaE3HGkMKx4lVyvYwlZYKA
	UTwqy9S0gcq4tU9Sql8zRz2OkIfKwdiUPpf7RM/BYEbfLXtvZiEvjJxg8IALro/v
	qWKyVSQwu1ZeOyFtBv6ovRh9hlsbNqRIY4syV0MAr/kUZyD+7SRvXKb+1diHys3I
	cc3pfPxiNEfTkmWUPswAwhL612KRfJNLa3A==
X-ME-Sender: <xms:EjQnacuci0ksOneWR_0JWAmk-fYourkc-MRiCXLecdtNp832xDnFmg>
    <xme:EjQnadJl5UvImSKRhEIBjJGqoXShMEEKx8JvmZ1dnwzYxdnOXL9agTr1A3vM4meCK
    aFnuKnj8vLPm1SiU68OzbKIeqtNj6kRa4N5A7SRGS-sHJDwipB6wUM>
X-ME-Received: <xmr:EjQnaRlhgqy8_MjBDtTcdBRGhVkGTyNnzSBzmSEMAaYDGN1IlCoGEEhIK11UEPhIcvXzCtNU8-aaLO1QQycCgqjt-ggUPChVcdVr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrghnrdgrrhhi
    ghhurhdoghhithesshgrmhhsrghrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrrgdrlhhkmhhlsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EjQnaWI9uaubDRydhgN6hUqOjxLpl2emNiMJQNwjVuCdwCIimBHsmw>
    <xmx:EjQnae790oPQsQ38dCsGLc91b5fCn__CyJasUHU2O_aw3cgC3p8HJg>
    <xmx:EjQnaS0RkruPm8WTr_hO4mLt6etH1NDpWq621ZuPp2HHRW7w_1mKlQ>
    <xmx:EjQnacc0JAJMfNh3EvNHLoIJsdgTdB7eC7ZS63o6WQ7pW--SzuDYRg>
    <xmx:EjQnaTUIl11UyMY2CfKNjjKnUAABAB99BgLOex3m-qViyESJOKN8C7LK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 12:08:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Ran Ari-Gur
 <ran.arigur+git@samsara.com>,  git@vger.kernel.org,  "raa.lkml@gmail.com"
 <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
In-Reply-To: <20251126145320.GA4143292@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 26 Nov 2025 09:53:20 -0500")
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
	<CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
	<xmqq8qfvw2lh.fsf@gitster.g>
	<20251124235530.GC2051672@coredump.intra.peff.net>
	<xmqqo6oqucka.fsf@gitster.g>
	<20251126145320.GA4143292@coredump.intra.peff.net>
Date: Wed, 26 Nov 2025 09:08:32 -0800
Message-ID: <xmqqpl94oh67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I would be more sympathetic if the original report was "it is useful for
> so-and-so reason to do this whitespace stripping". But it really sounds
> like the problem was some caller doing something like (in perl
> pseudo-code):
>
>   system("git", "clone", "-c $key", $repo);
>
> instead of:
>
>   system("git", "clone", "-c", $key, $repo);
>
> which is just a bug that happened to work in this limited instance.
>
> So my inclination would be to leave it be, because I do not think it
> merits the time. But if somebody else wants to go for it, I will not
> stop them. ;)

;-)  I might, as it would consume my time as well as theirs.
