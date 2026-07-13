Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3D421F1B
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948674; cv=none; b=LOHU3VA1jrGjvd7rIvPZKYDsxMDybqwEjPu+LQbewmv0GEjDYdMWGR+PyhLiqZFTzGnKLAaUHjvK1W01J1LKIeoxKRxI+BBhX0sVGmY5kUI+qGGM9+epc1CMCRWsgEUUywA+gG5pdHpyczo3L3TvLZYQHj3/FkSfO4hUX/huSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948674; c=relaxed/simple;
	bh=YdKaA49LSibr9ENw15oedkTj5/QAjGe6BH1C0jktWq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZVaEx9RVNS4Iz0c4PEwX5qsFdpgJSsPTt1wK5FwIoNyd0Wjq3gOPTWx+l8lJ7QKQ+KFOdpJiqDSvaJJVPiTqIlXsrfY6KaUdmqmODl+wtH9VI87nZ5nC9pfmU6Z/zzNdB7ud37JxovYXbpMnM+Y4xsTHWMhocZmVm56AvsJOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2ML5flO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2ML5flO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b966dd74so11731845e9.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948671; x=1784553471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m3gCdTW9AqW9Mg5lYXfttZdng0aTQ5oEmLRoIzbUASg=;
        b=O2ML5flOrYE9jBrGAYsEoIO5H+06IX7rQls9opOFzDjpxzux3HiTgc3bBMmzv10DY7
         X7IO4Ei6McrfxPKzTdWGQRT35Zv9parxhDPvMOMXuURqW730GgVgd+Y6FScNNk0dRdaw
         PrD8MjMqSgIKGlWBmDprms7bRXcKHK+Vo5gekMQ8jopaN2UNcM4nN3N9XIw0wKBW+pAv
         BizgmIyVo0mSmw0dzkmABPQAOSqbob3j/ymQJWTneprvwA7qUP30HIyuBTxG/ZCbL9Dq
         UHfopAskqyx2hvlt89yNaXssv0/KRr5dgyUonMvJWsff+XntTHav8fFLJ9CWOc7FOO/J
         Tgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948671; x=1784553471;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3gCdTW9AqW9Mg5lYXfttZdng0aTQ5oEmLRoIzbUASg=;
        b=VJ0v+c1wKzaC2s+StFvHQsblamQi7SPaAxpkhAwUUoyhp1cfwxa08nAj/5ta0zTVlK
         vEugLZnPlKRausPw3aaTMTHMBGldJKa4FmarDijdAd1CUcCTwV8+VJ3u/K+WFWy6pTAB
         4xfVyOYiDtEFtxfd4+MIr6PBpVdcv4YRhgfZBTAI0KLdE6aDurrkrnIiype715H5h+RD
         WJQbcCYdgXb7Ijiz0Omv54Y34v1hBoF73YJmJB2McKWF8+am/1I8TJJfBl0T2u9wEM9+
         T15CRGyP+gvLvTlbQXYvZ5leAdPnE+swXgGptcfzT4/15C4wzj4eQQwfF+hKvWF+UE2I
         /JWA==
X-Gm-Message-State: AOJu0YymjlV1BJZb8sZUP0+3+eTtOFmZwSpsZ08nLh229AUPqjdhsx16
	MsVMof8izNwQn3yEzxYiYdDiuatqyu6LiXsPM/8xJNSULmmP0wIYYgNuPz99ww==
X-Gm-Gg: AfdE7clU0+rQreL37Q+Hz+/65MXpPIY5bCDc8MpR7/lD+oqmcz0nBoTzmMB6l5k5WTH
	5zdAdV2zgysMVL4qI2beFfpQaRyprudbXpvs2zZMaSrAOLLJShECoRSp++O6eWTq6BEDqKHwGTK
	desxHw4ycS7dEt4xlznfHm8etokYhdOQNEOfrl9st2NlaptrfU8RBOS6k/NL3Ydvx/6OzV3k58B
	DY1S/R2HHy3IyoaL/BJjH/yK5sZfMTrHfRCzo8AwkMMULo3VfNc91I8zws5/sUgI3xbYiXpuggW
	5Gt3DYdIfbN8/CPKgJB5+x4ybYnBq/NrnaNqVe2z0Wk2RMlBoA1I9Yz8U7r1mMAVGn/mQp3S8TW
	aWR/PLhXhvbTdkVhLexu5ReTVDwxWsd2BB0/MEGPovWPqY/sAXQt7coPJdw3UlWy17TMqows54n
	MWG1y3Rwn5asfYKig8
