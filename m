Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C5433291F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470260; cv=none; b=K8vcEOQVbi5ThzwG+Yy2DxncfBb1gCJ+z8JgZdGopRuWXnGR2Je7xWt03VqAptA+LDgy1V0s5h3C8qjKQQ5JpA0pAANs5oIPZiWl3z+4GLxDZTOHZwEFpni+EEbAFw9hxXlO8oO/bKT+4ffc1H3FgNT7wsYGy2BFavyvQYZD+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470260; c=relaxed/simple;
	bh=1K0oJZuHsSPTKKnrV7LGaVAII6Y4iKGsWqzeYW8CuBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoO8l9gUBgiJkgNryTQXAKPoKqm2Hcd991omAG8md8JDupwpU7u/FkG4fPCY6UpT+cQULav6/VlY8AjnR0SBTQ4uISEMXE9pRy2VUt2d0tBxTmMCx2mOZag+JXXpSEQJfwqXBGFKh/Sw2NO12l5hhpJbX5TFsXuD265E7lsq8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOPJSA/4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOPJSA/4"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so179864a91.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774470258; x=1775075058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKDlsAYXK0y79l5z3CamQRmfytcTRgIeBmLKxtshLjA=;
        b=bOPJSA/4trexBOfYE3cNt5b2lk/zrKZmxdak9lKVPzq88yIY2HfBXvbmyjPmFXD1yw
         0fGBhFrKIBAfBoxVvwbodjsb5OytAsnkat9dGpNM8jbGbBZ7glMoJB6iZDm9bwZGXy3k
         9yv6AzlF9GnjHBD1AqS9ovAgOIoBoNC0QnT9rf4DREPicrf3nHPTekcaukx4M9l9UKw6
         nVJvp0bwGEO+xg7+ME10vEeWv26Rn6P2I9Wvej4gV2NCKvvXIidMY7dXtDA+zhupmZBF
         Jb6u05WMy1v1CN/SnAreBFue32BQYc2HiLs+e6GFTBwXc1KIiNiEWHCfon5M08ubWxhn
         MRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470258; x=1775075058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKDlsAYXK0y79l5z3CamQRmfytcTRgIeBmLKxtshLjA=;
        b=BhuUc6t37NzceFxMpnL5GdyF7c/vTbQMg9Yb4ivf6zNSQvGa4Yc96O7r7zRY0zkLze
         af1O7Hdduc/E6rv16X+2JhxPnzQSG9r377QpppDwE7HEU54FN5A6r85WrnquFU66mw/Q
         /hDzWq/kB3ksC/D3be+Mo14ZPksljx5bHDg+f0J/lcKeuqeHWOqDsYovXrKUEkeXMdc0
         E1MMewu2egVHYiuqRjb8r6QkDI9I7oislcvMWmHHIL9ksqjszJuPTHBPaJnlMEnYtvq9
         v3nrStZyh6XPv5kRcet2QcSaNmTfRcB9XOitxIXRVnP32rKJmwHEngtxxFyeafzDpToZ
         PcaQ==
X-Gm-Message-State: AOJu0Ywi5diiRDFO4iqrQe82KhrZRXp1JTfPHx5qtijpbyZvgjkEV1Kl
	M7C7MEI17M5OFs1NdhD0PufLzqweqQOKciScBCjbBlHG3LrgzCq8GYiMXSceiw==
X-Gm-Gg: ATEYQzzqGvv/JljhMP95oyt+BL3ZSQLtXVTLzoyzp+z2sH3AnECcCQeP5E4ZeiZ+uNT
	hYOcGT19hpsvX/SHZsq8wsfEXPeSLIvXdlaV14ylV9FHPe6cxOE100CCE3U1bVDrz92czM1aPbh
	kDHfyhIsVxX+xtf1oLHjjuVWiQ6b2tc4HH3a+KNCXkutGPkivrCf2CpaLHWbeBxLhOXOydxHaFS
	rPmmznpH47IdgwIb3jd39iwstTweAzjEWWc5LCVX9c64wLXE6ZdDYI1uWmcftU1QYjAxMYRcqVS
	qN4uK2rJP7lSZmalwdpPQpbtrXBndak06B27GPO0+GPBvgXNA/Zwhw28/a5LJaZQEgbZiLPYMj/
	6MkKRE1O8eZkZUvhFR8ZeUgJCljf/TgaGi7N6ksO6vctrojOI55QETIBlLFCL5WDuZUnLDLjlP5
	PanaGQSXIP1ZwNf1P5f7tVgFniu0VoNzqLejUJizYxM5P0fCPS3DaTvO+BiA==
X-Received: by 2002:a17:903:196b:b0:2b0:bf0c:cb29 with SMTP id d9443c01a7336-2b0bf0cdce6mr4587035ad.47.1774470258184;
        Wed, 25 Mar 2026 13:24:18 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:a0a6:2ae9:64a5:8a64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8e958csm6912125ad.66.2026.03.25.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:24:17 -0700 (PDT)
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
Subject: [PATCH v6 1/2] sequencer: extract revert message formatting into shared function
Date: Thu, 26 Mar 2026 01:53:53 +0530
Message-ID: <20260325202354.10628-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325202354.10628-1-siddharthasthana31@gmail.com>
References: <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-1-siddharthasthana31@gmail.com>
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

