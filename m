Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7641ADC9B
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060077; cv=none; b=l3riWT5InsR7rrokWd86hTq1GVcqFaMwWf3UAyaZKlprdZdwLeqgPTquiExlbsuDV5pCBI5UF8d5DnGTumaTfw04tFQOEMzo2MVs3Uo4VdNze5H6lPMag+6yKkH3S1DknmrqylVED5UgrdL5PIbqmvo0IGujOc2q1BhSLJpHH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060077; c=relaxed/simple;
	bh=UcqbeEnwBq8OyofC4+bJLWQyevdeIDPTZKrZ28p8CG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qcPGGTPwg5EyVYuHYPsO8cQ2z+DQu9txqlCYhInTe+TF1PFErJe67b7S9oL8a2w7bHi56wF50GHMHGwms6Xq1lQWuN22gmlmm+F+Iw+Hfjrstfh0xsUddy1Bg4nkquMY+4oGoONfuaDNfEK1eDg0mCrS5IGf2ZUBx9c9KH/Y/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cBCo7zdF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Em8kbIa5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cBCo7zdF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Em8kbIa5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 227341140245;
	Thu, 20 Feb 2025 09:01:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 20 Feb 2025 09:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740060074; x=1740146474; bh=3QX6WQJ3S/
	OznuqD6KXH3Haulk45Wk1NmIcotaSI7yM=; b=cBCo7zdFyJzeJu78sAnB5mxMRW
	I3RoKqvEqZacwgTKKzdGaCBJNQY+LKG281jz+Mw4UHfaZiJ8Soh3QPXJhZDcPYNE
	CWnOArA8/JiBZ0Rb1NjrdCdRhOYzgVccTH4IpKqftis+kK8FVR7NU1/Ps1O5H74E
	cex48ktAlLaBkQ+Pjuam8EeLvUu7uRQ0+Nq5eqw/Tq5yu506U9ujjOF/UV4ilApR
	Y5OXv0scE8hBBo17lS4RGLnUS/Uz9/HeS5R/E9d28tS1beUlxV/i1DmHYzqONCkd
	erkJt3R3GTSqVn7Cm5LurdhWrYdhnCvppvgjzC/8e2/CdvhU+n4C0K7BZpxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740060074; x=1740146474; bh=3QX6WQJ3S/OznuqD6KXH3Haulk45Wk1NmIc
	otaSI7yM=; b=Em8kbIa5kJHlJ2jNgSgL6sUbXf9cAhFjniteK1A/nsOSC8QhlVY
	U+W6fRGFrO9i+AG9jMgFtEdCYf0xen2iBBloMeu930WrWnS6REuUMiSjzuJD2FqO
	1egmYPAZ9jESvSh037TbfYtuPDOyQE2pOY5VFNSJfNuKM7uWKhQcBdfKftsTcHJF
	Ljz01G1F8NpBH4lcLhguvfcBVD0anSG9+O0ZHVSG1dqIDuYyrrwBUe1p4k5xxiQS
	xhZ+8xepb7pgjzcz1wBjCgmgOtqw9quA6PYkny5BEbXT4nudyGLQxMz3PiFlFnok
	nuNwrvRHnSGu3+RwyUOMVqwcX6g/o2CqHbA==
X-ME-Sender: <xms:qTW3Z79sZ6IOSNtWvr44rvYiG9wgd-RLjE-k_wO_avopwmiNrE8tsA>
    <xme:qTW3Z3sDxztEHSw_-9hU9odJDFlWKKi3B4YRijiXoSNgc1iA5Xs2OxfoBcCDQFTQc
    MkXX8yYmm3b-LwZ6w>
X-ME-Received: <xmr:qTW3Z5BVoRekAFtFSXi9aW46wcd0a1DrKjqNqV5EHllfO9_UZu_xUC5Kctmdt9J3m4zZxuNniOkEqFxnrajacdt8sxEW-T-jlqtuEyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepff
    eiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfeijedtnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsgh
    drohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qTW3Z3c6NAiijAA_RDdmnY67i6YYWpiCU4ulAFoFzBGUH1ADyrhwCg>
    <xmx:qTW3ZwOTu75j5u3CVxAHZX1jCbEQbyahLfVn0D6jWxLCXq_lo8f5wg>
    <xmx:qTW3Z5nmnF2-cHah9xhJc8Yc2cUYRRzYJDFOtYX4_U90Cwa7kI7uNA>
    <xmx:qTW3Z6s2pYidjUfu6n31HCYSzjH8FVzlLzfrWDt9nwpg1QZ018D_JA>
    <xmx:qjW3Z1omOMWE1vVItSv6wVLYy5K3AUkT2MRGNH-XtGNLhVlgsqcNJuXT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 09:01:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: various fixes for Windows, Meson build
In-Reply-To: <94cdb4c6-5466-44bc-ba42-120ae86fa951@kdbg.org> (Johannes Sixt's
	message of "Thu, 20 Feb 2025 11:16:14 +0100")
References: <94cdb4c6-5466-44bc-ba42-120ae86fa951@kdbg.org>
Date: Thu, 20 Feb 2025 06:01:11 -0800
Message-ID: <xmqqseo8emvs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit e76b53ef23871ff81ab305822eb605baf0cc5bd3:
>
>   gitk: Update Bulgarian translation (327t) (2024-12-24 11:58:09 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to 4a6cc6a20eeb593f1ad0f60475a9867532d7c5d5:
>
>   Merge branch 'pks-meson-support' of https://github.com/pks-t/gitk (2025-02-20 10:54:37 +0100)
>
> ----------------------------------------------------------------
> James J. Raden (1):
>       gitk: make the "list references" default window width wider
>
> Johannes Schindelin (2):
>       gitk(Windows): avoid inadvertently calling executables in the worktree
>       gitk: fix arrow keys in input fields with Tcl/Tk >= 8.6
>
> Johannes Sixt (2):
>       Merge branch 'g4w-gitk' of https://github.com/dscho/gitk
>       Merge branch 'pks-meson-support' of https://github.com/pks-t/gitk
>
> Karsten Blees (1):
>       gitk: Unicode file name support
>
> Patrick Steinhardt (2):
>       gitk: extract script to build executable
>       gitk: introduce support for the Meson build system
>
> Sebastian Schuberth (1):
>       gitk: Use an external icon file on Windows
>
>  Makefile        |   5 +-
>  generate-tcl.sh |  11 +++
>  gitk            | 213 +++++++++++++++++++++++++++++++++++++++++++++++---------
>  meson.build     |  30 ++++++++
>  po/meson.build  |  19 +++++
>  5 files changed, 241 insertions(+), 37 deletions(-)
>  create mode 100755 generate-tcl.sh
>  create mode 100644 meson.build
>  create mode 100644 po/meson.build

Pulled.  Big thanks to everybody who is involved in this set of updates.

