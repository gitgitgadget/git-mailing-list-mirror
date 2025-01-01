Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145922942A
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735750257; cv=none; b=bw7rz8WNtNBbm/hyHLGNKF+Yn56CyBAf1CCxsVoQbayN5xG1D7//jxQm75/kitL4N2QOR3n+/9hvj5FM7qiB74dFhVexk/4I/7HHpMBEpsCCdJtnaus9s9O5N7DxLpXGxphIWXxnWxsv/fTL6/mUwulqjP0w0NaWQiZNkERLSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735750257; c=relaxed/simple;
	bh=blzBNh0zETJjO7ZtQi16cTUZpHZSzzHOZ+xeb14JxI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rh9eI/0TWkjg3O9YL+YqdlU/meHTcQSpfKbn3qHC+c5pfJCME6ikNFAwCrodMx+OSODqwBgBmtckg3tkWucc19VwKCEL3w7zUjqL3zVK4Mzndk4NZgZV9x96oRww3GGCVr1JwRtGAKDgtL0aiOY7es+fLICmgn3X8bi5C37U7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rg+vDlYo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/kZsMw7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rg+vDlYo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/kZsMw7"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 27D0E1380208;
	Wed,  1 Jan 2025 11:50:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 01 Jan 2025 11:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735750254; x=1735836654; bh=AmJPIHvGcT
	KSB6SWWr4QKTWUrnlfbtsA+JA7JaCjmaA=; b=Rg+vDlYov0nI+FWHomBwR1tzNx
	h1lUpeUQojLCUix2+D/8mEMxrZvKOQQinViuLEZm71LvpXSmreWaIv5zOi5qpQXs
	4bamYMxw3Tndmq8pyA83RgyhFP3nNVDd710GIHbII/U8UXCrvWLtGSROV9Fpfux9
	Usu1PQ03o7xPc5DxAdUNl5lJoePIQwkhxze+yfyW6sTJaAbiEqDrIVC0ucUAooVO
	n/cBVwSWpgaG/xRqkEyLPoLTQLGuzWVTE812sWrhNgqgRkORoGV8OvaV3TgN1gci
	ovLK4uhnBmw21tR16um7pocJR6Bkjx73v/HnOpGfaN3sNbSt0wItcpAjyr7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735750254; x=1735836654; bh=AmJPIHvGcTKSB6SWWr4QKTWUrnlfbtsA+JA
	7JaCjmaA=; b=Y/kZsMw7wlkNhEayV5KLvkqmYhOqQ7LucHn1k9bA9fFWxF5i7bq
	oKsTX6v5cqNKZyOz+Lgdepi7j/WR5FWBhiHIg3sIb3KLlXIDzBEKJUj1Q4wO6YyU
	J/5aLxEFy6cOCMX/4ITeHoAr1phOJaZVkDDEh/PJqDc0YQYqxI06+xqwKqDg/OHD
	jif7PMEswfCgIOjLXOaxZIst+SEkiWBgZ8it/URenQuOGvXenyyz666kJjA1EIK6
	lUbIJD/6ns953UuaxN2aPTO8VNpJHKAC2uqsZXtzEo3c/zHRhNL4x3w8iw88gwM8
	B9RocTTcWoddW1lXgHKbnSmM2+NTYPDi67g==
X-ME-Sender: <xms:bXJ1Z_Tx_S18dN53STa7GZAIN5ZybHDmm-CAAHd_P9E8HvGY---Fhg>
    <xme:bXJ1ZwxZZ6lSySxXPEZoyp3AB2Sm76xaLkMTP6WQO-tJPp1jd_tIqn-zCnnM49QO1
    byMsl2eF3IO52EyqA>
