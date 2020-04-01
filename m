Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C55BC2D0F4
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4992077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqF1qAhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgDAERz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:17:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41860 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDAERy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so28858461wrc.8
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WKA2GOEL/rNx3KnJWM/AlX+tTsoRLm6jbIS76PeEymo=;
        b=OqF1qAhzPB3l/0/J+vePtA55XKw1cU5KeUVFswr1UPUEUtjknHXmf0ay8fcNlSNxOk
         HcUaWGND4pkzFEXCrVl1Xw00e/9z0jtpZp2zFxWIHTvVKUNAz14VTIZLA70cyMTBjQA3
         kV4LGkDgpOCUHdgMlH8JheDZaGc16V2Od5ErMQquk9aAgKMeZS2zogCajuo8loMGZFVb
         DVa2a3MUy8uFc1o83/WqMo6sU0cLufVSG39RWwKOWQoIGEqb5fw/oT2nS18XdySMfiKY
         QW/HdLNYnkr4hU6+cOErx6TzywhHraWymEvsfxxfRbKA8IwzRsj5Nlc9NsiYzUvLbFGd
         YJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WKA2GOEL/rNx3KnJWM/AlX+tTsoRLm6jbIS76PeEymo=;
        b=XyqOCtVRU39vdXBFfhm5qroQpxQWVIHFPBJbbAajb/5TQ8vJed81uepErUS/TgvrC8
         ATbObiU87glV0e5ZvxlpVFmo4eiM6cv3ohFtgj7llWDfnscJmKaRjXnmvTsjxwGMxknW
         qYiizljftzQ277pyFCGGb6bSJcwjnIHKhaEMHwpnu8+tQLFxQZUga4jW0UnZfznasJVB
         heIkksywtxZK6Gove5UWGD3z/S5vDGiGhSrgzZQoRnhAap2M93gepL1kWNLy87fes1Fa
         ukn4NSzqnw2+AdcabBiNUqnDDShAAvF+xfQT4OgwOHKBfaC224R+A4wT2q8Tb+7JOCS3
         9gqA==
X-Gm-Message-State: ANhLgQ0BSP8OjfE1KH3561Nm4DJPb5JjBgDzSkSWDnQoS/kW4S8EB34/
        LDLkYhqMmYe8zDNdHjXNerCoTZB9
X-Google-Smtp-Source: ADFU+vuIlS1tqqYQL7I03vbSdB0vZFXigL3E3/Jtrelm5OpZ1Hi1mpB8Kby9Dtb5+uERGyroyARyIw==
X-Received: by 2002:adf:ed0a:: with SMTP id a10mr25434156wro.198.1585714668843;
        Tue, 31 Mar 2020 21:17:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a186sm949323wmh.33.2020.03.31.21.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:48 -0700 (PDT)
Message-Id: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:34 +0000
Subject: [PATCH v5 00/12] Avoid multiple recursive calls for same path in read_directory_recursive()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series provides some "modest" speedups (see commit message for patch
8), and should allow 'git status --ignored' to complete in a more reasonable
timeframe for Martin Melka (see 
https://lore.kernel.org/git/CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com/
). It also cleans up the fill_directory() code and API, and fixes
bash-completion for 'git add untracked-dir/'.

Changes since v4:

 * cleanups suggested by Junio (patch 1)
 * new testcases that would have displayed multiple bugs with v4 (patch 2)
 * fixed the bugs with v4 (look for LEADING_PATHSPEC in patch 8)
 * fixed ANOTHER exponential slowdown codepath (look for MODE_MATCHING in
   patch 8)
 * make DIR_KEEP_UNTRACKED_CONTENTS less of a weird one-off (patch 9)
 * reduce number of calls to [do_]match_pathspec() (patch 10)
 * fix error-proneness of fill_directory() API (patch 11)
 * fix bash-completion results for 'git add' on an untracked dir (patch 12)

