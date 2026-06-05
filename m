Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A993FF891
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684560; cv=none; b=mKxay3Ioakt78CBRrxuc/Y3RvKwkcBKQRitb4tpnCrWUWk3jaowdRVlwSxicDpa0LWQGcqWXkqBfaT5lOXuvVFN9oHJe6TLl42hw2cuoMou9rDLu+uddoao0ovU3EH3XLtSzzHMrPGosX/Rx/ScTean/r1QjKSFghd+mLLX1SU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684560; c=relaxed/simple;
	bh=oy2o0ki5XIenRbKngaiksde02iyJhU4UdOgvGml+Oo0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ecci1ilMRcXngBQ4+I4MJ7hNqc+wL0wFKF4L+SMP4SozGAD02o8weqIRP6m6tZ5NkdLWeatoybdWVznJZP6awDs+TZmuscvrSwXO+rV59mXtFNgjVhIuONQp22q+DRJW6t6LmLt3lUWiUBqjZXxx+fZ3x+jillUWkPkpW+xRlp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hze8DFK5; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hze8DFK5"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304d8362a58so1357922eec.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684558; x=1781289358; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiRInenhJ2dBjlAQWiNo8mte+0JbktFzNmjY9rFkYjw=;
        b=Hze8DFK5KYh3Ho09S9SMW7Ti9UYMWR0RuaZXtCiIJN4uJvc9SUscCWx7gJo2k6UZiX
         bEiR+xNUvj+vV+R02zrzEvMsa02e/dt5DPJI1VkhJyT4XtlWgIbPO5sha7lhrF9jyxKh
         P5IPxt+oxGsApuLXd3SM9NUzDDiD285XytSW4vCDje3R130++uF5NsNo/Bqfa0vCRcjD
         iFNfOvDR0If0JMw0qQZvagLyBGaifaHym/ZSO16htFRcYFlVTz6kZ6w4D/aizdbDA6b1
         ksZ9uRC+tleeOz5SvLCWxiW4eKqi2j7ty7cKOPz4YZ1dBH6d5YnXsyQ1x2eLYc9ZD5Df
         ZSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684558; x=1781289358;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiRInenhJ2dBjlAQWiNo8mte+0JbktFzNmjY9rFkYjw=;
        b=EgrfxboxhMLtCpkj+Kqj55sTxIGnZ7B4WL0Xf+ZrrGLXaL/bV4nY0swuMt21m5iTAh
         JTP2bK9kvxp5U2S4Nlszs8rPWZUP9iKyrMa35gaRPGNusPZbvzW4lcBWDQfyEMpS0Ww9
         UAEgwMY9f7dB4rhS7eaK9zK3wtuwg5LzOo3VazzfgQg8pwpKxnycUZPF79CTI+eFa5N7
         cce8kqgdSRK4+wVo3vcusNAGWDsAGQQ/sBQCR99KO8/MpDE9dMIylb6bsQ6gsxluPM21
         9l0DLBVSyjME/aCR/PYWPNoyryzoAkT1Hf0iWF/0gIvODbiMvUOfVjKFM30hZirKS3OL
         1lVw==
X-Gm-Message-State: AOJu0YxA9i/zyTGvq925s/DSVWmDGftET/gYRgjCmzr36Ph/ES1KVzB9
	GtKdRHcoRBRr6pUB0JM0j3WhX3Cpw8/evz/kz2MxLcGJumCqdLsAsJ3hY66u8Q==
X-Gm-Gg: Acq92OHPzIZFqOz/gQrQFZEP6JwxGgk3BlJVIX+/eJLNDGT2I5AGhqKeEdWwgmZ2L9W
	g+PQL5p0+17TCwF600b9bTBT6FYFfBsuMYQrJrBPVNSdm6/0iYE4zBvC1r6AgE/Gvape464SbiR
	bN6c6ga1D7tWIDLyNniq99N+QrirAn/TG9GQj9/Arfoy4395Srf9uBycP/LPHMsxM3t/wxyo6eU
	ejfs6KCnPSeJSwrLoIPWroBv7fmDGAzpp0Je5qC5/SYyl+4gM0D30O7naleMPPU5lqr++yPhHwX
	w45sDv6Nse0P+ff9bE84rgRlE+1xUr/frJHdp7j1ZlHssnKBgz5r7hVMhaIOTrjI+dkdTpsg8Yp
	KdcOFTY90nhYxH0x9aDbq/0BZPcMzFllcPb/XeMKrE/d3TxNz7dJpXwKieE63hJZ6mEUGHfIHxf
	zlnESthCwxiPabTDQ3cCd7e8CZREvYQYP9YEc=
X-Received: by 2002:a05:7301:db08:b0:2d2:d5a3:e97c with SMTP id 5a478bee46e88-3077ffb5107mr1088077eec.12.1780684557743;
        Fri, 05 Jun 2026 11:35:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba046esm7697942eec.9.2026.06.05.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:57 -0700 (PDT)
Message-Id: <a7672713f67d6a44992c0f0cf989770c7e9ca38b.1780684553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
	<pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Jun 2026 18:35:49 +0000
Subject: [PATCH v13 2/6] branch: let delete_branches warn instead of error on
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
 builtin/branch.c | 50 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c159f45b4c..19d6147e71 100644
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
@@ -227,6 +240,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int i;
 	int ret = 0;
 	int remote_branch = 0;
+	int force = flags & DELETE_BRANCH_FORCE;
+	int quiet = flags & DELETE_BRANCH_QUIET;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -257,7 +272,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
-		int flags = 0;
+		int ref_flags = 0;
 
 		copy_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
@@ -279,7 +294,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					     RESOLVE_REF_READING
 					     | RESOLVE_REF_NO_RECURSE
 					     | RESOLVE_REF_ALLOW_BAD_NAME,
-					     &oid, &flags);
+					     &oid, &ref_flags);
 		if (!target) {
 			if (remote_branch) {
 				error(_("remote-tracking branch '%s' not found"), bname.buf);
@@ -291,7 +306,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 									   | RESOLVE_REF_NO_RECURSE
 									   | RESOLVE_REF_ALLOW_BAD_NAME,
 									   &oid,
-									   &flags);
+									   &ref_flags);
 				FREE_AND_NULL(virtual_name);
 
 				if (virtual_target)
@@ -306,16 +321,17 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
@@ -872,7 +888,9 @@ int cmd_branch(int argc,
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