X-Received: by 2002:a05:600c:608e:b0:493:b03c:5650 with SMTP id 5b1f17b1804b1-493f8820806mr88154145e9.19.1783948670975;
        Mon, 13 Jul 2026 06:17:50 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:50 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 09/10] sequencer: use an enum to represent result of picking a commit
Date: Mon, 13 Jul 2026 14:17:26 +0100
Message-ID: <4fb641afb3cb99858ccabd69d4a052a6b19b6148.1783948637.git.phillip.wood@dunelm.org.uk>
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
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rather than using an integer where -1 is an error, 0 is success and
1 means there were conflicts use an enum. This is clearer and lets
us add a separate return value for commits that are dropped because
they become empty in the next commit.

Note we continue to use "return error(...)" to return errors and
take advantage of C's lax typing of enums

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 61 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ff4547d417e..4b89349251b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2260,10 +2260,16 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
-static int do_pick_commit(struct repository *r,
-			  struct todo_item *item,
-			  struct replay_opts *opts,
-			  int final_fixup, int *check_todo)
+enum pick_result {
+	PICK_RESULT_ERROR = -1,
+	PICK_RESULT_OK,
+	PICK_RESULT_CONFLICTS,
+};
+
+static enum pick_result do_pick_commit(struct repository *r,
+				       struct todo_item *item,
+				       struct replay_opts *opts,
+				       int final_fixup, int *check_todo)
 {
 	struct replay_ctx *ctx = opts->ctx;
 	unsigned int flags = should_edit(opts) ? EDIT_MSG : 0;
@@ -2564,7 +2570,12 @@ static int do_pick_commit(struct repository *r,
 	free(author);
 	update_abort_safety_file();
 
-	return res;
+	if (res < 0)
+		return PICK_RESULT_ERROR;
+	else if (res > 0)
+		return PICK_RESULT_CONFLICTS;
+	else
+		return PICK_RESULT_OK;
 }
 
 static int prepare_revs(struct replay_opts *opts)
@@ -4960,37 +4971,47 @@ static int pick_one_commit(struct repository *r,
 			   struct replay_opts *opts,
 			   int *check_todo, int* reschedule)
 {
-	int res;
+	enum pick_result pick_res;
 	struct todo_item *item = todo_list->items + todo_list->current;
 	const char *arg = todo_item_get_arg(todo_list, item);
 
-	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
-			     check_todo);
+	pick_res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
+				  check_todo);
 	if (!is_rebase_i(opts))
-		return res;
+		switch (pick_res) {
+		case PICK_RESULT_ERROR:
+			return -1;
+		case PICK_RESULT_CONFLICTS:
+			return 1;
+		default:
+			return 0;
+		}
 
-	if (res < 0) {
+	if (pick_res == PICK_RESULT_ERROR) {
 		/* Reschedule */
 		*reschedule = 1;
 		return -1;
 	} else if (item->command == TODO_EDIT) {
 		struct commit *commit = item->commit;
-		if (!res) {
+		int res = pick_res == PICK_RESULT_CONFLICTS;
+
+		if (pick_res == PICK_RESULT_OK) {
 			if (!opts->verbose)
 				term_clear_line();
 			fprintf(stderr, _("Stopped at %s...  %.*s\n"),
 				short_commit_name(r, commit), item->arg_len, arg);
 		}
 		return error_with_patch(r, commit,
 					arg, item->arg_len, opts, res, !res);
-	} else if (!res) {
+	} else if (pick_res == PICK_RESULT_OK) {
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
 		return 0;
-	} else if (res && is_fixup(item->command)) {
+	} else if (pick_res == PICK_RESULT_CONFLICTS &&
+		   is_fixup(item->command)) {
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
-	} else if (res) {
+	} else if (pick_res == PICK_RESULT_CONFLICTS) {
 		int to_amend = 0;
 		struct object_id oid;
 
@@ -5008,7 +5029,7 @@ static int pick_one_commit(struct repository *r,
 			to_amend = 1;
 
 		return error_with_patch(r, item->commit, arg, item->arg_len,
-					opts, res, to_amend);
+					opts, 1, to_amend);
 	}
 
 	BUG("Unhandled return value from do_pick_commit()");
@@ -5547,7 +5568,15 @@ static int single_pick(struct repository *r,
 			TODO_PICK : TODO_REVERT;
 	item.commit = cmit;
 
-	return do_pick_commit(r, &item, opts, 0, &check_todo);
+	switch (do_pick_commit(r, &item, opts, 0, &check_todo)) {
+	case PICK_RESULT_ERROR:
+		return -1;
+	case PICK_RESULT_CONFLICTS:
+		return 1;
+	default:
+		return 0;
+	}
+
 }
 
 int sequencer_pick_revisions(struct repository *r,
-- 
2.54.0.200.gfd8d68259e3

