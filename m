Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B742376D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208595; cv=none; b=qkEXKqk+fF4zN4efDaebbJGLOgEnSJDFR1TpHjaCfHCq8FJlvB3KrgyEhAlWobtvpvXP3DT449U4JB+of/QwkFTePyJYJfag7LYmeqPlGjhFufVAtQadkf6Y7AsqAUiXSCn5eWyG7YIswJA5odW7REU5URyUDlNFD1QAP0bnxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208595; c=relaxed/simple;
	bh=r8xRyergcMPpd28sawiXLwl6QuEiHJOnDYGkN24GA7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVxOsg13ORMf+4bvwf45qXTzYSve4auXiD+mS+giCV765q4CnfLvBHXxND2p6NfHrrLWyT/bqW5WmYmff/hdccYL0c4ygF5uUdRTAcfjApyOsf6/qeCN82Er2VUNzANLkiRs0sxcWq270JLDQrzZFUhSsE6+/sf70DNXQBDOcCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um5f4pih; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um5f4pih"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so4721757a91.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208593; x=1784813393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FccEfatxn6XHWSzeAE2GEWCe8Dy9NDoCF9K/8q4XAVM=;
        b=Um5f4pihTz4AGulXw1rf9ZKlnsRovbf52l518vu41FIQ/gRAh5sC9pNZWPxe5P4K2U
         95xxZybu+BQsmp9FLMl1SZ/aQQ5nGT7q3P+1PTwvIadTBPfXgU3OMdzip5y5bkqzErCr
         QwcFpsdu/WRgkLbnIvDIgKMJdM4cmkcMU6Tc8kt9C+ijrrk0kxg1Dcs8ihf8883gnMkq
         vJ5tVMdMXkFDyGUHpBba1oNLjPw32aQbyQseG0rGsT2A28qhN/O22Ke8qEciYWgiGG81
         Lqs1XhZi+7iEWllKB1R8uf8vZttu1sMTkk8bTvelN00ueDlFrG/YusNe2t71PWRW5bvh
         A2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208593; x=1784813393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FccEfatxn6XHWSzeAE2GEWCe8Dy9NDoCF9K/8q4XAVM=;
        b=D38DKIBDRPi5vuzrpCoxGTbuqfh4H17AOKD43vaCBPpamk4rDSAKPWaJpkp3FodYRc
         7e7bq6gQvhoR/mhqzTQzkQMgHTt9WZriX2w9ws0RAHNk0n/cSDaHL03u/npNdZKLCtHZ
         13nwdKoQuBjhX2hWHk9ZnrRSvMK97Yy/LYqMYvJYBL5Hy9KrfijBaRobUKyy7LUwDVj9
         oopQmNmroTM8I/jGRlDeZy282TVDcvaREMA0cjXuBC78M5nSbMO/k7cEv2vnchuShJd7
         bE2lFEY3UBh0IjN1jMWy/lMhn/TuGPLRbunzDD19VgzjFeYwu45R4D9FnwHdkXnrAdAf
         m29A==
X-Gm-Message-State: AOJu0YxVHdKNwiv56noIWmF1FpB9ftVDH5vDI6b+tNyzRR9jcO1t7OBv
	FwtpNlrNt94fsSvFR9Ecs0Ga9aRsqvKGC7f6ch8pPQfPgQpT3U7ECv4eIiCr5niT
X-Gm-Gg: AfdE7cmN91chCbqj32pb7RR5HGFSfsxSnEGGDrUgPir59XQkcIUZY88kOTeN8G+wWN3
	liobV6FloLlbKts1s6lA+JDXW7mAtmfJnYa4s/KG+4awjL6LgdTsC24KxIR0EmLxARhJF8uVIjh
	f0xj8CQPFBUDC22KGKd/HDVJLtQIU94n7DgcqpXONcA4UHoyH/iKgQM3UluPXLeKfzG42Lp0VUN
	dT4TDW+0brT0CzbZm9rM1FMutdb5kst2jocl7pFpqu0bCkJllqIrLUMzp4Y67SUo/rUkT6tEEq+
	nPqwPEYhGjNYj//1IODJ4Z26oTrbMjWfPYu76j60OjVOmbJEJqYWaMzJF+ji+4Qq8Jeb09/wZqV
	p6r2CtAt+Jw94ATgynQkfPjJL19UoQyIe4waaUOmZdi7dbEC/iR3S5Cx+5TNBYv0dWXRjRCU8eI
	JMTinAs4+QdVayen+iZooOy7Z2ZD+07p9i/JLVYF0Jm2ap+HFJ36/5r+CNQBvyUnNe6+12+Eo3z
	NImwy1AGMRaYpiBL4HEdbLKsTV5ZYM9g96Gg1B1fnl5
X-Received: by 2002:a17:90b:3c91:b0:37f:9ce0:af36 with SMTP id 98e67ed59e1d1-38e2a0e6a24mr6952857a91.33.1784208593241;
        Thu, 16 Jul 2026 06:29:53 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fb:4543:3010:936c:4da8:7aa1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd31sm13291188eec.4.2026.07.16.06.29.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 06:29:52 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [RFC PATCH 7/7] repack-promisor: record dropped objects in a drop log
