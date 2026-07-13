Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FA426692
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948675; cv=none; b=IK3H1j5E1WGW/aohiWQQgeGEI1X+io3U4jNg6r/6/VNqHsKaMdnodG4ubBCTWG2JoWPS5CwQZFMPjNrSQzK2B8XcMPPDbSDeBQNHXY5dRYypooyHyZTwaeCGeqdsz70Phm/irYAEmFWzkyaHPNmKFg2pqMpZdKzN5OMHlpPNtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948675; c=relaxed/simple;
	bh=5kTI6p6RWgDduCj+CW+4qqMyjJmy/gEEX35PFH0g+d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBUZcymDvfTUAkUDFSUoP2UkdXWkyOSwFsyjDBmRNO0Dh0LITe5e3Ktrb4bxGrvlvCJozGqHsKSspFPs6LTTdYFVnZSrdzrnR2kwXgeLR7UOv6PLROdpviEK+7v7Pfgoz0M2PNG/UiYtLfci2Bh1GxwB6DeNf8LjHREJp+KU5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pskqUWt5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pskqUWt5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso28421675e9.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948672; x=1784553472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IGk29DXiFE7FrLTksaAULMDMifmobVYebAyqdbHHBy8=;
        b=pskqUWt5AodbcHY+6Cjh34Xwq+aECt5/nyoQNEcQ2MPxwNihM9ejbFt4s0E0I13Q8a
         a2SskOyW4lQbNTllRrshWjabGbyBhREOAKRdhUWtaS8AJXhxsLWYVQXrcWAr8fVuE4RN
         64TQpzJfWy+wErixXC0AcIHfsO35lRyBvszTMqGHpSWmseVoHfEZZDXg3ZvM4UcS2cWf
         sxu41pAwRuWMvMuvxo992N0lCMzd5heiWIfsMYs0XkHFJKbj3w5uEwLQeYOh/nAsC4Vq
         EmNkWcpESnYd3tIahfNZkdpLtdTztyDSU+qW+ruNJMbBxxHDrUm4RF82CuwlJ0owLlK9
         9uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948672; x=1784553472;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGk29DXiFE7FrLTksaAULMDMifmobVYebAyqdbHHBy8=;
        b=G45mOaG1abU5h4f4B2EUqznvJqkbiQt1LclUpw/0vjIyOFvHjS8UceBEtF6sVPJvmM
         puQs1nGgEMZYuMgn6InatBOX2vmKrezt5bhCXvBVRNBxJWqWlPzICyix9yLSjyhPB7vb
         bRrC4Yud+aGZJokr/JqRlm0xMpbAFtYK3PcZB4qoGnw+mG/ThVaxi0yjIce2GLv5F8Jv
         F8DeD48xwZ2zRYsHQNjF1aZd+KEgTBvdSQQoX7RisKBV7VtQHQo+X1YhZbiAj5rg2Asc
         gvFGEFWRpRvai3l3Y2qdLv9CsPQ11jLzIFkpVUBHJ2SBZYFuRdBeirfUDMAvyeL/6Diz
         gQYg==
X-Gm-Message-State: AOJu0Yx8bDVteiKmxTDI95QIeKftnGRkQVge72V0IDFbRZ4rydSRBcdx
	9IFiY4jiQc1vNQ6ttqMaeqDkB1nrqt3V3/6vliOz3pW765xFLeDzxhDkNuaR0A==
X-Gm-Gg: AfdE7cnzi5mC3so9I63AG3hfViLfhbELdJVNTuWzTHo3p7/3xEiW8uPUG1ZMeUt58C5
	s50JUvjWG8vas3r92FNS4/tlLh//gPJ3eSDLoH2oF7VNvqFdCeap0DTJc4jMh4t0JBq3JWm0li3
	dHx2aWed0ncNsYc1Gnv8MN/TFQzUxI2GSMEbNC7dI6UqwJeknWKKUnzXNmzRWTylf1BpkvhiYbM
	TnhL0wGCqW/1dkN/K4+fh7s6n+j6Sq2Fr1956ujLeFOYntzjK8d5qpYxt2RlKDwv00wlYszy9Qh
	K0dfVoV5Q6M/e9/+fSl6Grwq0yCfeI+H+P5Xo89xvgh1YKagmE6cOZl1pi3crXSDF+myqnBumxi
	k/JW0X1CvqBGL0RAJHDPIzknFvOXDl9UGaCr7NZakDWgMQYgoyUl02JzmI6jBIn3gp/x8y61kVm
	9u6NoM0e7lIhYkPu3j
X-Received: by 2002:a05:600c:63d0:b0:493:af56:8e64 with SMTP id 5b1f17b1804b1-493f882e94emr67165755e9.32.1783948671876;
        Mon, 13 Jul 2026 06:17:51 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:51 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 10/10] sequencer: do not record dropped commits as rewritten
Date: Mon, 13 Jul 2026 14:17:27 +0100
Message-ID: <c89234dd949f59ce150f0fb5d7442e1f46e3fef3.1783948637.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1783948637.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1783948637.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a commit gets dropped because its changes are already upstream
then we should not record it as rewritten. As well as confusing any
post-rewrite hooks this means we end up copying the notes from the
dropped commit to the commit that was picked immediately before the
one that was dropped.

