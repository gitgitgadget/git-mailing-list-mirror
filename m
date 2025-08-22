Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EA1FF7D7
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894532; cv=none; b=rHWIFjmX6OXACuDrLwXgEvGQqY9TJ2BtN4P93uhO9C+uB9wg6kI/W6hjRvIn4XMsCf25guQTwm/i7470bGhtFBG2CE00951of5bJFFdU+ftB6kL9/qDJjx3Qk9h1RqCRrQkjOeDvHP26kUlJo1bgxgfSzMwvcn58/s+LdomuAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894532; c=relaxed/simple;
	bh=tbVXQ3BFXH62IuFQlaVZHYq3mBGV4TfJbXoytTKotxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CpYfYWdYvM1wI1IRAyoDDgOdHmO0SG/OmnE9DW6SfWoehpu99XjE9nAVGc5B09PCtipM0CQpQXtJyvWZUqRZK57WdgjTChlppWrrI7rUW7vtRDsE604pi6jDYgY2ZyR4/aFLRYNGnCmkC/kcJgmcM3F6LiVZ3bxGOhMDWvBoeoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yvfw8rGN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nd7QVaO/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yvfw8rGN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nd7QVaO/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 231721D00159;
	Fri, 22 Aug 2025 16:28:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 22 Aug 2025 16:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755894528; x=1755980928; bh=6yS7xBICqA
	/gRwgaSYcDoec6wGrQby6m9x4AiAaoL/w=; b=Yvfw8rGNZYhX4XXq10LnQqhEKB
	AfWV1T4ifY6bhdfKLHCcbEV6M/GpfCjSFTRgTX5FRv/PjGIPnuHLd0PRBt8DkGBA
	YmrhQm+64YsVKh5efnYUpI/MQPpn9HMt9CXOlF7+K8smLSCxdyysypBzPE2b+0hz
	i+5RnvwJWs4kULpSswIvbZG2vr5KPuUCFGWK7gfZxunt/R0f7caJFBP4dTD6kMDj
	eb+wUdY4rEleq4+z5IMzuOWrKP2BkDQYjsIYR4NVT2otxrmAkEuweJER8qU1rvHc
	PVEyrcWrYVkFpi9Rp2PSHJFhS3Dmgy7A5g9gjvZJp+MhYGesVMJfZvTZM2IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755894528; x=1755980928; bh=6yS7xBICqA/gRwgaSYcDoec6wGrQby6m9x4
	AiAaoL/w=; b=nd7QVaO/ubha0Oo/lgeEy+tcN2VAkviPpfdn9drt2x3pnRa0jZL
	bBpvwnHUAkDD4wG524I8g281z5xacyQx4dHHdg89Ki6zwoPBrYwXp4uEFko1g9Fd
	k/lK6X1gMhleFkJgJg1k/01AWVsJZeAv1f0C7LWeECQHw5kNwyQ94CjAmbyvNJAG
	zSNySrILw7fS3mM4wNwxhDaHyqu54cyX4wAbuIiOZ0987mi8kIN09LIWIdv+OgqP
	Fqm75lDJTrYI6nAw12gwJ9gi3YpbQUxWKqEvlx0PLAM3drglRf40s04s3qzR1ROY
	G3e5qJHW9iBygzN6yaI3TnlnrpDcFJW1gqA==
X-ME-Sender: <xms:ANOoaANxxqQNxAdOsD-sgqrSdo5J3icaDm7N9FKGaTFZ4O46TiHPGQ>
    <xme:ANOoaBjetKjR2jRCyGnXPjIxTxruBvNeF_14tW_2m7eoLWr2ZGq9x-x-OdlsDTNf3
    7S7EGqcf7N1W1t3IQ>
X-ME-Received: <xmr:ANOoaD0uzLt09IeeVLVw14_ge-3htc4_fgGwsurk6jCHyo0I0x9TcEgv7oLNXDmBJMJgd7FS9pcsvm28aODod8WqcE4JyseWH33KExc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheprh
    grphhprgiiiihosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ANOoaLiz95qJY_ODJGt0mlSV6xGbvfhyhBU4LCYS-UcZYM1GQMNopA>
    <xmx:ANOoaDcjJRM76tha9QXXsVProi0h5adDcQrGz0yyy9TNiLognkz_NA>
    <xmx:ANOoaOl7EjW1QcmonL2GuXbR_AKYoFUM7aaW1uASheGu0Zuud7niDg>
    <xmx:ANOoaMv-KpjO8iUDcyqXJVAs-M2IA46MTS9RZBNVx_az17VSHl51Kw>
    <xmx:ANOoaNcelMJoTBSdgMx3ZWgzLtKYJ4b8HeeZTI3qoEd7OSnQcJZSgx6k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 16:28:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Michael Rappazzo <rappazzo@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] gitk: add README with usage, build, and contributing
 details
In-Reply-To: <cef6487f-aab4-421e-ba04-a5613c12e552@kdbg.org> (Johannes Sixt's
	message of "Fri, 22 Aug 2025 20:27:32 +0200")
References: <20250821222605.3993-1-rappazzo@gmail.com>
	<cef6487f-aab4-421e-ba04-a5613c12e552@kdbg.org>
Date: Fri, 22 Aug 2025 13:28:47 -0700
Message-ID: <xmqqect3w16o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> I would prefer an easy to read text file. Can we have underlined headers
> where possible:
>
> Gitk - The Git Repository Browser
> =================================

Oooh.  Thanks for being brave to say what I couldn't, due to fear of
being in the minority with unpopular preference ;-)

