Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A443AB2
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162537; cv=none; b=XhWIfriEj2CU9bpI7+od9Z3FijUnDHJDCYPy/lNkEOqnADNbd0uX/zmmaObOuxJFV+qdFIZf+HOMrh3QaHbDpZsE5YOwGQ+di+p1sxIlb/60z3gS8ufgDfV2RSmWHshTTgfkDSJCK0PP7s4P4yeICY0slb5961s8ZjYSsN8rsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162537; c=relaxed/simple;
	bh=8HemSDhkf0pk8YgbPSGvvE0Yc0sjrEMqMvhUANIuERg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp1qVR3iI+xR0M5yFN5C2R586yHiIKEGhfSPBvJZcSkA6YulMSqaVvsdes4kIPsRGb865hXhQQSCnSMA1XWzjznk/q6jsHnAwHoYmnVH1vXutvhV1tytNkHIYTRMofF9EYmUDeVYwjXy6X9W5c+/qVulU6+s2GNeI75tRPtqVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mn5uoFdR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBKVUfhP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mn5uoFdR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBKVUfhP"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D8CC911516A7;
	Tue, 20 Aug 2024 10:02:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Aug 2024 10:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162534; x=1724248934; bh=8QKVy0cCWt
	GjePaGzGjLO/H/4BcjmuVR0TfLB+Kdw6E=; b=Mn5uoFdRfjWm5hW+oElxs7vY6I
	2EaOPN8xybMymyNHHUHpJOjrKURJXaXOtgmywVOhKG5qN/dfGU9yXZdNZwshtg4r
	VYxT2zCuSTp8b3JdDmuxhR/6FOVbmFATlcOLMPRw0X0h5J4HUv9zG9KIGDQ6iAvd
	0qDSCT9yjTxH8qC9z2sJuR5wZPqx60lHdvMH6o5V9wQO0ifSwM9OzPhEr6yKSaJz
	THcRSGjMFNNFje8+nih2hwwpb9C8fX6GG0G1HXRUSk5w9JbKkq73ldSXogSot2bc
	b/eG0u1OtKHWZcbTovAnmkqmkht/W8wHhUoWPSe5pvnMwcBWpd7KIH0tpRsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162534; x=1724248934; bh=8QKVy0cCWtGjePaGzGjLO/H/4Bcj
	muVR0TfLB+Kdw6E=; b=PBKVUfhPZVcXDwzXD0KMEX7euQBXAQ7rSltpyfLgQUOG
	BgLCMMQomz1xFdk4nZJckWX/JhSC1gsnMNxJuHt8xsE3ts37U2ytDQbFyWbX/fsi
	wUUJletzfgZLelhM3HUby9A6JXwmKY3B83LRKYMxeDmP3ZcauCCp1RsVEk2qQU1v
	jtx5ILsPIr72coNUjZr54C3JhaSgmVxap6/YoB9GNzo0aq6FBNxK4YcD8UqwlT9L
	6V1kJglun0LXh4hHVyWXgN1pQAXigsEPrStIHohMhbFK6bETYD3iSNKvyBu9RTKo
	mk+Hv/Hou6ThdHLs5z0LEXHeN0awquVUibT0v6Lf0A==
X-ME-Sender: <xms:5qHEZgmLjgTOSjZkUyWlLojaU-o7R2BKvGhK-4wM986YEpLfeTpUBg>
    <xme:5qHEZv1k3UP5eN5uKKO5vXgDL_9ppvo6Op_tkzbvF9TefhdKZjaX5w-ZwVch9-vQe
    sKpLJb3QPhih_H9Nw>
X-ME-Received: <xmr:5qHEZuqlm0RMrmXOv_ZESPahmg9Jtj_jp2cLEAzr3bPxpIK2BMvbHVsosSoEKN-s_5bs95I4k72a4P9LvHT76tR-tMIYh3Sf1oAc1G0VWL9Bq_7kAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhr
    ghdruhhkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsphgvtghtrhgrlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthho
    pehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghthhhomhhsoh
    hnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:5qHEZslM8TFWSnUzPQa3VqJJoUrvQ3fISBDUoPsJ2WwoxFezufJt6g>
    <xmx:5qHEZu0LSmJB1OS9_m8zyUNNUvgRp8pWyWdCutk8G3BSmCZvPC5Qug>
    <xmx:5qHEZjueoGV9BmoNQkQXru8dw5KPB8m0ZSdliKYFFyNGIhLzxhJXyw>
    <xmx:5qHEZqXyjQ6tavTHykYuoRIgQtd8O3AtE0Ank0UlPRLWwfBmTPzNtg>
    <xmx:5qHEZswxB9m3fsRGnDvRXdvEN0y50HaCu81uXJFDo-7cs_tyEQ_sPIqM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b974306f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:01:41 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 01/13] t: do not pass GIT_TEST_OPTS to unit tests with
 prove
Message-ID: <e48a64611377b2ad49c7a1144612f8c001006d30.1724159966.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159966.git.ps@pks.im>

When using the prove target, we append GIT_TEST_OPTS to the arguments
that we execute each of the tests with. This doesn't only include the
intended test scripts, but also ends up passing the arguments to our
unit tests. This is unintentional though as they do not even know to
interpret those arguments, and is inconsistent with how we execute unit
tests without prove.

This isn't much of an issue because our current set of unit tests mostly
ignore their arguments anyway. With the introduction of clar-based unit
tests this is about to become an issue though, as these do parse their
command line argument to alter behaviour.

Prepare for this by passing GIT_TEST_OPTS to "run-test.sh" via an
environment variable. Like this, we can conditionally forward it to our
test scripts, only.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/Makefile    | 3 ++-
 t/run-test.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 4c30e7c06fb..d2212de0b78 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -68,7 +68,8 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
 
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) TEST_SHELL_PATH='$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
+	@echo "*** prove (shell & unit tests) ***"
+	@$(CHAINLINTSUPPRESS) TEST_OPTIONS='$(GIT_TEST_OPTS)' TEST_SHELL_PATH='$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
diff --git a/t/run-test.sh b/t/run-test.sh
index 13c353b91b4..63328ac630c 100755
--- a/t/run-test.sh
+++ b/t/run-test.sh
@@ -10,7 +10,7 @@ case "$1" in
 		echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
 		exit 1
 	fi
-	exec "${TEST_SHELL_PATH}" "$@"
+	exec "${TEST_SHELL_PATH}" "$@" ${TEST_OPTIONS}
 	;;
 *)
 	exec "$@"
-- 
2.46.0.164.g477ce5ccd6.dirty

