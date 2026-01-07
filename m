Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB09205E3B
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749372; cv=none; b=HBBIhJsdCbCNgrfWI6wRj5SqZXsFdhbKiNdiwExU68vikLwhJr4HyNxhXaxAqSCPHJUhJIwPrb3G5OXv+NMZDemoQzMu47qGQRlkCKyVDcKhBcEAfwM0o6dHV6QsC1pLCrlyeG8cAlGqZf8yWrJ1A1PUpm7UCVfhIaSfjQWNNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749372; c=relaxed/simple;
	bh=vlz6l4FxzY/O17t/j/Ac5ovcLupIQZIfGS3mu18GJMg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kOLaur2xKl0nXC1j8rPxnvvYDfWnfLagB0G/9J9MOm99MFJAXkvgY92tHtpmB8qNrCrIMMxXxmsfNAme9G3kaqM0JivRbqVbUtJlLRSycvvsFW80QFWA32UcjMHoV68JfdNOefblfbTctUtGcsS3gmaVsgHqiDid2EdVsFmLoZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwOmAnly; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwOmAnly"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2abf5900cd5so998818eec.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 17:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767749369; x=1768354169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZYMb+C/WvNL7gBSHnZKJk00GSOxwf4bu981uzfD0IU=;
        b=SwOmAnly2kD9I5CTX/gpH/UQIUrB58U0Wr24GvJLTc2sLQsMkLwrwcaAlh9JqdK23m
         76rFJQj07rjuWmk8yNTWxJrZQYXQDSz2Sg3twR5wGF3bBTNGuqfHGddz9R3cqpTD6q/a
         PRXEit3WfEUSkgtukBojErOHDQpangKa4R/lbCVBtxfufFkJG/5bPHplJnd/QXG0RYS0
         dGHgDw7zJL91vExkgd2eKlL6L8fKh2CzWd5CtvbBn+8f7BjTJsM2zrrnbGgUoVFT9BMn
         7F009//dMWt164wUhhfQ0DnrAIFFIwEQlweo6h34cUD43t4Xd6f3pgd4BZmD0xV4wvWZ
         ZNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767749369; x=1768354169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oZYMb+C/WvNL7gBSHnZKJk00GSOxwf4bu981uzfD0IU=;
        b=WjvfY322Pg+BSoE+Y+4cTwwDlgH0pnpiqT2/BcxMpotSO86oagWIU00QlcuFI8ufxj
         CyRIVGwyUtw71u54d++Fy8Ig7s7a94whef7OEWWZt9gRVDOLzp3vUuGP/nkfI5vp8K3s
         uogsV5LbTWsQy0/M1Yfcb5n+Tn8pQ211VnLWZbaQnH8dIlNvQZ7AHpVJ7FNWMrEiRuIZ
         +bOYanoCT6Bo3jN4FW2wgbqKsByKJNk+mYVqooXstyAvF+TIo1TvSK1yo2wCnqfa7GTG
         XmSd4W42vEae70rN9K+ftVP3lfF+0W4DjcYK2a5L+zVvxxpAHK5PJMgMc9dBwqDl4WBV
         ye3g==
X-Gm-Message-State: AOJu0YwpuZTr1NWyaADa2GYkfPOcZvwqPOe+jfHdxFG+z14VUgunwg+N
	FCkFEW/wzu+S5GHILUuQnWe9KRX/fo7/sQec8UefOpxlPYSPKTixJDs17Sk+3A==
X-Gm-Gg: AY/fxX7F+7XRC3Pcbk8Jf3SxAZEVhQqz+DxiyTuEIqIFrpkpQ+VAm8SiS+8TBGzguxy
	hB99Uqk90y08eACWFSqTmJDWQCBfJx57MyWJaMFHR/GcThIs4w3wMLtSsekOhU6s0t1BY1puzpQ
	eOnzYWYNHo+TZRVvB6oRH9ThkW+CjUr7j00/7yHtObMWX0pR2Q4RgJP/qGh1WHwMTmzVebG+4dj
	+i4+iTkbxKTeUov9vHPibKEkVUuoIWLxztCbSKCe2osP9afXag1Dpw3HToSezjIU1ALEVt9rnDn
	PTRgwapBsXR9tIMhERhWfkDiGgFWATA1CjkV2r7j9G1d4VC5RZ7rJnOk2NYqkgeJgjwlrMOURxq
	fiZ8h7XKGMtlPmCjn7wRpxhyAP+HJNbpkAzL2LbVqikJk7yp5CCpwnpOh5qPe0/5/aQylwZuMF+
	xsnG/mILfcN6E=
