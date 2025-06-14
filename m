Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56B34545
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749884802; cv=none; b=Nwl+cGWTDTud2h4aI1hA1NXlWczJ1oamP8aV8HlDDiqAarLm2/IJLPjGx7nTcTKO/AkL6Dce8CSqy6SchzBi0gH96xhcYX11UtP58wv3Jjx9PpAPSMw2o54bB6FV+HSAXBeSTG/4CgcSW0A5TT5BG7AuQV+guLLOAnRJYAdpY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749884802; c=relaxed/simple;
	bh=7yLhjx2Xq//II9VjsrKVynEMVclQwM6k57Sn0TCJxvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U4IVkBzln1d3OZAvddjJ0uXp2k1kvK1KCDcBpTTJkYhWgyTYvqdYCDw0I+mYiA8N6UPC7x/MhDiONW53fh4vp2bJVjpkuExMlqZ5I80DufxfXfnYY4thzAtPQ0VpYPbVmQs/TbDtiks7+dgx3HbcapCt2bZkFtpmEhuCxJqrylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVROnO0s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVROnO0s"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2352400344aso26491265ad.2
        for <git@vger.kernel.org>; Sat, 14 Jun 2025 00:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749884800; x=1750489600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf8PgS+81D7CB6AuY9aMcfgOruQ6EJJXBJsT7vYrwL8=;
        b=hVROnO0s0VYWQ4W0FGA1wOUfV3nt8TIOx6uppXqW7EWhcyG8VbGaAv4jvpuTz/w5iE
         zukealJhIvA7nowVFpn1tp4qeR5onryHIpJfs23vwjsfdHhlL04xn1EDRsnvZcHvJ++e
         lAlcKY32gSQJ4LTi2MvD46k6Ub4RAJ5dcKNqSH/1LRZUdp/G+ukzKTY3O5UVWa0oOZiK
         2XR1XlOv4A1/dM8b83Ux2AFaZjQOSgdFMt0/q6ZLCehvKdeQHKQg0S1RET9xfWvBUVJJ
         zOr+sl/AbQ/eLOd6hjNVTd8zGLeNOH/U6l7dyR0UFNeg+qhWxPdKe1MG98znQjHRPlzf
         ikSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749884800; x=1750489600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zf8PgS+81D7CB6AuY9aMcfgOruQ6EJJXBJsT7vYrwL8=;
        b=Qa6cJNJNdjRWYEX0EarRR2KdI9hFuXde7Ae+DThuEiIj84eB/ItI+/RzzIIPaMP4dZ
         ThXNpR1B8LyWxjJeuaBb/qmoEoaej1SHoA/U9I1qUUBSXvINhm4YD5IhyDxRMqL3ZCDI
         kz8beHeP6tgUsA7jm+bG3YXVpYImnCdU6m79Xw4J9Bm+pB2sFVmanV9yEvVzkETAhPG9
         oyts1RDR2/0pp1LCmlJF5VOqBUvaTjdTiOo8QtJ8EA3f+YAL6wz5YD7IDalwuQiktJow
         0n4ja6KxOsSPUNc6/3SqXjuNhAluKjk/kBrKBjAXNoYkXpOqvyLD/qxWK7yjNeXE34vM
         sHWg==
X-Gm-Message-State: AOJu0YzYvwN/ZiUiIl8hNZMmc19/XBNWyc84ctcVCeyMuF4okTYOp9CX
	2yHYm4vHIREvVNQcza2zn3ZdsiUdoTQV4iZEauIwB/dya+GAV4zic7Zyt6gU8c0z
X-Gm-Gg: ASbGncu5u5wkr1hfoWJuy7W6GsOaAOUO1Uj5BCFbsU5EO/ftIO9d8ZiGycvI3YFJFsH
	Hu/h8owqJoSMIFuuKNKctaqR61kNvhlfQG6iu3BfTtp+L5gMej9mNzNLgbfGVeQfXTBYu0/Mnxc
	mJc2g/qNIZff13wPbdAXU9YlKCr8zUegtJWSp/n1u9gov6TuHuqh1+IrXVXqH9PpCl4SDUALv38
	5y07YaThKXRjDTsUZ5bVXq4YA/owm5Juj6BDTab/kbsX7hLTA17Vn66LuPl4as8lvt6t4+UhBC2
	CtsuxAIPieeZbd1/mhm4e0MlEvpKjsaXW+ePZhLqg3dEZj//Wii2AkUMoF0=
X-Google-Smtp-Source: AGHT+IGQtskuRTRekR6BIWNxh9/B6l4fompCI+MllLvbQCuMNzW5b+kq0TGLZvr+jHNyb25Cqk2XYA==
X-Received: by 2002:a17:903:32c5:b0:234:f825:b2c3 with SMTP id d9443c01a7336-2366afe7df0mr29871375ad.17.1749884799620;
        Sat, 14 Jun 2025 00:06:39 -0700 (PDT)
