Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD929BDBB
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301485; cv=none; b=PZNP3Y91X2OdRARVsIceiiU8JwziQPnUTxReOMWTQiFfASGFGRVNpZO3qTdUyclsq7iiWI2xFLcRK2CwaQ69SKow/TdXg9C6TZ324mj4hg736WlcddXFZ43YxEj/xHAotk2/mkE+d4xkR9X5bWIpqsd+huENQlVwE6ei3BSmj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301485; c=relaxed/simple;
	bh=gXUE54nswX6l3ZAy+TYDyTin4bXOLhU6gkbRPT3ewqw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gzCNi6TJuqyJoqydoXWtkYicN6QjkJIp9goy01o1+pK3fipIPso5WOAfz45wVzda+ktxCbIK7+E2i4ZOfY88MIgkrDtno/UiTvjxHYVKe9Q0On620D/TJqs0if8gn8VzxNMU4oykhpiZxbUSSLY0r8qnWbro5KEGTl4MIKKrJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WisFE0eD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WisFE0eD"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso349150a12.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 15:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788301483; x=1788906283; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9oWVCbPwvQK7dk+bxS/VaBM/UFOCqUXz8ISod0dLSto=;
        b=WisFE0eDDHGxToqeMF5kRK7o5P7ZvVUXD4kNZHhKV93C70e/nAkf+HIp29QOhKWHPk
         1+NyLUX5axts+fVzqBxuUY94PrL74P10ry1V408RTEgBfKwQSl0SAIeNGOAqwW0ZcNOg
         ZJEP5jOxzu9HY4XXVov/+YXxLb29XdKzwr9zzpj9xpmHLOGYQFCl2PQGH6fCIxGYFl9o
         Mjrq/xGHdDlDGBXTK5GtILXvJCyw/aPcPv9QfExjE6bQnTAj6NpUsQbZHegvKCbmNxHy
         Zz5ioRst8lMKmivtJJUxhVk6hI8Uc+NDiywYgQevAPB/T/eD3u4EN9D8pd6wGeMto+wz
         bc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788301483; x=1788906283;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9oWVCbPwvQK7dk+bxS/VaBM/UFOCqUXz8ISod0dLSto=;
        b=YsZVGpeB6VBDFnt2k8KmjT1ymZs1CfumpXOu6PeZoyJa7ZkBKETGkxnbZMydQfRlMF
         uiHnWnbNb2Hyk0pGs4rV7y1sm+gnYGDMrpIMQT/El0dpsYwGXytcebnwnHWGb05X3N1U
         jXacaZPR0deNKVjMLCJaaaraNzik5M3NGJELl7txcHPAeBmKrYncuXB9l3nujjKHXUxB
         5S9IQey6mfEIJENOpJAKobV0aDbV78ir3xjoZe5ENyNS0VsjkXlNDqpVivfWhwcgxu+x
         HW3t1T5ksnikvkRnVCnzJZuPp9y8pJsjpAvE3fTa6VS3TnvY1ico3fTyfZunZzzk31wU
         z0Wg==
X-Gm-Message-State: AFuF++lsfJgew4xRuzSqCxLAb8AEry6WWXWv/GwLy0ZjdgqUXWSX+IJU
	vmw65BlsY2CtZKOhkqElURxhJRF35hEN2FN2N6FjXWIvFHNKKE+BYOT4qWO3vA==
