Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B03426425
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948673; cv=none; b=bSBf3kjlPaH2OKjFJnT61QsiR6wbzP4A19pNz2mh47JkzLUC6Uw/D3IZ6O8fKFRp+X1w57rNAkc0lqIiAQxXE+3FTddKQaQllORpjM0UTzMgBviRCK2eJkOmElTRFkeqirSUNQQ5rNiwAgZx1Z1tecw0MlJQAPrPP9EoaOzEbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948673; c=relaxed/simple;
	bh=M+7I+5W62arOBYRFX4S19cHcK2zNNmFYxIZrhki2nvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSq2teVZZd1D5reCEYPpXS+Gc0kHYH0GGeNacuj7uGFmY2Nl6oc97Jzodev87RhkRpISLYtHPTlwgt6KG7ofwuwhYEw79XdFh0/2dWS6l3AmXdw1z3sVPEZAiPqr4bqsm2DJXsbgK+sn5352lhE+pReyJj1npHtufaw+JNt9dI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPPFqN9t; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPPFqN9t"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f60208a5so27251515e9.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948670; x=1784553470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FADB0Rii5e2pdglO8YX+PtrhhIE2dEDeGqKRkhRWpiU=;
        b=mPPFqN9tVv2Q6aRl3kDnbwdiHg2ZIU6iYQkoNxQIDnssIqX+QORJK5XTMEdRuPlYb7
         NkGXIUpX94likxsiEj4q8QKU8oeL704pJ6u3kiUwOdSP29KQOLICqLvdNJsNTzjzqYal
         hqp6//W4T9W9lpUTLrtIp6biYXPvhyLoYUWpN/ICETXS2MBBtFbj04a8MC7HIgao4jES
         4MQlFlAcEocHFEH4kfXPbh/+fEQdpBHDuN2ZkZbalnp1rHXvW3+0c4Nv3gM/m+hdiawm
         Ix7xYhV3l9yhJBWozRquPdDH9EFdHt2jK9nd7n7RQLDPioGbDpngHdVHOhn8HCmTmAgt
         P/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948670; x=1784553470;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FADB0Rii5e2pdglO8YX+PtrhhIE2dEDeGqKRkhRWpiU=;
        b=o+7GqgHgczvep/LLFApck1qGas0YVSjl49ivdB+ft2ajVghtfeLZlPZ7I3OVoTmcd6
         8EYRxTTalcz1dvZ9qRkhsh3Y8SJ9WDDr9F/0ZlWMH1uug6mEi6doZK2V5sDHAHcbvFBk
         TchoZWpmblfcZxbdqINaoxUg7Ky6cGqYjJ+9jupZWT/eG9yRl60FTTib2BhAusmHhYaa
         6+hKMudcsILVJXERk4gX3E5R3Jl/RMBE+pEoDw/eWIUYzFS7MrcS4pUxwgQ9rI88fcIM
         AT2zjC+Ce3lpqz8XqH1jzrYxZhnJSJjB4HtvcBSYfi5kWTSCB1m3d2J30dRN1MgPElcI
         T5Yw==
X-Gm-Message-State: AOJu0YyFgjlU3HzGPnyplxam/jY0fyN78YASyyq8MqdwgJqD+JNmGsFt
	NOku8K/EwLHGOOeC8trAWMToSCivCy2/SREpFwcTesiT9KT/q0o4g6y1uGvy6A==
X-Gm-Gg: AfdE7clf0k9BFwbfiqevxJ4cm3+ar89t7GPZ1JVMy0FhlvewXLaYECI7DhVM87vWv6m
	WjE0Z/19XFuoiKxFh6kn8k0XJuWdfdCFgti5Ugh+QytbAhVVVZG5tCoAsClva77FjGQfodxrOJ9
	XureO2d9YdMORLtM/nZCcF8kAGArSRQm9/O+b8V3O+QEL7eqDuPsHb3IpntG9QaVstOIj1QD3Q6
	j2BXZaFd1aVqhGgUfeDLw3UyWtWBbu/ZfPUR0IIvKDGlgMkLbIW1+As85pm7Bj2Fwoc03MOUdgC
	Ohjx5cdhOnNjUB1H91IRXQwKV6w4vkwpM4QnQTz/S53vE3gqiIWkVEFYuz/Soji8Adm1q6DhlgU
	7WRSLKqnZfTUywyUnGwqOXOEQo250JtOH+tikN9aK1DyPGqP3IAdiVANTcFrlE2isOZ3RSe3EdW
	HHOPtBvF1sKrej6sMLQJzMa9KfNuE=
X-Received: by 2002:a05:600c:5493:b0:493:f262:b8 with SMTP id 5b1f17b1804b1-493f87d666bmr95147705e9.1.1783948670162;
        Mon, 13 Jul 2026 06:17:50 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:49 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 08/10] sequencer: simplify pick_one_commit()
Date: Mon, 13 Jul 2026 14:17:25 +0100
Message-ID: <e8b7fa4c59e81487c5302423dc894776ecc9416d.1783948637.git.phillip.wood@dunelm.org.uk>
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

Unless we're rebasing all we do in pick_one_commit() is call
do_pick_commit() and return its result. Simplify the code by returning
early if we're not rebasing so that we don't have to continually call
is_rebase_i() in the rest of the function. Note that there are a couple
of conditions that do not call is_rebase_i() but they check for either
an "edit" or a "fixup" command, both of which imply we're rebasing.

The only block that does not return early is the one guarded by
"!res". Move the return into that block to make it clear that after
recording the commit as rewritten all we do is return from the function.

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
index 5f5ff3783e6..ff4547d417e 100644
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

