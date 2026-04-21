Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60136605A
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756869; cv=none; b=AZee+icnJjNWbI/YF4Mee41JK711CCLeYeHrssdtgJGPq7RnB+2NkboKKkFODTk3bZQum3EngomWcyeF1xQpQPvpFYu0cV87osWhXt49g3TmBtlIhZ13z785UrRaHsuVFj+wlKET9Qw+ez6jzGs2CRbpcPnZIVp4Lni+/q1HKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756869; c=relaxed/simple;
	bh=2EYxhqTd9o9rmNiWi3rAwvLWvJeoxw2hWzmWOtroUQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHd23c79iWFdpOBmkunzOIKvYUJwzpapbdeLLXnshcvxW3zfOW44TaRziwcdOaLO/oG7NyTRPTuxK2BuwzCUiCHxQ2nHkr/h/JAGTkQVRbu3R3POO86Bgfgo5psV6bboAMi6NA286bT8ueUTqUjTQ9y/AfKV0UISfpY2r08XF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tJ6tRGQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IGjGjqEA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tJ6tRGQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGjGjqEA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 22F20EC01ED;
	Tue, 21 Apr 2026 03:34:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Apr 2026 03:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756867;
	 x=1776843267; bh=QBC9pOuBG94zo/rDUWzqvXjfcEYYHqxBl0TbjQtWjNo=; b=
	tJ6tRGQ4IG6RdWXpL8r1yRH9WC6sWnNKrDzj1E6GDAWNoULMDqGzKFcxUYimgasL
	j7dBFyZLvb+BSlGmd8w4qPXtTz40X2cg0nltyv5reGCAe5CQdKhNed5mc+IztH8G
	YL7UWOt1y8bpb1/P7wf/1qnBKUtkjIw6k4BU+Ljak4n5KAJ7wScDE5mq4mgN/Tsq
	R238zAT8QvWiXtAmd5nlmmOaKjZBzmXVIyWmF/fi3bZ0xPjxEJjKB2AMDeN3Bjkf
	Xk9N+CDdPDykNgK0N4mBYMPO+t/AmkaNFTP2XKsLlop7cVYXx5A1PHS5s8LNWcIg
	yFO/ZjUXGSGLEI2pLHWe5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756867; x=
	1776843267; bh=QBC9pOuBG94zo/rDUWzqvXjfcEYYHqxBl0TbjQtWjNo=; b=I
	GjGjqEAzyuC8gSVOxAzJmtitTnA2smF8ds2Dz2viyFIA/V1VLybBeahMrkUGgncd
	fZDOzQGEqLZccqZed/fDTD83M+U+YT+EVNB8NMmQqG1QCy6gP277BDHZ0dJl+0Mk
	hi/kG1PRDiMJkIOyTaz3sbnzUtw8CJD9kft05Eps4dP2kXj/iTt2xIMxaJtSoeGW
	VUdIFNq7uTxNnylBLEuVniE+zXNB2xOTYzrx3DhXp7XWG61nmpgCXW01P6eAiQfr
	rQ2Mcxeex75dJkUnPO0tbPJF1AByNZMIeW44jGaET46Pruju3IEC7TLJ5jnZZvm7
	LUdBUnzxKhN+yoV9907jQ==
X-ME-Sender: <xms:gyjnaU4YC6fVpIm5H00RsxrDEXh1YT5THQ4AlpuUZ-sj6zl87cE4cw>
    <xme:gyjnac4tpoZ6e03CqGR0AEOesfP0CeaW3wCSkj09D5UCSsCDPcK89gojLVN3kaGvL
    qj4DLrzjWYv4jLnHXaFFqc9Z-fUX6gT0mslgg1v_5UG0s1JVt6zdQ>
X-ME-Received: <xmr:gyjnaYeiuu1jx0tKmB6XGjb2zwdszTsNNr8jVTbOD398wMsZsCNB2Phq2u7hqRVi0nonh-U0iALnyhPbSzlJbBYYyYDKPmClNW5r0aOQ8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:gyjnaYCLEKZjxCnUpr05VFeDa9NWiCuPMId-npJIa8MD8DI7bU3W4w>
    <xmx:gyjnaT-bodkU3L4nVmk5Hx6sW7EWhX2SHGHNMevT71YAP6DYQmAUCQ>
    <xmx:gyjnabIB9OmI5bBoXsz5FgI9AMG_nra8mQ8T-VslOcvStQKI-L3DfA>
    <xmx:gyjnaUi4bUq8H2QA_gCAadvsZQQcVJzZ4NX79tQN2LNlDdu8wcvtgw>
    <xmx:gyjnaSI94cU1vsELLS-rd97K_T_cM14u-UWLtEstpJ66CzOc3bPjf-Hu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 05b055dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:16 +0200
Subject: [PATCH v6 03/12] t: prepare `stop_git_daemon ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-3-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

We have a couple of calls to `stop_git_daemon ()` outside of specific
test cases that will kill a backgrounded git-daemon(1) process and
expect the process with a specific error code. While these function
calls do end up killing git-daemon(1), the error handling we have in
those contexts is basically ineffective. So while we expect the process
to exit with a specific error code, we will just continue with any error
in case it doesn't.

This will change once we enable `set -e` in a subsequent commit. There's
two issues though that will make this _always_ fail:

  - Our call to `wait` is expected to fail, but because it's not part of
    a condition it will cause us to bail out immediately with `set -e`.

  - We try to kill git-daemon(1) a second time via the pidfile. We can
    generally expect that this is the same PID though as we had in the
    "GIT_DAEMON_PID" environment variable, and thus it's more likely
    than not that we have already killed it, and the call to kill will
    fail.

Prepare for this change by handling the failure of `wait` with `||` and
by silencing failures of the second call to `kill`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-daemon.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index e62569222b..d172aa51f0 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -85,14 +85,16 @@ stop_git_daemon() {
 
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
+
 	kill "$GIT_DAEMON_PID"
-	wait "$GIT_DAEMON_PID" >&3 2>&4
-	ret=$?
+	ret=0; wait "$GIT_DAEMON_PID" >&3 2>&4 || ret=$?
+
 	if ! test_match_signal 15 $ret
 	then
 		error "git daemon exited with status: $ret"
 	fi
-	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
+
+	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
 }

-- 
2.54.0.545.g6539524ca2.dirty

