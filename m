Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A42EEE84
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179999; cv=none; b=fAU8t/IzSYE9r+Q51u4A7ffLy3Lb792le70GDAMWKQKZT90QhZRgBHzi8N/COdBT+R6qNx8/z954F7in0Tow8nWuIJ7dwReQB5C8sxpkM+wPN+nbxpAoG6KMElAzYxkp/uh2RZSb88KrgYadu4TKAAFG4JJ1aiC2GNd3e0caydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179999; c=relaxed/simple;
	bh=7dYjlFPBDOtmyVPrA4JTBUTvC1yUhOryaJIUJJBa+wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqJ+sBfG2LUttf6AGg35ABoLaQLp+RTlgozroHHgDdGj3FWRvg43+1QPTfoXeto6S+A2Fe2my/dzmh4izVGBGATbcreGmg/cTAWf6rm/Tjj29QWcBsRfix/TZ6+O/VcrL/bMe9+x4aoYRz3NQd4gcB/ymrPznLCgj9LzY6GwaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QTqCTdgA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y46aNCLm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QTqCTdgA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y46aNCLm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DF7FA1D00109;
	Thu, 16 Jul 2026 01:33:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 01:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784179997;
	 x=1784266397; bh=ES/ZZOQA4rUPqj1XR8NLwlDmG+0sByFRyUZtHJ7s/fI=; b=
	QTqCTdgAWx9bjSGkH7Zu34Mu1nT2Ro3E0P90xEAS7qZxEx4jqyaaEIhBI5wyZlBJ
	fKir/DuTP3nRGRmwS1rnl2TZQ7KoFcF/SuZCT26B+gpBKssqYiKxQk+ucLPYNZXw
	03s9160ox2ZYuYjX71QC/zQwff7rJN+fcnZf3LGgwn/KpEE3V9c74ZXGTRB/5DWk
	VtsbATr76HAv1E6FvFcZgdxYDUrumflkRkWMW1iTBHzPPZ5sU+Kgyp+4Bs1ApoQ4
	rtM6Xst5qtFP0HmmhawSIMRnmcoUXFCGkpaDZiz3S0MbZdCeN2tIPBYUQVSa4rel
	soMqW9VeVg+BV29PlB2Y3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784179997; x=
	1784266397; bh=ES/ZZOQA4rUPqj1XR8NLwlDmG+0sByFRyUZtHJ7s/fI=; b=Y
	46aNCLmB+QwpYObg1KbYq0c3AlsTn+2iCLmXyoYC41llSt2Y9tbRfmG+Lb9wNrD2
	j73FuCp0ZimaP7nuv2h77OCCrxXd8v13l2Xj/Qtbhztt9HHhGWEifkE42nh+Foln
	hdZIJYe1l0H+DRH6HTjRzF9KhJK92zfCVe32iXRldFK3WocG6IWjuOG98XcbIplF
	aQxI/1mw3VgTgGDm8jH1JFVW6oYq64972UJpZpamyBvSr3XuMwW99s4n+iJ5jtm8
	Il4ZCnU+PE6Pk6AYG6hlhp69LK8PYPH4zCgzvqvyImyAfB8WFg/76DIgaVJScYWi
	M/DQkZ7wIR8FGtpMGorkg==
X-ME-Sender: <xms:HW1YanzL-SC0Xyi2NU2kZNfZ3N-Qda8BrNW-v99ER8l-3rXlTHkiOQ>
    <xme:HW1YamsDT0ekuLUmnFSZ4FYKlkO79YklaRVVY19jlmWaGfQsZ7FRumc1zBJwqtn69
    cBxLMwQ_yNjvT7OSbnVzDoiuL_VWyx0E9uaVOrUS3Kf6WQGmJainw>
