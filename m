Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35E4071E3
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929397; cv=none; b=WlVy4uNjL98Z1YjKRHV7qmmRHEyukY/rgz3ZO7noqqcoLI1YBi5qzdRj8e6B8Aeg5pYoLG1HHRnQbwHsbT8QqTYMtgZSX1rgxTh0bbk4kMj1D4IZK7mTIvvqDQlDx4M8RBaHrdD4TmlUX818ekEMWULTvJXlDNuCYaGN7TMfAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929397; c=relaxed/simple;
	bh=m0m3My088W0BTtjipbr1bqLodJ/GHP3Iy+ouiL05mUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gma0mMzki+RuPHcf8c9FELF/JOayTvOmaQTjC2tEcUPzEBMvgb81nKJJ9yJRNWWQXZLF/eCw+iyEO64n9sSAF+FhGiu4esX+RyLP5ZcQa8/g3seAN9nuIfb4upzjaJfmGN3jKoRS7JIX8MOVOZ5zWart/SpNU/04vOxUTobzod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qw3UrpJ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQP3XDYx; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qw3UrpJ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQP3XDYx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A729EC009F;
	Mon,  8 Jun 2026 10:36:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 10:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780929395; x=1781015795; bh=l4P3Zkb8MH
	8EnebiMjr6EP6CJRw/XKg11SDxQd53Ljs=; b=Qw3UrpJ4j4UKTKa/3mp3a94CE5
	ZAEA+GUvEVzPs8oojiAH5UhceEqJGQ02XjaZDry0haNOparC0j5O67gbdvRI37O2
	kDplv1MPIzZfIRNjNgTzgmGhZv6mFxF2BSaKbN1P4s5jHsgVi6dPUcKOxhb9pkTz
	M7tsvL7PSiRqeeywo2OwzuEs0RHnz1VteTwj6fAHWiNJB3QLRcWJozzZk7aFJNRM
	5ODD6xAuwD6So1AxW9p+8DpQil2vgNtc3VLTAXQ0schq4RWWhAAohW85Lj08NI/X
	3/ODDmkdP2AB9xgkX1yAWrAxGY4tyZ8xblIiGeheO2ieYV8D5tzcnMgUXwWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780929395; x=1781015795; bh=l4P3Zkb8MH8EnebiMjr6EP6CJRw/XKg11SD
	xQd53Ljs=; b=dQP3XDYxxbWhb+EMmEzwFMStV/EsV7hQqq4sFtsqahxI/MzXpIK
	wb4eXCu9PyPAvPHHVr1bMWKgji6I5+bzeh4jkj/lGwX77GskKll9slUN4UL6IEjr
	mHhO9prBDUVoHmUDafqZhGt15zKrDHaBedh1oNRabQgKaFIx9eqAyzzDxKPxv9n6
	/kev16cyE9XPStxUwPONrAQF9WKPmi5xTkC8qdb90wrsCIJikszdMmlS8LxMQiIo
	ZPsTtOs4QBkcUl6YyFtMv50y9Vm7Udj7YiIeiyap8m2cbXOv8dXyc5eAKIsaPBOX
	BcFwx/R2jv0tZ9Mo6hD/hf9ngJuXGOtoppg==
X-ME-Sender: <xms:c9MmatAyYb9emoj24JYg1Z5_nuZakJG6B-64hDFjT4TSfcU3tX2l0A>
    <xme:c9MmaihD-GrhAaA-Tppjh06aWLIH9moEsr86QiXf_YXkWbh4GO3ipl_aT4iniFmFb
    tpxVBKPZvZJwP9pfLqlExiKkExkVrG48DMLfzl3q0pD_6r1IRqxGw>
