Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F032D05E
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357164; cv=none; b=ESCqrUIuxyi2wOVm8s+ySEZkkZQ4q7T6SC1GQqxve9l7KLgLudZCcjRKzwA18WS9wZtnvsGnjyNEv1vLN/kYk9eKUGsGkXZ9aQFvQVong4qru47xX6bcKiUnGjM3d2IgkP2GEvCgoV+LYb1WLz4Q+NWFXLOIBmL3CNF2wOtfbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357164; c=relaxed/simple;
	bh=cwiaZL/68lubo2ozqcXgGfgxxL1Pbg6qFRr3GGLvXAI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kgHBPh8i9d/sqjgvl1Zmk8nGd+1z9jr+D074KmHErKxojxv5G+AxW12Lm+DkC+iBx0+D/XfKhempP0d7IoeYEglXjHcopTpJfbVQsTbeeFITLqz3A7RcOAGLEpSqWfFb1BI8pDZN03Hyw5vKCkiC97up40ySM2rm/Gpv7hN3DiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuBsTndJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuBsTndJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDBB1C4CECC;
	Tue,  8 Oct 2024 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728357163;
	bh=cwiaZL/68lubo2ozqcXgGfgxxL1Pbg6qFRr3GGLvXAI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YuBsTndJ/axWYBUrfb60dOYNmgFFEG+eaXoZQMGCEcOtrE3YimXr9RLN4R0snTjXA
	 Xp5LZO9gXky0/DuY+at39gVzPeJwCeFCHr6VPUCowUEkEd8MuykHLxWSlSTuwvJEWx
	 0o6oJSGoZ26j94KnbR8vpGgkzeOuKkkhfxVDCqKuvHL2814hB4zYpTPjDTLETYv6NM
	 6fuRJyx+XvFyBm8DFnSNSEO+Gr0wFypzX9WxVE9ehWVTAlvd+uVAjm7d9rZgo9j2NU
	 8m32Xvf3QnhHOQXaIBxKINHxVUr4n10E+4ElZ4Rayjm8ul6b3xzpgMXX0T3vgbg0aM
	 I6SufdCv7Psdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B165ECED25F;
	Tue,  8 Oct 2024 03:12:43 +0000 (UTC)
From: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>
Subject: [PATCH v3 0/3] Link worktrees with relative paths
Date: Mon, 07 Oct 2024 22:12:29 -0500
Message-Id: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB2jBGcC/zWPUWrDMBBEr2L0XQlJtiPZlJJ7lBBUZV0tVLIrK
 U5LyN27dij7NQvzZubOCmSEwsbmzjKsWHBOJNqXhvng0idwvJBmWupOSWn4rZ4zfLmKK5wXV0P
 h1k6Dn3onjfSMfEuGCX925vuJdMBS5/y7R6x6+/7TDnRSGaGMMtZyxf3lFrBCe1yiiMBOjycuw
 /eVmtUnk0Uoxe3NxuZ1Q8lBt9L0nTqIvtN2IBKt8uWaSsAER1qSK2SRoL5tDT9cAe7nGLGOzap
 FZ4SksMcfJdwzIw4BAAA=
X-Change-ID: 20241007-wt_relative_paths-88f9cf5a070c
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>, Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=25934; i=cdwhite3@pm.me;
 h=from:subject:message-id;
 bh=cwiaZL/68lubo2ozqcXgGfgxxL1Pbg6qFRr3GGLvXAI=;
 b=owGbwMvMwCVmxF73kO8jewrjabUkhnSWxRr3nuey6LD8fmWtO3/ftfc/7awnXuqUM106Yf8f0
 ZnSWbYJHaUsDGJcDLJiiixvtn4vUE99nMH9oXw2zBxWJpAhDFycAjCRunqGP5wbDI+E3lq7uKDk
 zbU9z7c7NfJHqf0+8zX9x6vce+82c+9jZPjj/cv4pH6l+6c/W4JnfmPyvLy6WzTq85+SX/VO0zb
 pzuQBAA==
