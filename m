Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F57280027
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420456; cv=none; b=GxmOoH4OnzzvkWFTA9L9SvV1CKmxk00DkP6FMYb8h7l+FCQCBXMnqY+jbgOgQxHo/FN5ezn5KouI4L4OUSRMIA0RFR5aemw5wet5+SIo8uDKHaNnX2yvAGWQuQKhOrUKe1DHKZvo/7NXPM0zkKYb4K+YCQsezfANv2RTJc9KZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420456; c=relaxed/simple;
	bh=yVLFZ1XGT8JS3R4jLi9QBlMiFqVtcIamzkYUlzJ0ZYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XikRhWt6Nf3Jvsi4x+v5HkBCP7NXbYIXymvfhIX9hjiNUrx55GnMYijD5ThnR+BEVdKH8T4ZniInEWKn4jhWJwHKKuC3Wzj/uBNixAEQRk19Di+HAvjMPikp1EWQvA2iXDkk5m8jLMIvFEDritWPyh2HwtH1r4WH1os8R/uSvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NgW2fUvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cErQgdh2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NgW2fUvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cErQgdh2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC7C1254010D;
	Fri, 16 May 2025 14:34:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 16 May 2025 14:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747420452; x=1747506852; bh=ejBr/iU8VL
	jKex2iKkFWL48sXyfZShT91sh6uLLMTNo=; b=NgW2fUvFXqo0GH+bEXuZqozxnh
	Nn2RbZEZ7Vg59gLyV9jCAXDys9MmiGc/8bI5Qyp+OhT/OFfY10B5o+hrG1ZAaI8C
	LLUbUM7/NFhkvbTpiR0RxsZxrTY2f8qCVarHpGWqR8WCmvQhZyX9pQ5y2p0JAvmi
	vABA3/p5uDNuDHHPYzCnQbg4D07E2P20Kow87C9AV4PYTeaETbcYfVZ9lGvOl2Ft
	4I6s1jJB/sfq0TPrJOXwNHYfdW9ZSfWpUsjNSSqw3B7iHncuUqH3R/Q/odAo6gkO
	YgUK/2MZeq0+Vuc5KV/gF3mpab1fqk1tLk4I3frhghVeROwqm7Qz4kW/txyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747420452; x=1747506852; bh=ejBr/iU8VLjKex2iKkFWL48sXyfZShT91sh
	6uLLMTNo=; b=cErQgdh2S+TDkf0sRvouz9P1p6qZ9j7tTWse43ylwPJoyHsL2XB
	ZqQYq2LSP12iPekXJ2QBpinnlQP9UKiA5lR98mkdw5wQKeibuHqsBfsInwM05+w0
	EAm498GwPlZZw9Th+1GV0sIaT/19Pm5Di35nPLv/8t0Qq7Y43DGLMZjCQnNDZUU8
	yrHbj88cGb4gTUNSjlHY+bVOs0jF6Ss/8IgZobTlSNWFoYpaHId9YftiKH9Nc75i
	R98A9J8GXVjk1HkVG2JV4I6k5qn1KKawDTcV3sOuUDqN1hSv0wTnm0UL3S6jFVG5
	/Bt/GI+qHNC2bietJ9V2HXvbk5qQuR5JEkg==
X-ME-Sender: <xms:JIUnaEPhRi6EHynWleDGg0PMlZz-xqAKAqxt2WsEipK9yLNSc37c-w>
    <xme:JIUnaK83Sm4W1UpPEq0Ns2ttHy18EE9ihwzwIlUNr3qlTxKg5LCAU2whXL4e_4pS4
    yntx1d8bmWLkUqHvQ>
