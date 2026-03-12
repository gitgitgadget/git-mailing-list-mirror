Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDA38E135
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331616; cv=none; b=g8z1Ddzp6sziA2VQyEtPo7gmxr+a8JznnXSOD7GF93s/DQADUvd6GUrUSRezfCqf+TfrCzaaPvQ9nThmjVciWGYLGAjEC3h4zeZa3p24ZfxjFELr1UwsYKCFITYMRbg82sHCy/XI+Iri3E5DIuPPBJXAZ7fJ0A+mMUKsBL6jTF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331616; c=relaxed/simple;
	bh=Xf6N1GHcMdIxFh+AaxVkrRcAgy+/7E1Sx8bovZHtbaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ABuF7DMxNho5lcxISe/4pyFp5St9zXVt/g+ouof3BlA2ghDp7BkR8dE4VfcTyJ2eeYBelumc7EW5MtN0ImHfgwwXQJ4fdZylyi3pioOcMXDoOlWhBRCyUBfN2XEEpoF/Y4x7ugXgaMCAybGpzKFRio/jHF/oAEZcXvP1AfMe1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IbWj/xVb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zHOYPDso; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IbWj/xVb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zHOYPDso"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6061B1D000F9;
	Thu, 12 Mar 2026 12:06:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 12:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773331613; x=1773418013; bh=MNDMb7JEpB
	M3E2RzbqKTm6Zzk5HJdhrDrfXGlA3GNBw=; b=IbWj/xVbA+1XVUM9Z2s0Hg/LJj
	w/XV6KgI6DTKX75eE+hrwamE6/367cvQ1CBV8I0rZ1UrGkmkmekg2b+uDmLE38jY
	EqTW86Gv37DP1ZwuzfqzENSRmQdLiBSf3tQK5JKcbS/eOki2K7ViStjPZF4NVukh
	SG1f0r0Y+QO0/HIbTiFm1/YGsvGHeRqZ7HB4aynQ1sM+mIs/OgtSToTXsJqfWn82
	jBQQelcf4IAZMel6CQWn5L5CSXdoyKCurFTbPPcIx5whHL95pEwyGHa3sGdRdGh1
	RxkjCE//eFGYN/LVU0KFJqAkuabGHEM3cCPlzkc38YdKQc137Hw4RgTUuZvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773331613; x=1773418013; bh=MNDMb7JEpBM3E2RzbqKTm6Zzk5HJdhrDrfX
	GlA3GNBw=; b=zHOYPDso+cZkJftqxHNJWohMzfeMUnXEyX3xxOwlVIA7D3gM0cd
	NdEMnaNqdV75Udf8i1dFqMLnNu25VhR30Af2zTiN+5sN5Xa10GBQRzBZ5dI3szHk
	ITW1ad6z9lDuLTQxKwNOWD4ldMlqDJImM1KgFZjSz+TPlUVt5+HZqyl94peUyNdH
	nBoUhSWlNcqxqMbcPJ0/AD500pRuVfJetlx4EQIQY/Sm5KD/GWvLexKsh0GIR2ai
	eCqoG6DwJFqbkGp/6dkHRfQF/+OuB5OfsYzGsAuTf91gdQyASetWHH15R+IejyNy
	Ib7KMN0HGzl8TYI5tAf9r8hfIzacnCQlUoQ==
X-ME-Sender: <xms:nOSyac5f1h7ZbS4zQILZUCa5vZYdJNWgAq0usm9B2sSDc8tlNmpZew>
    <xme:nOSyaQLjD7BNLSiSMXnzmqQWQVsJL8BE5Me7VCgCimkvd5OMev5bg0l1agL8IWJtN
    HiJ8B3nNo4yH_W5HxvZ4zn9Q40HHlEXiMfnEoDHI5dGeWQCw1aY>
