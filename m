Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC724186A
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769736; cv=none; b=Xg2VA1GZgyC6xOBQ58TzQPJl1fBznurKXYOsaYh7H5473O/jLqsStmHa1Tb2w+WSzz3oMDaRbcxMAXkLpMVtsA2N0gLo0AodzzFYf3VyNWlBoKr2qUsKXy2wpVwD0+edO3/Tej/0MxztJ6gAA4Dj+mkzGAqQNeuA2UUnpbHqLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769736; c=relaxed/simple;
	bh=0cpeFnYAY0LX8lBLlKaFUra2LVQc+vrYTYW9vA1DLdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIxOzUwKeH4upbLSBWRZpJvfuVQjPr4CUCWWkHMQ58+7hr/vAwa+BJ1DnoJ4Sp/1P789vAOss+02pbLxOviPkTEXnCIagk2zaR7OC6hotHr05uO5D99rs1nnZAHllJJv1xdLUvUOTrOQyDkQ6m02xsJ4HqNmbqOyZNeEPpJ99mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DtxDYijT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jthy0Fte; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DtxDYijT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jthy0Fte"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CBBE7A0A40;
	Tue, 29 Jul 2025 02:15:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 29 Jul 2025 02:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753769732; x=1753856132; bh=IcoyXuTUfJ
	dmlyz384mO7Z9U8+iXOFM0r3aImeJmX6Q=; b=DtxDYijTMFk4iLj6bQK4dMj6MJ
	T/e2rSV0ZnjvG858jMcVMqDurUxl6V0ydJR4J/MNiYAodb4Ee9C9z3aOXp51DdBU
	hF0UxIwt8b0xVsgIkjJyS+Kz0avDxSHCHvTF0eG8q899LykFTxNshrnFVhzcGV+B
	BTwhXOKrmlens3OUvDgSEeF7gKxe2LX00uK9mm68QzyM3uVMcq+5Ranxaf4e6lOp
	IzhZgBM8Y6wCTnKAs7H5iIWGi+7CxSFbKKXqSh4HJNfJbQksGJgIiCpzLG6bNmu7
	BkXVa9mnT0nqXK/FELSp5vssLB1pYC1xjdJxBJRxv3BDJ2FjaExwQRK99CvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753769732; x=1753856132; bh=IcoyXuTUfJdmlyz384mO7Z9U8+iXOFM0r3a
	ImeJmX6Q=; b=Jthy0FtecpztKizAkO0CUkxPlvzum34O084a78f68HXYooTVCea
	8B/cGVUJJgl+sVSYxyvOq2HKo5CSHBRSX6ABerR/8tx8/j0ID2YpyFBLkAPYH0n/
	AEjC2sNudG4OBsRUnB4rcMdLjZ/vvmHKNZzwqnkizfzRKqjsS4/ij0y7VzsPgnC7
	QzqxOC7cC/AV1heO7mFckC8wGq+CNJPRKIFoLIae2SFGsotrAyNMFlNdXJpErgjO
	ix4H3TnmRZ4XWYbpA9PkGUvHUM68KxMr8SgjpsX03fyKFKyfHYykU2vtp0jExOns
	w8wC1k7TGnBz+qRXcCocjyWDB8wPOuH62rg==
X-ME-Sender: <xms:A2eIaNGkBBxHCX-PlGJaAWQow7vZoSiP60EpCaIl0sOdLzpF5TC4nw>
    <xme:A2eIaCjpAn3wKSzu0HJxRQTHxFBEMUcETDrPRoyN3-8OhvZsgaSIn4ietPjG_Q_0K
    fuEPiF5rE7dM7S7ng>
X-ME-Received: <xmr:A2eIaA9_caAcZWsomN5EtXkb_B2WWrdkX-i_xu2GLasWL1v_F85KPO6wHJBRIyxPcM97RGWZU4zXJiT7TzgC3tqvdLPhfMKgNkZHYo-22Tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:A2eIaBoRFVbbQLRgyrFMvfYWP236uOyVKQf0PZzITz2uKdQbW6zHow>
    <xmx:A2eIaH-P5YEwcu8ejOY1zisIhB4WtHwzD3f28Vp_JUos-wj_MaUFmQ>
    <xmx:A2eIaNXlUtQSzWSMRJbwJfYTpbPzgLSoujeJYIcB46O3M6TCwcUyyA>
    <xmx:A2eIaFAx9ykL6A_rTmdH_keuBEcbZikFcqGP6Y7c_-XFLLQ94bfH-A>
    <xmx:BGeIaPpcZQh4QWg_IlR3YelqAzot03pltUN4jhLWbCcp_CV-AMJ15Z5X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 02:15:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f876874 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 06:15:29 +0000 (UTC)
