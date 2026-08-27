Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92730D3FE
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843975; cv=none; b=SCv+d1ru9pvui20f12DNnJdnyYfD3+VNpdVxDQJQbA01UIoiJVKSUvB9rzdhubxQpEwLc3xBD6JBQ7thLvK3A2wXCyJk+hUSDgkIlAichJC5SwIfCOAu/R2lKEijZH3pH0ydj3zwRxIAIVl8yfOAgWQAfdbsGWEVcvzkYJ1j0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843975; c=relaxed/simple;
	bh=klHCLyCxHJKJ6wHAciZysYMF4/0pJqQbKk6tgvaQzL0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rqJiM02nJLITcL1dQgcmEG0yjA7TQ5DnAc7sQVlkvPzaskQsMcm9PrLl0/PVv3gy0Wn2J6gcrhjs9eKcy8HjPYMXPLdX8ji2DY9hqLaHr7FdW7RXrfWysH4e6lYmotGTAEtAypLhzqNE18Nus3ilKhdPL8IgWR+TgZwmHMkLzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4fhH+Bt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4fhH+Bt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1866432f8f.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787843972; x=1788448772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xEfL+ULhZVa5HxQ7o6BDQ0lu1Gq2UtwnGzBC5r3byTc=;
        b=j4fhH+BtPOU2t8r+impQQpP133oDJOnCkVJyCnUGlB4VBmQ0NlkEBO4bNGkCBmpcfF
         chofyNOKAlgMuqhSANHL+b2vP/siqhVKjAeWLNwRt/LE1Rz7R64l5XjshKCAv3TrT/8w
         EsrrKi7MzQ7k5AM4WcMTJ+ziv29/cbDOVZufE4Z7Ar1vaOMJxQLF/2QaW4vvWwrFHUhX
         k0gIix00MZqjl+G5mXWGrGtDRUltRfQx+izerKpMXHDLjdmcc0iviRBSKj+XMrjcfORa
         fJyXdP6EMhAw1VIpmx1wXwN8pArzdts635qmI3exFSf0iNNAV14TVTjhk83D8/y0rZvc
         dLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843972; x=1788448772;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xEfL+ULhZVa5HxQ7o6BDQ0lu1Gq2UtwnGzBC5r3byTc=;
        b=IDHoYWUVcfb5N6AEAAZuxpavRL980Ksi47SHBqmZ2P2lpC7VnsEtqj9gtXXcRAOTpc
         BZ58rxpi8fkX10ZN1aS8/qBJtDXi8tkXLeEGCg/rjfxSTnkF8eG31SuQLUAVEe/x+0J0
         0KfgzdkjnwvLYdLMfabxpryo4eLqPxKTwD+pCqMa8wDA3Oo1viw6Q5wQaRGCE80gY2r1
         th2+sBErWHlkZQJSKP1nKpXnEZy62sEloYpBd7fh2TOIX2UMZSnU4PvSjleU6kB6JJXu
         edZRr2+VgB2sdKQhakd11ZbrC3w9QmyfNtdV5keIxzEG1f5Lx9lnU4MIgDxbPHMjJzMF
         z83A==
X-Forwarded-Encrypted: i=1; AHgh+RqQ9jPzZpW8elGQAnpar1LwBMPwlxEFFK2mlEk5mHOA/dHMuT49jJfs/xeymh5v7QOhBVA=@vger.kernel.org
X-Gm-Message-State: AFuF++nMtQ8z2cI1j5Caw4WP3bBAzBo5KvIv6lBsn8Y8F762ewDju30e
	zU20Vr3Fn7j9kn4sCHnkbKV0YpENAfbQRgfwgQs+bvoBXCO3mIZvrMAo
