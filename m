Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D632DB7AE
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097075; cv=none; b=gQ20s7QCI+0JCLMLEzhbfav89Q6DCGLdFmKoY5xPrdTwM6ZFeK8ETmdjqUWMUPIXQUaNE0laSLSUljRQ8uPHw3nYzEnZeCvtvy9mKG4Vk2I3SqcKKbvt0sm5NFGKi4Sob5HxlNT0cjgwcjtkyFRlWVC/JIF5VkY5bNkt9CBMCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097075; c=relaxed/simple;
	bh=zjwaoskdiwv2bemt6S4Gbtdi17DYGpgGKUms2NN4lCk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=crg/Fq8OT9HWut3mkbihQCx35i1R5sB4Tt8+Du4fdlW9VqAJaLLw5uuaQ/DAkJNGbPTdKDRyMVbhPU3LeyPpmmGppcwo/Nf6E19ZOvT9tGGaGJG1x9OSPkgpC+robTeZmQPUf4H4lpqzHr021xC/YkzSoqZ6sWP/r6NcF6uKAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns3Jj/pj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns3Jj/pj"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so13795916d6.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785097073; x=1785701873; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4so/CMP77vE3INOH9tQO92ZmQZV0XqGLh1T8sknFllw=;
        b=ns3Jj/pj8sjPzCL8pvn67CfE5Ld1gLF9uCz4ZKJKBe48s8w7LD3CxrkB6/LVFO8VsJ
         wU7HKzrKymPNneegb4NX4RHNg8hx2Qmh29HNrKV3Y5Of4AstdzMqIQc3qrs4s9UT6OUF
         E+kslbH4Pv0KDmAOTHwpCZMjY3yyHIv1+wrabPPq5zSG3Tjx9RPe1lvml9w1lL7yIqfJ
         5anhdiEvsWoj8Xu8bysJ1WWZAvD88DU6x1Jv5UtJuqmz7BrrEieZmZ8QZLkZiOxBdTwD
         vaEDZ0l/2nzV5pQwyrE8UyIU84byvRuB80ZnnOdU/aZWkjq1h82BLcXWuFf+C3htoB7g
         TGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785097073; x=1785701873;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4so/CMP77vE3INOH9tQO92ZmQZV0XqGLh1T8sknFllw=;
        b=msZkQlngBzRhwiQOuhsaoYTgRhZtPrfnAHqj5KAZjngYtCThgqGcS+dAwkAwwGDEL0
         YueaxkXXxE1yqkoTeFGPXwRZ8WDZkGK3yMRGft5B8XWpSy1YDrn04z1eI+bYxcvsByAw
         fR5Vpwq4GSo7Uo91x0UKu5RCI46wIV8oeOZUhOnWnk5yLkLMa1dw4wmtVb0Q3Z6+gk89
         iuTVrfpMzVXH+Ejolp5u6UcXEMcpA8PSG/yrd5WEmS8um4CcHL3zRpLUX9u1bzBf4hd8
         RZPJV0kQxHMkqX77dGWuzokcCZxAokaQou7uRL9TUy5zdk8B6qoQcEh/qZ4CbbvvwRnO
         +BeA==
X-Gm-Message-State: AOJu0Yz4WUYO0zdxboN/vJIoStSF2hrRoeY4wES9JvmhspAJzJM6zGaL
	zfNHJXAPRMVYt33eO9D6G30Xa5cbVAX/UEJwviHrhgQxdgimlXZv0oBISPU06g==
X-Gm-Gg: AR+sD11lB3iiMxN8jFG8HpcC6sP13lilYkTuiUvnjQBuNxVp3aMxVBwNQE5d7woRCUO
	wJ1pAdNkV5EjYIpZSu57l91ewqt+ATD8A3Vm5Up0s6p+LXmpP5uYHM8dR7ZnJq71cbm0Uy6bk01
	btsr3uorXMNWuLpsB0kkL4CCLzn03n9nboLVPX+gJBvozzvQ9ZRqCXa+CzfeZid+8Ed8AwCr53V
	VLrtQtOe4Luf7o61e/RM+W6Lnwec+/v9xV6WSCo7/YaKWh2lsKCO/fiNxyGbl3tUk5u7Xsu2AzQ
	Np1byF7lyNpYsAbqH/1jhC/bcf6xM3J/1x5tsRB7ULpKi/qty/Pnezb3lpAmZacZziSDnql/tm+
	0GpCgLZmpK4osIILVt2iVZf8lbQBeShdthsTTjvi2YwE55b9NQEHkMWpoMnYfs8nfGoG/bTZR35
	W/w6Ax
