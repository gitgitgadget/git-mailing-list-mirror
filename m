Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74B3659EF
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602746; cv=none; b=aeb7Pcwat38pwn8LWwAvpae6Yp8o2QFxRfNnYbcGNsKC0U+cDMYUizPdWvM0hXuCBoLxUKFcL8XJEx+sGJQWQau/7iTaFg1DLiLCAVsvEWakR6jaTeHOKJaj0CjfMOU1NIZDTS046bNi/uqSb8T4chVjysTpLSB8jwVD3nFy0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602746; c=relaxed/simple;
	bh=s5JOLcT6p70MYzvTty+USW8xNIsvcNCl1jUgF092DFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfuQtTIfgql3ChVn6Db/TFgN1Yfmo90DLpZ5Qa0tsmBDP13DdwcOalTpfgZOEEy0tNmXfBKt54SFs3Slb8bwAgqVzgyekQyOoRuMVVVgeaiXe2CjdcOnJYsLU4MHRKWOulGuqrtzlCEqsqicpsS6NnxD1LcoqsX9kD/uJwV5650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hBPDO+eL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QWDiafE2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hBPDO+eL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWDiafE2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EA04AEC0574;
	Wed,  4 Mar 2026 00:39:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 04 Mar 2026 00:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772602743; x=1772689143; bh=3wMiQUVuAv
	BI3Ixv9ctDeNoWFHfvFfKwdSRKdOy1GQc=; b=hBPDO+eLrHhruDcbqvXg+vxrNL
	x7rFN2JbY2fggA/dtWnlOg8rfaa9Eq56aZIRI3aeSkhiwROQlxZFWwJB8SDUan3D
	SkFKfl1urI5EJIU52MeKnXLGHR3YWtcCwDV87LlcPdOFPN0lfsVVROKJr2QEHgZz
	4nGAny/A/DPDNNL2nH9y7n2Rw4ZaNrVEK74X+rcXwslVg6g2wnqqmTQpxRdS908P
	isGjFq8ZjEMzB5smvr8x5/uz1HyDunY3nilzs+RIrOcGJN7ZsGFUIbycFqR17xnd
	Pg83WGiWlPuhqlvuPvg5Lknc1PS+171sXK5eepnG5xrJHG5/hLhZzLAmYIcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772602743; x=1772689143; bh=3wMiQUVuAvBI3Ixv9ctDeNoWFHfvFfKwdSR
	KdOy1GQc=; b=QWDiafE2Pl5jdzPQpk9tHqPYl/CWGpLbMCEYBDsxECRXlz73zRD
	uSJom5XRjR0nJ+eubWVx6AebhP3zmPsV7uHellm1j28sahMRYQfxv3wLNt9g2PJK
	w1iu5NpgONHM3dqPTXXO8sFjtPXCm2icltauQpEaWCedHm0GHQA8vvZ1+khXJzLi
	NfqQO2j98E0zLCDpUTS+wN3bK1Vr6Dz+uI9ObhGGLaBEUOWy2pStxb7l6eEpJjMo
	Sltl5FeXcmQEKjGg7U6qvlzLXmWyK9Hw94u+gPIS2+laXQc1EW3uHR+45UpAcaHQ
	2FN2wfZszswSXHSaH92IG+nJjCMsQcRH4CQ==
X-ME-Sender: <xms:d8WnaXWb4dbNa61NOK-iSHapbilX93nq7nnD3I3pbRythYV5_3b6Kg>
    <xme:d8WnaYCpWT41eIbqTe1702J0yObFcKL3vs8sdd3YHKW0Ch-iyvVLFkfNVcXRVunRB
    6r7w15SLDAVFQFXx0MZabcCWm7XACVciwC3ZH_UudV04hgnviFnbHM>
