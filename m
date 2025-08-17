Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D8200110
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446923; cv=none; b=bHyebcWlwwgAT3Wfj6ggHKqwa7+euOz9adxPLwbRG1B3a8FNynlSPA2OENwp4dMterDCBZ+V48OqXJUeSAXiK5q3y3aG35mZs6aAlAtlsdu3KUp0lcHsvyToBHbItQ6j5+Kv4uUJdw8ofZSlw8ea2rzgPweJ3TWt2VDYNhH3Bwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446923; c=relaxed/simple;
	bh=sx2zazXajULStdt9dK7Cc3huEYsBA75DWC4kpNe/sjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKPU6brDdkR9ijUuLkel5/iOuzGIYFWOcP4phm/Ac3f8pxM6Qniwmu7OqfoA7M7RjDB/ggJ3ODoxPkbljlvPO0YbT+RYCJ/fA9tN88dJU+jI5qlDhNi5tq8x8oqVlnVID4gjIahiUJiwQoin/dtS0ZXIA0UmNj9liIlyLJE/gc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WLynYwUx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RX5uFLQ1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WLynYwUx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RX5uFLQ1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 67987EC00A1;
	Sun, 17 Aug 2025 12:08:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 17 Aug 2025 12:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755446920; x=1755533320; bh=Fhzg2vqgPw
	k3nBZUGIQ0TA/jgXrOeQJMW7SiUSZIOqM=; b=WLynYwUxi5r0En0TSskdJBACCq
	AFb4LG2C4k0KkTHEeJGStrLkBDNWdDkjicFSg6vdbu6DqifMwExSsBNQ/ZgaT0HE
	6kT6GGe8P998ONN1gEVuy55yhmhr6zYJURKjadFR+pY7BgGhT1zAchc/ovPfAQ78
	XEPlGvT5T4n+hS/1p8Whcg7yZTTi4k/NdGz4MPiye1v/3zjiOD8A+6Q46nyz5Upm
	Uy656KEBGxOJGuXP3MrqZfzemB3i69D8AbHk2SYMNvjSVeNyxKX/t5tyvC9/Bhbk
	vYFj5OFRAsCjVirgp5ZHxReIZfzdmDT/lOB5bC0WJ2nGk75PvNfp5D+MQi9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755446920; x=1755533320; bh=Fhzg2vqgPwk3nBZUGIQ0TA/jgXrOeQJMW7S
	iUSZIOqM=; b=RX5uFLQ16jvZD0jdJbkShKLFwcgI5ioNDq089YXGhaWbbWJl8vf
	kRyLNYYYLT5Duz5EW1u8cOkqesXxtO8mcOidCzJdNvfpUvPu5QBqyFKzSZsFhiXP
	wkgo8hLSaeZ3+1tAAjPPGXo73pYlSffnMUzYwJycBuWyompCJln9cJDbFUZu3PTY
	TtS9HBukyyQGcmE9DBnEAqwgZWjBNPg3+QYsn2ntrG4G9t0kn+K1UploO4QugPYt
	KgGUJ5ge8yjVZWfmFVHZTABbZAS0JobetkDoKqRoKkRa3ZCcATcr4+OeRpQBnE19
	7sjziXyZmzDKw28vgAau+i+SLZvI78pIPMw==
X-ME-Sender: <xms:iP6haJBrxbc21SWOoChOU8Ft5EBzbdGWV0NzV6qWHKlCaknZfv2MAA>
    <xme:iP6haDC_hEkLVPR_3t_OFQcIj3ad_ChMtof2g3c8OwC_v3Xwxhs9PtoH8Sv4tstBh
    xz8MhniES5PjhHxAw>
X-ME-Received: <xmr:iP6haLCxK_fAsZk3Hs19-ubGnU_E7w9eDmHP9blI8HDGzX4GUDOKH-jjXFQQ7MYHRrgv67v8XEltVnkajqjGArNCmzloTcSJUJBiKtU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtrdhvghgvrhdrkhgvrhhnvghlrdhorhhgseguvght
    thifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iP6haOqElCIAj_tUiQLUNYpOL7Rb57yVydCV6fU9VToM_NkCyCg2Mw>
    <xmx:iP6haFktW6Cmh-JxHi4QGaTJSOygMbsOWEHLrFLRF6-u-czvPN6OtQ>
    <xmx:iP6haOyM1YMvfR3OoVgT1w0SM35mLFF5kgSyzUMIy867TVZGYuVvng>
    <xmx:iP6haN9Jioc1GOT0o5o2KOxNXJpJWCP5F2qtQ6tcNkLNKDHe55kUug>
    <xmx:iP6haJk7tpoa6ZTku2qc5ZlQ6bgq_m-B0dMYzPd2NySPqVCFTESwzA7v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Aug 2025 12:08:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "J. Dettweiler" <git.vger.kernel.org@dettweb.de>,  git@vger.kernel.org,
  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
In-Reply-To: <60f38225-2bcb-4383-be40-36c7b02cf38c@gmail.com> (Phillip Wood's
	message of "Sat, 16 Aug 2025 17:12:47 +0100")
References: <12fe17735317215aa0de58a20055193a@dettweb.de>
	<60f38225-2bcb-4383-be40-36c7b02cf38c@gmail.com>
Date: Sun, 17 Aug 2025 09:08:38 -0700
Message-ID: <xmqqfrdqkk1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> To use it create your stash with "git stash push --keep-index" and then
> use the script to pop the unstaged changes rather than using "git stash
> pop". If the script proves to be useful then perhaps we could add an
> "--unstaged" option to "git stash pop"

Hmph, would the behaviour useful enough that it should be always
enabled, without any new option?  I strongly suspect that those who
worked on adding "--keep-index" option did not expect the user to be
mucking with the working tree files while "testing the staged stuff
by updating the working tree files to match it and nothing else",
and as long as the end-user stays within that originally designed
use case, nothing changes for them, no?

Thanks.

(the script left for reference without comments below).

> ---- 8< ----
> #!/bin/sh
>
> USAGE="${0##*/} [<stash>]"
> SUBDIRECTORY_OK=1
> . "$(git --exec-path)/git-sh-setup"
> cd_to_toplevel
> require_clean_work_tree stash-pop-unstaged
>
> LF='
> '
> stash="${1:-stash@{0}}"
> if ! stash_oid="$(git rev-parse --verify --quiet "$stash")" ||
>    ! oid1="$(git rev-parse --verify --quiet $stash_oid^1)" ||
>    ! oid2="$(git rev-parse $stash_oid^2^@ 2>/dev/null)" ||
>    test "$oid1" != "$oid2"
> then
>     die "error: '$stash' does not look like a stash commit"
> fi
> merge_output="$(git merge-tree --merge-base=$stash_oid^2: HEAD: $stash_oid:)"
> status=$?
> if test $status = 0
> then
>     tree=$merge_output
>     conflict_info=
>     messages=
> elif test $status = 1
> then
>     merge_output="$merge_output$LF"
>     tree="${merge_output%%$LF*}"
>     conflict_info="${merge_output%%$LF$LF*}"
>     conflict_info="${conflict_info#*$LF}"
>     messages="${merge_output#*$LF$LF}"
> else
>     exit 128
> fi
> git read-tree --index-output="$GIT_DIR/stash-pop-index" -m -u HEAD $tree &&
> rm "$GIT_DIR/stash-pop-index" &&
> if test -n "$conflict_info"
> then
>     printf '%s' "$messages" >&2
>     printf '%s\n' "$conflict_info" | git update-index --index-info
> else
>     git stash drop "$stash"
> fi
