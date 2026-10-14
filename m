Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96547F771
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012840; cv=none; b=CC9QCnkvwXFv7KlZpKPzvdbQqtpgm/r+lM3WVZuCjeweGBGkOEqXhci97LQLJiTYkLcFeTdEuBp/IqlxEROin5X3D6l3ldH/wm9j8uDw7mrflFc1r0TWoCViKjqrmAzVuzTyi3a7l6QccJxj+HPSmkYd07Ws65hZsl/tNFVGYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012840; c=relaxed/simple;
	bh=2b0Ds9GnYv0/kFti8+Ysg15Lnz8XFL2oCQHHV9+eH08=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Akvz7zAmJrmXv1Y0RJJi9EdUquxtlARLN5EpMWvTZVTMOF3w06hqof1zhlS538FTuaz9vdAVLcebOfBFXfntJZ6Kz6eXsBiYChTAy2tVEXnzZX9lk3FbtMRT7PnvNrQTPQaVRtM2oNeIjR3c42zgxL30didMCOvhYbeiLUMoTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXJLVeEW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXJLVeEW"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e635220b4so454141685a.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012838; x=1792617638; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IpuKlvx6rfzX4IMHkhyuUyCCsu/NBYTmwbGywsWNNNc=;
        b=pXJLVeEW6TvCNTsU9S8gD/j6q92LmgN+qy+Z7E4NKlNbOU0Lp9XwhjuvLkXDP0ImMK
         YOI+T8wH7/L0VmiJcu6cXZC67H792rtAdRfSjLpL8wDGDr62+N3iG1AYv3NpqebX2yWc
         Y3hg8lLFwfwWZfcD6FgEGgXnNhgR7kAk6KRltarrf660S6n7dhShQt9Vv/Ajapljmdn0
         1gmOa3mth3zPgvk5Mq5iyFmz77YcSCvglJ/61feJ+PcsmLApsLlpraelMqObY1NOOgpi
         K+4l/QN8fRWFClTtcpIAkCWFBbEpfMyznmhVpja1JveCxfNQgx1ZJ1XXFJbLMl9l/EMG
         1Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012838; x=1792617638;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpuKlvx6rfzX4IMHkhyuUyCCsu/NBYTmwbGywsWNNNc=;
        b=nHtdIw7//3Up0CSo0rbUiwhLYM9JdGcFQDdJifqkmGA1R+KlbvnCghdj0wdx4PgPwW
         DHaf1P4smd35WnjhxUCmZbQ3KhxK0xXwrse/iuYQ3nnfPvuezmhSos2LJM5ATKQf/YwZ
         7ujqxmj8Dnnc1ye3BPkMApw8SoAOYqWRIRK0Mm1OUNz+aqWakgCkRutrt0driz6wABNt
         YbkLWD3ISBq3r4SjG5Ma2b1wV2cNDqPyhB5Cwks3FS6nRBaJhisJIlkcn458e75uaca8
         fCbvo62GDNzpyrRQtXxioNWhvrN9I7z+9cy7YnpnuX6dBPnmsIC2Yix6xsNXWpnNbC/o
         3ZYA==
X-Gm-Message-State: AFq9FYIhJF0jmpT/N1Njs72af24v5wlhPGMgT/BQxbUfjFywGCx3qna5
	DEpebwhN4wmJb7GPK4BfyFAPj5sUlVaWAGGf8bJXuOQVpRLzgkqr4A6Hhh//lA==
X-Gm-Gg: AYBFou2nBKNUog06gd2diF6bxWARQlaf4z0yfuMuRd/9AAXLGt4/Xxy4zXhLQ+oRAyw
	k+mMm9Lfo/3TAJgoTqVhqhG3T7SwnMVsVnoSPQ+Sr3dLkhklqszPL+QO8m2trbYXWabJ7adQjdX
	ByF3IfwsSlW3Hkar0P2bke+slF4wBcFprIf4smWAGxPiAIKvaPS53bHG96fqIx8mx5UhiAQuwvD
	t3+uWww0DN8eOi5j9tlLaPtkY0sAw2bDkdEgRPhErdStjzHfaTx4NEl1Vcjkt6KhrY0LxDWQ+3c
	HLGEs1+adWEr71zc4ByIBOY5BlEni3kBIo+TDRWbwUFmpiU77oJB7mFrSasYjy5OyiAft4nY8Cv
	m4nSicUiiGUBV72DAkdwBm/PK+cYN+VcOBpcVR98OCNfI/TfuJPmAloy22QKxktC8kmlC4+BWln
	7lNqrprb1q8n/V+Hvlu4FBbM2VZuyveRtIpbYN6c62LjEAbGMxeYFaPl6luLMldYHV9OCDMycmu
	Q==
X-Received: by 2002:a05:620a:2b8b:b0:93e:c12c:fbb6 with SMTP id af79cd13be357-93ec12d082emr2732660485a.67.1792012837757;
        Wed, 14 Oct 2026 14:20:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.220.125.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50adf59sm597238785a.45.2026.10.14.14.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:20:37 -0700 (PDT)