X-ME-Received: <xmr:nOSyadtP0ynSNomoXFYsXIqvIk0JZHRU9LxlOhUdGR0WcdChhHyYq_32pKDpWV5SREWnr4v30gTWmV13HwIlB92PxtKOIZLviA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprg
    hrshhhshhrihhvrghsthgrvhgrtddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nOSyaXIwS7_rR3YP93GebUxmbkpPNbcA7aKVhh5pV2jI_nPzPCjP4Q>
    <xmx:nOSyae_gVs3rYRcQe2bp92EfYPjwLsxr9ylBzhvt40g7PUnOkg0lNg>
    <xmx:nOSyaYzftWw37uLAuXSE1ZqNUiyJgu4P5R5TvrN2bPyFOzYuRffEgg>
    <xmx:nOSyaT5SMqHfDl-xYMeqcX-LBm1iSWLbyoiXxLkaT1pilZI-JQqi_A>
    <xmx:neSyac_6MiRTvTGa4cup3olMetQSJkzB_GMk0ZiZRDnWqcZ4QTlQ9awL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 12:06:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Arsh
 Srivastava <arshsrivastava00@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6] unpack-trees: suggesting 'git checkout -m' with its
 repercussions
In-Reply-To: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com> (Arsh
	Srivastava via GitGitGadget's message of "Thu, 12 Mar 2026 04:00:13
	+0000")
References: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
	<pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
Date: Thu, 12 Mar 2026 09:06:51 -0700
Message-ID: <xmqqms0dghgk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Arsh Srivastava <arshsrivastava00@gmail.com>
>
> This comment is an extention to the already existing stash comment.
> Added updated comment over the already existing function
> "setup_unpack_trees_porcelain" with "git checkout -m"
> and its repercussions
> I have also mentioned the repercussions of using "-m".
>
> Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com

The commit message should focus on the "why" and "what" from a user
perspective, following the project's standard format (problem
description, then solution).

Consider a more standard phrasing:

    unpack-trees: suggest 'git checkout -m' when checkout fails

    When a branch switch fails due to local changes, we suggest
    stashing or committing. However, 'git checkout -m' is a valid
    alternative for users who wish to carry their changes over via a
    merge.

    Update the advice message to suggest this option, while
    including a warning about the potential for data loss if a hard
    reset is performed after a conflicted merge.

Also, note that "extention" is a typo; it should be "extension".

Having said that, I am not sure if we want to suggest "checkout -m"
in this situation after all.

The added message is quite long:

> Try using 'git checkout -m <branch>' for a quick fix.
> Please Note :- that using -m (merge) will not save your changes,
> rather would directly merge them.
> Meaning if you are not able to resolve conflicts and does --hard
> reset your local changes would be gone.

When advice requires a multi-line warning about potential data loss,
it's often a sign that the operation being suggested isn't suitable
for general advice. The goal of these messages should be to provide
a clear, safe next step, not a list of advanced alternatives with
caveats. After all, the users who need such an "it failed, now what
should I do to recover?" message the most are relatively
inexperienced users and we do not want the advice to be
overwhelming.

The primary concern is that 'git checkout -m' is a high-stakes
operation compared to 'git stash'.

- When a user uses 'git stash', their changes are recorded in a
  stash entry. If 'git stash pop' later results in conflicts they
  cannot resolve, the user can always 'git reset --hard' to get back
  to a clean state, knowing their original changes are still safe in
  the stash entry, which they can re-attempt to use later.

- In contrast, 'git checkout -m' performs the merge directly in
  the working tree.  If conflicts arise, the original local changes
  are immediately replaced by conflict markers. Unlike stash, there
  is no "undo" record. If the user realizes they are in over their
  head, they cannot simply "abort" to get their original changes
  back. They have only one chance to resolve it correctly, and they
  have to do so right there.

Suggesting this "one-shot" approach to a user who is already in a
state of friction (and likely less experienced) might be providing
them with a "foot-gun" rather than a helpful tip. Generally, advice
that nudges users toward the safest "golden paths" like stashing or
committing is preferred.

For a microproject, you've successfully demonstrated that you can
modify the advice system and update the test suite. However, for the
health of the project's usability, it might be better to drop the
'checkout -m' suggestion and instead focus on making the existing
'stash' and 'commit' advice as clear and helpful as possible.

Thanks.

