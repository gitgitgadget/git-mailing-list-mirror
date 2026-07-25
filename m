Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B6371895
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784979148; cv=none; b=GunQ7cygSrWoydubIuqDErHArNUsUj5xOEN06O61aPAdNMNdcWw388o1Vg6WzpnhYddrXTwXlEXTAiyZtTPmr/ra+YPTaLVepzEE/NfTVKTMJBbjqBOlzWeWcaFvyOlcQ7jKqBuBoL/yoeZLh2SlwbB16Wz6JjyBHIwfsDYamwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784979148; c=relaxed/simple;
	bh=c3ovUYlOQcsrR9xZ9Q+5wzFbLSlLM/ljV8u1POCfUt0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eXUTckE3x8HSM2ANMUN31fzPHT6wol3ngeRSEuLcXYEMtziVOGFDEI96U/ldEV6GOdvM+Kqo2a5mtMKhtk5YxH3bLB4mbrIQBpmBzbjejYc8dBRPdmIEZ8oZa88vzUMR6aZcNqhEy3X1b5XslNHnIsXHks+KuXJflKifdi0HS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrWY9w/B; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrWY9w/B"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-497e6956acfso877514b6e.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784979146; x=1785583946; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EW3+10PoNk+6eJaeZKAilVj2OPxo70oBNxsKQ0j7T9Y=;
        b=FrWY9w/Bsy/rlZHuVSSnQMl367g8Jzjz6NQ97bIw2XJaQ6s8jyxZMT4ANel9WW30Uk
         cb2Z+OS+KcKEQMYOhh24NzCAHOi69CCToRsq/BQbvmR9VXhCiD+PSkqcfZkECHRHgUKD
         Bh4uzq4+Co93WkJeD1vAC/BzkJyKgaK7wKV3Y07U9al4CnvKbItjxfwdr3dhLASrfLph
         4X4ZtpvjqbUqJt7hbzV6aUyTXCcZjIED57L0NUX2yoF0HZfU0GUTmbv2uf/LGvV+RRYk
         YssoDq8w3SLzJ54Xc6KFprEyO1lqxT2L5K26gbLS/rpT7LTOgYnGJJOYYSDwG068bk6Y
         Xz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979146; x=1785583946;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EW3+10PoNk+6eJaeZKAilVj2OPxo70oBNxsKQ0j7T9Y=;
        b=EmFbr1dAv/nPqkYNEB4CcidlIJNAJVKNn61h1qGSDCOxEFjIiGCf0SLyDizyF1aAc0
         dZ58MrLOCe9Rvb0GnSnBoYriK3yNysjfHy4J7Rvrjfkq9k1qMp2Cn9jIWVL3cBxFWLxs
         8/VNv1M7N7p39dpDVVhnm/CZcqSu+URWjWR+gPTOubOhbcuhjAUN70VTObcT1/Ax6rm/
         ZNDqMVb5srqUqDNcuZKfSmmtTOvAe73pL/u7TofbRvahWwAkf1nXu84/fw07cwudNQ36
         N1vTy+ei1IjTt0ima7XLRNLJcIKzFUf4jYp/lAPc0vDTmDRevqZP9JmefsPEEXOTV96I
         MEwA==
X-Gm-Message-State: AOJu0YxT2FDg9pT5c1G4/dECkwj/qEnEklLgtYX42pAN/JVk9MnJoQLW
	r4QRZxt7Zxf/S5CWVJl5P5v7lVExmJE0xjvhf9zB15tAIfGiOQAL1BGKw/tk8bGo
X-Gm-Gg: AR+sD10r1HQADP9o09fnpwCoA9ONGe5FTw5GGDFDdkfUKDLw6soMdqU+iX1pRhDeXEJ
	4OeveeGCv26Sbx5whd1soLxTldcdEcz6vwhbiBB5V1MCT7d4zy3NMMjX0m1ozb2/hch8X3nsgCI
	PRfVVSnK+5EhSzR1Fb3vvpuKdj0P5a+V80+bXKAJ8DyOgt8YD8zHGYwnX9hIrZXhX35cmcKrQuH
	oyXUQzNnas82ihq7JY4Sa7tbgIfg5Y5uhVxk3IEYvlBOhnSqo+4jlWR+0iqDtNjlsEdaNnjUnF6
	z33rFDSrghjwSRgkFbi0ZMGvhhsuDByyvCCV5u3F2PbOJjLJVhvJ1hKr58YJ0hHzhwMjRiupWkY
	WfAj7Q9dVk33jR6hGU0C1Cs8pM8S6+uc2lCddB28nnbzK+SKlI0NStGUK0ax4sjjZxDCFo/qI7C
	MtO3bJ
X-Received: by 2002:a05:6808:bc7:b0:496:10af:ee45 with SMTP id 5614622812f47-4ab5e5e6dadmr3804565b6e.31.1784979145779;
        Sat, 25 Jul 2026 04:32:25 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.94.33])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab0cbb8ed3sm7199524b6e.5.2026.07.25.04.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:32:24 -0700 (PDT)
Message-Id: <2d20015ba91d994b61754fd79da558133a8aeddc.1784979136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
	<pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 11:32:11 +0000
Subject: [PATCH v23 2/7] branch: convert delete_branches() to a flags argument
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

