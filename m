Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012E35E927
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389855; cv=none; b=oTwvQHb3mIbMkvfJHPBMDAf3kXL1Hb4QFK4ekFkB7lKULkBjwrTPUus6GxfKIrfyID63WUFQivDNgOEEx7I3oOOcEMshYWO65y4f9PN/l77Vk1wx7e0KIUjc+Fr1/tShNHkNfg/6a5cZcP9YjJuP0meVvGsVMR1EfAhbOR6gcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389855; c=relaxed/simple;
	bh=1K0oJZuHsSPTKKnrV7LGaVAII6Y4iKGsWqzeYW8CuBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9zEaWx9mvfRT9VWamkjkbtr4uj9y2GUAta9zIg+3wYYxEayucngIflZfQl1LS2uL6m4+FVdt6WlQqZzcTad+mmWnWcZq0Hzsz5ZP9ReWE99q1Vqij501NynhOgxWGUlR+RqwGNxPaMvpWhMD44V5eYbv0F1bjxvGOEp8+A8fBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEhFeDeY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEhFeDeY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b04d051664so49620775ad.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389853; x=1774994653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKDlsAYXK0y79l5z3CamQRmfytcTRgIeBmLKxtshLjA=;
        b=JEhFeDeYJvkEtyAeU427ikgW/P9WyS2LEK9L/513EXA5He6m6/29BwXLVnopT+66sU
         v7xauAo/HPzI538w08NywvWAVTbJ0+yzsWfKMxvp2TSuTZ55jg2T04SaNc+hSPPySsDq
         +H6a9HNIDJddROIMBSAOr9J7S2XiZ0FYPyPjcZuqf4mIX7/yJfO7eFR8Mz/JvHDFTsIp
         xmf0Xq8vkoFiPZ2LJ9FNuWSqAWDfOWWXbTRGoGVV0mcqBQzRDIqv1xL8L+kaXbWlhlpp
         Xs4AePRSNtB69f9C0BPT7/+ks/TpSwTmlaZ2JwoHATgfRMBDan5RNOgUmgqhn6R0sP9q
         kcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389853; x=1774994653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKDlsAYXK0y79l5z3CamQRmfytcTRgIeBmLKxtshLjA=;
        b=gewh5/bi2d6fIk4IvJRVyGWFSn6IkXIWXBMGrPyKKN0m2jg5OKJldeNXioN/ho6bhh
         lrp5s6r80FDpcNhFd7xR+duSLsu0M75EQ80QaXhOb5z1cOj+ALH3VyZlGO9GeWWzPfpO
         JoKPMdFfOzjUPg4IivAIomfiWoKucFjZ1mtjWj0SVDI+ihT4Yi7IVOW56q7BQs7JdsqU
         q9zKZvs9pQK0oOj7N9Zlu3UtdQ4wxXFcQNQZ5sM8RfPReze1HxNkvSKjLHqhsdei3n1+
         LsQ8UrWzMXcrIDzWLxogCZAhiwLqPvq2HJaa3edzuDBYgU7Uo4GmZFog7LPtpaO2EmjK
         cYoA==
X-Gm-Message-State: AOJu0YwbXzEWciQF6BL3gvXswX66WeN0fVsF0E4YMMFMvFJxtZINZYsx
	0SmTMZlav7E3b6NhpIaxAiTRQPAH5+/ccNF5tO9R3YJR9WuK1IxgmTIYClkRWw==
X-Gm-Gg: ATEYQzy6uTsJ5pYMz9+Szx/6WzK0jQaG+rAetXD26Z1j770Cc9Du+BXvRsN2gXn/fLH
	LAXym78ganwram/lOoilf52Tt/gMSkapYOsLEYqzvYVgTk40KbsCZ3ZuxRCWZq0PQY4KNClqUUf
	V/woJqET+RrT/N0Q5o41e/JdRfXZGqlNzfu8jUcckF6tq7zkSKOkpfX6jHBQDf+giekg0s5JQlc
	nFRbGVUBy3EFOBs/eeVO27AMokiEwVbZac/wJ6Cgv6VLOnzVW4b4GY7PkRoWKrMjPk+J1QyxEOB
	MFeGDBx3MQ2sBiVqhkRW4FwvNQorfb2HE2YeV9mWbRRpShMdB5+3tSbHvEkvPdZMZtBnlOmQIR1
	qZ/2OxQyJfCFdN05YaBVZnV0S2f1Eha52/1Lngb57RUNmetnOn0inM5tJ8D475JIcpAnEt+PRj+
	wDUQXhnkvu1gr9nVzXgMafEbwfemDnYUvwP9grC4h3CcFpk5oaw9UR4sbp2Q==
X-Received: by 2002:a17:902:ebd2:b0:2aa:d65f:47a2 with SMTP id d9443c01a7336-2b0b0b0dc7amr12805765ad.41.1774389853053;
        Tue, 24 Mar 2026 15:04:13 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:7ceb:99d5:377f:7f66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656b51sm198111705ad.54.2026.03.24.15.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:04:12 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 1/2] sequencer: extract revert message formatting into shared function
Date: Wed, 25 Mar 2026 03:34:00 +0530
Message-ID: <20260324220401.47040-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324220401.47040-1-siddharthasthana31@gmail.com>
References: <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic for formatting revert commit messages (handling "Revert" and
"Reapply" cases, appending "This reverts commit <ref>.", and handling
merge-parent references) currently lives inline in do_pick_commit().
The upcoming replay --revert mode needs to reuse this logic.

