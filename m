Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67986204C18
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974029; cv=none; b=XQH0n5KbLVAIfg+CZ2o9Tw7bvgfYs90MsrSK7TZn5RKnPIAT8Uul5Pq07TK0F3H4BmWM6CZgPDSoRIV3F1TSime0ZTYAGdQzXZrkwlKzJa1nbenlrrvdVQCcExxkg/dGz60wXYXngbkKekEFbOo9oHKY5RYxc0sjCQ3/qhD8ln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974029; c=relaxed/simple;
	bh=pFNBqBnyaWc/nrURPfE3l9qY688Omr43y1y1ztmUycA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QU9+8iZ8VsbyZcu206Enkc+z6yqqjT9zROel5WO7vQM6P/6qZRydwzBPVM9uCY0vM2CgAr0gXof1Hze4OYgNpaujIDcjfMzjCBGOt75hSKRRZBGFGRkhAy7C7I4yqVFc5bC4I656BoODZkDurVuCftfgdoS327j/0nZclsT6/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O/9obzGC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQ3raw/F; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O/9obzGC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQ3raw/F"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 6EBA71382DEA;
	Fri, 14 Mar 2025 13:40:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 14 Mar 2025 13:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741974026; x=1742060426; bh=ljhmqOrs3k
	Ykv2PcFCwC/QiwDCb/x7htvfkGlmBeIik=; b=O/9obzGCv3d7na0pm/S+a7P3Du
	Q2qpYnrQNHVKSZ88kTRXQngg92S40y0FFgLRrZadD61vm6JcyC1qHQ5pwvaCbJ2X
	Jxq/439VhNDoUavwD2OKiTg9c2uJut50k8qu3bVKmhoGsq54yqR4/mzOKTEImW0M
	AFOG26dklyRucWSz1SGHf/8D1V2qxrRhNrpoJHrhHo9csii3f6KgAsTasnk3ELh4
	S+Rv/K03oHoykzPwmq4PHBW86vi6nWQ6LRNb1swP5N6eoz7nGcqPFEBsnf+wioRK
	0Fk+5v3hhhKewkAxWz74Z4AUPfVWQ10JQ87cUdHngZiGaK0Yb84zQPqBpsQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741974026; x=1742060426; bh=ljhmqOrs3kYkv2PcFCwC/QiwDCb/x7htvfk
	GlmBeIik=; b=uQ3raw/FtKQglIpTHXPHcKdW3ryowy9AlqIEoOx+h1QCtxoQFcG
	Gc168kpAxL3tSfc+bEuSXPHA/RTnUlD5P1s9zOFLFJf/paf0pXSWkKMY8dNsyvDO
	OazYshl4gJUDZxnPUrRJV3JBGvqwozm86ubxRei6R2xulw3qHH9N8BqHypT5Oj/G
	EKOYWVr3v8jh1IofEWSqaZHqZQUm7AqCrJ+JcM5bG/3PS5E/C/YdnOFf4Atmkfup
	rlFdHPONtOYe5Ge+r76m+gyTVblXmIxm7LDMve76y23S7BiDh+Kr9fk+cUmr6s7V
	jd4lVm6Omh4ecWKQKBCbgTv+Afuo1JbYljA==
X-ME-Sender: <xms:CmrUZ_SbGmvWSeR5g2BLOszFBVxvVt9mB4WNG_vA1Wf-TCH84KbtBg>
    <xme:CmrUZwy7Vyf9nJbCN42w1gzAqsXMyomVI0PHrICa6y_kniaeGDrNKr0sR60SbDiEG
    ju3o7G-xwjivjpUWg>
X-ME-Received: <xmr:CmrUZ03E12BTyy_QrMD9AqzlHwj7cTHRfxO717UdfL9TfBnjo7tqeE1fMuwEScN7FPehE-ZuOXrIIEuxaz4bj68Znztm0vzf70mcKpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfefgvdefudetudekteetveehiefgvddt
    jefftdekfeejffeghffggfeggeeffeetnecuffhomhgrihhnpehmrghkrdguvghvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:CmrUZ_AuGxhreigb0kORM5-aqj-uu7Yb4CyrTMGkGRQHRph4dqObKw>
    <xmx:CmrUZ4hgQlGO5a2eKMLDijlhddYDbR8dgJrfsZIO3Ux1en_CuDZVLA>
    <xmx:CmrUZzrmQ6oFXcWTC2KnkMjW0MxYQtlYllThsCxtfW4fU-ACUJmTpw>
    <xmx:CmrUZzi01nui8fJ2UuyvBLnk_7_1OGu_IFuQ-Xq0oFmPNu2K7sXz6w>
    <xmx:CmrUZ0ggluD-8E40j6Ev4HbxuwKy9kIlEzl4ARkRgjQhLhJrYO6VB3ZE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:40:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
In-Reply-To: <xmqqv7sbh698.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	14 Mar 2025 10:27:47 -0700")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
	<20250307195057.GA3675279@coredump.intra.peff.net>
	<xmqq34foefh8.fsf@gitster.g>
	<20250307225444.GA42758@coredump.intra.peff.net>
	<20250308032309.GA584028@coredump.intra.peff.net>
	<xmqqfrjkao75.fsf@gitster.g>
	<20250310160440.GA26189@coredump.intra.peff.net>
	<xmqqsenk7mab.fsf@gitster.g>
	<20250314161010.GA8522@coredump.intra.peff.net>
	<20250314161347.GA9440@coredump.intra.peff.net>
	<xmqqv7sbh698.fsf@gitster.g>
Date: Fri, 14 Mar 2025 10:40:24 -0700
Message-ID: <xmqqr02zfr3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> -- >8 --
>> Subject: [PATCH] run-command: use errno to check for sigfillset() error
>>
>> Since enabling -Wunreachable-code, builds with clang on macOS now fail,
>> complaining that the die_errno() call in:
>>
>>   if (sigfillset(&all))
>> 	die_errno("sigfillset");
>>
>> is unreachable. On that platform the manpage documents that sigfillset()
>> always returns success, and presumably the implementation is a macro or
>> inline function that does so in a way that is transparent to the
>> compiler.
>
> Would it work to instead do this here
> ...

I forgot to say a more important thing.  Between the "let's excempt
developers on macOS" and the "let's see how far we can go with the
warning turned on everywhere and wack-a-mole this particular one
with errno check" patches, I prefer the latter at least for a short
term.

Thanks.