X-Gm-Gg: AR+sD12Ea9GPdVXTo/6if/pcSwojurPLUNDbVnM8y/KkawNQD9r0QmEYt9qaqpmtkOn
	M5W7QPRXIVeyyYLQJIyLGfSQ1E6yjrqrR2BXNmOzyjnvQ40XQr+mWoUkCXkPX+VWPNhcAv6oScI
	538MULtqeRaBApJiR03fwNvSer5/ouFKqjEJqZJHgOr3bPw0xrmTs2wZfvwYEiUZDaoBpkmTTa3
	s2ZTPNV8kE/jOElNfh2FFysY2mwn0AakjKjO93oSt+WdLfXxSLJsorIEIfNwiu2XpNGtU7XtDAl
	oqgu98Nl+dQpZ7cuuPY+BlT+h4AyksTkyfSCFZ9BzbixzH+tqyxiEv56W+XJmXp+p2Rgfl/1XuT
	SiVbocg2QB3UuLIQqMCRkVH8ItWMuUezlBQDmRRmtxfm9Psgg+6Q7upqvRpoCwJNYsYyY+23mxG
	p7/ZNN3r92OoX+iV8RjgKZUbkJLy0R6TpgSBTO/ARocBNppQZpPLbc8zI5dbbwP0UGxtJG3eRGX
	42s6hrUZofZ4GpZs+ipxJqT4nVlYEFSYQVVAvvRpXs8XslE0NLEIA==
X-Received: by 2002:a05:6000:2888:b0:482:e451:6817 with SMTP id ffacd0b85a97d-482e4516915mr17624758f8f.12.1787843970623;
        Thu, 27 Aug 2026 08:19:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e2756112sm10602392f8f.0.2026.08.27.08.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:19:30 -0700 (PDT)
Message-ID: <6a04525c-d9e7-415a-845f-f11ed1c0f0d5@gmail.com>
Date: Thu, 27 Aug 2026 16:19:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] commit: refuse to amend during conflict resolution
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 27/08/2026 02:02, Elijah Newren via GitGitGadget wrote:
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

Thanks for working on this, it is a useful improvement to our UI. I've 
left a couple of comments but this all looks pretty sound to me.

Thanks

Phillip

