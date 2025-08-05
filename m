Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1A291C03
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410378; cv=none; b=rebKFSWIz6l8uLwvPsEJU3g3zejWknxttrOF1pYkwfn0lsc94U9hoJ9WC4VlvLjm06/Xw2CgifvYukr3U2bly81jPU7kdBuoCB/j43TsmPDa+NB0UwY2iM0f18JivUop/0E4FwTd76BK5zIODZGYF5BoKHsBEMiwevQ93eo+9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410378; c=relaxed/simple;
	bh=9fc9hQtGExovuW2Msx3OwYQoEfEAlUJOzY3V1evxkQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EBntGDCo3uSctb9fRbFJxSKbKOp8Ry/RUCH6sjt+JLBg9ZFJgjyKtiLvJKxe1yXckD4TENV7bVdsAmIlNXX040aOQPZ+A+LIf68V2QOXzwuwviLnWkGg7RtDPVC2iWcPI7VtvmGs8ojNzHuIQoJNaz/Msf0R2Q4/zuS3AmeY+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZPv1KOX4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OUt9fftt; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZPv1KOX4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OUt9fftt"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 63FB71D0020C;
	Tue,  5 Aug 2025 12:12:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 05 Aug 2025 12:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754410375; x=1754496775; bh=xVJT98Qqnw
	f5bGkRitrLhse1Id3b50gxb9p/iyziPbc=; b=ZPv1KOX4GIkpj1LdOrTsXazjV4
	pBkzhHjzrEXiIikrG3dZ7mBBk/+slq5dZD8frj/hgrhL7v8oVfPVNsnBFGbTOqIK
	+q8UDhHm0gJRecYcKroNM+ZyJmOdOey+qA9PxsXFRoj04Hn+X1mbLjxJokupEWOn
	TFrxkt3qSPNPOP2tmAQG5JW8bFncHqwHQVbTRjwUIDGQHBOk3jePrJhgqYILL3Gy
	4DKNYv04UHNJAkyWihSfsrsBWl2kFKqs6N6UZMgWa5Gz41l/hZLokEDLDJolqfSF
	SG8qfc5XEmXFEwyW4M+76LdKrTaxIu0x3pdeSAbXCmiUSb0VePiHfQ5G/O8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754410375; x=1754496775; bh=xVJT98Qqnwf5bGkRitrLhse1Id3b50gxb9p
	/iyziPbc=; b=OUt9fftt6BaTR54mqsvj/x8H3t/ru+0veVQXqqLkkQLH/JcHmFL
	D4riVYGZxNkuxc9i/8/Zova3nwnDtcLm4moqIOg4b6qRNf/rwO+hpoy4x87zVz0h
	f5GCUnfsQ7sadhHdjjJ00GMrB6FRBni0rtj2QfjtcMoIw11DZU2P+etcN2Gg7q8I
	lS0oZDHK7M9iqHa6aAJAKNPTpwKA+G15l2DQCpIHYV+PpdbWuH0PBcnNKL5DlruV
	ZBKGI+qggJJSTJf0LrXrR4DDoqWocXOWwDuiUOyFsVrOgutJYjl07PTVV5tkt+oi
	vxEJfuXz2HnSWuI4skGIs+X70PlrdTc5I4Q==
X-ME-Sender: <xms:hi2SaBdOHsMKyuR0Rer0DFQIEzFZe5ak1dQhS4G0HwRNoF32AN03sw>
    <xme:hi2SaMKn0NBaWlA39pjBQABiVYgYCG02uPdJ1zUSTZSXX5Jm8og2kBlP7bWQOVJSg
    zTaGjSXHYmMLf32uw>
X-ME-Received: <xmr:hi2SaGLXULfGuuGXjxVr9_BC6-o_QoIrZheNeQjxLPWyACcDfxkq5CcQVfPMXAJ_5xy3am1C400whTPu41MraaXx4UMnHlsJE5D7F-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hi2SaDVPhGFge44hqQgRR1MHsxiW_Zn6F-xbadasH25uoeY4G8HZXw>
    <xmx:hi2SaHlVE0AKJQVGIWgedgrNY4EQj6gMnovym35HS-G2zsHK1ODZGw>
    <xmx:hi2SaBlrVeM_-M1mTYlR8Lst_WHLFWkLp62PdycQJLTfwJCFtK5EQw>
    <xmx:hi2SaPbvViVuZtk8HKTOl0KQ0x4hZxBIASQBmQ5c9eHLOyvaK14q5Q>
    <xmx:hy2SaC8j6dhzksRPnWUbgs0X9lC1Zwkjo0eLo7_NqH2fjdFF-xaZP-g5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 12:12:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com,
  karthik.188@gmail.com,  sunshine@sunshineco.com,
  phillip.wood123@gmail.com
Subject: Re: [GSoC][PATCH v6 0/6] Add refs list subcommand
In-Reply-To: <20250805092758.5321-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Tue, 5 Aug 2025 14:57:52 +0530")
References: <20250804092255.1092973-1-meetsoni3017@gmail.com>
	<20250805092758.5321-1-meetsoni3017@gmail.com>
Date: Tue, 05 Aug 2025 09:12:53 -0700
Message-ID: <xmqqy0rx21dm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Hello everyone,
>
> This is the sixth version of the patch series that introduces the git
> refs list subcommand.
>
> changes in v6:
>   - rebased onto v2.51.0-rc0

Thanks.  Will queue.
