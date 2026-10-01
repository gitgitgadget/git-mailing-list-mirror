Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562443F090
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833165; cv=none; b=HNx1yiz7An4YTHs3x0Uk4nsEJoIrjmSyveB2DbCSZ46cJ1HQi4yMA2RsdN1DKO8JXZCIoVAEQlzpczuplcj1HOVQqOa4zXE7zWovo6jzJw2yk3ZQ2OqpjbWPlIHNWVPiOkhEvActsmWWKi9kJVtN19wy+85zO8paek3nqydJjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833165; c=relaxed/simple;
	bh=e33QVOBdCxDlhzAFb8MzOgY5khm2Ld1ijisqK6UzpNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcXM5Uh3w3zm6NazSZF7dM+bdpj/FzFDoJzbujhbFds2KC+O3/v/It3zJ9sPThVumrFoi/kCm0/UtueK+nBX2lhIlyT80nBHn9/0osLA0NrC8CtPGF80glO7bpd5L5Uj7N7UtH5sGkVSoO9MogGRX9EuscC35a1LB7sBk3/G2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zz9Ea5ix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s2jtrAdy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zz9Ea5ix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s2jtrAdy"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C0C714000E1;
	Thu,  1 Oct 2026 01:39:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 01 Oct 2026 01:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790833158;
	 x=1790919558; bh=2U6kTqnDZHW+75AVMO8adNH8Rx5tdi3eFPiP5BLYLfU=; b=
	Zz9Ea5ixMdiDfZ81uOkpwnjsoQZRtfLONAQbnJoI0GkiTalaHOnn18OZE7YYTEj8
	IJYc3C7SR78xUL0spudAlR0kNHg6qQv+Wt8j/IPT/bTk1IVNSsdxDeWNMz4CmR+0
	5l4uwP2Ke9SHKn74/SImk/+e11OMo11xgdUAUl/XwB0GRYZ7dRewJf9P6W5DGjdU
	qMW29CHKjV7ZLUg/3ZOx/u24KIaEaHbC1IJ+dl0kU8fmhaGGOW2Eeex8Fc/JNJ4x
	wuOyl965GN5BpNqYzjbl5KTg90WrB/50SsTrHAwnoAzpJkLPIdVU5s3BsFSAax6u
	V4+qecAHgSFAf5tjUi4t3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790833158; x=
	1790919558; bh=2U6kTqnDZHW+75AVMO8adNH8Rx5tdi3eFPiP5BLYLfU=; b=s
	2jtrAdyjWEkxiLTTuVaMnDfZ9ayzYMI6S/lCrMz9oGpqtTpDZD6icCAQQOfAY/3k
	07gINtnyU6jpX8psIV29Ki4nCHk1NG9aPatEof9/fE8tMXaUqUhT961hRVOldg+T
	Q9DEvMQmHCVz6yRMxrCbNc3X+80s/o3HLa1BuD3wF13sBUKVzpfCpejmJ7K9HgZU
	VHB/L9XmHfs5q46+fZLzm2YJJQF2ih1p4alGRS0LQx6PbDSs3vUZNxFinhpAX80w
	X1XhQ9Gz5KBuZKv1CbzVxKxeoBN/S0nJPqx4F881uxqhH9FVsdjqOnwlcuSxOqSF
	L+6gabTzUIbzrRKV4kf+w==
X-ME-Sender: <xms:BvK9ammh9ZUecQaqxsLpQCjsrfPJ3rrPvrGME4REGrjSMlkp8fmiTQ>
    <xme:BvK9arodhjx13WlLcn1hst318RTNLlPcMgj_U7ERH34M0u1upbFLVOCkSTs8FjxVe
    KbXYX2xf6vd2ZRk-nLX9W4k945x0d-x8PrrNOJuUr5-VMq4eCtK-jc>
