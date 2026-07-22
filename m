Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75959386571
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704244; cv=none; b=LuIHi9YPwTecjT09zyqVb56u3WdEa61dYiYX5aa+FwDWVdl/wOYFkgRNqfORO+P6izRIVV4dsc0bZN+KjYiqgex8OEY5MHUdyWB3mY63aWZp/5D4IzkqxP1/xLmBZ1/OWDVLY4lmFBvjZFIEm3or2grxeNkbBm/SqjaHfOKqlzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704244; c=relaxed/simple;
	bh=c3ovUYlOQcsrR9xZ9Q+5wzFbLSlLM/ljV8u1POCfUt0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NUQbFPvwFnZDhIuSBk8b7dWHKOmNiuB8EODzE3ZVX+OkzhZTjKtqjB+Sd+J2ihJFd0rhWgHT1tcza8TCa3CiXQH1NUCIcxhnoeaL72vV/EUkXYIvpg50wfw6m7QR7Z9K1hBtUvwH8T72DltRDQIGQQ2W7Bb5QhvtHDMZBYq/epE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkya8Oco; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkya8Oco"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ee6912d86dso61897456d6.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 00:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784704242; x=1785309042; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EW3+10PoNk+6eJaeZKAilVj2OPxo70oBNxsKQ0j7T9Y=;
        b=fkya8Oco4QSkwmB7fW9c83+44mnuJhS1baSVqyqV5mItn2izM73c1zJ3c/Vlt8YgUC
         T9u7HoGLBKWyKYTKhsCT+45HAQHC3bcGNE+3F/rBL7cMe3zmO34UWFz4lzBp84xg6Dg9
         tPTp6hS4nBRJKeuMQXpQJNf9LOYZc/Ub2sFWc1cxKz1fxUoeAomeHQ9yGSxnYA9RHzGQ
         RjMbIXbfNxPAfcsqGEJkffEmhM/MIiARPoi1rU8pfba9kgcRFjaRE+BZDp22VDfbx47h
         N3NJlf8kMzE5uHPXAf9LPMeCj/98G6SEI6raK+pr6ULhZ6xFE6oMz1ADYvAwPWguNHoS
         eFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704242; x=1785309042;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EW3+10PoNk+6eJaeZKAilVj2OPxo70oBNxsKQ0j7T9Y=;
        b=NdAAiIRBxxxWgcsroxwcVLneCwcTOG45F6eZT9SAe6C55cBZcoQ0cvStXaTu71mlS4
         xOuKX7v6ZMlso1ECW1dYWSqHYrRWQyFZ49ugtJLYTZUYd8h951V25dz9r/z7Gw14npH3
         BCaCyWkqfkC95Ul7gWp9ON7XdgY/9QHyh/E42eDzRbBAZAzhd+NFO43XOWhL6MlHKSez
         wKON2Hxc3Akhwd31TYKBSQ/ed4qGts0GfPo2Gp7YFWm4QdRNF8jyNyy66tiG1YS3EUt2
         pjgMBSOTUFKWnnLF3FauxPEU1tTUtaL4UJ84ldmG73rwTueicL5bzadsozBYh/6bOrdW
         juSw==
X-Gm-Message-State: AOJu0YyzWUVjmEDVWFD+1r60K2OfWUvTgghgyaqgh9H3aM/es6DTfozB
	KQxwXAAPOKHx7cgGCH0R48Vug0Ph1NWrqCOjvbvo1xOx4nf+Fka1NBThKyQoEQ==
X-Gm-Gg: AR+sD11ncCQJ7K42H7fQE97rKnqtoOOnyUEqdXv7Wq+SWiDtsQCG5PfhuH8l16VqAdf
	ZcLUXb7gmaRE2toGBCqdbPgm5vkKE6M0LtsK+0oSFJw66l7a5+rarPadcvYD7kspRO3h9iJhIdI
	6Ij4/vGhTOseKqQs42mTU1ehmj63YoeD9UDfKeN9I9hNVHqPwje8m22FrBZqQqXuhTk0qjJC1uH
	xQBYLVP9stt0QIsAhhtHGvjDTLagPuLUSbT4H0b7WGsPb5klIhtOQT3mfuZmRolog+VMuzgiipH
	dZl9lQJt17nP6jUzyqHSUpKckYXD0FuLWcp8Php8G0CtUiKKGNsLFsfJy6ug2TBv1193M9cdKhx
	QZCRAxzWQao6bieHce5xTC1Sll3dfi/OomLL0PEDAS+Kaxw9apE/59PejMQbjUUwplhU/mFDTb/
	MIpqU=
