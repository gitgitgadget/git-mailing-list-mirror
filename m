Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BD311592
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832273; cv=none; b=cL9VTzmtHx4CS7uaLJbEkwasXjhnHMP5xlfIagrSKL8+c7vwxWRNotmL358MA0Eb2r2reMqKFmSnOOsel/3Mjn0RpgDTC8ACIoScVKu41jpyqI+9BXcINaiftFv6gngBjjXV6T3XmVBGZdCmxFP1B1LlboET7MrsKXagMC4Zjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832273; c=relaxed/simple;
	bh=yaRtTafFc4k2/n7E+nzO2eCmJcrk2saxbOtYzC28jyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RitXvQAQGKFubzyy/D7KIDkqbFvX1REGdihcr0VjhWerTyWyOarNtOfw1y+HuRh2+FsslPfd4SsAnWf0GzJHl/tCJM6UI30196PpcfFbdtv1IzJstkHARqHctatiae62FK9lmYzjc0EN+bUCjNw5qGoPPtgBFb6EFkRML8edyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i9+BD+mQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKJup8jP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i9+BD+mQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKJup8jP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E821AEC0425;
	Tue,  2 Sep 2025 12:57:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 12:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756832270; x=1756918670; bh=jOKDAc3QPJ
	/ddI1+q/I9lr7VMG8cD3P7R7Qm1eesXKs=; b=i9+BD+mQYIfFy2Y2B+4rhoB+LC
	nxWR0I7tA9HjxGa1Z/+tyg5hb8S3k379dUJN+QRrlDU+N+/keEa92zXOtd0ruZaz
	UknC4AmEQlZnacsUNgGaQ9eZ9M0BXl1e/yWBRrLT7UIowm+gsvdOpyh2AzJUNgZc
	NkVsgtBZR8H1SKskxPbtBfRyN8t+F1pdh/lEo9aj53I42fSQN7BAcMalCKpOeXC9
	NcNi+JxqsmDA/8qRZcLAIeKE2YwImaWL687ovQ1aSuADgBUpmHL5LgOimQHT8GWV
	cwFH9M53ocTWQUXetqiUItZnPuZmz3IJlG8TNcvy1hbfTqXjayie1eS/tYlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756832270; x=1756918670; bh=jOKDAc3QPJ/ddI1+q/I9lr7VMG8cD3P7R7Q
	m1eesXKs=; b=dKJup8jPTMZL6SKQuN7CDNqc17JubNRH1NpzGoIzwyJXhGF2+vZ
	O+5Sf7tcTENmA6YkrRhlNwDTbfReIy7M1P6dzMT7xDlJ2Lhdtfab3sEQ7j8PDruS
	sdSTQgcfxqau+DpK95NJvHgidlvjy3bpUaMtUBsvZ8/NVh7bZKGe+K9AxFLt+/+A
	RDp4xS2ps4lPIKPE+z8H4d1Vpf/O9igJLUKrRWh1n+d+zi6Uiieps7W1stv+BRc8
	M81NyJmUqyIxoxoJW1SnODhzedCZWQ3PfW6Vdf2G49qGROjJk/OITb2NgHQVfi1Y
	fyjLZwuE+dxQ6i4yrzH6zgPe3K2BSWeH4oA==
X-ME-Sender: <xms:DiK3aMMK1VV0NVL2uP9h0hPomLUJMKZZicm3d5GjNNmiUOowsVq1hw>
    <xme:DiK3aOdZN5wBS3SidB-NBzUec_cxU8sp34ET0LRpD55KZUMZIC749xh81_h9KejZD
    Zq99_1vuA2uiCh_9g>
