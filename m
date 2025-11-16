Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BC22A4EB
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763312149; cv=none; b=RpNizQS9mU0cfwa21RbFymub7UbKCybvEKtbKOY2PZZhjuOSj/+Nspr96WzHD/g7xBNObq2/hsa1xiI9S5X1fGbBsRgMsnJ743fR3vsAbq99tpnCdkA+rOitn1asVjRJKDbwrI775kSj2OmaGlgUU4IqGah5NTVs+5S/gjBoaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763312149; c=relaxed/simple;
	bh=D20kA8mhTtFli+zr5TFSeRcoFUH951oERQKUMjSLRpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dXy+aRl6iLAro68YoTRuY2s2TlPdFcnvNe0dyZBvTygxA0ogsp4/50aHKBLVdgiBEbJz1Dv2x5AtYHwbQL1AEEiPr7drhyewBqCiCBaqdf3gMVZAd0fU1JBX46/9j2gGgiRVv0YZw4qMbJgkHJJiFvUSRvtVZzi0FQD78mwNrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lmxoqcmo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zJgrQ8fA; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lmxoqcmo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zJgrQ8fA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AB6FB1D0011A;
	Sun, 16 Nov 2025 11:55:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 16 Nov 2025 11:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763312146; x=1763398546; bh=FUDBC0V3Fk
	iihbNZIa5voe6sZ1vWGV1awMQtofgvd90=; b=lmxoqcmog5I+eSLvslRG74JbPb
	At/HJreSbHATWRZH8K8p56hOr7fwXECylMDdYUVppl3jifIzsZ1Fi6GZxrWp4XCc
	F/efDTyRACG5XegUeC0bjZtmR8qXGnVLhyVWj5GLN5GXJn1EGbxafREguyKhXNnm
	1Y8vlhlJCvcrihpdxcmZbyuTxJHxhuNI57kvj0S1xNiaAf+JUFW1Xms5aHcR6bRd
	uQc40sfRAZ7W8us843XH4j7L6K++3+8Vmo8xvPhvCs61blNJZnCl3bzyzdmiIsk9
	TmkTXr/drL4IIsdDwrOKjv+cX8DPlMHfN9lUFumfGG7nEe8PGBfSX7ap6Ruw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763312146; x=1763398546; bh=FUDBC0V3FkiihbNZIa5voe6sZ1vWGV1awMQ
	tofgvd90=; b=zJgrQ8fAwjoMEjew0bSIE4uTvvSSfvcTph/dOqE+xa1Fr+ICCkp
	5ZpfUujjZl6VNKrHQQxoebEhXEYMqQy1MSaEu5YFiSBRfkqzod7GZbGdu7Jn8foa
	JWHbkMQQdxbnSK/vIZcw8WrTUZkhJ0pxve2RIOOhgoz+BXZteAuZHSbxrluZcg3a
	DD9fcJrU51AW9y4YeYY1xeNvedBasRXXfjQeymjEcXM7fL1Gtgxejg73t2058r+w
	DbmYluvvcok2T44luj+8ENua0OE0XMdrnKzr5gth0JyEYP4t1vZC4xjn23mO/6+L
	uKizWLJ3rSYFyQpvR2TRiOwkgvPPMcEICGw==
X-ME-Sender: <xms:EgIaaXV6bGPdX81psKLhxmu5LAyB78MEnn17ROd61bd_C92jSQ6bzg>
    <xme:EgIaaWkCQIg9jAL0EsQvfgnYN9FzN0Wqg4xmSJvs6MwfF10WnqBIoO0g3Du0syZt8
    2EwGWQJzfBlCgEtnNgZdluw_f_wXZ5LWCOxGAmTfcm1nUn-gUOYSQ>
X-ME-Received: <xmr:EgIaaYZqITphdGIteugA3rK10t7GqnfzNFERbhAbu0YJMkceOdFhGV2hZh8LbdKIvL9wKAYDuH_Jr-UYnEpHHFiO3lluOmBbsmBG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepihhvrghnohhvkhhirhhilhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EgIaaRPNlgZm7-iPJej18hYbK_Odj0BvYM7E2WWOSGop7rzW_tpY_w>
    <xmx:EgIaadaYOX827qQCqFZeigTyfLEeecCEPHZwTQzI19_wcGd3FaLONA>
    <xmx:EgIaaf2ktLKyoJQtdaj92Biu18BfmI9JHHzLlqNDV9FaKBSF4PjceA>
    <xmx:EgIaaTehTGqIzygBL3O0NWpQFcM9fo7_kTE8iosLO-lVWONl2R1nkw>
    <xmx:EgIaaT60eroFnF3EDpGRZWUQWzdegq4LaqRdxyHtgByzIhwINeRr1Ooc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 11:55:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kiril Ivanov <ivanovkirilg@gmail.com>
Cc: git@vger.kernel.org,  Kiril Ivanov via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/3] git-prompt: add quiet upstream indicator option
In-Reply-To: <CANHi5upZdwi33upTFL01NymMqK7dCWEbj8XAOEydCDMf4bSFzw@mail.gmail.com>
	(Kiril Ivanov's message of "Sun, 16 Nov 2025 14:05:17 +0200")
References: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
	<xmqqjyzrdpqu.fsf@gitster.g>
	<CANHi5upZdwi33upTFL01NymMqK7dCWEbj8XAOEydCDMf4bSFzw@mail.gmail.com>
Date: Sun, 16 Nov 2025 08:55:44 -0800
Message-ID: <xmqqms4ldii7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kiril Ivanov <ivanovkirilg@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> ... (this is a reaction to seeing
>> some bash-isms in these patches.  No complaints here, as the test
>> script is all about the command line prompt feature to be used with
>> bash and nothing else).
>
> Actually, this got me reconsidering.  The prompt feature claims at least
> to support zsh in addition to bash, and it has had modifications to make
> it more compliant:
>
> <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
>
>> After this patchset, the following shells work: bash, zsh, dash (since at
>> least 0.5.8), free/net bsd sh, busybox-ash, mksh, openbsd sh, pdksh(!),
>> Schily extended Bourne sh (bosh), yash.
>
> And the test seems to run successfully under 'sh' in master with:
> -. ./lib-bash.sh
> +. ./test-lib.sh
> (Passes normally, and fails when the 'expected' strings are clobbered.)

Ah, good finding.  So the inclusion of lib-bash.sh there is wrong,
and we shouldn't expect that we'd always run under bash.

> ... Which is all to say that the bash-isms may be undesirable even here.

You're right.  Thanks for correcting me.

