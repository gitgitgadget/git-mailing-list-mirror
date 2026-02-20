Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DD33A70F
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582529; cv=none; b=LMb8wyX27WElv5/VTGbMykahpWRDWJqLCswdrOWR8xsTOzwxtEqwQ5bL2vgn9/otiKbAemFW5gYp3P9/Cf3Q6Mw6caa4mHAb0Pin1HDV8ksVU7WuB6SDxc6rcLoNpnQcNQdAY8xnT3yWvdXqOYeXFD5XB9KkyFlHNfaY3fyOY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582529; c=relaxed/simple;
	bh=3XIHTEjul41xGHiQLzaHZgVohuiwi6PhYCRYTVRL+9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqyf4RRAu4B8ahWt5K93AuKpDofEyxqoLhBDTjVTgmhunP3HjgzrjqOmC9JjWPopW6ikP9+Z2Q/cfzPG/X636PwYtl6v6vHVm9AqKHvEOgtPuSUZtwL4N8k0MXIYaHx+OcLOTlkunSvA/4M6i3LmE/PMR2dPM8dfHwgb+78C/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e5fYx/p5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Efw8bwRh; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e5fYx/p5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Efw8bwRh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C8BE7A01BB;
	Fri, 20 Feb 2026 05:15:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 05:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771582524;
	 x=1771668924; bh=DM6fN4TH6pQ3Nt2+Gw74wBdcgfz+I9bpPEEh3SqLr6M=; b=
	e5fYx/p5r6WMhUcjJsATgg/YcZaYRbwCiXm5UlsG9Kv1UxaKQ7nKJU9n58qbPhco
	a8hKcU78I41KeyBtGjOkl8lVZoFO3L2rrQVBhuKJiyZwAZASfOw4vFfWeK/yFgtG
	O+7dtxMXVQsSU2pBwkVuq2Z4h4+5NjgT/xu1p4oSuKRP3oi3dOoHAZwzLOGLawgn
	TVkEK5Z17CTf+V54hPes9NmyvE8d+4CXyXC22jB3Gs/t0mf4wxs5BkYCVZHiTh6k
	anaaZXlIbM7lecCH55Nk209pCbP9W/AoEeSqGxCSyXhmSJGOIGwi6Td3DRJ5Lw+h
	zGP/WlLbeV4SKXtYyy4e/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771582524; x=
	1771668924; bh=DM6fN4TH6pQ3Nt2+Gw74wBdcgfz+I9bpPEEh3SqLr6M=; b=E
	fw8bwRhMHDKUaibxpYXKXocqepQCbf/Fb7/9Hlj280WeHWEsbOJ6dZczThcOxFfN
	VShiAIg/0SOqF/sVVefG1kwZkyRrs1Mst3HMb2geiUNBf/wPjs9iG5N2SLayhBPs
	OZEb5hA56dfYTkkqoeUhhid7JPu+B7k1QPXH9ChLtCmrkKgFQ+cae/Xyu9/HVKHz
	9/tiG6mfScD1PHRBf+6OPRVKE/qLMCJJznNjepau4GcTFW6Zx4KwUgl8AMdH4EWk
	Weq2nWwguG2LuTCzx5FWruQRDpkV3OgLGqSquSz0zUETI7vlCLLlTWdvxv8nRVF0
	jwDMM2lNa7GD+DORlZEqw==
X-ME-Sender: <xms:PDSYadnAQ5snT6HrNvNNw3atdSS_fPBsLZzATQt-EHc5ugCOHnMooQ>
    <xme:PDSYaQQK-qI4zRRfCTQntQsPQxW8DjOmwLAxr7uqhmZneg7fQdzpEcIUZ8tvVE50b
    Uj1Of2mMEewI6T5UrMAUveivD6DmmpnNFIEPjf5LEzczwigSOi_3iI>
X-ME-Received: <xmr:PDSYaRDko_H365z2vIc-pgZRPztvnBFK8yxHj8VnWRFSzKE7Gk-ivxxXFyD5qrWbUUJ27LMZZyIbZXiHnf6LuQJMNbvxU48hXeQ9Y_4xe-s8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeugeelgfffhfdvtedtvefgkeeitddthefftdeuhfehvdevjeekteeuleeufeefgeen
    ucffohhmrghinhepihhntghrvghmvghnthgrlhdqrhgvphgrtghkrdgruhhtohenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PDSYaXT-OCma4i-3Zq1pOEdfslK-22JcyPiw88z0i094WLTeEJPH6A>
    <xmx:PDSYafoKMlfY4_cBjF1x0H03ooMxhhK_sgZD6zRFVuwstSv4Y7KXfw>
    <xmx:PDSYaZzJNAs704988hFA7vI27-T9ZNWEEGY1r0lFF0wT6WOugJGt1A>
    <xmx:PDSYaUIJP8QCTNisxtORsRaEYrMtOHF9qb-V6Z9nc4IW0gMtZ5aTSQ>
    <xmx:PDSYaQux82Lp6lvwiqNl0oFDeOST1fRV5oBznqXK5IUs8BNSlgQE6J8M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:15:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3c58676 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:15:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 11:15:05 +0100
Subject: [PATCH 1/8] t: fix races caused by background maintenance
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

Many Git commands spawn git-maintenance(1) to optimize the repository in
the background. By default, performing the maintenance is for most of
the part asynchronous: we fork the executable and then continue with the
rest of our business logic.