X-Google-Smtp-Source: AGHT+IFX44FP+6uhi8ESu+hZYUA9VZRq2GFzIF2wgk+I+7D6HivsuIUPHxrfwCp3fzDSsaNqTFAxyg==
X-Received: by 2002:a05:7301:1e42:b0:2ab:c279:9dce with SMTP id 5a478bee46e88-2b17d1fae3fmr711025eec.7.1767749368383;
        Tue, 06 Jan 2026 17:29:28 -0800 (PST)
Received: from [127.0.0.1] ([52.159.246.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673bc0sm5880246eec.5.2026.01.06.17.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:29:27 -0800 (PST)
Message-Id: <pull.2026.v2.git.1767749366719.gitgitgadget@gmail.com>
In-Reply-To: <pull.2026.git.1767035549378.gitgitgadget@gmail.com>
References: <pull.2026.git.1767035549378.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Jan 2026 01:29:26 +0000
Subject: [PATCH v2] fsck: snapshot default refs before object walk
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
Cc: Matthew John Cheetham <mjcheetham@outlook.com>,
    Jeff King <peff@peff.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Fsck has a race when operating on live repositories; consider the
following simple script that writes new commits as fsck runs:

    #!/bin/bash
    git fsck &
    PID=$!

    while ps -p $PID >/dev/null; do
        sleep 3
        git commit -q --allow-empty -m "Another commit"
    done

Since fsck walks objects for connectivity and then reads the refs at the
end to check, this can cause fsck to get confused and think that the new
refs refer to missing commits and that new reflog entries are invalid.
Running the above script in a clone of git.git results in the following
(output ellipsized to remove additional errors of the same type):

    $ ./fsck-while-writing.sh
    Checking ref database: 100% (1/1), done.
    Checking object directories: 100% (256/256), done.
    warning in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: missingTaggerEntry: invalid format - expected 'tagger' line
    Checking objects: 100% (835091/835091), done.
    error: HEAD: invalid reflog entry 2aac9f9286e2164fbf8e4f1d1df53044ace2b310
    error: HEAD: invalid reflog entry 2aac9f9286e2164fbf8e4f1d1df53044ace2b310
    error: HEAD: invalid reflog entry da0f5b80d61844a6f0ad2ddfd57e4fdfa246ea68
    error: HEAD: invalid reflog entry da0f5b80d61844a6f0ad2ddfd57e4fdfa246ea68
    [...]
    error: HEAD: invalid reflog entry 87c8a5c2f6b79d9afa9e941590b9a097b6f7ac09
    error: HEAD: invalid reflog entry d80887a48865e6ad165274b152cbbbed29f8a55a
    error: HEAD: invalid reflog entry d80887a48865e6ad165274b152cbbbed29f8a55a
    error: HEAD: invalid reflog entry 6724f2dfede88bfa9445a333e06e78536c0c6c0d
    error: refs/heads/mybranch invalid reflog entry 2aac9f9286e2164fbf8e4f1d1df53044ace2b310
    error: refs/heads/mybranch: invalid reflog entry 2aac9f9286e2164fbf8e4f1d1df53044ace2b310
    error: refs/heads/mybranch: invalid reflog entry da0f5b80d61844a6f0ad2ddfd57e4fdfa246ea68
    error: refs/heads/mybranch: invalid reflog entry da0f5b80d61844a6f0ad2ddfd57e4fdfa246ea68
    [...]
    error: refs/heads/mybranch: invalid reflog entry 87c8a5c2f6b79d9afa9e941590b9a097b6f7ac09
    error: refs/heads/mybranch: invalid reflog entry d80887a48865e6ad165274b152cbbbed29f8a55a
    error: refs/heads/mybranch: invalid reflog entry d80887a48865e6ad165274b152cbbbed29f8a55a
    error: refs/heads/mybranch: invalid reflog entry 6724f2dfede88bfa9445a333e06e78536c0c6c0d
    Checking connectivity: 833846, done.
    missing commit 6724f2dfede88bfa9445a333e06e78536c0c6c0d
    Verifying commits in commit graph: 100% (242243/242243), done.

We can minimize the race opportunities by taking a snapshot of refs at
program invocation, doing the connectivity check, and then checking the
snapshotted refs afterward.  This avoids races with regular refs between
fsck and adding objects to the database, though it still leaves a race
between a gc and fsck.  We are less concerned about folks simultaneously
running gc with fsck; though, if it becomes an issue, we could lock fsck
during gc.  We definitely do not want to lock fsck during operations
that may add objects to the object store; that would be problematic for
forges.

Note that refs aren't the only problem, though; reflog entries and index
entries could be problematic as well.  For now we punt on index entries
just leaving a TODO comment, and for reflogs we use a coarse solution of
taking the time at the beginning of the program and ignoring reflog
entries newer than that time.  That may be imperfect if dealing with a
network filesystem, so we leave TODO comment for those that want to
improve that handling as well.

As a high level overview:
  * In addition to fsck_handle_ref(), which now is only a few lines long
    to process a ref, there's also a snapshot_ref() which is called
    early in the program for each ref and takes all the error checking
    logic.
  * The iterating over refs that used to be in get_default_heads() plus
    a loop over the arguments now appears in shapshot_refs().
  * There's a new process_refs() as well that kind of looks like the old
    get_default_heads() though it is streamlined due to the work done by
    snapshot_refs().

This combination of changes modifies the output of running the script
(from the beginning of this commit message) to:

    $ ./fsck-while-writing.sh
    Checking ref database: 100% (1/1), done.
    Checking object directories: 100% (256/256), done.
    warning in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: missingTaggerEntry: invalid format - expected 'tagger' line
    Checking objects: 100% (835091/835091), done.
    Checking connectivity: 833846, done.
    Verifying commits in commit graph: 100% (242243/242243), done.

While worries about live updates while running fsck is likely of most
interest for forge operators, it may also benefit those with
automated jobs (such as git maintenance) or even casual users who want
to do other work in their clone while fsck is running.

Originally-based-on-a-patch-by: Matthew John Cheetham <mjcheetham@outlook.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fsck: snapshot default refs before object walk
    
    Changes in v2, thanks to feedback & help from Peff & Junio:
    
     * Fixed errors in commit message
     * Changed to use a refname, oid struct and have an array of those
     * Snapshot command line arguments and worktree HEADs too
     * Add TODO items for snapshotting index entries, and for possibly
       improved reflog handling
     * Since nothing from Matthew's original patch in GitHub's fork of git
       remains in this patch by v2 (only a little of it remained in v1), I
       changed authorship to myself and gave Matthew an
       Originally-based-on-a-patch-by trailer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2026%2Fnewren%2Ffsck-snapshot-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2026/newren/fsck-snapshot-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2026

Range-diff vs v1:

 1:  394b84bb70 ! 1:  7af3e9b92e fsck: snapshot default refs before object walk
     @@
       ## Metadata ##
     -Author: Matthew John Cheetham <mjcheetham@outlook.com>
     +Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
          fsck: snapshot default refs before object walk
     @@ Commit message
                  git commit -q --allow-empty -m "Another commit"
              done
      
     -    Since fsck reads refs at the beginning, walks those for connectivity,
     -    and then reads the refs again at the end to check, this can cause fsck
     -    to get confused and think that the new refs refer to missing commits and
     -    that new reflog entries are invalid.  Running the above script in a
     -    clone of git.git results in the following (output ellipsized to remove
     -    additional errors of the same type):
     +    Since fsck walks objects for connectivity and then reads the refs at the
     +    end to check, this can cause fsck to get confused and think that the new
     +    refs refer to missing commits and that new reflog entries are invalid.
     +    Running the above script in a clone of git.git results in the following
     +    (output ellipsized to remove additional errors of the same type):
      
              $ ./fsck-while-writing.sh
              Checking ref database: 100% (1/1), done.
     @@ Commit message
              missing commit 6724f2dfede88bfa9445a333e06e78536c0c6c0d
              Verifying commits in commit graph: 100% (242243/242243), done.
      
     -    This problem doesn't occur when refs are specified on the command line
     -    for us to check, since we use those specified refs for both walking and
     -    checking.  Using the same refs for walking and checking seems to just
     -    make sense, so modify the existing code to do the same when refs aren't
     -    specified.  Snapshot the refs at the beginning, and also ignore all
     -    reflog entries since the time of our snapshot (while this technically
     -    means we could ignore a reflog entry created before the fsck process
     -    if the local clock is weird, since reflogs are local-only there are not
     -    concerns about differences between clocks on different machines).  This
     -    combination of changes modifies the output of running the above script
     -    to:
     +    We can minimize the race opportunities by taking a snapshot of refs at
     +    program invocation, doing the connectivity check, and then checking the
     +    snapshotted refs afterward.  This avoids races with regular refs between
     +    fsck and adding objects to the database, though it still leaves a race
     +    between a gc and fsck.  We are less concerned about folks simultaneously
     +    running gc with fsck; though, if it becomes an issue, we could lock fsck
     +    during gc.  We definitely do not want to lock fsck during operations
     +    that may add objects to the object store; that would be problematic for
     +    forges.
     +
     +    Note that refs aren't the only problem, though; reflog entries and index
     +    entries could be problematic as well.  For now we punt on index entries
     +    just leaving a TODO comment, and for reflogs we use a coarse solution of
     +    taking the time at the beginning of the program and ignoring reflog
     +    entries newer than that time.  That may be imperfect if dealing with a
     +    network filesystem, so we leave TODO comment for those that want to
     +    improve that handling as well.
     +
     +    As a high level overview:
     +      * In addition to fsck_handle_ref(), which now is only a few lines long
     +        to process a ref, there's also a snapshot_ref() which is called
     +        early in the program for each ref and takes all the error checking
     +        logic.
     +      * The iterating over refs that used to be in get_default_heads() plus
     +        a loop over the arguments now appears in shapshot_refs().
     +      * There's a new process_refs() as well that kind of looks like the old
     +        get_default_heads() though it is streamlined due to the work done by
     +        snapshot_refs().
     +
     +    This combination of changes modifies the output of running the script
     +    (from the beginning of this commit message) to:
      
              $ ./fsck-while-writing.sh
              Checking ref database: 100% (1/1), done.
     @@ Commit message
              Verifying commits in commit graph: 100% (242243/242243), done.
      
          While worries about live updates while running fsck is likely of most
     -    interest for forge operators, it will likely also benefit those with
     +    interest for forge operators, it may also benefit those with
          automated jobs (such as git maintenance) or even casual users who want
          to do other work in their clone while fsck is running.
      
     -    Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
     -    Co-authored-by: Elijah Newren <newren@gmail.com>
     -    [en: several changes:
     -      * adjusted for upstream refactorings to refs callback call signatures
     -      * handle reflogs as well
     -      * free recorded snapshot of refs when done
     -      * default to snapshotting instead of making it a non-default option
     -      * provide reproducible testcase in commit message and rewrite commit
     -        message around it
     -    ]
     +    Originally-based-on-a-patch-by: Matthew John Cheetham <mjcheetham@outlook.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/fsck.c ##
     @@ builtin/fsck.c: static int fsck_handle_reflog_ent(const char *refname,
       	if (verbose)
       		fprintf_ln(stderr, _("Checking reflog %s->%s"),
       			   oid_to_hex(ooid), oid_to_hex(noid));
     -@@ builtin/fsck.c: static int fsck_head_link(const char *head_ref_name,
     - 			  const char **head_points_at,
     - 			  struct object_id *head_oid);
     +@@ builtin/fsck.c: static int fsck_handle_reflog(const char *logname, void *cb_data)
     + 	return 0;
     + }
       
     --static void get_default_heads(void)
     +-static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
      +struct ref_snapshot {
     -+	size_t nr;
     -+	size_t name_alloc;
     -+	size_t oid_alloc;
     -+	char **refname;
     -+	struct object_id *oid;
     ++	char *refname;
     ++	struct object_id oid;
     ++	/* TODO: Maybe supplement with latest reflog entry info too? */
      +};
      +
     -+static int snapshot_refs(const struct reference *ref, void *cb_data)
     -+{
     -+	struct ref_snapshot *refs = cb_data;
     ++struct snapshot {
     ++	size_t nr;
     ++	size_t alloc;
     ++	struct ref_snapshot *ref;
     ++	/* TODO: Consider also snapshotting the index of each worktree. */
     ++};
      +
     -+	ALLOC_GROW(refs->refname, refs->nr + 1, refs->name_alloc);
     -+	ALLOC_GROW(refs->oid, refs->nr + 1, refs->oid_alloc);
     ++static int snapshot_ref(const struct reference *ref, void *cb_data)
     + {
     ++	struct snapshot *snap = cb_data;
     + 	struct object *obj;
     + 
     + 	obj = parse_object(the_repository, ref->oid);
     +@@ builtin/fsck.c: static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
     + 		errors_found |= ERROR_REFS;
     + 	}
     + 	default_refs++;
      +
     -+	refs->refname[refs->nr] = xstrdup(ref->name);
     -+	oidcpy(&refs->oid[refs->nr], ref->oid);
     -+	refs->nr++;
     ++	ALLOC_GROW(snap->ref, snap->nr + 1, snap->alloc);
     ++	snap->ref[snap->nr].refname = xstrdup(ref->name);
     ++	oidcpy(&snap->ref[snap->nr].oid, ref->oid);
     ++	snap->nr++;
      +
      +	return 0;
      +}
      +
     -+static void free_snapshot_refs(struct ref_snapshot *snapshot)
     ++static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
      +{
     -+	for (size_t i = 0; i < snapshot->nr; i++)
     -+		free(snapshot->refname[i]);
     -+	free(snapshot->refname);
     -+	free(snapshot->oid);
     -+}
     ++	struct object *obj;
      +
     -+static void get_default_heads(struct ref_snapshot *the_refs)
     ++	obj = parse_object(the_repository, ref->oid);
     + 	obj->flags |= USED;
     + 	fsck_put_object_name(&fsck_walk_options,
     + 			     ref->oid, "%s", ref->name);
     +@@ builtin/fsck.c: static int fsck_head_link(const char *head_ref_name,
     + 			  const char **head_points_at,
     + 			  struct object_id *head_oid);
     + 
     +-static void get_default_heads(void)
     ++static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
       {
       	struct worktree **worktrees, **p;
       	const char *head_points_at;
       	struct object_id head_oid;
       
     --	refs_for_each_rawref(get_main_ref_store(the_repository),
     --			     fsck_handle_ref, NULL);
     -+	if (the_refs)
     -+		for (size_t i = 0; i < the_refs->nr; i++) {
     ++	for (int i = 0; i < argc; i++) {
     ++		const char *arg = argv[i];
     ++		struct object_id oid;
     ++		if (!repo_get_oid(the_repository, arg, &oid)) {
      +			struct reference ref = {
     -+				.name = the_refs->refname[i],
     -+				.oid = &the_refs->oid[i],
     ++				.name = arg,
     ++				.oid = &oid,
      +			};
     -+			fsck_handle_ref(&ref, NULL);
     ++
     ++			snapshot_ref(&ref, snap);
     ++			continue;
      +		}
     -+	else
     -+		refs_for_each_rawref(get_main_ref_store(the_repository),
     -+				     fsck_handle_ref, NULL);
     ++		error(_("invalid parameter: expected sha1, got '%s'"), arg);
     ++		errors_found |= ERROR_OBJECT;
     ++	}
     ++
     ++	if (argc) {
     ++		include_reflogs = 0;
     ++		return;
     ++	}
     ++
     + 	refs_for_each_rawref(get_main_ref_store(the_repository),
     +-			     fsck_handle_ref, NULL);
     ++			     snapshot_ref, snap);
       
       	worktrees = get_worktrees();
       	for (p = worktrees; *p; p++) {
     +@@ builtin/fsck.c: static void get_default_heads(void)
     + 				.oid = &head_oid,
     + 			};
     + 
     +-			fsck_handle_ref(&ref, NULL);
     ++			snapshot_ref(&ref, snap);
     + 		}
     + 		strbuf_release(&refname);
     + 
     +-		if (include_reflogs)
     ++		/*
     ++		 * TODO: Could use refs_for_each_reflog(...) to find
     ++		 * latest entry instead of using a global 'now' for that
     ++		 * purpose.
     ++		 */
     ++	}
     ++	free_worktrees(worktrees);
     ++
     ++	/* Ignore reflogs newer than now */
     ++	now = time(NULL);
     ++}
     ++
     ++
     ++static void free_snapshot_refs(struct snapshot *snap)
     ++{
     ++	for (size_t i = 0; i < snap->nr; i++)
     ++		free(snap->ref[i].refname);
     ++	free(snap->ref);
     ++}
     ++
     ++static void process_refs(struct snapshot *snap)
     ++{
     ++	struct worktree **worktrees, **p;
     ++
     ++	for (size_t i = 0; i < snap->nr; i++) {
     ++		struct reference ref = {
     ++			.name = snap->ref[i].refname,
     ++			.oid = &snap->ref[i].oid,
     ++		};
     ++		fsck_handle_ref(&ref, NULL);
     ++	}
     ++
     ++	if (include_reflogs) {
     ++		worktrees = get_worktrees();
     ++		for (p = worktrees; *p; p++) {
     ++			struct worktree *wt = *p;
     ++
     + 			refs_for_each_reflog(get_worktree_ref_store(wt),
     + 					     fsck_handle_reflog, wt);
     ++		}
     ++		free_worktrees(worktrees);
     + 	}
     +-	free_worktrees(worktrees);
     + 
     + 	/*
     + 	 * Not having any default heads isn't really fatal, but
      @@ builtin/fsck.c: int cmd_fsck(int argc,
     + 	     const char *prefix,
     + 	     struct repository *repo UNUSED)
       {
     - 	int i;
     +-	int i;
       	struct odb_source *source;
     -+	struct ref_snapshot default_refs_snapshot = {
     ++	struct snapshot snap = {
      +		.nr = 0,
     -+		.name_alloc = 0,
     -+		.oid_alloc = 0,
     -+		.refname = NULL,
     -+		.oid = NULL
     ++		.alloc = 0,
     ++		.ref = NULL
      +	};
     -+	bool use_snapshot;
       
       	/* fsck knows how to handle missing promisor objects */
       	fetch_if_missing = 0;
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      +	 * objects. We can still walk over new objects that are added during the
      +	 * execution of fsck but won't miss any objects that were reachable.
      +	 */
     -+	use_snapshot = !argc;
     -+	if (use_snapshot) {
     -+		now = time(NULL);
     -+		refs_for_each_rawref(get_main_ref_store(the_repository),
     -+				     snapshot_refs, &default_refs_snapshot);
     -+	}
     ++	snapshot_refs(&snap, argc, argv);
     ++
     ++	/* Ensure we get a "fresh" view of the odb */
     ++	odb_reprepare(the_repository->objects);
      +
       	if (connectivity_only) {
       		for_each_loose_object(the_repository->objects,
       				      mark_loose_for_connectivity, NULL, 0);
      @@ builtin/fsck.c: int cmd_fsck(int argc,
     - 	 * in this case (ie this implies --cache).
     - 	 */
     - 	if (!argc) {
     + 			errors_found |= ERROR_OBJECT;
     + 	}
     + 
     +-	for (i = 0; i < argc; i++) {
     +-		const char *arg = argv[i];
     +-		struct object_id oid;
     +-		if (!repo_get_oid(the_repository, arg, &oid)) {
     +-			struct object *obj = lookup_object(the_repository,
     +-							   &oid);
     +-
     +-			if (!obj || !(obj->flags & HAS_OBJ)) {
     +-				if (is_promisor_object(the_repository, &oid))
     +-					continue;
     +-				error(_("%s: object missing"), oid_to_hex(&oid));
     +-				errors_found |= ERROR_OBJECT;
     +-				continue;
     +-			}
     +-
     +-			obj->flags |= USED;
     +-			fsck_put_object_name(&fsck_walk_options, &oid,
     +-					     "%s", arg);
     +-			mark_object_reachable(obj);
     +-			continue;
     +-		}
     +-		error(_("invalid parameter: expected sha1, got '%s'"), arg);
     +-		errors_found |= ERROR_OBJECT;
     +-	}
     ++	/* Process the snapshotted refs and the reflogs. */
     ++	process_refs(&snap);
     + 
     +-	/*
     +-	 * If we've not been given any explicit head information, do the
     +-	 * default ones from .git/refs. We also consider the index file
     +-	 * in this case (ie this implies --cache).
     +-	 */
     +-	if (!argc) {
      -		get_default_heads();
     -+		get_default_heads(use_snapshot ? &default_refs_snapshot : NULL);
     ++	/* If not given any explicit objects, process index files too. */
     ++	if (!argc)
       		keep_cache_objects = 1;
     - 	}
     +-	}
     +-
     + 	if (keep_cache_objects) {
     ++		/*
     ++		 * TODO: Consider first walking these indexes in snapshot_refs,
     ++		 * to snapshot where the index entries used to point, and then
     ++		 * check those snapshotted locations here.
     ++		 */
     + 		struct worktree **worktrees, **p;
       
     + 		verify_index_checksum = 1;
      @@ builtin/fsck.c: int cmd_fsck(int argc,
       		}
       	}
       
     -+	if (use_snapshot)
     -+		free_snapshot_refs(&default_refs_snapshot);
     ++	free_snapshot_refs(&snap);
       	return errors_found;
       }


 builtin/fsck.c | 162 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 122 insertions(+), 40 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index c489582faa..eec4626bfa 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -51,6 +51,7 @@ static int show_progress = -1;
 static int show_dangling = 1;
 static int name_objects;
 static int check_references = 1;
+static timestamp_t now;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -509,6 +510,9 @@ static int fsck_handle_reflog_ent(const char *refname,
 				  timestamp_t timestamp, int tz UNUSED,
 				  const char *message UNUSED, void *cb_data UNUSED)
 {
+	if (now && timestamp > now)
+		return 0;
+
 	if (verbose)
 		fprintf_ln(stderr, _("Checking reflog %s->%s"),
 			   oid_to_hex(ooid), oid_to_hex(noid));
@@ -530,8 +534,22 @@ static int fsck_handle_reflog(const char *logname, void *cb_data)
 	return 0;
 }
 
-static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
+struct ref_snapshot {
+	char *refname;
+	struct object_id oid;
+	/* TODO: Maybe supplement with latest reflog entry info too? */
+};
+
+struct snapshot {
+	size_t nr;
+	size_t alloc;
+	struct ref_snapshot *ref;
+	/* TODO: Consider also snapshotting the index of each worktree. */
+};
+
+static int snapshot_ref(const struct reference *ref, void *cb_data)
 {
+	struct snapshot *snap = cb_data;
 	struct object *obj;
 
 	obj = parse_object(the_repository, ref->oid);
@@ -555,6 +573,20 @@ static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
 		errors_found |= ERROR_REFS;
 	}
 	default_refs++;
+
+	ALLOC_GROW(snap->ref, snap->nr + 1, snap->alloc);
+	snap->ref[snap->nr].refname = xstrdup(ref->name);
+	oidcpy(&snap->ref[snap->nr].oid, ref->oid);
+	snap->nr++;
+
+	return 0;
+}
+
+static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
+{
+	struct object *obj;
+
+	obj = parse_object(the_repository, ref->oid);
 	obj->flags |= USED;
 	fsck_put_object_name(&fsck_walk_options,
 			     ref->oid, "%s", ref->name);
@@ -567,14 +599,35 @@ static int fsck_head_link(const char *head_ref_name,
 			  const char **head_points_at,
 			  struct object_id *head_oid);
 
-static void get_default_heads(void)
+static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 {
 	struct worktree **worktrees, **p;
 	const char *head_points_at;
 	struct object_id head_oid;
 
+	for (int i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		struct object_id oid;
+		if (!repo_get_oid(the_repository, arg, &oid)) {
+			struct reference ref = {
+				.name = arg,
+				.oid = &oid,
+			};
+
+			snapshot_ref(&ref, snap);
+			continue;
+		}
+		error(_("invalid parameter: expected sha1, got '%s'"), arg);
+		errors_found |= ERROR_OBJECT;
+	}
+
+	if (argc) {
+		include_reflogs = 0;
+		return;
+	}
+
 	refs_for_each_rawref(get_main_ref_store(the_repository),
-			     fsck_handle_ref, NULL);
+			     snapshot_ref, snap);
 
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
@@ -589,15 +642,52 @@ static void get_default_heads(void)
 				.oid = &head_oid,
 			};
 
