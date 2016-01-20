From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] merge: add --rename-notes
Date: Wed, 20 Jan 2016 18:06:08 +0700
Message-ID: <1453287968-26000-8-git-send-email-pclouds@gmail.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 12:07:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLqba-0003e2-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 12:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbcATLHL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 06:07:11 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34602 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817AbcATLHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 06:07:08 -0500
Received: by mail-pa0-f65.google.com with SMTP id yy13so253243pab.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uvBrrdGVERrHIBLjkEULXXc4H4qCszb33zDS7CDAYmc=;
        b=jDzJqW/yJVj7MFNUR/uldSr2gdVju4YVeUF9UP0VEfXemF0U5jJ01tDGXD47bZ7nFI
         XjB8peAplcNVC5uuVfL8VAQrPbzvKVkKP7CtU/UpdXE306TRlr0t6IhZdpcn4ltJFKLM
         nRNe2thA4yleZ/CjobzLSlHZ15kdJ9Kij09BnsFnYz/UIvbK7imfYScdM4YEWBvmMI9L
         yMRjHMTjsn0a44Af8a+uuOuYRBFK0TlJbZs5jqKMShGdPqbl+uk2/VEGfq8HPXi9yUIz
         u0xMvgTTe9TLwI0dyPBxmcEexgiKy487YL01t+1m86QqdMMdDM/ZNQqQqQMInGbcuWcN
         aUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=uvBrrdGVERrHIBLjkEULXXc4H4qCszb33zDS7CDAYmc=;
        b=b2wxY43//lCmyQILZge3ixtumus0GhLmKoPKvAXnAledMw4bJaZ/hNXfL8+goGWmUg
         5yGBtpRMoUZjf8bJgwL0lplLFpiKYznxBe9sQwnEmw/03celKFeHPEB9LKHpZ4R3OMsI
         Re0UnkBEaMSDKxCViMJ8vODfhpANECzgHcjerIM+a7a+ZAGW7hw8+qDbFNxkgrSnd1Vm
         8/1Vyi3i2k4pZH4jvPo5Ru5jIDkFh7FHP3xLxwDOHroURhIbLfsjXMHemYagwavHfZ9M
         CIv2K6wMikyEMDitVH8BxLpVWB+wIQDwc+xD+qy6ra0m4oUZ80Ewpriy797akyo5Cd9q
         mmpA==
X-Gm-Message-State: ALoCoQmty9cTH7MQKlRYwPAZ7zZQSy9z1YezHUZsPGr+1D66/ez/ympz4XT90oIzWvWGvZ3J9P2Ti0QkOh17rA/x6T6zTxFqkQ==
X-Received: by 10.66.180.48 with SMTP id dl16mr51133135pac.39.1453288028449;
        Wed, 20 Jan 2016 03:07:08 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id z15sm48008055pfa.71.2016.01.20.03.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 03:07:06 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Jan 2016 18:07:03 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284454>

=46or merge professionals, --rename-file is as bad a nightmare as
resolving conflicts because they may have to create a rename file for
every merge. --rename-notes takes advantage of rename notes to avoid th=
at.

Because rename notes are between commit A and A^, not between A and its
merge base, we need to convert "rename path A to path B" to "rename blo=
b
A' to blob B'" and hope that mere base still has that blob A'.

Merging notes this way is expensive. So it's cached in $GIT_DIR/rename-=
cache.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 114 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 95a6c26..6ad2e52 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -30,6 +30,7 @@
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
 #include "sequencer.h"
+#include "notes.h"
=20
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -69,6 +70,7 @@ static int default_to_upstream =3D 1;
 static const char *sign_commit;
 static const char *rename_file;
 static struct strbuf manual_renames =3D STRBUF_INIT;