This is one of those rare patchsets that is absolutely perfect and
risk-free. That's right, bask in their glory and the ease of conscience from
using such solid stuff. Using this series will even innoculate you from bugs
outside of dir.c, and ones external to git, and even bugs external to your
computer. It's just that good. Pay no attention to the man behind the
curtain, er, I mean the huge warnings in patch 8, er...I mean what warnings?
There's no warnings to view, this stuff is solid as can be.

But if an extra pair of eyes wants to look at commit message in patch 8, or
at the new patches (2 and 9-12) and opine on how perfect everything looks
and feels, be my guest.

Derrick Stolee (1):
  dir: refactor treat_directory to clarify control flow

Elijah Newren (11):
  t7063: more thorough status checking
  t3000: add more testcases testing a variety of ls-files issues
  dir: fix simple typo in comment
  dir: consolidate treat_path() and treat_one_path()
  dir: fix broken comment
  dir: fix confusion based on variable tense
  dir: replace exponential algorithm with a linear one
  dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_directory()
  dir: replace double pathspec matching with single in treat_directory()
  Fix error-prone fill_directory() API; make it only return matches
  completion: fix 'git add' on paths under an untracked directory

 builtin/clean.c                        |   6 -
 builtin/grep.c                         |   2 -
 builtin/ls-files.c                     |   5 +-
 builtin/stash.c                        |  17 +-
 contrib/completion/git-completion.bash |   2 +-
 dir.c                                  | 422 +++++++++++++++----------
 t/t3000-ls-files-others.sh             | 121 +++++++
 t/t7063-status-untracked-cache.sh      |  52 +++
 t/t9902-completion.sh                  |   5 +
 wt-status.c                            |   6 +-
 10 files changed, 437 insertions(+), 201 deletions(-)


base-commit: 0cbb60574e741e8255ba457606c4c90898cfc755
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-700%2Fnewren%2Ffill-directory-exponential-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-700/newren/fill-directory-exponential-v5
Pull-Request: https://github.com/git/git/pull/700

