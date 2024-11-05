Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CFEADC
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770040; cv=none; b=JQ+Uiyi7iRuKx/9waGxBoxxEextyZiYmcPi3ww2k0M+One6M62Wqx/p6KFDji8w8J0LuLKtiz4kOAkzAqEecAO5RTVQkN225u+hbvCqg2Kj3eec10J+g36Kar4hHuj0+vdy+8KgCXmZoq9uY8kcTfbSWENlnuYHcOa2H6IIFYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770040; c=relaxed/simple;
	bh=FTgoDmMSMbEkTwjpDgoZgGUEglBXGsrVk3xORKVkRuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=suhUsu1NTJeRNCtb/k2wKFtOAa6H3cclK8av1HblEnoa1hmOAZ1zR4BEZzuzAnZ64O3cPMdUUm83TWBaz4rPifspmsC9LZ8gM/+xZnH9y4mNJAGXJId8giHpknX8ns1oDiswp2hsyETuItuu3Mt15eFNaJEly1lUYpfdBLDfvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G7fQcgkm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YgoZigw/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G7fQcgkm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YgoZigw/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 191BC138012D;
	Mon,  4 Nov 2024 20:27:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 04 Nov 2024 20:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730770037; x=1730856437; bh=2eXA+3z/B1
	KP6sKV6irXB8L/HNHfrg/huK55NUd2Zks=; b=G7fQcgkmg7q3HtXVqv3KEqMFS6
	HUE94Rg+cYjDPlWxu8T0LK1CMu/3xJKVskw0sKbiwpQhIEvzUQ+3KJsp4+PZricT
	GhTjeFDZ0dXltLKxjEkcS8mpyiUFh3Z7ca2SiPr0kAkXcRpM5c0j+lG4irq9xkLM
	tRqcRwbvjMpcmWWyZVVWn1zFDJMKyhrz4phJQiPjb9tebDyXH3w8/+6R561fMd+S
	bdJ9LCA9XLEAbj+jHLXvBSRaQha2sduDy4lyzdnNlp9shWHEVUBnx34gUiZMafv7
	7HdLQ/msD8uFeD6KxCcRnC8Pyz1/jT0j/cH4D2XwCsQh42PIz2aXsIgEoRlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730770037; x=1730856437; bh=2eXA+3z/B1KP6sKV6irXB8L/HNHfrg/huK5
	5NUd2Zks=; b=YgoZigw/72yj9RpfOENqZaVa1axs/uWmlnn2Gh396nIBAm2oRge
	vQenTkWsXzqPY6mpaqKFMyIW2j+E89af2CZj8tRmyIsbTRWaEaCs6ILc8O6GSxV+
	9k2AzpZ/8TV8MEjJrBXtU8u0ezKWU2AOQ4fEJuVNcsAGu6WrIZeaEjLp/OwYV61k
	5A3uNf6XyK7nGMlRjCs6HtGCHnnXI1he7U3UHXQd0h3hHqiCFOF7DnT3Dn9j16FY
	BcKWw1QurL2b03jSoPiqSZuWlC4PnwVJ9oFgplTEa8zZYDbdfjHrkA36HK4+j2Uv
	MftAHkPgpWDJe/jnvYXMHQcQECTbe21nsQQ==
X-ME-Sender: <xms:dHQpZ3xhvA6u_pUU8NUu1HMdYKrSCZhFi323SzxGtK79zLiy7J2LFA>
    <xme:dHQpZ_QFETRHLP5HOG20cTy5Ggqd8D6k5PObeIHPo_ISBqeyc4p4LioD4aP4FxDgk
    O-Ui8chkg_-RQJwwg>
X-ME-Received: <xmr:dHQpZxUZ6YLxP_WWVRCZCI_xcCrJPz3pPJuRximYkPD1QNcU3FdfYmWBMtQXhLp1je7lZiEo7uQ2r1zkGa-uAsian5ORspiMhqJT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dHQpZxj4B8TeLMJz3iSeS1_naSf3__t3Kx83rADBvsGMTRHfp1SE2w>
    <xmx:dHQpZ5D2rWJ0RzKF9aw1CdDOyWQnQyAw0QEpp-NlkUsu2BXM2W1-1Q>
    <xmx:dHQpZ6L3Pf2FcEWh5TLDOT0WtN5qGeUijFjiouU2mYKfyl8og0n9xg>
    <xmx:dHQpZ4CN07fQw4UrJC8KT3bSHsvw74X_kNMCbopCmKLUwZc35E8fVA>
    <xmx:dXQpZ09MmV-M16DffmWf_0bkC14g_xdA86GPAxIrATGfp7nAWFhG7nom>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 20:27:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] A few --shallow-exclude fixes
In-Reply-To: <pull.1822.git.1730746964.gitgitgadget@gmail.com> (Elijah Newren
	via GitGitGadget's message of "Mon, 04 Nov 2024 19:02:42 +0000")
References: <pull.1822.git.1730746964.gitgitgadget@gmail.com>
Date: Mon, 04 Nov 2024 17:27:15 -0800
Message-ID: <xmqqzfmetqq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here's a couple patches to fix up an error message and the documentation
> around the --shallow-exclude option.
>
> Elijah Newren (2):
>   upload-pack: fix ambiguous error message
>   doc: correct misleading descriptions for --shallow-exclude

Both patches look sensible.

Will queue.  Thanks.
