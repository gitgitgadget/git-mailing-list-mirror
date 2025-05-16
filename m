Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923C22ACFA
	for <git@vger.kernel.org>; Fri, 16 May 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432588; cv=none; b=ZBqm8aGwFiRUpVCvKwPs/BMzl/w3EmawpSC4+L89sDFoCbhlSXfkrN1mSiA5bsxjT/nTyziPc00k+FC/2M+0yFRNxm0b6ol3IGB4CSwV46GNfgopaitTFCwaSalEvwS6OlVmAPSQQmj9b/JrkjsWL+XRYgSTwikkox0KtoUzsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432588; c=relaxed/simple;
	bh=nBmKw3urDo0qJmT+XiNBwensAFXh4Y445aaP5fFRFNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JMOAg1LALU++akpbRDAQ/gMz73tmseUSmGYoSf3XOFuVpkYwgtTY2QrTlWcX96Po5C1KHvVT+YF0OU03EpD6irVFSttyCeRlFZpqcD1j/AwLfkukq4X6XHungnwUvCGIZOdAaBAJsM99lJVnJQXrza+siKy7CBGI03Kr5Z56Od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N5IjdxmC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JN3GcAul; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N5IjdxmC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JN3GcAul"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D88871140124;
	Fri, 16 May 2025 17:56:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 16 May 2025 17:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747432584; x=1747518984; bh=ieKhh9VdgT
	nmaj4Q5ghmj8/ZsHifrMSYR/hY8UNWcBM=; b=N5IjdxmCYMsni2NaxHlfwbW0zw
	SF+Gr2pmPYEqsO+yMMUqHjLdOeWJJ0L60Afw52s/Ikba8NyT6GfTSDw0fKcL7YOH
	0r4fCLoU5kqD3rJNWiApf26vfaW2DyqUv9dG1vH1tILt1nmy/cex6+hmO386Jx52
	Qn230zpzKaNmVlHM+mcacLltZkQ3nJ8UJcKuJC7jCR57EJ03Y5OH9AIMVkTb1RcI
	qYHymeixsRwk3kjKm7ezkr8ZocoGly+Zf75C0MyCnGQnNwOyRRn+NzJ2BVSfozVw
	N/g2rGod9InwYwkQWjF97UOrBw+y7id/l3XQmHE08Vb6Si2eVgpnhIFP4qjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747432584; x=1747518984; bh=ieKhh9VdgTnmaj4Q5ghmj8/ZsHifrMSYR/h
	Y8UNWcBM=; b=JN3GcAulu05gBYbMHBHcj+hhPFokERKqlm0VqokLC11v/PFwLuZ
	Mxuq8LNI42IyAFhapeZYLhMllbXiJh7pAOl8JROFxTMaBBymB9dU0oYFUIaRwZLY
	EVVaUX1Ikp3GufpDk0Xsp/0+i3cmTMSQqlm4vqYIUcW8FcgKihRybE/WgIevbt1Y
	uofiL51WfF786gAMM8qg1VKc+SUrf56KXJBG3qCtXF56DntYVlPEVdRU2U7UmoYJ
	pgzzYmEKjtGRPYm0Ss32tRJ7FEXXkjitdBRtR5syy6aEYTSz4EprGBXP+MqBmcwS
	XFVSsg0XTSmo8g64uxgWyhUQJ+0gOZ/rR4A==
X-ME-Sender: <xms:iLQnaCrWSds4d5MtpP2QpEERMGOW5viWGB0qhYCzajqm9LEPzbPdBw>
    <xme:iLQnaAoIiNckZN-9NoXS0E7V9rU1mYmmaJtXvP7x_xaR1pg53Js8wRrVQbV-PfgZt
    PvabLHktnqkZ9GTDA>
X-ME-Received: <xmr:iLQnaHPAvAiNVbwmEhAq5lQovgVP1GSSXNRbgwHMQCe6fqdl46CpQJRhqtpDA9gmteEBQkk1nV7fQmi1tDOeQRcK4sXi1yFWWdPBdq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusg
    hgrdhorhhgpdhrtghpthhtohepughhrghrieduheelheesghhmrghilhdrtghomhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iLQnaB6vLLbtMr4nloVECW4T9PaSgB6h2zzruUfPQRwe4hJUl-PCkg>
    <xmx:iLQnaB5IR2b6u85QxzpphCk_RpNdVbQmuyy0998QcOfsgLA6DV2qVw>
    <xmx:iLQnaBhFs5fatuH2NOf27vxLLPcMg_QDBtEIZpTRRki_r9x7GNFu4Q>
    <xmx:iLQnaL6MJZzbQEQ6YHAULgWQjdoKim1JTrVtdzI9OjgsxeehST3iBA>
    <xmx:iLQnaGIAPG0-45U0bzugwcfU8nOiwjY6aPPug6tmBQ56LXvZRtU19bEF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 17:56:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Moumita <dhar61595@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v7 1/1] userdiff: extend Bash pattern to cover more
 shell function forms
In-Reply-To: <a72235c1-625a-4b90-8111-629b5a6ee7c2@kdbg.org> (Johannes Sixt's
	message of "Fri, 16 May 2025 19:45:32 +0200")
References: <20250511141101.18450-1-dhar61595@gmail.com>
	<20250516144515.49514-1-dhar61595@gmail.com>
	<20250516144515.49514-2-dhar61595@gmail.com>
	<a72235c1-625a-4b90-8111-629b5a6ee7c2@kdbg.org>
Date: Fri, 16 May 2025 14:56:22 -0700
Message-ID: <xmqq4ixkte2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> All my comments have been addressed and this round looks good. Thank you!
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>
>
> -- Hannes

Thanks, both.  Queued.
