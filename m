Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2E946F
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044215; cv=none; b=BrLJXhZc0Y933U/UsIAKHubQpKIX7jd8++7GMBsw/NiBf2dEe+wmLSh0vHS2K8W9bNgwc5UINfYx7467vIGemXdbD07DidYbVZ9OXHkTStdEfe/E+KNpgcZhpvHk6riF1ZsmC2hMzkvfjBcQUn5+uLZQsRvVOjshvyiM12Z+meM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044215; c=relaxed/simple;
	bh=ViOfaaILeYfTf9Dby6qGXpP1+BfhNOFOhBl5uFOhOfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEJFdZWpbbPx2qzfI5mGw6fcR+QGmTEQJekK3btEcmi4iNgXFni4eCw/xQ1TuFDsfj7lvA5qjnPsjgJGobrB5Bqd+JdA02/YmeKh0QNYGiRFJ9cp4GjgQnmkcCztpa3No3yWuKmWFMT5/gpwJDKzCvdv9KIBpwZenPp1dUPCzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NMo5v/Hw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=la5iy8yv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NMo5v/Hw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="la5iy8yv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BDA5913806C1;
	Fri,  4 Oct 2024 08:16:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 04 Oct 2024 08:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728044212; x=1728130612; bh=RgnoZF8chv
	ZVNtUDjXAWmwTQ+Xf5wWdrDecBr+p2kto=; b=NMo5v/Hw91TEvnWqFi6zRWngDd
	PwIIsIv8nnzxKYwHwaYVqcbZmi0Ai560/2o3YjPzv9mUnhP0mawSeXsEyQP4R11t
	zBXaJxcBnD/CwHCoiioV02i6ItVFL8uxukS+2FaQ0N72YknV5TACK9gXFW5H7UiN
	+jXlKdQ0queKJbN3jGHhObbOs9fwHq3ezWGzeu/nK/xC0JB1Z+kFwKl81uigG46l
	vNQ23NU5sQiqTHEGhLGiUSGXSMu4ofASRj+pddsexgxM0nHQTRQCmqUS6cVs/AUn
	CQCRi1lYZMz8B5f8TiBiZ8q/z0VajDWDeTMtch3vOFSq5sljsjoD6iVHcNNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728044212; x=1728130612; bh=RgnoZF8chvZVNtUDjXAWmwTQ+Xf5
	wWdrDecBr+p2kto=; b=la5iy8yvNbC0NEFJpQ+ceI3WZ2SDJxfmaQPsQp0uzMwY
	1Rw8Q1c4jUGc9aB4+nsCHhBwwIt8Tb6SfzprxCUi4bDp96ltmyV5OYNes8Eu2mf4
	A09TQkP1Lmmc6yLK6SMCAcSg/fORmYpUtd0ND6Xn16vRWDLBMgKxAhCilPiV9f6J
	UprsJYLMrsij/4T/VthCxgO3Eq0H5YiS1f7Qzva4awBKPmM+cczHhurcwn8YoxQ0
	U2YZS1hri02U8UU7MwvbqAYpnGZjELEqOY9aWRAaN+2+y7BmRT2/1/DMAYazQ/nP
	V3QYahLk06ldyFvHVKKGXvTYZXtkTfRBonwPJ/36BQ==
X-ME-Sender: <xms:tNz_ZrVhBD03xIONixS_udXAqnPgJGrxmwKOmNgEfqbAmeuhPdEqSA>
    <xme:tNz_ZjlUeDt2hUnGztTk_cRSTF4ewc_-kvM6KujTXujMQwIwvgnI7JuRYfhMU8XF5
    3mBKiDjCHVENh9whA>
X-ME-Received: <xmr:tNz_ZnZq03ew9x1OJTtKJ_7fA0-PhOeEQUkvhj2E9aTwL7_4tw5CkMWvcZkKwI2r074T4ijLoBIRYAEkWngR1CmHr4PgdF4hW12SiouOVfjK1FLb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    hhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:tNz_ZmXEVbTV7rtBS0gmXXEf-ZyNlUMyiKBg-2ghwa0_884wZ48u1Q>
    <xmx:tNz_ZlkhV7ZuWsnVoJ1oXKMC_NyZdJrgXSnv1XzMapk2pqm45bqbIw>
    <xmx:tNz_ZjfFAVgu_Irmln-ZEeQ01SzaEnf5Zw17XFMASo06oCdu05yhjA>
    <xmx:tNz_ZvHzQQOpaez8sstTpl5r8K_MYs1LfVcuEwL_thiyYWMh9cyfaw>
    <xmx:tNz_ZjaeUVh2S_OgKXqAR0HV1I367NpQaNytm8ppcbA2yOg6GcUn07ty>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 08:16:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c6d121e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 12:15:56 +0000 (UTC)