X-Gm-Gg: AYBFou2IHlkkK6v7OmEvftKLYjnf5KRZcDeKun34+Uta3yRA+0fn0waPi+CnLBlhZ+x
	HBrVuOzu9krzSdxPtOC77duIjqBFnu0zV7rL7oP5xG5MU7qmcwYVjRbQ2qXe9eqWEOk6UDiV9ra
	gLNqlxl+ny30fC+JvbQ95m475hpxiPf/JdkoNnBlMp5mFNTr+vPNXjbowt3I6+9CYCEssLGIdaW
	McflTppHnulfr3pGDP549x/6h5diWtCdmsYh1M5hMP8vKqFrXXiCJr9WPzDy9/Yhu1PVj369aVI
	k4d3UfDEgE439EICeEb9NUIkS75Dao/ndbtTF1sI6TQMjbPGJdLCO9U8FunmwZGwFvm/1iUffQQ
	D/U1DpugrB4aTLWlI3e3GvKKKD74PWCeAumdqUGfnX/w4zvvZY2DgzBoUSNMGkgwKO+eVoKO+eP
	F81HHMKXem/H635qns1nCeln+m2o2IPorhdNt9x/fKBHrtJ+J87Q3dutB33bdy
X-Received: by 2002:a17:90b:5606:b0:398:9be6:f996 with SMTP id 98e67ed59e1d1-39aee1115e0mr208998a91.21.1788301483171;
        Tue, 01 Sep 2026 15:24:43 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f1a82sm1140832eec.10.2026.09.01.15.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:24:42 -0700 (PDT)
Message-Id: <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 22:24:36 +0000
Subject: [PATCH v4 0/5] commit: refuse to amend during conflict resolution
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v3:

 * Just a clarifying rename, but applied in 3 places:
   * FROM_REBASE_EMPTY -> FROM_REBASE_NOW_EMPTY
   * is_from_rebase_empty() -> is_from_rebase_now_empty()
   * ONGOING_REBASE_EMPTY -> ONGOING_REBASE_NOW_EMPTY

Changes since v2:

 * Two new preparatory patches:
   * Rename FROM_REBASE_PICK and is_from_rebase() to point out they are
     about empty commits
   * Allow a partial commit when a rebase pick becomes empty
 * Tweaked the error message for attempted amend on now-dropped empty commit
   (suggestions for further improvements welcome)
 * Used the path accessor functions within sequencer.c to simplify the new
   helper function

Both git commit --amend and a partial commit (git commit <paths>) are
foot-guns while the user is in the middle of an operation that resolves
conflicts on top of HEAD: recording a conflict resolution is about capturing
the state of the whole tree as a new commit, not about rewriting HEAD or
committing a subset of paths.

Historically we only rejected these during a merge or a cherry-pick or when
resolving an empty pick during a rebase. The same hazard exists for am,
revert, and rebase conflict stops, none of which were covered. This series
extends the refusal to all of them.

The three patches:

 1. reword the two pre-existing "empty commit" rebase messages, which were
    misleadingly generic
 2. refuse git commit --amend during these additional operations
 3. refuse partial commits during the same operations.

Elijah Newren (5):
  commit: clarify FROM_REBASE_PICK and is_from_rebase() names
  commit: allow a partial commit when a rebase pick becomes empty
  commit: reword the empty-commit rebase amend error
  commit: refuse to amend during conflict resolution
  commit: refuse partial commits during conflict resolution

 builtin/commit.c                |  65 +++++++++++-----
 sequencer.c                     |  59 ++++++++++++++-
 sequencer.h                     |  24 ++++++
 t/t3404-rebase-interactive.sh   | 128 +++++++++++++++++++++++++++++++-
 t/t3507-cherry-pick-conflict.sh |  22 ++++++
 t/t4151-am-abort.sh             |  22 ++++++
 wt-status.h                     |   6 +-
 7 files changed, 299 insertions(+), 27 deletions(-)


base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2389%2Fnewren%2Frefuse-amend-during-conflicts-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2389/newren/refuse-amend-during-conflicts-v4
Pull-Request: https://github.com/git/git/pull/2389