X-Received: by 2002:a05:6214:e88:b0:8ef:dc74:91ba with SMTP id 6a1803df08f44-907ec729f46mr78635736d6.13.1785097072654;
        Sun, 26 Jul 2026 13:17:52 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e8694125sm48637706d6.31.2026.07.26.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:17:52 -0700 (PDT)
Message-Id: <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
References: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 20:17:49 +0000
Subject: [PATCH v4 0/2] mv: report missing destination leading directory
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Pablo Sabater <pabloosabaterr@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

Changes in v4:

 * reverted to lstat and added has_symlink_leading_path() to refuse a
   destination that goes through a symbolic link, independent of the link
   target, per Junio C Hamano's point that Git tracks symlinks and must not
   follow them here
 * added new "destination is beyond a symbolic link" message
 * added tests: symlink as immediate parent and as intermediate component,
   symlink at the destination, -f does not bypass the symlink refusal, and a
   regression test that a move through a symlink no longer corrupts the
   index (see the reproduction reported on the list)

Changes in v3:

 * added ENOTDIR handling and an S_ISDIR check so a non-directory leading
   path component is caught, as suggested by Junio C Hamano
 * (v3 used stat() to resolve symlinks; this was reverted in v4 after Junio
   pointed out symlinks must not be followed)
 * fixed indentation

Changes in v2:

 * altered the error message to include both source and destination as
   suggested by Ben Knoble

Lucas Zamboni Orioli (2):
  mv: name both source and destination when rename fails
  mv: reject a destination whose leading path is missing or a symlink

 builtin/mv.c  | 37 ++++++++++++++++++++++-
 t/t7001-mv.sh | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 1 deletion(-)


base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2356%2FZamboniL%2Fmv-detect-non-existing-target-folder-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2356/ZamboniL/mv-detect-non-existing-target-folder-v4
Pull-Request: https://github.com/git/git/pull/2356