Received: from meet.. ([43.250.165.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168999asm2380814a12.54.2025.06.14.00.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 00:06:39 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: Meet Soni <meetsoni3017@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	shejialuo <shejialuo@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>
Subject: [GSoC][RFC PATCH 1/2] builtin/refs: add list subcommand
Date: Sat, 14 Jun 2025 12:35:35 +0530
Message-Id: <20250614070536.17320-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614070536.17320-1-meetsoni3017@gmail.com>
References: <20250614070536.17320-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git's reference management is distributed across multiple
commands and as part of an ongoing effort to streamline and modernize
reference handling, we are beginning to consolidate these operations
into a cohesive `git refs` command.

Add a `list` subcommand to `git refs` as a modern replacement for
`git show-ref`, consolidating ref listing functionality under the
unified `git refs` command.

The initial implementation supports the following options from
`git show-ref`:

- --head
- --tags
- --branches
- patterns argument

For large changes, this patch limits itself to the basic ref listing and
commonly used flags. Remaining options will be added incrementally in
follow-up patches, guided by feedback from the mailing list.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc |  25 ++++++++
 builtin/refs.c              | 110 ++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 4d6dc994f9..397c3ceb01 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -11,6 +11,7 @@ SYNOPSIS
 [synopsis]
 git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
 git refs verify [--strict] [--verbose]
+git refs list [--head] [--branches] [--tag] [--] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -26,6 +27,12 @@ migrate::
 verify::
 	Verify reference database consistency.
 
+list::
+	Displays references available in a local repository along with the associated
+	commit IDs. Results can be filtered using a pattern.
+
+	By default, shows the tags, heads, and remote refs.
+
 OPTIONS
 -------
 
@@ -57,6 +64,24 @@ The following options are specific to 'git refs verify':
 --verbose::
 	When verifying the reference database consistency, be chatty.
 
+The following options are specific to 'git refs list':
+
+--head::
+	Show the HEAD reference, even if it would normally be filtered out.
+
+--branches::
+--tags::
+	Limit to local branches and local tags, respectively.  These options
+	are not mutually exclusive; when given both, references stored in
+	"refs/heads" and "refs/tags" are displayed.
+
+<pattern>...::
+	Show references matching one or more patterns. Patterns are matched from
+	the end of the full name, and only complete parts are matched, e.g.
+	'master' matches 'refs/heads/master', 'refs/remotes/origin/master',
+	'refs/tags/jedi/master' but not 'refs/heads/mymaster' or
+	'refs/remotes/master/jedi'.
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 998d2a2c1c..c098132191 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -2,6 +2,9 @@
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
+#include "hex.h"
+#include "object-name.h"
+#include "object-store.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "strbuf.h"
@@ -13,6 +16,9 @@
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
 
+#define REFS_LIST_USAGE \
+	N_("git refs list [--head] [--branches] [--tag] [--] [<pattern>...]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo UNUSED)
 {
@@ -101,6 +107,108 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+struct list_options {
+	unsigned int show_head;
+	unsigned int filter_branches;
+	unsigned int filter_tags;
+	unsigned int found_match;
+	const char **patterns;
+};
+
+static void print_ref(const char *refname, const struct object_id *oid)
+{
+	const char *hex;
+
+	hex = oid_to_hex(oid);
+	if (!has_object(the_repository, oid,
+			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+		die("git refs list: bad ref %s (%s)", refname,
+		    hex);
+
+	printf("%s %s\n", hex, refname);
+}
+
+static int list_ref(const char *refname, const char *referent UNUSED,
+		    const struct object_id *oid, int flag UNUSED, void *cbdata)
+{
+	struct list_options *data = cbdata;
+
+	if (data->show_head && !strcmp(refname, "HEAD"))
+		goto match;
+
+	if (data->patterns) {
+		int reflen = strlen(refname);
+		const char **pattern_ptr = data->patterns, *pattern;
+		while ((pattern = *pattern_ptr++) != NULL) {
+			int pattern_len = strlen(pattern);
+			if (pattern_len > reflen)
+				continue;
+			if (memcmp(pattern, refname + reflen - pattern_len, pattern_len))
+				continue;
+			if (pattern_len == reflen)
+				goto match;
+			if (refname[reflen - pattern_len - 1] == '/')
+				goto match;
+		}
+		return 0;
+	}
+
+match:
+	data->found_match++;
+
+	print_ref(refname, oid);
+
+	return 0;
+}
+
+static int cmd_refs_list(int argc, const char **argv, const char *prefix,
+			 struct repository *repo UNUSED)
+{
+	struct list_options list_opts = {0};
+	const char * const list_usage[] = {
+		REFS_LIST_USAGE,
+		NULL,
+	};
+	struct option options[] = {
+		OPT_BOOL(0, "head", &list_opts.show_head,
+			 N_("show the HEAD reference, even if it would be filtered out")),
+		OPT_BOOL(0, "tags", &list_opts.filter_tags,
+			 N_("only show tags (can be combined with --branches)")),
+		OPT_BOOL(0, "branches", &list_opts.filter_branches,
+			 N_("only show branches (can be combined with --tags)")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, list_usage, 0);
+
+	if (argv && *argv)
+		list_opts.patterns = argv;
+
+	if (list_opts.show_head)
+		refs_head_ref(get_main_ref_store(the_repository), list_ref,
+			      &list_opts);
+
+	if (list_opts.filter_tags || list_opts.filter_branches) {
+		if (list_opts.filter_branches)
+			refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						 "refs/heads/", NULL,
+						 list_ref, &list_opts);
+
+		if (list_opts.filter_tags)
+			refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						 "refs/tags/", NULL,
+						 list_ref, &list_opts);
+	} else {
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  list_ref, &list_opts);
+	}
+
+	if (!list_opts.found_match)
+		return 1;
+
+	return 0;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -109,12 +217,14 @@ int cmd_refs(int argc,
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
+		REFS_LIST_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option opts[] = {
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
+		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
 		OPT_END(),
 	};
 
-- 
2.34.1

