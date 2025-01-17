Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E025A659
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107215; cv=none; b=F5Qkb0W9brnxxtIwfadqXncfZLEe2BgBhfsIhMi4tCtA0f4T5N8h2NXuqhHmR7E7qRjC2yhsxVgst1sZE2B+bUHbygt3ByNTIOyiPRug4IXxUR1D5Iz1XcXKBFDXz3s1D1NAe6G1d4mkk6qpehO6mPC8KS171XwhkudfbOGeyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107215; c=relaxed/simple;
	bh=VzSlsozGN/t60teHSYd23NioXPahrttDXlYTEVnWpjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lot1UmlaPtlTwWBW7o3zKmrzOx3nUu9TJiOXXEMheiBmDAmAZNscbDLvEuSjGZO4EjsjW7dIrLrJ4LZLBNLu22ZDXPIao4E/3Tc1qcZZNLrInsiFUz4gK5rhe3RdSXz2X3M/n3Pn94b56AwzkPrAglPeB+3GCbXYeIf5JwQ8ZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xz3xz+Lv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kqd5ULH0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xz3xz+Lv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kqd5ULH0"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80051114009F;
	Fri, 17 Jan 2025 04:46:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 17 Jan 2025 04:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737107212; x=1737193612; bh=VzSlsozGN/
	t60teHSYd23NioXPahrttDXlYTEVnWpjs=; b=Xz3xz+LvZ/kpO/zhJWBYPqa5MY
	CjPZbB3dYVW66TkZKhmHZjizsgCyri6T4shbuRNuXPHFVbfige41oH0s7rL0mEws
	TzVa6aACxF3T0YDLhvzygCM5atP9gAC84TqAPVrNsaZSoLWR8vPTyt/Ys3acxVF2
	EjMpsws10Y0RqpnO9QnOGHkx6Rpbs8/ZbZQVhUhXhCaTf3jsPe2lSI6ndG945YVO
	YoIORXVX38SsyHtPxUrOnZf3bjOQwhTZTjxBasVbbv6t53Dn9c+ha0cFoJyx3SW2
	W00svD1D8h+6LqKMj0JQ6a+wdv/Iqr75juHkq4KBs/QTq3u5eqmFmOuWQ0cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737107212; x=1737193612; bh=VzSlsozGN/t60teHSYd23NioXPahrttDXlY
	TEVnWpjs=; b=Kqd5ULH0MSYksq2fTJtJkbnsBBHfNii7loxx4lpUVG7UTWgkIez
	rknsvMdzxKqb4uWHfOupsJvkI00k7dyndx6BGMc0LDiBSKtMBzVInEL6r3IN/8d6
	5AwvB84VHD4U5hebRpzyC8b15cAPPfP+3k0i0S2DKWoPI2thLnA2lxmMG362cqQd
	LkS5dmiVs19FTF3+kZz/X8xjvLTnTgTTaq/8lOMCLT8NTmG0cQl3b+EOJWMqw+z7
	VrcdglsI/JxWb6Z5hbcgq6wBOesJZuRuz4Mkhi6H1JDHEGAISP8NN4aUFufJ7PER
	yvBr3ObqIp4w4E8ozGfzizj2VKaUpKVZMcw==
X-ME-Sender: <xms:DCeKZ4ibNcPIWtx9VWeG59EhTqjzj6FHx0yv6IjNxGAKS0aTP0rNVw>
    <xme:DCeKZxCF5eBjmz9gpZrtjHCpJYbTrAu960UZJ0vn9vLgd5_WaQdhJDO5q8-H_FLU5
    _cObOo7EPnqr6KSvg>
X-ME-Received: <xmr:DCeKZwFgZnls1_8vv9ldUxjm0TL4e4OHdfHx4F9okjrOA9abkBAx-jWZA-1I1gmbZVwdWGTVrthB3tP_j0G4BMhqavqDHnmufE8VzX5Wy-wS0Oo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DCeKZ5Qyp07C27pH4krtvSZEM9DfzRfj4BmLJuagbuveHcEz01FTBA>
    <xmx:DCeKZ1xFVelvVBV-5ulY2qr5QqKU9q_aSsTPz97fo1-SuH1z4u1lhQ>
    <xmx:DCeKZ37MVS8XCb1THDgIiYz4HUdpurxtq_q2vKicgYsRep9bRLeGCA>
    <xmx:DCeKZyzXBnj5PDLb-45q3GMLBiEvbAPCcHBbPvGEJQBolvA5BXU6jA>
    <xmx:DCeKZ98D8BlZrUX93c2IkwSwj7Iq-wlzcCF7iP1pAzvghHVBgJ0a6CVL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:46:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0838f0d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:46:50 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:46:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 5/5] pack-write: pass hash_algo to internal functions
Message-ID: <Z4onCYz5zD0L1_Q-@pks.im>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
 <20250117-kn-the-repo-cleanup-v2-5-a7fdc19688f5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117-kn-the-repo-cleanup-v2-5-a7fdc19688f5@gmail.com>

On Fri, Jan 17, 2025 at 10:20:52AM +0100, Karthik Nayak wrote:
> The internal functions `write_rev_trailer()`, `write_rev_trailer()`,
> `write_mtimes_header()` and write_mtimes_trailer()` use the global
> `the_hash_algo` variable to access the repository's hash function. Pass
> the hash from down as we've added made them available in the previous

This doesn't read quite right -- from where do we want to pass it down?
Other than that the series looks good to me, thanks!

Patrick