Range-diff vs v3:

 1:  0d67da588b = 1:  0d67da588b mv: name both source and destination when rename fails
 2:  5ac1587362 ! 2:  6b72efb413 mv: check for missing destination directory before renaming
     @@ Metadata
      Author: Lucas Zamboni Orioli <lucaszam0@gmail.com>
      
       ## Commit message ##
     -    mv: check for missing destination directory before renaming
     +    mv: reject a destination whose leading path is missing or a symlink
      
     -    Moving a file into a directory that does not exist fails at rename(2)
     -    with ENOENT. The checking phase already rejects a missing destination
     -    directory when the destination ends in a slash, but a destination that
     -    names a file inside a non-existent directory is not caught and only
     -    fails later at the syscall. The same is true when a leading path
     -    component exists but is not a directory: rename(2) fails with ENOTDIR,
     -    again only at the syscall. As a consequence "git mv -n" does not detect
     -    either problem: the dry run never reaches rename(2) and reports a move
     -    that would not actually succeed.
     +    Moving a file into a destination whose leading directories are not all
     +    present, real directories is only diagnosed later at rename(2), and for
     +    a symlinked component is not diagnosed at all.
      
     -    Detect this during the checking phase. For entries that will be renamed
     -    on disk, stat the destination's leading directory and fail with a
     -    suitable message if it is missing or is not a directory. stat() is used
     -    rather than lstat() so that the check follows symlinks the same way
     -    rename(2) does: a symlink to a directory is accepted, while a symlink to
     -    a file is rejected. A missing directory or a non-directory path
     -    component (ENOENT or ENOTDIR) reuses the existing "destination directory
     -    does not exist" message; a leading component that resolves to a
     -    non-directory reports "destination is not a directory". Other stat()
     -    errors fall through to rename(2), which reports them as before.
     +    Three cases reach rename(2) unchecked today:
      
     -    Add tests covering the missing directory, a path component that is a
     -    file, a symlink to a file, a symlink to a directory (which must still
     -    succeed), and dry-run detection.
     +      - A leading directory is missing: rename(2) fails with ENOENT,
     +        reported against the source (misleading), and "git mv -n" does not
     +        detect it since the dry run never reaches the syscall.
     +
     +      - A leading component is a non-directory ("git mv x a/b" with 'a' a
     +        file): rename(2) fails with ENOTDIR, again only at the syscall.
     +
     +      - A leading component is a symbolic link: "git mv" follows it. Since
     +        Git tracks symlinks, the destination is really occupied by a
     +        tracked object, and following it is wrong regardless of the link
     +        target. The move is done on disk at the resolved location while the
     +        index records the literal path, leaving the index describing a
     +        worktree that does not exist. A later "git add" can reconcile it,
     +        but "git mv" alone has already corrupted the state.
     +
     +    Detect all three in the checking phase. Reject a destination that goes
     +    through a symlink with has_symlink_leading_path(), which uses lstat()
     +    and never follows the link, so the refusal is independent of the
     +    target. Then lstat() the leading directory: report "destination
     +    directory does not exist" for ENOENT/ENOTDIR and "destination is not a
     +    directory" for a non-directory. Other errors fall through to rename().
     +    Guard the directory check with the same condition under which rename(2)
     +    runs, so directory moves and sparse/out-of-cone destinations are not
     +    flagged incorrectly.
     +
     +    This changes behavior: a move through a tracked symlink that previously
     +    "succeeded" while corrupting the index is now refused. The other two
     +    cases only change when the failure is diagnosed.
      
          Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
      
       ## builtin/mv.c ##
     +@@
     + #include "string-list.h"
     + #include "parse-options.h"
     + #include "read-cache-ll.h"
     ++#include "symlinks.h"
     + 
     + #include "setup.h"
     + #include "strvec.h"
      @@ builtin/mv.c: dir_check:
     + 			bad = _("destination directory does not exist");
       			goto act_on_entry;
       		}
     - 
     ++		if (has_symlink_leading_path(dst, strlen(dst))) {
     ++			bad = _("destination is beyond a symbolic link");
     ++			goto act_on_entry;
     ++		}
     ++
      +		/*
      +		 * If we are going to move SRC to DST on disk, DST's leading
      +		 * directories must already exist.
      +		 */
      +		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
     -+				!(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
     ++		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
      +			char *dst_dir = xstrdup(dst);
      +			char *slash = strrchr(dst_dir, '/');
      +
      +			if (slash) {
      +				struct stat dir_st;
     ++
      +				*slash = '\0';
     -+				if (stat(dst_dir, &dir_st) < 0) {
     -+					/* other errors fall through to rename(), which reports them */
     ++				if (lstat(dst_dir, &dir_st) < 0) {
     ++					/*
     ++					 * other errors fall through to rename(),
     ++					 * which reports them
     ++					 */
      +					if (errno == ENOENT || errno == ENOTDIR)
      +						bad = _("destination directory does not exist");
     -+				} else if (!S_ISDIR(dir_st.st_mode))
     ++				} else if (!S_ISDIR(dir_st.st_mode)) {
      +					bad = _("destination is not a directory");
     ++				}
      +			}
      +			free(dst_dir);
     ++
      +			if (bad)
      +				goto act_on_entry;
      +		}
     -+
     + 
       		if (ignore_sparse &&
       		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
     - 		    index_entry_exists(the_repository->index, dst, strlen(dst))) {
      
       ## t/t7001-mv.sh ##
      @@ t/t7001-mv.sh: test_expect_success 'clean up' '
       	git reset --hard
       '
       
     -+test_expect_success 'moving to a non-existent path component in the destination' '
     ++test_expect_success 'moving to a non-existent directory' '
      +	git reset --hard &&
     -+	mkdir -p from &&
     ++	rm -rf from && mkdir from &&
      +	echo content >from/file &&
      +	git add from/file &&
      +	test_must_fail git mv from/file no-such-dir/file 2>actual &&
      +	test_grep "destination directory does not exist" actual
      +'
      +
     -+test_expect_success 'moving to a destination with a file as a path component' '
     ++test_expect_success 'moving to a destination with a file as a leading path component' '
      +	git reset --hard &&
     -+	mkdir -p from &&
     ++	rm -rf from && mkdir from &&
      +	echo contents >from/file &&
      +	echo blocker >not-dir &&
      +	git add from/file &&
     @@ t/t7001-mv.sh: test_expect_success 'clean up' '
      +	test_grep "destination is not a directory" actual
      +'
      +
     -+test_expect_success SYMLINKS 'moving to a destination with a symlink to a file as a path component' '
     ++test_expect_success SYMLINKS 'moving to a destination beyond a symlink' '
      +	git reset --hard &&
     -+	mkdir -p from &&
     ++	rm -rf from regular-dir link-to-dir &&
     ++	mkdir from regular-dir &&
      +	echo contents >from/file &&
     -+	echo target >regular &&
     -+	ln -s regular link-to-file &&
     ++	ln -s regular-dir link-to-dir &&
      +	git add from/file &&
     -+	test_must_fail git mv from/file link-to-file/file 2>actual &&
     -+	test_grep "not a directory" actual
     ++	test_must_fail git mv from/file link-to-dir/file 2>actual &&
     ++	test_grep "destination is beyond a symbolic link" actual
      +'
      +
     -+test_expect_success SYMLINKS 'moving to a destination with a symlink to a directory' '
     ++test_expect_success SYMLINKS 'moving to a destination with a symlink as an intermediate component' '
      +	git reset --hard &&
     -+	mkdir -p from realdir &&
     ++	rm -rf from && mkdir -p from/real/inner &&
      +	echo contents >from/file &&
     -+	ln -s realdir link-to-dir &&
     -+	git add from/file &&
     -+	git mv from/file link-to-dir/file &&
     -+	test_path_is_file realdir/file
     ++	ln -s real from/link &&
     ++	git add from/file from/link &&
     ++	test_must_fail git mv from/file from/link/inner/dst 2>actual &&
     ++	test_grep "destination is beyond a symbolic link" actual
     ++'
     ++
     ++test_expect_success SYMLINKS 'refuses to overwrite a symlink at the destination' '
     ++	git reset --hard &&
     ++	rm -rf from && mkdir from &&
     ++	echo contents >from/file &&
     ++	ln -s target from/link &&
     ++	git add from/file from/link &&
     ++	test_must_fail git mv from/file from/link 2>actual &&
     ++	test_grep "destination exists" actual
     ++'
     ++
     ++test_expect_success SYMLINKS 'mv through a symlinked leading path does not touch the index' '
     ++	git reset --hard &&
     ++	rm -rf from && mkdir from &&
     ++	echo contents >from/src &&
     ++	ln -s . from/link &&
     ++	git add from/src from/link &&
     ++	git commit -m "setup symlink case" &&
     ++	git ls-files --stage >expect.index &&
     ++	test_must_fail git mv from/src from/link/real/dst 2>actual &&
     ++	test_grep "destination is beyond a symbolic link" actual &&
     ++	git ls-files --stage >actual.index &&
     ++	test_cmp expect.index actual.index
     ++'
     ++
     ++test_expect_success SYMLINKS 'mv -f does not follow a symlinked leading path' '
     ++	git reset --hard &&
     ++	rm -rf from && mkdir from &&
     ++	echo contents >from/src &&
     ++	ln -s file from/link &&
     ++	git add from/src from/link &&
     ++	test_must_fail git mv -f from/src from/link/dst 2>actual &&
     ++	test_grep "destination is beyond a symbolic link" actual
      +'
      +
      +test_expect_success 'mv --dry-run detects non-existent destination parent directory' '
      +	git reset --hard &&
     -+	mkdir -p from &&
     -+	echo content >from/file &&
     ++	rm -rf from && mkdir from &&
     ++	echo contents >from/file &&
      +	git add from/file &&
      +	test_must_fail git mv -n from/file no-such-dir/file 2>actual &&
      +	test_grep "destination directory does not exist" actual

-- 
gitgitgadget
