Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1B284693
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338113; cv=none; b=RkSy9/luYCbHd5NnwDOuwcG92ZDctB0xMDVLB0AvNKpHVtV/Ry/go2DDr6Pe+7CzPQ7qdtzZzpiMuB3JhWNH5uA6bGyJ092blbIwAmnkTLoGlN3Zw3WbLVC01e3zxtrx9v5WdwIx3Alx3xqqR1FT1ts0Y+NFiACg6sRSKgYyrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338113; c=relaxed/simple;
	bh=KjiGtruBVnrVqEUprHuzjMyaiiabZgh7TFUkoeQ4xis=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ylhb5TPDVUik8u+Q3qmSDbK+Ggj/OWYrHEbx6xf2aSD0LQRRUbIShEmHUQrEcmqu37PpXKJClJLUdgTbYY/2muBLxLA+Ox6UP4h8A79ixdypjLZ0TO3uUGmBClj+W0PjBopvIGyo5zGcCP7rBSJ39ERGb17A551Euct5g8+Mnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsrphIO3; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsrphIO3"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30c52cc5285so2374574eec.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338112; x=1782942912; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DYXqJ/vWxGvHLI/4V1ysuQNcz2lurY64W8PBoiiMeM=;
        b=AsrphIO3mWJEh/oCN8i7/JW7tPmQLlYBLDaFq2yeguaBwWEg9ItNv0ztRXUclSHA3l
         eSThT9BDozgrMdi8Weps3W0VSy618A8uFDRszcH7Slvtpk6u3cbzLp2YBKxpbjtFq+Kd
         52UhPswp3EAizikJzwbG7w6TguIc3E5JzsSaZVYhOwHo8Q7ezRqyMRrR9ADQvhJYjKPS
         vHIhyi1NMwyNJUiOQiQhQWi8Gy/z/GPEGbnrbPdCV9O5ghPp3QcERqQ496Gg5M4+ZqWI
         978zxj8qn6q9+qtrAINh0GkKN8tHZflEHdgM+AovQ+Oh6Z8lYPqXQQj2j2stk+igI9Sw
         WwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338112; x=1782942912;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0DYXqJ/vWxGvHLI/4V1ysuQNcz2lurY64W8PBoiiMeM=;
        b=JxmWcbrGfT6YkO408Qwsqzy73bZ/g5zk7SJRsYpFI0q850RA+mCpWytzFDS405Q8ua
         5Vn3xTNBwcSkt5UN+TyLd7knISX6MXSFbvgADpREd0PHcyFwo2IpTDsf4g0uH514LoeI
         iCi4ARaxXd9CvipzB8fTRa2htZQLxwYmCDMpy9j1KnyOr88QoNQ8rjVzdr1kasI+21v0
         8WO9LyScQLD4BWk795kMi3n6jQBnThkxNHHkPBFCZ2gxZ44DmjPq/9qBimVxr0/yxyvn
         uOvMFOElGzGvujnariwYteEZA1ivKVRitWg4zk95DJmrQszrR0toN9lWCMF7mRp5DdLY
         2Kww==
X-Gm-Message-State: AOJu0Yx04SV08v057ITaITEKjffqnwm566iu55QA7eFZ0mKBkbzTYyIb
	pWeOX2GiyV6UPqcZDvG57dSVE/XsrFlH9wj2OLL1IHnGH4iBMtQwlL3/+8ot/Q==
X-Gm-Gg: AfdE7cnLhoBo/xG/ZnRQvndKKoX0bmNX+1u8OgL0PO0BANji47JoHn4WAkCO7oScVNX
	1j3g4RZSc3fWsJD8gBJXzDLBGsSddMIE0uF4kQ3m6uiaFnrYxrRHJGo3Ven4pWItuNdwLvrNke1
	GQi3/VAb7nA4FCdIf8F4ITiY4A6ob/vOXA6L4ug8Imufjvmw0pFotxpwOZw0CJbrbxTWtf+ti6b
	7we4K7pHZWDD8kICSY7NxqBk1xL4lkHS2MGaTdOSk6mIzy7oCfcp2n/jzwwhgiFR3+Z5mN9gdUa
	Tbfa4ihXAAbRlVMSgahyF4H1a9KJyo5RZGpQFdDsOpwR2J2yJXhzO2vDYD1+hj5yLdiYnqCoUvo
	78NB12M3rjAp3nr5TFcrjXeC2+6WcYcNluX58ilisHSRiLL/AKtNdpXBzHj7QGpSlV9AfxPQ/zI
	+B+ahKe76y87589r+f
X-Received: by 2002:a05:7300:a145:b0:30c:60fc:1528 with SMTP id 5a478bee46e88-30c845f8935mr65118eec.20.1782338111637;
        Wed, 24 Jun 2026 14:55:11 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.149.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c6c2sm1857571eec.10.2026.06.24.14.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:11 -0700 (PDT)
Message-Id: <cdd4fea4a73e39a1f88127037d806c9b6182d01e.1782338106.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
	<pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:01 +0000
Subject: [PATCH v18 2/7] branch: convert delete_branches() to a flags argument
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

