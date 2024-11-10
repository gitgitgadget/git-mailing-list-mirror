Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFC1537C6
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731240463; cv=none; b=PFSmTtGG7T/IYX/iEvl7hXwOp1QTlrWkORWpcJsTTeTvKjlXmwfQztSCHUJP6ZPvpFq0cQAWf8UKNr4vausQNV55tdX7n9sEfhk+7BPLuikmhcm5w6yhBoAHJOu0Vi8chd/c/TV7WOeWmrYpc99tpdnimEl900pLoCs0JlY0Sz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731240463; c=relaxed/simple;
	bh=P1zYGX7mLkANOB68aymFEv+cOu6oe4D7UGfywUAwWd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiPWx8jwngXrmUPwfdR2AMnU4KeUaysGKkuwiBeykKyJqhRgqqtR156CYXplonyCBzIhFBMaF/Xq3ChC+S9NlA9dcC85DP/RTaIvf5deUTJxNVwob4hwfbwq+vZWayH4i/zaAXH/HOJd7hi9qHbGtq2EgD3+7KIvMDZapItK7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgHMr2/k; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgHMr2/k"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2905441b3a.2
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 04:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731240459; x=1731845259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//bIliIK2grFdP0R7rJp2u7OeBWqw6kATU8bLscW+xI=;
        b=bgHMr2/kRUJrasbyRYtEODTbPmS0ZWNif3LtwN7js/KePMmZp63NuY3nJ/fqRKSVzt
         4PPFBTMQQjMXHtALdYRNiV+ijwpmKivST/ZMKPymAv55zKhgjOrq+QrxXsG/5g2E2qWx
         LFrmTEou4Br06zLS64hA1yy6ZuhPEW09Xng1H13CdIAC4ql879Kdup/HWWqE7m9xntWO
         S7regGWaZrkLTHQI9ygwEBtrGGBrbz76N32TzeEC+5AvZc9u3NAcbI9h6cbM++MSUtDB
         mxCn7Wh/Pp0q3XuH+HKXIu5/gCpiB3ZDVzjieFrBl0IBdMTleY+a/aPXoJbCC9E7mKJi
         sXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731240459; x=1731845259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//bIliIK2grFdP0R7rJp2u7OeBWqw6kATU8bLscW+xI=;
        b=ajDnvc3Qo6qxQjnxLpsfTOjBNBEbzihz9WKe5AWNnzU3OS/YthtSTXWW5UvEVE25SJ
         DcXrpbNSUqHUYIvbJNVHQwqNczimuCOjbs1zlxnUxpzW+5rdi5CJ1WdfSh8WULq+Zz1G
         Kih9VfSTr0fs3MOUobJeP0MKeUSFEDjCqqSy71p0d0eet90VRS4x5YasjNYrEwJ/fwa2
         LiCZTLbOPJ6FCJMpIqFKPL2LZAfhnzXGnXlHo5OlHwhkqiAD6Wi6Viuaf6KxMLXYcUvI
         ZlkzUUEJ+2dMnlJeTpKdZZkWmvDQCI0lZkSvhGNIS39f/mDVJVy5n08I55mbgbTjfsmf
         WqiQ==
X-Gm-Message-State: AOJu0Yzkd9jctUcLCXLrbLbZCtQaoScJkjc/2QJo+6r0hyqfod3Zztbj
	eLjp0lirYSSF717ja99krLQapIqb7DXuTcbBcWufeidysoJ6om5T+aFJufeCzz8=
X-Google-Smtp-Source: AGHT+IHNVXr1leW+ELyVhpzFvuuH8IaKEVqN7frKFsO3o1QIzyt62VJyaTjYOCfhhVkOwPIQFEzLWA==
X-Received: by 2002:a05:6a00:230a:b0:71e:108e:9c16 with SMTP id d2e1a72fcca58-724132c73a8mr12164463b3a.12.1731240459333;
        Sun, 10 Nov 2024 04:07:39 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a19dd8sm7056585b3a.157.2024.11.10.04.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 04:07:38 -0800 (PST)
Date: Sun, 10 Nov 2024 20:07:36 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 0/9] add ref content check for files backend
Message-ID: <ZzCiCGxL4Adnd_eq@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZX5HDdq_R0C77b@ArchLinux>

Hi All:

This new version solves the follow problems:

1. Enhance the commit message suggested by Patrick.
2. Rename "target_name" to "refname".
3. Enhance the shell scripts to use `for in` to avoid repetition. And
this is the main change of this new version.