X-ME-Received: <xmr:bXJ1Z00KcnG_TiGaea0pIQXHM4YULTdQxGX7wwjw-fp0lUnjFFmbo4OpT4DaGXKUqhx5wxDAcYcd2Dm-TdE1S9sP0UT94RNYGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeftddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bXJ1Z_D8rkxeL171VB5tRcj0OoYIHBEkAdqS0fnKZVsK9rirsg2Lzw>
    <xmx:bXJ1Z4gWRWddjUSKxheTmUgIiDjN3DPL8Hw1lXwF7HpFbYGphuLSkQ>
    <xmx:bXJ1Zzpk70AfuYoIi3kzC91hshSzNU2gtMwHHaRaIDFwPO9TGG5XcQ>
    <xmx:bXJ1ZzhaD95ckiDs8Qe0ePfJ7ehiD7b9UmsCN9VzcJLgqYytlwqo4Q>
    <xmx:bnJ1ZybbGKmbcIJV7yfyhyfKIFJ5kdsnIYkG25WbAeTAe0yIQJP1JnMQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jan 2025 11:50:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH] object-file: fix race in object collision check
In-Reply-To: <20241231014220.GA225521@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 30 Dec 2024 20:42:20 -0500")
References: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
	<xmqqy0zxz11m.fsf@gitster.g> <Z3KzHJagr_3Fkz67@pks.im>
	<20241231014220.GA225521@coredump.intra.peff.net>
Date: Wed, 01 Jan 2025 08:50:51 -0800
Message-ID: <xmqq7c7exytw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> There is one gotcha here, though. We call this collision check only if
> we got EEXIST trying to move the tempfile into place. If the destination
> file then goes away, we can't do the collision check. But is it right to
> quietly return success?
>
> If the contents of the two were the same, that's fine. We don't need the
> extra copy.
>
> But if the contents were not the same, we'd prefer either to actually
> copy the contents into place, or to return an error.
>
> Of course we can't know, because the destination file has gone away. In
> the common case they will be the same, but the whole point of this check
> is to allow loosening the cryptographic collision of the packfile
> contents. So the safest thing would be to retain the tempfile, copying
> it into the destination file. That errs on the side of keeping data when
> we cannot make a determination.
>
> IOW, if we see ENOENT on filename_b, should we then loop back in the
> caller to try the link() again?

Yuck, I think you're absolutely right.

> I think check_collision() is used _after_ the attempt to rename() into
> place. So there's a race when the tempfile goes away, but I think the
> outcome is made a bit worse by your patch.
>
> Consider a sequence like this:
>
>   a. Process A writes tmp_pack_foo.
>
>   b. Process A tries to link tmp_pack_foo to pack-<hash> but finds it
>      already exists.
>
>   c. Process A opens both tmp_pack_foo and pack-<hash>.
>
>   d. Process A compares the two byte-for-byte, and then returns
>      success/failure based on whether they were actually identical.
>
> Now imagine there is a process B that deletes the file (maybe an
> over-zealous "gc --prune=now" deletes the in-use temporary file):
>
>  - if process B deletes it between steps (a) and (b), process A returns
>    an error (there is nothing to link). The caller knows that the data
>    was not stored.
>
>  - if process B deletes it between (b) and (c), then before your patch
>    we see an error (because we can't compare the files). After your
>    patch, we continue on and return success. The caller knows the data
>    was stored (via the original file, not our new copy).
>
>  - if process B deletes it between (c) and (d), then process A has no
>    idea. But at this point it does not matter. If the files were
>    identical, we return success (and in fact, process A deletes the file
>    itself). And if not identical, then we return error, and the callers
>    knows the data was not stored.
>
> So even though the exact behavior may depend on where we hit the race, I
> think ignoring an ENOENT open() error on the tempfile meaningfully
> changes what happens in the middle case.
>
> In practice I don't really expect this to happen, and "gc --prune=now"
> is inherently risky in a live repository. But I think we're probably
> better off to continue treating it as an error if we can't open our own
> tempfile.

So we'd ignore the racy and flaky tests, as hiding the flake by
ignoring the error would only hurt the real world users.