Message-Id: <pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 21:20:31 +0000
Subject: [PATCH v2 0/5] worktree repair: avoid breaking unrelated .git file and gitdir
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

'git worktree repair' does not sufficiently validate the cross-references
between a linked working tree and its administrative data before repairing
them. This can cause the repair to modify the wrong .git file or gitdir in
certain situations.


v2 (0156021)
============

Split the first commit of v1 to make the changes easier to understand. Fold
long lines.

 * [1/5] align .git file handling with repair_gitfile()
 * [2/5] centralize inferred backlink selection
 * [3/5] use read_gitfile_raw() in infer_backlink()
 * [4/5] reduce .git file reads
 * [5/5] avoid breaking unrelated .git file and gitdir


v1 (99aa341)
============

This series first refactors the code to read the .git file once and extract
the worktree ID, then uses that information to validate the repair target
before modifying the cross-references.

 * [1/2] Refactor the code without changing functionality before making the
   fix
 * [2/2] Validate the worktree ID and inferred gitdir path before repairing

Yoichi NAKAYAMA (5):
  worktree repair: align .git file handling with repair_gitfile()
  worktree repair: centralize inferred backlink selection
  worktree repair: use read_gitfile_raw() in infer_backlink()
  worktree repair: reduce .git file reads
  worktree repair: avoid breaking unrelated .git file and gitdir

 t/t2406-worktree-repair.sh |  33 +++++++++--
 worktree.c                 | 113 +++++++++++++++++++++----------------
 2 files changed, 91 insertions(+), 55 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2225%2Fyoichi%2Fworktree-repair-keep-unrelated-gitfile-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2225/yoichi/worktree-repair-keep-unrelated-gitfile-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2225

