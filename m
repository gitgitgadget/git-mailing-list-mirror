Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216D185935
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744861334; cv=none; b=jl1Bctq52NuVQouN95URKwuUccTOL91sD0W5//Cfg6b1M7d+uMWUF9bBdE2MaPoLQ0KXe1ds6wZM7xNxSApPi4gf51rTY+yULh2oPzvaJEjEkNQZDQRsaWAGX6mpBK+P/6fGiQB4x2GkkPahJm1hoHrbH+4FzQOyApSxQ1Yfx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744861334; c=relaxed/simple;
	bh=avpnbPGdfZqUqDb0BDCndtpf/l+SDOpD7oXcCyVJhPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZJTyjUuFAyGVDto3b+sZWZ9dUPKTKCL9kRVDVV7k2jAjtBKn/LONfvyzV8WITOWnrEdNyRtDpsDG9qad8sNs2BfONthxNJtqunxWTgu0innxpmz4WsbBgFwNfDtTrFtdC4VkZMCt0LUS/GGPrZvyYkMUvW/g7IYhlEdqAn18K3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pBuKnQA8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LsaUMfE0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pBuKnQA8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LsaUMfE0"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 58F9513803E1;
	Wed, 16 Apr 2025 23:42:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 16 Apr 2025 23:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744861331; x=1744947731; bh=yZPYf0dS/Y
	z7v+UnKROTPDEsXan5mguygvNFWC72Z88=; b=pBuKnQA8MOmoczwnkiWX0m56TT
	+dg62JxW6/dC1T9sL64S8xB8Bh43eExzxu9hzo6f8blGY+6xiCBEbok+2K3fZMKb
	NYkwurYPkXHjDoTPGuCmM6EFTSVAqmiTuagmXlfuvJwsRsr0HP8ViBANJPVEPSsl
	9TX2nHxzHvjDk+UTUZEY7wWKaQ5GXc6Mj1oBuWJ7ksASIvBWb8V6BwQ+Ra+uI2AI
	tK1RNs7Yky/AZx20BoSSn4bVFaXaKzr/HLFakXpes5T720u+jRs9Bg4mxjSAcAxU
	iMHS6JW5bqz5S8VxSTwsIzW1qjEjvm3vjPgg8AONuXQWfeIQXaZtdYDjxEnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744861331; x=1744947731; bh=yZPYf0dS/Yz7v+UnKROTPDEsXan5mguygvN
	FWC72Z88=; b=LsaUMfE0PFDpglPvLnZOdHydrWeBw7zk5RcnW3e9D22HG1rcNTg
	w4SU2oU0xZdW//r0r/vciSazwZ8IoEUjO/RBRGB8u22wSfla+Dqz2ntoA08OkGzf
	Iy9rLQKm6BWlxJ4+mNrDmIdkxeKIHREjbZksm0LbH1ThGfbj7WvHjO9wDIhm9Tqq
	o26BZjvebrGgMalCA+RAx0Nix98MPonb7oSnPnWVC1YlmStwEt//oXFze6lf+1A2
	WhrRrNxhLa8nXt/TB1Z6aRc+Ofu39gJZZ0MpHNIxJLPe9jBIZkPaB7Cr53OzHkSi
	TU90R1IU6UyvVtz19jRLyHO452Yl8f04w5A==
X-ME-Sender: <xms:k3gAaFmHQltyBAjKD1v4zVkALNO0Kiw2ipf4qhIu1rDDhLphvZDWmg>
    <xme:k3gAaA2z79zeAMuI_hEGg2-Yxu6BIQK8zsN_ETO10q9ZwnuCsntb1L9Zd4zTAOC5l
    3UKQHy6kMv3RQTecw>
X-ME-Received: <xmr:k3gAaLpCSbqKka0lapsUTyxSMpDDXhrtfS_QFABjf6xJ_nk1DSckbPtbU2xLz4kqZV0xAkgJBrVefBLbH2M99muLvj-TCRLIvNGr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhose
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:k3gAaFnxfzc1Gw4Dalxcm_Gu9Vftbxrtl68iLJSi6YXMkFHyy5j7eg>
    <xmx:k3gAaD19n3w8Gtr67IMuI_MFUirkVnjYblroDKYphM-LpiH6nJi2cw>
    <xmx:k3gAaEu9jzX0wEDPT-Kj6Ron2iG7L4dTLiwkoj5j1wUHQ-JApisGfw>
    <xmx:k3gAaHWMBvBlGjlE4PDUzeb36tsGAcD_x-inCAIYPTI4pw0u_RueNA>
    <xmx:k3gAaHh_BmeSGx8WmUzJZUh4s_lZ34s6oPN7ovFRefGyBDt9S5JdQy9n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 23:42:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Derrick Stolee <stolee@gmail.com>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  james@jamesliu.io,
  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] docs: document core.hooksPath=/dev/null
In-Reply-To: <aABNzj66xq5HA6gA@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 17 Apr 2025 00:39:42 +0000")
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
	<pull.1899.v2.git.1744818135435.gitgitgadget@gmail.com>
	<BD8FCCB1-C97D-4057-982E-93A7F8B01AB9@gmail.com>
	<9e14443c-e549-46e1-9fbf-ee72800e6944@gmail.com>
	<aABNzj66xq5HA6gA@tapette.crustytoothpaste.net>
Date: Wed, 16 Apr 2025 20:42:09 -0700
Message-ID: <xmqqecxrfo8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I thought the text in the patch looked good to me.  I appreciate you
> graciously pivoting approaches and documenting this, both for the
> benefit of users and as an approach to help make sure we don't break
> this functionality.

Thanks, all.  I too appreciate that Derrick left no loose ends
untied after changing direction.

