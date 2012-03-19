From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 1/2] Unification of user message strings
Date: Mon, 19 Mar 2012 18:51:42 +0100
Message-ID: <1332179503-2992-2-git-send-email-vfr@lyx.org>
References: <1332179503-2992-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 18:52:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9gke-0004O6-D3
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 18:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030646Ab2CSRwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 13:52:06 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46428 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030417Ab2CSRwE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 13:52:04 -0400
Received: by eekc41 with SMTP id c41so2815283eek.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 10:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=IobOxbRbenyxfDnO2/kL4sRtBcyTU0riDAUVwEojXC0=;
        b=WmZpZ/13WsjY6eKKbZCd0q8w9ti1M3cTT9HnpL6tCCT6lMuuP+7Gn1FW/eISk5/bfh
         BTBKcPxAiENSk4dWhuD7tmbji1Q3uTHAQwcuXsiKmUnvJE4hpUxgZyY1YnjQoDUwx9Q4
         TG1bPThkb5PvESrPvHTIM153kS+h0tOBfhu/fKR9HCnZu7saTWvIJx/RvBB+rkUsU9t4
         oNEqpDgXHwTSRAzyTlOoyr9FMRjiI+b4k+7rLUW4K9cUrW8QBPIfh4uvH6cOtpqKK+pV
         /I/MJbeGnMO7FT/mlSXOD0mWLWvB6dfJAbpmA2y+tqNxaMM3Uifjqnfe7PJhmeGvcwLg
         ZsLA==
Received: by 10.14.94.139 with SMTP id n11mr1179004eef.47.1332179523004;
        Mon, 19 Mar 2012 10:52:03 -0700 (PDT)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id m42sm21762289eef.0.2012.03.19.10.52.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 10:52:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1332179503-2992-1-git-send-email-vfr@lyx.org>
X-Gm-Message-State: ALoCoQk7y246JxIWdVTlEfpa+PMZ1Yqo5eW93VjSCT2QiJfRaBX+s3v5Scqwxp0tZ7y3cT4mTGkC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193445>

From: Vincent van Ravesteijn <vfr@lyx.org>

Rewrite user messages to stick to a uniform style for all messages. From the surrounding code, the following guidelines were deduced:
- messages start with a capital,
- short messages do not end with a full stop,
- paths, filenames, and commands are quoted by single quotes (if not separated by the normal text by a ':'),
- 'could not' is used rather than 'cannot'.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 gpg-interface.c |    6 +++---
 grep.c          |    2 +-
 help.c          |    2 +-
 sequencer.c     |   24 ++++++++++++------------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 09ab64a..5e14a21 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -56,7 +56,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	args[3] = NULL;
 
 	if (start_command(&gpg))
-		return error(_("could not run gpg."));
+		return error(_("Could not run 'gpg'"));
 
 	/*
 	 * When the username signingkey is bad, program could be terminated
@@ -68,7 +68,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 		close(gpg.in);
 		close(gpg.out);
 		finish_command(&gpg);
-		return error(_("gpg did not accept the data"));
+		return error(_("'gpg' did not accept the data"));
 	}
 	close(gpg.in);
 
@@ -79,7 +79,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	sigchain_pop(SIGPIPE);
 
 	if (finish_command(&gpg) || !len || len < 0)
-		return error(_("gpg failed to sign the data"));
+		return error(_("'gpg' failed to sign the data"));
 
 	/* Strip CR from the line endings, in case we are on Windows. */
 	for (i = j = bottom; i < signature->len; i++)
diff --git a/grep.c b/grep.c
index 190139c..6e0fef5 100644
--- a/grep.c
+++ b/grep.c
@@ -1277,7 +1277,7 @@ static int grep_source_load_sha1(struct grep_source *gs)
 	grep_read_unlock();
 
 	if (!gs->buf)