Range-diff vs v1:

 -:  ---------- > 1:  21b2878aa5 worktree repair: align .git file handling with repair_gitfile()
 1:  dc7ebb427b ! 2:  30ac7acad3 worktree repair: refactor and reduce .git file reads
     @@ Metadata
      Author: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
       ## Commit message ##
     -    worktree repair: refactor and reduce .git file reads
     +    worktree repair: centralize inferred backlink selection
      
     -    Remove the file reading and trimming logic from `infer_backlink()`,
     -    and instead read the .git file once in its caller,
     -    `repair_worktree_at_path()`, using `read_gitfile_raw()`. Since
     -    `read_gitfile_gently()` is replaced with `read_gitfile_raw()`, restore
     -    the logic for constructing the absolute path and replace the
     -    READ_GITFILE_ERR_NOT_A_REPO handling with a check using
     -    `is_git_directory()`. Simplify the logic for prioritizing
     -    'inferred_backlink' over 'backlink'.
     -
     -    Extract `get_worktree_id()` to get the worktree ID from the contents
     -    of the .git file. We are going to modify and use this function in
     -    subsequent commits.
     +    Reorder the processing steps to centralize the logic for preferring
     +    the inferred_backlink.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
       ## worktree.c ##
     -@@ worktree.c: int other_head_refs(struct repository *repo,
     - 	return ret;
     - }
     - 
     -+static const char *get_worktree_id(const char *dotgit_contents)
     -+{
     -+	const char *slash = find_last_dir_sep(dotgit_contents);
     -+	if (!slash)
     -+		return "";
     -+	return slash + 1;
     -+}
     -+
     - /*
     -  * Repair worktree's /path/to/worktree/.git file if missing, corrupt, or not
     -  * pointing at <repo>/worktrees/<id>.
     -@@ worktree.c: static int is_main_worktree_path(struct repository *repo, const char *path)
     -  * Returns -1 on failure and strbuf.len on success.
     -  */
     - static ssize_t infer_backlink(struct repository *repo,
     --			      const char *gitfile,
     -+			      const char *dotgit_contents,
     - 			      struct strbuf *inferred)
     - {
     --	struct strbuf actual = STRBUF_INIT;
     - 	const char *id;
     - 
     --	if (strbuf_read_file(&actual, gitfile, 0) < 0)
     --		goto error;
     --	if (!starts_with(actual.buf, "gitdir:"))
     --		goto error;
     --	if (!(id = find_last_dir_sep(actual.buf)))
     --		goto error;
     --	strbuf_trim(&actual);
     --	id++; /* advance past '/' to point at <id> */
     -+	id = get_worktree_id(dotgit_contents);
     - 	if (!*id)
     - 		goto error;
     - 	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
     - 	if (!is_directory(inferred->buf))
     - 		goto error;
     - 
     --	strbuf_release(&actual);
     - 	return inferred->len;
     - error:
     --	strbuf_release(&actual);
     - 	strbuf_reset(inferred); /* clear invalid path */
     - 	return -1;
     - }
      @@ worktree.c: void repair_worktree_at_path(struct repository *repo,
     - 	struct strbuf inferred_backlink = STRBUF_INIT;
       	struct strbuf gitdir = STRBUF_INIT;
       	struct strbuf olddotgit = STRBUF_INIT;
     --	char *dotgit_contents = NULL;
     -+	struct strbuf contents = STRBUF_INIT;
     + 	struct strbuf contents = STRBUF_INIT;
      +	const char *dotgit_contents = NULL;
       	const char *repair = NULL;
       	int err;
     @@ worktree.c: void repair_worktree_at_path(struct repository *repo,
       
      -	infer_backlink(repo, dotgit.buf, &inferred_backlink);
      -	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
     --	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
     --	if (dotgit_contents) {
     --		strbuf_addstr(&backlink, dotgit_contents);
     --	} else if (err == READ_GITFILE_ERR_NOT_A_FILE ||
     --			err == READ_GITFILE_ERR_IS_A_DIR) {
     -+	err = read_gitfile_raw(&contents, dotgit.buf);
     -+	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
     -+	    err == READ_GITFILE_ERR_IS_A_DIR) {
     - 		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
     + 	err = read_gitfile_raw(&contents, dotgit.buf);
     +-	if (!err) {
     +-		const char *dotgit_contents = contents.buf;
     +-		if (is_absolute_path(dotgit_contents)) {
     +-			strbuf_addstr(&backlink, dotgit_contents);
     +-		} else {
     +-			strbuf_addbuf(&backlink, &dotgit);
     +-			strbuf_strip_suffix(&backlink, ".git");
     +-			strbuf_addstr(&backlink, dotgit_contents);
     +-			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
     +-		}
     +-	}
     + 	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
     + 	    err == READ_GITFILE_ERR_IS_A_DIR) {
     + 		fn(1, dotgit.buf,
     + 		   _("unable to locate repository; .git is not a file"),
     + 		   cb_data);
       		goto done;
     --	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
     +-	} else if (!err && !is_git_directory(backlink.buf)) {
     +-		strbuf_release(&backlink);
      -		if (inferred_backlink.len) {
      -			/*
      -			 * Worktree's .git file does not point at a repository
     @@ worktree.c: void repair_worktree_at_path(struct repository *repo,
      -			 */
      -			strbuf_swap(&backlink, &inferred_backlink);
      -		} else {
     --			fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
     +-			fn(1, dotgit.buf,
     +-			   _("unable to locate repository; .git file does not reference a repository"),
     +-			   cb_data);
      -			goto done;
      -		}
     --	} else {
     -+	} else if (err) {
     - 		fn(1, dotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
     + 	} else if (err) {
     + 		fn(1, dotgit.buf,
     + 		   _("unable to locate repository; .git file broken"),
     +@@ worktree.c: void repair_worktree_at_path(struct repository *repo,
       		goto done;
       	}
       
      +	dotgit_contents = contents.buf;
     -+	infer_backlink(repo, dotgit_contents, &inferred_backlink);
     ++	infer_backlink(repo, dotgit.buf, &inferred_backlink);
      +	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
      +
      +	if (is_absolute_path(dotgit_contents)) {
     @@ worktree.c: void repair_worktree_at_path(struct repository *repo,
      +	}
      +
      +	if (!is_git_directory(backlink.buf) && !inferred_backlink.len) {
     -+		fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
     ++		fn(1, dotgit.buf,
     ++		   _("unable to locate repository; .git file does not reference a repository"),
     ++		   cb_data);
      +		goto done;
      +	}
      +
     @@ worktree.c: void repair_worktree_at_path(struct repository *repo,
       	 */
       	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf))
       		strbuf_swap(&backlink, &inferred_backlink);
     -@@ worktree.c: void repair_worktree_at_path(struct repository *repo,
     - 					     gitdir.buf, use_relative_paths);
     - 	}
     - done:
     --	free(dotgit_contents);
     - 	strbuf_release(&olddotgit);
     - 	strbuf_release(&backlink);
     - 	strbuf_release(&inferred_backlink);
     - 	strbuf_release(&gitdir);
     - 	strbuf_release(&dotgit);
     -+	strbuf_release(&contents);
     - }
     - 
     - int should_prune_worktree(struct repository *repo,
 -:  ---------- > 3:  2cc7b817ee worktree repair: use read_gitfile_raw() in infer_backlink()
 -:  ---------- > 4:  8c80b9ae05 worktree repair: reduce .git file reads
 2:  99aa34135c ! 5:  015602168c worktree repair: avoid breaking unrelated .git file and gitdir
     @@ worktree.c: static ssize_t infer_backlink(struct repository *repo,
       
       	return inferred->len;
      @@ worktree.c: void repair_worktree_at_path(struct repository *repo,
     - 		fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
     + 		   cb_data);
       		goto done;
       	}
      +	if (!inferred_backlink.len) {
     -+		fn(1, dotgit.buf, _("unable to locate repository; .git file is not for a linked worktree"), cb_data);
     ++		fn(1, dotgit.buf,
     ++		   _("unable to locate repository; .git file is not for a linked worktree"),
     ++		   cb_data);
      +		goto done;
      +	}
       

-- 
gitgitgadget
