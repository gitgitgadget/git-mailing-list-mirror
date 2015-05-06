From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] fixed translation in config file to enhance user output
 message from the porcelain command(git config). This fixes the error and die
 function by wrapping it in the _(...) function. This also avoid the code from
 breaking
Date: Wed, 6 May 2015 19:51:13 +0100
Message-ID: <554a6462.c2bbb40a.1e2a.0255@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed May 06 20:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq4Wu-0000VU-W4
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 20:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbbEFS6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 14:58:45 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38084 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbEFS6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 14:58:44 -0400
Received: by wiun10 with SMTP id n10so33542087wiu.1
        for <git@vger.kernel.org>; Wed, 06 May 2015 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=wAilDbkMp5VX80iVZfZRgqo0T6joOKDMQf7rUkeYjFA=;
        b=tBuaWvGtk5qSDCVQG5tCdaLvxCS0Fku+TG/76yZOSR9pOc7MERKmze9y6cVXG3LIIi
         nn06zUangZq4uEv1DwUx37co41zjdk1P3xKdwT/FzYLcvZsQRMjA6iMVlTjUKvdcgfmR
         PolC/oQtGr3NZN0jZF6KefRFT83OHvBvhiqaWhs6cVHbNP9G2IxPDJOR/stYH0U4MCXu
         zT7O/Fy7/tMm0x56W9kyaMigEndnKKcYs1hi8HvRDJ3FQIaEk5rb1IL9ATsecUbMoAYD
         OkB/vU5aBqUEUc9IOqydoiC5D39Pbt98UiSQZseBbW4hPhXbOravYojqdllkH3H13Ad/
         CffQ==
X-Received: by 10.181.29.36 with SMTP id jt4mr16141830wid.21.1430938722881;
        Wed, 06 May 2015 11:58:42 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id fu2sm24238wic.20.2015.05.06.11.58.41
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 11:58:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268481>

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 config.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/config.c b/config.c
index 66c0a51..cc41dbb 100644
--- a/config.c
+++ b/config.c
@@ -76,7 +76,7 @@ static int config_buf_ungetc(int c, struct config_source *conf)
 	if (conf->u.buf.pos > 0) {
 		conf->u.buf.pos--;
 		if (conf->u.buf.buf[conf->u.buf.pos] != c)
-			die("BUG: config_buf can only ungetc the same character");
+			die(_("BUG: config_buf can only ungetc the same character"));
 		return c;
 	}
 
@@ -106,7 +106,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 
 	expanded = expand_user_path(path);
 	if (!expanded)
