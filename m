Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783A1DC1AB
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959212; cv=none; b=cfoAueHIhHdqmc9Cq5RVn1fN/A7HKf6RfDwugBwCCAFadq7v2ZmIiO2NiMe7Xi8oSKHmK07kO3tNotXHkvoImFGcTo+hjdmThXOAv2qTEsfCWNjcSSHGU3HDQ/nm88vgxh78hlqJc/60WfAndz+ruSRqLUhKGXjoNJ8gmXwSFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959212; c=relaxed/simple;
	bh=+EDuSH6dNnw6mUGksTwsiCZH25FcmNK8OHOes0FK0/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kr2Vsw7JKPzEG3wqqueiCZHHQApuOA+NzaA4mt30ZV4zsKCxLtbySLmb9Rd3q49TRfpaJ7X6R1Ve8oxbQK1xnK1OldnFyOXRnAeVZfLDgqW9oPr2q0RD43bDJO/gqBHP3Jp5XP2TIrO2TRt2hiTK2vxCpuRAB+ZDfTBXkQAoh08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OcH0X2PN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=foIvRDxy; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OcH0X2PN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="foIvRDxy"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F1D8A1D000DD;
	Wed,  8 Oct 2025 17:33:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 08 Oct 2025 17:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759959209; x=1760045609; bh=VRmTvMh/RF
	HLK/AW88ojVJqg3HMvZO1mBCoqeAyu6+E=; b=OcH0X2PN20umG/R/lKboKH4E3O
	XY9GoOrMpRFSeGbYACSxed/2lR+v133dQKv8PYWEcAABc7HPaEo7tK0k5Lxz8d3V
	lwQHI6W0mlAc1d51e4saKxuK4ZYMo9YfTmPtOiO2noH6o66/uAutg7weMT7cTxph
	cSbLCEwl/B8mJw1bXiIrV4WY3kNuBX4LVSyrzy78SEK4eE4i61pJtyC0GmE8X2Ss
	8s7KCOJ8Xq7SU3y9Mi3ds9JCCERD0C9FsCJmwTkgojxyEg/DR9sS/mFwv9dZ4dqI
	kN5GbO6e+YlHKazjFecZrKnXGALuKo5bCTQP1nXwbniMktUG88EJbWxZzTEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759959209; x=1760045609; bh=VRmTvMh/RFHLK/AW88ojVJqg3HMvZO1mBCo
	qeAyu6+E=; b=foIvRDxyYzKE/3XieFGBdcx1LH5WiOeGi80OturGViCt3a1Q0HF
	We44D6Ej9iCqHukXva7dVRTnId/eICUzeLtmxlWKpEPeJY9M4LMKa2TUBd+7/WQ/
	6YJ9zvKA0SMoCnWlORWlYSfBYmpNnzigIexJ5p/7S0k4tmDm5ym1FapgPWZ+gaIp
	+M5zKNxYLnIFGg2Ic6vy5vy9cdZW+gpjspdbojQmy0p+U6Hr7cdzryH6qwntyrLT
	uONjW6R/Riqg14E13QFlD8oncEcUOgUJLF/nF/CaB7uiefdiLbtxWf/BWXZM7dUU
	VDvSESS8V60lc8qMDBuISxqjtjblyZ7DbEw==
X-ME-Sender: <xms:qdjmaJRFIkiD9vN9dGtSwy2cUEOViErYb2H02QeYyzoT5E-dMq8nXg>
    <xme:qdjmaGfZ-_RXOIyfWDJFlFDX8sQBPiCHO10Z9U_Mo2iTtsBBWTCwGXknE9vZx3z0U
    NDVxZYFFdWurGuIyVZzigKEiKOO5XNOV6Bjv1M2Padbq8PA36tYZw>
X-ME-Received: <xmr:qdjmaIp1RZq8gJCJtACErTJ8-xhcOpcBLnFdikYkQZKWiMhWvdByJWYijAv83x0JXXG3_dOzTxwcSqq0ypjIwExT58K4klblemsi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrd
    htohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgt
    rgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qdjmaH93UgLrhOlLEMgTERkUelpcGn4AZJYE0zlno_eAr4_qVGmRZA>
    <xmx:qdjmaEfKAsaUrUIbQ-3whE0-Ta_v0bH7ogKRqilxVhtceK1qZIm56A>
    <xmx:qdjmaBIJkGv_rDta8SZQTDI8ubNlPpUvtFqNaSgOzq95r3zeXHVtGw>
    <xmx:qdjmaEh_Gjv3Qd445mrXhgjZrLWA5z6wMkEBDiuGMnzItWvwNhlfmQ>
    <xmx:qdjmaC1trqnnK0EdRrIH3Yepim_Tb9eRN5ixA0HfH8d7JMOPvh9RVZ5W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 17:33:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Chris
 Torek <chris.torek@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 2/4] doc: git-pull: clarify options for integrating
 remote branch
In-Reply-To: <122774d4cc8fa4e9184a0f82e9b6e562363ea433.1759951536.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Wed, 08 Oct 2025 19:25:34
	+0000")
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
	<pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
	<122774d4cc8fa4e9184a0f82e9b6e562363ea433.1759951536.git.gitgitgadget@gmail.com>
Date: Wed, 08 Oct 2025 14:33:28 -0700
Message-ID: <xmqqqzvddqon.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Integrate changes from a remote repository into the current branch.
> +
> +First, `git pull` runs `git fetch` with the same arguments
> +(excluding merge options) to fetch remote branch(es).
> +Then it decides which remote branch to integrate: if you run `git pull`
> +with no arguments this defaults to the <<UPSTREAM-BRANCHES,upstream>>
> +for the current branch.
> +Then it integrates that branch into the current branch.
> +There are 4 main options for integrating the remote branch:
> +
> +1. `git pull --ff-only` will only do "fast-forward" updates: it
> +   fails if the remote branch has diverged. This is the default.

Technically, you can pretend to be the king, the center of the
world, and occasionally publish your very latest to the remote by
pushing there, and it is technically possible that the remote to
diverge from you by somehow acquiring its own commits, so the above
is not wrong per-se, but the way it is phrased is a bit awkward.

The operation fails when _you_ diverged from the remote branch.

In other words, you cloned or made yourself in-sync with the remote
earlier, the remote may or may not have progressed before your
'pull'.  If you created your own commits on top of the state that
was in sync with them, you diverged from them and --ff-only is
stopped in such a case.  If you haven't changed your branch since
you were in sync with them the last time, --ff-only would
fast-forward your branch to match what they have.

> +2. `git pull --rebase` runs `git rebase`

This technically does not integrate remote branch into our current
branch.  Rather, the commits on our current branch are integrated
on top of their history.  That may be worth noting?  I dunno.

> +3. `git pull --no-rebase` runs `git merge`.
> +4. `git pull --squash` runs `git merge --squash`
> +
> +You can also set the configuration options `pull.rebase`, `pull.squash`,
> +or `pull.ff` with your preferred behaviour.

This part has two orthogonal things, each of which has its own
default, which may be a bit confusing.  (1) which branch we get from
the remote integrates with the current branch.  The default is to
use the upstream of our current branch.  (2) how the integration
between the remote thing and our current branch is done.  The
default is only to accept fast-forward updates.

Perhaps it may help clarify the flow if we said upfront that we
describe two orthgonal things?  E.g.,

    First it fetches.  Then it decides two things: what to integrage
    with the current branch, and how to do the integration.  By
    default, the upstream branch of the current branch is what gets
    integrated, and by default "pull --ff-only" (described below) is
    how the integration is done.

or something?  I dunno.

