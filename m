Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCA4248A9
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889384; cv=none; b=ma6peI10F0wYL4aonHInDlaSubHxv/1GEC3//dQVbaXnWELhb4D3Zsu1vDvYyoVR8hdSXBf2e5PdiMDfXD3RPrNrievdEQ2fQnbgxjQSb84Si48nygq2Xk2K5b7+PckCpicJ2KRpYUkMRE0McNAqQKX4sfa6ZSoO93Axw9pdDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889384; c=relaxed/simple;
	bh=c3ovUYlOQcsrR9xZ9Q+5wzFbLSlLM/ljV8u1POCfUt0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r00Z8bao799V2BTAues49j7hdZw4KD5kgOOQ5M6Bb6OJIhSrxj9YHzHZkjtiPpFV1npNknuHLF6yxiRzZ2CvUL+FqmLWRrVSx7gTGTZItwG7o9tDWYB+D9+dVLV24j4Nu/+HCP2t7unVhvaS4liqQkO0KnQIShbrbJqoaqn+9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr9doo9M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr9doo9M"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caed617615so3044655ad.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889383; x=1785494183; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EW3+10PoNk+6eJaeZKAilVj2OPxo70oBNxsKQ0j7T9Y=;
        b=Qr9doo9MkqSvWyfAGW4VaAS5WfPWVV6uBxm4w4C5ht6miWEiy8JcnszauuU8vMGQ3b
         IB2WBZUIVD1BteQn5zhYA5dG3ub61qZzWD6bD8vhA1/RIbb4/hsDxopydW556hxeR4oG
         Of/rJGW1/JCImWljaLxCM/h5WjwGDEx7hdg86xfr1V31fvjrbGizwmf2+oG0KJ4q8jky
         /LyekkihGiaKoYp+Ipp3mwO+cfElqtpczVHPFzZHG6JDf3EQmRR2PvZPW128Ql4ejQrF
         gTPjSU1g+qJ9jEt3UsMK4Tpjg/wKoLt+MS3dMhwInF7FHGfjGyThHB7SE8ydKzR7ZfVB
         aQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889383; x=1785494183;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EW3+10PoNk+6eJaeZKAilVj2OPxo70oBNxsKQ0j7T9Y=;
        b=n0SUWyz6lD4uEVVs/SOex5e80t5jRpajF0bQnFLlvd+20PPyAXenW18LLdA7qZMRPi
         DmYwNIAru9WmQFbCqKsM0OC6z17Yi5jwcdr7YY0TeZrjuDnyzd76xU2B7BpPgtQ0qwjW
         4GMZsasJ1TpcyYveUKUPgoDgezA+UHVaUVRT6CXOIKaNr/lZMZqaYdwU4aflHL8GgThq
         5UDJAKkscx5mP7o0+tYuxkqZzVXcsVrXIB0QnjVr2mDJluly3wBVSTSr57/RL+OtG6CZ
         900E0JxAjMBF1Z++MzNXsabo+lk0aNA4HvVCVE1BBJkyrt7Z9pg7CGVbva4cSj28Ado+
         68dQ==
X-Gm-Message-State: AOJu0Yws19Demh31wBcZP84ztAtdO6jY9PXCBBBZYInbk2BRd4TwC0MG
	oqJ8CgyiZOd2sHCCu5WiXkDgUER1Xv52nwSF6zlBSZe/Dr8gO5Rv0Ll8viZVTQ==
X-Gm-Gg: AR+sD12/yv93SZ6qgzxhyVSCjtd8qGBtGBiYBKGyQ5/dNsJtb+r9i8eN6ZLAjTQrruO
	NRT5pOy1b4BNNAAEzwVVbIRO+ZlewCvmwld5f5UDEnieGb+LdhlWblJjCXyOiGDsBgwYrw7zCSP
	w8LEjLj6Ix1DICZA2PaUnrhU+ePB+KpZu/6Z0oLDnTr69H42xNAVmj9TaUhFhAqY0VhEh1dOnnm
	b1uz4BewIEwgzgDZMazl9L3B9HljRZXAVxsseiuS1wkHnpHUBkrIXXojfuHuh/v+tDINiL1roLP
	dNOZ629pYlUFsY9lrcqr3iSBOqLJaNejzau1UxCdxvDvn5EZd1SRe5XafRbUalTfrfEwBmI8rkx
	AgqhO4YcOYI1WCOQin8vhoVRb/hedRLqlD2pK9Vd2LY9CpL5HisceLpwNdTSA2IhpOdojWiXD6A
	9125ZmAg==
X-Received: by 2002:a17:903:1c3:b0:2ce:d34a:5959 with SMTP id d9443c01a7336-2cfa6f97cedmr77894355ad.44.1784889382597;
        Fri, 24 Jul 2026 03:36:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa49cdsm49325885ad.6.2026.07.24.03.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:36:22 -0700 (PDT)
Message-Id: <048c002cb4bc4d5fe107406a6da0479807db4b49.1784889377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
References: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
	<pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 10:36:12 +0000
Subject: [PATCH v21 2/7] branch: convert delete_branches() to a flags argument
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

