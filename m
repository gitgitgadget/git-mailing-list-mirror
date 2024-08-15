Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C701714DD
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720927; cv=none; b=l2VJoqO2ZNNiqS5hqOoNGvyWL3Q55rDe/ccWlCqoaAkannc8PqVTPo6E5Vi46qAAUAJs+25ygf6wqljT5i/Mthu/myZMuBdAuisZ3iAssj3e3p19NOXGiNf1qc7iYKCo/P2cARVJNPBHcuRusuYXXDHQcr1vV870lgPI5E9OE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720927; c=relaxed/simple;
	bh=XmkTB6jxtXARBaWDG5rPAnVGrArllhsJEigdfU6PNxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Npza/MfldcFRj2h3wQ/GdoIA/yb3FFLWyQ+nl4eC4ISaWXRR+L5J2Z8upmxkApMDAziRAAlu2QVHNKzi6RFNY8zNsNbNvSpTOJE3OsQePpqf0IsWT0BWFpG7VExzs6UqeqZopbQxeZ5V1Hy7hoyCha+z4rJGkkMwsOaLL75Vm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cHzqMzUr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HD3ZxdrD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cHzqMzUr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HD3ZxdrD"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AF425114ACF2;
	Thu, 15 Aug 2024 05:12:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 15 Aug 2024 05:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723713162; x=1723799562; bh=5tYMlbLDwv
	m982XMJggbaMnOEuW6BOecxZBgQpD8Tug=; b=cHzqMzUr9ZBjuVcYrXRA/PU9Pd
	vzHgLtz06Z/b7+4oWOQRkg30QsaBwSeGIMfzHjjIkZVF/30p00VdyBuJ24/uV4x7
	CKLInsm9ZmNDIYPjESEw1gmqYzkoWL0jDSgxF4FtRzZ2QZN6Kzlcu+zjxB82Galh
	qLug9PdCNxfnKS/bM4/AdgCEZhGPGhS5Pc8pzVydrEb/xbVS+ikA+Zyrt1ETyexs
	W2hpDQONfRp80JFqP7fLyDXHso5KNd6bFshdrO70/U2PsAA9ufoPS9Suoxz9q1BY
	ZRnzrmWTdrJ8HnBrm2C6mEi6nXkSufhTynB9s4pdiD40G/objr+J+w0dHGZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723713162; x=1723799562; bh=5tYMlbLDwvm982XMJggbaMnOEuW6
	BOecxZBgQpD8Tug=; b=HD3ZxdrDOcSSa+AyK/saL8PEhhbgSDm5Jvegc/gqUZ1a
	OWKJ+Q82/mbaxI/tEoZEQ02JgX8KYwfzP0NbjScl7LJ7hsUyso6xjDEgiqPvQTwV
	SHyX2n9JM22T+pEr3UXD2vsHBSMocgQ5VFCIT/QtU5elyzuHHPog88q/2PvTQjgq
	Btt+wIPbIVc6fKj3xFMcto4HtqimFVbvWHn8H4+O/MWOyfCRVIHcFb09dMYVnIN1
	K/PBaEz4rAyMN5HTBeUSP1kqWJCM0K5fcr/XgYq7FXO36BCMzRQbhWHwcTHG7TGa
	zhhu8l88T1e+OpdIsZYu3XrV1ItTwl3+orOKPQBgVA==
X-ME-Sender: <xms:isa9Zsj_fiC0esxsXuzML7BKD0C06Wz5hGPfCyPvNfmz1QZmztfZRg>
    <xme:isa9ZlC0NnQYrKQhHGeA6KT-438Me0I44Qs4AXkq5jUnBTvEGIEeno3N62NQn-yCK
    iOooKaqsdHUR2z7_A>
X-ME-Received: <xmr:isa9ZkH-ajIDcV_DRqoBrkZid4kngbakI1f5reRLRttl6f8XblNhLpX7sCMMkeATWKQT6bSpT2u9iDjvv_rryvs_KTMFNvl9lVg8MPLxPJA7yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:isa9ZtQTzJ5a7vx2DrhoHcYD3pH3YQC6CKUj9lgGkHn4qInyGhhe6Q>
    <xmx:isa9ZpytaFJl-fYEGuv-G-UlTuUElzaywzWvpCLYLJqDiWuHSVwi2g>
    <xmx:isa9Zr6vQveP73z-QWXfFa8Sp6ZUUjIFGdEx8EFvdYH7EEACHyrosA>
    <xmx:isa9ZmwZD2vDIp_ZvlUnT0pMaGkp7S3aBh4uiOPsrSHelND5bJumMA>
    <xmx:isa9ZrvpSUMPg592jMZgcqG63lUwBlBjjSDRTlAKMIEfBhmPe42srcyf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:12:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5133ef6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:12:21 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:12:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>
Subject: [PATCH v2 4/7] builtin/gc: stop processing log file on signal
Message-ID: <812c61c9b66d7608e41c6c1d00a6e22e995cef06.1723712608.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723712608.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723712608.git.ps@pks.im>

When detaching, git-gc(1) will redirect its stderr to a "gc.log" log
file, which is then used to surface errors of a backgrounded process to
the user. To ensure that the file is properly managed on abnormal exit
paths, we install both signal and exit handlers that try to either
commit the underlying lock file or roll it back in case there wasn't any
error.

This logic is severly broken when handling signals though, as we end up
calling all kinds of functions that are not signal safe. This includes
malloc(3P) via `git_path()`, fprintf(3P), fflush(3P) and many more
functions. The consequence can be anything, from deadlocks to crashes.
Unfortunately, we cannot really do much about this without a larger
refactoring.

The least-worst thing we can do is to not set up the signal handler in
the first place. This will still cause us to remove the lockfile, as the
underlying tempfile subsystem already knows to unlink locks when
receiving a signal. But it may cause us to remove the lock even in the
case where it would have contained actual errors, which is a change in
behaviour.

The consequence is that "gc.log" will not be committed, and thus
subsequent calls to `git gc --auto` won't bail out because of this.
Arguably though, it is better to retry garbage collection rather than
having the process run into a potentially-corrupted state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a93cfa147e..f815557081 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -109,13 +109,6 @@ static void process_log_file_at_exit(void)
 	process_log_file();
 }
 
-static void process_log_file_on_signal(int signo)
-{
-	process_log_file();
-	sigchain_pop(signo);
-	raise(signo);
-}
-
 static int gc_config_is_timestamp_never(const char *var)
 {
 	const char *value;
@@ -807,7 +800,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 					  git_path("gc.log"),
 					  LOCK_DIE_ON_ERROR);
 		dup2(get_lock_file_fd(&log_lock), 2);
-		sigchain_push_common(process_log_file_on_signal);
 		atexit(process_log_file_at_exit);
 	}
 
-- 
2.46.0.46.g406f326d27.dirty

