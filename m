From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/2] remove superfluous newlines in error messages
Date: Sun, 29 Apr 2012 20:28:45 -0400
Message-ID: <1335745726-2583-2-git-send-email-pw@padd.com>
References: <1335745726-2583-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 02:29:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOeUN-0000Wf-It
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 02:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab2D3A3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 20:29:10 -0400
Received: from honk.padd.com ([74.3.171.149]:35040 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab2D3A3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 20:29:09 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id AE0722EB4;
	Sun, 29 Apr 2012 17:29:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 84AE9313F8; Sun, 29 Apr 2012 20:29:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.574.g53b8dd
In-Reply-To: <1335745726-2583-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196525>

The error handling routines add a newline.  Remove
the duplicate ones in error messages.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 builtin/branch.c                       |    2 +-
 builtin/merge-file.c                   |    4 ++--
 builtin/unpack-objects.c               |    2 +-
 compat/win32mmap.c                     |    2 +-
 contrib/examples/builtin-fetch--tool.c |    4 ++--
 fsck.c                                 |    2 +-
 http-push.c                            |    4 ++--
 http.c                                 |    2 +-
 imap-send.c                            |    2 +-
 ll-merge.c                             |    2 +-
 object.c                               |    6 +++---
 sha1_file.c                            |    6 +++---
 transport-helper.c                     |    4 ++--
 unpack-trees.c                         |    2 +-
 vcs-svn/svndump.c                      |    4 ++--
 15 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5f150b4..dc353ff 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -657,7 +657,7 @@ static int edit_branch_description(const char *branch_name)
 	fp = fopen(git_path(edit_description), "w");
 	if ((fwrite(buf.buf, 1, buf.len, fp) < buf.len) || fclose(fp)) {
 		strbuf_release(&buf);
-		return error(_("could not write branch description template: %s\n"),
+		return error(_("could not write branch description template: %s"),
 			     strerror(errno));
 	}
 	strbuf_reset(&buf);
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 237abd3..6f0efef 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -63,7 +63,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	if (quiet) {
 		if (!freopen("/dev/null", "w", stderr))
 			return error("failed to redirect stderr to /dev/null: "
-				     "%s\n", strerror(errno));
+				     "%s", strerror(errno));
 	}
 
 	if (prefix)
@@ -76,7 +76,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		if (read_mmfile(mmfs + i, fname))
 			return -1;
 		if (buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
-			return error("Cannot merge binary files: %s\n",
+			return error("Cannot merge binary files: %s",
 					argv[i]);
 	}
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 14e04e6..2217d7b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -107,7 +107,7 @@ static void *get_data(unsigned long size)
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
 		if (ret != Z_OK) {
-			error("inflate returned %d\n", ret);
+			error("inflate returned %d", ret);
 			free(buf);
 			buf = NULL;
 			if (!recover)
diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index b58aa69..61d2ef8 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -30,7 +30,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 	temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);
 
 	if (!CloseHandle(hmap))
-		warning("unable to close file mapping handle\n");
+		warning("unable to close file mapping handle");
 
 	return temp ? temp : MAP_FAILED;
 }
diff --git a/contrib/examples/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
index 3140e40..0d54aa7 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -518,7 +518,7 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 		filename = git_path("FETCH_HEAD");
 		fp = fopen(filename, "a");
 		if (!fp)
-			return error("cannot open %s: %s\n", filename, strerror(errno));
+			return error("cannot open %s: %s", filename, strerror(errno));
 		result = append_fetch_head(fp, argv[2], argv[3],
 					   argv[4], argv[5],
 					   argv[6], !!argv[7][0],
@@ -536,7 +536,7 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 		filename = git_path("FETCH_HEAD");
 		fp = fopen(filename, "a");
 		if (!fp)
-			return error("cannot open %s: %s\n", filename, strerror(errno));
+			return error("cannot open %s: %s", filename, strerror(errno));
 		result = fetch_native_store(fp, argv[2], argv[3], argv[4],
 					    verbose, force);
 		fclose(fp);
diff --git a/fsck.c b/fsck.c
index 6c855f8..4c63b2c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -27,7 +27,7 @@ static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
 			result = walk(&lookup_blob(entry.sha1)->object, OBJ_BLOB, data);
 		else {
-			result = error("in tree %s: entry %s has bad mode %.6o\n",
+			result = error("in tree %s: entry %s has bad mode %.6o",
 					sha1_to_hex(tree->object.sha1), entry.path, entry.mode);
 		}
 		if (result < 0)
diff --git a/http-push.c b/http-push.c
index f22f7e4..1df7ab5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1108,7 +1108,7 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 				if (repo->path)
 					url = repo->path;
 				if (strncmp(path, url, repo->path_len))
-					error("Parsed path '%s' does not match url: '%s'\n",
+					error("Parsed path '%s' does not match url: '%s'",
 					      path, url);
 				else {
 					path += repo->path_len;
@@ -1702,7 +1702,7 @@ static int delete_remote_branch(const char *pattern, int force)
 		run_active_slot(slot);
 		free(url);
 		if (results.curl_result != CURLE_OK)
-			return error("DELETE request failed (%d/%ld)\n",
+			return error("DELETE request failed (%d/%ld)",
 				     results.curl_result, results.http_code);
 	} else {
 		free(url);
diff --git a/http.c b/http.c
index f3f83d7..ef331bd 100644
--- a/http.c
+++ b/http.c
@@ -906,7 +906,7 @@ static char *fetch_pack_index(unsigned char *sha1, const char *base_url)
 	tmp = strbuf_detach(&buf, NULL);
 
 	if (http_get_file(url, tmp, 0) != HTTP_OK) {
-		error("Unable to get pack index %s\n", url);
+		error("Unable to get pack index %s", url);
 		free(tmp);
 		tmp = NULL;
 	}
diff --git a/imap-send.c b/imap-send.c
index 972ad62..d42e471 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1022,7 +1022,7 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret != strlen(response))
-		return error("IMAP error: sending response failed\n");
+		return error("IMAP error: sending response failed");
 
 	free(response);
 
diff --git a/ll-merge.c b/ll-merge.c
index da59738..f3f7692 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -73,7 +73,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	if (buffer_is_binary(orig->ptr, orig->size) ||
 	    buffer_is_binary(src1->ptr, src1->size) ||
 	    buffer_is_binary(src2->ptr, src2->size)) {
-		warning("Cannot merge binary files: %s (%s vs. %s)\n",
+		warning("Cannot merge binary files: %s (%s vs. %s)",
 			path, name1, name2);
 		return ll_binary_merge(drv_unused, result,
 				       path,
diff --git a/object.c b/object.c
index 49a864c..4af3451 100644
--- a/object.c
+++ b/object.c
@@ -176,7 +176,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			obj = &tag->object;
 		}
 	} else {
-		warning("object %s has unknown type id %d\n", sha1_to_hex(sha1), type);
+		warning("object %s has unknown type id %d", sha1_to_hex(sha1), type);
 		obj = NULL;
 	}
 	if (obj && obj->type == OBJ_NONE)
@@ -202,7 +202,7 @@ struct object *parse_object(const unsigned char *sha1)
 	    (!obj && has_sha1_file(sha1) &&
 	     sha1_object_info(sha1, NULL) == OBJ_BLOB)) {
 		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
-			error("sha1 mismatch %s\n", sha1_to_hex(repl));
+			error("sha1 mismatch %s", sha1_to_hex(repl));
 			return NULL;
 		}
 		parse_blob_buffer(lookup_blob(sha1), NULL, 0);
@@ -213,7 +213,7 @@ struct object *parse_object(const unsigned char *sha1)
 	if (buffer) {
 		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
 			free(buffer);
-			error("sha1 mismatch %s\n", sha1_to_hex(repl));
+			error("sha1 mismatch %s", sha1_to_hex(repl));
 			return NULL;
 		}
 
diff --git a/sha1_file.c b/sha1_file.c
index ad314f0..c8d572d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2417,7 +2417,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 	unlink_or_warn(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
-			return error("unable to write sha1 filename %s: %s\n", filename, strerror(ret));
+			return error("unable to write sha1 filename %s: %s", filename, strerror(ret));
 		}
 		/* FIXME!!! Collision check here ? */
 	}
@@ -2509,9 +2509,9 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	fd = create_tmpfile(tmp_file, sizeof(tmp_file), filename);
 	if (fd < 0) {
 		if (errno == EACCES)
-			return error("insufficient permission for adding an object to repository database %s\n", get_object_directory());
+			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
 		else
-			return error("unable to create temporary sha1 filename %s: %s\n", tmp_file, strerror(errno));
+			return error("unable to create temporary sha1 filename %s: %s", tmp_file, strerror(errno));
 	}
 
 	/* Set it up */
diff --git a/transport-helper.c b/transport-helper.c
index f6b3b1f..61c928f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -199,7 +199,7 @@ static struct child_process *get_helper(struct transport *transport)
 			data->import_marks = strbuf_detach(&arg, NULL);
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
-			    "helper probably needs newer version of Git.\n",
+			    "helper probably needs newer version of Git.",
 			    capname);
 		}
 	}
@@ -599,7 +599,7 @@ static void push_update_ref_status(struct strbuf *buf,
 		status = REF_STATUS_REMOTE_REJECT;
 		refname = buf->buf + 6;
 	} else
-		die("expected ok/error, helper said '%s'\n", buf->buf);
+		die("expected ok/error, helper said '%s'", buf->buf);
 
 	msg = strchr(refname, ' ');
 	if (msg) {
diff --git a/unpack-trees.c b/unpack-trees.c
index 36523da..7cfa026 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1792,7 +1792,7 @@ int bind_merge(struct cache_entry **src,
 	struct cache_entry *a = src[1];
 
 	if (o->merge_size != 1)
-		return error("Cannot do a bind merge of %d trees\n",
+		return error("Cannot do a bind merge of %d trees",
 			     o->merge_size);
 	if (a && old)
 		return o->gently ? -1 :
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 644fdc7..0899790 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -175,7 +175,7 @@ static void read_props(void)
 		int ch;
 
 		if (!type || t[1] != ' ')
-			die("invalid property line: %s\n", t);
+			die("invalid property line: %s", t);
 		len = atoi(&t[2]);
 		strbuf_reset(&val);
 		buffer_read_binary(&input, &val, len);
@@ -201,7 +201,7 @@ static void read_props(void)
 			strbuf_reset(&key);
 			continue;
 		default:
-			die("invalid property line: %s\n", t);
+			die("invalid property line: %s", t);
 		}
 	}
 }
-- 
1.7.10.572.ged86f