> Elijah Newren (3):
>    commit: reword the empty-commit rebase errors
>    commit: refuse to amend during conflict resolution
>    commit: refuse partial commits during conflict resolution
> 
>   builtin/commit.c                |  51 +++++++++----
>   sequencer.c                     |  65 +++++++++++++++++
>   sequencer.h                     |  24 ++++++
>   t/t3404-rebase-interactive.sh   | 125 +++++++++++++++++++++++++++++++-
>   t/t3507-cherry-pick-conflict.sh |  22 ++++++
>   t/t4151-am-abort.sh             |  22 ++++++
>   6 files changed, 293 insertions(+), 16 deletions(-)
> 
> 
> base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2389%2Fnewren%2Frefuse-amend-during-conflicts-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2389/newren/refuse-amend-during-conflicts-v2
> Pull-Request: https://github.com/git/git/pull/2389
> 
> Range-diff vs v1:
> 
>   -:  ---------- > 1:  65c48ed3cb commit: reword the empty-commit rebase errors
>   1:  a3d6b059c6 ! 2:  4a1461e527 commit: refuse to amend during conflict resolution
>       @@ Commit message
>            Signed-off-by: Elijah Newren <newren@gmail.com>
>        
>         ## builtin/commit.c ##
>       -@@
>       - #include "path.h"
>       - #include "preload-index.h"
>       - #include "read-cache.h"
>       -+#include "refs.h"
>       - #include "repository.h"
>       - #include "string-list.h"
>       - #include "rerere.h"
>        @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
>       - 		else if (whence == FROM_REBASE_PICK)
>       - 			die(_("You are in the middle of a rebase -- cannot amend."));
>       + 		use_editor = 0;
>       +
>       + 	/* Sanity check options */
>       +-	if (amend && !current_head)
>       +-		die(_("You have nothing to amend."));
>       +-	if (amend && whence != FROM_COMMIT) {
>       +-		if (whence == FROM_MERGE)
>       ++	if (amend) {
>       ++		if (!current_head)
>       ++			die(_("You have nothing to amend."));
>       ++		/*
>       ++		 * Refuse to amend in the middle of any operation that is
>       ++		 * meant to record its result as a new commit on top of HEAD
>       ++		 * rather than by rewriting HEAD.
>       ++		 */
>       ++		switch (sequencer_ongoing_operation(s->repo, whence)) {
>       ++		case ONGOING_NONE:
>       ++			break;
>       ++		case ONGOING_MERGE:
>       + 			die(_("You are in the middle of a merge -- cannot amend."));
>       +-		else if (is_from_cherry_pick(whence))
>       ++		case ONGOING_CHERRY_PICK:
>       + 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
>       +-		else if (whence == FROM_REBASE_PICK)
>       ++		case ONGOING_REBASE_EMPTY:
>       + 			die(_("You are resolving a commit that became empty -- cannot amend."));
>       ++		case ONGOING_REVERT:
>       ++			die(_("You are in the middle of a revert -- cannot amend."));
>       ++		case ONGOING_AM:
>       ++			die(_("You are in the middle of an am session -- cannot amend."));
>       ++		case ONGOING_REBASE_CONFLICT:
>       ++			die(_("You are resolving conflicts during a rebase -- cannot amend."));
>       ++		}
>         	}
>       -+	if (amend && whence == FROM_COMMIT) {
>       -+		char *applying, *apply_dir, *stopped_sha, *amend_marker;
>       -+		int in_am, conflicted_stop;
>       + 	if (fixup_message && squash_message)
>       + 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
>       +
>       + ## sequencer.c ##
>       +@@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
>       + 	return 0;
>       + }
>       +
>       ++enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
>       ++						   enum commit_whence whence)
>       ++{
>       ++	char *path;
>       ++	int found;
>        +
>       -+		/* Check middle of revert */
>       -+		if (refs_ref_exists(get_main_ref_store(the_repository),
>       -+				    "REVERT_HEAD"))
>       -+			die(_("You are in the middle of a revert -- cannot amend."));
>       ++	/*
>       ++	 * The merge, cherry-pick, and (empty) rebase-pick stops are already
>       ++	 * distinguished by 'whence'.
>       ++	 */
>       ++	switch (whence) {
>       ++	case FROM_MERGE:
>       ++		return ONGOING_MERGE;
>       ++	case FROM_CHERRY_PICK_SINGLE:
>       ++	case FROM_CHERRY_PICK_MULTI:
>       ++		return ONGOING_CHERRY_PICK;
>       ++	case FROM_REBASE_PICK:
>       ++		return ONGOING_REBASE_EMPTY;
>       ++	case FROM_COMMIT:
>       ++		break;
>       ++	}
>        +
>       -+		/* Check middle of `am` */
>       -+		applying = repo_git_path(the_repository,
>       -+					 "rebase-apply/applying");
>       -+		in_am = file_exists(applying);
>       ++	/*
>       ++	 * 'whence' is FROM_COMMIT, but we may still be in the middle of an
>       ++	 * operation that records its result on top of HEAD; detect those
>       ++	 * from their on-disk state.
>       ++	 */
>        +
>       -+		free(applying);
>       -+		if (in_am)
>       -+			die(_("You are in the middle of an am session -- cannot amend."));
>       ++	/* In the middle of a revert? */
>       ++	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
>       ++		return ONGOING_REVERT;
>        +
>       -+		/* Check middle of rebase specifically stopped for conflicts */
>       -+		apply_dir = repo_git_path(the_repository,
>       -+					  "rebase-apply");
>       -+		stopped_sha = repo_git_path(the_repository,
>       -+					    "rebase-merge/stopped-sha");
>       -+		amend_marker = repo_git_path(the_repository,
>       -+					     "rebase-merge/amend");
>       -+		/*
>       -+		 * The apply backend only ever stops for conflicts; the
>       -+		 * merge backend writes stopped-sha but omits `amend`,
>       -+		 * which it writes only at a clean edit/reword stop.
>       -+		 */
>       -+		conflicted_stop =
>       -+			file_exists(apply_dir) ||
>       -+			(file_exists(stopped_sha) && !file_exists(amend_marker));
>       ++	/* In the middle of an `am`? */
>       ++	path = repo_git_path(r, "rebase-apply/applying");
>       ++	found = file_exists(path);
>       ++	free(path);
>       ++	if (found)
>       ++		return ONGOING_AM;
>       ++
>       ++	/*
>       ++	 * In the middle of a rebase that stopped for conflict resolution?
>       ++	 * The apply backend only ever stops for conflicts, so the presence
>       ++	 * of its state directory is enough.  The merge backend writes
>       ++	 * stopped-sha whenever it hands control back to the user, but omits
>       ++	 * `amend` unless it stopped with HEAD already pointing at the commit
>       ++	 * to be amended (a clean edit/reword stop); its absence therefore
>       ++	 * marks a conflicted stop.
>       ++	 */
>       ++	path = repo_git_path(r, "rebase-apply");
>       ++	found = file_exists(path);
>       ++	free(path);
>       ++	if (!found) {
>       ++		char *stopped_sha = repo_git_path(r, "rebase-merge/stopped-sha");
>       ++		char *amend_marker = repo_git_path(r, "rebase-merge/amend");
>        +
>       -+		free(apply_dir);
>       ++		found = file_exists(stopped_sha) && !file_exists(amend_marker);
>        +		free(stopped_sha);
>        +		free(amend_marker);
>       -+		if (conflicted_stop)
>       -+			die(_("You are resolving conflicts during a rebase -- cannot amend."));
>        +	}
>       - 	if (fixup_message && squash_message)
>       - 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
>       - 	die_for_incompatible_opt4(!!use_message, "-C",
>       ++	if (found)
>       ++		return ONGOING_REBASE_CONFLICT;
>       ++
>       ++	return ONGOING_NONE;
>       ++}
>       ++
>       + int sequencer_get_update_refs_state(const char *wt_dir,
>       + 				    struct string_list *refs)
>       + {
>       +
>       + ## sequencer.h ##
>       +@@ sequencer.h: int sequencer_get_last_command(struct repository* r,
>       + 			       enum replay_action *action);
>       + int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
>       +
>       ++/*
>       ++ * An in-progress operation that records its result (often a conflict
>       ++ * resolution) as a new commit on top of HEAD, during which amending
>       ++ * HEAD via "git commit --amend" is almost always a mistake.
>       ++ */
>       ++enum ongoing_operation {
>       ++	ONGOING_NONE = 0,
>       ++	ONGOING_MERGE,
>       ++	ONGOING_CHERRY_PICK,
>       ++	ONGOING_REBASE_EMPTY,
>       ++	ONGOING_REVERT,
>       ++	ONGOING_AM,
>       ++	ONGOING_REBASE_CONFLICT
>       ++};
>       ++
>       ++/*
>       ++ * Return which in-progress operation, if any, is underway; see enum
>       ++ * ongoing_operation.  'whence' is the origin already computed for the
>       ++ * pending commit.
>       ++ */
>       ++enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
>       ++						   enum commit_whence whence);
>       ++
>       + /**
>       +  * Append the set of ref-OID pairs that are currently stored for the 'git
>       +  * rebase --update-refs' feature if such a rebase is currently happening.
>        
>         ## t/t3404-rebase-interactive.sh ##
>        @@ t/t3404-rebase-interactive.sh: test_expect_success 'correct error message for commit --amend after empty pick'
>       - 	test_grep "middle of a rebase -- cannot amend." err
>       + 	test_grep "resolving a commit that became empty -- cannot amend." err
>         '
>         
>        +test_expect_success 'commit --amend is refused at a rebase conflict stop' '
>   -:  ---------- > 3:  e0be8cdf63 commit: refuse partial commits during conflict resolution
> 

