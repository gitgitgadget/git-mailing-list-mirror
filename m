Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40610397AF2
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833368; cv=none; b=coFkvG92H+VkwRfxTNN1fpReuJrgrRxz3Fvu51OphUdW++7YqJcYPyjrpK/w02XWrqwjgVIv+ndQ4rywF42sclO+hsu+YpO1+8a08ny/TmdVxRS8WwehhMTq8lIGeyChb8EybXLbQdpQ19SNdRhBdsJzhNBY1HSCPlDfMixf/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833368; c=relaxed/simple;
	bh=HZmi0ZeUioUdU1uMNWQzIvrMH1PVGnllNw9XrAdbD5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jar5Pp2syp5YSvpBMq3wUcX+FBkjz0dFr+FhZ3iguSMRwYjz/QukeK84vAw5LOAuXf0l0XC7EkM8YV5TUSEgW8Ue5/T0aEXaWE1IZBvyp40zeKDCRuxWA4L56ueCVUGO3ScbRzyXoEKb1J5HBLy02+VKyyasPtaLa8bd7j628Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vwxd2x6x; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwxd2x6x"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4629051c9d1so2716083f8f.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833362; x=1783438162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H+wZcOvY8D+vA67WJ0DacnBqTF6fyRY/u/HhCOq3n+s=;
        b=Vwxd2x6x+HgT4zvcSoh7juUX3Z3uWo04GzrviK9AzICgMSH+qDi/eKdcYJLwQdWU5f
         gB3MR+Bhbd53AowEhZUCcjwVsh3DRax9WTNDklayG4hKxGx0kYC5o3ViP6KOOFJ1rLG5
         Xsxktmg3Kf1HM2Q2c1CrHlORFuY6g2W90oybBi4fpslcEtdW6LpUz7ZVQeM2dEkNG+tU
         FpJEQ95Aa3EZgF9pK9b8PfTdjMT/FrKg6Y6NvsmB2t1C7lC0+0zQvemI5p6Q5B1DyR5h
         esIS1tkIyhqHkKaQcEryaEpbu3WeABS10D7fJ+HBCH9OfEes6MZfGx7/PpC02hulYuV/
         WFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833362; x=1783438162;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+wZcOvY8D+vA67WJ0DacnBqTF6fyRY/u/HhCOq3n+s=;
        b=m8JCnR/3+hYR0sut3OUWJI/lxz6l4gvfVFEkI5kxagWcVUpmS/Oh8TCIvQHAK36zJ9
         8KfKohum63DxA7ED9eNw8ZO/r1foLzxwOxlPbZ/XV+nfCfln4+ACNFFZEcJ3NXxG8c5A
         f0GRje94yGynAvtaReXCTUDkQMgh2K+Cs5ipseG+2Cm42Ts6SsguwRtZNrytbwDxuMeq
         g+bcP7k7a/HRtHA67h7WHi6h6aLsNgtBRAokgawJYvg6TKs1yo0Msn2az5UvP+cMOWwZ
         onSuXbvvrGGa4EbKOXMzBj0c/kx7og5MEB3S5IFud7n44BFROxckvyaRSdFB3aSPYftC
         Of9A==
X-Gm-Message-State: AOJu0YxuYF3QCz3JQWEHsBGNPb1D706dPLaPyows79jyHTNYMKfYbCMn
	2HRpVwSxkvgVETOroEZrneE/JISARpYaLuwswWvFYbuHBzPdxy3aCM6f/1WYlw==
X-Gm-Gg: AfdE7cmD638FAQUwx+SUporNfpgLFTHFytytPnlR+QGfupyYCW4TqnuLkKrcDp/C8Dd
	GJmBmSPoncHce7CjzqfamuyhBLVUAK2lhI5cpxqJfftEwndcHqLF8i5eEAVe64zOhKrdjvZJebz
	NO0SLl06I3NLhXSvsBGhp69KrGLw8vy51r5v9xFGjwJuALz8PINg2OzytqWNjKoObTYyagAenxx
	1VDZ1UM0s5l6leqHxnw+BSlxw2Js0yOoWdBqSLZg/t87zGabwLN9AH8NSeDgjg2aGlzBSbfyjUg
	j85Hi9mfAG3v6CQR0d+fbyAWIfnF6E+rsWjjgf2r/8jBEhSpTYJ6p+61tTeMVk309NQ7AMpy/rd
	MEkU3STGgJGZ8aNCOwzq40+hYhlR5Uc8CTq2UUj/Gf4902rb7Dcyz35l1KfBR7+Oqnw6/hUHVUs
	linnmeFAEAScsxPPFO
X-Received: by 2002:a05:6000:4284:b0:474:8bfe:ccc0 with SMTP id ffacd0b85a97d-475505f43b5mr6009054f8f.7.1782833362191;
        Tue, 30 Jun 2026 08:29:22 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:21 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 08/11] sequencer: simplify pick_one_commit()
Date: Tue, 30 Jun 2026 16:28:58 +0100
Message-ID: <f51751fa3ec1545b7304b869d91d21b055218755.1782833268.git.phillip.wood@dunelm.org.uk>
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

Unless we're rebasing all we do in pick_one_commit() is call
do_pick_commit() and return its result. Simplify the code by returing
early if we're not rebasing so that we don't have to continually call
is_rebase_i() in the rest of the function. Note that there are a couple
of conditions that do not call is_rebase_i() but they check for either
an "edit" or a "fixup" command, both of which imply we're rebasing.

As the conditional blocks are all mutually exclusive (either the
conditions are mutually exclusive, or an earlier conditional block
that would match a later one contains a "return" statement) chain
them together with "else if" to make that clear.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ff28873d21c..416729f30a7 100644
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
@@ -4981,14 +4983,13 @@ static int pick_one_commit(struct repository *r,
 		}
 		return error_with_patch(r, commit,
 					arg, item->arg_len, opts, res, !res);
-	}
-	if (is_rebase_i(opts) && !res)
+	} else if (!res) {
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
-	if (res && is_fixup(item->command)) {
+	} else if (res && is_fixup(item->command)) {
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
-	} else if (res && is_rebase_i(opts)) {
+	} else if (res) {
 		int to_amend = 0;
 		struct object_id oid;
 
-- 
2.54.0.200.gfd8d68259e3

