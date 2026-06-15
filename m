Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6E40F8F8
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542050; cv=none; b=g2zGakDg9Zj6I55QA4cWZn8NmPKJSERAZ178M/OCFUGLaj4AUrE3cjPpMJTOEeYkG/3+mcAdVsuQ6dUGdPvkpMHNar6uhAlP14tTsPzUZrCBCtTs8/ZqdIU19hwxBnuT459LHx3bbFfCXDZnDISH+kfF0A0GLTq+NqdaFukjwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542050; c=relaxed/simple;
	bh=KjiGtruBVnrVqEUprHuzjMyaiiabZgh7TFUkoeQ4xis=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DLJfFOZEWFHwgttn0JAJoDT8dO79YdhXG6ZCUNAep+tBW8U8spK/DbZi3Y/cj4wY0J+kvXmn3OZsYqVz4nI9Iu0gvNm49hbMU3huPXQJxlaS9AlUocCFfNNX93BSytlzqdUrzaNcWADdxpbqkmCiHUq7qACK+QS7FDfVfINUDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEdRQ5HE; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEdRQ5HE"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-135e7f4a295so1929126c88.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542048; x=1782146848; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DYXqJ/vWxGvHLI/4V1ysuQNcz2lurY64W8PBoiiMeM=;
        b=BEdRQ5HEJw45YONH7oYBtemit7ytmV6Ua/LgBE2XSO37+jExds6iqAxcDycgSBwj41
         c9mj9hTLIJxEB0IHNRyNbcFlyUURebTu/oCOv5c4hDxXpSMXDb57nI7Vg9gI0dOh+lJy
         t+aQdCkoNUFKxkHBGPZge+10y43tLYcyvJCOy5AJU+FP2XnzGCuCEa5pqjHAYXNEPlDq
         +mxXeg/jDclNcJ9wdhaMcoG4HhYF9crFxQrjZoksHQO5TafmzPOrYmPiqQRVayPqTsLm
         kzPxdO5ykNb2srDga84ecZM85kjAeQhhF7KbGycbujnB/6aT41bUWVf1lqnfyjoem+90
         zHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542048; x=1782146848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0DYXqJ/vWxGvHLI/4V1ysuQNcz2lurY64W8PBoiiMeM=;
        b=RKDRSq1C8S+G+HpK/JTXMLZ3iX5zP6VxEQGH9XSyaxjyB/i/8vZpcPj2kK+TZVs5iC
         p2yfX2X4By7RITn9AQffMOWcJh1+w0Ezj5tMYyY2Eo224tnfhDnhVLO9SYrE9+dGaeNo
         a89aCXVFMOqwRs1F1d1E408UQmAIO3Byxek3Ran832ZvYPHAwjgvCDhs9tqARuJXsLau
         lkCR3VVUP3CiLpH60pobFxiDVnlvHIZNkpy4OGgnuSszIAdbBn/c8V4nE5Xjt3PMbwJN
         zZ17MXQQGBB1PLDHKdzhrAX6VPW334vOjibFIsXcQJcMPxzeoSWn90HSX8IhERHv404P
         wcrw==
X-Gm-Message-State: AOJu0YwEwS5M91jx/IjZ5Gcabhe0G8R8Fm2eqpihmcmei/jgp8fm0DGO
	IGu5ghQdD1yE/YNE29M1gcErPV74vA3u+kJGOskTuDyNF59NvzfjY67Mp9aWVw==
X-Gm-Gg: Acq92OEhEYfCfNgYCwWbTARwfZzWuLvFwU8GcADhsdKxfpqHGQKf4dIq5iQ5PWJ3Yur
	/Uq9pk8fVBy2tL1HaJn+WIKrik+ogZSEJaX+kb+MpdLUhTgjf23UOv4k1vcZK6tViLcBE+7MIoV
	Au3YfB/k+lFqyavPn6/PZ02we9lBlLcrG2v9PNA+ccFmQF8KRrYefpulVdQbLUpqx00Mn2vXeTT
	madDyIt7pKzh1wcp0ddPKfkrCDtXy3EYd1k4CZdbTcmHiapDtwq2i5v77c2hEBcwO4Sj+VNf4Ae
	EUYjK6FaUrykDBFn2S5YBdw29aNHig8Ec+ivSx/bkO5gulBjW368KIVAIeMi3syhqz/3dU4EGNp
	MZiXh2L+m/dRu1+xg3U1jeDFakNpg6zmpBO3ZzoCcpKtVZ9MfQxwKQc6vpRccA4XNCiymY8USRA
	tkdQeG82vAiGAb4PGmp2Mg13N5
X-Received: by 2002:a05:7022:48f:b0:128:d396:f2ea with SMTP id a92af1059eb24-139857bc219mr136960c88.11.1781542047889;
        Mon, 15 Jun 2026 09:47:27 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm15322475eec.5.2026.06.15.09.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:47:26 -0700 (PDT)
Message-Id: <91c35f10cc60b51e3df0f9a4e0ba4997e35bf0c9.1781542042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 16:47:17 +0000
Subject: [PATCH v15 2/7] branch: convert delete_branches() to a flags argument
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

delete_branches() and check_branch_commit() take a pair of int
booleans (force and quiet) that the next commits would grow further.
Replace them with a single "unsigned int flags" argument and an
enum, splitting the bits back into named bool locals so the body
keeps reading the same named values.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c159f45b4c..a9be980aef 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -189,10 +189,16 @@ static int branch_merged(int kind, const char *name,
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
+	bool force = flags & DELETE_BRANCH_FORCE;
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
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
@@ -227,6 +233,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int i;
 	int ret = 0;
 	int remote_branch = 0;
+	bool force;
+	bool quiet = flags & DELETE_BRANCH_QUIET;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -241,7 +249,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		remote_branch = 1;
 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
 
-		force = 1;
+		flags |= DELETE_BRANCH_FORCE;
 		break;
 	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
@@ -252,12 +260,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
+	force = flags & DELETE_BRANCH_FORCE;
+
 	if (!force)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
-		int flags = 0;
+		int ref_flags = 0;
 
 		copy_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
@@ -279,7 +289,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					     RESOLVE_REF_READING
 					     | RESOLVE_REF_NO_RECURSE
 					     | RESOLVE_REF_ALLOW_BAD_NAME,
-					     &oid, &flags);
+					     &oid, &ref_flags);
 		if (!target) {
 			if (remote_branch) {
 				error(_("remote-tracking branch '%s' not found"), bname.buf);
@@ -291,7 +301,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 									   | RESOLVE_REF_NO_RECURSE
 									   | RESOLVE_REF_ALLOW_BAD_NAME,
 									   &oid,
-									   &flags);
+									   &ref_flags);
 				FREE_AND_NULL(virtual_name);
 
 				if (virtual_target)
@@ -306,16 +316,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
@@ -872,7 +882,9 @@ int cmd_branch(int argc,
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

