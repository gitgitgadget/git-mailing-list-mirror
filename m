Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A45C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 15:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiGOPhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiGOPhj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 11:37:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0858841
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 08:37:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a5so7201257wrx.12
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eNraG+2BS2yYy06rtHFLBdYZb2S7fXdCkHMDP05jmfA=;
        b=gfk5dDmjaon0ABleDfm71KOG79FmsoNccun2wf04RQ9ijEsCl2VsXG+mxNAkpDUnw1
         pzY1NzRcRxoTT36ZQ6bOKiMjjdMPVY3OeyWbSSOqXh2TGv2JG4bbsRx4oC6dtBrkfYyZ
         pXJYB65iDNTikGB92hHr71HNkTM+XqCRfHiqEA6CfBnf6BA7Wtg6AzIZGjC9f/99QrYw
         RNuijdcKti6/ZK1zmFRltRBQj7+TzcojKuDYDsd9iCiSe5sQ2zLhpNoYfP/R6Y7lgjyF
         E11gfNgC5q+KRHiVX6MSSWtBqMW5+w4ayfqdkXnThTooAKnVczOtiWgDsr5sI9zriCv4
         eIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eNraG+2BS2yYy06rtHFLBdYZb2S7fXdCkHMDP05jmfA=;
        b=Yt4NZU7d1FVUXHg2WujfCzgZ93Sjv5F9GSdT5jdMSlhHt2N29Nz0eMh4fde80KehqZ
         F5w6+YKqmohmlCu8FPxMsOJQvqJbYWdmm150mBCJmrZPBqJj1x21xKhaXVwJbqoLhAZP
         VVbQEWRRqakcUTiLML9cWhW++pr/7kVJl10MhZ10cTj5JMqpWXmUnyls6p8M+qeDLfee
         Zmqq5TnUi3s8ZxnR1FnO6sgyuoP4MU3U5sXnoCUSlNGZ5brvRvAI99D0bsgIAppE5Z7E
         cSfQPjwEhdSNhCb2GlYPoPwtabeEQmCe4l948inePqXOfHd5SGuhLWtqHC0OGpPEcKKv
         xreQ==
X-Gm-Message-State: AJIora9Q9L9s8fBuk8r6p7H4oSwHLTdsfnuCOl+HdGohFJMb9mKVEPtT
        Pdu2Y+ajf3kSznC+eANJPRk=
X-Google-Smtp-Source: AGRyM1t2yfK7TVTJ9/+n/xo6wnUKx5oAzMUft1qtmmIpZeNly0iCYlkwieztO7xb1d9CIZOVwVIMqQ==
X-Received: by 2002:a5d:595f:0:b0:21d:78fd:70d6 with SMTP id e31-20020a5d595f000000b0021d78fd70d6mr13010697wri.402.1657899455552;
        Fri, 15 Jul 2022 08:37:35 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id az29-20020a05600c601d00b003a03e63e428sm11019626wmb.36.2022.07.15.08.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 08:37:35 -0700 (PDT)
Message-ID: <8e533a1d-9d8f-a09f-e036-37ba39023aee@gmail.com>
Date:   Fri, 15 Jul 2022 16:37:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 03/12] branch: consider refs under 'update-refs'
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <bf301a054e3903444c2ea1c2e0234209d5ece291.1657631226.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <bf301a054e3903444c2ea1c2e0234209d5ece291.1657631226.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2022 14:06, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The branch_checked_out() helper helps commands like 'git branch' and
> 'git fetch' from overwriting refs that are currently checked out in
> other worktrees.
> 
> A future update to 'git rebase' will introduce a new '--update-refs'
> option which will update the local refs that point to commits that are
> being rebased. To avoid collisions as the rebase completes, we want to
> make the future data store for these refs to be considered by
> branch_checked_out().
> 
> The data store is a plaintext file inside the 'rebase-merge' directory
> for that worktree. The file lists refnames followed by two OIDs, each on
> separate lines. The OIDs will be used to store the original values of
> the refs and the to-be-written values as the rebase progresses, but can
> be ignored at the moment.
> 
> Create a new sequencer_get_update_refs_state() method that parses this
> file and populates a struct string_list with the ref-OID pairs. We can
> then use this list to add to the current_checked_out_branches strmap
> used by branch_checked_out().
> 
> To properly navigate to the rebase directory for a given worktree,
> extract the static strbuf_worktree_gitdir() method to a public API
> method.
> 
> We can test that this works without having Git write this file by
> artificially creating one in our test script, at least until 'git rebase
> --update-refs' is implemented and we can use it directly.

This looks good, I've left a couple of comments below but I'm not sure 
they're even worth reading let alone replying to!

Best Wishes

