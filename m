Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA92AD04
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124551; cv=none; b=aBK3YSUvdPmhPHZNAeyrFoTk/SWQrjLQjxOaddso8uDYiAjRo6O6R9RSBLPyY9GJyNffW4ewKj2HI14yEgTY5vsSL1CvM9LvVE9qsphhE5J0XC4XhyVRbSasMb6N6vl8MqX1z2L/omnB4EtbrhfV8iXHDhCCgmhEjrGaee73JJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124551; c=relaxed/simple;
	bh=NxGuozT9fdueoSOXAKbwHXnUXuA2gs8pxDnp4G7PEcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GtdjjOEs2Wra3CmHfYXIwG0Yv406+od+Rh5vlgeYU1mIEPsSkie8+rcZbDhjCdx78+84Rl+GwImsMfZsbKBPK36TCvamBTeqU1X6qFKgA+joCGC/46WiNi9mFNdSDQ4y1AyXELE97DuXeZGMEv967qhob1Ri4mmck1Em4BFkfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XjFZ0AYo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AVsLEGzi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XjFZ0AYo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVsLEGzi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 50F9013800E8;
	Tue,  8 Apr 2025 11:02:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 08 Apr 2025 11:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744124548; x=1744210948; bh=CGqqNdXKkD
	xAiIwsdRY6v6xtX+J0ZqOC1BfBzsHbe9o=; b=XjFZ0AYoTVWVjvMYuoTxV5SxiY
	QZi6BgkYAhwKFFbVFclywYvLrfJSzCwBgjvv++1kl9au36jklk0pVN5Vh6qsTAmk
	0hLhRdwIEAI+W2sZqC0BRsNFOkF1mT4B97Q6oArt0vWaWpnFatiWjimMiq8bzYEe
	2QAd4FMlAGFfTgHxP4N3uVeTB4CZK/SSFPoX95wQZWAikYHf4HseZoAQJWutmE9+
	iREPo3pP3lAK4OTpVJ6LvvgIUKrIkJQb0/fEw96EdZ4RY6fk38JS/CwQzQtkaTCr
	/CP3o+zbuKx/FxwyZAEq9qZFqtw2v+DIIuAtd5Sd1fzL48u6FgV/k1BWDpmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744124548; x=1744210948; bh=CGqqNdXKkDxAiIwsdRY6v6xtX+J0ZqOC1Bf
	BzsHbe9o=; b=AVsLEGziP64foS2jA+1J4BdxEIlg/bVrIdnjEtaXHwyfQRXmnlh
	n4614xyH8f72O4+k1k++IzePcnc6DTmXAPhFzJAnfQ9bN2btDBNLw1eHjvUfwgZj
	A3mjgasFJIYzCLHobldH1DsLq/F4OsYdxXYtHxT+7oRsuRanzCUmYwTCwnjWQSLr
	IZKAoq+dwQI2GJht2ts5butsQjJ0fL63LlrgUZmRe0HHTZP0Ux/vclCBHLvor2g7
	Hs2inOYBdtAb0g1cYAjAudjmkkzwL6lKrjkGwcUy26ImNf6DuJ7hhi8TWMzoeJ6s
	ucArQAYJQVTftaJOAFGPWTpBiWyu7aKHHJQ==
X-ME-Sender: <xms:hDr1Z6O0v2WiUJk0Yky9rwcvNANQUuOePoISJ2Yf7J1i_qQK-41S4Q>
    <xme:hDr1Z493JLdrDHSTHckebSI6hj5Z3oX7ux1bTgCEBjinS9S-EuXHGThzrkkepvO8i
    PS2MGJDoP0_2kXbWQ>
X-ME-Received: <xmr:hDr1ZxS6Je9p-ijZWg-sPKSvaMZnLILgHzRpOojsQuChyVnCPyuo1SEgTSHVNCuyQ7rLOmCGL9Gg_nahX4Fjywvbi66AI9CTYfpd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdefgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggv
    rdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hDr1Z6uekd8KehlOK26iBM0I9r9Sf40k5bo60AUTaz5FQcIgo7vcUw>
    <xmx:hDr1Zyf1ddEPeCmasoFgE5B2b3JBQdBTZxp6moiS5nxK0XUJ-92wEQ>
    <xmx:hDr1Z-0HVXz1HD81vabTkJ7bt0DJ660QNOd4tZQ7bgkdseb_S5WjDA>
    <xmx:hDr1Z2_fbJw1sSBMJxtePrsqHYlKXKnRvDKvNzp4iyB-1CkHbJG5kA>
    <xmx:hDr1Z0B_Rm5t2rCVa7WOgP1TLZvMbR5dsIGrL6jc9tAxqxlMCU40iNny>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 11:02:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im,  jn.avila@free.fr
Subject: Re: [PATCH v6 8/8] update-ref: add --batch-updates flag for stdin mode
In-Reply-To: <20250408085120.614893-9-karthik.188@gmail.com> (Karthik Nayak's
	message of "Tue, 8 Apr 2025 10:51:12 +0200")
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
	<20250408085120.614893-1-karthik.188@gmail.com>
	<20250408085120.614893-9-karthik.188@gmail.com>
Date: Tue, 08 Apr 2025 08:02:26 -0700
Message-ID: <xmqqfriiy9vh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Content-Type: text/plain; charset=y

Please don't ;-).

More practically, is there something we can do to avoid this
happening in send-email?  It may be a not-so-uncommon end user
mistake that we would rather help our users avoid.

> When updating multiple references through stdin, Git's update-ref
> ...

Will replace and queue.  Let me mark the topic for 'next'.