X-ME-Received: <xmr:d8WnaT2bY0AiKZ2vxGqjJ-dwu7q-LwgycZtkmxUvH5rfrp7rt8rjW48m3ukS-iPR0Jdo26mmwj3835KKnGBhEKb64AX6YmeTGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:d8WnaS22k1Cssn5oi6RsnD_cExdnC1GmeB66enFyTMYBCa-3-98DPQ>
    <xmx:d8WnaQAePYvMrPplTkyI3pKCHxYiCwB9M2s9qewrd2ICfciBMBvD4g>
    <xmx:d8WnaZ48Auh3_b4R3W7MKf3sh547Ox8E2TOnTekwmtYSMkuKrkIDig>
    <xmx:d8WnaZLH369Cn4q_LswrATODjouR5pma4aQvq6ZtPKYwafAg-Jdb4A>
    <xmx:d8WnaV0KHSjfL-9H1Q-6Dg2pdXwU9ASRJYBhQ2B-gIxfmsV-Y_xgID3->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 00:39:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Tian Yuchen <a3205153416@gmail.com>,
  karthik.188@gmail.com,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
In-Reply-To: <460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com> (Phillip Wood's
	message of "Tue, 3 Mar 2026 19:31:04 +0000")
References: <20260222102928.377519-1-a3205153416@gmail.com>
	<20260223074410.917523-1-a3205153416@gmail.com>
	<xmqqpl5rumy0.fsf@gitster.g> <xmqqjyvu42pw.fsf@gitster.g>
	<460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
Date: Tue, 03 Mar 2026 21:39:02 -0800
Message-ID: <xmqqo6l49mrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Looking at the test failures the tests are failing because
>
>      GIT_DIR=/dev/null git diff --no-index ...
>
> which is used by test_cmp() on Windows is dying. That happens because 
> stat("nul", &st) fails and this series makes that an error (somewhere 
> along the line "/dev/null" is rewritten to "nul" on Windows). I'm afraid 
> I don't know enough about Windows to be sure how to fix it but maybe we 
> should special case "nul" in the setup code or mingw_stat().

While I do not think we want to special case "nul", I think we need
to make the tightening of error checking conditional to who is
asking to know.  The _intent_ behind the NEEDSWORK comment was to
allow us to be more strict when we see a fishy ".git" filesystem
entity when we are in a directory /a/b/c/d and are trying to find
out if we are in a Git working tree and where our .git directory is.
We may not see /a/b/c/d/.git, go up one level and find /a/b/c/.git
and stat(2) it.  In the current code, we take any and all stat(2)
failures as if it failed because ENOENT i.e., as if /a/b/c/.git did
not exist, and we go upwards.  The NEEDSWORK comment wonders if we
want to be noticing that /a/b/c/.git did exist but we failed to
stat(2) for some other reason, and if we would want to let the user
know.

But the "GIT_DIR=/dev/null git ..." use case is vastly different.
We are not doing a discovery and we are not interested in going
upwards when the thing we check for "git-dir-ness" fails to be a
git-dir.  It may have worked around the "nul cannot be stat'ed"
limitation if we used "GIT_DIR=no-such-directory git ...", but I
think anything that we positively know is not a .git directory or a
"gitdir: over-there" file is given as GIT_DIR, we would want to say
"nope, we do not have .git dir and have to work outside any
repository", instead of dying with "whoa, what is that garbage you
are giving me as GIT_DIR???".

WIth an explicitly given GIT_DIR, setup_explicit_git_dir() is called
and the function calls read_gitfile_gently(path, NULL), that lets it
die when the thing turns out not to be a proper ".git", except when
stat(2) failed (for any reason) or stat(2) tells that the thing is
not a file.  If we use GIT_DIR=/dev/null on POSIX systems, this
"not-a-file is fine" leniency allows us to proceed without dying,
saying "We were given an invalid GIT_DIR, we are not doing
discovery, hence we are operating without a repository".  On systems
where stat(2) fails for "/dev/null" or its equivalent "NUL:", the
same "stat failed for any reason" leniency allows us to do the same.

But with the patches we have been looking at, that leniency is
tightened.  I think it is a good thing to do during the repository
discovery.  But it is not if we are checking the explicitly given
GIT_DIR.  All calls to read_gitfile_gently(path, NULL) need to be
audited and then we need to decide which ones to leave lenient, and
which ones are OK to tighten together with the call used during the
repository discovery.

Thanks.

