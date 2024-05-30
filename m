Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D02183060
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072109; cv=none; b=gd/ExheuSzRuuCbQbBw4tzrQUCr1y8ilaaeodqoZJiKrGwwqllbmyVYqorgxJqbSokR9Tg55jrhPYFXw/uKuozPZlQajPPbd7SEBZGF0qzaoNqnqArAYFg22T2U/ay9y7ik16VM9gmllncz/uVNDyA+e1hNwlWuzSA7hJSgKgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072109; c=relaxed/simple;
	bh=ZocM87yrqT6nxzS1hLkiCTtHHd52dn60XLuZrNEl4Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNm+m6K4oAgaQ1yOqHRBmzq12Ty3NgTugeI8yTNK03vBx1c9E06hXBZ06f0s8/oCL+QEZwsHugUMaoqvZ3T8RV0Nq2RxM6dJJvoGak0RB6L0ckZZ1IvQVRgYI3erRN2FF54RsRPdQVI2BCGPughIQX+pKlpvERGZHxCAiS3+ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR4dOqdj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR4dOqdj"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f8ecafd28cso713568b3a.3
        for <git@vger.kernel.org>; Thu, 30 May 2024 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717072106; x=1717676906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uv/clhDStXf7Q6UtVOXzFbuTwIxScrNP0nu0lRpr4OA=;
        b=mR4dOqdjgHE5pU9E3H2ljo+Nrggc7lZfyuP4NIEYm9mSqN7h15dadBdrABE+ZiK3Hx
         Ia/6uC8+//Cqez3kCtmgwYr8fjyYmQ1wCobtLRWcsoI+oP/LFiIOf3EjkHdgEP/uBDxG
         51HkvybcVroNtigOMNu3tZ+xGU08+/1VAdDmuU04awzBQgVnx2mYLQhO/3bCHNhF6E1w
         tDkB2JGe/o1JMUa/KNmo84r7Hi5+Px1zfelRW9dK+Pb4Xckf7iB+iLv0BthENHKPZUJk
         d5JXjvRsOgHsoqt20O79u2xxRaP2hytBUpV01wUMuLWF8DSO0CqWsp5QBp+uFX9CULVc
         oRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717072106; x=1717676906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv/clhDStXf7Q6UtVOXzFbuTwIxScrNP0nu0lRpr4OA=;
        b=uUnssJ7KrsvqcWDZymLpcUaZSd+fKFOch1eXQ1HjyePzZbg0/0o676u4LUBCsOOPPL
         tAR/nwXApsKFihYOsCXIZb4OQ7FxQfla5CjMluKaxWvQLrIbtJGom1UcZqyxoSSmCU4y
         LzWAZ4pV2mH7314xszsaEf8y/nUzr3MyqPWFOq6LfoIEK/uq0xfzd/3G0sm6Nwx0aX/N
         LoTyRcxWvzi+SS+/ETiavbOMEuALaNj1gRrYrxWdl2P1nsaETGo0voQaxcZxpEIGRODr
         wxCIsGVERHGgCXKhsNOGAkz1OhK6j6npLtV+ccOXjvzIOmZRDT6P6pGhmeOPNrzrKj8v
         4ZeQ==
X-Gm-Message-State: AOJu0YztlUduz1Sm6engdryi0RjIzW/7o9Om8cmOfWwgKpfDbfhDB71H
	l/YHuTxUZdeOhnUx8VBBksQNPAnOK7/7+/St+5AS08R7plsHUgRvINUqfvJD
X-Google-Smtp-Source: AGHT+IGw67dKpvX6+ILeFUAIbuzjy9KOTZWXS4cN1jcHT7svX5AUXdLIyr3Mgl88YsZzRDUb5W0YJg==
X-Received: by 2002:a05:6a20:1043:b0:1ad:7ff5:cb38 with SMTP id adf61e73a8af0-1b264635c15mr1659491637.60.1717072106152;
        Thu, 30 May 2024 05:28:26 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c1f2548c7dsm321176a12.20.2024.05.30.05.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:28:25 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH 2/2] refs: add name and content check for file backend
Date: Thu, 30 May 2024 20:27:53 +0800
Message-ID: <20240530122753.1114818-3-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530122753.1114818-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing git-fsck does not fully check bad format ref name such as
standalone '@' or name ending with ".lock". And also `git-fsck` does not
fully check ref content, the following contents will not be reported by
the original git-fsck command.

1. "c71dba5654404b9b0d378a6cbff1b743b9d31a34 garbage": with trailing
   characters.
2. "c71dba5654404b9b0d378a6cbff1b743b9d31a34    ": with trailing empty
   characters.
3. "C71DBA5654404b9b0d378a6cbff1b743b9d31A34": with uppercase hex.
4. "z71dba5654404b9b0d378a6cbff1b743b9d31a34": with not hex character.

Provide functionality to support such consistency checks for branch and
tag refs and add a new unit test to verify this functionality.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     | 112 ++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh | 132 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b6147c588b..3c811f5c03 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3299,11 +3299,121 @@ static int files_init_db(struct ref_store *ref_store,
 	return 0;
 }
 