X-ME-Received: <xmr:DiK3aJv76_btH04_Z8voBN9yOWXP9QfHrLPURXaVR-SbtMFQpbH8-N_V31GTcmz7osxXbvHu6jHsUfka_joLoQfMfyaK-so_Eku-AV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DiK3aPkfgbjc241hxq5l19nN21YRtRo7_Cyk9OjoZgCMbmdHq8PAwA>
    <xmx:DiK3aLysPP0TVUi2L-32qrLVggnZz9-5SAgUaN5oX3PomV7nfQ0lKQ>
    <xmx:DiK3aBO8j_F94aT1RkDA8UPf3Z0MdmpQX-1kilpjD2M-bkdR-Lsd5g>
    <xmx:DiK3aHpnIdDYTz48V1YyMuQEziMhfhzQ9r0Agmwx3HeOnZ8zUby47w>
    <xmx:DiK3aK-y4HqEDzRXbwEKSzmeznj_TTXn3vQ3Mzfyp0WSOyAyldioOkXL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 12:57:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH v3 0/4] Add refs exists subcommand
In-Reply-To: <20250826064110.10540-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Tue, 26 Aug 2025 12:11:06 +0530")
References: <20250823060012.540433-1-meetsoni3017@gmail.com>
	<20250826064110.10540-1-meetsoni3017@gmail.com>
Date: Tue, 02 Sep 2025 09:57:49 -0700
Message-ID: <xmqqtt1kkd0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> This series introduces `git refs exists` as a modern replacement for
> `git show-ref --exists`, continuing the effort to consolidate commands
> under the `git refs` namespace.
>
> changes in v3:
>  - Reverted commit message.
>  - nit: added empty line.
>
> Meet Soni (4):
>   builtin/refs: add 'exists' subcommand
>   t1403: split 'show-ref --exists' tests into a separate file
>   t1422: refactor tests to be shareable
>   t: add test for git refs exists subcommand
>
>  Documentation/git-refs.adoc |  7 ++++
>  builtin/refs.c              | 48 +++++++++++++++++++++++
>  t/meson.build               |  4 +-
>  t/show-ref-exists-tests.sh  | 77 +++++++++++++++++++++++++++++++++++++
>  t/t1403-show-ref.sh         | 65 -------------------------------
>  t/t1422-show-ref-exists.sh  |  9 +++++
>  t/t1462-refs-exists.sh      | 10 +++++
>  7 files changed, 154 insertions(+), 66 deletions(-)
>  create mode 100644 t/show-ref-exists-tests.sh
>  create mode 100755 t/t1422-show-ref-exists.sh
>  create mode 100755 t/t1462-refs-exists.sh
>
> Range-diff against v2:
>  1:  19623eb97e <  -:  ---------- doc: factor out common option
>  2:  69c207dc45 <  -:  ---------- builtin/for-each-ref: align usage string with the man page
>  3:  6eeb1c070a <  -:  ---------- builtin/for-each-ref: factor out core logic into a helper
>  4:  eecccfe98b <  -:  ---------- builtin/refs: add list subcommand
>  5:  aa91c5c570 <  -:  ---------- t6300: refactor tests to be shareable
>  6:  fed66d91c0 <  -:  ---------- t: add test for git refs list subcommand
>  7:  b55e6d36eb <  -:  ---------- diff: ensure consistent diff behavior with ignore options
>  8:  e1d3d61a45 <  -:  ---------- diff: --no-index should ignore the worktree
>  9:  621ce9c1c6 <  -:  ---------- git-jump: make `diff` work with filenames containing spaces
> 10:  9a49aef8dc <  -:  ---------- environment: remove the global variable 'merge_log_config'
> 11:  22d421fed9 <  -:  ---------- builtin/fmt-merge-msg: stop depending on 'the_repository'
> 12:  741f36c7d9 <  -:  ---------- docs: remove stray bracket from git-clone synopsis
> 13:  1fa68948c3 <  -:  ---------- The second batch

GitGitGadget and/or range-diff somehow went berserk?

But thanks to it, I now know that the series is built on top of the
second batch ;-)  I was wondering why the patches did not apply
cleanly to a more recent tip of 'master'.

Will queue.  Thanks.
