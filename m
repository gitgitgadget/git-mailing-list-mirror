Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DE146D55
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266226; cv=none; b=CuKvOud0aNDDmT/D9xj9QeoPtoi9aL+l4Ap+QiQTRjyhhjb6/aO++PaecqNrPk/L4AXHoyGfds60KGxKhktiEmaKc6pNUtGRquWZ00aW7Gi0olrjR07/pEqjJpEy7RVO/8x9PcUGASmN5/IGbmb8guOLAkEoCQDCEtSzD/Z1nJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266226; c=relaxed/simple;
	bh=3ZsC7S4LlwLkYNgDoavw9OOpvxHFDLrx0UuUvoeZDAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcrpKHjVO3njpIQa2bMRRgirtgUrVRcg7YgP4tpqekTBrUC1z8bPif83tB7Yz/jBHkR6jj71l0pR2+NABP0fyKj+mxsVD48m8TtPSq7XqvxiHLzVSQQ1b8ozl0bARtPA84RGKwzFgDRQQEGIR27dbVT6S3xEgiCEBckPfgoPaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HOcPTB+H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wjJNtIzx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HOcPTB+H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wjJNtIzx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HOcPTB+H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wjJNtIzx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HOcPTB+H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wjJNtIzx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EBFF1F7A3;
	Mon, 29 Jul 2024 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722266222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkM+aa3HY/YUYGkb4JeRb0JN1uqd88rxb8Ps8hLkl9Y=;
	b=HOcPTB+Hn7mujoz0BfecRV4/m087Hyi+Uham4xcrd26pNjkJNAhoD1t7mljnPSkUCXL/r/
	ViQimnD3piUzs9xt/ft0FVuoYXCq23gDKl9YwNHUzyl7nRTninyKG5KDCpz/nDEjIPs1cm
	gq+CNJ2IoVpHrLsMRBxXBtrj+c5TYpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722266222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkM+aa3HY/YUYGkb4JeRb0JN1uqd88rxb8Ps8hLkl9Y=;
	b=wjJNtIzxsAcS9CVL2HOBPyk0toYIA1eJECofXkGzCDGij0/GnFFKJxgowuTmivkA7+0mrA
	cHlvumAXTuSamcDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722266222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkM+aa3HY/YUYGkb4JeRb0JN1uqd88rxb8Ps8hLkl9Y=;
	b=HOcPTB+Hn7mujoz0BfecRV4/m087Hyi+Uham4xcrd26pNjkJNAhoD1t7mljnPSkUCXL/r/
	ViQimnD3piUzs9xt/ft0FVuoYXCq23gDKl9YwNHUzyl7nRTninyKG5KDCpz/nDEjIPs1cm
	gq+CNJ2IoVpHrLsMRBxXBtrj+c5TYpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722266222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkM+aa3HY/YUYGkb4JeRb0JN1uqd88rxb8Ps8hLkl9Y=;
	b=wjJNtIzxsAcS9CVL2HOBPyk0toYIA1eJECofXkGzCDGij0/GnFFKJxgowuTmivkA7+0mrA
	cHlvumAXTuSamcDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4345F1368A;
	Mon, 29 Jul 2024 15:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +NPyDm6yp2aIdwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 29 Jul 2024 15:17:02 +0000
From: David Disseldorp <ddiss@suse.de>
To: git@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 1/1] notes: do not trigger editor when adding an empty note
Date: Mon, 29 Jul 2024 17:14:00 +0200
Message-ID: <20240729151639.19192-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729151639.19192-1-ddiss@suse.de>
References: <20240729151639.19192-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.60 / 50.00];
	REPLY(-4.00)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.60

With "git notes add -C $blob", the given blob contents are to be made
into a note without involving an editor.  But when "--allow-empty" is
given, the editor is invoked, which can cause problems for
non-interactive callers[1].

This behaviour started with 90bc19b3ae (notes.c: introduce
'--separator=<paragraph-break>' option, 2023-05-27), which changed
editor invocation logic to check for a zero length note_data buffer.

Restore the original behaviour of "git note" that takes the contents
given via the "-m", "-C", "-F" options without invoking an editor, by
checking for any prior parameter callbacks, indicated by a non-zero
note_data.msg_nr.  Remove the now-unneeded note_data.given flag.

Add a test for this regression by checking whether GIT_EDITOR is
invoked alongside "git notes add -C $empty_blob --allow-empty"

[1] https://github.com/ddiss/icyci/issues/12

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 builtin/notes.c  | 22 ++++++++++------------
 t/t3301-notes.sh |  5 +++++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d9c356e354..4cc5bfedc3 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -114,7 +114,6 @@ struct note_msg {
 };
 
 struct note_data {
-	int given;
 	int use_editor;
 	int stripspace;
 	char *edit_path;
@@ -193,7 +192,7 @@ static void write_commented_object(int fd, const struct object_id *object)
 static void prepare_note_data(const struct object_id *object, struct note_data *d,
 		const struct object_id *old_note)
 {
-	if (d->use_editor || !d->given) {
+	if (d->use_editor || !d->msg_nr) {
 		int fd;
 		struct strbuf buf = STRBUF_INIT;
 
@@ -201,7 +200,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 		d->edit_path = git_pathdup("NOTES_EDITMSG");
 		fd = xopen(d->edit_path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 
-		if (d->given)
+		if (d->msg_nr)
 			write_or_die(fd, d->buf.buf, d->buf.len);
 		else if (old_note)
 			copy_obj_to_fd(fd, old_note);
@@ -515,7 +514,6 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	if (d.msg_nr)
 		concat_messages(&d);
-	d.given = !!d.buf.len;
 
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
@@ -528,7 +526,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	if (note) {
 		if (!force) {
 			free_notes(t);
-			if (d.given) {
+			if (d.msg_nr) {
 				free_note_data(&d);
 				return error(_("Cannot add notes. "
 					"Found existing notes for object %s. "
@@ -690,14 +688,14 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		usage_with_options(usage, options);
 	}
 
-	if (d.msg_nr)
+	if (d.msg_nr) {
 		concat_messages(&d);
-	d.given = !!d.buf.len;
-
-	if (d.given && edit)
-		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
-			"for the 'edit' subcommand.\n"
-			"Please use 'git notes add -f -m/-F/-c/-C' instead.\n"));
+		if (edit)
+			fprintf(stderr, _("The -m/-F/-c/-C options have been "
+				"deprecated for the 'edit' subcommand.\n"
+				"Please use 'git notes add -f -m/-F/-c/-C' "
+				"instead.\n"));
+	}
 
 	object_ref = 1 < argc ? argv[1] : "HEAD";
 
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 536bd11ff4..c0dbacc161 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1557,4 +1557,9 @@ test_expect_success 'empty notes are displayed by git log' '
 	test_cmp expect actual
 '
 
+test_expect_success 'empty notes do not invoke the editor' '
+	test_commit 18th &&
+	GIT_EDITOR="false" git notes add -C "$empty_blob" --allow-empty
+'
+
 test_done
-- 
2.43.0

