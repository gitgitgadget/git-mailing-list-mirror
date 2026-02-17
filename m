Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3F36165D
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344704; cv=none; b=jXJ9pOXrlVVjFGBEyFcH9xYo2lzJUahYkAgigTzw7Rfzzl+AfiKEeY6sHOiBMJa4X8HCcmTL1ctUhAwdEghMuCmM76gtWt3XsgVi1EVNm7IbyKu5G4fPaIQumxO7/5OpArJjhzgOdl6elZBltXysmI4t8+MiM4VWMiHTwlI6A1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344704; c=relaxed/simple;
	bh=d5kaCiZyEoOb5kchrihlfw2eKojGyRmk77Y2cu7MJJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqQyQNrKBLop2RRAV10jNaKdEtflEO4wCQbxVSt14WOxuc0WXKLBpzLSw5OcChoaYGCuhGUCmkEE5vWwWcn1ffMhMH4tj5cZjDL72S+Colu6MHjXdFqIhIybuL4Y508OHm9BNSD6TQGo5Kevy8DFyIhmQQsKWm+lwqv9TFeu4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bLTq7TDH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rMaMH8Q0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bLTq7TDH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMaMH8Q0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6EE91400112;
	Tue, 17 Feb 2026 11:11:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 11:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771344702; x=1771431102; bh=L+B9WQDSCl
	lLnE4iY6u0SKA0i/IqixkY0OIlmP5MFxs=; b=bLTq7TDHOUjyBaY20UaJddGrcn
	giMaXfdCB0GtfTx1v6v5D7f3TAWswnXFRuQpdtYxK8xfKHXhQ4Js3TBsuYNtHYsH
	+sR59Wh5LqOfBtIRTYIASSaBYA6bAiL8/Ir0luDQmCDU5wkfAwWCLeP94VEXFJ0N
	IHD5OcPS4TiFmOFbcP/hd8+jhr7eH9itJXtFHA2TLjckW65LWsicofOQmVXx1ZPu
	nLEzH0VHdzoWqhglWSwnP1FamGzVYQ4ErhjA6c2UJ8NYaQJZ3uI07OLrsXJ2h8MR
	2CXq7uqR/HV+Cc5p49wkIjbezWP1oTSNj0RPmYmini+N1zSTDC6+AXhVo4LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771344702; x=1771431102; bh=L+B9WQDSCllLnE4iY6u0SKA0i/IqixkY0OI
	lmP5MFxs=; b=rMaMH8Q0otP0wnSu2UuO1JKsbk8kNtgPvAmhQP9NzSVRpXGFAoY
	YXWx+9AfaJS93Z10rOo8tZ0H6SxHG5Tbti8Mb5OnwharuW2r4H7Vfkn/BnyjSZVV
	1vFo4j+2/WS3TiZx3FtX+/zigzOWTPnTmQ1jPH1xe5Y90XikK5FCueYsceQok2oT
	B3rduQypXChmMIrZX7UVANJJEEBZgt/4bybAUHgz6tafC/VC/RAX/J99wG2qp8+V
	g0CQOxGyNeMjlXEzR7P6Mj1/cYDNufkMagDgqnxL5yXLLdgX0L775hadMys6hXZH
	urfzj93aEmyeJa7mX3EtBDPMcUbuJ/VznvA==
X-ME-Sender: <xms:PpOUaf-vxuQSRj6DdQZgPpjmUpdhNuzc2kJ8SYaE6WZs-Kv63ScHRw>
    <xme:PpOUaeTpf35eAQJy1AJYHj8vk157nKmBlrzwxHcaKWRRWOnrIKoZ8TPTk9ZCDx48f
    q8StCQ1tGSPg-9StlaoFohpzNisLyYCfU_gBHWL_N7FH9rdRM5WtXQ>
X-ME-Received: <xmr:PpOUaQpD56UnWuJTmKNpD0co4wUf5oAQbPwqq8URYOZL3w1ZNdn8C7hmsT9YIe3azwyEUOHkYWyX296PgeZ3Fwtd-125KaIhVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggv
    rdhfrhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PpOUabk8d_D01zqsnYudLJHx_HEazsjwJzbLkMaocp_cCtZ16WUemA>
    <xmx:PpOUaZdAX23DSj9HAign_0RjM7AjL9d8866x3irgZIAPTB2FVuCEBA>
    <xmx:PpOUaXrga7Qe_WxiVgSzMA79HXn_Wb-dMhN_tWKeBD2iBx697VHP1A>
    <xmx:PpOUaTMsG0O5qKHCRQVwRebCMc9whw3fUPJi4MQzvKSRadficsGjvA>
    <xmx:PpOUabakNP1c7P1IPWpgP3MTEK5Ev1VIIezG2-nZJcG3EqN6i8M-MLK0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 11:11:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 03/13] config: make 'git config list --type=<X>' work
In-Reply-To: <aZQvLzL-AhPG3rbx@pks.im> (Patrick Steinhardt's message of "Tue,
	17 Feb 2026 10:04:47 +0100")
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<6d2a48a3b7f61c068392e66933caaf1d78055857.1771026918.git.gitgitgadget@gmail.com>
	<aZQvLzL-AhPG3rbx@pks.im>
Date: Tue, 17 Feb 2026 08:11:40 -0800
Message-ID: <xmqqa4x7e4eb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> -	if (!opts->omit_values && value_)
>> -		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
>> -	else
>> -		printf("%s%c", key_, opts->term);
>> +	if (format_config(opts, &formatted, key_, value_, kvi, 1) >= 0)
>> +		fwrite(formatted.buf, 1, formatted.len, stdout);
>
> We could probably use puts(3p) instead, but as we know the length of the
> data ahead of time it might be more efficient to use fwrite(3p) indeed.
> Ultimately I guess it doesn't matter much.
>
> Patrick

If we are not always doing LF-delimited output, puts(3) would not
help us very much, I suspect.
