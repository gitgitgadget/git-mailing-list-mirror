Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB61DA21
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993282; cv=none; b=fhGifnV8sunTkmE8CCefh64aUop9hp59VbQJbaNZYzkh4h+jHGK5z6ISMTCKAHhOQpqB2ttM3Q+lZKeQYppZ4X0Vt+Q/bOKqli+sDzev69WbXq5mmzJMIbPAjiIeMtNrUm71UXPAOdIJWpQzYOlVPMgq4kfgTHmtXhYaMMILpe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993282; c=relaxed/simple;
	bh=q4FTt78BvEY0oOnAG/otUtSUNl0K5eei994covvB1zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTqbqA7/1zlMC0Jxc+NHYZoKyTiJHN/DOWb5NU0ZRAeOwWMcLuQhw6K2ZXQYM6LAAhQtvF+gxN0nnpZumMq1tbcOPLMLX3Pr3197I+o6kA7gsA4lx49wUKwHFfiYL6LKR/r/Krg913U6NFpsdv5qau4FuDXFqu6mc6rX80V40W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y52nqJ1v; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y52nqJ1v"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-710ffaf921fso2223701b3a.1
        for <git@vger.kernel.org>; Sun, 18 Aug 2024 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723993280; x=1724598080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcNTuNXb7qa8AAgktcTFmjFCMbe3wM5N69E31da+ryg=;
        b=Y52nqJ1vRPCCu7yEv+ddr6PxADFAy+VQYQcU4sIiw3+vAyqRUQ3bNE4TDyVmCNPt7G
         yrNv7dK2r2niabVHgJ1Jec+eqhwm51MP6r5wHh5SQ8NpMxH0WL2RSM3kTsqqYzH9cuiW
         av8683+xNb+rg8IKmmf0aCmENE23wPZV2YkhZ0tvKPO7rlg79pMGCs8HCce2pyQXXq7k
         3fdiTZyXrzVkCKuejauDSFXkxgg0B3RGC1fN5Q2Kkat9Y3SJmmoOFRbY89PFP+u3VHJv
         CF/06WGsFPYJaUsoPltQO+9D0L0mmgIe57Z1sLoldYGJXO8a5vCsHOTmIXZ+3YLkuDtD
         v6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723993280; x=1724598080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcNTuNXb7qa8AAgktcTFmjFCMbe3wM5N69E31da+ryg=;
        b=gluzebql4R1eu+xrrFr5Lrjpozas8kYUaw0Q8Kf5K6Ubb7oMSfq55zPxQvvfltTTvH
         jJkP5iIh0ANbtFnZBxvV6LCB42DBsj2qmLp7p5eN4fDAr4C9CVRQdduL9gAew9x0IfLI
         7rx7PE4aFPrie/yCuHmhpXZ4oYRjB2v2KLvDkxG4fxJFm9/eHGNcEQy/2PYKD37gX13y
         UxmDKTzC/vehhG4xHaT4o/8kA3PM2w/IoJ2ch0CyNmTTnpYt6kHI5C11AEpU69wITUXG
         sAlQzrR0o8+kiKfBGtkX1Gqy8lwLLOqO8dP6cvdDbfFNq2sQsyWmsLwE46iVoAYnU/hX
         7bBw==
X-Gm-Message-State: AOJu0YxsQ2E/XTkCI8m9btY/5vgqqS9DJA6JYBzLgdnG6Dahy2OCoaH/
	2a4IhMPsBt5JQlr2oA5of+ipvnUFG553MrqRmYxzygVtl05YFCEeGXJJ1g==
X-Google-Smtp-Source: AGHT+IF7i0UG2ZpKHVoIEXdHofcvErAki3BHpNzMFMhtDjq/VhmiUPD6YpDIDs5h+wSrQfCXS3qY8A==
X-Received: by 2002:a05:6a00:4f01:b0:706:5daf:efa5 with SMTP id d2e1a72fcca58-71276f6321dmr18097287b3a.9.1723993279395;
        Sun, 18 Aug 2024 08:01:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-713f3c35cf0sm418629b3a.173.2024.08.18.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 08:01:18 -0700 (PDT)
Date: Sun, 18 Aug 2024 23:02:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 4/4] ref: add symlink ref consistency check for files
 backend
Message-ID: <ZsIM6JZ7miA3j09j@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsIMc6cJ-kzMzW_8@ArchLinux>

We have already introduced "files_fsck_symref_target". We should reuse
this function to handle the symrefs which are legacy symbolic links. We
should not check the trailing garbage for symbolic links. Add a new
parameter "symbolic_link" to disable some checks which should only be
used for symbolic ref.

We firstly use the "strbuf_add_real_path" to resolve the symlinks and
get the absolute path "pointee_path" which the symlink ref points to.
Then we can get the absolute path "abs_gitdir" of the "gitdir". By
combining "pointee_path" and "abs_gitdir", we can extract the
"referent". Thus, we can reuse "files_fsck_symref_target" function to
seamlessly check the symlink refs.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     | 82 ++++++++++++++++++++++++++++------------
 t/t0602-reffiles-fsck.sh | 44 +++++++++++++++++++++
 2 files changed, 101 insertions(+), 25 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bfb8d338d2..398afedaf0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
