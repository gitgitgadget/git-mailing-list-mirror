Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D679CF
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706591; cv=none; b=hpjfVwKa6ICjfh/Om3Pu2tp/JZo9JmjMV/WvrNJAhCynOJhFMbG/roOvkriKt7kpoCNFpTM3dZ37z4mw187D9tYHfoCyIdEBujxU7VklgfyELE2RAU2pL+9L3uDSZOeE1Pq7xIvLGiaqYuAafdrap+MzvWaqa4sy+2aSMhQF/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706591; c=relaxed/simple;
	bh=FeEv9ZsXI8KBWWC2QZgROLh2ShfhfJr6SYIHxfvDxLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rci25EzKpGzUWAvEohQ8M/GKVevLKjgc+h3/VtOUwRJ2+FhKDCljUAokDl1C9jDkGRFTMO1doEbnEzfF2jkNpXhq0g9RPufbHrU5qPxcDb0MY4R0HjsG1CKRruJmjRschwtpSwVwSzVAqMe0LQlM2FyL0NkKwMuFaSjk0MOxIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1gsuXYt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1gsuXYt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297f35be2ffso89759575ad.2
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764706589; x=1765311389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHfJqfOpw/tZqFMNY9ObgTzQr8maQHPaRR1/0Wq6z7U=;
        b=L1gsuXYt8Inem8RRZegeBY0pUUWSOEIVtWUg0ylLJrvg9EdEMFgd5h2L+xoWsSYjly
         /9agmK03LmFpNpUrMwyY/ZdXzJf2PXFi+1hQdHgRxZx7TM0I40Ceg54Ee5GlJ7fnDx4a
         mKFZERVIHNa6z4IXJP2NwK3ydZcRDaUBSFcszaVFa+iBWbcIOv5dpE4q2GIskzbAgDUZ
         CqwRbzqOKhZZ5Vc6Y9uvc+PYJgVhvwrEz6xBgWdQmEO1eFL4ZU1oXfFyyOL2VUx7Svtg
         uBBs1aXeLezMZL0rYM/HKkDNh5Is9HfvVZWWkg/yadjQkGar4R/lwNK9FTzAcYgz9gDU
         BuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764706589; x=1765311389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IHfJqfOpw/tZqFMNY9ObgTzQr8maQHPaRR1/0Wq6z7U=;
        b=owrlFn/mW7yrQ0aLjcShDdT917LAyDxni+Tam2DcjZPssod/JM5QutFtj+IKbqhxtX
         DeHC3NI9ZPWFeARDXIG9H3HYjUDsSgngQjkWydbA+RrvCz2taRXQ28WLqEXUWTxOow52
         +shHRSsd8f88sJUj5/XgHPRcL/lRgoX9IGmI/oPFoDJLm7kNFrkQ1H3sSe0Ek5LSJU9o
         V6RBhFWp9Js7kqOcc8pkgQe+yrVY3EcX7EUy3G0u7UebWw8xiBoGQ5sJh4eIiwTl0k+P
         rKjbtRTr9paoQA0iU7SAE8P5k6s4Q/FQmg8eUTbERJSFdm6RDm58wXVjG1V8vDitinGu
         Svdg==
X-Gm-Message-State: AOJu0YzH9luUMUYtbuva4Q+IHhIwxj1xgR11SqPbwCJ/FAv1GIdgmQDA
	6WnhEoabKBpSKzEBX70EcdMmlrs8S66JHQr1tfA3ta+j19uUxiPpxwGYo0xZcr25
X-Gm-Gg: ASbGnctc0N7cp8iToXQhyRzma/okypfU3YSADYGBOWw/z8tI1tnz1i0jY7RenlRwJEr
	z4VU5cB+5wKdkDlsFmTtmOXjnHcUPa3GMnffIBJYL0LirVzyVAXxa/kLZt26jK7h8cWhCSzb4IT
	JNv3rX4orI/3gTalJ5Qcfn5zrO3GlQHDIPP/XRqcGAW1hNh7UsoBr8CvWqpjCRG9kwp4RQzqU17
	26aRe2V5OGajsNhcoL62s4l7o0LILtdxx4r5RCzz6coZLaFXs3b14AeS4divmDi/M9YgxuPnZkR
	wDJL98zYPP4tgl1tV/V9NnohIFM5HCDabGn0e/MycTGstVIOQNVz1K6YoujKBBXVAI53yOrlfz4
	HIuIMwzmTvR4JvjD6n95NzOkuYQ4lxm13KcKc0wnSwHJtwBtx/fuzOa92Ft4hfEkEWGUcHKDrG2
	XflO96DPZxBM8nPa+IHr8b8pusMdt8iHTsLdAuBeJwisk6/N/8PxpOnbt+DdIcdg==
