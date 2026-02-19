Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049233AD9A
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506012; cv=none; b=lBKx+pC3eWdzfJjx3/YGufmZNobWgwa/OCXeXzFAAnDzp9GUotX3XtNfzicGKUJudOmDllp/dvBlRtSRSJitWuvt2aDK06kM6rynBSVKU+YzJL253+kLlxNU/FEAuVj60EWwbeFBs51KUgeBI+sHmrWU/SknuGDqebp07ZcarRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506012; c=relaxed/simple;
	bh=CkSpUr8OeU/zMY4EE80/ARQPf8JPyB9kTkNHyUiypWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hse8eEpurKoG5XKW4Xrs8flKT72U6OibC1rboEaPB4/FWfBE9zZ4iMrRJYXwvNARtKm76XcxKM0wHBOZT5aR+VSOwpI0tLtuEMvPVqsspFmDsVQxd+gOExpDXoZDNonmC9idTOsIDULFLNLPDBZ2cNQ2+7MCxLbo/NNeGxsjXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iT1UVKox; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT1UVKox"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43591b55727so927302f8f.3
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 05:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771506009; x=1772110809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOuOa0Zdky+dnOyyIer2bFCUZo6kYKwFJPihFtRXFro=;
        b=iT1UVKoxMyFDsYr6fVXQ500q83L3TBgYv7QcdPY5/U9S+gXiz1fYJQIePoK5vEQR/C
         MXTyyx0S2hRDTywwf6BdPDSKXdzde2BUudVAUqL1Qek2PxOLyP8apgvqyrNWZPy/IgZt
         12DwtKWtOTvKevLv+Qd9ZQLe4ToTh/0pKcUvrNDKETc1Tr0+l6YontCFk5eKlX7f9wfT
         yH6S5pCXvRQGJyhlOUCzAQFQ5y5b2lAvqgmepxh77brXTJjT6lZTjBR3ay0r6/0eT4se
         /ZE99i8XrWlh+1HOw8ahkyUQRKFO7qLIJWZlGurUb1ms2W2O08pSr6ToNBi0pOrn6zPw
         dwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771506009; x=1772110809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qOuOa0Zdky+dnOyyIer2bFCUZo6kYKwFJPihFtRXFro=;
        b=aKRXnxLJHFglPdaSxf8TQ0O5Dl+OcQBA/NYvYaRQsaGrsSw0+sIABLWtJgGaTa9wvu
         BAPUWJGEfo1mrcIIi25rXINc5zxjtw8pFHIx/IRLrZJdQd24dqxrU8G+pmPUc3Edgz/O
         GNtM+00fGN/U2Q53CciecRXv32Br4M19XRzzjDuS93VrY/50yuTXUsTLG1MOy+I6K3Ys
         czB4hvmoArY8qemwYHY1MkdHTcDJ1/m2G9+KZ2F3eVDUFh+FjX0rTDhayzghqlaLdT3k
         Ghcqx4rbvDVFLIkb8hRbaz0RmRIz0BvpaXd2+Y6sodpzjd2xjuUgZfJvIVPkDWC96zgd
         NwKQ==
X-Gm-Message-State: AOJu0Yw16k6Ik73/XCHL6Xc9wbGjY2ZpYbEbZ6DydQJVIO8P9tcvBLEt
	vgZNztziIvGG84uuqHAnKQ+KgLAMiQOuROGUeNNcFg86QQRm7mSxHDe2q8Ykkg==