X-Developer-Key: i=cdwhite3@pm.me; a=openpgp;
 fpr=99981A649E1CA829A335E77493EDE5A0C788BC38
X-Endpoint-Received: by B4 Relay for cdwhite3@pm.me/default with
 auth_id=237
X-Original-From: Caleb White <cdwhite3@pm.me>
Reply-To: cdwhite3@pm.me

Git currently stores absolute paths to both the main repository and
linked worktrees. However, this causes problems when moving repositories
or working in containerized environments where absolute paths differ
between systems. The worktree links break, and users are required to
manually execute `worktree repair` to repair them, leading to workflow
disruptions. Additionally, mapping repositories inside of containerized
environments renders the repository unusable inside the containers, and
this is not repairable as repairing the worktrees inside the containers
will result in them being broken outside the containers.

To address this, this patch series makes Git always write relative paths
when linking worktrees. Relative paths increase the resilience of the
worktree links across various systems and environments, particularly
when the worktrees are self-contained inside the main repository (such
as when using a bare repository with worktrees). This improves
portability, workflow efficiency, and reduces overall breakages.

Although Git now writes relative paths, existing repositories with
absolute paths are still supported. There are no breaking changes
to workflows based on absolute paths, ensuring backward compatibility.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
Changes in v3:
- Squashed patch [3/4] into patch [2/4] to streamline changes.
- Dropped patch [4/4] as it was no longer necessary.
- Rebased onto 20240923075416.54289-1-ericsunshine@charter.net
- Updated `infer_backlink()` to return 1 on success for consistency.
- Swapped the order of `infer_backlink()` arguments for clarity.
- Clear `inferred` if error occurs in `infer_backlink()`.
- Renamed `git_contents` to `dotgit_contents` for clearer semantics.
- Cleaned up `dotgit_contents` logic in `repair_worktree_at_path()`.
- Replaced multiple `xstrfmt/free` calls with a single `strbuf`.
- Added a test case covering a failure noted in a separate patch series.
- Improved commit messages.
- Link to v2: https://lore.kernel.org/r/20241006060017.171788-1-cdwhite3@pm.me
Changes in v2:
- No changes, just a resubmission
- Link to v1: https://lore.kernel.org/git/20241006045847.159937-1-cdwhite3@pm.me/