X-ME-Received: <xmr:BvK9avH5iKR5uZMd2dL6_sM90dokYJlWUI2Y98RdrQvBcO-qNP1VqjTFTjfVZVE0UIpdzA>
X-ME-Proxy-Cause: dmFkZTGIkKVdMarSAY4xW6yDam7TpuznlbXDDdynjc5Pvdxkql0eaW81iqkeTIDr57n18D
    Qf+hY8KXhZFfu1rkTLS8gEkLFaYXtoNacbrSzp858oJpmLKA/U4F9KEXt5Bbhkwtj/OGfx
    gEm1opbaTXksonW6Oma261aZyGGsyHPFcGq41BoM2GiU2AhW7LTGsgTnJmrjin1yXa0gnD
    n/iVbiEkqn7rqU6WJIMYpRhh0tFIhyjtP8gKihOqWVIQvcW8h+8Ek6UF1POoE0kbNvAi3g
    RhSccRA5Kvl8TbxfUp1tN3eF0zUJ7poEtJEGLbsSfl+G8OPWA9Q8BH50r4okzyNklXDeRP
    5v+z4Yci+st0ajReiSzJpw++b91Vs8H/WoDWDzOkIsKkFACz9EoX5ASMao36qrcl9zkkVB
    85LkP3lKpUYNEcUVS6SuSdgmo8qV4EUQx1sjzq3ySfTZ7YJZUXaxotn1XOPJyj2USvVNk1
    c8owPuLATaWyTPRG4v6AHk3bb2b9WCQHS5xPwBvC/QlmCMUDBfRye5fp+qcBnp6qSYqVHM
    O3gV7LjhYtyKWRWwquMF1KxuR41R6x0BEBQ5OqT/1QDgMsfZLQ14jmec8GH3PjuKNgo9NR
    0sCOTTQs90JxGvEchP9q794e5cwvvQ9ncgCWa43TH1yhOjuw7lv/pp1P9ygg
X-ME-Proxy: <xmx:BvK9anw_o9WaDgu6Dfjb6p6r-WA_PwJxNqZuSvaD7Fb1HViyVvW7gw>
    <xmx:BvK9akqDxjf3Lu2lGD0ZHN3_Lp-we7KLH2xakIa1kRVIgVFQVh80gg>
    <xmx:BvK9ahhJ32hVyrVg8YZgTc2R1YT7bIVEZJNzt9MtoDlCu70XmGF6aA>
    <xmx:BvK9ahhC8Bf63q2DVj6Yvv5cGnSyU39ueQU7lRFppCdLbcKcL8G-NQ>
    <xmx:BvK9aoc3YX0ivXPKA66s3maScz-B0W50oSwbCLV9_mzviFt0P9zIRSeY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 01:39:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92641793 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 05:39:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 01 Oct 2026 07:39:02 +0200
Subject: [PATCH v2 3/3] refs/reftable: fix on-disk representation of reflog
 timezones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-pks-reftables-fix-timezone-format-v2-3-a4fd1f7cd21a@pks.im>
References: <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
In-Reply-To: <20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
To: git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When writing reflog entries to disk we also record authorship
information for the reflog. Besides the author name and mail address,
it also contains the date and timezone at which the record has been
created.

The timezone information is typically encoded in the "[+-]HHMM" format,
and we often pass it around as parsed integer. For example, the timezone
"-0700" would be passed around as -700. And this is also the value that
we eventually store in the reftable on disk.

But the specification in "Documentation/technical/reftable.adoc" notes
that the timezone is a "2-byte timezone offset in minutes (signed)". So
instead of storing -700 in the above example, we have to first convert
that value into minutes and then store -420. We don't though, so we have
a mismatch between specification and implementation.

Ideally, we'd just adapt the specification to match the implementation.
But that's easier said than done, because the specification is 11 years
old by now and reftables have already been implemented by JGit for a
long time. So if we now changed the specification, those libraries would
have to make a backwards-incompatible change.

Another alternative would be to bump the reftable format version, but
that feels suboptimal, too. Other libraries would all have to adapt, and
it wouldn't really help us to fix the discrepancy between alternative
implementations and our implementation as older versions would still be
misinterpreted.

The only viable option seems to be that we simply treat this as a bug
and fix it. This will of course make us misinterpret older reftables
that already exist on disk:

  ┌───────┬───────────────┬─────────────────┬────────────┐
  │ tz    │ HHMM encoding │ correct minutes │ divergence │
  ├───────┼───────────────┼─────────────────┼────────────┤
  │ +1400 │ 1400          │ 840             │ 560        │
  ├───────┼───────────────┼─────────────────┼────────────┤
  │ -1200 │ -1200         │ -720            │ 480        │
  ├───────┼───────────────┼─────────────────┼────────────┤
  │ +0530 │ 530           │ 330             │ 200        │
  ├───────┼───────────────┼─────────────────┼────────────┤
  │ +0000 │ 0             │ 0               │ 0          │
  └───────┴───────────────┴─────────────────┴────────────┘

But this divergence ultimately doesn't matter much, as Git only uses the
timezone of reflog entries for display purposes anyway. We don't take
the timezone into account when parsing "HEAD@{1.hour.ago}" syntax, and
`should_expire_reflog_ent()` doesn't use it either to decide whether
reflog entries should be pruned.

