Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DC366042
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363704; cv=none; b=t20yD7aXWuwTrvVUXvGOSm/JPHIPDW6zQ90BNPbup3z6zGlxFASh7xAHbHSH4otW6LDXXqUfGgonXPz0pabeE3QOnwDQ6kQyVoX+SUYPETfzNu0A4nTyZbkp30ebRs4PRhNOxoCN3qtDJ1FEejJCAbQf2L+os8K4uLdlmKBRsLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363704; c=relaxed/simple;
	bh=jSHXNuwXF+yqzfkxUx2LOrT2IE8bT7/vCks8VbOpIfA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J1bbEN7cvQcw2ZXVibn9zV2N4fVAx3YQB6HEdba81Z0rw4boLlUyAbgxabLBdAo5R902JFUiy/onWNUGC5iGHbO3ed8pgdy8hnroXpOtDNmp85lH7XBO1K1RPXiswrnobGupTiOgzlK+wfXzi8UnPLfZYpby94T3MTK8Hkoa/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+qrBqil; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+qrBqil"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a6108734d5so2041876a12.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363698; x=1788968498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/uR+LA9A4E0pfAzI2T61F2sfilbGcpPprMSdGJRffFQ=;
        b=W+qrBqilnSiLMD/SeGhVAGvR/n8R4Pw7BMIQsq7lmF0aHaaXzrl7rakiCGbPTWvnDE
         a/ebXfMOgbhTb7F+XVSmA/1LHNk7yohELCKGVoD/H/y7yGkO+Lj6UnltUVmiJeqD/5LO
         RXwVJ/d63UGUCw2QfyNMeaaimTnuZ1kGnB4g0CI64V+l84hGaSE+ns18SfyHoEPNOLuq
         fILSUfFhSXCKbihPLRxO8477s6aQ+bMqefvkg6lqfLD+G9KvoDNTtBq/vcHGeNRSFo/U
         L76d937gO4Tutect74IOIO6xlUgSXP8yDwXS6GQBBiujRICJ0UlJviRApJZ74Wx8Juds
         Zgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363698; x=1788968498;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uR+LA9A4E0pfAzI2T61F2sfilbGcpPprMSdGJRffFQ=;
        b=ed76Or5nl159Dh71wWxDRwoQxQkifbNujiXewnCjZrl3avNRjlNNnde/EDIgP64v6k
         71jDDysHyk3MH0sxEld7qn8csGX1dUKYD9eISLXuyTXfokKqzWDb4kbLWVdY2PpvMA/f
         VXv87pb6IaTVGFe5olyeweqm0EkbX/1AVk3p0xd6M6Lt8JlGPiBIDdHbr5KST0X9ltxZ
         +hbEohUvJ+WrDeJ1zdqaGlpDzWmQELve+ywhMVuSmrBEfKHoilScuB7Be8ryvDPc47uG
         4ObVtqOSgzl3H8LgM9BDSmr6E7wnUApgDoj7mOXJunuNeNmw41ZjdOBbIEq33IiRYEEg
         DOdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKuR363Z1vxiNQF9Lc4qH+flvTNi4uSmPyRdldlHljwY/auYbaDAwXsaruV0YGnwd0sxg=@vger.kernel.org
X-Gm-Message-State: AFuF++lIT4cbmENiWHNqyY1H6S2/o6ZE5uikRPGFP2rLJvnIsWjOcNpd
	e6Xthx0ANe6pnLVZtudO8Ugaf1MeMT8O8hfd6tpot0WYzT6JEwsjFtq/0kGcSA==
X-Gm-Gg: AYBFou2Ezxnlk8YpIfH1lj6axHsIt0BCPHTyXZUtPvn1sN/hUqngoFng6lHBUNDz2jk
	yCLP2YUN3rivecdCURmT6yIpuMa4vOX3XEP3itP4NXJOHXVPyFIUWReCyCgsL+FseSoy+7pQfD2
	wSTM2994NLecP2qbHc3oQxsHHkTLPjUrnhZfvys4fW9K8xh8kH68yAyL9VcCFvyd4IM5EQ1+re5
	FGE31lWokV/8xeFllNQmL4BbR1aIf2x+dbQkf3+W3fSfJCmrOw3QgfI4h9iX/eOjfkP3QI/3aPy
	rT1+QJS7nszd8hYUHzdkj6juZNVOSEO699vjk9CZ3DnmlnaP6jhQ9FlBwpe6k0xc2FuSSZ6eCQO
	kK5Me5FZ/BWnZAAROhvQ65V1Wydnk462aU6+nhT2H9aQjkpndrZXob4oDOBqPNcZQxDIm33lcUx
	tkvGFboCRR4jAqx1Ng9bR8rjo+d4XJRMmFx53DlR9T9BVxiDbODJWs7O1jeh8d8P8JOhUzWUz8h
	afNihAYFsKaHwy25OVkIS5VpmRDFKuQ3Yy5LSWUvrq8iGSzeuOS8g==
