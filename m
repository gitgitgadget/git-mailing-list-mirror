Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691663ECBC4
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999922; cv=none; b=EtlzXtF4Si9oGo4+9DAFrl+kJXgWhNrFzdfJUdwofnatmX+O7c8v43OH3dBlhQi11XbKxUp/Ko50GsDkQEew2/ipr/uKi7JjRCm6QZmczWkI84WIsF/pYNfWAKQWxIpVA7tDoWDld8HyGJGCbfvK7LRSGSVj4I8kzmnyNSuXFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999922; c=relaxed/simple;
	bh=yZVyWhOIuae21/Hzdxe/cv4N+eOcS4OkL49O+J4L8yc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NWpknT/KH5WmZWo+MP39uGWPbdeKWn7OmlCEqy940jDbUiF8VnTXN4bGpxiIM8vw9tGpWLG+TKsq82NK3IMrW6pFYDeFJB4NM42xPRbpXNcW9WsLmPkod0wFS04+iM2yM3dkiW34QV4+rmqGyVKULXX14/VI58D2/i35cQFaZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJDLibmR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJDLibmR"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ccea53f35cso55716386d6.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999920; x=1781604720; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLMd64tuJnLSx22bJT2fqW6iw6OEhPErWZFtvr5y2G8=;
        b=BJDLibmRzmIGh+xEOY2R41zB9z5UDRhnOr6SXgynqmw5JKQ8qIx1YvIkJTr7bs1fNr
         zhSIpU+Y//rAMEuaSKBVnLwBSm11b2ST8bLzzVkROLv1FUn2yMJZMuBsBtP4Iu/BYH/F
         rfcbfeq80AxUew9c15jaLtHD/QYYP0sHYCQ50S2pe734zxWYQpzFRD8z30GDZ0PNBoEm
         1Vg2GqGAy7mjoe7FG4hOOJGO+TRlHgCQS3zbSwbBgbM4GpCq7FzNZPrVyZR3QamoBGIe
         F8ePUhZK5PoDEZhFdSq8gguvrbzT0fr5IkGr0K0kWn5WRKjfQE2u4TjxK9oJlHekKFhZ
         eDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999920; x=1781604720;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLMd64tuJnLSx22bJT2fqW6iw6OEhPErWZFtvr5y2G8=;
        b=VOPh9eLqHohum5eCKOhe6Vcb9SZpkhULjI/ylSfqNgkeyKXjQgJ7H+d+kUd90Z4kf/
         KP3lKE0iDJUAlvKNQN/s+q6wVGbxuJm2/NiVJnu3Su9ZM4gx0HL3H9RJ7nsJOSkoKJM4
         Bznsbj5Vs/b7vt3K41Y8mJ7FH6QoSQGHWPTjeJSLug72CM+4LAgT522Furv0qWB5Rtds
         7bbvdkjjaPzA4QIL8fSqrooJAejmXSKTGBVGsXP8cE1fR+2t1G4OEQN7VTbo26FE1zBa
         eluKOG210V047G+9euKxrm7/Q03VwYBjuJ2z37Mv5SSktnPEENvHMinAzOAJ1CnTAhFD
         srwg==
X-Gm-Message-State: AOJu0YwCaMnqAMFRBfeD8jU3082Fc3nXwyts0kZbIKgQFfCmPVD/0GqI
	Iiyoer3iZtp4iNGkIvKWc6xyKO2XQ6qpx9MpnVLnX8SSHe6iqKV/kpMRkLUp/vIg
X-Gm-Gg: Acq92OGeM5dwJMNw+rpnnPbO6gj8ZgFrHOthDzkTrWp28DvOzxoN5cxsrPif1kjfPBu
	ogiglTHMQ6hEzkXRDHa/nE+Oh8UCz9ErV/Xpx3zDpNGUbdDVd9QFRilxxVTcqlcR1to6ylGjQEt
	I1Xr8YPngOGJYKiWjPnI6jRVZ2ozRnICwDxQDI/l5p4j1wWUG7Uy6vXrRHrdpD4JYdFtikDbfOV
	hjawiACXu21hX2GTxkAX9GlmYxerXKQ4PLpgxw5Gjk6OmlaPkpko5Ol70s0VwYgTwVysnyMVfKg
	1DO65OkWg47HD94HH0kQsJVem8lO0GUBazlljG95k5JsFsduE4wsq8AR+aEOr++U+pwsAGuGem/
	siccXxxsrdF434UxAFOPGh387f7PeqQb7YC2tN1UICpj0aD5wJbo2KtN5Fqh2GsDbGxpx3VsRy5
	JVqMzw92tfnfw8L9wEwlQ4acCJOBQ6dEybEg==