Thanks,
Jialuo

shejialuo (9):
  ref: initialize "fsck_ref_report" with zero
  ref: check the full refname instead of basename
  ref: initialize ref name outside of check functions
  ref: support multiple worktrees check for refs
  ref: port git-fsck(1) regular refs check for files backend
  ref: add more strict checks for regular refs
  ref: add basic symref content check for files backend
  ref: check whether the target of the symref is a ref
  ref: add symlink ref content check for files backend

 Documentation/fsck-msgids.txt |  35 +++
 builtin/refs.c                |  10 +-
 fsck.h                        |   6 +
 refs.c                        |   7 +-
 refs.h                        |   3 +-
 refs/debug.c                  |   5 +-
 refs/files-backend.c          | 190 ++++++++++++--
 refs/packed-backend.c         |   8 +-
 refs/refs-internal.h          |   5 +-
 refs/reftable-backend.c       |   3 +-
 t/t0602-reffiles-fsck.sh      | 480 +++++++++++++++++++++++++++++++---
 11 files changed, 690 insertions(+), 62 deletions(-)

Range-diff against v6:
 1:  319f384f1c =  1:  bfb2a21af4 ref: initialize "fsck_ref_report" with zero
 2:  8662fc9679 !  2:  9efc83f7ea ref: check the full refname instead of basename
    @@ Commit message
     
         In order to fix the above problem, enhance "files_fsck_refs_name" to use
         the full name for "check_refname_format". Then, replace the tests which
    -    are related to "@" and add tests to exercise the above situations.
    +    are related to "@" and add tests to exercise the above situations using
    +    for loop to avoid repetition.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct ref_store *ref_stor
      		goto cleanup;
      
     -	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
    ++	/*
    ++	 * This works right now because we never check the root refs.
    ++	 */
     +	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
     +	if (check_refname_format(sb.buf, 0)) {
      		struct fsck_ref_report report = { 0 };
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct ref_store *ref_stor
     
      ## t/t0602-reffiles-fsck.sh ##
     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name should be checked' '
    - 	git tag tag-2 &&
    - 	git tag multi_hierarchy/tag-2 &&
    + 	cd repo &&
      
    -+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
    -+	git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	EOF
    -+	test_must_be_empty err &&
    -+	rm $branch_dir_prefix/@ &&
    -+
    - 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
    - 	test_must_fail git refs verify 2>err &&
    - 	cat >expect <<-EOF &&
    -@@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name should be checked' '
    - 	rm $branch_dir_prefix/.branch-1 &&
    - 	test_cmp expect err &&
    + 	git commit --allow-empty -m initial &&
    +-	git checkout -b branch-1 &&
    +-	git tag tag-1 &&
    +-	git commit --allow-empty -m second &&
    +-	git checkout -b branch-2 &&
    +-	git tag tag-2 &&
    +-	git tag multi_hierarchy/tag-2 &&
    ++	git checkout -b default-branch &&
    ++	git tag default-tag &&
    ++	git tag multi_hierarchy/default-tag &&
      
    +-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
    +-	test_must_fail git refs verify 2>err &&
    +-	cat >expect <<-EOF &&
    +-	error: refs/heads/.branch-1: badRefName: invalid refname format
    +-	EOF
    +-	rm $branch_dir_prefix/.branch-1 &&
    +-	test_cmp expect err &&
    +-
     -	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
    -+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\'' branch-1'\'' &&
    - 	test_must_fail git refs verify 2>err &&
    - 	cat >expect <<-EOF &&
    +-	test_must_fail git refs verify 2>err &&
    +-	cat >expect <<-EOF &&
     -	error: refs/heads/@: badRefName: invalid refname format
    -+	error: refs/heads/ branch-1: badRefName: invalid refname format
    - 	EOF
    --	rm $branch_dir_prefix/@ &&
    -+	rm $branch_dir_prefix/'\'' branch-1'\'' &&
    - 	test_cmp expect err &&
    +-	EOF
    ++	cp $branch_dir_prefix/default-branch $branch_dir_prefix/@ &&
    ++	git refs verify 2>err &&
    ++	test_must_be_empty err &&
    + 	rm $branch_dir_prefix/@ &&
    +-	test_cmp expect err &&
      
     -	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
    -+	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/'\''~tag-2'\'' &&
    - 	test_must_fail git refs verify 2>err &&
    - 	cat >expect <<-EOF &&
    +-	test_must_fail git refs verify 2>err &&
    +-	cat >expect <<-EOF &&
     -	error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
    -+	error: refs/tags/multi_hierarchy/~tag-2: badRefName: invalid refname format
    - 	EOF
    +-	EOF
     -	rm $tag_dir_prefix/multi_hierarchy/@ &&
    -+	rm $tag_dir_prefix/multi_hierarchy/'\''~tag-2'\'' &&
    - 	test_cmp expect err &&
    +-	test_cmp expect err &&
    +-
    +-	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
    ++	cp $tag_dir_prefix/default-tag $tag_dir_prefix/tag-1.lock &&
    + 	git refs verify 2>err &&
    + 	rm $tag_dir_prefix/tag-1.lock &&
    + 	test_must_be_empty err &&
      
    - 	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
    -@@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name should be checked' '
    +-	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/.lock &&
    ++	cp $tag_dir_prefix/default-tag $tag_dir_prefix/.lock &&
    + 	test_must_fail git refs verify 2>err &&
    + 	cat >expect <<-EOF &&
      	error: refs/tags/.lock: badRefName: invalid refname format
      	EOF
      	rm $tag_dir_prefix/.lock &&
    +-	test_cmp expect err
     +	test_cmp expect err &&
     +
    -+	mkdir $tag_dir_prefix/'\''~new-feature'\'' &&
    -+	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/'\''~new-feature'\''/tag-1 &&
    -+	test_must_fail git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	error: refs/tags/~new-feature/tag-1: badRefName: invalid refname format
    -+	EOF
    -+	rm -rf $tag_dir_prefix/'\''~new-feature'\'' &&
    - 	test_cmp expect err
    ++	for refname in ".refname-starts-with-dot" "~refname-has-stride"
    ++	do
    ++		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname" &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: refs/heads/$refname: badRefName: invalid refname format
    ++		EOF
    ++		rm "$branch_dir_prefix/$refname" &&
    ++		test_cmp expect err || return 1
    ++	done &&
    ++
    ++	for refname in ".refname-starts-with-dot" "~refname-has-stride"
    ++	do
    ++		cp $tag_dir_prefix/default-tag "$tag_dir_prefix/$refname" &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: refs/tags/$refname: badRefName: invalid refname format
    ++		EOF
    ++		rm "$tag_dir_prefix/$refname" &&
    ++		test_cmp expect err || return 1
    ++	done &&
    ++
    ++	for refname in ".refname-starts-with-dot" "~refname-has-stride"
    ++	do
    ++		cp $tag_dir_prefix/multi_hierarchy/default-tag "$tag_dir_prefix/multi_hierarchy/$refname" &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: refs/tags/multi_hierarchy/$refname: badRefName: invalid refname format
    ++		EOF
    ++		rm "$tag_dir_prefix/multi_hierarchy/$refname" &&
    ++		test_cmp expect err || return 1
    ++	done &&
    ++
    ++	for refname in ".refname-starts-with-dot" "~refname-has-stride"
    ++	do
    ++		mkdir "$branch_dir_prefix/$refname" &&
    ++		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname/default-branch" &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: refs/heads/$refname/default-branch: badRefName: invalid refname format
    ++		EOF
    ++		rm -r "$branch_dir_prefix/$refname" &&
    ++		test_cmp expect err || return 1
    ++	done
      '
      
    + test_expect_success 'ref name check should be adapted into fsck messages' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    + 	branch_dir_prefix=.git/refs/heads &&
    +-	tag_dir_prefix=.git/refs/tags &&
    + 	cd repo &&
    + 	git commit --allow-empty -m initial &&
    + 	git checkout -b branch-1 &&
    +-	git tag tag-1 &&
    +-	git commit --allow-empty -m second &&
    +-	git checkout -b branch-2 &&
    +-	git tag tag-2 &&
    + 
    + 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
    + 	git -c fsck.badRefName=warn refs verify 2>err &&
     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted into fsck messages' '
      	rm $branch_dir_prefix/.branch-1 &&
      	test_cmp expect err &&
      
     -	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
    -+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\''~branch-1'\'' &&
    ++	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
      	git -c fsck.badRefName=ignore refs verify 2>err &&
      	test_must_be_empty err
      '
 3:  96144756fe !  3:  5ea7d18203 ref: initialize target name outside of check functions
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    ref: initialize target name outside of check functions
    +    ref: initialize ref name outside of check functions
     
         We passes "refs_check_dir" to the "files_fsck_refs_name" function which
         allows it to create the checked ref name later. However, when we
    -    introduce a new check function, we have to re-calculate the target name.
    -    It's bad for us to do repeat calculation. Instead, we should calculate
    -    it only once and pass the target name to the check functions.
    +    introduce a new check function, we have to allocate redundant memory and
    +    re-calculate the ref name. It's bad for us to allocate redundant memory
    +    and duplicate logic. Instead, we should allocate and calculate it only
    +    once and pass the ref name to the check functions.
     
         In order not to do repeat calculation, rename "refs_check_dir" to
    -    "target_name". And in "files_fsck_refs_dir", create a new strbuf
    -    "target_name", thus whenever we handle a new target, calculate the
    -    name and call the check functions one by one.
    +    "refname". And in "files_fsck_refs_dir", create a new strbuf "refname",
    +    thus whenever we handle a new ref, calculate the name and call the check
    +    functions one by one.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
      typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
      				  struct fsck_options *o,
     -				  const char *refs_check_dir,
    -+				  const char *target_name,
    ++				  const char *refname,
      				  struct dir_iterator *iter);
      
      static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
      				struct fsck_options *o,
     -				const char *refs_check_dir,
    -+				const char *target_name,
    ++				const char *refname,
      				struct dir_iterator *iter)
      {
      	struct strbuf sb = STRBUF_INIT;
     @@ refs/files-backend.c: static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
    - 	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
    - 		goto cleanup;
    - 
    + 	/*
    + 	 * This works right now because we never check the root refs.
    + 	 */
     -	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
     -	if (check_refname_format(sb.buf, 0)) {
    -+	if (check_refname_format(target_name, 0)) {
    ++	if (check_refname_format(refname, 0)) {
      		struct fsck_ref_report report = { 0 };
      
     -		report.path = sb.buf;
    -+		report.path = target_name;
    ++		report.path = refname;
      		ret = fsck_report_ref(o, &report,
      				      FSCK_MSG_BAD_REF_NAME,
      				      "invalid refname format");
    @@ refs/files-backend.c: static int files_fsck_refs_dir(struct ref_store *ref_store
      			       const char *refs_check_dir,
      			       files_fsck_refs_fn *fsck_refs_fn)
      {
    -+	struct strbuf target_name = STRBUF_INIT;
    ++	struct strbuf refname = STRBUF_INIT;
      	struct strbuf sb = STRBUF_INIT;
      	struct dir_iterator *iter;
      	int iter_status;
    @@ refs/files-backend.c: static int files_fsck_refs_dir(struct ref_store *ref_store
      			continue;
      		} else if (S_ISREG(iter->st.st_mode) ||
      			   S_ISLNK(iter->st.st_mode)) {
    -+			strbuf_reset(&target_name);
    -+			strbuf_addf(&target_name, "%s/%s", refs_check_dir,
    ++			strbuf_reset(&refname);
    ++			strbuf_addf(&refname, "%s/%s", refs_check_dir,
     +				    iter->relative_path);
     +
      			if (o->verbose)
     -				fprintf_ln(stderr, "Checking %s/%s",
     -					   refs_check_dir, iter->relative_path);
    -+				fprintf_ln(stderr, "Checking %s", target_name.buf);
    ++				fprintf_ln(stderr, "Checking %s", refname.buf);
     +
      			for (size_t i = 0; fsck_refs_fn[i]; i++) {
     -				if (fsck_refs_fn[i](ref_store, o, refs_check_dir, iter))
    -+				if (fsck_refs_fn[i](ref_store, o, target_name.buf, iter))
    ++				if (fsck_refs_fn[i](ref_store, o, refname.buf, iter))
      					ret = -1;
      			}
      		} else {
    @@ refs/files-backend.c: static int files_fsck_refs_dir(struct ref_store *ref_store
      
      out:
      	strbuf_release(&sb);
    -+	strbuf_release(&target_name);
    ++	strbuf_release(&refname);
      	return ret;
      }
      
 4:  b396bf6bc2 !  4:  cb4669b64d ref: support multiple worktrees check for refs
    @@ Commit message
         ref: support multiple worktrees check for refs
     
         We have already set up the infrastructure to check the consistency for
    -    refs, but we do not support multiple worktrees. As we decide to add more
    -    checks for ref content, we need to set up support for multiple
    -    worktrees.
    +    refs, but we do not support multiple worktrees. However, "git-fsck(1)"
    +    will check the refs of worktrees. As we decide to get feature parity
    +    with "git-fsck(1)", we need to set up support for multiple worktrees.
     
         Because each worktree has its own specific refs, instead of just showing
         the users "refs/worktree/foo", we need to display the full name such as
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
      static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
      {
      	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
    -+	struct worktree **worktrees, **p;
    ++	struct worktree **worktrees;
      	const char * const verify_usage[] = {
      		REFS_VERIFY_USAGE,
      		NULL,
    @@ builtin/refs.c: static int cmd_refs_verify(int argc, const char **argv, const ch
      
     -	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
     +	worktrees = get_worktrees();
    -+	for (p = worktrees; *p; p++) {
    -+		struct worktree *wt = *p;
    -+		ret |= refs_fsck(get_worktree_ref_store(wt), &fsck_refs_options, wt);
    -+	}
    -+
    ++	for (size_t i = 0; worktrees[i]; i++)
    ++		ret |= refs_fsck(get_worktree_ref_store(worktrees[i]),
    ++				 &fsck_refs_options, worktrees[i]);
      
      	fsck_options_clear(&fsck_refs_options);
     +	free_worktrees(worktrees);
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct ref_store *ref_stor
     +			       struct worktree *wt,
      			       files_fsck_refs_fn *fsck_refs_fn)
      {
    - 	struct strbuf target_name = STRBUF_INIT;
    + 	struct strbuf refname = STRBUF_INIT;
     @@ refs/files-backend.c: static int files_fsck_refs_dir(struct ref_store *ref_store,
      		} else if (S_ISREG(iter->st.st_mode) ||
      			   S_ISLNK(iter->st.st_mode)) {
    - 			strbuf_reset(&target_name);
    + 			strbuf_reset(&refname);
     +
     +			if (!is_main_worktree(wt))
    -+				strbuf_addf(&target_name, "worktrees/%s/", wt->id);
    - 			strbuf_addf(&target_name, "%s/%s", refs_check_dir,
    ++				strbuf_addf(&refname, "worktrees/%s/", wt->id);
    + 			strbuf_addf(&refname, "%s/%s", refs_check_dir,
      				    iter->relative_path);
      
     @@ refs/files-backend.c: static int files_fsck_refs_dir(struct ref_store *ref_store,
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
     +	sort err >sorted_err &&
     +	test_cmp expect sorted_err &&
     +
    -+	(
    -+		cd worktree-1 &&
    -+		test_must_fail git refs verify 2>err &&
    -+		cat >expect <<-EOF &&
    -+		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
    -+		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
    -+		EOF
    -+		sort err >sorted_err &&
    -+		test_cmp expect sorted_err
    -+	) &&
    -+
    -+	(
    -+		cd worktree-2 &&
    -+		test_must_fail git refs verify 2>err &&
    -+		cat >expect <<-EOF &&
    -+		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
    -+		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
    -+		EOF
    -+		sort err >sorted_err &&
    -+		test_cmp expect sorted_err
    -+	)
    ++	for worktree in "worktree-1" "worktree-2"
    ++	do
    ++		(
    ++			cd $worktree &&
    ++			test_must_fail git refs verify 2>err &&
    ++			cat >expect <<-EOF &&
    ++			error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
    ++			error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
    ++			EOF
    ++			sort err >sorted_err &&
    ++			test_cmp expect sorted_err || return 1
    ++		)
    ++	done
     +'
     +
      test_done
 5:  6a9e297dfc !  5:  4e1add6465 ref: port git-fsck(1) regular refs check for files backend
    @@ fsck.h: enum fsck_msg_type {
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
    - 				  const char *target_name,
    + 				  const char *refname,
      				  struct dir_iterator *iter);
      
     +static int files_fsck_refs_content(struct ref_store *ref_store,
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
     +		ret = fsck_report_ref(o, &report,
     +				      FSCK_MSG_BAD_REF_CONTENT,
    -+				      "cannot read ref file '%s': (%s)",
    ++				      "cannot read ref file '%s': %s",
     +				      iter->path.buf, strerror(errno));
     +		goto cleanup;
     +	}
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_st
     +
      static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
      				struct fsck_options *o,
    - 				const char *target_name,
    + 				const char *refname,
     @@ refs/files-backend.c: static int files_fsck_refs(struct ref_store *ref_store,
      {
      	files_fsck_refs_fn fsck_refs_fn[]= {
    @@ refs/files-backend.c: static int files_fsck_refs(struct ref_store *ref_store,
     
      ## t/t0602-reffiles-fsck.sh ##
     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should work for multiple worktrees' '
    - 	)
    + 	done
      '
      
     +test_expect_success 'regular ref content should be checked (individual)' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	branch_dir_prefix=.git/refs/heads &&
    -+	tag_dir_prefix=.git/refs/tags &&
     +	cd repo &&
     +	test_commit default &&
     +	mkdir -p "$branch_dir_prefix/a/b" &&
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should work for mu
     +	git refs verify 2>err &&
     +	test_must_be_empty err &&
     +
    -+	bad_content=$(git rev-parse main)x &&
    -+	printf "%s" $bad_content >$tag_dir_prefix/tag-bad-1 &&
    -+	test_must_fail git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	error: refs/tags/tag-bad-1: badRefContent: $bad_content
    -+	EOF
    -+	rm $tag_dir_prefix/tag-bad-1 &&
    -+	test_cmp expect err &&
    -+
    -+	bad_content=xfsazqfxcadas &&
    -+	printf "%s" $bad_content >$tag_dir_prefix/tag-bad-2 &&
    -+	test_must_fail git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	error: refs/tags/tag-bad-2: badRefContent: $bad_content
    -+	EOF
    -+	rm $tag_dir_prefix/tag-bad-2 &&
    -+	test_cmp expect err &&
    -+
    -+	bad_content=Xfsazqfxcadas &&
    -+	printf "%s" $bad_content >$branch_dir_prefix/a/b/branch-bad &&
    -+	test_must_fail git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
    -+	EOF
    -+	rm $branch_dir_prefix/a/b/branch-bad &&
    -+	test_cmp expect err
    ++	for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
    ++	do
    ++		printf "%s" $bad_content >$branch_dir_prefix/branch-bad &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: refs/heads/branch-bad: badRefContent: $bad_content
    ++		EOF
    ++		rm $branch_dir_prefix/branch-bad &&
    ++		test_cmp expect err || return 1
    ++	done &&
    ++
    ++	for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
    ++	do
    ++		printf "%s" $bad_content >$branch_dir_prefix/a/b/branch-bad &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
    ++		EOF
    ++		rm $branch_dir_prefix/a/b/branch-bad &&
    ++		test_cmp expect err || return 1
    ++	done
     +'
     +
     +test_expect_success 'regular ref content should be checked (aggregate)' '
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should work for mu
     +		git update-ref refs/worktree/branch-4 refs/heads/branch-1
     +	) &&
     +
    -+	bad_content_1=$(git rev-parse HEAD)x &&
    -+	bad_content_2=xfsazqfxcadas &&
    -+	bad_content_3=Xfsazqfxcadas &&
    -+
    -+	printf "%s" $bad_content_1 >$worktree1_refdir_prefix/bad-branch-1 &&
    -+	test_must_fail git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	error: worktrees/worktree-1/refs/worktree/bad-branch-1: badRefContent: $bad_content_1
    -+	EOF
    -+	rm $worktree1_refdir_prefix/bad-branch-1 &&
    -+	test_cmp expect err &&
    -+
    -+	printf "%s" $bad_content_2 >$worktree2_refdir_prefix/bad-branch-2 &&
    -+	test_must_fail git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	error: worktrees/worktree-2/refs/worktree/bad-branch-2: badRefContent: $bad_content_2
    -+	EOF
    -+	rm $worktree2_refdir_prefix/bad-branch-2 &&
    -+	test_cmp expect err &&
    -+
    -+	printf "%s" $bad_content_3 >$worktree1_refdir_prefix/bad-branch-3 &&
    -+	test_must_fail git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	error: worktrees/worktree-1/refs/worktree/bad-branch-3: badRefContent: $bad_content_3
    -+	EOF
    -+	rm $worktree1_refdir_prefix/bad-branch-3 &&
    -+	test_cmp expect err
    ++	for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
    ++	do
    ++		printf "%s" $bad_content >$worktree1_refdir_prefix/bad-branch-1 &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: worktrees/worktree-1/refs/worktree/bad-branch-1: badRefContent: $bad_content
    ++		EOF
    ++		rm $worktree1_refdir_prefix/bad-branch-1 &&
    ++		test_cmp expect err || return 1
    ++	done &&
    ++
    ++	for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
    ++	do
    ++		printf "%s" $bad_content >$worktree2_refdir_prefix/bad-branch-2 &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: worktrees/worktree-2/refs/worktree/bad-branch-2: badRefContent: $bad_content
    ++		EOF
    ++		rm $worktree2_refdir_prefix/bad-branch-2 &&
    ++		test_cmp expect err || return 1
    ++	done
     +'
     +
      test_done
 6:  7eea024182 !  6:  945322fab7 ref: add more strict checks for regular refs
    @@ refs/refs-internal.h: struct ref_store {
     
      ## t/t0602-reffiles-fsck.sh ##
     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be checked (individual)' '
    - 	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
    - 	EOF
    - 	rm $branch_dir_prefix/a/b/branch-bad &&
    -+	test_cmp expect err &&
    + 		EOF
    + 		rm $branch_dir_prefix/a/b/branch-bad &&
    + 		test_cmp expect err || return 1
    +-	done
    ++	done &&
     +
     +	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
     +	git refs verify 2>err &&
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be che
     +	rm $branch_dir_prefix/branch-no-newline &&
     +	test_cmp expect err &&
     +
    -+	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
    -+	git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
    -+	EOF
    -+	rm $branch_dir_prefix/branch-garbage &&
    -+	test_cmp expect err &&
    -+
    -+	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
    ++	for trailing_content in " garbage" "    more garbage"
    ++	do
    ++		printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
    ++		git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
    ++		EOF
    ++		rm $branch_dir_prefix/branch-garbage &&
    ++		test_cmp expect err || return 1
    ++	done &&
    ++
    ++	printf "%s\n\n\n" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/tags/tag-garbage-1: trailingRefContent: has trailing garbage: '\''
    ++	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
     +
     +
     +	'\''
     +	EOF
    -+	rm $tag_dir_prefix/tag-garbage-1 &&
    ++	rm $branch_dir_prefix/branch-garbage-special &&
     +	test_cmp expect err &&
     +
    -+	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
    ++	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/tags/tag-garbage-2: trailingRefContent: has trailing garbage: '\''
    ++	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
     +
     +
     +	  garbage'\''
     +	EOF
    -+	rm $tag_dir_prefix/tag-garbage-2 &&
    -+	test_cmp expect err &&
    -+
    -+	printf "%s    garbage\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
    -+	git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	warning: refs/tags/tag-garbage-3: trailingRefContent: has trailing garbage: '\''    garbage
    -+	a'\''
    -+	EOF
    -+	rm $tag_dir_prefix/tag-garbage-3 &&
    -+	test_cmp expect err &&
    -+
    -+	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
    -+	test_must_fail git -c fsck.trailingRefContent=error refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	error: refs/tags/tag-garbage-4: trailingRefContent: has trailing garbage: '\'' garbage'\''
    -+	EOF
    -+	rm $tag_dir_prefix/tag-garbage-4 &&
    - 	test_cmp expect err
    ++	rm $branch_dir_prefix/branch-garbage-special &&
    ++	test_cmp expect err
      '
      
    + test_expect_success 'regular ref content should be checked (aggregate)' '
     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be checked (aggregate)' '
      	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
      	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be che
      	sort err >sorted_err &&
      	test_cmp expect sorted_err
     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref content checks should work with worktrees' '
    - 	error: worktrees/worktree-1/refs/worktree/bad-branch-3: badRefContent: $bad_content_3
    - 	EOF
    - 	rm $worktree1_refdir_prefix/bad-branch-3 &&
    -+	test_cmp expect err &&
    + 		EOF
    + 		rm $worktree2_refdir_prefix/bad-branch-2 &&
    + 		test_cmp expect err || return 1
    +-	done
    ++	done &&
     +
     +	printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
     +	git refs verify 2>err &&
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref content checks should work wi
     +	warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
     +	EOF
     +	rm $worktree1_refdir_prefix/branch-no-newline &&
    - 	test_cmp expect err
    ++	test_cmp expect err
      '
      
    + test_done
 7:  1bf36dd644 !  7:  3006eb9431 ref: add basic symref content check for files backend
    @@ fsck.h: enum fsck_msg_type {
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
    - 				  const char *target_name,
    + 				  const char *refname,
      				  struct dir_iterator *iter);
      
     +static int files_fsck_symref_target(struct fsck_options *o,
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be che
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	branch_dir_prefix=.git/refs/heads &&
    -+	tag_dir_prefix=.git/refs/tags &&
     +	cd repo &&
     +	test_commit default &&
     +	mkdir -p "$branch_dir_prefix/a/b" &&
     +
    -+	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
    -+	git refs verify 2>err &&
    -+	rm $branch_dir_prefix/branch-good &&
    -+	test_must_be_empty err &&
    ++	for good_referent in "refs/heads/branch" "HEAD"
    ++	do
    ++		printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
    ++		git refs verify 2>err &&
    ++		rm $branch_dir_prefix/branch-good &&
    ++		test_must_be_empty err || return 1
    ++	done &&
     +
    -+	printf "ref: HEAD\n" >$branch_dir_prefix/branch-head &&
    -+	git refs verify 2>err &&
    -+	rm $branch_dir_prefix/branch-head &&
    -+	test_must_be_empty err &&
    ++	for bad_referent in "refs/heads/.branch" "refs/heads/~branch" "refs/heads/?branch"
    ++	do
    ++		printf "ref: %s\n" $bad_referent >$branch_dir_prefix/branch-bad &&
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: refs/heads/branch-bad: badReferentName: points to invalid refname '\''$bad_referent'\''
    ++		EOF
    ++		rm $branch_dir_prefix/branch-bad &&
    ++		test_cmp expect err || return 1
    ++	done &&
     +
    -+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
    ++	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline &&
     +	git refs verify 2>err &&
     +	cat >expect <<-EOF &&
    -+	warning: refs/heads/branch-no-newline-1: refMissingNewline: misses LF at the end
    ++	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
     +	EOF
    -+	rm $branch_dir_prefix/branch-no-newline-1 &&
    ++	rm $branch_dir_prefix/branch-no-newline &&
     +	test_cmp expect err &&
     +
     +	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'regular ref content should be che
     +	warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
     +	EOF
     +	rm $branch_dir_prefix/a/b/branch-complicated &&
    -+	test_cmp expect err &&
    -+
    -+	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
    -+	test_must_fail git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	error: refs/heads/branch-bad-1: badReferentName: points to invalid refname '\''refs/heads/.branch'\''
    -+	EOF
    -+	rm $branch_dir_prefix/branch-bad-1 &&
     +	test_cmp expect err
     +'
     +
 8:  1d200f2ade !  8:  c59d003d78 ref: check whether the target of the symref is a ref
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'textual symref content should be
     +	test_commit default &&
     +	mkdir -p "$branch_dir_prefix/a/b" &&
     +
    -+	printf "ref: HEAD\n" >$branch_dir_prefix/branch-good &&
    -+	git refs verify 2>err &&
    -+	rm $branch_dir_prefix/branch-good &&
    -+	test_must_be_empty err &&
    ++	for good_referent in "refs/heads/branch" "HEAD" "refs/tags/tag"
    ++	do
    ++		printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
    ++		git refs verify 2>err &&
    ++		rm $branch_dir_prefix/branch-good &&
    ++		test_must_be_empty err || return 1
    ++	done &&
     +
    -+	printf "ref: refs/foo\n" >$branch_dir_prefix/branch-good &&
    -+	git refs verify 2>err &&
    -+	rm $branch_dir_prefix/branch-good &&
    -+	test_must_be_empty err &&
    -+
    -+	printf "ref: refs-back/heads/main\n" >$branch_dir_prefix/branch-bad-1 &&
    -+	git refs verify 2>err &&
    -+	cat >expect <<-EOF &&
    -+	warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''refs-back/heads/main'\''
    -+	EOF
    -+	rm $branch_dir_prefix/branch-bad-1 &&
    -+	test_cmp expect err
    ++	for nonref_referent in "refs-back/heads/branch" "refs-back/tags/tag" "reflogs/refs/heads/branch"
    ++	do
    ++		printf "ref: %s\n" $nonref_referent >$branch_dir_prefix/branch-bad-1 &&
    ++		git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''$nonref_referent'\''
    ++		EOF
    ++		rm $branch_dir_prefix/branch-bad-1 &&
    ++		test_cmp expect err || return 1
    ++	done
     +'
     +
      test_expect_success 'ref content checks should work with worktrees' '
 9:  752f0ad22e !  9:  bb6d7f3323 ref: add symlink ref content check for files backend
    @@ refs/files-backend.c: static int files_fsck_refs_content(struct ref_store *ref_s
     
      ## t/t0602-reffiles-fsck.sh ##
     @@ t/t0602-reffiles-fsck.sh: test_expect_success 'the target of the textual symref should be checked' '
    - 	test_cmp expect err
    + 	done
      '
      
     +test_expect_success SYMLINKS 'symlink symref content should be checked' '
-- 
2.47.0