X-Gm-Gg: AZuq6aJWql0KVuukbJ7xGI3Ir9IXW4QsP1fA+cZlKWcC+a7dJqMS3DsmVYiKO/KdttY
	MXQOm15mK1Q4YyzxgxZoWnZ8NU2UQ5OsY0eaLBI+wTLStkW5RtbfTmbf2WnQ4TRXll3dCjzK0Tc
	eSIczndgVEMvxTpA26pPgsefMv4Heu4F5gbrORoca0M8mC+3z4wxw6TyUqNcfCWysmTMSlaFAWL
	ef21pk+LB4kYAHPKfTiyO2RoLdD56KEy5VVq+Eb1Q5NFJV7teJh39HzOq8iuF1EQbbcJMAqedgL
	r19PnsB64HYsAu/Dd4pxpU0/wRMTKjle2N0XBnva3wRVDK3jnaljYeoR2Wf4GgI9RVuY4+OJ5c1
	Bn9aw5siRmpvrGJDGJ+UStDKwiZyRlySx8ZSiIUguB/ho+9hdiopBf5tucHWqjHovcaWJsfeLZK
	JKqb5opYE8ZrCCfek=
X-Received: by 2002:a05:600c:c491:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-48379be8253mr306319135e9.22.1771506009273;
        Thu, 19 Feb 2026 05:00:09 -0800 (PST)
