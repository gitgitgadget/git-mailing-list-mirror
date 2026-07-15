Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A248C3F3
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128949; cv=none; b=NSKAMxNOt+Xa0Jyd6iXKQby+sPPrhJjNjaAsEsfnogUlMlrqNclR82vkvEt9jsc2BOGPXt6POiRgACr7p1p623XTIdFzXES45knhLtuN9+KGzY3FC0gyZpLhIOBIt9zbyuf6ddGXPr5NChv3R4489lFL/TKKLOfxiYjj9Dcgrk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128949; c=relaxed/simple;
	bh=hx+6/VvYHwqcj9d4T67MhG9IeRA0XDidHFIWzsziuAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Biz7WKMo0kMyTOt//VcRPCi7SKmiXtiFG/4QB6DsLNHajSsW3uCaaErMrEoIW2xxo18YfXjEhKC4rw+5J48vo2NF5decZ31tLLQyehJwK5L8bng4pkXorf+OFtD/PEqqgibgQammV7jOlaQa6vQlYowx8gqZ9t4ifROKuk7+ZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG91/VdX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG91/VdX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c7902f47so46948145e9.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128946; x=1784733746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Y/35cCTlPhNixpo4vCfwFtT1s3g3DOUXIzdk6M3a9w=;
        b=VG91/VdXiyzHeMqvl+dhOg79sj8VME2J9O0g31Qh6RiTXy+IyhtXWMTJ1xKHJWaRhg
         aG2ZW3V8CC/70MKAYyBfrkw0MDxUuM24vsgvleVdR8iktwmzSAYSxFi3yU0SgOkt6gan
         2R3P+hbO0wPBkkV6rP3hCPq7KjE+Fwah89CzdSKGVR+iu4M0+cL0mAzIvx/5+C+BXeet
         4hJ329KHNxfwpNM3ezG1yK0Mfts6EEdsZFVLWZU1wW9vn4FBBp3uC60d06tGTqdj7IMJ
         AyukBMdTav5MSPQEsf4Kpp//+llMz4SHj0aPGGIvjC1V6nEKVvvP2ZcKWL/IHIeV/tUC
         RGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128946; x=1784733746;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Y/35cCTlPhNixpo4vCfwFtT1s3g3DOUXIzdk6M3a9w=;
        b=hS/9+5gia3ISlkaWHkHCAtVdmCon0POmzoePrw/yf/VAuIZ4fMrj8I97WYdn5TPQ1K
         kvVcTKWytN2XjyTQZqehwWFKTmtXZj6NCzCoKjUshB0H1jCalreUOqHItZIHEGtYXr0t
         hcewh2AvrnmrCPn8Kbhje1TuqCBmagl4OlGJSx2AKLZ19jF0vpWlBGyca3gC2PEsk52Y
         3bKEXgUVTndZ6LbWl/sArld5zgfzcH+ZSBiJlpcUahGWpcoHNZ20kTzCSz66cogBEC8q
         DSHpB4WJmOwhEDjuvcZ0lxQyJTTuVqC3u2MH+iNIpQmx44L03TfIjjYcGa4/bn+JPq5V
         tqZQ==
X-Gm-Message-State: AOJu0YyBQGbFqxck1T8XFme5/ziOCl53XY8HC/a6YTf8+OJgCXa+Uttg
	dej2iNGytXivmYYFTNcG7Clv6xdrb4rjX01EkRg0GrRz6dp5RNSkMeXdrljbQg==
X-Gm-Gg: AfdE7ckarOK+UHGR9C8+qouxJCvkZbtgs6JNEIOhckrCR6VT8B/50radtWkRc6Nzpeg
	JgJa3ECh9lkRX+gGahuBCp/iBY0zCoIDGO94teZPnS+7RE+gpb96sfyP5cST0MunvTZtz8ovR4h
	PlKUIePxJZq21jx4YtWUuvFVvdhPk5b4oAF/6tzqtfcM/zBuAdYZ5TjmcugcGzUcFrwS9N083cm
	47bbK5yhId3094GwVT12yHP243bqWWHl3mu0MvsvGREH+JENdv612boo9UvvNtPMfjL76SdhKt8
	v2Xc2rmPDEiGYAoOQrjmq66F3njac1pFKSpbtUAUMiEVGoSoDDWZOksA8M5+pPwOJgynpJAwYqC
	McKwBHF2gEYuSzaKT/bsme4ZD/3noz2vlOSaKB3SYfEpLQrmZdcDlrWTCXad2Ysv+I+ed2pAYzB
	1BbM1l0jhihhUKC2ve
X-Received: by 2002:a05:600c:8b8c:b0:495:3f68:699b with SMTP id 5b1f17b1804b1-4953f6869f7mr20993495e9.9.1784128946106;
        Wed, 15 Jul 2026 08:22:26 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:25 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 8/9] sequencer: use an enum to represent result of picking a commit
Date: Wed, 15 Jul 2026 16:22:02 +0100
Message-ID: <0a146d57266bdb54bbccdf714967c42ab0a2ecfc.1784128921.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784128921.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1784128921.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rather than using an integer where -1 is an error, 0 is success and 1
indicates there were conflicts, use an enum. This is clearer and lets
us add a separate return value for commits that are dropped because
they become empty in the next commit.

Note we continue to use "return error(...)" to return errors and
take advantage of C's lax typing of enums

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 61 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9016af9b5d7..4b3092dc9bb 100644
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