-		return error(_("'%s': unable to read %s"),
+		return error(_("%s: unable to read '%s'"),
 			     gs->name,
 			     sha1_to_hex(gs->identifier));
 	return 0;
diff --git a/help.c b/help.c
index 14eefc9..5ab076b 100644
--- a/help.c
+++ b/help.c
@@ -285,7 +285,7 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 
 static const char bad_interpreter_advice[] =
 	N_("'%s' appears to be a git command, but we were not\n"
-	"able to execute it. Maybe git-%s is broken?");
+	"able to execute it. Maybe 'git-%s' is broken?");
 
 const char *help_unknown_cmd(const char *cmd)
 {
diff --git a/sequencer.c b/sequencer.c
index a37846a..1554173 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -156,10 +156,10 @@ static void write_message(struct strbuf *msgbuf, const char *filename)
 	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
 					       LOCK_DIE_ON_ERROR);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno(_("Could not write to %s"), filename);
+		die_errno(_("Could not write to '%s'"), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die(_("Error wrapping up %s"), filename);
+		die(_("Error wrapping up '%s'"), filename);
 }
 
 static struct tree *empty_tree(void)
@@ -588,11 +588,11 @@ static void read_populate_todo(struct commit_list **todo_list,
 
 	fd = open(todo_file, O_RDONLY);
 	if (fd < 0)
-		die_errno(_("Could not open %s"), todo_file);
+		die_errno(_("Could not open '%s'"), todo_file);
 	if (strbuf_read(&buf, fd, 0) < 0) {
 		close(fd);
 		strbuf_release(&buf);
-		die(_("Could not read %s."), todo_file);
+		die(_("Could not read '%s'"), todo_file);
 	}
 	close(fd);
 
@@ -668,7 +668,7 @@ static int create_seq_dir(void)
 		return -1;
 	}
 	else if (mkdir(seq_dir, 0777) < 0)
-		die_errno(_("Could not create sequencer directory %s"), seq_dir);
+		die_errno(_("Could not create sequencer directory '%s'"), seq_dir);
 	return 0;
 }
 
@@ -682,9 +682,9 @@ static void save_head(const char *head)
 	fd = hold_lock_file_for_update(&head_lock, head_file, LOCK_DIE_ON_ERROR);
 	strbuf_addf(&buf, "%s\n", head);
 	if (write_in_full(fd, buf.buf, buf.len) < 0)
-		die_errno(_("Could not write to %s"), head_file);
+		die_errno(_("Could not write to '%s'"), head_file);
 	if (commit_lock_file(&head_lock) < 0)
-		die(_("Error wrapping up %s."), head_file);
+		die(_("Error wrapping up '%s'"), head_file);
 }
 
 static int reset_for_rollback(const unsigned char *sha1)
@@ -729,10 +729,10 @@ static int sequencer_rollback(struct replay_opts *opts)
 		return rollback_single_pick();
 	}
 	if (!f)
-		return error(_("cannot open %s: %s"), filename,
+		return error(_("Could not open '%s': %s"), filename,
 						strerror(errno));
 	if (strbuf_getline(&buf, f, '\n')) {
-		error(_("cannot read %s: %s"), filename, ferror(f) ?
+		error(_("Could not read '%s': %s"), filename, ferror(f) ?
 			strerror(errno) : _("unexpected end of file"));
 		fclose(f);
 		goto fail;
@@ -762,14 +762,14 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
 	if (format_todo(&buf, todo_list, opts) < 0)
-		die(_("Could not format %s."), todo_file);
+		die(_("Could not format '%s'"), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
-		die_errno(_("Could not write to %s"), todo_file);
+		die_errno(_("Could not write to '%s'"), todo_file);
 	}
 	if (commit_lock_file(&todo_lock) < 0) {
 		strbuf_release(&buf);
-		die(_("Error wrapping up %s."), todo_file);
+		die(_("Error wrapping up '%s'"), todo_file);
 	}
 	strbuf_release(&buf);
 }
-- 
1.7.5.4