X-Received: by 2002:a05:6214:e45:b0:8ef:ddf7:3135 with SMTP id 6a1803df08f44-907783b38cdmr246826316d6.38.1784704242324;
        Wed, 22 Jul 2026 00:10:42 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba9ddd4bsm14983566d6.26.2026.07.22.00.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:10:41 -0700 (PDT)
Message-Id: <711574b2e5e6fad528713b62b415e22266ede080.1784704238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
References: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
	<pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 07:10:33 +0000
Subject: [PATCH v20 2/7] branch: convert delete_branches() to a flags argument
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

delete_branches() takes separate force and quiet parameters, while
check_branch_commit() takes force. The next commits would grow this
collection further. Replace them with a single unsigned flags argument
and an enum.

Test the FORCE and QUIET bits directly from flags at each use site so
that mutating or forwarding flags cannot leave cached values stale.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3ac1272d7e..09631f93f7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -189,16 +189,22 @@ static int branch_merged(int kind, const char *name,
 	return merged;
 }
 
+enum delete_branch_flags {
+	DELETE_BRANCH_FORCE = (1 << 0),
+	DELETE_BRANCH_QUIET = (1 << 1),
+};
+
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, unsigned int flags)
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
-	if (!force && !rev) {
+	if (!(flags & DELETE_BRANCH_FORCE) && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
-	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
+	if (!(flags & DELETE_BRANCH_FORCE) &&
+	    !branch_merged(kinds, branchname, rev, head_rev)) {
 		error(_("the branch '%s' is not fully merged"), branchname);
 		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
 				  _("If you are sure you want to delete it, "
@@ -217,8 +223,8 @@ static void delete_branch_config(const char *branchname)
 	strbuf_release(&buf);
 }
 
-static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+static int delete_branches(int argc, const char **argv, int kinds,
+			   unsigned int flags)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -241,7 +247,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		remote_branch = 1;
 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
 
-		force = 1;
+		flags |= DELETE_BRANCH_FORCE;
 		break;
 	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
@@ -252,12 +258,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!force)
+	if (!(flags & DELETE_BRANCH_FORCE))
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
-		int flags = 0;
+		int ref_flags = 0;
 
 		copy_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
@@ -279,7 +285,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					     RESOLVE_REF_READING
 					     | RESOLVE_REF_NO_RECURSE
 					     | RESOLVE_REF_ALLOW_BAD_NAME,
-					     &oid, &flags);
+					     &oid, &ref_flags);
 		if (!target) {
 			if (remote_branch) {
 				error(_("remote-tracking branch '%s' not found"), bname.buf);
@@ -291,7 +297,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 									   | RESOLVE_REF_NO_RECURSE
 									   | RESOLVE_REF_ALLOW_BAD_NAME,
 									   &oid,
-									   &flags);
+									   &ref_flags);
 				FREE_AND_NULL(virtual_name);
 
 				if (virtual_target)
@@ -306,16 +312,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
+					flags)) {
 			ret = 1;
 			goto next;
 		}
 
 		item = string_list_append(&refs_to_delete, name);
-		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
-				    : (flags & REF_ISSYMREF) ? target
+		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
+				    : (ref_flags & REF_ISSYMREF) ? target
 				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
 
 	next:
@@ -330,7 +336,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *name = item->string;
 		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
-			if (!quiet)
+			if (!(flags & DELETE_BRANCH_QUIET))
 				printf(remote_branch
 					? _("Deleted remote-tracking branch %s (was %s).\n")
 					: _("Deleted branch %s (was %s).\n"),
@@ -895,7 +901,9 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, filter.kind,
+				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
+				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
-- 
gitgitgadget