X-ME-Received: <xmr:c9MmatmV1J5BZ9wKROHtaV_ovui-CQOaK_eywS6mY_yozxEPsZs3-51O6UivxgobDSt1FdNewwgDBT5DH0_8jkyw2KMG0BQ7x4zj>
X-ME-Proxy-Cause: dmFkZTGiS9/NYcbf4GczKU8iR84wutR4z8BVBaRz22de9vbWZN7kA7ezQ+5cefwwQrdL2h
    myxWKFTxyNiDQyw5DpJODrf4tQxtlzQvx0286m1MnE8j6oldtYSBeCVLKrfVgtfcIsooDy
    jRu52p4KlA39iGBTiVCm2WPSNPpt9su/caJipCw2mmBgtMTIbnUNU2cVabdrSAMsBuuEDy
    ZkS8bgXd84P9vH1Ps3RYv2oC+K0w0S57rfbAnSy7unYxR3x56P4dR+1d8GMKWInguDFEPm
    rF/vq6SkLUg+ARaMeRuDFiF9XuRO1pM7krn/pPwuEMP8AJl7OwpsJvYhJqUpxnQ/EWagPk
    /43tKS6Ngm0peYvBCTHw41bs0WmxY0kKYmfU/jWJmAQ30oKWeS84iyWKVuY7lGmUCOPDF1
    71M1DO862V7h6LdVmEcgN5xhbvTjv5zBhQR+N0mjMVN3YfUuNyClmHdsgIySAu5o/uHic/
    s82Zmj7JUBpFKpmCm9SMdNynV2Unw3lTRVf68MHEvNJ042RLDqIN4VQXbiWgrw85Y/EGt7
    fYcXVE1niO0FtF3pZH58k3C7PwMwyDk6TzkLNxfn9XOnyr3esCGsoOye3vQOszdBnij3Rm
    iUD6tshIFCjxa+oSLfeEXLXeSsKhNTisTuo+aaXbNzjNzBkJw9ZvxHS88Ayw
X-ME-Proxy: <xmx:c9MmamrRUMrzgcychXB45vqg5Cpuz8KILdcU1rk5KweWDVWydHdxfg>
    <xmx:c9MmauGbh2fXn75BC6trYpXPT7GEHU5ath-FYCop8McQK9HS4GrN8g>
    <xmx:c9MmaqzSywoLsA1MHNMeDh_-khRUnAscn7_S8g0cD0S-rolGskRzGA>
    <xmx:c9MmarpOip7Za4iK7sx98Q6rQvobdnW1wzYV2E7rcU8yxuQbM9sKSw>
    <xmx:c9MmalElY8lKP7PS0-7MflVW9ZjQ5ULzq2kLX6H_OyEzoVGZ8icjiExU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 10:36:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jason Newton <nevion@gmail.com>
Subject: Re: [PATCH 0/2] worktree: copy-on-write creation and shared-branch
 worktrees
In-Reply-To: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com> (Jason
	Newton via GitGitGadget's message of "Fri, 05 Jun 2026 18:49:26
	+0000")
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 07:36:33 -0700
Message-ID: <xmqq8q8pxfny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jason Newton via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When many worktrees share one repository -- e .g. a fleet of agents each
> needing an isolated checkout -- "git worktree add" is costly at scale.
> Objects are shared via the common dir, but the working tree is not: each add
> rewrites every tracked file, so N worktrees cost N full checkouts of disk
> and I/O.

Are the "CoW" semantics offered by these underlying mechanisms,
which may differ per operating system and possibly filesystem type,
all meant as mere storage-space optimization, or do some of them
trade potential space saving with some limitation of the features,
i.e., what you can do in the CoW copy and original, or increased
runtime cost, either at the clone time or the time of first
modification?

What I am trying to get at is why should this be even an opt-in
feature.  If "cp treeA treeB" at the shell level would make all the
files in treeA under identical names and contents in treeB, and let
you edit/update/delete copies in either tree without affecting the
other tree, then in practice you would not even be able to _tell_ if
CoW is in use, no?

It may tilt the scale if there is a downside associated with the use
of CoW, like at the first modification of one copy, the system may
need to do real copies of other copies, but even such a cost should
not be outrageously worse than the cost of copying everything once
at the worktree creation time.

So I would understand "whenever we say git_copy_file(A, B), we
always use CoW facility under the hood if available, regardless of
the purpose of the operation to copy one file to another location---
it may include, but does not have to be limited to, populating
working file trees in a new worktree", and I think it is a welcome
change.

But I do not quite get "... only if the user gives --reflink
option".  Why is it even necessary to offer a choice?  Especially
since you seem to have auto-probe, we should be able to implement a
low-level operation to materialize contents identified by a_hash at
a_path in the working tree in two different ways, switching on the
availablity of CoW, e.g.,

	if (CoW available && we can find existing path with a_hash) {
	        copy-cow the found path to a_path;
	} else {
		write object identified by a_hash to a_path;
	}

>  And a branch can only be checked out in one worktree.

This is a safety feature that has nothing to do with shared files
across worktrees, no?  Your two worktrees may think they have a
checkout of the same branch (thus the same commit), one worktree
makes changes and commits, the other worktree suddenly starts seeing
a totally different output from its "git diff HEAD" that mixes what
it did relative to where it started (which is what we want) plus the
reversion of what was done in the other worktree (which is definitely
not what we want).