In summary, the fallout from this change is quite contained. Adapt the
reftable backend accordingly and simply reinterpret the timezones with
the specified meaning.

Add a test to verify that we properly encode the timezone as offset in
minutes. Adapt the test helper accordingly to no longer zero-pad the
offset with "%04d", as that can be easily misinterpreted as the "HHMM"
encoding.

Reported-by: Josh McKinney <git-bugs@lists.joshka.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  7 ++++---
 t/helper/test-reftable.c   |  2 +-
 t/t0610-reftable-basics.sh | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 10db03991e..d0de066355 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2,6 +2,7 @@
 #include "../abspath.h"
 #include "../chdir-notify.h"
 #include "../config.h"
+#include "../date.h"
 #include "../dir.h"
 #include "../environment.h"
 #include "../fsck.h"
@@ -317,7 +318,7 @@ static void fill_reftable_log_record(struct reftable_log_record *log, const stru
 		tz_begin++;
 	}
 
-	log->value.update.tz_offset = sign * atoi(tz_begin);
+	log->value.update.tz_offset = tz_to_minutes(sign * atoi(tz_begin));
 }
 
 static int reftable_be_config(const char *var, const char *value,
@@ -2186,7 +2187,7 @@ static int yield_log_record(struct reftable_ref_store *refs,
 	full_committer = fmt_ident(log->value.update.name, log->value.update.email,
 				   WANT_COMMITTER_IDENT, NULL, IDENT_NO_DATE);
 	return fn(log->refname, &old_oid, &new_oid, full_committer,
-		  log->value.update.time, log->value.update.tz_offset,
+		  log->value.update.time, minutes_to_tz(log->value.update.tz_offset),
 		  log->value.update.message, cb_data);
 }
 
@@ -2690,7 +2691,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 
 		if (should_prune_fn(&old_oid, &new_oid, logs[i].value.update.email,
 				    (timestamp_t)logs[i].value.update.time,
-				    logs[i].value.update.tz_offset,
+				    minutes_to_tz(logs[i].value.update.tz_offset),
 				    logs[i].value.update.message,
 				    policy_cb_data)) {
 			dest->value_type = REFTABLE_LOG_DELETION;
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 57758936b0..d9f2ca1d0e 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -163,7 +163,7 @@ static int dump_table(struct reftable_merged_table *mt)
 			       log.update_index);
 			break;
 		case REFTABLE_LOG_UPDATE:
-			printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
+			printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %d\n",
 			       log.refname, log.update_index,
 			       log.value.update.name ? log.value.update.name : "",
 			       log.value.update.email ? log.value.update.email : "",
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 35e98b43db..2253705a19 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -837,6 +837,41 @@ test_expect_success 'reflog: renaming branch writes reflog entry' '
 	)
 '
 
+test_expect_success 'reflog: timezone offset is stored in minutes' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		GIT_COMMITTER_DATE="1234567890 -1200" git commit --allow-empty -m min &&
+		GIT_COMMITTER_DATE="1234567890 +0530" git commit --allow-empty -m east &&
+		GIT_COMMITTER_DATE="1234567890 -0830" git commit --allow-empty -m west &&
+		GIT_COMMITTER_DATE="1234567890 +1400" git commit --allow-empty -m max &&
+
+		# The reftable format specifies the timezone as the offset from
+		# UTC in minutes, whereas Git uses the parsed form of "+HHMM"
+		# internally. Verify that we do the conversion when writing.
+		for table in .git/reftable/*.ref
+		do
+			test-tool dump-reftable -t "$table" || return 1
+		done >dump &&
+		sed -n "s/^log{refs\/heads\/main([0-9]*) .* 1234567890 //p" dump >actual &&
+		cat >expect <<-\EOF &&
+		840
+		-510
+		330
+		-720
+		EOF
+		test_cmp expect actual &&
+
+		# And verify that we convert back when reading.
+		test-tool ref-store main for-each-reflog-ent refs/heads/main >entries &&
+		test_grep "1234567890 -1200	commit (initial): min" entries &&
+		test_grep "1234567890 +0530	commit: east" entries &&
+		test_grep "1234567890 -0830	commit: west" entries &&
+		test_grep "1234567890 +1400	commit: max" entries
+	)
+'
+
 test_expect_success 'reflog: can store empty logs' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&

-- 
2.56.0.353.g0856645cf6.dirty