X-Google-Smtp-Source: AGHT+IHS7yyVB5xF9kia1rKyReuJ3aNo5M5FOP4qVa3cFCsePjvskLfSr/maE3FBhUp16NkqJlRUug==
X-Received: by 2002:a17:903:388c:b0:298:43f4:cc49 with SMTP id d9443c01a7336-29d65d09227mr6209635ad.24.1764706588359;
        Tue, 02 Dec 2025 12:16:28 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:30a4:b776:698d:fcda:3aba:18d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40acc7sm162058925ad.2.2025.12.02.12.16.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Dec 2025 12:16:27 -0800 (PST)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 1/2] sequencer: extract revert message formatting into shared function
Date: Wed,  3 Dec 2025 01:46:10 +0530
Message-ID: <20251202201611.22137-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202201611.22137-1-siddharthasthana31@gmail.com>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic for formatting revert commit messages (handling "Revert" and
"Reapply" cases) is currently duplicated between sequencer.c and will be
needed by builtin/replay.c.

Extract this logic into a new sequencer_format_revert_header() function
that can be shared. The function handles both regular reverts ("Revert
"<subject>"") and revert-of-revert cases ("Reapply "<subject>"").
Update do_pick_commit() to use the new helper, eliminating code
duplication while preserving the special handling for commit_use_reference.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 sequencer.c | 39 +++++++++++++++++++++++++--------------
 sequencer.h |  8 ++++++++
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5476d39ba9..9f621aef4b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2365,22 +2365,10 @@ static int do_pick_commit(struct repository *r,
 		if (opts->commit_use_reference) {
 			strbuf_commented_addf(&ctx->message, comment_line_str,
 				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
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
+			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
 		} else {
-			strbuf_addstr(&ctx->message, "Revert \"");
-			strbuf_addstr(&ctx->message, msg.subject);
-			strbuf_addstr(&ctx->message, "\"\n");
+			sequencer_format_revert_header(&ctx->message, msg.subject);
 		}
-		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
 		refer_to_commit(opts, &ctx->message, commit);
 
 		if (commit->parents && commit->parents->next) {
@@ -5572,6 +5560,29 @@ int sequencer_pick_revisions(struct repository *r,
 	return res;
 }
 
+void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject)
+{
+	const char *revert_subject;
+
+	if (skip_prefix(orig_subject, "Revert \"", &revert_subject) &&
+	    /*
+	     * We don't touch pre-existing repeated reverts, because
+	     * theoretically these can be nested arbitrarily deeply,
+	     * thus requiring excessive complexity to deal with.
+	     */
+	    !starts_with(revert_subject, "Revert \"")) {
+		strbuf_addstr(out, "Reapply \"");
+		strbuf_addstr(out, revert_subject);
+		strbuf_addch(out, '\n');
+	} else {
+		strbuf_addstr(out, "Revert \"");
+		strbuf_addstr(out, orig_subject);
+		strbuf_addstr(out, "\"\n");
+	}
+
+	strbuf_addstr(out, "\nThis reverts commit ");
+}
+
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 {
 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
diff --git a/sequencer.h b/sequencer.h
index 719684c8a9..114c5d2449 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -271,4 +271,12 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
  */
 int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
 
+/*
+ * Formats a revert commit message header following standard Git conventions.
+ * Handles both regular reverts ("Revert \"<subject>\"") and revert of revert
+ * cases ("Reapply \"<subject>\""). Adds "This reverts commit " at the end.
+ * The caller should append the commit OID after calling this function.
+ */
+void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject);
+
 #endif /* SEQUENCER_H */
-- 
2.51.0

