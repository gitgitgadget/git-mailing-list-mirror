Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CA2E3719
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754424410; cv=none; b=JCHa/oxdC8EtA+NyphXV75Xok7oP0DkZD4q5vGY7q2sGSbTiMu4mugReRvU3xfhfxJeMHA1tkZbvM8QIkv6VuAyNXexXqa0tu7YymGtbj1LQT6J6wJ6tbaFkkAEis9ZqMx3JGABnpXuJhNe61wMGReGfUhczKXPsBUDRQr+6/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754424410; c=relaxed/simple;
	bh=Iu/+k9AIJzWWNS7KPihrRWiiAUUh1GD4gU5eOGbNBwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FsxQL2eTgmWsDRUMtE57uKXGNfDcLpPJ4sFu+XiaQ729PLELTrT5g8asMO8RK/yD4nyzXuFk7/hcLiAps3uq184HaZY0XiqjLiBKXHtj7E/80/l6hptTpTRk7TmemJXab78Vv/00CgZhU2/slc9hmjziD7/Mtz5kAO/bUlKJMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ck+gGu6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CjwWIHq5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ck+gGu6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CjwWIHq5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56D051400167;
	Tue,  5 Aug 2025 16:06:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 16:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754424407; x=1754510807; bh=NpSbEhC2ph
	bzLHDtjKQeqoFCAVZx1snIoW8xnOPXzC8=; b=Ck+gGu6VoTM3y8cisUbDbIHDBv
	s6b57/UPin1Jz6H+YQa+FxuKVjBRfgcn0LPcXd/AOEX89bfxJ/tMOdyZ9pqxaJsQ
	WuvarWoqbCt8PoR6uvgZqWOGxxAmvGp4lmhCCaH3ef8z8ObeTt+mlhuz9BY24Mqj
	6fcV+PjFMEaD0ReiWATMRMk2MN8hUUlMHKpUtZSPLjo1Uh0c/huIz44m8n56/WwP
	9Oc+kpU10eypZLikez0YyAHrXKyrdYkgoFtSmAWfbGJnbu8vJAYABbUy2swTmi7b
	Q3zY9x2v6QtUvxHEc1eyU0PbN7LSDxk0c9v6rUY6wpHRD77w2OGGrcE4i7oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754424407; x=1754510807; bh=NpSbEhC2phbzLHDtjKQeqoFCAVZx1snIoW8
	xnOPXzC8=; b=CjwWIHq5Th/P8tiM8SV15GcNFsSPkqflWj8cKlamFZVIgeNEtRY
	xznC3f7U7bqMy7RX5zKy2TXGlhZ4pCSfG1wuliFpo/jYxjO2sAER2S2mFGFL2HU/
	PPgaEcKqlYUm8bg/qjLdFwjJpebxbCo7VJ2EP1d07HiANSfu4z0t2+80gFQLod33
	6SlBLjECIE1l6R/cBNY7xIPWANPeuUzrpRIK1kXQVz0i9UrFFSpKL4oHghN+Wwh9
	8q6F29Ia0jdk50bvQ+mfg8CQsS4TKQvOsVehvIltM3oa9NfXeWRlFSHmxPKicQyw
	1ILFPB3g/p4F4V7OPHp3XKshjYuGUSENFlA==
X-ME-Sender: <xms:V2SSaP4aCcr5pgTWtZDi8BpxqYhf9OdgcfStaOk5oEvCMSzHxtK5AA>
    <xme:V2SSaPe_Msi2hfqCeNxD02heXtt59V9i2AgTBSJNi05fKR8W96tX4eDCZNZMfzYZe
    TfaJhVAIwFyM6GNXw>
X-ME-Received: <xmr:V2SSaDC059hajQ58otWMlNcN6lN2dEcSON7qztM_ACVnPkuf9jpR-eaYC03Rs96fbiwFzenqDCd0LCNZ12F-jlUkKFHvPT7DESuE5iU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:V2SSaC8ODPBAd3q7W3JcONRA1XMHrF8JSI7033TNVbWtNrrZ3Yqy0A>
    <xmx:V2SSaOKRyi0QHB7nirC_5UactU7_Kb2vaxonCn1QJurkcsqeLxQppA>
    <xmx:V2SSaLg8lH6u30His9pFceCpZ61isOd4XfLlvZrO4fyQMyj45WC7nA>
    <xmx:V2SSaO4QeLhtyOxntEEZMnQPrv8C8DnBZWPsNIdfShUBPA3ayNAihA>
    <xmx:V2SSaOof79eZ99KFDe8B8Zo9QUwj-i3Ag919xHI8hMFcRBQ-OniEE46q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 16:06:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
In-Reply-To: <20250805185703.GC1345110@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 5 Aug 2025 14:57:03 -0400")
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
	<xmqqv7nezdw2.fsf@gitster.g>
	<CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
	<20250802094657.GG3711639@coredump.intra.peff.net>
	<CALnO6CALb-_RjNZw9u-0R33O+KfccfZK0+mF-W7G659wc4PW7Q@mail.gmail.com>
	<20250802185238.GE1773585@coredump.intra.peff.net>
	<xmqqbjoxgd83.fsf@gitster.g>
	<20250805185703.GC1345110@coredump.intra.peff.net>
Date: Tue, 05 Aug 2025 13:06:45 -0700
Message-ID: <xmqqa54dzg6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Sat, Aug 02, 2025 at 10:56:28PM -0700, Junio C Hamano wrote:
>
>> > So I wonder if we have painted ourselves into a compatibility corner a
>> > bit, if we have two conflicting expectations. We might be better off
>> > just teaching check_filename() to parse multiple of [^/!] and the
>> > trailing colon. It's horrible and not great for maintainability, but
>> > this syntax is not something that changes often.
>> 
>> Ah, OK.
>> 
>> So the idea is that when given _as_ a pathspec element (e.g., after
>> an explicit "--" separator), we do want to interpret ":file.txt" as
>> the same as "file.txt", but when dwimming to sift revs and pathspec
>> elements apart, prefer to take it as a blob object name in the
>> index?
>
> Yeah, I think that is a good way of framing / justifying it; DWIM can be
> looser because it's inherently about heuristics.
>
> I don't plan to do anything with this topic anytime soon, but maybe Ben
> wants to produce a patch in that direction.
>
> -Peff
>
> PS I'll be offline for a week or so starting tomorrow, so apologies for
>    any discussions I leave hanging.

Thanks for a heads-up, and enjoy your time off away from the list
;-)

