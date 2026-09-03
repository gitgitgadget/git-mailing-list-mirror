Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB741282F03
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397553; cv=none; b=tx76ElFVJdsfOPzMyQ7zYvuSCyqI9AQrcHZt7jnxHJCWVFZ8ucKC+YPNndgZb/duLHbscN1izoSs6n/8vGKbAzMMw6SL+xP55Rjw/B2UPxlvPVdpIIPPcWeseevYTDFOnPEgcKvaL55IInUc92bw6PZDyAeSGeIMnPwXKj28v+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397553; c=relaxed/simple;
	bh=fNr1WSMWmWNJHJXhxEzyBzJ382wMHl45TS/2pLFMJSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kd9MwTcOb0iDrKQau4Dn4LGfP8C1oxnr25cO5iP3CcIg3SEIQdVZwtV70iQDqLHPyo5835HG9y+wiBdjlZG5mrlAAUD/+fqbSl7q2Hpj7OtcZ98SAINtSVFl1FnA3FMCDo7eRzP5+Ni+WqShNR2MO1j3xeC6tMaoGFApByhgwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=F7T6sPc+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="F7T6sPc+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482e067e908so1516194f8f.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 18:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788397550; x=1789002350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZH4tyKcFwRFTHdyVW8dgZsVblaVXEEhNmoTOkr9BErI=;
        b=F7T6sPc+me0H+jkIJom7lHRkgOlnGMfOhiVwvDMTfyK434hIYa9hBVYV6ht+R6bsGN
         pYKCudhuz7NfV2igWA3KoTY6XTPHKY+Jsw+qW6ESvMJoD42J8ONdNIBLPTXgit6ZaiL9
         TNzTDUoXtKbCYHuTJm6zvj7N7Hy7zcQJYYiA+Xqtl0w185FWbDMgfLAlcDAFUFP6WwyL
         gQfBHx2YIKsgfLVBIaqLRC+MTLdyEG+kOEcKBuRNkaTnZUj7edqEuCVJ72KiyQ+ajR3g
         15Pujs3C/9mnqq4eiESkCIVp8AWn2PqNky2m8wamQ05miGG7lMHYnpKK2hx42PLPgh+8
         kpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788397550; x=1789002350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZH4tyKcFwRFTHdyVW8dgZsVblaVXEEhNmoTOkr9BErI=;
        b=mncYj9WZdjZwFxktOPtYgJOXKTaKMmiHf89hAfu6wbNFqD0/DXctpx0MhY6RzsEhJA
         CYffuyJbIpv6jU63WL7MQzhc2e/pznYJvrcMT0hpy/ATksE8UJ9IyfQ3ZrrbtTjw2OTq
         Lmr1sp/IqoAbDji3v+J+EznA8Gh47UMl4leKgOtJ0nNXJ+xiJtxpcI+mpn7IJbalT8l4
         smtPIRYDVD/ZjDmmZwccXWXlf8ipLSLG0Wkwe4Du7jEIu1k7Xz0lMhE50sT2Y4ByPSx0
         G6Ojk5N3izAyJgV3IN4mjw1N26Fv/3YSCyp4nKXSmaVpKW2zwORsGsSjYwUMLq2vFRN9
         j6kw==
X-Gm-Message-State: AFuF++n6gPsuet5Nzam6L7TZzG9FuX1DrWmbuhtGUuiia7DTbJefMV+S
	XW+P9BMFF2B/eUEX/9PgtRFViOucePKBsRqgn4hok/+CIiYXvdl8rWaHXipzWfNqHwi7rC90vuw
	iJx7YrS9chA==
X-Gm-Gg: AYBFou1QUrypl0ZXla1B6AstOXP4j0HECswJr4FFSF5aVP+6y05ZpQjImVoWfTUVQlw
	y80ai4RyAAxrAMeeiRfADb9Za117ul/zkmPnEAvqqf811hVh8d3pgE8/lwHEPEmm7FzgyFvofuM
	LIvrcCMO+pu2JcmopMsOx3vr5zuRe5fHwxpzA2OEThJ6zkctwnoDP+WVsfQKD8ucZ7me+B3qrr1
	nCcTDITCv6WGkl556m2bLA1dIog1R3RMyFEt+KppvP1296Vh11jhx9XYZ8U9+nwX4luQvuiiJ1B
	+kWlDB9HQ+9aBc6ps21mTAksWOicQGjUR8KX1eRV8q2gbIz1I1XePTmmy1WrvqG9f5LNfLRsg+c
	q7GVddtaghMp26fmSTf+4q1oz7RJMdDUllT9R9LOvJO+LajwSst4U5qh35j9cptDill1MrYywrc
	x3cJyyW7xpvHhSZUdr5arQtt+I4ecJlnmyxnVtQmusVEh7w665AsBXZyFr/zWG+jT6Wu3h
X-Received: by 2002:a05:6000:2f8a:b0:482:e64d:a1f7 with SMTP id ffacd0b85a97d-48488e0371cmr13650535f8f.11.1788397549946;
        Wed, 02 Sep 2026 18:05:49 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72df2sm10567110f8f.1.2026.09.02.18.05.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 18:05:49 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH] push: fix --force-if-includes when remote-tracking ref has no reflog
Date: Thu,  3 Sep 2026 04:05:47 +0300
Message-ID: <20260903010547.85469-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 99a1f9ae10 (push: add reflog check for "--force-if-includes",
2020-10-03), is_reachable_in_reflog() stops walking the reflog of the
local branch at entries older than the newest reflog entry of the
remote-tracking ref. That timestamp is read by a callback of
refs_for_each_reflog_ent_reverse() into a variable that is never
initialized, so when the remote-tracking ref has no reflog the walk
is cut off at whatever happens to be on the stack.

With the files backend a remote-tracking ref created by "git clone"
has no reflog and does not get one until it moves. On my machine the
leftover value exceeds any real timestamp: the walk stops at the very
first entry, never reaches the "Created from" entry that "checkout
--track" wrote, and the push is rejected with "remote ref updated
since checkout" although nothing on the remote has changed.

Initialize the timestamp to zero, so that a remote-tracking ref
without reflog makes the walk cover the whole reflog of the local
branch, as documented.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
Assisted-by: LLM
---
The new test fails without the fix on my machine (macOS, arm64). As
the value read is uninitialized, other platforms may pass it by luck.

 remote.c            |  2 +-
 t/t5533-push-cas.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 00723b3..6d30169 100644
--- a/remote.c
+++ b/remote.c
@@ -2751,7 +2751,7 @@ static int check_and_collect_until(const char *refname UNUSED,
  */
 static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 {
-	timestamp_t date;
+	timestamp_t date = 0;
 	struct commit *commit;
 	struct commit **chunk;
 	struct check_and_collect_until_cb_data cb;
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a8..77f46f3 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -396,4 +396,22 @@ test_expect_success '"--force-if-includes" should allow deletes' '
 	)
 '
 
+test_expect_success '"--force-if-includes" should allow forced update when remote-tracking ref has no reflog' '
+	rm -fr dst src &&
+	git init --bare dst &&
+	git push dst main main:branch &&
+	git clone --no-local dst src &&
+	test_when_finished "rm -fr dst src" &&
+	(
+		cd src &&
+		# a clone leaves the remote-tracking refs without reflog
+		# entries with the files backend, but not with reftable
+		git reflog expire --all --expire=all &&
+		git switch -c branch --track origin/branch &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		git push --force-if-includes --force-with-lease="branch"
+	)
+'
+
 test_done

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