Date: Thu, 16 Jul 2026 18:58:48 +0530
Message-ID: <20260716132848.95982-8-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After --drop-filtered removes promisor blobs, append a record of each
dropped object to $GIT_DIR/objects/info/promisor-dropped. Each line
records the object ID, a reflog-style timestamp (Unix seconds and
timezone), the filter spec, and the promisor remote it was attested
recoverable from like the following:

  <oid> <time> <tz> filter=<spec> remote=<name>

If a dropped object later becomes unrecoverable (for example, the
branch holding it is deleted on the promisor remote), a lazy fetch
fails with a generic error. This persistent record lets a later change
explain that the object was dropped deliberately, when, under which
filter, and from which remote it was expected to be recoverable.

The remote field lists all configured promisor remotes rather than the
specific one each dropped object is recoverable from. Determining the
exact remote would require asking the remote whether it has the object.
A "remote-object-info" command is being added to the "git cat-file
--batch" protocol for this kind of query, but it is not available yet.
A NEEDSWORK marks this for a follow-up.

The log is written only on a real run, i.e. --dry-run changes nothing.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c  |  4 +++
 repack-promisor.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 repack.h          |  4 +++
 3 files changed, 99 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index aa3257a98a..49dcbbc567 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -702,6 +702,10 @@ int cmd_repack(int argc,
 		write_midx_file(files->packed, NULL, NULL, flags);
 	}
 
+	if (drop_filtered && !dry_run)
+		append_drop_log(repo, &drop_oids,
+			expand_list_objects_filter_spec(&po_args.filter_options));
+
 cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
diff --git a/repack-promisor.c b/repack-promisor.c
index fabfdc168a..60913a5150 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -7,6 +7,97 @@
 #include "repository.h"
 #include "run-command.h"
 #include "oidset.h"
+#include "date.h"
+#include "promisor-remote.h"
+#include "strbuf.h"
+
+/*
+ * Append the drop-log entries to the already-computed path.
+ * Returns -1 on any I/O failure so the caller can warn once.
+ * Keeping this in a separate helper avoids goto-based cleanup
+ * in append_drop_log();
+ */
+static int write_to_drop_log(struct repository *repo,
+			     const char *path,
+			     const struct oidset *dropped,
+			     const char *stamp,
+			     const char *filter_spec,
+			     const char *remotes)
+{
+	struct oidset_iter iter;
+	const struct object_id *oid;
+	FILE *fp;
+
+	if (safe_create_leading_directories(repo, (char *)path)) {
+		warning(_("could not create leading directories for '%s'"), path);
+		return -1;
+	}
+
+	fp = fopen(path, "a");
+	if (!fp) {
+		warning_errno(_("could not open '%s'"), path);
+		return -1;
+	}
+
+	oidset_iter_init(dropped, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		if (fprintf(fp, "%s %s filter=%s remote=%s\n",
+				oid_to_hex(oid), stamp,
+				filter_spec ? filter_spec : "",
+				remotes) < 0) {
+			warning(_("could not write to '%s'"), path);
+			fclose(fp);
+			return -1;
+		}
+	}
+
+	if (fclose(fp)) {
+		warning_errno(_("could not close '%s'"), path);
+		return -1;
+	}
+
+	return 0;
+}
+
+void append_drop_log(struct repository *repo,
+		     const struct oidset *dropped,
+		     const char *filter_spec)
+{
+	char *path;
+	struct strbuf stamp = STRBUF_INIT;
+	struct strbuf remotes = STRBUF_INIT;
+	struct promisor_remote *pr;
+
+	if (!oidset_size(dropped))
+		return;
+
+	datestamp(&stamp);
+
+	/*
+	 * NEEDSWORK: we temporarily record all configured promisor remotes rather
+	 * than the specific one a given object is recoverable from because there
+	 * is currently no way to determine that locally. it would require
+	 * asking the remote whether it has the object. A "remote-object-info"
+	 * command is being added to the "git cat-file --batch" protocol for
+	 * this kind of query. Once it is merged in the codebase, this should
+	 * record the exact promisor remote that has each dropped object.
+	 */
+	for (pr = repo_promisor_remote_find(repo, NULL); pr; pr = pr->next) {
+		if (remotes.len)
+			strbuf_addch(&remotes, ',');
+		strbuf_addstr(&remotes, pr->name);
+	}
+
+	path = repo_git_path(repo, "objects/info/promisor-dropped");
+
+	if (write_to_drop_log(repo, path, dropped, stamp.buf,
+			filter_spec, remotes.buf))
+		warning(_("could not record all dropped objects in the drop log"));
+
+	strbuf_release(&stamp);
+	strbuf_release(&remotes);
+	free(path);
+}
 
 struct write_oid_context {
 	struct child_process *cmd;
diff --git a/repack.h b/repack.h
index 61e554e4ed..33309548ce 100644
--- a/repack.h
+++ b/repack.h
@@ -171,6 +171,10 @@ int enumerate_promisor_blobs(struct repository *repo,
 			     const struct list_objects_filter_options *filter,
 			     struct oidset *to_drop);
 
+void append_drop_log(struct repository *repo,
+		     const struct oidset *dropped,
+		     const char *filter_spec);
+
 int write_cruft_pack(const struct write_pack_opts *opts,
 		     const char *cruft_expiration,
 		     unsigned long combine_cruft_below_size,
-- 
2.54.0

