Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD3132103
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175152; cv=none; b=oDCl+GPFQqJwEKeIXnsDvO/AoZivJ6MaExbRYsrjwmLxtDQWidq5EcqleN8fjCiF8HKXiyGG4qrBHwjV5FiZE8ExDrZMq3Gl4vV/XdZ8KOEBpeacnNzYfoCLZjIEwtVuqTxvu5yU04145RlQrDVkzdx4/a7tsoUar8/1NJno6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175152; c=relaxed/simple;
	bh=UQFPlm8Cf0XuJjN+UNBRZIWIzRIP+8QgrpCKP6yB0dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CtgztmwcD1sxN11Ho5Sawrci4lw/58aggDYGyHazQFIxRSSAEJhboZf1+TSeAjBb8g8EvNovgDeZ+NtHBHZ4ASqxw4LMuqrHAhODJZhczGW6h2T92SkDu3e/TEtMcxKunp/f8h5g1b/HxzU3PhbdMYh0Bpv64ru+XMAnEOJKFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xZ9aY6Ra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DhG4feVd; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xZ9aY6Ra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DhG4feVd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C39F2540192;
	Mon,  6 Jan 2025 09:52:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 06 Jan 2025 09:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736175148; x=1736261548; bh=sfjmmF30+D
	SQdjPTMwNN6X4xmiGHBktF/WoQLhICdyA=; b=xZ9aY6Rav6OVGJG+67uowjvTVY
	zMZ9ZcTHnzJlzeDHGz0Kbnq2xmHtTmcszf3WAbYQC66EOhMiR7b+t5zJ0QVZ6bi9
	PTxrJu9Fhp0aIVXkb3voIgzXVOQ0Dvb8BLLzDn4mrL6vKLM/eczN4rxSD4JjNo2a
	tIzPElckV3cTgsYI4zf5bQb++m+VEIlp7vgrnLiZtwEudliIAFC8bojRQDRKSfdt
	0nTqaOzOxyYVm9vQgpUqXHw1AsyXQwAstmCOVrYJ+dTkTqylW9YSKaCPzLhUxHl9
	r8Z0LZqCOZx888i3vAauItN5586yNmzrzjxXsnxBongxRdP1w4dkDrOLllJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736175148; x=1736261548; bh=sfjmmF30+DSQdjPTMwNN6X4xmiGHBktF/Wo
	QLhICdyA=; b=DhG4feVdrb55qcOsJLDINVzhUEhO6M8bzca7+R24AV6S766oPcv
	8NC97qWJaWrpn5xfE5e5yNQhvOjyNG4Wh8HEII7UCycj1g0bJXOSv6KHNUj5EnUT
	vFp5Ul5AbxIGRKAQ+GcPs3YQ3wbvX/4BC1ETrEqqoHRUDpNogAUAcc2GcpZfRpjh
	jSQmtqyY8IF3bqFkkXXudfQ7Fwt8LaxEJtemTX2tCaIV53k27Igc9P5mLtI+7hqs
	UQXA24cRPYuPqAwurCOWlxWzbKBgWF7g7ALxxLZqzqvGKwXElH8ShH7cp2VLSLKX
	lXugMmySZseAh11ctqqIEn43gyloZaS6UZg==
X-ME-Sender: <xms:LO57Z22l5bvZvZw5ZW0DZrXYNgwm4ZXOJEnnrF_1Y3xwXHgfFuebYg>
    <xme:LO57Z5F52aGWEZ6a_NP16RI6rOoZqocjLO3LxHlGaGdh3-mfYtQY9Am7PACetQNoh
    ya3xxSYTYxOyBOsCA>
X-ME-Received: <xmr:LO57Z-5g3RO5GOUI4AD2QtO7EEy2k-fjVkRGe5k0dOh0I41GUgtANuBVHx7bkeDxcfYm5SOgcjK29E41i4ei71Pd5ff3UmiQhYMZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffie
    etueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LO57Z32Fo16dxH1S5vTPDZZ5Vm6VLPyLVwLmzTSXoXobESeoQR46Hg>
    <xmx:LO57Z5HoDefIdyKAcSWmuxI4nLSLrseM5ylSrDQl-BI1Tu91luq05Q>
    <xmx:LO57Zw_ocITl4dgxb8jgMLO1o7ZHCGDqXubls1DV7Y7iHBW5pCUWiw>
    <xmx:LO57Z-nZATd4dSdHfw9skI2POpBfIFN9FcIwAI7UMNI_gwCK2Di1dA>
    <xmx:LO57Z5CggvMFlJ63Kqn48JDrg3zzROWAAmBrp3KbGtu4WqtCSN_NAWtU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 09:52:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] git-gui: Bulgarian translation
In-Reply-To: <dbf29bb6-5105-4a26-80f6-36b796ffa4cb@kdbg.org> (Johannes Sixt's
	message of "Sun, 5 Jan 2025 22:40:03 +0100")
References: <dbf29bb6-5105-4a26-80f6-36b796ffa4cb@kdbg.org>
Date: Mon, 06 Jan 2025 06:52:26 -0800
Message-ID: <xmqqa5c42dw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit 5c95773eacee6eeecc16506fad3ca7fe6bf249be:
>
>   Merge branch 'js/no-rescan-on-empty-diff' (2024-12-21 14:06:33 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/git-gui.git master
>
> for you to fetch changes up to ae6336b6173bf5303fad53e0a52a16f92c47b6b7:
>
>   Merge branch 'as/translations-bg' (2025-01-05 10:44:35 +0100)
>
> ----------------------------------------------------------------
> Alexander Shopov (1):
>       git-gui i18n: Updated Bulgarian translation (579t)
>
> Johannes Sixt (1):
>       Merge branch 'as/translations-bg'
>
>  po/bg.po | 3721 +++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 1890 insertions(+), 1831 deletions(-)

Thanks, pulled.