-			fsck_handle_ref(&ref, NULL);
+			snapshot_ref(&ref, snap);
 		}
 		strbuf_release(&refname);
 
-		if (include_reflogs)
+		/*
+		 * TODO: Could use refs_for_each_reflog(...) to find
+		 * latest entry instead of using a global 'now' for that
+		 * purpose.
+		 */
+	}
+	free_worktrees(worktrees);
+
+	/* Ignore reflogs newer than now */
+	now = time(NULL);
+}
+
+
+static void free_snapshot_refs(struct snapshot *snap)
+{
+	for (size_t i = 0; i < snap->nr; i++)
+		free(snap->ref[i].refname);
+	free(snap->ref);
+}
+
+static void process_refs(struct snapshot *snap)
+{
+	struct worktree **worktrees, **p;
+
+	for (size_t i = 0; i < snap->nr; i++) {
+		struct reference ref = {
+			.name = snap->ref[i].refname,
+			.oid = &snap->ref[i].oid,
+		};
+		fsck_handle_ref(&ref, NULL);
+	}
+
+	if (include_reflogs) {
+		worktrees = get_worktrees();
+		for (p = worktrees; *p; p++) {
+			struct worktree *wt = *p;
+
 			refs_for_each_reflog(get_worktree_ref_store(wt),
 					     fsck_handle_reflog, wt);
+		}
+		free_worktrees(worktrees);
 	}
-	free_worktrees(worktrees);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
@@ -962,8 +1052,12 @@ int cmd_fsck(int argc,
 	     const char *prefix,
 	     struct repository *repo UNUSED)
 {
-	int i;
 	struct odb_source *source;
+	struct snapshot snap = {
+		.nr = 0,
+		.alloc = 0,
+		.ref = NULL
+	};
 
 	/* fsck knows how to handle missing promisor objects */
 	fetch_if_missing = 0;
@@ -999,6 +1093,17 @@ int cmd_fsck(int argc,
 	if (check_references)
 		fsck_refs(the_repository);
 
+	/*
+	 * Take a snapshot of the refs before walking objects to avoid looking
+	 * at a set of refs that may be changed by the user while we are walking
+	 * objects. We can still walk over new objects that are added during the
+	 * execution of fsck but won't miss any objects that were reachable.
+	 */
+	snapshot_refs(&snap, argc, argv);
+
+	/* Ensure we get a "fresh" view of the odb */
+	odb_reprepare(the_repository->objects);
+
 	if (connectivity_only) {
 		for_each_loose_object(the_repository->objects,
 				      mark_loose_for_connectivity, NULL, 0);
@@ -1040,42 +1145,18 @@ int cmd_fsck(int argc,
 			errors_found |= ERROR_OBJECT;
 	}
 
-	for (i = 0; i < argc; i++) {
-		const char *arg = argv[i];
-		struct object_id oid;
-		if (!repo_get_oid(the_repository, arg, &oid)) {
-			struct object *obj = lookup_object(the_repository,
-							   &oid);
-
-			if (!obj || !(obj->flags & HAS_OBJ)) {
-				if (is_promisor_object(the_repository, &oid))
-					continue;
-				error(_("%s: object missing"), oid_to_hex(&oid));
-				errors_found |= ERROR_OBJECT;
-				continue;
-			}
-
-			obj->flags |= USED;
-			fsck_put_object_name(&fsck_walk_options, &oid,
-					     "%s", arg);
-			mark_object_reachable(obj);
-			continue;
-		}
-		error(_("invalid parameter: expected sha1, got '%s'"), arg);
-		errors_found |= ERROR_OBJECT;
-	}
+	/* Process the snapshotted refs and the reflogs. */
+	process_refs(&snap);
 
-	/*
-	 * If we've not been given any explicit head information, do the
-	 * default ones from .git/refs. We also consider the index file
-	 * in this case (ie this implies --cache).
-	 */
-	if (!argc) {
-		get_default_heads();
+	/* If not given any explicit objects, process index files too. */
+	if (!argc)
 		keep_cache_objects = 1;
-	}
-
 	if (keep_cache_objects) {
+		/*
+		 * TODO: Consider first walking these indexes in snapshot_refs,
+		 * to snapshot where the index entries used to point, and then
+		 * check those snapshotted locations here.
+		 */
 		struct worktree **worktrees, **p;
 
 		verify_index_checksum = 1;
@@ -1148,5 +1229,6 @@ int cmd_fsck(int argc,
 		}
 	}
 
+	free_snapshot_refs(&snap);
 	return errors_found;
 }

base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45
-- 
gitgitgadget
