Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A05273F9
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405415; cv=none; b=cUu3ybLd0XkP//ZlmkTYg3lymCXSw8gwtr0mqa8Xf/D97fmQ0T+7tnSrIVK+Dmq+P8xy6j/JUd5IaTfZ3u84H5Htv9aWdksBFkZt0zxD1VDlg5zV4gPm512FrTU805JLAEKLU80X+MQMvADRdCibHqa/xDH0Vc2ysan37nPsmds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405415; c=relaxed/simple;
	bh=zDjaFiRZoKfAHuiXcO6zWAoWj1h12xb+ZwINRwZeWrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MleXa3i4Lp8ohWQ98Q5O894GE8+4JSWO5NPDzuEUTWTM2PPoPb1fKgnp6i/IsuZXGiD7DP8fphE9om84Ey3n+tFgbnSchclm76F7rbn3siDLh3PsRbKMXf3mXYXYKqyZu0Z4mo1hJ6O8q+9LVI4dl0TdhChXLf8sqOw8Oi/vnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZH57hlz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s+i0PV1O; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZH57hlz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+i0PV1O"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBAD711400A5;
	Mon, 31 Mar 2025 03:16:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 31 Mar 2025 03:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743405412; x=1743491812; bh=zDjaFiRZoK
	fAHuiXcO6zWAoWj1h12xb+ZwINRwZeWrA=; b=ZH57hlz9kR9fiO4WclEwbvSp2y
	5Kiejtf297EoiZ4ha69TVOnU1bI7TBIZhQyF8OcLB1s1FxjpLdaJEdHX0kXYuxaO
	5wdXewUmMcyIlyU1ALqfIejW6CK0rUjkP0q2zrBIk8EcveiZfoDjrVIyVSpiQz21
	BIQqrvmt9EhLPL5ypUIAy7qXXYI/yPF1GDeESb5GF6m6ZoytUUAIUgKaH09Ev+UR
	nj7vVUh7R70iAgwsUjwPV5bD8w84kxrL1OSeuPQa8U7HfLf1eK9oSWsdun058t6q
	13VAQFbEAVAktxPYRybDxkFsxpwCa/1KeythGTkvsnrAvQD/Pw0ntqG4hVTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743405412; x=1743491812; bh=zDjaFiRZoKfAHuiXcO6zWAoWj1h12xb+ZwI
	NRwZeWrA=; b=s+i0PV1OQyyaSaJsqqUeg5RAd/qKh+Xn2Yk0C2G+7JeET8PKtkY
	1go434cPK4mrzVcq5X73mbaUFjd4DPb5QxihmX9uolOvHI9UCtLloKM3I/PeVwsP
	Lxh1hS9tzSlKOKoWB8gYnpIThdTUuqrPvNTWszxOHUqjQ9moWAnDwye4L3odmfmm
	JeYFGCHstOriTUJhSgYPexMf7TQpTvXt+qvThpeiit3JfZFvfX9Bw/WW+ItJel8Y
	y0875k/wkTeaiDBuGJH3RFwDCLgUPcFXT3e91Z7vexjML5rKXt1TXD0X0fsJuddT
	zivxJmHuYK96UsekViMhWEBv2jXdyJmN0Ng==
X-ME-Sender: <xms:ZEHqZ5SSA5fmfp3UzGdADnN1i1w-iYy0kSu5XTx8joICt_8TNnnpEA>
    <xme:ZEHqZyx9nEIwNJm1enE1E8QsQzqhyNqwf4RGE4QnYr_FCDaoow-yZS6IkFzZcPEQZ
    ta-51mGVLOdukRBbw>
X-ME-Received: <xmr:ZEHqZ-0rB3neVeYxSEHThXtMBluTZPR8afam9_Vk9HuKSQf7sNhpM0vXS5igU53CZMYh9UCo9SeZBuZspGzcEAl3126hnxObUr4r2r92afIZlSTl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehphhhilhhiphesvgigrghmphhlvgdrtghomhdprhgtphhtthhopehjohhhnhgt
    rghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouh
    guvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinh
    ihvghmihdvtddvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZEHqZxAO5ELJCpc-uaeML0qPABMjXFwxg9CjjYc3D6Jii_z-pnl-OA>
    <xmx:ZEHqZyghwHLtpuLOmymdxX3xvAAgPbLFllQqMEOPiHuKTSFK2Azt1Q>
    <xmx:ZEHqZ1qqXjvdVfZ9kTt6qwuljU7gUkGvAF_l9QbPgt4UmVqlFEJ8AQ>
    <xmx:ZEHqZ9j18N3QYLp6aKxHbV0WjlbQ4DDbIW1CH2Q4s2hO3zvQVRBfdQ>
    <xmx:ZEHqZ9PSWEDwhxoLAMlI8ymVwYKgXJukHj7etiELRt3eC2zQPVbSGMDo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 03:16:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63afa873 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 07:16:49 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:16:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johncai86@gmail.com, me@ttaylorr.com, shejialuo@gmail.com,
	philip@example.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/1] builtin/update-server-info: remove unnecessary if
 statement
Message-ID: <Z-pBXOxmtJu9a9R4@pks.im>
References: <20250329120327.105925-1-usmanakinyemi202@gmail.com>
 <20250329120327.105925-2-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329120327.105925-2-usmanakinyemi202@gmail.com>

On Sat, Mar 29, 2025 at 05:29:25PM +0530, Usman Akinyemi wrote:
> Since we already teach the `repo_config()` to allow `repo`
> to be NULL, no need to check if `repo` is NULL before calling
> `repo_config()`.

Tiny nit: when you refer to changes made in a previous commit it makes
sense to reference that commit via `git log -1 --format=reference` so
that outside readers who aren't deeply familiar with the recent changes
know where to look.

Other than that this patch looks good to me, thanks!

Patrick