-static int files_fsck(struct ref_store *ref_store)
+typedef int (*files_fsck_refs_fn)(const char *refs_check_dir,
+				struct dir_iterator *iter);
+
+static int files_fsck_refs_name(const char *refs_check_dir,
+				struct dir_iterator *iter)
 {
+	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+		error(_("%s/%s: invalid refname format"), refs_check_dir, iter->basename);
+		return -1;
+	}
+
 	return 0;
 }
 
+static int files_fsck_refs_content(const char *refs_check_dir,
+				struct dir_iterator *iter)
+{
+	struct strbuf ref_content = STRBUF_INIT;
+
+	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+		error(_("%s/%s: unable to read the ref"), refs_check_dir, iter->basename);
+		goto clean;
+	}
+
+	/*
+	 * Case 1: check if the ref content length is valid and the last
+	 * character is a newline.
+	 */
+	if (ref_content.len != the_hash_algo->hexsz + 1 ||
+			ref_content.buf[ref_content.len - 1] != '\n') {
+		goto failure;
+	}
+
+	/*
+	 * Case 2: the content should be range of [0-9a-f].
+	 */
+	for (size_t i = 0; i < the_hash_algo->hexsz; i++) {
+		if (!isdigit(ref_content.buf[i]) &&
+				(ref_content.buf[i] < 'a' || ref_content.buf[i] > 'f')) {
+			goto failure;
+		}
+	}
+
+	strbuf_release(&ref_content);
+	return 0;
+
+failure:
+	error(_("%s/%s: invalid ref content"), refs_check_dir, iter->basename);
+
+clean:
+	strbuf_release(&ref_content);
+	return -1;
+}
+
+static int files_fsck_refs(struct ref_store *ref_store,
+				const char* refs_check_dir,
+				files_fsck_refs_fn *fsck_refs_fns)
+{
+	struct dir_iterator *iter;
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+	int iter_status;
+
+	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);
+
+	iter = dir_iterator_begin(sb.buf, 0);
+
+	/*
+	 * The current implementation does not care about the worktree, the worktree
+	 * may have no refs/heads or refs/tags directory. Simply return 0 now.
+	*/
+	if (!iter) {
+		return 0;
+	}
+
+	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
+		if (S_ISDIR(iter->st.st_mode)) {
+			continue;
+		} else if (S_ISREG(iter->st.st_mode)) {
+			for (files_fsck_refs_fn *fsck_refs_fn = fsck_refs_fns;
+					*fsck_refs_fn; fsck_refs_fn++) {
+				ret |= (*fsck_refs_fn)(refs_check_dir, iter);
+			}
+		} else {
+			error(_("unexpected file type for '%s'"), iter->basename);
+			ret = -1;
+		}
+	}
+
+	if (iter_status != ITER_DONE) {
+		ret = -1;
+		error(_("failed to iterate over '%s'"), sb.buf);
+	}
+
+	strbuf_release(&sb);
+
+	return ret;
+}
+
+static int files_fsck(struct ref_store *ref_store)
+{
+	int ret = 0;
+
+	files_fsck_refs_fn fsck_refs_fns[] = {
+		files_fsck_refs_name,
+		files_fsck_refs_content,
+		NULL
+	};
+
+	ret = files_fsck_refs(ref_store, "refs/heads",fsck_refs_fns)
+	    | files_fsck_refs(ref_store, "refs/tags", fsck_refs_fns);
+
+	return ret;
+}
+
 struct ref_storage_be refs_be_files = {
 	.name = "files",
 	.init = files_ref_store_create,
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
new file mode 100755
index 0000000000..1c6c3804ff
--- /dev/null
+++ b/t/t0602-reffiles-fsck.sh
@@ -0,0 +1,132 @@
+#!/bin/bash
+
+test_description='Test reffiles backend consistency check'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=files
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+test_expect_success 'ref name should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/.branch-1: invalid refname format
+		error: ref database is corrupt
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-1.lock: invalid refname format
+		error: ref database is corrupt
+		EOF
+		rm $tag_dir_prefix/tag-1.lock &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/@: invalid refname format
+		error: ref database is corrupt
+		EOF
+		rm $branch_dir_prefix/@ &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'ref content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2
+	) &&
+	(
+		cd repo &&
+		printf "%s garbage" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-garbage &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-1-garbage: invalid ref content
+		error: ref database is corrupt
+		EOF
+		rm $branch_dir_prefix/branch-1-garbage &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "%s garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-1-garbage: invalid ref content
+		error: ref database is corrupt
+		EOF
+		rm $tag_dir_prefix/tag-1-garbage &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "%s    " "$(git rev-parse tag-2)" > $tag_dir_prefix/tag-2-garbage &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-2-garbage: invalid ref content
+		error: ref database is corrupt
+		EOF
+		rm $tag_dir_prefix/tag-2-garbage &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		tr -d "\n" < $branch_dir_prefix/branch-1 > $branch_dir_prefix/branch-1-without-newline &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-1-without-newline: invalid ref content
+		error: ref database is corrupt
+		EOF
+		rm $branch_dir_prefix/branch-1-without-newline &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		tr "[:lower:]" "[:upper:]" < $branch_dir_prefix/branch-2 > $branch_dir_prefix/branch-2-upper &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2-upper: invalid ref content
+		error: ref database is corrupt
+		EOF
+		rm $branch_dir_prefix/branch-2-upper &&
+		test_cmp expect err
+	)
+'
+
+test_done
-- 
2.45.1

