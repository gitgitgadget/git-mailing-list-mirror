Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E30245008
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773380448; cv=none; b=cxlZUfD5yeENgDloINwCZN/WSw+SuCStM2VLoUkYpQ5/pwDsjUDKJq8RocputQ8oH4dEDHGu5bqSKUrjokTIwS3aqj9WVKcSFL6Ar0efUkX8VGK9DpNov7JtWfXBEayxp+WlrRtadxQrgh6FvBz/L04MzRdk2oZFdJcTbMsspJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773380448; c=relaxed/simple;
	bh=zxYhIZ9PBd/W373ky1PA+FlutiDoyYs9/BHDq8d1gWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUgP8U0lcXj4wAaG4I8cHhyJsV/V6ze22IFFs7enuZecasfyrG58qWhHaIUDmEC27/czAX0A32NWB66/VUSVuvnjm8tFxVhm50/Nww3Y7T0S4bbA+nLJkmV+KZfoXdm+uyqMa7OSyGiLibVGkNRPPJ3HSt0wI99T9siZFHlCvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvEKMr7E; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvEKMr7E"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c73bb6662d8so461981a12.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 22:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773380446; x=1773985246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofxoD3sBDy4vhsa/ksTL+q4Uklqy1Fo5Tl7L8+dTNu0=;
        b=UvEKMr7EEdHVFZ3knD/brbiZr2E8FuGH1X7vxoADh81q3MapbhGtjZpdOkTgHM9Z8J
         /ElQ6ScmmhzoGooCok5cpceek/0j6+oMrQG8Rh7ceJvbOW+eCnHioxUp8CXmx+IG8cCP
         rzrXoxTrtCdOMArUuYFP02sJ1LPT230ziLO2KnKDwfCF7THMV/G9Q92SyoXTaOIrJBcm
         6y5euCLNGN7jVKLtL1hcVptu7Eycmhm31YE/sv7XSPX2hFhlvFu2hHQsfELC3HQY9yG0
         QrCDtypm5Y9JENhw2HTgMbLntKbEDfE+ni8AilnrMcU+7ZXsS05wH846mHbbqRbQCxB/
         LQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773380446; x=1773985246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ofxoD3sBDy4vhsa/ksTL+q4Uklqy1Fo5Tl7L8+dTNu0=;
        b=FzWfvTQZRdBmBhaScEwc2xfA3yom95TsEq/h3MrE9VbGbXlZ5yyVDPYKOPxa4fEphP
         wGubwK6QLWSQrFzNpdM8b8kgxJIWmj9eBr3S31Jc9DYWLyvWd/RcISa3ZFy+neaJ9BWz
         3woF+HQbN2zpPoIu+x3UivPTrrDyNEuSEK15ZQZljDC2ZPKpuJJGv3hpS7BIxS8bO1nB
         Bhk1L8UUPv2E1iO8X4evOC4+NGtEkqY0oMZAeufVrNqBEy03QDoi7quOMWvmRhV2V9np
         9pdmcwWvPF8C3Q9fy6oTP8hxOEBKqxPmuNy6D6ek+x9hdTfjni8Teas8mJ1QSdfl88Tv
         O1Hg==
X-Gm-Message-State: AOJu0YwSyvC1534JRnyJZhKyYeg6UJNx1dpRKu8zY/SXOEuktr98Pqbz
	Rdg9T7C+VI6CG8hS8YhQmB1+8LqmcavqDAlYS9tUAG685lx/I078jXpwN0orw1en
X-Gm-Gg: ATEYQzxDYDawCDXS7kFp1CMPoswaTspuBG5C71hQvUzoFzCBTi1RhdfrkWs44U+f50e
	7QWSs/hv6mWpRmACEwNLLB8HwEhjKgzMMb6SeYsl59Kn0irlE1eepl0WsQlsOPiZ08+U+DKuW9O
	5Ey2ZUzB2mPekdhXyRew0b90qL24vZSrzBt6OhBe6KKJ9qe/ZH2N2kga2IwTi6dvfSg1E7g8+PH
	Il5SwimBlW/jYAU8Bh9JXZ6VmLYx8w03WajZk3+ikVrOXlaTHKN/4dRaIyqDGJ1vMif4dLtKJgB
	p9UxSyQbDGTwInJEN0YUzgRSpwxTvmOguj0HzbrJCUgtlizijhbl2YjTZj//eu2QCLUzIa/Ws8k
	21BVDcHY4QwyFFpY/RDoAyeFpYrWi36oUeWCzKPIH9qCBG+jMOESZ0u8lSKFJbCO5QvJ7z3La2A
	qvBlqXiJylWcG3W5+rEvBbaUq9aK+a9DsxyT2iz6weXmjbann3PpLESpCKfg==
X-Received: by 2002:a05:6a20:3d86:b0:393:2434:683a with SMTP id adf61e73a8af0-398ece17551mr1701763637.67.1773380445898;
        Thu, 12 Mar 2026 22:40:45 -0700 (PDT)
Received: from localhost ([2409:40e3:308b:f961:6950:2a48:4c4a:2156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb9ed44sm713511a12.34.2026.03.12.22.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 22:40:45 -0700 (PDT)
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
Subject: [PATCH v4 1/2] sequencer: extract revert message formatting into shared function
Date: Fri, 13 Mar 2026 11:10:34 +0530
Message-ID: <20260313054035.26605-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313054035.26605-1-siddharthasthana31@gmail.com>
References: <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-1-siddharthasthana31@gmail.com>
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
 sequencer.h | 14 ++++++++++
 2 files changed, 60 insertions(+), 32 deletions(-)

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
index 719684c8a9..de0bd6e8a2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -271,4 +271,18 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
  */
 int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
 
+/*
+ * Formats a complete revert commit message following standard Git conventions.
+ * Handles regular reverts ("Revert \"<subject>\""), revert of revert cases
+ * ("Reapply \"<subject>\""), and the --reference style. Appends "This reverts
+ * commit <ref>." using either the abbreviated or full commit reference
+ * depending on use_commit_reference. Also handles merge-parent references.
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

