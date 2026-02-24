Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CF368267
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922758; cv=none; b=t5Rf/joye6A2Mq5/HyHhyIdESCQl7ehtGhdmfFBVaaRTUXKDJ1gDE8DApFGd7xiVgHV7ogdKzG1PmePs26JDWygQojP9UVJhk+0rj4bc3S5D1qKw1uFTl+ZOoFn/yi+niTMp3im8GOurC0678dyZv7/ApXtz4hhyBtroP6SHE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922758; c=relaxed/simple;
	bh=Ul+OCHyBftC1Tum5r645rHjlqCInxBTWEF/ToqXg5dA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7iP4+h9+uYIkuAr7oZkK02BhH9tOHBMZRqE8vAlDgd4J5KkSkd9AVYGBUXNoFjSj7w5tahadZotQ7C2iLGWL/MZlFhTun1cM5/JV8nebKHrdoKO/9MkwcByzxGahRySEuEHppQFjgV2ythhmiZelxpfE4JuRlUM2QSH+tSOc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=no1meHmY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=emZFVvZp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="no1meHmY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="emZFVvZp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D3B714001CE;
	Tue, 24 Feb 2026 03:45:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 03:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771922756;
	 x=1772009156; bh=OCKuVoby+B5qyfECRbd1Bn9Yda3IsVaC3QmeAl/8bG8=; b=
	no1meHmY9dQ0okdjPpwaxumXOLt1b/9gBlG23F4TCkWWmtiZJPRutdM2kqFlhIAO
	S7Rl9tmzQPfCu3IL2pPG7+H5d5m7RQs96AyLzcPKL41IdrgbSMEcF18ynnKvYpG2
	5UuIRpcJGD25wRjMkclnkU9vAPXC7SLLNVwiSK40tY75KSuhamE/kVEADy7K4mP3
	lH4FQHXwqZz3PcpCrNoeOicfyrvJSR/q/MKGk6q3EWdct1gcBNP4L8JT8sUQf9JD
	zGa3ivW0kWAhcMERoRcPUp4r26WJWfnlQ4ffDEAK8j7yvGzGVzE2D2AtJsJCF5JY
	iH2NYdpWRT7aCJw5mN07ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771922756; x=
	1772009156; bh=OCKuVoby+B5qyfECRbd1Bn9Yda3IsVaC3QmeAl/8bG8=; b=e
	mZFVvZpO/ZILGZ73Szs4mhZ3Tmhlc0YWZ6JBQooqMRLveCQzxunMZ5lad7OJFhY8
	AEKVFdz7Kj94d+VqqpjgO4PCo06D8njIpzZNoGYpNrTZFfmQk1wDN7l6A+ESfHZE
	kwkW6KQRfsJupufQW48gclGWZmc0lkgw5omCccNTtAf0IlCUlg1G3S8CcVf6SXIz
	E41xeiedAx1txRJUpBaJAD2PKY+rhZ22703evRyj76uOlfXT8cD/ipe9ypITTt1J
	DGBDcavFWVrjc7zmNA/n1yajvXcEBuvRTbJeeE5PmTFgBM49dmjZiuNxSY3pS78J
	uYZq5wXiGbnwFDeW/jN2A==
X-ME-Sender: <xms:Q2WdabHrpqA0Or2iIcyRJ8iHgiAmg6cy2qHVFJ35Xb1xTLS0XOTzXg>
    <xme:Q2WdafUgLofcvLQ05HMrfg42Sii2FYFK9ZvnGWvBGHDiNv5gm-UUfSy6b6YYtrz6U
    6Ly1mfFwBpTrZcA4vrVs_8a8z3DPMECU4lS4kjfD9tWgw_zqvmk_Q>
X-ME-Received: <xmr:Q2WdaSI0BkYRr4wp0aZnue7qjCOx7Fin3LJCMsXVrgdP3J02w-A-WCdlZtBd4hpoAmildqbrpdgDGKqoeH9M67VqcHW2Zsc170uXuhZ1rzSYCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeugeelgfffhfdvtedtvefgkeeitddthefftdeuhfehvdevjeekteeuleeufeefgeen
    ucffohhmrghinhepihhntghrvghmvghnthgrlhdqrhgvphgrtghkrdgruhhtohenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:Q2WdaX_M8sdnxQXQUZ05uQMGBbsBN1UOmhmycoptMJMa2A3KiqnCMQ>
    <xmx:Q2WdadJhcJrLYDwhL_JszfPFw-iuT3OR0rt_CgtaZ8FmQtTDK5uopw>
    <xmx:Q2WdaUmg6lHZ2H6uh5NNynVK5g8kZ7UP53Oq17APhJoU-nbTOxaYwQ>
    <xmx:Q2WdaZPoHkZYmN0z00n_WWq0YIrwK9fLQYFe7B61Xr_jLPmVOIJWeQ>
    <xmx:RGWdaUrQIj6kj4wwl0AZ_aaVfGgby4T4mIoEvim6qqoXdop5DAns1i9d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:45:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f2dfd05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:45:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Feb 2026 09:45:45 +0100
Subject: [PATCH v2 1/8] t: fix races caused by background maintenance
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-1-8657338c6fa1@pks.im>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>
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
option, as it would result in significant divergence from the "real
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
allows us to override the auto-detach behaviour and set that variable in
our tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 run-command.c            | 2 +-
 t/t5616-partial-clone.sh | 6 +++---
 t/t7900-maintenance.sh   | 3 +++
 t/test-lib.sh            | 4 ++++
 4 files changed, 11 insertions(+), 4 deletions(-)

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
index 7cc0ce57f8..fe344f47ee 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -7,6 +7,9 @@ test_description='git maintenance builtin'
 GIT_TEST_COMMIT_GRAPH=0
 GIT_TEST_MULTI_PACK_INDEX=0
 
+# Ensure that auto-maintenance detaches as usual.
+sane_unset GIT_TEST_MAINT_AUTO_DETACH
+
 test_lazy_prereq XMLLINT '
 	xmllint --version
 '
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
2.53.0.536.g309c995771.dirty