X-ME-Received: <xmr:JIUnaLRHVbJfY8z7qPFsRkymP5dmmGFsE4LgWTNMWMhEWYwPbtDZuXSsHJmLV5iBR1JDoxLqVuw_IuVqJFgY63GtobwOsnODfCiSxSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:JIUnaMurjgPjyWIDlnh2NCAZR5NdsJuUGy1wz9kuFko8cX_DocmKSg>
    <xmx:JIUnaMdLf1e-kCzAnh7Q7LWKiPEKwxj1JPnWLbW74dnjeiy14wuQ1w>
    <xmx:JIUnaA2qoo3m2-2AzoapvEQRyBi-AAP6KDz9taoY_zfaRZX2oz6wmg>
    <xmx:JIUnaA-no-_7857td6dFGWugPM_tsdoc7FeVe9hQtp-e3F_6X_G_vA>
    <xmx:JIUnaAWfUlJijKBP6D4DN25UHtRXGB8wXTjin5jhda7QpP8svBQ_FpcL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 14:34:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] packfile: avoid access(3p) calls for missing packs
In-Reply-To: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
	(Patrick Steinhardt's message of "Fri, 16 May 2025 10:55:10 +0200")
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
Date: Fri, 16 May 2025 11:34:10 -0700
Message-ID: <xmqq7c2gv1zx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The function `add_packed_git()` adds a packfile to the known list of
> packs in case it exists. In case the packfile doesn't look like a pack
> though, or in case it doesn't exist, the function will simply return a
> `NULL` pointer.
>
> The ordering in which those checks are done is somewhat curious though:
> we first perform a couple of access(3p) syscalls for auxiliary files
> like ".keep" before we determine whether the ".pack" file itself exists.
> And if we see that the ".pack" file does not exist, we bail out and thus
> effectively discard all the information. This means that the access(3p)
> calls were a complete waste of time.
>
> The reason why we do this is likely because we reuse `p->pack_name` to
> derive the other files' names, as well, so that we only have to allocate
> this buffer once. As such, we have to compute the packfile name last so
> that it doesn't get overwritten by the other names.

I vaguely recall that the order of checks between .idx and .pack
were deliberately chosen, as we do not want to add and attempt to
use .pack file before its associated .idx file is ready since
without the latter the former is unusable at runtime.  

    Side note: It may have been more important back when the name of
    the packfile was a hash of names of the objects in the pack,
    which meant that when you repack a quiescent and fully repacked
    repository twice with different parameters, you could have ended
    up with a packfile whose name is the same but the contents as a
    bytestream (hence the object offset) are different, making a
    stale .idx not pointing into the correct position in the new
    .pack file.  These days the name of the packfile is based on the
    contents of the pack as a bytestream, so we no longer suffer
    in such a scenario.

But I wouldn't be surprised if checks for other auxiliary files were
added later to come next to .idx not .pack, exactly because .pack is
the primary thing.

> All of this likely doesn't matter in the general case: Git shouldn't end
> up looking too many nonexistent packfiles anyway.

In any case, we shouldn't attempt to use .pack when its associated
files are missing.  It is not about nonexistent but about incomplete
(including "in the process of being written").

> But there are edge
> cases where it _does_ matter. One such edge case that we have hit in our
> production systems was a stale "multi-pack-index" file that contained
> references to nonexistent packfiles. As there is no negative lookup
> cache this causes us to repeatedly look up the same packfiles via the
> multi-pack index, only to realize that they don't exist. This translated
> into hundreds of thousands of syscalls to access(3p) and stat(3p).

Ouch.  Multi-pack index is a more recent invention, and I am not
surprised if such bugs still lurk.  And as you hinted, a solution
may be a negative "known-not-to-exist" list, but given one such
stale midx, would we try to open the same missing packfiles over and
over within the same process?

> while the issue was entirely self-made because the multi-pack index
> should have been regenerated, we can still reduce the number of syscalls
> by 75% in the case of nonexistent packfiles by reordering these calls.

That sounds more like a band-aid, if we still do the remaining 25%
that we somehow know would be unnecessary.

Note that I do not know if the ordering that I think was originally
introduced for correctness still matters for correctness.  The first
paragraph of this message was written without consulting "git log",
lore archive, or even the current state of the source, but from
vague memory.

