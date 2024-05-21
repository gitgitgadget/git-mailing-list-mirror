Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DD2BAF0
	for <git@vger.kernel.org>; Tue, 21 May 2024 05:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716269605; cv=none; b=ews7AbDneNfqtgImBWy0B/y6Ydc5Ao9hhsGO7wEhmQIYM1jKci18rb/2apnTCw/d10xhHQfDEy0EZTXnOjOxUxTfAldTxo90k1DRmQNGAXhk08/0hqe/iQrPA1McsqHPICauc7mGHw/W1gO4t4l49tkuNAmZlFTbe/w0X9s3LR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716269605; c=relaxed/simple;
	bh=lQDuj/XD+kFYEIO/caMB4eeYle0kCdtNPfpYKeSfYRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLdv/Kbrm9P95UyhORJyK8VYsvLYNoE5BerWtlG1BWwNK/6xzouQ1IRq/MOT6uyTy3B4DGOkt12e/NOtYf9lTba74MpilcQGSX1DMjYz3NE4tSjA0rDvjmfdU5QfFxmcjtx2TXciPUalNFeRB4vpVlBNjo9RTABtntYHSUrNBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=coBRj7JH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="coBRj7JH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D3872C23A;
	Tue, 21 May 2024 01:33:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lQDuj/XD+kFYEIO/caMB4eeYle0kCdtNPfpYKe
	SfYRk=; b=coBRj7JHCxaZQN2ptxkAO0XXryVhJkWHtHThEYMikVYTyypXtnkYE7
	owy5WTllF0ZGgchSFn1pPrabQeFiVBvKMDrRU2noykyeT2u3L3Qn8kKlRdlpeCEV
	S6Ow1M1EdwbG8wjlPkBJudmw0qvHj2C+IZsOP3Anp4vKCqIpLmSV0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 850A42C239;
	Tue, 21 May 2024 01:33:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E6B92C238;
	Tue, 21 May 2024 01:33:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] Various fixes for v2.45.1 and friends
In-Reply-To: <xmqqseycca0z.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	20 May 2024 16:56:44 -0700")
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
	<xmqqseycca0z.fsf@gitster.g>
Date: Mon, 20 May 2024 22:33:19 -0700
Message-ID: <xmqqikz7d90g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A2545F96-1733-11EF-805D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> In any case, I just compared the result of applying these patches to
> v2.39.4 with the result of reverting the following out of v2.39.4:
>
>     584de0b4 (Add a helper function to compare file contents, 2024-03-30)
>     8db1e874 (clone: prevent hooks from running during a clone, 2024-03-28)
>     20f3588e (core.hooksPath: add some protection while cloning, 2024-03-30)
>
> and the differences was exactly as I expected.  A Makefile fix and a
> new test added to t1350 are the extra in the series, but otherwise
> the patches are essentially reversion of these three steps.  Very
> nicely done.
>
> Thanks for a quick turnaround.  Will take further look.

I completed merge-up exercise and compared the result with your
"tentative" cascade from maint-2.39 to maint-2.45 tracks.  

The differences came from pointed cherry-picks (like 'ci: avoid bare
"gcc" for osx-gcc job') looked minimal and sensible.  I wonder what
the best way to do a public review of this kind of history, though.

$ git log --oneline --graph maint-2.45..dscho/tentative/maint-2.45
* aeddcb0275 Git 2.45.2
* 65f0d62523 Sync with 2.44.2
* 9953011fcd Git 2.44.2
* f78818b645 Sync with 2.43.5
* 0aeca2f80b Git 2.43.5
* 0cc3782b1a Sync with 2.42.3
* 33efa2ad1a Git 2.42.3
* 30195eb2b6 Sync with 2.41.2
* 5215e4e368 Git 2.41.2
* 9d6788fd73 Sync with 2.40.3
* 4bf5d57da6 Git 2.40.3
* 9f7a956be5 Sync with 2.39.5
* b9a96c4e5d Git 2.39.5

All of the above (and the one below) are merging up, resolving
conflicts, and updating release notes and GIT-VERSION-GEN.

*   b674c6f66c Merge branch 'js/fix-v2.39.4-regressions' into maint-2.39
|\  
| * 5c576e889d Revert "Add a helper function to compare file contents"
| * 0044a35567 clone: drop the protections where hooks aren't run
| * cd14042b06 tests: verify that `clone -c core.hooksPath=/dev/null` works again
| * 57db89a149 Revert "core.hooksPath: add some protection while cloning"
| * 961dfc35f4 init: use the correct path of the templates directory again
| * d4a003bf2c hook: plug a new memory leak

The above 6 patches all appeared on the list in this "v3" thread.

* 883ca51e0a Merge branch 'jk/ci-macos-gcc13-fix' into 'maint-2.39'

This is a merge of the following three patches to maint-2.39

* d4543be3f2 ci: stop installing "gcc-13" for osx-gcc
* 2aef8020d2 ci: avoid bare "gcc" for osx-gcc job
* f3e5bdfebc ci: drop mention of BREW_INSTALL_PACKAGES variable

These three patches were taken from jk/ci-macos-gcc13-fix that was
forked from v2.45.0 and rebased them on top of v2.39.4.  The bottom
one seems to have been adjusted for the older contexts, which during
subsequent merging-up has been adjusted back again for the more
recent contexts (e.g., we used to use $HOME/bin but use $P4_PATH for
Perforce these days, and such differences in the base version appear
in the context for "BREW_INSTALL_PACKAGES" change).

So, in short, I didn't see anything unexpected to see in these
branches.  The "ci" fixes were already reviewed elsewhere (even
though there are slight deviations), so if people are OK with the 6
patches in this thread, I would say we are good to go.

Thanks.