Range-diff vs v4:

  1:  752403e339b !  1:  e2704245854 t7063: more thorough status checking
     @@ -11,8 +11,10 @@
          restructuring.
      
          Unfortunately, it's not easy to run status and tell it to ignore the
     -    untracked cache; the only knob we have it to instruct it to *delete*
     -    (and ignore) the untracked cache.
     +    untracked cache; the only knob we have is core.untrackedCache=false,
     +    which is used to instruct git to *delete* the untracked cache (which
     +    might also ignore the untracked cache when it operates, but that isn't
     +    specified in the docs).
      
          Create a simple helper that will create a clone of the index that is
          missing the untracked cache bits, and use it to compare that the results
     @@ -33,9 +35,9 @@
      +#    iuc status --porcelain >expect &&
      +#    git status --porcelain >actual &&
      +#    test_cmp expect actual
     -+iuc() {
     ++iuc () {
      +	git ls-files -s >../current-index-entries
     -+	git ls-files -t | grep ^S | sed -e s/^S.// >../current-sparse-entries
     ++	git ls-files -t | sed -ne s/^S.//p >../current-sparse-entries
      +
      +	GIT_INDEX_FILE=.git/tmp_index
      +	export GIT_INDEX_FILE
  -:  ----------- >  2:  88e9d5d5dbd t3000: add more testcases testing a variety of ls-files issues
  2:  a4287d690be =  3:  38d4d5a46b1 dir: fix simple typo in comment
  3:  48f37e5b114 =  4:  eeb38a25f3a dir: consolidate treat_path() and treat_one_path()
  4:  b5ad1939379 =  5:  6e29f1f6aec dir: fix broken comment
  5:  2603c1a9d13 =  6:  62dae938c8f dir: fix confusion based on variable tense
  6:  576f364329d =  7:  25921cb792e dir: refactor treat_directory to clarify control flow
  7:  e20525429e5 !  8:  b2caa426790 dir: replace exponential algorithm with a linear one
     @@ -187,8 +187,23 @@
       
      -	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
      +	/*
     -+	 * We only need to recurse into untracked/ignored directories if
     -+	 * either of the following bits is set:
     ++	 * If we have a pathspec which could match something _below_ this
     ++	 * directory (e.g. when checking 'subdir/' having a pathspec like
     ++	 * 'subdir/some/deep/path/file' or 'subdir/widget-*.c'), then we
     ++	 * need to recurse.
     ++	 */
     ++	if (pathspec) {
     ++		int ret = do_match_pathspec(istate, pathspec, dirname, len,
     ++					    0 /* prefix */, NULL /* seen */,
     ++					    DO_MATCH_LEADING_PATHSPEC);
     ++		if (ret == MATCHED_RECURSIVELY_LEADING_PATHSPEC)
     ++			return path_recurse;
     ++	}
     ++
     ++	/*
     ++	 * Other than the path_recurse case immediately above, we only need
     ++	 * to recurse into untracked/ignored directories if either of the
     ++	 * following bits is set:
      +	 *   - DIR_SHOW_IGNORED_TOO (because then we need to determine if
      +	 *                           there are ignored directories below)
      +	 *   - DIR_HIDE_EMPTY_DIRECTORIES (because we have to determine if
     @@ -197,6 +212,16 @@
      +	if (!(dir->flags & (DIR_SHOW_IGNORED_TOO | DIR_HIDE_EMPTY_DIRECTORIES)))
       		return excluded ? path_excluded : path_untracked;
       
     ++	/*
     ++	 * ...and even if DIR_SHOW_IGNORED_TOO is set, we can still avoid
     ++	 * recursing into ignored directories if the path is excluded and
     ++	 * DIR_SHOW_IGNORED_TOO_MODE_MATCHING is also set.
     ++	 */
     ++	if (excluded &&
     ++	    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
     ++	    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
     ++		return path_excluded;
     ++
      +	/*
      +	 * If we have we don't want to know the all the paths under an
      +	 * untracked or ignored directory, we still need to go into the
     @@ -241,59 +266,52 @@
      +
      +	/* There are a variety of reasons we may need to fixup the state... */
      +	if (state == path_excluded) {
     -+		int i;
     -+
     -+		/*
     -+		 * When stop_early is set, read_directory_recursive() will
     -+		 * never return path_untracked regardless of whether
     -+		 * underlying paths were untracked or ignored (because
     -+		 * returning early means it excluded some paths, or
     -+		 * something like that -- see commit 5aaa7fd39aaf ("Improve
     -+		 * performance of git status --ignored", 2017-09-18)).
     -+		 * However, we're not really concerned with the status of
     -+		 * files under the directory, we just wanted to know
     -+		 * whether the directory was empty (state == path_none) or
     -+		 * not (state == path_excluded), and if not, we'd return
     -+		 * our original status based on whether the untracked
     -+		 * directory matched an exclusion pattern.
     ++		/* state == path_excluded implies all paths under
     ++		 * dirname were ignored...
     ++		 *
     ++		 * if running e.g. `git status --porcelain --ignored=matching`,
     ++		 * then we want to see the subpaths that are ignored.
     ++		 *
     ++		 * if running e.g. just `git status --porcelain`, then
     ++		 * we just want the directory itself to be listed as ignored
     ++		 * and not the individual paths underneath.
      +		 */
     -+		if (stop_early)
     -+			state = excluded ? path_excluded : path_untracked;
     ++		int want_ignored_subpaths =
     ++			((dir->flags & DIR_SHOW_IGNORED_TOO) &&
     ++			 (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING));
      +
     -+		else {
     ++		if (want_ignored_subpaths) {
      +			/*
     -+			 * When
     -+			 *     !stop_early && state == path_excluded
     -+			 * then all paths under dirname were ignored.  For
     -+			 * this case, git status --porcelain wants to just
     -+			 * list the directory itself as ignored and not
     -+			 * list the individual paths underneath.  Remove
     -+			 * the individual paths underneath.
     ++			 * with --ignored=matching, we want the subpaths
     ++			 * INSTEAD of the directory itself.
      +			 */
     ++			state = path_none;
     ++		} else {
     ++			int i;
      +			for (i = old_ignored_nr + 1; i<dir->ignored_nr; ++i)
     -+				free(dir->ignored[i]);
     ++				FREE_AND_NULL(dir->ignored[i]);
      +			dir->ignored_nr = old_ignored_nr;
      +		}
      +	}
     -+
     -+	/*
     + 
     + 	/*
     +-	 * If this is an excluded directory, then we only need to check if
     +-	 * the directory contains any files.
      +	 * If there is nothing under the current directory and we are not
      +	 * hiding empty directories, then we need to report on the
      +	 * untracked or ignored status of the directory itself.
     -+	 */
     + 	 */
     +-	return read_directory_recursive(dir, istate, dirname, len,
     +-					untracked, 1, excluded, pathspec);
      +	if (state == path_none && !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
      +		state = excluded ? path_excluded : path_untracked;
     - 
     - 	/*
     --	 * If this is an excluded directory, then we only need to check if
     --	 * the directory contains any files.
     ++
     ++	/*
      +	 * We can recurse into untracked directories that don't match any
      +	 * of the given pathspecs when some file underneath the directory
      +	 * might match one of the pathspecs.  If so, we should make sure
      +	 * to note that the directory itself did not match.
     - 	 */
     --	return read_directory_recursive(dir, istate, dirname, len,
     --					untracked, 1, excluded, pathspec);
     ++	 */
      +	if (pathspec &&
      +	    !match_pathspec(istate, pathspec, dirname, len,
      +			    0 /* prefix */, NULL,
     @@ -316,6 +334,47 @@
       	strbuf_setlen(path, baselen);
       	if (!cdir->ucd) {
       		strbuf_addstr(path, cdir->file);
     +@@
     + 				      const struct pathspec *pathspec)
     + {
     + 	int has_path_in_index, dtype, excluded;
     +-	enum path_treatment path_treatment;
     + 
     + 	if (!cdir->d_name)
     + 		return treat_path_fast(dir, untracked, cdir, istate, path,
     +@@
     + 	default:
     + 		return path_none;
     + 	case DT_DIR:
     +-		strbuf_addch(path, '/');
     +-		path_treatment = treat_directory(dir, istate, untracked,
     +-						 path->buf, path->len,
     +-						 baselen, excluded, pathspec);
     + 		/*
     +-		 * If 1) we only want to return directories that
     +-		 * match an exclude pattern and 2) this directory does
     +-		 * not match an exclude pattern but all of its
     +-		 * contents are excluded, then indicate that we should
     +-		 * recurse into this directory (instead of marking the
     +-		 * directory itself as an ignored path).
     ++		 * WARNING: Do not ignore/amend the return value from
     ++		 * treat_directory(), and especially do not change it to return
     ++		 * path_recurse as that can cause exponential slowdown.
     ++		 * Instead, modify treat_directory() to return the right value.
     + 		 */
     +-		if (!excluded &&
     +-		    path_treatment == path_excluded &&
     +-		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
     +-		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
     +-			return path_recurse;
     +-		return path_treatment;
     ++		strbuf_addch(path, '/');
     ++		return treat_directory(dir, istate, untracked,
     ++				       path->buf, path->len,
     ++				       baselen, excluded, pathspec);
     + 	case DT_REG:
     + 	case DT_LNK:
     + 		return excluded ? path_excluded : path_untracked;
      @@
       	int stop_at_first_file, const struct pathspec *pathspec)
       {
  -:  ----------- >  9:  08a10869816 dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in treat_directory()
  -:  ----------- > 10:  cee74871e43 dir: replace double pathspec matching with single in treat_directory()
  -:  ----------- > 11:  61d9c9d758e Fix error-prone fill_directory() API; make it only return matches
  -:  ----------- > 12:  725adf0a9b8 completion: fix 'git add' on paths under an untracked directory

-- 
gitgitgadget