While we do not want to record the dropped commit is rewritten, if
it is the final commit in a chain of fixups then we need to flush
the list of rewritten commits. The behavior of an "edit" command
where the commit is dropped is changed so that "rebase --continue"
will not amend the previous pick. However, as the code comment notes
it will still be erroneously recorded as rewritten when the rebase
continues. That will need to be addressed separately along with not
recording skipped commits as rewritten.

The initialization of "drop_commit" is moved to ensure it is initialized
when rewording a fast-forwarded commit.

Reported-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                  | 24 +++++++++++++++++++-----
 t/t3400-rebase.sh            | 12 ++++++++++++
 t/t5407-post-rewrite-hook.sh | 23 +++++++++++++++++++++++
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4b89349251b..7bc885085f9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2264,6 +2264,7 @@ enum pick_result {
 	PICK_RESULT_ERROR = -1,
 	PICK_RESULT_OK,
 	PICK_RESULT_CONFLICTS,
+	PICK_RESULT_DROPPED,
 };
 
 static enum pick_result do_pick_commit(struct repository *r,
@@ -2279,7 +2280,7 @@ static enum pick_result do_pick_commit(struct repository *r,
 	const char *base_label, *next_label, *reflog_action;
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
-	int res, unborn = 0, reword = 0, allow, drop_commit;
+	int res, unborn = 0, reword = 0, allow, drop_commit = 0;
 	enum todo_command command = item->command;
 	struct commit *commit = item->commit;
 
@@ -2509,7 +2510,6 @@ static enum pick_result do_pick_commit(struct repository *r,
 		goto leave;
 	}
 
-	drop_commit = 0;
 	allow = allow_empty(r, opts, commit);
 	if (allow < 0) {
 		res = allow;
@@ -2574,6 +2574,8 @@ static enum pick_result do_pick_commit(struct repository *r,
 		return PICK_RESULT_ERROR;
 	else if (res > 0)
 		return PICK_RESULT_CONFLICTS;
+	else if (drop_commit)
+		return PICK_RESULT_DROPPED;
 	else
 		return PICK_RESULT_OK;
 }
@@ -4994,18 +4996,30 @@ static int pick_one_commit(struct repository *r,
 	} else if (item->command == TODO_EDIT) {
 		struct commit *commit = item->commit;
 		int res = pick_res == PICK_RESULT_CONFLICTS;
+		int to_amend = pick_res != PICK_RESULT_CONFLICTS &&
+				pick_res != PICK_RESULT_DROPPED;
 
-		if (pick_res == PICK_RESULT_OK) {
+		/*
+		 * NEEDSWORK: Do not record the commit as rewritten when
+		 * continuing if it was dropped. Does it even make sense
+		 * to stop if the commit was dropped?
+		 */
+		if (pick_res == PICK_RESULT_OK ||
+		    pick_res == PICK_RESULT_DROPPED) {
 			if (!opts->verbose)
 				term_clear_line();
 			fprintf(stderr, _("Stopped at %s...  %.*s\n"),
 				short_commit_name(r, commit), item->arg_len, arg);
 		}
-		return error_with_patch(r, commit,
-					arg, item->arg_len, opts, res, !res);
+		return error_with_patch(r, commit, arg, item->arg_len, opts,
+					res, to_amend);
 	} else if (pick_res == PICK_RESULT_OK) {
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
+		return 0;
+	} else if (pick_res == PICK_RESULT_DROPPED) {
+		if (is_final_fixup(todo_list))
+			flush_rewritten_pending();
 		return 0;
 	} else if (pick_res == PICK_RESULT_CONFLICTS &&
 		   is_fixup(item->command)) {
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index f0e7fcf649a..1d09886ea35 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -274,6 +274,18 @@ test_expect_success 'rebase --apply can copy notes' '
 	git reset --hard n3 &&
 	git rebase --apply --onto n1 n2 &&
 	test "a note" = "$(git notes show HEAD)"
+'
+
+test_expect_success 'rebase drops notes of dropped commits' '
+	git checkout n1 &&
+	echo n3 >n3.t &&
+	echo n4 >n4.t &&
+	git add n3.t n4.t &&
+	git commit -m n34 &&
+	git rebase HEAD n3 &&
+	test_commit_message HEAD -m n2 &&
+	test_must_fail git notes list HEAD >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'rebase commit with an ancient timestamp' '
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ad7f8c6f002..51991956d1d 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -306,6 +306,29 @@ test_expect_success 'git rebase -i (exec)' '
 	cat >expected.data <<-EOF &&
 	$(git rev-parse C) $(git rev-parse HEAD^)
 	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
+	verify_hook_input
+'
+
+test_expect_success 'rebase with commits that become empty' '
+	cat >todo <<-\EOF &&
+	pick H
+	pick E
+	fixup I
+	fixup H
+	pick G
+	pick I
+	EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --empty=drop A A
+	) &&
+	echo rebase >expected.args &&
+	cat >expected.data <<-EOF &&
+	$(git rev-parse H) $(git rev-parse HEAD~2)
+	$(git rev-parse E) $(git rev-parse HEAD~1)
+	$(git rev-parse I) $(git rev-parse HEAD~1)
+	$(git rev-parse G) $(git rev-parse HEAD)
 	EOF
 	verify_hook_input
 '
-- 
2.54.0.200.gfd8d68259e3