+static const char *rename_note_ref;
=20
 static struct strategy all_strategy[] =3D {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -228,6 +230,7 @@ static struct option builtin_merge_options[] =3D {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored=
 files (default)")),
 	OPT_FILENAME(0, "rename-file", &rename_file, N_("--rename-file to dif=
f")),
+	OPT_STRING(0, "rename-notes", &rename_note_ref, N_("note-ref"), N_("-=
-rename-notes to diff")),
 	OPT_END()
 };
=20
@@ -1161,6 +1164,102 @@ static struct commit_list *collect_parents(stru=
ct commit *head_commit,
 	return remoteheads;
 }
=20
+static int merge_rename_note(const unsigned char *object_hash,
+			     const unsigned char *note_hash,
+			     char *note_path,
+			     void *cb_data)
+{
+	struct strbuf *cache =3D cb_data;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *p, *end;
+	enum object_type type;
+	unsigned long size;
+	char *note;
+
+	note =3D read_sha1_file(note_hash, &type, &size);
+	if (type !=3D OBJ_BLOB) {
+		free(note);
+		return 0;
+	}
+
+	p =3D note;
+	end =3D p + strlen(p);
+	while (p < end) {
+		const char *line_end =3D strchr(p, '\n');
+		const char *arrow =3D strstr(p, " =3D> ");
+		const char *src =3D p, *dst;
+		struct object_id src_oid;
+		struct object_id dst_oid;
+
+		if (!line_end)
+			line_end =3D end;
+		p =3D line_end + 1;
+
+		if (!arrow || arrow >=3D line_end)
+			continue;
+
+		if (starts_with(src, "blob ") && src + 4 < arrow) {
+			strbuf_addf(cache, "%.*s\n",
+				    (int)(line_end - src), src);
+			continue;
+		}
+
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s:%.*s", sha1_to_hex(object_hash),
+			    (int)(arrow - src), src);
+		if (get_sha1(sb.buf, src_oid.hash))
+			continue;
+
+		dst =3D arrow + strlen(" =3D> ");
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s:%.*s", sha1_to_hex(object_hash),
+			    (int)(line_end - dst), dst);
+		if (get_sha1(sb.buf, dst_oid.hash))
+			continue;
+
+		strbuf_addf(cache, "blob %s =3D> %s\n",
+			    oid_to_hex(&src_oid),
+			    oid_to_hex(&dst_oid));
+	}
+
+	return 0;
+}
+
+/*
+ * Traverse through the given notes tree, convert all "path to path"
+ * rename lines into "blob to blob" and return it. If cache_file is
+ * non-NULL, return it's content if still valid. Otherwise save the
+ * new content in it.
+ */
+static void merge_rename_notes(struct strbuf *cache,
+			       struct notes_tree *t, const char *cache_file)
+{
+	struct object_id notes_oid;
+
+	if (cache_file) {
+		struct object_id cache_oid;
+
+		strbuf_reset(cache);
+		if (!resolve_ref_unsafe(t->ref, RESOLVE_REF_READING,
+					notes_oid.hash, NULL))
+			return;
+
+		if (strbuf_read_file(cache, cache_file, 0) > GIT_SHA1_HEXSZ + 1 &&
+		    cache->buf[GIT_SHA1_HEXSZ] =3D=3D '\n' &&
+		    !get_oid_hex(cache->buf, &cache_oid) &&
+		    !oidcmp(&notes_oid, &cache_oid)) {
+			strbuf_remove(cache, 0, GIT_SHA1_HEXSZ + 1);
+			return;
+		}
+	}
+
+	strbuf_reset(cache);
+	for_each_note(t, 0, merge_rename_note, cache);
+	if (cache_file && cache->len)
+		write_file(cache_file, "%s\n%s",
+			   oid_to_hex(&notes_oid), cache->buf);
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -1260,10 +1359,25 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
=20
+	if (rename_file && rename_note_ref)
+		die(_("--rename-file and --rename-notes are incompatible"));
+
 	if (rename_file &&
 	    strbuf_read_file(&manual_renames, rename_file, 0) =3D=3D -1)
 		die(_("unable to read %s"), rename_file);
=20
+	if (rename_note_ref) {
+		struct notes_tree rename_notes;
+		struct strbuf ref =3D STRBUF_INIT;
+
+		strbuf_addstr(&ref, rename_note_ref);
+		expand_notes_ref(&ref);
+		init_notes(&rename_notes, ref.buf, NULL, 0);
+		strbuf_release(&ref);
+		merge_rename_notes(&manual_renames, &rename_notes,
+				   git_path("GIT_RENAME_CACHE"));
+	}
+
 	if (!head_commit) {
 		struct commit *remote_head;
 		/*
--=20
2.7.0.125.g9eec362