X-Received: by 2002:a05:6214:4e09:b0:8ce:b2e9:a4bc with SMTP id 6a1803df08f44-8cee5ffcaf2mr273672096d6.15.1780999920250;
        Tue, 09 Jun 2026 03:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.9.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdcc968sm211159426d6.22.2026.06.09.03.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:11:59 -0700 (PDT)
Message-Id: <7ef9502e01055fd5442550cf34d491fd21a9b971.1780999917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jun 2026 10:11:53 +0000
Subject: [PATCH v14 2/6] branch: let delete_branches warn instead of error on
 bulk refusal
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

Add a warn-only mode to delete_branches() and check_branch_commit()
so a bulk caller can report branches that are not fully merged as a
short warning and carry on, rather than erroring with the longer
"use 'git branch -D'" advice that the plain "git branch -d" path
emits. Existing callers are unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 54 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c159f45b4c..4fb012c7a4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -189,20 +189,33 @@ static int branch_merged(int kind, const char *name,
 	return merged;
 }
 
+enum delete_branch_flags {
+	DELETE_BRANCH_FORCE = (1 << 0),
+	DELETE_BRANCH_QUIET = (1 << 1),
+	DELETE_BRANCH_WARN_ONLY = (1 << 2),
+};
+
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, unsigned int flags)
 {
+	int force = flags & DELETE_BRANCH_FORCE;
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (flags & DELETE_BRANCH_WARN_ONLY) {
+			warning(_("the branch '%s' is not fully merged"),
+				branchname);
+		} else {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -217,8 +230,8 @@ static void delete_branch_config(const char *branchname)
 	strbuf_release(&buf);
 }
 
-static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+static int delete_branches(int argc, const char **argv, int kinds,
+			   unsigned int flags)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -227,6 +240,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int i;
 	int ret = 0;
 	int remote_branch = 0;
+	int force, quiet;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -241,7 +255,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		remote_branch = 1;
 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
 
-		force = 1;
+		flags |= DELETE_BRANCH_FORCE;
 		break;
 	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
@@ -252,12 +266,15 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
+	force = flags & DELETE_BRANCH_FORCE;
+	quiet = flags & DELETE_BRANCH_QUIET;
+
 	if (!force)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
-		int flags = 0;
+		int ref_flags = 0;
 
 		copy_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
@@ -279,7 +296,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					     RESOLVE_REF_READING
 					     | RESOLVE_REF_NO_RECURSE
 					     | RESOLVE_REF_ALLOW_BAD_NAME,
-					     &oid, &flags);
+					     &oid, &ref_flags);
 		if (!target) {
 			if (remote_branch) {
 				error(_("remote-tracking branch '%s' not found"), bname.buf);
@@ -291,7 +308,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 									   | RESOLVE_REF_NO_RECURSE
 									   | RESOLVE_REF_ALLOW_BAD_NAME,
 									   &oid,
-									   &flags);
+									   &ref_flags);
 				FREE_AND_NULL(virtual_name);
 
 				if (virtual_target)
@@ -306,16 +323,17 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
-			ret = 1;
+					flags)) {
+			if (!(flags & DELETE_BRANCH_WARN_ONLY))
+				ret = 1;
 			goto next;
 		}
 
 		item = string_list_append(&refs_to_delete, name);
-		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
-				    : (flags & REF_ISSYMREF) ? target
+		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
+				    : (ref_flags & REF_ISSYMREF) ? target
 				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
 
 	next:
@@ -872,7 +890,9 @@ int cmd_branch(int argc,
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