X-Received: by 2002:a17:906:99d4:b0:c25:58e:83ff with SMTP id a640c23a62f3a-c25d52b4f8cmr366446866b.10.1788363697561;
        Wed, 02 Sep 2026 08:41:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d03fa17dsm162909166b.48.2026.09.02.08.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:41:37 -0700 (PDT)
Message-ID: <03b9f094-c969-4309-b2cc-f7cd01959d49@gmail.com>
Date: Wed, 2 Sep 2026 16:41:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/5] commit: refuse to amend during conflict resolution
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

The changes from v2 look good, I've got mixed feelings about the new 
patch 2 but I'm happy with everything else. Thanks for working on it

Phillip


On 01/09/2026 23:24, Elijah Newren via GitGitGadget wrote:
> Changes since v3:
> 
>   * Just a clarifying rename, but applied in 3 places:
>     * FROM_REBASE_EMPTY -> FROM_REBASE_NOW_EMPTY
>     * is_from_rebase_empty() -> is_from_rebase_now_empty()
>     * ONGOING_REBASE_EMPTY -> ONGOING_REBASE_NOW_EMPTY
> 
> Changes since v2:
> 
>   * Two new preparatory patches:
>     * Rename FROM_REBASE_PICK and is_from_rebase() to point out they are
>       about empty commits
>     * Allow a partial commit when a rebase pick becomes empty
>   * Tweaked the error message for attempted amend on now-dropped empty commit
>     (suggestions for further improvements welcome)
>   * Used the path accessor functions within sequencer.c to simplify the new
>     helper function
> 
> Both git commit --amend and a partial commit (git commit <paths>) are
> foot-guns while the user is in the middle of an operation that resolves
> conflicts on top of HEAD: recording a conflict resolution is about capturing
> the state of the whole tree as a new commit, not about rewriting HEAD or
> committing a subset of paths.
> 
> Historically we only rejected these during a merge or a cherry-pick or when
> resolving an empty pick during a rebase. The same hazard exists for am,
> revert, and rebase conflict stops, none of which were covered. This series
> extends the refusal to all of them.
> 
> The three patches:
> 
>   1. reword the two pre-existing "empty commit" rebase messages, which were
>      misleadingly generic
>   2. refuse git commit --amend during these additional operations
>   3. refuse partial commits during the same operations.
> 
> Elijah Newren (5):
>    commit: clarify FROM_REBASE_PICK and is_from_rebase() names
>    commit: allow a partial commit when a rebase pick becomes empty
>    commit: reword the empty-commit rebase amend error
>    commit: refuse to amend during conflict resolution
>    commit: refuse partial commits during conflict resolution
> 
>   builtin/commit.c                |  65 +++++++++++-----
>   sequencer.c                     |  59 ++++++++++++++-
>   sequencer.h                     |  24 ++++++
>   t/t3404-rebase-interactive.sh   | 128 +++++++++++++++++++++++++++++++-
>   t/t3507-cherry-pick-conflict.sh |  22 ++++++
>   t/t4151-am-abort.sh             |  22 ++++++
>   wt-status.h                     |   6 +-
>   7 files changed, 299 insertions(+), 27 deletions(-)
> 
> 
> base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2389%2Fnewren%2Frefuse-amend-during-conflicts-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2389/newren/refuse-amend-during-conflicts-v4
> Pull-Request: https://github.com/git/git/pull/2389
> 
> Range-diff vs v3:
> 
>   1:  7e198a20fa ! 1:  bd361679b9 commit: clarify FROM_REBASE_PICK and is_from_rebase() names
>       @@ Commit message
>            specifically about hitting a commit that becomes empty when rebasing.
>            Clarify their names now.
>        
>       -    While at it, change `whence == FROM_REBASE_EMPTY` to use
>       -    `is_from_rebase_empty(whence)`.
>       +    While at it, change `whence == FROM_REBASE_NOW_EMPTY` to use
>       +    `is_from_rebase_now_empty(whence)`.
>        
>            Signed-off-by: Elijah Newren <newren@gmail.com>
>        
>       @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
>         		else if (is_from_cherry_pick(whence))
>         			die(_("cannot do a partial commit during a cherry-pick."));
>        -		else if (is_from_rebase(whence))
>       -+		else if (is_from_rebase_empty(whence))
>       ++		else if (is_from_rebase_now_empty(whence))
>         			die(_("cannot do a partial commit during a rebase."));
>         	}
>         
>       @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
>         	else if (whence == FROM_MERGE)
>         		hook_arg1 = "merge";
>        -	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) {
>       -+	else if (is_from_cherry_pick(whence) || is_from_rebase_empty(whence)) {
>       ++	else if (is_from_cherry_pick(whence) || is_from_rebase_now_empty(whence)) {
>         		hook_arg1 = "commit";
>         		hook_arg2 = "CHERRY_PICK_HEAD";
>         	}
>       @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
>         			fputs(_(empty_amend_advice), stderr);
>         		else if (is_from_cherry_pick(whence) ||
>        -			 whence == FROM_REBASE_PICK) {
>       -+			 is_from_rebase_empty(whence)) {
>       ++			 is_from_rebase_now_empty(whence)) {
>         			fputs(_(empty_cherry_pick_advice), stderr);
>         			if (whence == FROM_CHERRY_PICK_SINGLE)
>         				fputs(_(empty_cherry_pick_advice_single), stderr);
>       @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
>         		else if (is_from_cherry_pick(whence))
>         			die(_("You are in the middle of a cherry-pick -- cannot amend."));
>        -		else if (whence == FROM_REBASE_PICK)
>       -+		else if (is_from_rebase_empty(whence))
>       ++		else if (is_from_rebase_now_empty(whence))
>         			die(_("You are in the middle of a rebase -- cannot amend."));
>         	}
>         	if (fixup_message && squash_message)
>       @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
>         		use_message = "HEAD";
>         	if (!use_message && !is_from_cherry_pick(whence) &&
>        -	    !is_from_rebase(whence) && renew_authorship)
>       -+	    !is_from_rebase_empty(whence) && renew_authorship)
>       ++	    !is_from_rebase_now_empty(whence) && renew_authorship)
>         		die(_("--reset-author can be used only with -C, -c or --amend."));
>         	if (use_message) {
>         		use_message_buffer = read_commit_message(use_message);
>       @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
>         		}
>         	}
>        -	if ((is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) &&
>       -+	if ((is_from_cherry_pick(whence) || is_from_rebase_empty(whence)) &&
>       ++	if ((is_from_cherry_pick(whence) || is_from_rebase_now_empty(whence)) &&
>         	    !renew_authorship) {
>         		author_message = "CHERRY_PICK_HEAD";
>         		author_message_buffer = read_commit_message(author_message);
>       @@ builtin/commit.c: int cmd_commit(int argc,
>         			reflog_msg = is_from_cherry_pick(whence)
>         					? "commit (cherry-pick)"
>        -					: is_from_rebase(whence)
>       -+					: is_from_rebase_empty(whence)
>       ++					: is_from_rebase_now_empty(whence)
>         					? "commit (rebase)"
>         					: "commit";
>         		commit_list_insert(current_head, &parents);
>       @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_wh
>         		    !repo_get_oid(r, "CHERRY_PICK_HEAD", &cherry_pick_head) &&
>         		    oideq(&rebase_head, &cherry_pick_head))
>        -			*whence = FROM_REBASE_PICK;
>       -+			*whence = FROM_REBASE_EMPTY;
>       ++			*whence = FROM_REBASE_NOW_EMPTY;
>         		else
>         			*whence = FROM_CHERRY_PICK_SINGLE;
>         
>       @@ wt-status.h: enum commit_whence {
>         	FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
>         	FROM_CHERRY_PICK_MULTI, /* commit came from a sequence of cherry-picks */
>        -	FROM_REBASE_PICK /* commit came from a pick/reword/edit */
>       -+	FROM_REBASE_EMPTY /* rebase applied a pick that became empty */
>       ++	FROM_REBASE_NOW_EMPTY /* rebase applied a pick that became empty */
>         };
>         
>         static inline int is_from_cherry_pick(enum commit_whence whence)
>       @@ wt-status.h: static inline int is_from_cherry_pick(enum commit_whence whence)
>         }
>         
>        -static inline int is_from_rebase(enum commit_whence whence)
>       -+static inline int is_from_rebase_empty(enum commit_whence whence)
>       ++static inline int is_from_rebase_now_empty(enum commit_whence whence)
>         {
>        -	return whence == FROM_REBASE_PICK;
>       -+	return whence == FROM_REBASE_EMPTY;
>       ++	return whence == FROM_REBASE_NOW_EMPTY;
>         }
>         
>         struct wt_status_change_data {
>   2:  e169303619 ! 2:  a0b9900437 commit: allow a partial commit when a rebase pick becomes empty
>       @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
>         			die(_("cannot do a partial commit during a merge."));
>         		else if (is_from_cherry_pick(whence))
>         			die(_("cannot do a partial commit during a cherry-pick."));
>       --		else if (is_from_rebase_empty(whence))
>       +-		else if (is_from_rebase_now_empty(whence))
>        -			die(_("cannot do a partial commit during a rebase."));
>         	}
>         
>   3:  0850a999da ! 3:  c4511a9887 commit: reword the empty-commit rebase amend error
>       @@ builtin/commit.c
>        @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
>         		else if (is_from_cherry_pick(whence))
>         			die(_("You are in the middle of a cherry-pick -- cannot amend."));
>       - 		else if (is_from_rebase_empty(whence))
>       + 		else if (is_from_rebase_now_empty(whence))
>        -			die(_("You are in the middle of a rebase -- cannot amend."));
>        +			die(_("The now-empty commit has been dropped -- cannot amend."));
>         	}
>   4:  9f80d8a00d ! 4:  e77b34c1cf commit: refuse to amend during conflict resolution
>       @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
>        -		else if (is_from_cherry_pick(whence))
>        +		case ONGOING_CHERRY_PICK:
>         			die(_("You are in the middle of a cherry-pick -- cannot amend."));
>       --		else if (is_from_rebase_empty(whence))
>       -+		case ONGOING_REBASE_EMPTY:
>       +-		else if (is_from_rebase_now_empty(whence))
>       ++		case ONGOING_REBASE_NOW_EMPTY:
>         			die(_("The now-empty commit has been dropped -- cannot amend."));
>        +		case ONGOING_REVERT:
>        +			die(_("You are in the middle of a revert -- cannot amend."));
>       @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_wh
>        +	case FROM_CHERRY_PICK_SINGLE:
>        +	case FROM_CHERRY_PICK_MULTI:
>        +		return ONGOING_CHERRY_PICK;
>       -+	case FROM_REBASE_EMPTY:
>       -+		return ONGOING_REBASE_EMPTY;
>       ++	case FROM_REBASE_NOW_EMPTY:
>       ++		return ONGOING_REBASE_NOW_EMPTY;
>        +	case FROM_COMMIT:
>        +		break;
>        +	}
>       @@ sequencer.h: int sequencer_get_last_command(struct repository* r,
>        +	ONGOING_NONE = 0,
>        +	ONGOING_MERGE,
>        +	ONGOING_CHERRY_PICK,
>       -+	ONGOING_REBASE_EMPTY,
>       ++	ONGOING_REBASE_NOW_EMPTY,
>        +	ONGOING_REVERT,
>        +	ONGOING_AM,
>        +	ONGOING_REBASE_CONFLICT
>   5:  050b9e8a52 ! 5:  b93b26ed9f commit: refuse partial commits during conflict resolution
>       @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
>        +		die(_("cannot do a partial commit during a merge."));
>        +	case ONGOING_CHERRY_PICK:
>        +		die(_("cannot do a partial commit during a cherry-pick."));
>       -+	case ONGOING_REBASE_EMPTY:
>       ++	case ONGOING_REBASE_NOW_EMPTY:
>        +		/*
>        +		 * A pick that became empty is not a conflict, and creating
>        +		 * a new commit (partial or not) poses no problem.
> 

