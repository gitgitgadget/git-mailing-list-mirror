Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946D248880
	for <git@vger.kernel.org>; Tue, 27 May 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361176; cv=none; b=lwUJAnyaKyXCw3xxI/lqF4Z/pgCHGl8Mwt85xi7d+Aw7XjMrWur2fzEOzZhz98Veuh5ncUG4GJUWYbiuDx/J3sUekm5l2DQB06pRUHaeKmOKsgjsk1mMyVL4j9wK+sRPtPvVZNg7aaI1sjhn0TzCOTN1QaaGzTqHAj2gOD5eB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361176; c=relaxed/simple;
	bh=E0AzNm3UJtBLRYZQFmZGp9Z3yXmZ+h4PfYMJCp8R36w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZYdSJTFNbqUrq9i04Hv1vy3r3vWsIUDB3ITnNTVlEffBA433CVip4P1oA3UvF5vu4rwMWelCAeTqr9BV1xODwURokz5fNhc3Cyyy7K7Cv5y6CY04ChOjL1sjNiU6abaKtZ6o2ZyEzbdLeA6mh3mISloSErdo5r6OBfrtsD+Yuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KoJxnG8F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P49DHBwV; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KoJxnG8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P49DHBwV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 848D011400F2;
	Tue, 27 May 2025 11:52:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 27 May 2025 11:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748361173; x=1748447573; bh=E0AzNm3UJt
	BLRYZQFmZGp9Z3yXmZ+h4PfYMJCp8R36w=; b=KoJxnG8FRM5CdE+Ved3oH/IEaJ
	ndBe4TXOV3mTcxgZhFHRUKxmnQa/JrySlmeA2i/3yNJzcVEPmg8K3rb95i08oIpZ
	ttXI3wbhQb+8KZhRR3BBOqZ+jUhJvIu3Wfcko3qraaja1eAQ8TsTOixcIqxYaEE3
	IVjXzthNkDaO3IhPXSXRl1k0j3nge48U5jtodd80ySzIBN1pbXlqlE9wJbUczAJM
	XqCCEOUbdqdG/NBLotWr7vddMLEuT3kzJ6EpzLI6934EouayIG5F/OAWSFvt/m3y
	WTV1FboEHTG2IQLpEOkw/q5nNWhRvLvgRVqdRWE6diKqm7LrFplCxmomsyhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748361173; x=1748447573; bh=E0AzNm3UJtBLRYZQFmZGp9Z3yXmZ+h4PfYM
	JCp8R36w=; b=P49DHBwVP9iHIcKgMCUinQVeufP/zhvyMOMzIJgnibo6Mkxowhg
	uNRmZJU5RUcxH2Xg4mxPdtB0irT8+D+f11dp2rB9J/hNG1kgeHD2yOBGzNhO5UQk
	+I+7kvWHzvANV6h4xHNOpcmuyfsV+kiRpaau8amxh2nddbB4GesxIRikXrtCDF/E
	IEFopfqpCNFfRwssRFaFNO/jCjjHlsfHFzBE69+xV1ooUAFvkFWvBvkQ19m8hTj4
	cLj0HaoTDeeoH63CDjyKoFnTvOWkF+zuhE/vTbhoW+UZzm+k1gkp0Fz+7veGXo5t
	VaeHtKPLHdlOTZB7WDMS4yi4spHTCeOrRLw==
X-ME-Sender: <xms:1d81aMUh5nf701wyInVbfu6-5X9PoiDL1VL_--jUD8gfy6Ob0TFk0g>
    <xme:1d81aAl75Q56UKYMVx5QmRprDLsjE1XXukes8m9h09Azuk96LAkTmseynR_NKIaB-
    JwrNU1f3zZwgnUH4w>
X-ME-Received: <xmr:1d81aAbR67UOGTuUxH_lB1FYuYFt4_8jf-2zlU6bprNq-uK3AOI1a_sbva5jyVou5ANl7fNlHMcg4myoJfSEqW9LZUQR55_JgBTlnJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdejleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhmohhg
    ihhlvhhiodhgihhtseiiohhhohdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:1d81aLXPnn3OefWaTQR3rs3rH39p6DlKZIR9oRXwWgEIBZbH5HVUhA>
    <xmx:1d81aGnSWtiRCLjRZL9CUIeMQI05SeORsWF7bVLdOIr9rvgCbcnpjA>
    <xmx:1d81aAeJaD-fw_hDUzHmKauyWoz5vVvENeh32ysMgIifV1ouCKqlsA>
    <xmx:1d81aIEzsMFz-AKZp0S0jZhiyK5RawZuzxEgMzb9Qi-daJv-wkKL9g>
    <xmx:1d81aDDAXVEOru2eF-1YKlycrZMRJp2WfaU4WoegRr56cWDG8YuAr3TX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 11:52:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ondrej Pohorelsky <opohorel@redhat.com>
Cc: Matthew Ogilvie <mmogilvi+git@zoho.com>,  Todd Zullinger
 <tmz@pobox.com>,  Jeff King <peff@peff.net>,  =?utf-8?B?T25kxZllaiBQb2hv?=
 =?utf-8?B?xZllbHNrw70=?= via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
In-Reply-To: <CA+B51BFJ9abjP5pDYwV1-mHpwg_n-jjz4_YX+nm9wOYF4nKuGQ@mail.gmail.com>
	(Ondrej Pohorelsky's message of "Mon, 26 May 2025 15:56:13 +0200")
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
	<pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
	<xmqqh61ear4s.fsf@gitster.g> <xmqq1pshc2vs.fsf@gitster.g>
	<CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
	<xmqq7c287i7n.fsf@gitster.g>
	<20250522170536.GB1613@coredump.intra.peff.net>
	<aC9lM12GyntAp2tR@teonanacatl.net> <xmqqtt5c5viq.fsf@gitster.g>
	<aC_90R3ohRRBVIV7@comcast.net> <xmqqwma7z5th.fsf@gitster.g>
	<CA+B51BFJ9abjP5pDYwV1-mHpwg_n-jjz4_YX+nm9wOYF4nKuGQ@mail.gmail.com>
Date: Tue, 27 May 2025 08:52:50 -0700
Message-ID: <xmqq7c22qcdp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ondrej Pohorelsky <opohorel@redhat.com> writes:

> I've just submitted v4, which removes the 'escapeRefName' function, so
> we avoid the warnings and test failures when we build with new Perl
> releases.

Great, thanks.

> I think the next step would be to remove whole git-cvsserver as was
> said earlier. I'll take a look what it is going to take and submit a
> patch with the removal later, if that's ok

It probably needs to follow the pattern established for all the
other recent topics that touched Documentation/BreakingChanges file.