Range-diff against v2:
1:  735a90355e ! 1:  b5060dba05 worktree: refactor infer_backlink() to use *strbuf
    @@ Metadata
      ## Commit message ##
         worktree: refactor infer_backlink() to use *strbuf
     
    -    This refactors the `infer_backlink` function to return an integer
    -    result and use a pre-allocated `strbuf` for the inferred backlink
    -    path, replacing the previous `char*` return type.
    +    This lays the groundwork for the next patch, which needs the backlink
    +    returned from infer_backlink() as a `strbuf`. It seemed inefficient to
    +    convert from `strbuf` to `char*` and back to `strbuf` again.
     
    -    This lays the groundwork for the next patch, which needs the
    -    resultant backlink as a `strbuf`. There was no need to go from
    -    `strbuf -> char* -> strbuf` again. This change also aligns the
    -    function's signature with other `strbuf`-based functions.
    +    This refactors infer_backlink() to return an integer result and use a
    +    pre-allocated `strbuf` for the inferred backlink path, replacing the
    +    previous `char*` return type and improving efficiency.
     
         Signed-off-by: Caleb White <cdwhite3@pm.me>
     
    @@ worktree.c: static int is_main_worktree_path(const char *path)
       * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
       */
     -static char *infer_backlink(const char *gitfile)
    -+static int infer_backlink(struct strbuf *inferred, const char *gitfile)
    ++static int infer_backlink(const char *gitfile, struct strbuf *inferred)
      {
        struct strbuf actual = STRBUF_INIT;
     -	struct strbuf inferred = STRBUF_INIT;
    @@ worktree.c: static char *infer_backlink(const char *gitfile)
                goto error;
     -	strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id);
     -	if (!is_directory(inferred.buf))
    ++	strbuf_reset(inferred);
     +	strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
     +	if (!is_directory(inferred->buf))
                goto error;
      
        strbuf_release(&actual);
     -	return strbuf_detach(&inferred, NULL);
    -+	return 0;
    ++	return 1;
      
      error:
        strbuf_release(&actual);
     -	strbuf_release(&inferred);
     -	return NULL;
    -+	return 1;
    ++	strbuf_reset(inferred); /* clear invalid path */
    ++	return 0;
      }
      
      /*
    @@ worktree.c: void repair_worktree_at_path(const char *path,
        struct strbuf dotgit = STRBUF_INIT;
        struct strbuf realdotgit = STRBUF_INIT;
     +	struct strbuf backlink = STRBUF_INIT;
    ++	struct strbuf inferred_backlink = STRBUF_INIT;
        struct strbuf gitdir = STRBUF_INIT;
        struct strbuf olddotgit = STRBUF_INIT;
     -	char *backlink = NULL;
    -+	char *git_contents = NULL;
    +-	char *inferred_backlink = NULL;
    ++	char *dotgit_contents = NULL;
        const char *repair = NULL;
        int err;
      
    @@ worktree.c: void repair_worktree_at_path(const char *path,
                goto done;
        }
      
    +-	inferred_backlink = infer_backlink(realdotgit.buf);
     -	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
    -+	git_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
    - 	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
    +-	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
    ++	infer_backlink(realdotgit.buf, &inferred_backlink);
    ++	dotgit_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
    ++	if (dotgit_contents) {
    ++		strbuf_addstr(&backlink, dotgit_contents);
    ++	} else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
                fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
                goto done;
        } else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
    --		if (!(backlink = infer_backlink(realdotgit.buf))) {
    -+		if (infer_backlink(&backlink, realdotgit.buf)) {
    +-		if (inferred_backlink) {
    ++		if (inferred_backlink.len) {
    + 			/*
    + 			 * Worktree's .git file does not point at a repository
    + 			 * but we found a .git/worktrees/<id> in this
    + 			 * repository with the same <id> as recorded in the
    + 			 * worktree's .git file so make the worktree point at
    +-			 * the discovered .git/worktrees/<id>. (Note: backlink
    +-			 * is already NULL, so no need to free it first.)
    ++			 * the discovered .git/worktrees/<id>.
    + 			 */
    +-			backlink = inferred_backlink;
    +-			inferred_backlink = NULL;
    ++			strbuf_swap(&backlink, &inferred_backlink);
    + 		} else {
                        fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
                        goto done;
    - 		}
    - 	} else if (err) {
    - 		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
    - 		goto done;
    -+	} else if (git_contents) {
    -+		strbuf_addstr(&backlink, git_contents);
    +@@ worktree.c: void repair_worktree_at_path(const char *path,
    + 	 * in the "copy" repository. In this case, point the "copy" worktree's
    + 	 * .git file at the "copy" repository.
    + 	 */
    +-	if (inferred_backlink && fspathcmp(backlink, inferred_backlink)) {
    +-		free(backlink);
    +-		backlink = inferred_backlink;
    +-		inferred_backlink = NULL;
    ++	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf)) {
    ++		strbuf_swap(&backlink, &inferred_backlink);
        }
      
     -	strbuf_addf(&gitdir, "%s/gitdir", backlink);
    @@ worktree.c: void repair_worktree_at_path(const char *path,
        }
      done:
     -	free(backlink);
    -+	free(git_contents);
    +-	free(inferred_backlink);
    ++	free(dotgit_contents);
        strbuf_release(&olddotgit);
     +	strbuf_release(&backlink);
    ++	strbuf_release(&inferred_backlink);
        strbuf_release(&gitdir);
        strbuf_release(&realdotgit);
        strbuf_release(&dotgit);
2:  f128dfa53c ! 2:  017f199988 worktree: link worktrees with relative paths
    @@ Metadata
      ## Commit message ##
         worktree: link worktrees with relative paths
     
    -    This modifies Git’s handling of worktree linking to use relative
    -    paths instead of absolute paths. Previously, when creating a worktree,
    -    Git would store the absolute paths to both the main repository and the
    -    linked worktrees. These hardcoded absolute paths cause breakages such
    -    as when the repository is moved to a different directory or during
    -    containerized development where the absolute differs between systems.
    +    Git currently stores absolute paths to both the main repository and
    +    linked worktrees. However, this causes problems when moving repositories
    +    or working in containerized environments where absolute paths differ
    +    between systems. The worktree links break, and users are required to
    +    manually execute `worktree repair` to repair them, leading to workflow
    +    disruptions. Additionally, mapping repositories inside of containerized
    +    environments renders the repository unusable inside the containers, and
    +    this is not repairable as repairing the worktrees inside the containers
    +    will result in them being broken outside the containers.
     
    -    By switching to relative paths, we help ensure that worktree links are
    -    more resilient when the repository is moved. While links external to the
    -    repository may still break, Git still automatically handles many common
    -    scenarios, reducing the need for manual repair. This is particularly
    -    useful in containerized or portable development environments, where the
    -    absolute path to the repository can differ between systems. Developers
    -    no longer need to reinitialize or repair worktrees after relocating the
    -    repository, improving workflow efficiency and reducing breakages.
    +    To address this, this patch makes Git always write relative paths when
    +    linking worktrees. Relative paths increase the resilience of the
    +    worktree links across various systems and environments, particularly
    +    when the worktrees are self-contained inside the main repository (such
    +    as when using a bare repository with worktrees). This improves
    +    portability, workflow efficiency, and reduces overall breakages.
     
    -    For self-contained repositories (such as using a bare repository with
    -    worktrees), where both the repository and its worktrees are located
    -    within the same directory structure, using relative paths guarantees all
    -    links remain functional regardless of where the directory is located.
    +    Although Git now writes relative paths, existing repositories with
    +    absolute paths are still supported. There are no breaking changes
    +    to workflows based on absolute paths, ensuring backward compatibility.
    +
    +    At a low level, the changes involve modifying functions in `worktree.c`
    +    and `builtin/worktree.c` to use `relative_path()` when writing the
    +    worktree’s `.git` file and the main repository’s `gitdir` reference.
    +    Instead of hardcoding absolute paths, Git now computes the relative path
    +    between the worktree and the repository, ensuring that these links are
    +    portable. Locations where these respective file are read have also been
    +    updated to properly handle both absolute and relative paths. Generally,
    +    relative paths are always resolved into absolute paths before any
    +    operations or comparisons are performed.
    +
    +    Additionally, `repair_worktrees_after_gitdir_move()` has been introduced
    +    to address the case where both the `<worktree>/.git` and
    +    `<repo>/worktrees/<id>/gitdir` links are broken after the gitdir is
    +    moved (such as during a re-initialization). This function repairs both
    +    sides of the worktree link using the old gitdir path to reestablish the
    +    correct paths after a move.
    +
    +    The `worktree.path` struct member has also been updated to always store
    +    the absolute path of a worktree. This ensures that worktree consumers
    +    never have to worry about trying to resolve the absolute path themselves.
     
         Signed-off-by: Caleb White <cdwhite3@pm.me>
     
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
     +	strbuf_realpath(&sb_path_realpath, path, 1);
     +	strbuf_realpath(&sb_repo_realpath, sb_repo.buf, 1);
     +	write_file(sb.buf, "%s/.git", relative_path(sb_path_realpath.buf, sb_repo_realpath.buf, &sb_tmp));
    -+	strbuf_reset(&sb_tmp);
     +	write_file(sb_git.buf, "gitdir: %s", relative_path(sb_repo_realpath.buf, sb_path_realpath.buf, &sb_tmp));
        strbuf_reset(&sb);
        strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
        return ret;
      }
     
    + ## setup.c ##
    +@@ setup.c: static void separate_git_dir(const char *git_dir, const char *git_link)
    + 
    + 		if (rename(src, git_dir))
    + 			die_errno(_("unable to move %s to %s"), src, git_dir);
    +-		repair_worktrees(NULL, NULL);
    ++		repair_worktrees_after_gitdir_move(src);
    + 	}
    + 
    + 	write_file(git_link, "gitdir: %s", git_dir);
    +
      ## t/t2408-worktree-relative.sh (new) ##
     @@
     +#!/bin/sh
    @@ worktree.c: int validate_worktree(const struct worktree *wt, struct strbuf *errm
      {
        struct strbuf path = STRBUF_INIT;
     +	struct strbuf repo = STRBUF_INIT;
    ++	struct strbuf file = STRBUF_INIT;
     +	struct strbuf tmp = STRBUF_INIT;
    -+	char *file = NULL;
      
        if (is_main_worktree(wt))
                BUG("can't relocate main worktree");
    @@ worktree.c: int validate_worktree(const struct worktree *wt, struct strbuf *errm
        if (fspathcmp(wt->path, path.buf)) {
     -		write_file(git_common_path("worktrees/%s/gitdir", wt->id),
     -			   "%s/.git", path.buf);
    -+		file = xstrfmt("%s/gitdir", repo.buf);
    -+		write_file(file, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
    -+		free(file);
    -+		strbuf_reset(&tmp);
    -+		file = xstrfmt("%s/.git", path.buf);
    -+		write_file(file, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
    ++		strbuf_addf(&file, "%s/gitdir", repo.buf);
    ++		write_file(file.buf, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
    ++		strbuf_reset(&file);
    ++		strbuf_addf(&file, "%s/.git", path.buf);
    ++		write_file(file.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
     +
                free(wt->path);
                wt->path = strbuf_detach(&path, NULL);
        }
    -+	free(file);
        strbuf_release(&path);
     +	strbuf_release(&repo);
    ++	strbuf_release(&file);
     +	strbuf_release(&tmp);
      }
      
    @@ worktree.c: static void repair_gitfile(struct worktree *wt,
     -	char *backlink;
     +	struct strbuf backlink = STRBUF_INIT;
     +	struct strbuf tmp = STRBUF_INIT;
    -+	char *git_contents = NULL;
    ++	char *dotgit_contents = NULL;
        const char *repair = NULL;
        int err;
      
    @@ worktree.c: static void repair_gitfile(struct worktree *wt,
        strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
        strbuf_addf(&dotgit, "%s/.git", wt->path);
     -	backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
    -+	git_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
    ++	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
     +
    -+	if (git_contents) {
    -+		if (is_absolute_path(git_contents)) {
    -+			strbuf_addstr(&backlink, git_contents);
    ++	if (dotgit_contents) {
    ++		if (is_absolute_path(dotgit_contents)) {
    ++			strbuf_addstr(&backlink, dotgit_contents);
     +		} else {
    -+			strbuf_addf(&backlink, "%s/%s", wt->path, git_contents);
    ++			strbuf_addf(&backlink, "%s/%s", wt->path, dotgit_contents);
     +			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
     +		}
     +	}
    @@ worktree.c: static void repair_gitfile(struct worktree *wt,
      
     -	free(backlink);
     +done:
    -+	free(git_contents);
    ++	free(dotgit_contents);
        strbuf_release(&repo);
        strbuf_release(&dotgit);
     +	strbuf_release(&backlink);
    @@ worktree.c: static void repair_gitfile(struct worktree *wt,
      }
      
      static void repair_noop(int iserr UNUSED,
    +@@ worktree.c: void repair_worktrees(worktree_repair_fn fn, void *cb_data)
    + 	free_worktrees(worktrees);
    + }
    + 
    ++void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path)
    ++{
    ++	struct strbuf path = STRBUF_INIT;
    ++	struct strbuf repo = STRBUF_INIT;
    ++	struct strbuf gitdir = STRBUF_INIT;
    ++	struct strbuf dotgit = STRBUF_INIT;
    ++	struct strbuf olddotgit = STRBUF_INIT;
    ++	struct strbuf tmp = STRBUF_INIT;
    ++
    ++	if (is_main_worktree(wt))
    ++		goto done;
    ++
    ++	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
    ++	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
    ++
    ++	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
    ++		goto done;
    ++
    ++	strbuf_rtrim(&olddotgit);
    ++	if (is_absolute_path(olddotgit.buf)) {
    ++		strbuf_addbuf(&dotgit, &olddotgit);
    ++	} else {
    ++		strbuf_addf(&dotgit, "%s/worktrees/%s/%s", old_path, wt->id, olddotgit.buf);
    ++		strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
    ++	}
    ++
    ++	if (!file_exists(dotgit.buf))
    ++		goto done;
    ++
    ++	strbuf_addbuf(&path, &dotgit);
    ++	strbuf_strip_suffix(&path, "/.git");
    ++
    ++	write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
    ++	write_file(gitdir.buf, "%s", relative_path(dotgit.buf, repo.buf, &tmp));
    ++done:
    ++	strbuf_release(&path);
    ++	strbuf_release(&repo);
    ++	strbuf_release(&gitdir);
    ++	strbuf_release(&dotgit);
    ++	strbuf_release(&olddotgit);
    ++	strbuf_release(&tmp);
    ++}
    ++
    ++void repair_worktrees_after_gitdir_move(const char *old_path)
    ++{
    ++	struct worktree **worktrees = get_worktrees_internal(1);
    ++	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
    ++
    ++	for (; *wt; wt++)
    ++		repair_worktree_after_gitdir_move(*wt, old_path);
    ++	free_worktrees(worktrees);
    ++}
    ++
    + static int is_main_worktree_path(const char *path)
    + {
    + 	struct strbuf target = STRBUF_INIT;
     @@ worktree.c: void repair_worktree_at_path(const char *path,
    - 	struct strbuf backlink = STRBUF_INIT;
    + 	struct strbuf inferred_backlink = STRBUF_INIT;
        struct strbuf gitdir = STRBUF_INIT;
        struct strbuf olddotgit = STRBUF_INIT;
     +	struct strbuf realolddotgit = STRBUF_INIT;
     +	struct strbuf tmp = STRBUF_INIT;
    - 	char *git_contents = NULL;
    + 	char *dotgit_contents = NULL;
        const char *repair = NULL;
        int err;
     @@ worktree.c: void repair_worktree_at_path(const char *path,
    - 		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
    - 		goto done;
    - 	} else if (git_contents) {
    --		strbuf_addstr(&backlink, git_contents);
    -+		if (is_absolute_path(git_contents)) {
    -+			strbuf_addstr(&backlink, git_contents);
    + 	}
    + 
    + 	infer_backlink(realdotgit.buf, &inferred_backlink);
    ++	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
    + 	dotgit_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
    + 	if (dotgit_contents) {
    +-		strbuf_addstr(&backlink, dotgit_contents);
    ++		if (is_absolute_path(dotgit_contents)) {
    ++			strbuf_addstr(&backlink, dotgit_contents);
     +		} else {
     +			strbuf_addbuf(&backlink, &realdotgit);
     +			strbuf_strip_suffix(&backlink, ".git");
    -+			strbuf_addstr(&backlink, git_contents);
    ++			strbuf_addstr(&backlink, dotgit_contents);
    ++			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
     +		}
    + 	} else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
    + 		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
    + 		goto done;
    +@@ worktree.c: void repair_worktree_at_path(const char *path,
    + 			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
    + 			goto done;
    + 		}
    +-	} else if (err) {
    ++	} else {
    + 		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
    + 		goto done;
        }
    - 
    -+	strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
    - 	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
    - 	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
    +@@ worktree.c: void repair_worktree_at_path(const char *path,
                repair = _("gitdir unreadable");
        else {
                strbuf_rtrim(&olddotgit);
    @@ worktree.c: void repair_worktree_at_path(const char *path,
     +		write_file(gitdir.buf, "%s", relative_path(realdotgit.buf, backlink.buf, &tmp));
        }
      done:
    - 	free(git_contents);
    + 	free(dotgit_contents);
        strbuf_release(&olddotgit);
     +	strbuf_release(&realolddotgit);
        strbuf_release(&backlink);
    + 	strbuf_release(&inferred_backlink);
        strbuf_release(&gitdir);
        strbuf_release(&realdotgit);
        strbuf_release(&dotgit);
    @@ worktree.c: void repair_worktree_at_path(const char *path,
     +	struct strbuf dotgit = STRBUF_INIT;
     +	struct strbuf gitdir = STRBUF_INIT;
     +	struct strbuf repo = STRBUF_INIT;
    ++	struct strbuf file = STRBUF_INIT;
     +	char *path = NULL;
    -+	char *file = NULL;
     +	int rc = 0;
        int fd;
        size_t len;
    @@ worktree.c: void repair_worktree_at_path(const char *path,
     -	if (file_exists(git_path("worktrees/%s/locked", id)))
     -		return 0;
     -	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
    -+	file = xstrfmt("%s/locked", repo.buf);
    -+	if (file_exists(file)) {
    ++	strbuf_addf(&file, "%s/locked", repo.buf);
    ++	if (file_exists(file.buf)) {
     +		goto done;
     +	}
     +	if (stat(gitdir.buf, &st)) {
    @@ worktree.c: void repair_worktree_at_path(const char *path,
     +		strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
     +	}
     +	if (!file_exists(dotgit.buf)) {
    -+		free(file);
    -+		file = xstrfmt("%s/index", repo.buf);
    -+		if (stat(file, &st) || st.st_mtime <= expire) {
    ++		strbuf_reset(&file);
    ++		strbuf_addf(&file, "%s/index", repo.buf);
    ++		if (stat(file.buf, &st) || st.st_mtime <= expire) {
                        strbuf_addstr(reason, _("gitdir file points to non-existent location"));
     -			free(path);
     -			return 1;
    @@ worktree.c: void repair_worktree_at_path(const char *path,
     +	*wtpath = strbuf_detach(&dotgit, NULL);
     +done:
     +	free(path);
    -+	free(file);
     +	strbuf_release(&dotgit);
     +	strbuf_release(&gitdir);
     +	strbuf_release(&repo);
    ++	strbuf_release(&file);
     +	return rc;
      }
      
      static int move_config_setting(const char *key, const char *value,
    +
    + ## worktree.h ##
    +@@ worktree.h: typedef void (* worktree_repair_fn)(int iserr, const char *path,
    +  */
    + void repair_worktrees(worktree_repair_fn, void *cb_data);
    + 
    ++/*
    ++ * Repair the linked worktrees after the gitdir has been moved.
    ++ */
    ++void repair_worktrees_after_gitdir_move(const char *old_path);
    ++
    ++/*
    ++ * Repair the linked worktree after the gitdir has been moved.
    ++ */
    ++void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path);
    ++
    + /*
    +  * Repair administrative files corresponding to the worktree at the given path.
    +  * The worktree's .git file pointing at the repository must be intact for the
3:  2347affc96 < -:  ---------- worktree: sync worktree paths after gitdir move
4:  64638e39c3 < -:  ---------- worktree: prevent null pointer dereference
-:  ---------- > 3:  a3ea6625f2 worktree: add test for path handling in linked worktrees

---
Caleb White (3):
      worktree: refactor infer_backlink() to use *strbuf
      worktree: link worktrees with relative paths
      worktree: add test for path handling in linked worktrees

 builtin/worktree.c           |  16 +--
 setup.c                      |   2 +-
 t/t2401-worktree-prune.sh    |  19 ++++
 t/t2408-worktree-relative.sh |  39 +++++++
 worktree.c                   | 253 ++++++++++++++++++++++++++++++++-----------
 worktree.h                   |  10 ++
 6 files changed, 265 insertions(+), 74 deletions(-)
---
base-commit: 4ec4435df758668055cc904ef64c275bc8d1089b
change-id: 20241007-wt_relative_paths-88f9cf5a070c
prerequisite-message-id: <20240923075416.54289-1-ericsunshine@charter.net>
prerequisite-patch-id: 78371f4dbb635e6edab8c51ee7857b903e60df8f

Best regards,
-- 
Caleb White <cdwhite3@pm.me>


