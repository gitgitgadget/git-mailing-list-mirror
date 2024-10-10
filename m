Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE971C7B68
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575827; cv=none; b=iDr+zmGTSA3o1hfLR6srfAijeqp1BkjgdaWCoowiRKEzQk9VWQf+NGesk91mZKw6rXdco55vcqLhM/EWCp8IgPsaEoQL3LY1bA5IFulmepL+Uq9MmrKc1owQb6UnuTT9VPkGTutpm3PKv9+IntAU2dEE2H0KdyxtCdtwKEIU2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575827; c=relaxed/simple;
	bh=WqMQl98/36B0/ncX2+i5kCx+Zs79eHsgSm4s0K6b4Qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gDyl6A6b/kdgiuFeFEdB12XMXInTUIKOtvWV1lj46ynZI+sqwYhzk0yzSNSIm3nwDuAxBypeOruBD4QqZKZrYQN85zNh03wtA+z+17IZjIBPZFSePLw7m6LnjBptAl5LN/skpdN1KU0//ZIfgQnokfHAED9Aqq99wVR0QlPv1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S3HVbkUl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mrawstxE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S3HVbkUl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mrawstxE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E701A1380449;
	Thu, 10 Oct 2024 11:57:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 10 Oct 2024 11:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728575824; x=1728662224; bh=i3CFai7TOW
	eVzdQzlKT2X3cR4kPfVXnddhMxHPh+yuQ=; b=S3HVbkUlCaB8xsEPdfOGAHMqvc
	T+AMXsNkT7C5zP6uWtFFfqrxyBdozRVSxNmVO+Halx1Xen0lrbRkOVOvL4aAUghD
	KMVY95WMeUtpszk/c5qL1pICws70IKK2A3h+p9oCAACW0+HirHWgVBJ9y2u0C3dC
	akzfW+6luZNqU00YgTA5mcrHPvjay6lhQB7hbV4e5Lmho3VsLtquZ7QzCoKu/Nuz
	5bZeBiFzvtI75RtRs4mpEJ7ngSgQSXY/Jj51bpmw1TT5D7nYjq1/OTINFn3sjiJ+
	jzkz7e2pI0J5D9s7AIAxdvuSy2zBbK358+M2xPG63Io9StfRapvP+TP1e/rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728575824; x=1728662224; bh=i3CFai7TOWeVzdQzlKT2X3cR4kPf
	VXnddhMxHPh+yuQ=; b=mrawstxE6VfGzoabxOw9wVpC9JQbECl1H4YBa70W6tzG
	EAovvrmwLxZ3YUe3X7qQAJoyxn1x6Yl0GUjatfBmyWsDxtUwH1DQzWxq5dn6JVjL
	ivTujDyfuYd2QV1KZRgX78bnvRsgdJgIZgNBeaa6YmRyFiHB73mOYzEjOAsb35kE
	MF6bZpEK3Hnp+jqfNSZqOYvJokPjJqhad6G6ENyQKf+kNadcES4J/5JbdvPFMUiT
	dO3lSCLzWBe7FZ0T371aCCyFZ8Q4ANjtHFyIqYgrKpouAB+rJBaC5BBl+bDfIKBH
	3wh/lEdnSHaEEPdZ2k9vnTHWMkTW08wRRGobwjH9Zw==
X-ME-Sender: <xms:UPkHZ3oZiY7jIb-NHcVf-njIIGd9uoZFWCmjEcazTOmpltdZLv1uEA>
    <xme:UPkHZxqRsW3GoR3HvbH6pdJiETzBBhPOleDhxOrA0NMjSM3uyWL-obyoeVll_VztQ
    fOzrTMKISilW2jmkA>
X-ME-Received: <xmr:UPkHZ0N8UIRUmBv--w0UmhjLehAWnNVvdXc2FsQVLov5GPtTvv-yI5PxQ6FxWjyoJtvF6b7BmMl0n8fGqakwFDUqj_oKI36FVEgieNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UPkHZ66GkJJ55a2uflUlMlKAsTw_Q7yr7CRam_j4aTYH4hWNMsb-Aw>
    <xmx:UPkHZ25wNYnhfLJSOIMiW7KFCUIZqtMOxtUhOVuj6tZSPNdP8h9yag>
    <xmx:UPkHZyhPEvknFhRv3HiWV3LFuCFFuSR1Eq6Dv4WqG-twpXb622VcMQ>
    <xmx:UPkHZ441Z5uxiFpif7O-zeLKwl28hmoDsPQ_I1wUAsu72C499ks8wA>
    <xmx:UPkHZ9aVaa9bnjfCQLafgoOUlvTNPOp6Ba78Z0kUcuBb_JFJ-r5o9P_C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 11:57:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  Taylor Blau
 <me@ttaylorr.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 3/6] set-head: better output for --auto
In-Reply-To: <xmqqjzehq9qk.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	09 Oct 2024 13:53:07 -0700")
References: <xmqq1q0xhu13.fsf@gitster.g>
	<20241009135747.3563204-1-bence@ferdinandy.com>
	<20241009135747.3563204-3-bence@ferdinandy.com>
	<xmqqjzehq9qk.fsf@gitster.g>
Date: Thu, 10 Oct 2024 08:57:02 -0700
Message-ID: <xmqqv7y0lzn5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> +static void report_auto(const char *remote, const char *head_name,
>> +			struct strbuf *buf_prev) {
>> +	struct strbuf buf_prefix = STRBUF_INIT;
>> +	const char *prev_head;
>
> I think we need to initialize prev_head to NULL.
>
>> +	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
>> +	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
>
> If the symref was not pointing into the "refs/remotes/<remote>/"
> hierarchy previously, skip_prefix() comes back without touching
> prev_head (i.e. not starting with the prefix does not clear it).

The two uninitialized prev_head were also noticed by compilers in
multiple jobs at GitHub CI.

https://github.com/git/git/actions/runs/11265515664