-		return error("Could not expand include path '%s'", path);
+		return error(_("Could not expand include path '%s'"), path);
 	path = expanded;
 
 	/*
@@ -117,7 +117,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		char *slash;
 
 		if (!cf || !cf->path)
-			return error("relative config includes must come from files");
+			return error(_("relative config includes must come from files"));
 
 		slash = find_last_dir_sep(cf->path);
 		if (slash)
@@ -177,7 +177,7 @@ int git_config_parse_parameter(const char *text,
 
 	pair = strbuf_split_str(text, '=', 2);
 	if (!pair[0])
-		return error("bogus config parameter: %s", text);
+		return error(_("bogus config parameter: %s"), text);
 
 	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=') {
 		strbuf_setlen(pair[0], pair[0]->len - 1);
@@ -189,7 +189,7 @@ int git_config_parse_parameter(const char *text,
 	strbuf_trim(pair[0]);
 	if (!pair[0]->len) {
 		strbuf_list_free(pair);
-		return error("bogus config parameter: %s", text);
+		return error(_("bogus config parameter: %s"), text);
 	}
 	strbuf_tolower(pair[0]);
 	if (fn(pair[0]->buf, value, data) < 0) {
@@ -854,7 +854,7 @@ static int git_default_core_config(const char *var, const char *value)
 			comment_line_char = value[0];
 			auto_comment_line_char = 0;
 		} else
-			return error("core.commentChar should only be one character");
+			return error(_("core.commentChar should only be one character"));
 		return 0;
 	}
 
@@ -949,7 +949,7 @@ static int git_default_branch_config(const char *var, const char *value)
 		else if (!strcmp(value, "always"))
 			autorebase = AUTOREBASE_ALWAYS;
 		else
-			return error("Malformed value for %s", var);
+			return error(_("Malformed value for %s"), var);
 		return 0;
 	}
 
@@ -976,8 +976,8 @@ static int git_default_push_config(const char *var, const char *value)
 			push_default = PUSH_DEFAULT_CURRENT;
 		else {
 			error("Malformed value for %s: %s", var, value);
-			return error("Must be one of nothing, matching, simple, "
-				     "upstream or current.");
+			return error(_("Must be one of nothing, matching, simple, "
+				     "upstream or current."));
 		}
 		return 0;
 	}
@@ -1124,10 +1124,10 @@ static int git_config_from_blob_sha1(config_fn_t fn,
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-		return error("unable to load config blob object '%s'", name);
+		return error(_("unable to load config blob object '%s'"), name);
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return error("reference '%s' does not point to a blob", name);
+		return error(_("reference '%s' does not point to a blob"), name);
 	}
 
 	ret = git_config_from_buf(fn, name, buf, size, data);
@@ -1143,7 +1143,7 @@ static int git_config_from_blob_ref(config_fn_t fn,
 	unsigned char sha1[20];
 
 	if (get_sha1(name, sha1) < 0)
-		return error("unable to resolve config blob '%s'", name);
+		return error(_("unable to resolve config blob '%s'"), name);
 	return git_config_from_blob_sha1(fn, name, sha1, data);
 }
 
@@ -1173,7 +1173,7 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
 {
 	const char *v = getenv(k);
 	if (v && !git_parse_ulong(v, &val))
-		die("failed to parse %s", k);
+		die(_("failed to parse %s"), k);
 	return val;
 }
 
@@ -1720,7 +1720,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 
 static int write_error(const char *filename)
 {
-	error("failed to write new configuration file %s", filename);
+	error(_("failed to write new configuration file %s"), filename);
 
 	/* Same error code as "failed to rename". */
 	return 4;
@@ -1859,12 +1859,12 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	 */
 
 	if (last_dot == NULL || last_dot == key) {
-		error("key does not contain a section: %s", key);
+		error(_("key does not contain a section: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	if (!last_dot[1]) {
-		error("key does not contain variable name: %s", key);
+		error(_("key does not contain variable name: %s"), key);
 		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
@@ -1886,12 +1886,12 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 		if (!dot || i > baselen) {
 			if (!iskeychar(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
-				error("invalid key: %s", key);
+				error(_("invalid key: %s"), key);
 				goto out_free_ret_1;
 			}
 			c = tolower(c);
 		} else if (c == '\n') {
-			error("invalid key (newline): %s", key);
+			error(_("invalid key (newline): %s"), key);
 			goto out_free_ret_1;
 		}
 		(*store_key)[i] = c;
@@ -2113,7 +2113,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	}
 
 	if (commit_lock_file(lock) < 0) {
-		error("could not commit config file %s", config_filename);
+		error(_("could not commit config file %s"), config_filename);
 		ret = CONFIG_NO_WRITE;
 		lock = NULL;
 		goto out_free;
@@ -2228,7 +2228,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	lock = xcalloc(1, sizeof(struct lock_file));
 	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (out_fd < 0) {
-		ret = error("could not lock config file %s", config_filename);
+		ret = error(_("could not lock config file %s"), config_filename);
 		goto out;
 	}
 
@@ -2240,7 +2240,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	fstat(fileno(config_file), &st);
 
 	if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
-		ret = error("chmod on %s failed: %s",
+		ret = error(_("chmod on %s failed: %s"),
 				lock->filename.buf, strerror(errno));
 		goto out;
 	}
@@ -2295,7 +2295,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	fclose(config_file);
 unlock_and_out:
 	if (commit_lock_file(lock) < 0)
-		ret = error("could not commit config file %s", config_filename);
+		ret = error(_("could not commit config file %s"), config_filename);
 out:
 	free(filename_buf);
 	return ret;
@@ -2313,7 +2313,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 #undef config_error_nonbool
 int config_error_nonbool(const char *var)
 {
-	return error("Missing value for '%s'", var);
+	return error(_("Missing value for '%s'"), var);
 }
 
 int parse_config_key(const char *var,
-- 
2.4.0.dirty
