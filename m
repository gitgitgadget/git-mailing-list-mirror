Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C887199E81
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805114; cv=none; b=OxICFNG4ldZdJWnQOkqyer8fN0ArpB1p/+k8Mpl63s3MFHOxueWVRpxDYdSEqZ6+TSMmP+M+vMmw9GsV0W2h5vzD+5nfQEjpj673yor3XcEhwbCawBgHE4yQxZXGRatyksWk/1TwglxWpcbCf2/pKdqMRD44l8ywmBzC0iKW+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805114; c=relaxed/simple;
	bh=XmkTB6jxtXARBaWDG5rPAnVGrArllhsJEigdfU6PNxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ6NQKgJfIxFPfAkskT0U6XtAkfxFUE88wNmgwq1EtuRiskEBqEFzJnvbxikPLlMrMSRiWNXr1HOyVJ6Z3uplo58M8geSFxcgJkH9Sa7ydCrCcqRDYNm8tKzVvo8Xm3TvLd/TP6IzSEWQH64uflgorhJcATiaTmLFZzVBo1876k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fnopqSRE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXiO7oHx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fnopqSRE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXiO7oHx"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ADA1B1151BD7;
	Fri, 16 Aug 2024 06:45:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 16 Aug 2024 06:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723805111; x=1723891511; bh=5tYMlbLDwv
	m982XMJggbaMnOEuW6BOecxZBgQpD8Tug=; b=fnopqSREJrevQsY2bbViubn9/S
	ogCfdQA+WzkHTOJV/GxUC5wqsG6JHWroBSUymFl8HEnxZzWZk+7rhIZUOtUtTlnD
	6QardTTyT+ZN+z08ku6TYbOo/pOVltTLAGVjV5s8b7qaojXG8xYSotmJslwyRzJI
	BqoASDJxbEvMEXfFBN5ZE2NQqwjLU6dv+hjzDZY+00CnSFYbMzE9FKZTD9hdgMy3
	tZd6f6UI6B4dzw6S8ZFV/qHCO7794Kq4QVIWIYfC3JLq2eYadFVYrjx+CvH1mJdR
	E1BuyuXdFRprjySGnyT536toReti7KukzJYgsJwZwpp/mzxzUIWG3zGpBPkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723805111; x=1723891511; bh=5tYMlbLDwvm982XMJggbaMnOEuW6
	BOecxZBgQpD8Tug=; b=mXiO7oHxl983UC0l4Fy5lIvaa06AKf2FcbhwYn53tQdO
	DAnKJF2d/xpIRVNb5hmzDYR98BD/16W4WClkWfeIeEjCSLqmpofFjOF9xtA76mAh
	UR5FqgldPU5rnpYSDDf2hcSgEY0BNJgyHNbNiBc0isgLyP6zzsd94r50QYSB6Vy4
	tLCyPw/TbTpnCoNC4nkNflG7NcTRbYudWgwrNIF1ScjZlTYblGhAu12f2wZ0i9VW
	CC4FXbsx2e5OkZXn6n3fBtmK+HmzTolVCBXEHwXqUqgVtTUQ/GFGX9q+pLoWmL9y
	wwz7hrD2B+gLXImqQMMghW6xAW8VviBmP15CEaBGDQ==
X-ME-Sender: <xms:ty2_ZjLBTHgHkhl8d_pVeZ5iwLm7Ar_rx9w4LM6xRN603o-AtSzSnw>
    <xme:ty2_ZnJKT-yli-I5R_771IZSdQHOfPDWbcoE4J7Dgmz_mjR0ZZu8yAKztQxYb6Z0k
    1V-V1_dgw_cXmCIkg>
X-ME-Received: <xmr:ty2_Zrt2HU9m_d639k9evcgVmV-1HWuPt72N2YfdYNl2u0x2MJSo-rA9o2G3OShIivYu3hvIxkan1TIxQJ296phFYw4A3760GOp8A_z8aZnFtws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjrghmvghssehjrg
    hmvghslhhiuhdrihhopdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ty2_Zsb7fgujeQ4j0iQEirPjZzcMS8pzeDGYXYN6jVngRzOu7-b-QA>
    <xmx:ty2_ZqbbEAaOr3iAlMycRQxnqDghODRguii58eYKyUcPP8dUg2LiCA>
    <xmx:ty2_ZgBGc6y28x8F1-tGVSMX-VeIs4bIGpST4KwMAfDLPl5jNriUQg>
    <xmx:ty2_ZoZflvgcOl2gWDNxchvbymiE_PrMvx9ZP9ilZg3FSs5Z7Spb1Q>
    <xmx:ty2_ZvPWFBswIFyOkYLOlFgUvNySgy3D0i5Ts8r14xnSs2bmR4tfl4L9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:45:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea2fbe53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:44:47 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:45:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/7] builtin/gc: stop processing log file on signal
Message-ID: <812c61c9b66d7608e41c6c1d00a6e22e995cef06.1723804990.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723804990.git.ps@pks.im>

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

