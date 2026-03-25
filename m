Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1579372EC8
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470246; cv=none; b=G0TwE0yIIeWIyEJZ14Lgdei642Ttqpb7SbejQQpAJJmn43Vjk3HF2g1VhQ4CEqiFVduGnWAvdwtchta/it3tMYi/CuGtsIy9q48Fd+6G5Qxt/tEA+LTV+YvBbME8tlW4F65SOd0KXpIRYwlxnXJ2uhVoHYi3mYJP6w9m77A4uMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470246; c=relaxed/simple;
	bh=1K0oJZuHsSPTKKnrV7LGaVAII6Y4iKGsWqzeYW8CuBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr/YfQb67LB22XBoqZqHICtFTyEqBYYQAysOXYbnzE/qpQH7TuzmkfTjyV54uhFLgUxxUpPcbDPWRYG3gQHiC8EQlDd9IE0HI/NnJSoS1E05gUTwk4aForXXo428ygANTs9I8PAdH/o6gK1YkJh8id+8mQCChVQeEbPbbGunQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwFNwmPK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwFNwmPK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8298fad2063so153901b3a.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774470244; x=1775075044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKDlsAYXK0y79l5z3CamQRmfytcTRgIeBmLKxtshLjA=;
        b=PwFNwmPKZY/sONCM459YeXSLsj97ZQKSChJPkRjaoMQIHl1o51uEELeVZ/Jm07BKyt
         oOYmmlyQXGa79sXK+Ku/G9vYabEXJ1+o9Llv4C44UDM0FrYqx2y7r4TtcKCrRTJhSuZd
         HSRx6g+wpyahbfQ1GPSIBr3mjxY9ZuQ6jluTSOYeo2pjDthjx+XtfxkG5VJedkPH4PtF
         sGeL8rgEK9nbkKhMp5cMBFQybrTiXGx1ktQbHZqCBmcquyKP0mnhieyu3LHAGEY3VblD
         r1Ds25wAS05uc1m5CK2LBf9RLrFPv++DCSlWRa6rCEorL3eOqOHG75yYXPKBc8Y77MPV
         UXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470244; x=1775075044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKDlsAYXK0y79l5z3CamQRmfytcTRgIeBmLKxtshLjA=;
        b=lAiDVHfmpRkGH5MBd6YumfsPFucPMWNx5o87ckhZ5l+svTwJhmPIz+nFYU6iOSoHho
         ygiejWhGnow+2ABLfgZHqJhxTBWe8BSJo/pbeirP848EyN39jwV0Ko68xNoJ84Kp/opC
         n7ZbnFIhwYvlG6Theb3QWmYpO3qfn9V57TuBGwxo4IKqRmNgdjw6qxJ7df4O7flKErmO
         DEq3WHc9Gk3cWC9GUgd1WtVC45RS9cEnHybjehLi99t3fLbdfIs/U+5KOPzjwVioZv9i
         RIbRkofKCdBMVZvkBEdu9GIiBEp6bbRM033ksVtoapjKMrRny8aAIuPTtJfBjaMSfq1M
         GSdw==
X-Gm-Message-State: AOJu0Yy8Y6U640RByeMSrYY+gTm+jZa6KcPQppEhA6xIsb0SkrJXHFjk
	iffASpRsywFTqNMSKGDTXBEjlEKPaadRQRhUzWwtsifHu3vw+dNU1yEuVCpR8w==
X-Gm-Gg: ATEYQzwdLskIjGKDJU+3f+Fjcp3TpsebjlMT5DKS0rzVCidW3zR3DUCsvR1KG6zwU9C
	Tfm3R/HNgoPq3PmZ3zeeu9Q5YENE/CO6/wrPd91IeLvTjUCd3yjiwpPi3VAuz34RvQgv8z4N1dJ
	8bIxoQtWV1y7TudRoERq3BIswMmz8SID0+6lCqtLtyGXHGQUAZTWiS0oZuIe4I4kBCqI8P5E0DI
	kIdEoZFn3P4UPWDTs94l+WC/nwOAkLvwY0R0S0taFrGV5IaItlwN/mGkBn13derpz0U/5u1IG6y
	C+5N975+U1XHyAdGXhwCQBHj9MxbFBAHokuXfV2bWBNVYS7QohkK8lmDcwys7IzkmwJRB05qEpE
	VBMTywJ0JG8FkbjL+cG+f1pYuUiMJ6ywubgKdEXtvnoNH3P249PNtmGCSmuK/v+6God0nxy8iX5
	FKHR7FC/lZA5MdrLxj4gnBsId2f7rcv+xvL4WAV5dZ9RmNIVOx+YdCI8I+OQ==
X-Received: by 2002:a05:6a00:1c81:b0:82c:21df:807a with SMTP id d2e1a72fcca58-82c6df06b38mr4868040b3a.26.1774470243912;
        Wed, 25 Mar 2026 13:24:03 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:a0a6:2ae9:64a5:8a64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d388d11sm507208b3a.28.2026.03.25.13.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:24:03 -0700 (PDT)
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
Date: Thu, 26 Mar 2026 01:53:51 +0530
Message-ID: <20260325202354.10628-2-siddharthasthana31@gmail.com>
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

