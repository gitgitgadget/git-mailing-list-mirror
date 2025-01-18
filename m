Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D402913
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737162546; cv=none; b=MNBcbORdsaD4yQMYauN8GOwnAmiYadfEHBUsSZj7tlW2f7EJ7pozm6XZ7FAG4D9xJeGy+vcdL4go8TqRFEnmliq8z6WMlqffGDH0NRXmkW84t/n9FZwRwQALpVMhSJbzDqscA7M0Yt7tMspCfL74+xBwfAumXFeP73L92GHHocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737162546; c=relaxed/simple;
	bh=dXHqfc8ImHCKJwN63scK6PHpxa+Web1dMJfzOaMO0ak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkYzCaZ5ca1I/1U17soNqG05LyYCTS/TbeTfS7UJ7OpOKgfrY4os3ZNq2GBcuYBi8H467vIoadDa1F6b7sV9Qz9vMcr022VFMobVn/Evt6OT+OzzNikd+Bozekh5nt5qDcSbq/Kae6/AFWyJSI0ihXexdcyFcK8JNBQlCosb898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ciUkDf/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fP5p03Z+; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ciUkDf/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fP5p03Z+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BD97F114017C;
	Fri, 17 Jan 2025 20:09:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 17 Jan 2025 20:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737162543; x=1737248943; bh=+XTCiN5ig6
	07gvP/lCPg7gk3C0BrpN9deZmATOJTFOc=; b=ciUkDf/sDoqbv2IhlQN9ag1mhI
	tp6Xy0LuyXKn+1vN3Vru+eN1LBw0KpMKGYFfqrTzyIPYtDawvY+ylZn99DF8NTa8
	3DemRf0vCobTfNhjP6RIj+qtzzN3yiM3JGeQrJiV0wsj1OB+ARTgzZeF8oWUE00W
	KSWDlOKvADNLD63NGm4bhD7yQYL0mJCXhrXaHfQW9l/94wHUf3Pbt3mJlX0fXmwq
	7Ciz5pcbrXtPGg5SQZhVcefChgnt0KJiBj08Fgd0eCeNg6xLTGQXZaGX2qxQvMDw
	Fa5hLiuBILskpLtz9SS5mmp1+MPLFdR+QXFki0DgLSQGbST6PBLEytcjqsqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737162543; x=1737248943; bh=+XTCiN5ig607gvP/lCPg7gk3C0BrpN9deZm
	ATOJTFOc=; b=fP5p03Z+173T14/DaLNrRLy3wDKXmF4ejh0BJweWdQuCVaFteSY
	2pBEr9Oo+aS4CUKjKYzkZtwxzsU4hkGCqqnbpdb5Gs/PjemR+GgNV33RoCYY02RK
	qkSZ7M9J+C7AALGU1/oX2EYzN4hI4pRiw7csz9vHyD3aelw+bcYxC5flK7cNeEVl
	bEsk0ShFNh+T8fQUaE2h3LiOG9Cq45dylYbLPaBIg9rW13O2SRUeo+sTRu34h5nW
	lVi+MmhGD4x8lf/qFtVhQvgkO1bQEv5SnW92c319WpvIR8HUXPoP8Ptft/mesia1
	R6QjNmdf25bHOR+PUyMWGt1PPIDlWaGN3Ww==
X-ME-Sender: <xms:L_-KZ2iGSYG5j1I3xGdw_0WjYqR8S3JK2AspPhZYQ-LcfDuUB7A71w>
    <xme:L_-KZ3DG5XohE8RPTF3qJ6nRmx71TaGrm3zg6KcfahQpri1bkfqgBYUFknHBWVFGf
    zhlUXyeTJTjUOXP-w>
X-ME-Received: <xmr:L_-KZ-F1vsr-Ayw8fqKFpyHQzBNQ_NDeixN43WYkepMxm76rbWK2EvJFteNVrrvAHIxQQI4gunPASmeqlmFK1zFo581o2NWL-zcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhprghluhhssehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L_-KZ_TCT3_gVWw85YtDi1F7ZV9-1KbhmgS7QT8hIrllw7PvBQ6ORw>
    <xmx:L_-KZzz-UGujSE1cXrQzs_49l0HTmuVfXidi1JrKwu9s8HdW7edDOQ>
    <xmx:L_-KZ97DHF7YnK6oPL2fCq5csmMy0DJfW8uVTegrH0ee4ikpNqPSCQ>
    <xmx:L_-KZwxrfnHiR-hRhKrwUPENEJZr1Lx1kz8LrsZYQ5qk28ECIcda5g>
    <xmx:L_-KZ1vPdWcUmwr2qOuVjLjwp9SeQ-lEBXPFm4_RKRq5LC1vlVXX6JKV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 20:09:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jan Palus <jpalus@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] t8002-blame: simplify padding generation in blank
 boundary tests
In-Reply-To: <xmqqr056bv8v.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	13 Jan 2025 07:15:28 -0800")
References: <20250111231107.2190448-1-jpalus@fastmail.com>
	<Z4UIWId7ExLB2gWJ@pks.im> <xmqqr056bv8v.fsf@gitster.g>
Date: Fri, 17 Jan 2025 17:09:01 -0800
Message-ID: <xmqqikqd3p3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> So, my suggestion would be:
>>
>>     t8002: fix unportable printf formatting directives
>>
>>     In e7fb2ca945 (builtin/blame: fix out-of-bounds write with blank
>>     boundary commits, 2025-01-10), we have introduced two new tests that
>>     expect a certain amount of padding. This padding is generated via
>>     printf using the "%0.s" formatting directive. That directive is
>>     non-portable and not understood by for example mksh, breaking these
>>     tests on platforms using that shell.
>>
>>     Fix this issue by using "%${N}s" instead, which is already being
>>     used in t5300 and thus portable enough for us.
>
> Is "%.0s" really not portable, or is it just mksh
> being a bit lacking?
>
> "That directive non-portable ..." -> "Some implementations (e.g.
> one that is built into mksh) does not support the precision to be 0
> (i.e. "%.0" before the "s" conversion)"
>
> Other than that, your version is easy to read and understand.
>
>>> -	$(printf "%0.s " $(test_seq 11)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
>>> +	$(printf "%11s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
>>>  	EOF
>>>  	git blame -b --abbrev=10 ^HEAD -- abbrev.t >actual &&
>>>  	test_cmp expect actual
>>
>> Okay, makes sense. And as mentioned, we already have such a use of
>> printf in t5300, so it should be portable enough for our use case.
>
> Thanks for reviewing, and thanks, Jan, for noticing and fixing.

Sorry, as Jan is not a list regular, perhaps I should have
communicated more carefully when I said "Thanks".

The above message from me with "Thanks" does not mean that the patch
is now settled.  There are suggested improvements pending that needs
to be incorporated before the patch becomes acceptable to our tree.

Anybody can help that "further polishing as suggested" step, and
when the patch is left in limbo for too long, I might step in to do
it myself (when I have no other better things to do), but it is
customary around here that the original patch submitter does so.

Thanks.