This is working as expected for our users, but this behaviour is
somewhat problematic for our test suite as this is inherently racy. We
have many tests that verify the on-disk state of repositories, and those
tests may easily race with our background maintenance. In a similar
fashion, we may end up with processes that "leak" out of a current test
case.

Until now this tends to not be much of a problem. Our maintenance uses
git-gc(1) by default, which knows to bail out in case there aren't
either too many packfiles or too many loose objects. So even if other
data structures would need to be optimized, we won't do so unless the
object database also needs optimizations.

This is about to change though, as a subsequent commit will switch to
the "geometric" maintenance strategy as a default. The consequence is
that we will run required optimizations even if the object database is
well-optimized. And this uncovers races between our test suite and
background maintenance all over the place.

Disabling maintenance outright in our test suite is not really an
option, as it would result in significantly divergence from the "real
world" and reduce our test coverage. But we've got an alternative up our
sleeves: we can ensure that garbage collection runs synchronously by
overriding the "maintenance.autoDetach" configuration.

Of course that also diverges from the real world, as we now stop testing
that background maintenance interacts in a benign way with normal Git
commands. But on the other hand this ensures that the maintenance itself
does not for example lead to data loss in a more reproducible way.

Another concern is that this would make execution of the test suite much
slower. But a quick benchmark on my machine demonstrates that this does
not seem to be the case:

    Benchmark 1: meson test (revision = HEAD~)
      Time (mean ± σ):     131.182 s ±  1.293 s    [User: 853.737 s, System: 1160.479 s]
      Range (min … max):   130.001 s … 132.563 s    3 runs

    Benchmark 2: meson test (revision = HEAD)
      Time (mean ± σ):     129.554 s ±  0.507 s    [User: 849.040 s, System: 1152.664 s]
      Range (min … max):   129.000 s … 129.994 s    3 runs

    Summary
      meson test (revision = HEAD) ran
        1.01 ± 0.01 times faster than meson test (revision = HEAD~)

Funny enough, it even seems as if this speeds up test execution ever so
slightly, but that may just as well be noise.

Introduce a new `GIT_TEST_MAINT_AUTO_DETACH` environment variable that
allows us to override the auto-detach behaviour and set that varibale in
our tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 run-command.c            | 2 +-
 t/t5616-partial-clone.sh | 6 +++---
 t/t7900-maintenance.sh   | 1 +
 t/test-lib.sh            | 4 ++++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..438a290d30 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1828,7 +1828,7 @@ int prepare_auto_maintenance(int quiet, struct child_process *maint)
 	 */
 	if (repo_config_get_bool(the_repository, "maintenance.autodetach", &auto_detach) &&
 	    repo_config_get_bool(the_repository, "gc.autodetach", &auto_detach))
-		auto_detach = 1;
+		auto_detach = git_env_bool("GIT_TEST_MAINT_AUTO_DETACH", true);
 
 	maint->git_cmd = 1;
 	maint->close_object_store = 1;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 1e354e057f..d62760eb92 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -229,7 +229,7 @@ test_expect_success 'fetch --refetch triggers repacking' '
 
 	GIT_TRACE2_EVENT="$PWD/trace1.event" \
 	git -C pc1 fetch --refetch origin &&
-	test_subcommand git maintenance run --auto --no-quiet --detach <trace1.event &&
+	test_subcommand git maintenance run --auto --no-quiet --no-detach <trace1.event &&
 	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace1.event &&
 	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace1.event &&
 
@@ -238,7 +238,7 @@ test_expect_success 'fetch --refetch triggers repacking' '
 		-c gc.autoPackLimit=0 \
 		-c maintenance.incremental-repack.auto=1234 \
 		-C pc1 fetch --refetch origin &&
-	test_subcommand git maintenance run --auto --no-quiet --detach <trace2.event &&
+	test_subcommand git maintenance run --auto --no-quiet --no-detach <trace2.event &&
 	grep \"param\":\"gc.autopacklimit\",\"value\":\"0\" trace2.event &&
 	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace2.event &&
 
@@ -247,7 +247,7 @@ test_expect_success 'fetch --refetch triggers repacking' '
 		-c gc.autoPackLimit=1234 \
 		-c maintenance.incremental-repack.auto=0 \
 		-C pc1 fetch --refetch origin &&
-	test_subcommand git maintenance run --auto --no-quiet --detach <trace3.event &&
+	test_subcommand git maintenance run --auto --no-quiet --no-detach <trace3.event &&
 	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace3.event &&
 	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"0\" trace3.event
 '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 7cc0ce57f8..d11d6f8f15 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -6,6 +6,7 @@ test_description='git maintenance builtin'
 
 GIT_TEST_COMMIT_GRAPH=0
 GIT_TEST_MULTI_PACK_INDEX=0
+sane_unset GIT_TEST_MAINT_AUTO_DETACH
 
 test_lazy_prereq XMLLINT '
 	xmllint --version
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fb76f7d11..aa805a01ce 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1947,6 +1947,10 @@ test_lazy_prereq COMPAT_HASH '
 GIT_TEST_MAINT_SCHEDULER="none:exit 1"
 export GIT_TEST_MAINT_SCHEDULER
 
+# Ensure that tests cannot race with background maintenance by default.
+GIT_TEST_MAINT_AUTO_DETACH="false"
+export GIT_TEST_MAINT_AUTO_DETACH
+
 # Does this platform support `git fsmonitor--daemon`
 #
 test_lazy_prereq FSMONITOR_DAEMON '

-- 
2.53.0.414.gf7e9f6c205.dirty