Date: Fri, 4 Oct 2024 14:16:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Josh Steadmon <steadmon@google.com>
Subject: [PATCH] t0610: work around flaky test with concurrent writers
Message-ID: <f83e23f1e76454a80e3e53cd02b3bb5bba6b8da1.1728044178.git.ps@pks.im>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>

In 6241ce2170 (refs/reftable: reload locked stack when preparing
transaction, 2024-09-24) we have introduced a new test that exercises
how the reftable backend behaves with many concurrent writers all racing
with each other. This test was introduced after a couple of fixes in
this context that should make concurrent writes behave gracefully. As it
turns out though, Windows systems do not yet handle concurrent writes
properly, as we've got two reports for Cygwin and MinGW failing in this
newly added test.

The root cause of this is how we update the "tables.list" file: when
writing a new stack of tables we first write the data into a lockfile
and then rename that file into place. But Windows forbids us from doing
that rename when the target path is open for reading by another process.
And as the test races both readers and writers with each other we are
quite likely to hit this edge case.

Now the two reports are somewhat different from one another:

  - On Cygwin we hit timeouts because we fail to lock the "tables.list"
    file within 10 seconds. The renames themselves succeed even when the
    target file is open because Cygwin provides extensive compatibility
    logic to make them work even when the target file is open already.

  - On MinGW we hit I/O errors on rename. While we do have some retry
    logic in place to make the rename work in some cases, this is
    seemingly not sufficient when there is this much contention around
    the files.

Neither of these cases is a regression: the logic didn't work before the
mentioned commit, and after the commit it performs well on Linux, macOS
and in Cygwin, and at least a bit better with MinGW. But the tests show
that we need to put more thought into how to make this work properly on
MinGW systems.

The fact that Cygwin can work around this issue with better emulation of
POSIX-style atomic renames shows that we can in theory make MinGW work
better, as well. But doing so likely requires quite some fiddling with
Windows internals, and Git v2.47 is about to be released in a couple
days. This makes any potential fix quite risky as it would have to
happen deep down in our rename(3P) implementation in "compat/mingw.c".

Let's instead work around both issues by disabling the test on MinGW
and by significantly increasing the locking timeout for Cygwin. This
bumped timeout also helps when running with e.g. the address and memory
sanitizers, which also tend to significantly extend the runtime of this
test.

This should be revisited after Git v2.47 is out.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

This fix can be applied to remove some of the stress with the Git v2.47
release pending. If would of course be preferable to find an alternate
fix that makes MinGW work as required, but if you take the 500 lines of
code that is the rename(3P) implemenation of Cygwin as a hint you
quickly figure out that this is a rather complex problem.

Patrick

 t/t0610-reftable-basics.sh | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 2d951c8ceb..86a746aff0 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -450,15 +450,27 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
 	)
 '
 
-test_expect_success 'ref transaction: many concurrent writers' '
+# This test fails most of the time on Windows systems. The root cause is
+# that Windows does not allow us to rename the "tables.list.lock" file into
+# place when "tables.list" is open for reading by a concurrent process.
+#
+# The same issue does not happen on Cygwin because its implementation of
+# rename(3P) is emulating POSIX-style renames, including renames over files
+# that are open.
+test_expect_success !MINGW 'ref transaction: many concurrent writers' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
-		# Set a high timeout such that a busy CI machine will not abort
-		# early. 10 seconds should hopefully be ample of time to make
-		# this non-flaky.
-		git config set reftable.lockTimeout 10000 &&
+		# Set a high timeout. While a couple of seconds should be
+		# plenty, using the address sanitizer will significantly slow
+		# us down here. Furthermore, Cygwin is also way slower due to
+		# the POSIX-style rename emulation. So we are aiming way higher
+		# than you would ever think is necessary just to keep us from
+		# flaking. We could also lock indefinitely by passing -1, but
+		# that could potentially block CI jobs indefinitely if there
+		# was a bug here.
+		git config set reftable.lockTimeout 300000 &&
 		test_commit --no-tag initial &&
 
 		head=$(git rev-parse HEAD) &&

base-commit: 111e864d69c84284441b083966c2065c2e9a4e78
-- 
2.47.0.rc0.dirty