Date: Tue, 29 Jul 2025 08:15:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #08; Mon, 28)
Message-ID: <aIhm_nqiH8Sci12i@pks.im>
References: <xmqqo6t3sqrc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6t3sqrc.fsf@gitster.g>

On Mon, Jul 28, 2025 at 06:57:27PM -0700, Junio C Hamano wrote:
> * ps/remote-rename-fix (2025-07-28) 5 commits
>  - builtin/remote: only iterate through refs that are to be renamed
>  - builtin/remote: rework how remote refs get renamed
>  - refs: simplify logic when migrating reflog entries
>  - refs: pass refname when invoking reflog entry callback
>  - Merge branch 'ps/reflog-migrate-fixes' into ps/remote-rename-fix
>  (this branch uses ps/reflog-migrate-fixes.)
> 
>  "git remote rename origin upstream" failed to move origin/HEAD to
>  upstream/HEAD when origin/HEAD is unborn and performed other
>  renames extremely inefficiently, which has been corrected.
> 
>  Will merge to 'next'?
>  source: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>

Let's wait a bit with this one. It's a non-trivial refactoring, so I'd
like to have a couple eyes on it.

> * ps/reflog-migrate-fixes (2025-07-24) 8 commits
>  - refs: fix invalid old object IDs when migrating reflogs
>  - refs: stop unsetting REF_HAVE_OLD for log-only updates
>  - refs: fix identity for migrated reflogs
>  - ident: fix type of string length parameter
>  - builtin/reflog: implement subcommand to write new entries
>  - refs: export `ref_transaction_update_reflog()`
>  - builtin/reflog: improve grouping of subcommands
>  - Documentation/git-reflog: convert to use synopsis type
>  (this branch is used by ps/remote-rename-fix.)
> 
>  "git refs migrate" to migrate the reflog entries from a refs
>  backend to another had a handful of bugs squashed.
> 
>  Will merge to 'next'.
>  source: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>

There's been some discussion with Peff at [1] around one of the commits.
I plan to send another revision later today that makes this area a bit
more robust. So please hold off merging this series for now.

> * ps/config-wo-the-repository (2025-07-23) 22 commits
>  - config: fix sign comparison warnings
>  - config: move Git config parsing into "environment.c"
>  - config: remove unused `the_repository` wrappers
>  - config: drop `git_config_set_multivar()` wrapper
>  - config: drop `git_config_get_multivar_gently()` wrapper
>  - config: drop `git_config_set_multivar_in_file_gently()` wrapper
>  - config: drop `git_config_set_in_file_gently()` wrapper
>  - config: drop `git_config_set()` wrapper
>  - config: drop `git_config_set_gently()` wrapper
>  - config: drop `git_config_set_in_file()` wrapper
>  - config: drop `git_config_get_bool()` wrapper
>  - config: drop `git_config_get_ulong()` wrapper
>  - config: drop `git_config_get_int()` wrapper
>  - config: drop `git_config_get_string()` wrapper
>  - config: drop `git_config_get_string()` wrapper
>  - config: drop `git_config_get_string_multi()` wrapper
>  - config: drop `git_config_get_value()` wrapper
>  - config: drop `git_config_get_value()` wrapper
>  - config: drop `git_config_get()` wrapper
>  - config: drop `git_config_clear()` wrapper
>  - config: drop `git_config()` wrapper
>  - Merge branch 'bc/use-sha256-by-default-in-3.0' into ps/config-wo-the-repository
> 
>  The config API had a set of convenience wrapper functions that
>  implicitly use the_repository instance; they have been removed and
>  inlined at the calling sites.
> 
>  Will merge to 'next'?
>  source: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>

Yup, this one is ready from my perspective.

Thanks!

Patrick

[1]: <20250725113610.GA3015361@coredump.intra.peff.net>