Extract all of this into a new sequencer_format_revert_message()
function. The function takes a repository, the subject line, commit,
parent, a use_commit_reference flag, and the output strbuf. It handles
both regular reverts ("Revert "<subject>"") and revert-of-revert cases
("Reapply "<subject>""), and uses refer_to_commit() internally to
format the commit reference.

Update refer_to_commit() to take a struct repository parameter instead
of relying on the_repository, and a bool instead of reading from
replay_opts directly. This makes it usable from the new shared function
without pulling in sequencer-specific state.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 sequencer.c | 78 +++++++++++++++++++++++++++++++----------------------
 sequencer.h | 13 +++++++++
 2 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index aafd0bc959..7bf9d6ad19 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2206,15 +2206,16 @@ static int should_edit(struct replay_opts *opts) {
 	return opts->edit;
 }
 
-static void refer_to_commit(struct replay_opts *opts,
-			    struct strbuf *msgbuf, struct commit *commit)
+static void refer_to_commit(struct repository *r, struct strbuf *msgbuf,
+			    const struct commit *commit,
+			    bool use_commit_reference)
 {
-	if (opts->commit_use_reference) {
+	if (use_commit_reference) {
 		struct pretty_print_context ctx = {
 			.abbrev = DEFAULT_ABBREV,
 			.date_mode.type = DATE_SHORT,
 		};
-		repo_format_commit_message(the_repository, commit,
+		repo_format_commit_message(r, commit,
 					   "%h (%s, %ad)", msgbuf, &ctx);
 	} else {
 		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
@@ -2364,38 +2365,14 @@ static int do_pick_commit(struct repository *r,
 	 */
 
 	if (command == TODO_REVERT) {
-		const char *orig_subject;
-
 		base = commit;
 		base_label = msg.label;
 		next = parent;
 		next_label = msg.parent_label;
-		if (opts->commit_use_reference) {
-			strbuf_commented_addf(&ctx->message, comment_line_str,
-				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
-		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
-			   /*
-			    * We don't touch pre-existing repeated reverts, because
-			    * theoretically these can be nested arbitrarily deeply,
-			    * thus requiring excessive complexity to deal with.
-			    */
-			   !starts_with(orig_subject, "Revert \"")) {
-			strbuf_addstr(&ctx->message, "Reapply \"");
-			strbuf_addstr(&ctx->message, orig_subject);
-			strbuf_addstr(&ctx->message, "\n");
-		} else {
-			strbuf_addstr(&ctx->message, "Revert \"");
-			strbuf_addstr(&ctx->message, msg.subject);
-			strbuf_addstr(&ctx->message, "\"\n");
-		}
-		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
-		refer_to_commit(opts, &ctx->message, commit);
-
-		if (commit->parents && commit->parents->next) {
-			strbuf_addstr(&ctx->message, ", reversing\nchanges made to ");
-			refer_to_commit(opts, &ctx->message, parent);
-		}
-		strbuf_addstr(&ctx->message, ".\n");
+		sequencer_format_revert_message(r, msg.subject, commit,
+						parent,
+						opts->commit_use_reference,
+						&ctx->message);
 	} else {
 		const char *p;
 
@@ -5580,6 +5557,43 @@ int sequencer_pick_revisions(struct repository *r,
 	return res;
 }
 
+void sequencer_format_revert_message(struct repository *r,
+				     const char *subject,
+				     const struct commit *commit,
+				     const struct commit *parent,
+				     bool use_commit_reference,
+				     struct strbuf *message)
+{
+	const char *orig_subject;
+
+	if (use_commit_reference) {
+		strbuf_commented_addf(message, comment_line_str,
+				      "*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
+	} else if (skip_prefix(subject, "Revert \"", &orig_subject) &&
+		   /*
+		    * We don't touch pre-existing repeated reverts, because
+		    * theoretically these can be nested arbitrarily deeply,
+		    * thus requiring excessive complexity to deal with.
+		    */
+		   !starts_with(orig_subject, "Revert \"")) {
+		strbuf_addstr(message, "Reapply \"");
+		strbuf_addstr(message, orig_subject);
+		strbuf_addstr(message, "\n");
+	} else {
+		strbuf_addstr(message, "Revert \"");
+		strbuf_addstr(message, subject);
+		strbuf_addstr(message, "\"\n");
+	}
+	strbuf_addstr(message, "\nThis reverts commit ");
+	refer_to_commit(r, message, commit, use_commit_reference);
+
+	if (commit->parents && commit->parents->next) {
+		strbuf_addstr(message, ", reversing\nchanges made to ");
+		refer_to_commit(r, message, parent, use_commit_reference);
+	}
+	strbuf_addstr(message, ".\n");
+}
+
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 {
 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
diff --git a/sequencer.h b/sequencer.h
index 719684c8a9..56cd50233a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -271,4 +271,17 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
  */
 int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
 
+/*
+ * Format a revert commit message with appropriate 'Revert "<subject>"' or
+ * 'Reapply "<subject>"' prefix and 'This reverts commit <ref>.' body.
+ * When use_commit_reference is set, <ref> is an abbreviated hash with
+ * subject and date; otherwise the full hex hash is used.
+ */
+void sequencer_format_revert_message(struct repository *r,
+				     const char *subject,
+				     const struct commit *commit,
+				     const struct commit *parent,
+				     bool use_commit_reference,
+				     struct strbuf *message);
+
 #endif /* SEQUENCER_H */
-- 
2.51.0

