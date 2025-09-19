Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8F270ED2
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305719; cv=none; b=gqWIyr8KE6et0MH/E3QNH8LoOBztA6dHgwNYIyMNpDfnD7EpDE9qgO4uAFIbMRn7eYSGgraoVp1+0qXnliaRT2HGV0HK1FtQk/uwK5mVOSIQlxbOpzD+avO3GEFU8wQRHVxINs6ZMyirvgRXl82pAOig4Cy2ObM/SJ1ws2w0rqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305719; c=relaxed/simple;
	bh=nL57L3uChZLqOPCQUXyMtoXC/c4p/3ySF9SAXPKHTXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lrJ5UEjOjRymVa7TwdweG7Shnz2+NKuA1fyqcXrGWf3fsMHXfGq+0CVKiUy1WhqsyRrjFjh9GFuA6OGLIiZo6A9QBCo52arndBcyofrEbDMk2vNYHnxEGzmKVjF5GQdXUzzQdQcAhxJELoPqsv8ieERpQUVZ3z1C0GBrE6ugx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=otlW4qty; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTqSiZrx; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="otlW4qty";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTqSiZrx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4124E1D0010E;
	Fri, 19 Sep 2025 14:15:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 19 Sep 2025 14:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758305716; x=1758392116; bh=57/MK/wKvH
	1Z9PcO7f1cF86E1dF2N8lSmcRCaO0+MwI=; b=otlW4qtyog7l2M5QZ8WHtCsih4
	ysaShhSMxF7KeKC1iNgxSz+MhcTDxE6sCMNtSZU72A4poV2lN6NXNbKvj7P7BAIA
	Fmq+xUPEYuHC2cb48XyhO3kf+yAI/mvEiLDHHDsP7FiEiLIMIhd8bRQHnW7eCMzk
	3nP0LadH6x+xDXRmN0hxs+Xq2IomhGKDYn9UzL0XrQNeKLA1bIrm9oMQqe9FB1Km
	L0R3OQWT2v1NgIVCcG91TzaxKKWrWPc/a7skIkxhu5mMmeelwFVIUJHPxsmLtWrR
	AxVlFHL7hanIKCaherINwNO+cZnRrrLutDivfEwNZxHPlgTaIyzMAuYFEG7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758305716; x=1758392116; bh=57/MK/wKvH1Z9PcO7f1cF86E1dF2N8lSmcR
	CaO0+MwI=; b=RTqSiZrxZjlHU/8v13DiuNmAkBQGwiMf+FQiT1qa3e6/9i9juKO
	LuA9Vox/15aquCHyGBL9S94/n+Dzk+ln1jwxlmRCZiAsVoCTr6weM6xjp+cGD2I+
	T/Zxj0cIFlYStCRzIGha9Wq2zLSyq2pA4H9E43llE4V58D3KHcSO5/gJtzu8F4a7
	psJ0fSRZZQIy03cUfbzrVlSfpi68Epb47I4+JBl2lpwWNZUYkoRVEEcUTwaQ08MR
	awJVeKf1LAbeLD+mMbVIeuQzwQiK2WvbiXGElMzPvdL9nguDbKer4nGqbUeGqU7B
	/z1f8uk7dYCpU9EhaPxbu86BahHdL5I9l2A==
X-ME-Sender: <xms:s53NaJxb05i-_hteep2o5GN_mxsslsugAPrFf7qKbNBVaLz1iP0VRQ>
    <xme:s53NaBuE3_r2885poKgBIqJFUk08zmwru2-qF4bu4mrNkltYtJ3TPUfPMFuagWXTO
    _CBHy_17HihsnZl1w>
X-ME-Received: <xmr:s53NaDzxrLg3O85MOaktopucJ0Wu7wpfjYvCAqxU5D_HydwQ7SeBe2WsIyxdSXKi6q1zat-0DrdHfBLvzaeRyQhOD0nWmMDEJI1tBSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtoheprghpvgesrghpvgeftddttddrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:s53NaMBtJNRRD5i6VPFnZTssj653dUFyFZz4XDejLrJXh41-38MKrg>
    <xmx:s53NaJdZTUraxTTteEMwSrNysCjDjF36d5QFiytYJcgXhK01F8B7hw>
    <xmx:s53NaOlFqbg_QngGdv1RB0S28tXVed25zkilSoNMSa3IU7P2ABa8Rw>
    <xmx:s53NaIEefDQQRQ-8cyoaGZ8SPkmhy5bLaHk8y7wTVvIAqycg9nFILA>
    <xmx:tJ3NaE4-4w_3NDGnZwdfiSt8p4LlpKLGnqHTTwtGGKH9z2SWM-UKO1GD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 14:15:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Lauri Niskanen
 <ape@ape3000.com>,  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [BUG] git stash show -p with invalid option aborts with
 double-free in show_stash() (strvec_clear)
In-Reply-To: <20250919172007.GA59895@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 19 Sep 2025 13:20:07 -0400")
References: <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
	<1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
	<xmqq4isy77qr.fsf@gitster.g> <xmqqldma5qha.fsf@gitster.g>
	<20250919172007.GA59895@coredump.intra.peff.net>
Date: Fri, 19 Sep 2025 11:15:13 -0700
Message-ID: <xmqqbjn65mxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But really, I do not know that we need to NULL the whole thing. We have
> given the caller the reduced argc. The only argv invariant we are
> violating is that argv[argc] should be NULL (or in this case,
> argv[left]). Anything after argv+left should be considered
> uninitialized. So just:
>
>   argv[left] = NULL;
>
> would be enough, I'd think.

Even when strvec was passed and more than one element was eaten
after parsing?  strvec_clear() goes by .nr not stopping at the first
NULL IIRC.