Received: from fedora ([159.146.42.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c0779sm4603015e9.6.2026.02.19.05.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:00:08 -0800 (PST)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	ps@pks.im,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [GSOC PATCH 1/2] mailmap: stop using the_repository
Date: Thu, 19 Feb 2026 15:59:53 +0300
Message-ID: <20260219125954.3539324-2-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219125954.3539324-1-bkkaracay@gmail.com>
References: <20260219125954.3539324-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'read_mailmap' and 'read_mailmap_blob' functions rely on the global
'the_repository' variable. Update both functions to accept a
'struct repository' parameter.

Update all callers to pass 'the_repository' to retain the current
behavior.

Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 builtin/blame.c         |  2 +-
 builtin/cat-file.c      |  2 +-
 builtin/check-mailmap.c |  4 ++--
 builtin/commit.c        |  2 +-
 builtin/log.c           |  2 +-
 builtin/shortlog.c      |  2 +-
 mailmap.c               | 11 ++++++-----
 mailmap.h               |  5 +++--
 pretty.c                |  2 +-
 ref-filter.c            |  2 +-
 10 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index eac2fe7320..f3a11eff44 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1252,7 +1252,7 @@ int cmd_blame(int argc,
 	sb.xdl_opts = xdl_opts;
 	sb.no_whole_file_rename = no_whole_file_rename;
 
-	read_mailmap(&mailmap);
+	read_mailmap(the_repository, &mailmap);
 
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df8e87a81f..d298e95797 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -1105,7 +1105,7 @@ int cmd_cat_file(int argc,
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
 	if (use_mailmap)
-		read_mailmap(&mailmap);
+		read_mailmap(the_repository, &mailmap);
 
 	switch (batch.objects_filter.choice) {
 	case LOFC_DISABLED:
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 9cc5c59830..3f2a39cae0 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -63,9 +63,9 @@ int cmd_check_mailmap(int argc,
 	if (argc == 0 && !use_stdin)
 		die(_("no contacts specified"));
 
-	read_mailmap(&mailmap);
+	read_mailmap(the_repository, &mailmap);
 	if (mailmap_blob)
-		read_mailmap_blob(&mailmap, mailmap_blob);
+		read_mailmap_blob(the_repository, &mailmap, mailmap_blob);
 	if (mailmap_file)
 		read_mailmap_file(&mailmap, mailmap_file, 0);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 9e3a09d532..3700f66ba9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1155,7 +1155,7 @@ static const char *find_author_by_nickname(const char *name)
 	setup_revisions(ac, av, &revs, NULL);
 	revs.mailmap = xmalloc(sizeof(struct string_list));
 	string_list_init_nodup(revs.mailmap);
-	read_mailmap(revs.mailmap);
+	read_mailmap(the_repository, revs.mailmap);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
diff --git a/builtin/log.c b/builtin/log.c
index 8ab6d3a943..ff0227e32d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -336,7 +336,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (mailmap) {
 		rev->mailmap = xmalloc(sizeof(struct string_list));
 		string_list_init_nodup(rev->mailmap);
-		read_mailmap(rev->mailmap);
+		read_mailmap(the_repository, rev->mailmap);
 	}
 
 	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d80bf1a7d0..6b2a0b93b5 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -357,7 +357,7 @@ void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
 
-	read_mailmap(&log->mailmap);
+	read_mailmap(the_repository, &log->mailmap);
 
 	log->list.strdup_strings = 1;
 	log->wrap = DEFAULT_WRAPLEN;
diff --git a/mailmap.c b/mailmap.c
index 37fd158a51..6628975f30 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -183,7 +183,8 @@ static void read_mailmap_string(struct string_list *map, char *buf)
 	}
 }
 
-int read_mailmap_blob(struct string_list *map, const char *name)
+int read_mailmap_blob(struct repository *repo, struct string_list *map,
+                      const char *name)
 {
 	struct object_id oid;
 	char *buf;
@@ -192,10 +193,10 @@ int read_mailmap_blob(struct string_list *map, const char *name)
 
 	if (!name)
 		return 0;
-	if (repo_get_oid(the_repository, name, &oid) < 0)
+	if (repo_get_oid(repo, name, &oid) < 0)
 		return 0;
 
-	buf = odb_read_object(the_repository->objects, &oid, &type, &size);
+	buf = odb_read_object(repo->objects, &oid, &type, &size);
 	if (!buf)
 		return error("unable to read mailmap object at %s", name);
 	if (type != OBJ_BLOB) {
@@ -209,7 +210,7 @@ int read_mailmap_blob(struct string_list *map, const char *name)
 	return 0;
 }
 
-int read_mailmap(struct string_list *map)
+int read_mailmap(struct repository *repo, struct string_list *map)
 {
 	int err = 0;
 
@@ -224,7 +225,7 @@ int read_mailmap(struct string_list *map)
 					 startup_info->have_repository ?
 					 MAILMAP_NOFOLLOW : 0);
 	if (startup_info->have_repository)
-		err |= read_mailmap_blob(map, git_mailmap_blob);
+		err |= read_mailmap_blob(repo, map, git_mailmap_blob);
 	err |= read_mailmap_file(map, git_mailmap_file, 0);
 	return err;
 }
diff --git a/mailmap.h b/mailmap.h
index 908365e1bf..11346835cb 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -11,9 +11,10 @@ extern char *git_mailmap_blob;
 
 int read_mailmap_file(struct string_list *map, const char *filename,
 		      unsigned flags);
-int read_mailmap_blob(struct string_list *map, const char *name);
+int read_mailmap_blob(struct repository *repo, struct string_list *map,
+                      const char *name);
 
-int read_mailmap(struct string_list *map);
+int read_mailmap(struct repository *repo, struct string_list *map);
 void clear_mailmap(struct string_list *map);
 
 int map_user(struct string_list *map,
diff --git a/pretty.c b/pretty.c
index e0646bbc5d..ebf4da4834 100644
--- a/pretty.c
+++ b/pretty.c
@@ -781,7 +781,7 @@ static int mailmap_name(const char **email, size_t *email_len,
 	static struct string_list *mail_map;
 	if (!mail_map) {
 		CALLOC_ARRAY(mail_map, 1);
-		read_mailmap(mail_map);
+		read_mailmap(the_repository, mail_map);
 	}
 	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
 }
diff --git a/ref-filter.c b/ref-filter.c
index 3917c4ccd9..d7a23a7b61 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1753,7 +1753,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 		    (starts_with(name + wholen, "email") &&
 		    (atom->u.email_option.option & EO_MAILMAP))) {
 			if (!mailmap.items)
-				read_mailmap(&mailmap);
+				read_mailmap(the_repository, &mailmap);
 			strbuf_addstr(&mailmap_buf, buf);
 			apply_mailmap_to_header(&mailmap_buf, headers, &mailmap);
 			wholine = find_wholine(who, wholen, mailmap_buf.buf);
-- 
2.52.0