X-ME-Received: <xmr:HW1Yauue2H6UqxQ6_d9xINQrlDNqKBwvfqExer_kEvIga9n_wxmBfJLAGP4dd3bpk4bT17nZnwMqtvHSbiiAM8tGeao4e7kjGVjRiIcN>
X-ME-Proxy-Cause: dmFkZTFCZM58uO+Kjntqg7FYkdfh2sutn/6CYbY0CX4sL7h3JLIZ8cA69dC/WfCY/OghO8
    zFZCLaL0gPhNr4gRRsDnJysGUj66DnmbHTCOXZssZsgxpvzllW4lO4l93QsCMT1ZWvy5Y9
    UZZJtE345TGfnsqk9aLpG8k65/sfattnbWJnCnB6WW75bQHA2fWpYz+EDXG9Hvwdw7ZjCu
    hAIOchxh8Pud7ZfkRkt4UGracxmb/6V7yIknPzisHkXCVXPd/pUmy7bAQ1Lrs8pf+vA8dV
    CN5WTxjy0v+s4UWNgCBjVbsi2ZMVyY4P++o7GWqPsf2FiKMrtv97Ov2YTNIaaBevHhbPKi
    oaN209xpMHZc7wXXbQUR9AzEkCDyF5V7X5HNzf/pfqZjkWnIS+QKwDsa5tNogNfb95sXo4
    jVnqdTdOE71Bksk+u+RnUeC4+uESq6wtDQMLqU/BoEaVMwTMYvjEF7l9I/zmhu8XtEH0wx
    iMFf0kcRhKj4o1BJ4xQPF0IYzkVRDban6xiqg9O2ZK60ElHzsNrE61Aa6nU5gAJXCeDwzW
    D2x6RMUEFG+vSmsSV9izP6GXhJWeWAPYit2m/+9g1WD6/nY5EjlSECSsAkIFZVZyomv+B1
    W+KlvqD1LKrav2pNgPHkyAA4+lAR+6PllaD60ckdgs3FkAnmtXAVPWujqF8Q
X-ME-Proxy: <xmx:HW1YarNPcdSw32s7NL2sbfgacZTr_5kx291NtSgo6HUIOXXikbK1uw>
    <xmx:HW1Yas08P18jCdeDorilF7MJkckhbQhuB_a8uQWfjnL6U6CK2GwQqg>
    <xmx:HW1YanOSGjyBrkUPM_286LC3uw0vAWCl21dUDy7pJpWFicVSa5T_wg>
    <xmx:HW1Yas22uqDUpoqFO12HCJlMP8A1rRccbOvTYrkuikmv90nIhZGRVg>
    <xmx:HW1YatVWXHPsWNn9ob2hDXSjiyL-24tXhrN05h5bk4Q2n24QCoil_d0d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 01:33:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97032225 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 05:33:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 07:33:02 +0200
Subject: [PATCH v3 1/6] refs/packed: de-globalize handling of
 "core.packedRefsTimeout"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-refs-wo-the-repository-v3-1-db0a804e0224@pks.im>
References: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
In-Reply-To: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When locking the "packed-refs" file we allow the user to configure a
timeout for how long we try taking the lock. This is configurable via
"core.packedRefsTimeout", which we parse in `packed_refs_lock()`.

The parsed value is stored in function-static variables though, which of
course has the effect that we'll only ever use the timeout configured in
the first packed reference store that we see. Consequently, if we ever
were to handle stores from different repositories, then we'd use the
same configuration for both stores even if they diverge.

This is of course a somewhat theoretical concern -- we don't typically
handle multiple packed stores, and even if we did it's very unlikely
that the user has configured different timeout values for each of them.
But still, this is a code smell, and an unnecessary one, too.

Fix the issue by moving the value into `struct packed_ref_store` so that
it can be parsed per store.

This removes the last callsite that still used `the_repository`, so drop
the `USE_THE_REPOSITORY_VARIABLE` define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 499cb55dfa..c5d96793fa 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"
@@ -162,6 +161,13 @@ struct packed_ref_store {
 	 * `packed_ref_store`) must not be freed.
 	 */
 	struct tempfile *tempfile;
+
+	/*
+	 * Timeout when taking the "packed-refs.lock" file. configurable via
+	 * "core.packedRefsTimeout".
+	 */
+	bool timeout_configured;
+	int timeout_value;
 };
 
 /*
@@ -1233,12 +1239,12 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
 				"packed_refs_lock");
-	static int timeout_configured = 0;
-	static int timeout_value = 1000;
 
-	if (!timeout_configured) {
-		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
-		timeout_configured = 1;
+	if (!refs->timeout_configured) {
+		if (repo_config_get_int(ref_store->repo, "core.packedrefstimeout",
+					&refs->timeout_value))
+			refs->timeout_value = 1000;
+		refs->timeout_configured = true;
 	}
 
 	/*
@@ -1249,7 +1255,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	if (hold_lock_file_for_update_timeout(
 			    &refs->lock,
 			    refs->path,
-			    flags, timeout_value) < 0) {
+			    flags, refs->timeout_value) < 0) {
 		unable_to_lock_message(refs->path, errno, err);
 		return -1;
 	}

-- 
2.55.0.313.g8d093f411d.dirty