Range-diff vs v3:

 1:  7e198a20fa ! 1:  bd361679b9 commit: clarify FROM_REBASE_PICK and is_from_rebase() names
     @@ Commit message
          specifically about hitting a commit that becomes empty when rebasing.
          Clarify their names now.
      
     -    While at it, change `whence == FROM_REBASE_EMPTY` to use
     -    `is_from_rebase_empty(whence)`.
     +    While at it, change `whence == FROM_REBASE_NOW_EMPTY` to use
     +    `is_from_rebase_now_empty(whence)`.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
       		else if (is_from_cherry_pick(whence))
       			die(_("cannot do a partial commit during a cherry-pick."));
      -		else if (is_from_rebase(whence))
     -+		else if (is_from_rebase_empty(whence))
     ++		else if (is_from_rebase_now_empty(whence))
       			die(_("cannot do a partial commit during a rebase."));
       	}
       
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       	else if (whence == FROM_MERGE)
       		hook_arg1 = "merge";
      -	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) {
     -+	else if (is_from_cherry_pick(whence) || is_from_rebase_empty(whence)) {
     ++	else if (is_from_cherry_pick(whence) || is_from_rebase_now_empty(whence)) {
       		hook_arg1 = "commit";
       		hook_arg2 = "CHERRY_PICK_HEAD";
       	}
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       			fputs(_(empty_amend_advice), stderr);
       		else if (is_from_cherry_pick(whence) ||
      -			 whence == FROM_REBASE_PICK) {
     -+			 is_from_rebase_empty(whence)) {
     ++			 is_from_rebase_now_empty(whence)) {
       			fputs(_(empty_cherry_pick_advice), stderr);
       			if (whence == FROM_CHERRY_PICK_SINGLE)
       				fputs(_(empty_cherry_pick_advice_single), stderr);
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
       		else if (is_from_cherry_pick(whence))
       			die(_("You are in the middle of a cherry-pick -- cannot amend."));
      -		else if (whence == FROM_REBASE_PICK)
     -+		else if (is_from_rebase_empty(whence))
     ++		else if (is_from_rebase_now_empty(whence))
       			die(_("You are in the middle of a rebase -- cannot amend."));
       	}
       	if (fixup_message && squash_message)
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
       		use_message = "HEAD";
       	if (!use_message && !is_from_cherry_pick(whence) &&
      -	    !is_from_rebase(whence) && renew_authorship)
     -+	    !is_from_rebase_empty(whence) && renew_authorship)
     ++	    !is_from_rebase_now_empty(whence) && renew_authorship)
       		die(_("--reset-author can be used only with -C, -c or --amend."));
       	if (use_message) {
       		use_message_buffer = read_commit_message(use_message);
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
       		}
       	}
      -	if ((is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) &&
     -+	if ((is_from_cherry_pick(whence) || is_from_rebase_empty(whence)) &&
     ++	if ((is_from_cherry_pick(whence) || is_from_rebase_now_empty(whence)) &&
       	    !renew_authorship) {
       		author_message = "CHERRY_PICK_HEAD";
       		author_message_buffer = read_commit_message(author_message);
     @@ builtin/commit.c: int cmd_commit(int argc,
       			reflog_msg = is_from_cherry_pick(whence)
       					? "commit (cherry-pick)"
      -					: is_from_rebase(whence)
     -+					: is_from_rebase_empty(whence)
     ++					: is_from_rebase_now_empty(whence)
       					? "commit (rebase)"
       					: "commit";
       		commit_list_insert(current_head, &parents);
     @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_wh
       		    !repo_get_oid(r, "CHERRY_PICK_HEAD", &cherry_pick_head) &&
       		    oideq(&rebase_head, &cherry_pick_head))
      -			*whence = FROM_REBASE_PICK;
     -+			*whence = FROM_REBASE_EMPTY;
     ++			*whence = FROM_REBASE_NOW_EMPTY;
       		else
       			*whence = FROM_CHERRY_PICK_SINGLE;
       
     @@ wt-status.h: enum commit_whence {
       	FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
       	FROM_CHERRY_PICK_MULTI, /* commit came from a sequence of cherry-picks */
      -	FROM_REBASE_PICK /* commit came from a pick/reword/edit */
     -+	FROM_REBASE_EMPTY /* rebase applied a pick that became empty */
     ++	FROM_REBASE_NOW_EMPTY /* rebase applied a pick that became empty */
       };
       
       static inline int is_from_cherry_pick(enum commit_whence whence)
     @@ wt-status.h: static inline int is_from_cherry_pick(enum commit_whence whence)
       }
       
      -static inline int is_from_rebase(enum commit_whence whence)
     -+static inline int is_from_rebase_empty(enum commit_whence whence)
     ++static inline int is_from_rebase_now_empty(enum commit_whence whence)
       {
      -	return whence == FROM_REBASE_PICK;
     -+	return whence == FROM_REBASE_EMPTY;
     ++	return whence == FROM_REBASE_NOW_EMPTY;
       }
       
       struct wt_status_change_data {
 2:  e169303619 ! 2:  a0b9900437 commit: allow a partial commit when a rebase pick becomes empty
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
       			die(_("cannot do a partial commit during a merge."));
       		else if (is_from_cherry_pick(whence))
       			die(_("cannot do a partial commit during a cherry-pick."));
     --		else if (is_from_rebase_empty(whence))
     +-		else if (is_from_rebase_now_empty(whence))
      -			die(_("cannot do a partial commit during a rebase."));
       	}
       
 3:  0850a999da ! 3:  c4511a9887 commit: reword the empty-commit rebase amend error
     @@ builtin/commit.c
      @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
       		else if (is_from_cherry_pick(whence))
       			die(_("You are in the middle of a cherry-pick -- cannot amend."));
     - 		else if (is_from_rebase_empty(whence))
     + 		else if (is_from_rebase_now_empty(whence))
      -			die(_("You are in the middle of a rebase -- cannot amend."));
      +			die(_("The now-empty commit has been dropped -- cannot amend."));
       	}
 4:  9f80d8a00d ! 4:  e77b34c1cf commit: refuse to amend during conflict resolution
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
      -		else if (is_from_cherry_pick(whence))
      +		case ONGOING_CHERRY_PICK:
       			die(_("You are in the middle of a cherry-pick -- cannot amend."));
     --		else if (is_from_rebase_empty(whence))
     -+		case ONGOING_REBASE_EMPTY:
     +-		else if (is_from_rebase_now_empty(whence))
     ++		case ONGOING_REBASE_NOW_EMPTY:
       			die(_("The now-empty commit has been dropped -- cannot amend."));
      +		case ONGOING_REVERT:
      +			die(_("You are in the middle of a revert -- cannot amend."));
     @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_wh
      +	case FROM_CHERRY_PICK_SINGLE:
      +	case FROM_CHERRY_PICK_MULTI:
      +		return ONGOING_CHERRY_PICK;
     -+	case FROM_REBASE_EMPTY:
     -+		return ONGOING_REBASE_EMPTY;
     ++	case FROM_REBASE_NOW_EMPTY:
     ++		return ONGOING_REBASE_NOW_EMPTY;
      +	case FROM_COMMIT:
      +		break;
      +	}
     @@ sequencer.h: int sequencer_get_last_command(struct repository* r,
      +	ONGOING_NONE = 0,
      +	ONGOING_MERGE,
      +	ONGOING_CHERRY_PICK,
     -+	ONGOING_REBASE_EMPTY,
     ++	ONGOING_REBASE_NOW_EMPTY,
      +	ONGOING_REVERT,
      +	ONGOING_AM,
      +	ONGOING_REBASE_CONFLICT
 5:  050b9e8a52 ! 5:  b93b26ed9f commit: refuse partial commits during conflict resolution
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
      +		die(_("cannot do a partial commit during a merge."));
      +	case ONGOING_CHERRY_PICK:
      +		die(_("cannot do a partial commit during a cherry-pick."));
     -+	case ONGOING_REBASE_EMPTY:
     ++	case ONGOING_REBASE_NOW_EMPTY:
      +		/*
      +		 * A pick that became empty is not a conflict, and creating
      +		 * a new commit (partial or not) poses no problem.

-- 
gitgitgadget
