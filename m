Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF748BD56
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128948; cv=none; b=dhopW0EDF+XgTVP4ZPwqV5n0IOe8ADCJpz5LXUMYR7MvlDl06a5g17gFKtKnILlOPLxP3bEf/0sxVI0f6rFdqenkxzme/pq6Ak/ueg0OW6saqlIAvKGaD6NLHwC05hcbxaJDZpPdZD2/5uHc73maQigpZKl4QUBsAPN6l/MEDxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128948; c=relaxed/simple;
	bh=rLtTkEnHxLaKlXzh0vRfsOxsoEINDj9w+y1PpyfCm7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAf5onS2/31oXTpV2n0u3YM6brhai0T+1/wmQDqIkY78VG2azt9NYhJZZxd0nXPC3rWBkTQIxGoBjPbQ9VV4nFW/jQ/DES/JnHiTvsjGu3xhAxHK6t2fnv67pQvhw19I6bTUI+0s5GAXT8UXAJEFK6bwMrQ6+ke6/5NMe8Usf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVEb+UaC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVEb+UaC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4953ddae026so5393025e9.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128945; x=1784733745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zcZ+aaAm0y0G2vLU1P6cqC9zdCBj7A55EpnZY+u64vk=;
        b=SVEb+UaCddSYW10P3+HQMyN9j3ql10cxr2bS2UXElFZZUfTu3kKqA32a+XrLf8AKna
         Ae9i+CivlJKEk4+JRJnossxKCMcDRsKkqyGwmacPxyvfxvfimXEHk7Fc1ENzUTWzSX5b
         5ULOxyWjObXx/cjmOFwglLuITy8y3rpGbUa0bJX9DY2IeZLvPp0PDmv17Scp11MjuWnr
         Yxatz/xBRrEG84WEyALLZdA+Zz+EW2TjhU86z8Tkz1Exozb+esGtjHgHTzFrn0vPa42i
         RwfLjbFC+SZtOLPdOfk5yugooq8C8AJpwqsMSY5ouk4x2+85M81QfDdzw35M1f3vVLag
         pwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128945; x=1784733745;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zcZ+aaAm0y0G2vLU1P6cqC9zdCBj7A55EpnZY+u64vk=;
        b=i1V7OSKbSDExothhuU/IEKO1USIGN8fRssronciMzqc5M68K89zUt9dlxUhmAxazvC
         8gd2gSVnZsGBmeshwgr3VSnOXxKp6mTdgeU8ehTlGATTwXF1vI9tZGQEbdT+cMcSYKdK
         0pvMKoQOWXDkH6owoxzu3moUwc7E9a5IWxtObPHrvgM1yVP1YGWKFuT0gj/uVuXLqoFF
         V3RkKOFqdbouaw7fTeA2zmX6lXi8k+/sAXXuTkDWkhBEo9/0aJkw3T+n3WWZGPQ9NNCa
         gi9bu1TzWPBdBVB+iiHqi73uxl+Ul2zTE6MnJLgA5K0q5Xi+offS8JSUCwRHhQAHTb5U
         LyaQ==
X-Gm-Message-State: AOJu0YyR1MQ504quutgboxYgrApsTAQlQ3x88D3LgWR+Mog8lW9VaORg
	wjEtmxxOKRbq46byj6lcI36BcM/LD6ylBELf2VU87r0AIxIj71GfLIPQPe8nKg==
X-Gm-Gg: AfdE7cnAJyDjnye8RO6z4ASFn97yebVAd6CeapWNXRd5O94/cIxVVXkPmSymBoDQkgP
	cKInCl4kQjA5hw3M6mLQSCeguJcElxTXcz6+w6UQVLnCM39k9gPvuuF4kQpD8XaFJBmS6ErN9+x
	Ajo4FW4FKTRR6QOsYd38W59FpkFzJbIQ8MjAhs5wykJ28v/hBJjmy+4ZMypwHeXtUSIRh0Zh6Qb
	tQr/acPBkRIarADSaTpE7Dpvc32tCrLiICWX1gVTAokoowsVSLLnm46yAmXfWJsuCvXTmh/3oa6
	OYu2Y1sQDnaIW31PlpFf3MQuTKH8LmrEyE86XEUhMUCdZOeTpVvAaX2Sm4imXJCneyrRieCO71c
	Wf6TROZrQG9Q3CFJ+p6eHlgVbZnfHLlKm+4WS6h92h6Gu8bdazVRL6QPUtgORNgBUaUR/og2I0I
	ZmJYbY2GTer+cE+xB3
X-Received: by 2002:a05:600c:8718:b0:492:7101:3d88 with SMTP id 5b1f17b1804b1-493f881d4bfmr172200595e9.24.1784128945086;
        Wed, 15 Jul 2026 08:22:25 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:24 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 7/9] sequencer: simplify pick_one_commit()
Date: Wed, 15 Jul 2026 16:22:01 +0100
Message-ID: <7c1642b0a49027a8851aa5985f4020d8e76414d1.1784128921.git.phillip.wood@dunelm.org.uk>
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

Unless we're rebasing, all we do in pick_one_commit() is call
do_pick_commit() and return its result. Simplify the code by returning
early if we're not rebasing so that we don't have to repeatedly call
is_rebase_i() in the rest of the function. Note that there are a couple
of conditions that do not call is_rebase_i() but they check for either
an "edit" or a "fixup" command, both of which imply we're rebasing.

The only block that does not return early is the one guarded by
"!res". Move the return into that block to make it clear that after
recording the commit as rewritten, all we do is return from the
function.

As the conditional blocks are all mutually exclusive (either the
conditions are mutually exclusive, or an earlier conditional block
that would match a later one contains a "return" statement) chain
them together with "else if" to make that clear.

While we could remove "res" from the conditions below "if (!res)"
they are left alone because, when we start using an enum in the next
commit, it makes it clear that these clauses are handling cases where
there are conflicts.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8f3eed205e7..9016af9b5d7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4966,12 +4966,14 @@ static int pick_one_commit(struct repository *r,
 
 	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
 			     check_todo);
-	if (is_rebase_i(opts) && res < 0) {
+	if (!is_rebase_i(opts))
+		return res;
+
+	if (res < 0) {
 		/* Reschedule */
 		*reschedule = 1;
 		return -1;
-	}
-	if (item->command == TODO_EDIT) {
+	} else if (item->command == TODO_EDIT) {
 		struct commit *commit = item->commit;
 		if (!res) {
 			if (!opts->verbose)
@@ -4981,14 +4983,14 @@ static int pick_one_commit(struct repository *r,
 		}
 		return error_with_patch(r, commit,
 					arg, item->arg_len, opts, res, !res);
-	}
-	if (is_rebase_i(opts) && !res)
+	} else if (!res) {
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
-	if (res && is_fixup(item->command)) {
+		return 0;
+	} else if (res && is_fixup(item->command)) {
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
-	} else if (res && is_rebase_i(opts)) {
+	} else if (res) {
 		int to_amend = 0;
 		struct object_id oid;
 
@@ -5008,7 +5010,8 @@ static int pick_one_commit(struct repository *r,
 		return error_with_patch(r, item->commit, arg, item->arg_len,
 					opts, res, to_amend);
 	}
-	return res;
+
+	BUG("Unhandled return value from do_pick_commit()");
 }
 
 static int pick_commits(struct repository *r,
-- 
2.54.0.200.gfd8d68259e3

