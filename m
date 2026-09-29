Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAB4FDA55
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675818; cv=none; b=NIFkKwwwOXe+D8TnN2j7hIIflQNJzyZP1NF65VomX07+KNABkIY0iPGoevQkTxcQsP7l7PUy8xZFiIDPErF1EZ2e/tch481sTYhQtHKqDSbARnRmHC4k3P9ALlETsaOTJbjVBYqSJij6HemR4KloalJIs1Jw7L/y4VAeLbNcLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675818; c=relaxed/simple;
	bh=6/dmOn8ThZuMisaWjniR72V1Au2M+8fzEcKdPlgoEdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rg9aeG9zlkcO1bZgwkWDoSBAZqCI2LjkWF6jLydTNsvdCRrnnE7DaXNBNWCH4T7XrvpJF9AcohgFMYpD6ue6AMjmIJ4qLOD3qHWmpL/DYjVmk+kt/RquIAEIFCqc1R5JE85dzsXllYzo+u3DSPDSBm0vNSJJRSFI4biaFahQ97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h2x8uuiN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EU5h644i; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h2x8uuiN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EU5h644i"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 49E051D000D0;
	Tue, 29 Sep 2026 05:56:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 29 Sep 2026 05:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790675815;
	 x=1790762215; bh=HAG15vaR9d8WpuqTKGKMeHmKVg9xFnUFX4mU/FrO0IQ=; b=
	h2x8uuiNEJPMpL64Koh0XmPZx1NDqBah/lR78CwNwBu1dRZTrHb8gwX1Aogx3v/h
	1ASkIgbIiNiLd2oP8Tt8d0GlsOSnSY1dY0TfWJnbe7Nte+f57CKdsaJTFpaLW+f8
	toQFVy3ROFSG1At4xYRgGMnUHibNKilFAm1qw14WxtQ02XSOna1OlO2hCWZ3jR3W
	uydmuBI+a4kWJ03q0e0mN+C37km1STdZgwqFZLRQyUxzEz1ZD6ScKTqUxfkzGyDH
	sTxR0HEnG74uLaOmJ51YfRPkx2DzVVcXXEHVDmp9BB2fnqOGWGqyr/Z6pqKi/+Y/
	kv9+Lb2YZyaeMW6tMNGMcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790675815; x=
	1790762215; bh=HAG15vaR9d8WpuqTKGKMeHmKVg9xFnUFX4mU/FrO0IQ=; b=E
	U5h644iJ+aZ1H72ctSU+z9hnTap8ZLlvAQdmaElBZKYddK6yTKaijWQ3PvOvKkRE
	AuRiXElxrhYeGIeUXUTzyo+8fsFk3gXJ2XoAMf0NL2dRYgiwEfOE6yRMr34WeaBC
	g+gViYn+eHqWQ6sMhl98+vWH6sCth74vez3rn/jUrlIKUKQ2gfco7NV4mwxkHf+f
	TNVw9IS3LHZzOEtmJrm7y+fG1QCIAIdsBCRk3Yd8XIYCmMZ0jrCEi0R/g3Fc2D6c
	EbURXijCJLeqFqPn2eyXuhAcv78TLH10Wzo7m5x53IYP5k/a6dPEP9zKW9GX9j7X
	VPiTo6qD74q70BBnKUWqQ==
X-ME-Sender: <xms:Z4u7ahbGD5K2UhEfbnXtq2tQLPOvibZTc3A4Cy7UpClbHx5rJ1rlmw>
    <xme:Z4u7agKfwfUkPm33bF_FCau56dOuodSQmkdt6qYDw_jWFio3QsklGgZBeWlwhuERp
    JS-VLitylbHLbEhOOAwrslxtSVRCO8h7Xr1WKLFkguWwX1Y4w-w3yw>
X-ME-Received: <xmr:Z4u7anD7hVQQ7tVUSGrSpPza0c_5C7QuMuYE1Ik-eHhpWsiVvkUF5Q>
X-ME-Proxy-Cause: dmFkZTFm8IiqzsptTc08zENQtaTh5Ug0w2zW0GK7uF4X2s8/R/WZ70FPl5csHZ5d0vowJL
    yXDl16IMAXqjvK0gwhKNrt5KdqurO6BTrJa0+/YNsN8+iBvBlrTbh/85oxA6xARNPwci51
    X0JVKEwlZDZHpeA8iKBwuVjRyBbFmGJSRH2PKHJ1+KMcOSCqJSJJhRDTGUQYg5DaT5axeb
    ZX/JAjX3FIe+HYsXmxJXvC/OLz76bPFXRqY0vgBmtkGNgsyT9KAgXPJQQcYP0OI2aYE4k1
    dGJQH+itI9Mj0jpUpoKcN3Cngc+R56Rkl7MfYDVXuxmPH27mZKHEioGEcIr1wUwJaDGrYV
    CSetD1dnEb+mlphoHnq4AFPbJsoSX3NgmFlKX7JGH0oaH6Q7RLl6giCrS3S4AsiVoBSJgH
    aAX33u0M5HEiwFFu3amZ/HLFrfPbzL1w+01dtkHEO3PP4uAR7NLXot4HN/TPghvyzAjxSv
    TpFxaY8VvgixiSvEBdqK/yFLlLDheue4Rt6esgWGWR9yVI254gZN70gmy6vfPeFsiKSjio
    CNCYHHJc7wbB7krz62zSWO4Tkf/9clonBIAUsTkRtgjr09Mpiiu9oKbX+d9p1q4MRjOIuk
    3qmVAc2k6v1mATN0JK/4ohdwvak03yqyfv6hDuWOOCVp1rsrxh2I1KI+Y4hQ
X-ME-Proxy: <xmx:Z4u7atovxFJmWojVMAmqCukwWuPavYaU55D60KV__MUnUjTGQSS_Mg>
    <xmx:Z4u7aqhFURfTw-GqpVLspTapbXgYNFFc7rnnDHbp2dyqKzAX8GikGw>
    <xmx:Z4u7aiBZPjxDrPYqikHdpXIy508iCcbfOgzbAIZzTAPj303-LDJNkw>
    <xmx:Z4u7anHACAIhawxuFkTzLQt9hEdWb1-BM32hm8MwMU-48pzeBZhCew>
    <xmx:Z4u7aktCuFoAUg_P2T7ByzNNOLCAAYBqYVaiglm5DSmOQ_uWVDm4jEDd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 05:56:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c7bb64c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 29 Sep 2026 09:56:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Sep 2026 11:56:31 +0200
Subject: [PATCH 3/3] refs/reftable: fix on-disk representation of reflog
 timezones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-pks-reftables-fix-timezone-format-v1-3-3df105a95ed1@pks.im>
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
In-Reply-To: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
To: git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, 
 Junio C Hamano <gitster@pobox.com>
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
index 35e98b43db..579657467d 100755
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
+		GIT_COMMITTER_DATE="1234567890 -0800" git commit --allow-empty -m west &&
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
+		-480
+		330
+		-720
+		EOF
+		test_cmp expect actual &&
+
+		# And verify that we convert back when reading.
+		test-tool ref-store main for-each-reflog-ent refs/heads/main >entries &&
+		test_grep "1234567890 -1200	commit (initial): min" entries &&
+		test_grep "1234567890 +0530	commit: east" entries &&
+		test_grep "1234567890 -0800	commit: west" entries &&
+		test_grep "1234567890 +1400	commit: max" entries
+	)
+'
+
 test_expect_success 'reflog: can store empty logs' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&

-- 
2.56.0.rc2.329.gd58861e689.dirty

