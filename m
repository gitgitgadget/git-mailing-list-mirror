Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60B2C2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8031E20643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPQleFu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLXLFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40818 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfLXLFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so15775914qkg.7
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YlNOBbYAcOpwwPjd99hpmWTBnvLFoWj33D3WEAz/l9k=;
        b=OPQleFu98UGv+hlH29+ZyWpq8K3H5qBz37ScfFMZXlcj8PzGrrl7te4edM9kzvz8Ym
         6QGih8uOJm97OxaJpNvFM3jby9WNqyliaUvKQ64o1IPiA23uU00B8YDvHZFVQMybKwbA
         13georxYa/3Wz1BERtMCSMIjaGnXekGP90SOTztcqqjpQJtxe8poDti0wuVXRuj4dnW8
         GVNTHwd3c7uOuCw3xAzXxTeLseidCPKwmA6uJ6Y5vimgWaiyzziHUS/FJIf6bpRoeKDJ
         LvtVWxg3BDeLS2KmQCq88lMjSitXWbg/Rqga48OKrKsl3IZjY/KMWmspEk72XhuQYBLs
         9QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YlNOBbYAcOpwwPjd99hpmWTBnvLFoWj33D3WEAz/l9k=;
        b=EhHP3bxLWC93vbl/TsfCRTtKH58qJVrpQqhYlDbUN0SsTb462VFoZxkmMASbvaWxub
         xBk78RiW54bxsXMXHH7mXX84Uqr5pezq5pRTeBPMVHou3ijd70mjXOgaLb5jBEr3h5mn
         R1aZdWzCAe8K2mAPTius1CQPHtu2Q21pl6CY8PlyFRx2AsXVcq0Rr39xAnMS4SmcsEr4
         7fvv4NAZmWxzdLelnVWKyF4IrVLxcU4fwRfOcP7gX6c3YgLRn2EwXh4CkhGXQKIZCQp3
         VrtWMcHBIMEMHRwqvp0ssa6i+e27ciDZW/DZikSaSKkkwL8bK3Ty9ZQKj5OagCAi1KcR
         SeYA==
X-Gm-Message-State: APjAAAXJ6L5yorR70Q9Lfs4TYRRfdE6vulWl4zclKP2xN+PXLZ1GmTq9
        YgIRlqajarIj+sc0bR90Y0SON/Ck
X-Google-Smtp-Source: APXvYqwODRIypAISTgrEzwrN77bV5M+tjq7IIQ0TiJEMIyDg6Wc5/mwD8dT3JfN8uJZUvILgWoi4lw==
X-Received: by 2002:a05:620a:1522:: with SMTP id n2mr29983986qkk.108.1577185550698;
        Tue, 24 Dec 2019 03:05:50 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:50 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 04/17] sequencer: configurably warn on non-existent files
Date:   Tue, 24 Dec 2019 06:05:01 -0500
Message-Id: <fd547aab491b24a47f683d717c6b77255ac16901.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on externing read_oneliner(). Future users of
read_oneliner() will want the ability to output warnings in the event
that the `path` doesn't exist. Introduce the `warn_nonexistence`
parameter which, if true, would issue a warning when a file doesn't
exist by skipping the `!file_exists()` check and letting
`strbuf_read_file()` handle that case.