Phillip

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   branch.c                  | 13 +++++++
>   sequencer.c               | 74 +++++++++++++++++++++++++++++++++++++++
>   sequencer.h               |  9 +++++
>   t/t2407-worktree-heads.sh | 23 ++++++++++++
>   4 files changed, 119 insertions(+)
> 
> diff --git a/branch.c b/branch.c
> index 526e8237673..f252c4eef6c 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -365,6 +365,7 @@ static void prepare_checked_out_branches(void)
>   		char *old;
>   		struct wt_status_state state = { 0 };
>   		struct worktree *wt = worktrees[i++];
> +		struct string_list update_refs = STRING_LIST_INIT_DUP;
>   
>   		if (wt->is_bare)
>   			continue;
> @@ -400,6 +401,18 @@ static void prepare_checked_out_branches(void)
>   			strbuf_release(&ref);
>   		}
>   		wt_status_state_free_buffers(&state);
> +
> +		if (!sequencer_get_update_refs_state(get_worktree_git_dir(wt),
> +						     &update_refs)) {
> +			struct string_list_item *item;
> +			for_each_string_list_item(item, &update_refs) {
> +				old = strmap_put(&current_checked_out_branches,
> +						 item->string,
> +						 xstrdup(wt->path));
> +				free(old);
> +			}
> +			string_list_clear(&update_refs, 1);
> +		}
>   	}
>   
>   	free_worktrees(worktrees);
> diff --git a/sequencer.c b/sequencer.c
> index 8c3ed3532ac..e93c61cbd25 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -147,6 +147,20 @@ static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
>    */
>   static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>   
> +/*
> + * The update-refs file stores a list of refs that will be updated at the end
> + * of the rebase sequence. The 'update-ref <ref>' commands in the todo file
> + * update the OIDs for the refs in this file, but the refs are not updated
> + * until the end of the rebase sequence.
> + *
> + * rebase_path_update_refs() returns the path to this file for a given
> + * worktree directory. For the current worktree, pass the_repository->gitdir.
> + */
> +static char *rebase_path_update_refs(const char *wt_dir)

It is nice to see this function. The naming  of wt_dir confused me 
slightly, wt_git_dir would make it clear that this function takes the 
git_dir of the worktree and not the worktree directory. Theu 
documentation does a good job of clarifying that though.

> +{
> +	return xstrfmt("%s/rebase-merge/update-refs", wt_dir);
> +}
> +
>   /*
>    * The following files are written by git-rebase just after parsing the
>    * command-line.
> @@ -169,6 +183,15 @@ static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-res
>   static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
>   static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
>   
> +/**
> + * A 'struct update_refs_record' represents a value in the update-refs
> + * list. We use a string_list to map refs to these (before, after) pairs.
> + */
> +struct update_ref_record {
> +	struct object_id before;
> +	struct object_id after;
> +};
> +
>   static int git_sequencer_config(const char *k, const char *v, void *cb)
>   {
>   	struct replay_opts *opts = cb;
> @@ -5901,3 +5924,54 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
>   
>   	return 0;
>   }
> +
> +int sequencer_get_update_refs_state(const char *wt_dir,
> +				    struct string_list *refs)
> +{
> +	int result = 0;
> +	FILE *fp = NULL;
> +	struct strbuf ref = STRBUF_INIT;
> +	struct strbuf hash = STRBUF_INIT;
> +	struct update_ref_record *rec = NULL;
> +
> +	char *path = rebase_path_update_refs(wt_dir);
> +
> +	fp = fopen(path, "r");
> +	if (!fp)
> +		goto cleanup;
> +
> +	while (strbuf_getline(&ref, fp) != EOF) {
> +		struct string_list_item *item;
> +
> +		CALLOC_ARRAY(rec, 1);

It does not matter but later in the series we use rec = 
xmalloc(sizeof(*rec)) to do this. I'm not sure the project has a 
standard way of allocating a single instance of something.

> +
> +		if (strbuf_getline(&hash, fp) == EOF ||
> +		    get_oid_hex(hash.buf, &rec->before)) {
> +			warning(_("update-refs file at '%s' is invalid"),
> +				  path);
> +			result = -1;
> +			goto cleanup;
> +		}
> +
> +		if (strbuf_getline(&hash, fp) == EOF ||
> +		    get_oid_hex(hash.buf, &rec->after)) {
> +			warning(_("update-refs file at '%s' is invalid"),
> +				  path);
> +			result = -1;
> +			goto cleanup;
> +		}
> +
> +		item = string_list_insert(refs, ref.buf);
> +		item->util = rec;
> +		rec = NULL;
> +	}
> +
> +cleanup:
> +	if (fp)
> +		fclose(fp);
> +	free(path);
> +	free(rec);
> +	strbuf_release(&ref);
> +	strbuf_release(&hash);
> +	return result;
> +}
> diff --git a/sequencer.h b/sequencer.h
> index da64473636b..3ae541bb145 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -232,4 +232,13 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose);
>   int sequencer_get_last_command(struct repository* r,
>   			       enum replay_action *action);
>   int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
> +
> +/**
> + * Append the set of ref-OID pairs that are currently stored for the 'git
> + * rebase --update-refs' feature if such a rebase is currently happening.
> + *
> + * Localized to a worktree's git dir.
> + */
> +int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
> +
>   #endif /* SEQUENCER_H */
> diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> index a67ce5fb003..97f5c87f8c8 100755
> --- a/t/t2407-worktree-heads.sh
> +++ b/t/t2407-worktree-heads.sh
> @@ -81,6 +81,29 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (mer
>   	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
>   '
>   
> +test_expect_success 'refuse to overwrite: worktree in rebase with --update-refs' '
> +	test_when_finished rm -rf .git/worktrees/wt-3/rebase-merge &&
> +
> +	mkdir -p .git/worktrees/wt-3/rebase-merge &&
> +	touch .git/worktrees/wt-3/rebase-merge/interactive &&
> +
> +	cat >.git/worktrees/wt-3/rebase-merge/update-refs <<-EOF &&
> +	refs/heads/fake-3
> +	$(git rev-parse HEAD~1)
> +	$(git rev-parse HEAD)
> +	refs/heads/fake-4
> +	$(git rev-parse HEAD)
> +	$(git rev-parse HEAD)
> +	EOF
> +
> +	for i in 3 4
> +	do
> +		test_must_fail git branch -f fake-$i HEAD 2>err &&
> +		grep "cannot force update the branch '\''fake-$i'\'' checked out at.*wt-3" err ||
> +			return 1
> +	done
> +'
> +
>   test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
>   	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
>   	grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&

