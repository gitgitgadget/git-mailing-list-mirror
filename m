Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C140DFD1
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833372; cv=none; b=CUsZ9/AyI6e+2zy7InR6LtnLhMJrXA3xdnMJVSUzu/xrLg4QnVkMAYrRn/abu6dZz+QlfhKxkWnpvfmYnToy/I3u8StMm1Z3k8huDKS1y/TsznX8sz9/KB34WfhrjGOrvzhvlbf8L1EHr+NsCG7WVyvyGt3pJYL81gh/JLvWyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833372; c=relaxed/simple;
	bh=za66EcRT3k8Wqza1HAqpiOJf6ia5tpjWxrQ/daL1ats=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6si5KpbqXtQVT57p/lFpP8/4F7KO+d1Lwt7E8jXtetRGGR3sT+o/uJjFoK3hl8Hq1fY4y/u/wj+aNfsa3qv+ksd5wCcr4WN4QA8c0U0pGquci065Dz3WcYcCaYYSzd9WU/5wLyaIxRsqq88GelT3peoaHkkAq5dDS66ZYcLfTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMndn86+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMndn86+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47248615e4dso2992378f8f.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833364; x=1783438164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UKK0h9IuCueRRCV0TTrtM9ueyR0uKhpf0t9/DFabafg=;
        b=lMndn86+fiCq586VVO75E/fMWrlt4vJyVhCmEvNQsZ+4L//oqLf0edxSVYxxpUUMlG
         mMoM6k61SWyWXFzcRd5ti/fC686PV+LKDZS8t47hKfi7U6UKzkgQFG75q7KozgoTchft
         L1L6Y1hNlgz7xtYs0cY42ehVrOfiNjqayKtR0autc5R4U8PoAuih7o8RBNdQmBdJNHLp
         GeOqm/fyz07eqa55GW4EO6Y6CsbAKu1Umsnxy50y6odDdiKPP6VUM5P0g/Sy4t4uBvWr
         ttx+gJhnvjGqBMIpF6QAew3x+VbKT7fr0Odos4u4efagOuOazDZDM+Y94BaynJ8ZzW3J
         Yc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833364; x=1783438164;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKK0h9IuCueRRCV0TTrtM9ueyR0uKhpf0t9/DFabafg=;
        b=tLoIv8vk3a/sSV5Bun/BC9FRFlz4Y++Rj6OFp8ypnICq+fNmp8dTLYpflcpo0WBJM7
         zjyAR6vidhKUx4nBfgt3t+WLqGDqRCZ9tYxXpBGXprZT2w9mrIqbc1N21VF4CSuM6/Ik
         zQnvTXlVoI5PWBr8SOZou+knylmc0ESYiPMIf1L7DPZDzT/ec1zXQUg6KvbkE6XZ898U
         cU39/ybSNDj//aUqJr4P0ozhKHLAN9fhyNSI0QDNBy51zcuoRznDw+IErji6GtkcOKnf
         ezf+44IjVl7uXxjj3lcDJyJ+M/RsvFLAe9CKk2A8FcdAye8CmmWPTKgfCBD42EwTpmQx
         yQ/g==
X-Gm-Message-State: AOJu0YwqJTR55isN5a+3hP+JF0EMOj9obkamue1QdDtAo7yrsHlkfHga
	4/9kU+AaFzUFU3Is/PWUxpKZMkz/FrWGaUKugCgzXt0tKKYj2TNXZUprbSZOnA==
X-Gm-Gg: AfdE7cnEe2yeN0Vvyo9kyHlHE7RL8qA02yrrEaf3MgAW3nE2u0knba5pkRWBq/KA8xG
	U6qE7bGcjs0Sx4Z48srSJNfiWLfPLR2fFHmFbdZlWfQiCotqfgojEm6YhyBxwNj8q+gZrY5Kvom
	6zeRbV6p5MpaW6Pklc4YZzEvm6a5riMyoMPmaJZM9CEwl0g3tl55+3Gh0NWVGxeaJQeleXaKfI9
	Cm0RUNCq3KexB3kEMy+IAgWldA8I0kfnJQ31HZ4g8CDZk5zfnvdYVC+2OlQVbAzi8nACuOLRDWa
	aYxg/+9ERJUcO5XO7ar8sg812FHBoFBKG42Z7e60KrYzCC4Z0RAJW0jmbQ8NzOd4hUBji8Mov5u
	BCvsDwrJJvded/D1DbDkAPkBaTRSFgz6cuHizImyenisiuqI7freOH3AnxoZ6Emc8fNMsujvKup
	c7mX0MW6vJ4I8Ul3Ek
X-Received: by 2002:a05:6000:38b:b0:475:f0c2:75a6 with SMTP id ffacd0b85a97d-4765b03d0cfmr1503973f8f.55.1782833364250;
        Tue, 30 Jun 2026 08:29:24 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:23 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 10/11] sequencer: use an enum to represent result of picking a commit
Date: Tue, 30 Jun 2026 16:29:00 +0100
Message-ID: <e4050ead27f1e01ca72acc849fa16bd67e0d1c4b.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com> <cover.1782833268.git.phillip.wood@dunelm.org.uk>
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
index 655a2e84bef..ca005b969c4 100644
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