Mechanically replace uses of read_oneliner() in sequencer.c with the
following spatch so that current behaviour is maintained:

	@@
	expression a, b, c;
	@@
	  read_oneliner(a, b, c
	+ , 0
	  )

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5ba8b4383f..103cea1460 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -426,13 +426,13 @@ static int write_message(const void *buf, size_t len, const char *filename,
  *
  * Returns 1 if the file was read, 0 if it could not be read or does not exist.
  */
-static int read_oneliner(struct strbuf *buf,
-	const char *path, int skip_if_empty)
+static int read_oneliner(struct strbuf *buf, const char *path,
+			 int skip_if_empty, int warn_nonexistence)
 {
 	int ret = 0;
 	struct strbuf file_buf = STRBUF_INIT;
 
-	if (!file_exists(path))
+	if (!warn_nonexistence && !file_exists(path))
 		return 0;
 
 	if (strbuf_read_file(&file_buf, path, 0) < 0) {
@@ -2558,10 +2558,10 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 {
 	strbuf_reset(buf);
-	if (!read_oneliner(buf, rebase_path_strategy(), 0))
+	if (!read_oneliner(buf, rebase_path_strategy(), 0, 0))
 		return;
 	opts->strategy = strbuf_detach(buf, NULL);
-	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
+	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0, 0))
 		return;
 
 	parse_strategy_opts(opts, buf->buf);
@@ -2572,7 +2572,7 @@ static int read_populate_opts(struct replay_opts *opts)
 	if (is_rebase_i(opts)) {
 		struct strbuf buf = STRBUF_INIT;
 
-		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1, 0)) {
 			if (!starts_with(buf.buf, "-S"))
 				strbuf_reset(&buf);
 			else {
@@ -2582,7 +2582,7 @@ static int read_populate_opts(struct replay_opts *opts)
 			strbuf_reset(&buf);
 		}
 
-		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
+		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1, 0)) {
 			if (!strcmp(buf.buf, "--rerere-autoupdate"))
 				opts->allow_rerere_auto = RERERE_AUTOUPDATE;
 			else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
@@ -2618,7 +2618,7 @@ static int read_populate_opts(struct replay_opts *opts)
 		strbuf_release(&buf);
 
 		if (read_oneliner(&opts->current_fixups,
-				  rebase_path_current_fixups(), 1)) {
+				  rebase_path_current_fixups(), 1, 0)) {
 			const char *p = opts->current_fixups.buf;
 			opts->current_fixup_count = 1;
 			while ((p = strchr(p, '\n'))) {
@@ -2627,7 +2627,7 @@ static int read_populate_opts(struct replay_opts *opts)
 			}
 		}
 
-		if (read_oneliner(&buf, rebase_path_squash_onto(), 0)) {
+		if (read_oneliner(&buf, rebase_path_squash_onto(), 0, 0)) {
 			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0)
 				return error(_("unusable squash-onto"));
 			opts->have_squash_onto = 1;
@@ -3759,7 +3759,7 @@ static int apply_autostash(struct replay_opts *opts)
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1)) {
+	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1, 0)) {
 		strbuf_release(&stash_sha1);
 		return 0;
 	}
@@ -4093,7 +4093,7 @@ static int pick_commits(struct repository *r,
 		if (todo_list->current < todo_list->nr)
 			return 0;
 
-		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
+		if (read_oneliner(&head_ref, rebase_path_head_name(), 0, 0) &&
 				starts_with(head_ref.buf, "refs/")) {
 			const char *msg;
 			struct object_id head, orig;
@@ -4106,13 +4106,13 @@ static int pick_commits(struct repository *r,
 				strbuf_release(&buf);
 				return res;
 			}
-			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
+			if (!read_oneliner(&buf, rebase_path_orig_head(), 0, 0) ||
 					get_oid_hex(buf.buf, &orig)) {
 				res = error(_("could not read orig-head"));
 				goto cleanup_head_ref;
 			}
 			strbuf_reset(&buf);
-			if (!read_oneliner(&buf, rebase_path_onto(), 0)) {
+			if (!read_oneliner(&buf, rebase_path_onto(), 0, 0)) {
 				res = error(_("could not read 'onto'"));
 				goto cleanup_head_ref;
 			}
@@ -4145,7 +4145,7 @@ static int pick_commits(struct repository *r,
 				DIFF_FORMAT_DIFFSTAT;
 			log_tree_opt.disable_stdin = 1;
 
-			if (read_oneliner(&buf, rebase_path_orig_head(), 0) &&
+			if (read_oneliner(&buf, rebase_path_orig_head(), 0, 0) &&
 			    !get_oid(buf.buf, &orig) &&
 			    !get_oid("HEAD", &head)) {
 				diff_tree_oid(&orig, &head, "",
@@ -4230,7 +4230,7 @@ static int commit_staged_changes(struct repository *r,
 
 		if (get_oid("HEAD", &head))
 			return error(_("cannot amend non-existing commit"));
-		if (!read_oneliner(&rev, rebase_path_amend(), 0))
+		if (!read_oneliner(&rev, rebase_path_amend(), 0, 0))
 			return error(_("invalid file: '%s'"), rebase_path_amend());
 		if (get_oid_hex(rev.buf, &to_amend))
 			return error(_("invalid contents: '%s'"),
@@ -4391,7 +4391,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 		struct strbuf buf = STRBUF_INIT;
 		struct object_id oid;
 
-		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
+		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1, 0) &&
 		    !get_oid_committish(buf.buf, &oid))
 			record_in_rewritten(&oid, peek_command(&todo_list, 0));
 		strbuf_release(&buf);
-- 
2.24.1.810.g65a2f617f4