@@ -3437,13 +3438,15 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 /*
  * Check the symref "pointee_name" and "pointee_path". The caller should
  * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
- * would be the content after "refs:".
+ * would be the content after "refs:". For symblic link, "pointee_name" would
+ * be the relative path agaignst "gitdir".
  */
 static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
 				    const char *refname,
 				    struct strbuf *pointee_name,
-				    struct strbuf *pointee_path)
+				    struct strbuf *pointee_path,
+				    unsigned int symbolic_link)
 {
 	unsigned int newline_num = 0;
 	unsigned int space_num = 0;
@@ -3459,34 +3462,36 @@ static int files_fsck_symref_target(struct fsck_options *o,
 		goto out;
 	}
 
-	while (*p != '\0') {
-		if ((space_num || newline_num) && !isspace(*p)) {
-			ret = fsck_report_ref(o, report,
-					      FSCK_MSG_BAD_REF_CONTENT,
-					      "contains non-null garbage");
-			goto out;
+	if (!symbolic_link) {
+		while (*p != '\0') {
+			if ((space_num || newline_num) && !isspace(*p)) {
+				ret = fsck_report_ref(o, report,
+						      FSCK_MSG_BAD_REF_CONTENT,
+						      "contains non-null garbage");
+				goto out;
+			}
+
+			if (*p == '\n') {
+				newline_num++;
+			} else if (*p == ' ') {
+				space_num++;
+			}
+			p++;
 		}
 
-		if (*p == '\n') {
-			newline_num++;
-		} else if (*p == ' ') {
-			space_num++;
+		if (space_num || newline_num > 1) {
+			ret = fsck_report_ref(o, report,
+					      FSCK_MSG_TRAILING_REF_CONTENT,
+					      "trailing null-garbage");
+		} else if (!newline_num) {
+			ret = fsck_report_ref(o, report,
+					      FSCK_MSG_REF_MISSING_NEWLINE,
+					      "missing newline");
 		}
-		p++;
-	}
 
-	if (space_num || newline_num > 1) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_TRAILING_REF_CONTENT,
-				      "trailing null-garbage");
-	} else if (!newline_num) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_REF_MISSING_NEWLINE,
-				      "missing newline");
+		strbuf_rtrim(pointee_name);
 	}
 
-	strbuf_rtrim(pointee_name);
-
 	if (check_refname_format(pointee_name->buf, 0)) {
 		ret = fsck_report_ref(o, report,
 				      FSCK_MSG_BAD_SYMREF_POINTEE,
@@ -3521,8 +3526,10 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
 	struct strbuf pointee_path = STRBUF_INIT;
 	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf abs_gitdir = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
+	unsigned int symbolic_link = 0;
 	const char *trailing = NULL;
 	unsigned int type = 0;
 	int failure_errno = 0;
@@ -3567,8 +3574,32 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 				    ref_store->gitdir, referent.buf);
 			ret = files_fsck_symref_target(o, &report, refname.buf,
 						       &referent,
-						       &pointee_path);
+						       &pointee_path,
+						       symbolic_link);
+		}
+	} else if (S_ISLNK(iter->st.st_mode)) {
+		const char *pointee_name = NULL;
+
+		symbolic_link = 1;
+
+		strbuf_add_real_path(&pointee_path, iter->path.buf);
+		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
+		strbuf_normalize_path(&abs_gitdir);
+		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
+			strbuf_addch(&abs_gitdir, '/');
+
+		if (!skip_prefix(pointee_path.buf,
+				 abs_gitdir.buf, &pointee_name)) {
+			ret = fsck_report_ref(o, &report,
+					       FSCK_MSG_BAD_SYMREF_POINTEE,
+					       "point to target outside gitdir");
+			goto cleanup;
 		}
+
+		strbuf_addstr(&referent, pointee_name);
+		ret = files_fsck_symref_target(o, &report, refname.buf,
+					       &referent, &pointee_path,
+					       symbolic_link);
 	}
 
 cleanup:
@@ -3576,6 +3607,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
 	strbuf_release(&pointee_path);
+	strbuf_release(&abs_gitdir);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index e8fc2ef015..c6e93e4757 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -228,4 +228,48 @@ test_expect_success 'symbolic ref content should be checked' '
 	test_cmp expect err
 '
 
+test_expect_success SYMLINKS 'symbolic ref (symbolic link) content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	git commit --allow-empty -m initial &&
+	git checkout -b branch-1 &&
+	git tag tag-1 &&
+	git checkout -b a/b/branch-2 &&
+
+	ln -sf ../../../../branch $branch_dir_prefix/branch-symbolic &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-symbolic: badSymrefPointee: point to target outside gitdir
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	ln -sf ../../logs/branch-bad $branch_dir_prefix/branch-symbolic &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-symbolic: badSymrefPointee: points to ref outside the refs directory
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-symbolic: badSymrefPointee: points to refname with invalid format
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	ln -sf ./".branch" $branch_dir_prefix/branch-symbolic &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-symbolic: badSymrefPointee: points to refname with invalid format
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.46.0

