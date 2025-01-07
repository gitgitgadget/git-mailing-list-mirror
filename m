Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9C1A83E1
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291552; cv=none; b=WbiRpRLYgPhk+hprqeCY+L8eVAq8su8O3L3tkTUUEsMZYdwcz5224nzxYN7iCXUAvMigrNN0pGS+GB2F5W6LQfH1iBmxoh1ArHZv2rXaIsp5UUhXtaikOSi1jNHi8IZWIaO19xK5PCoDRarlbp7h7jYx9/OPTPV26CbooYyGz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291552; c=relaxed/simple;
	bh=nS5VnIK8a1IiEQrJBjiXGobVv+eH4RufOnD+urkmSpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l4ozGIaoj9dxm0ymDxq4bfab+yGTi8XxEhNSpE2EG+LQL/w04FjqpaZmQylpFEfw/Kyf82iwyfqr3aZRQdUN5ZcV3T+vVNYzp4upczzMRD6mas+5bGwulHOFNFmYLN/istf/Ulcs5eLS9jXSPn9ezIRlMYeHdKZ2Dv4UD+Uv8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dqdidcgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sycd/CTA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dqdidcgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sycd/CTA"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5FD9B114015D;
	Tue,  7 Jan 2025 18:12:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jan 2025 18:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736291549; x=1736377949; bh=qQaf2/kwxo
	S9rnt8H6y+d26XgUXR1DwJo90hfHG0g5U=; b=Dqdidcgyr6kWyF3lE6DbW7kZSg
	XwSYCKqpbGdcIhVlfRubmOf6RLw40LqBD0M+WiVw1ljV6QlTyfOfeBwk370nOn2K
	YbofUm3HAhrB0GDItow5Y49i8vQiW+gJvkk/k62snGis8Ba3JLeQrJZlLEu6TBLJ
	NvCGYoHUJrQEBpX4hxdhk5okWQ5S3zAn2fXd04z3HXPLtafijYdfnKzRbS9rXW8V
	6vdHX6fqMCPCIoosH0ZvTdIUtJnm0Z6G+T4/yKFrLZBMPqZ3O3LeQhE6drMq6gcc
	WZ4/PSilmYwU+EcfYdrGlKiFIvEs56WNSnenDxbBBXXQr+bRjB/ma2DoPZ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736291549; x=1736377949; bh=qQaf2/kwxoS9rnt8H6y+d26XgUXR1DwJo90
	hfHG0g5U=; b=Sycd/CTAH2r/zsXTAqdheFmN6730xPxFld4Ded89HttBJFNx2LH
	Ud+bxOvDsA3UGxH8rCypl/qNIhV9Q+b3M2xqnTfWi2PYu3w4+rsZ7xGDjh112PRf
	SLW/QLR3fzT2MXzviTzg/jjGwxlUAZ9TGTFA6iqZ+6Zc/xhLM6WeNfwTABic0D3X
	yY2N0sEs520IHFB5w7MzjUCN0cQyUR018vfrEKaI6e/59Rv5scz+u7kssl4TqgkN
	zOacf+aORy7RsgkwyuJ/SlFOzxHPgJv3YxW4JYdIr4ApPaBs9b7lxL3n4E3vBZQr
	l7M7z25yFHM7WW/JFHTrNdYU5WdpRGM6YAw==
X-ME-Sender: <xms:3LR9Z1Dsah0PZbIFWqoS8nY5Ip0a-RXblpwDOxuRZS8ySwXZrrx3nQ>
    <xme:3LR9ZziajBgtL_V4Jcd5ySMxDSAj2a2OdDftrSLUKtRxQX_N_SE_z3xhsRPTlA59D
    XQBKQMbS6d_mDMc-A>
X-ME-Received: <xmr:3LR9ZwlSbHn-RRVGC_TuC_ansjcQdzDNi6CFpjVWY1wDVd3wh5ughoQmEdaeCQhio5bYpob1wkCFxNsvUo0d2oninHlOLyvGvzJ5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3LR9Z_xvArgm5DKb4phBiHmnuvWOO17pHwASiCJY817XvKC5LMBPVw>
    <xmx:3LR9Z6TaOYqeT8qu963YzrVyeP4CJpp-CLQeVFEdirwfzwX73ZhUZw>
    <xmx:3LR9ZyYMKB1WSeJeAOGJQ0vpGO3VEzsjjY_78gWxiMjSbtHgGycqAA>
    <xmx:3LR9Z7ThnP7TKH9G75UIVKeFCHiJoGi6oqMQ0M-JISDw7Gn1XRM6Jw>
    <xmx:3bR9Z4eQ2-KS5280Wn8tFO5uPcdJhkv_Hfku1FAXyVVH91li89wUJFuk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 18:12:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #02; Mon, 6)
In-Reply-To: <87o70ijpgr.fsf@iotcl.com> (Toon Claes's message of "Tue, 07 Jan
	2025 22:15:00 +0100")
References: <xmqq5xmryalp.fsf@gitster.g> <87o70ijpgr.fsf@iotcl.com>
Date: Tue, 07 Jan 2025 15:12:27 -0800
Message-ID: <xmqqa5c2qkv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ps/the-repository (2024-12-18) 15 commits
>> ...
> Reviewed by shejialuo, Karthik Nayak, and me.

Yeah, thanks, all.  Marked for 'next'.

