Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2087FC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 13:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiGONZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGONZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 09:25:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A42678DD1
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:25:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so837049wmo.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L8JeLSHJ9VhT5i2qKiw5IRp40SAEINEeBEFH8eedSnA=;
        b=c1A+t+XTOgfNvltJFEu6xPwpSm/YgteH744yrJV2WYwm5Re9La5NE02qjCBDpkqnXf
         9wJh0nccHkr0jDweDOWPPHbBzCMU4scGaXxicY4IfhKvwxF3pQUTLRVr/l44Ik0xVbE9
         8tJKSn+KQ+7PteeITL6PchaAKRlcCaNsS4RoLCYizDLeINha2McQzZsjlEMo3tRAD+LL
         E+V8DBIoEA0zDqxoe8K55ln+OsJz2qdahbuMEjAxKvY7j4W/068ae0MXT/2UEqfksr/d
         GkJ2EH3uzPAL/ZX8CH9M1k1PWC3Ki33LnNK/kbTNfYP3PVy4ZaBLVT+rLGI7MmY1K+A6
         QaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L8JeLSHJ9VhT5i2qKiw5IRp40SAEINEeBEFH8eedSnA=;
        b=oFgY/Z4aLsGLV6KRGLqCMGjrgWlHzCuZ7pfojWEPxQKfEY21HFmA9t6H7jYqrTZ6Vb
         jkIyjrjLLwBiNrlp4MbYRxPWiNJP85wxqJH9OKxxj7PH+CAjVT5nr1vCySGl2IW0dTJ3
         LJCO52D9/tbqcPG2xbf4b1L+4AN07CfOywrBR0D/t9kXkEfG26TsMrHScsHotX7xWKiM
         FVBYEuMBIBGJwH+4RtQ03KYBlwKWQqtNaK/B8ER3e31TeqX3A520GlP4FZAKnkgG9sOI
         snTzyT5FueKimjYbbpAJLYjYa5lhMzy9pIQrWSMLmmzl7M5CLQeUz3BGmQGyq9hxiS4f
         ELKQ==
X-Gm-Message-State: AJIora/VrzM8R5yTgHmH9xyL/6/eGms8cyAbnbIo+ze9TA8bos1mEtaZ
        AbeI/bBejOpXcm/hK6zPILQ=
X-Google-Smtp-Source: AGRyM1u1UcsmMBnE2YIlDSXw1HPAwcrtaeBSYIPdecEpUeLU5xLaRaScRNbFnO0ez+LLaXGb+fpPWQ==
X-Received: by 2002:a7b:c3d8:0:b0:3a2:fcc8:323 with SMTP id t24-20020a7bc3d8000000b003a2fcc80323mr13242370wmj.132.1657891524172;
        Fri, 15 Jul 2022 06:25:24 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id j27-20020a05600c1c1b00b0039c4ba160absm16387267wms.2.2022.07.15.06.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 06:25:23 -0700 (PDT)
Message-ID: <e40df260-6ca7-10f8-c4bf-82c42585dd12@gmail.com>
Date:   Fri, 15 Jul 2022 14:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 08/12] rebase: update refs from 'update-ref' commands
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <fb5f64c52010e01ce0b5a886e9611fa2a6ea7833.1657631226.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <fb5f64c52010e01ce0b5a886e9611fa2a6ea7833.1657631226.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 12/07/2022 14:07, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The previous change introduced the 'git rebase --update-refs' option
> which added 'update-ref <ref>' commands to the todo list of an
> interactive rebase.
> 
> Teach Git to record the HEAD position when reaching these 'update-ref'
> commands. The ref/before/after triple is stored in the
> $GIT_DIR/rebase-merge/update-refs file. A previous change parsed this
> file to avoid having other processes updating the refs in that file
> while the rebase is in progress.
> 
> Not only do we update the file when the sequencer reaches these
> 'update-ref' commands, we then update the refs themselves at the end of
> the rebase sequence. If the rebase is aborted before this final step,
> then the refs are not updated. The 'before' value is used to ensure that
> we do not accidentally obliterate a ref that was updated concurrently
> (say, by an older version of Git or a third-party tool).
> 
> Now that the 'git rebase --update-refs' command is implemented to write
> to the update-refs file, we can remove the fake construction of the
> update-refs file from a test in t2407-worktree-heads.sh.

This is looking good. I've left a few comments, mostly about error 
propagation. It's nice to see us recording the initial value of the ref 
when the todo list is created. It's also good to see this using a lock 
file. We could perhaps lock the file (with a timeout) when we read it in 
sequencer_get_update_refs_state() to avoid a race where a process is 
checking out a new branch in one worktree and another is preparing to 
rebase that branch in another worktree.

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   sequencer.c                   | 113 +++++++++++++++++++++++++++++++++-
>   t/t2407-worktree-heads.sh     |  21 ++-----
>   t/t3404-rebase-interactive.sh |  17 +++++
>   3 files changed, 134 insertions(+), 17 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e657862cda2..2d89b3b727a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -36,6 +36,7 @@
>   #include "rebase-interactive.h"
>   #include "reset.h"
>   #include "branch.h"
> +#include "log-tree.h"
>   
>   #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>   
> @@ -193,6 +194,19 @@ struct update_ref_record {
>   	struct object_id after;
>   };
>   
> +static struct update_ref_record *init_update_ref_record(const char *ref)
> +{
> +	struct update_ref_record *rec = xmalloc(sizeof(*rec));
> +
> +	oidcpy(&rec->before, null_oid());
> +	oidcpy(&rec->after, null_oid());
> +
> +	/* This may fail, but that's fine, we will keep the null OID. */
> +	read_ref(ref, &rec->before);
> +
> +	return rec;
> +}
> +
>   static int git_sequencer_config(const char *k, const char *v, void *cb)
>   {
>   	struct replay_opts *opts = cb;
> @@ -4081,11 +4095,102 @@ leave_merge:
>   	return ret;
>   }
>   
> -static int do_update_ref(struct repository *r, const char *ref_name)
> +static int write_update_refs_state(struct string_list *refs_to_oids)
>   {
> +	int result = 0;
> +	struct lock_file lock = LOCK_INIT;
> +	FILE *fp = NULL;
> +	struct string_list_item *item;
> +	char *path;
> +
> +	if (!refs_to_oids->nr)
> +		return 0;
> +
> +	path = rebase_path_update_refs(the_repository->gitdir);
> +
> +	if (safe_create_leading_directories(path)) {
> +		result = error(_("unable to create leading directories of %s"),
> +			       path);
> +		goto cleanup;
> +	}
> +
> +	if (hold_lock_file_for_update(&lock, path, 0) < 0) {
> +		result = error(_("another 'rebase' process appears to be running; "
> +				 "'%s.lock' already exists"),
> +			       path);
> +		goto cleanup;
> +	}
> +
> +	fp = fdopen_lock_file(&lock, "w");
> +	if (!fp) {
> +		result = error_errno(_("could not open '%s' for writing"), path);
> +		rollback_lock_file(&lock);
> +		goto cleanup;
> +	}
> +
> +	for_each_string_list_item(item, refs_to_oids) {
> +		struct update_ref_record *rec = item->util;
> +		fprintf(fp, "%s\n%s\n%s\n", item->string,
> +			oid_to_hex(&rec->before), oid_to_hex(&rec->after));
> +	}
> +
> +	result = commit_lock_file(&lock);
> +
> +cleanup:
> +	free(path);
> +	return result;
> +}
> +
> +static int do_update_ref(struct repository *r, const char *refname)
> +{
> +	struct string_list_item *item;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +	sequencer_get_update_refs_state(r->gitdir, &list);

We're ignoring any errors here and always returning 0 from this function.

> +
> +	for_each_string_list_item(item, &list) {
> +		if (!strcmp(item->string, refname)) {
> +			struct update_ref_record *rec = item->util;
> +			read_ref("HEAD", &rec->after);
> +			break;
> +		}
> +	}
> +
> +	write_update_refs_state(&list);
> +	string_list_clear(&list, 1);
>   	return 0;
>   }
>   
> +static int do_update_refs(struct repository *r)
> +{
> +	int res = 0;
> +	struct string_list_item *item;
> +	struct string_list refs_to_oids = STRING_LIST_INIT_DUP;
> +	struct ref_store *refs = get_main_ref_store(r);
> +
> +	sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);
> +
> +	for_each_string_list_item(item, &refs_to_oids) {
> +		struct update_ref_record *rec = item->util;
> +
> +		if (oideq(&rec->after, the_hash_algo->null_oid)) {
> +			/*
> +			 * Ref was not updated. User may have deleted the
> +			 * 'update-ref' step.
> +			 */

Unless we want to support users editing the todo list without using "git 
rebase --edit-todo" then by the end of the series it is a bug if we 
leave an entry in the update-refs file that has been removed from the 
todo list so I wander if we should remove this if().

> +			continue;
> +		}
> +
> +		res |= refs_update_ref(refs, "rewritten during rebase",
> +				       item->string,
> +				       &rec->after, &rec->before,
> +				       0, UPDATE_REFS_MSG_ON_ERR);
> +	}
> +
> +	string_list_clear(&refs_to_oids, 1);
> +	return res;
> +}
> +
>   static int is_final_fixup(struct todo_list *todo_list)
>   {
>   	int i = todo_list->current;
> @@ -4603,6 +4708,8 @@ cleanup_head_ref:
>   		strbuf_release(&head_ref);
>   	}
>   
> +	do_update_refs(r);

Should this be inside the "if (is_rebase_i(opts))" that is closed just 
above it? We're also ignoring the return value.

> +
>   	/*
>   	 * Sequence of picks finished successfully; cleanup by
>   	 * removing the .git/sequencer directory
> @@ -5676,7 +5783,7 @@ static int add_decorations_to_list(const struct commit *commit,
>   
>   			sti = string_list_insert(&ctx->refs_to_oids,
>   						 decoration->name);
> -			sti->util = oiddup(the_hash_algo->null_oid);
> +			sti->util = init_update_ref_record(decoration->name);
>   		}
>   
>   		item->offset_in_buf = base_offset;
> @@ -5732,6 +5839,8 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
>   		}
>   	}
>   
> +	write_update_refs_state(&ctx.refs_to_oids);

We're ignoring the return value. Also I think 
todo_list_add_update_ref_commands() only ever returns 0.

Best Wishes

Phillip

> +
>   	string_list_clear(&ctx.refs_to_oids, 1);
>   	free(todo_list->items);
>   	todo_list->items = ctx.items;
> diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> index 8a03f14df8d..50815acd3e8 100755
> --- a/t/t2407-worktree-heads.sh
> +++ b/t/t2407-worktree-heads.sh
> @@ -81,25 +81,16 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (mer
>   	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
>   '
>   
> -test_expect_success 'refuse to overwrite: worktree in rebase with --update-refs' '
> -	test_when_finished rm -rf .git/worktrees/wt-3/rebase-merge &&
> -
> -	mkdir -p .git/worktrees/wt-3/rebase-merge &&
> -	touch .git/worktrees/wt-3/rebase-merge/interactive &&
> +test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with --update-refs' '
> +	test_when_finished git -C wt-3 rebase --abort &&
>   
> -	cat >.git/worktrees/wt-3/rebase-merge/update-refs <<-EOF &&
> -	refs/heads/fake-3
> -	$(git rev-parse HEAD~1)
> -	$(git rev-parse HEAD)
> -	refs/heads/fake-4
> -	$(git rev-parse HEAD)
> -	$(git rev-parse HEAD)
> -	EOF
> +	git branch -f can-be-updated wt-3 &&
> +	test_must_fail git -C wt-3 rebase --update-refs conflict-3 &&
>   
>   	for i in 3 4
>   	do
> -		test_must_fail git branch -f fake-$i HEAD 2>err &&
> -		grep "cannot force update the branch '\''fake-$i'\'' checked out at.*wt-3" err ||
> +		test_must_fail git branch -f can-be-updated HEAD 2>err &&
> +		grep "cannot force update the branch '\''can-be-updated'\'' checked out at.*wt-3" err ||
>   			return 1
>   	done
>   '
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 3cd20733bc8..a37820fa728 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1813,6 +1813,23 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
>   	)
>   '
>   
> +test_expect_success '--update-refs updates refs correctly' '
> +	git checkout -B update-refs no-conflict-branch &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~3 &&
> +	git branch -f third HEAD~1 &&
> +	test_commit extra2 fileX &&
> +	git commit --amend --fixup=L &&
> +
> +	git rebase -i --autosquash --update-refs primary &&
> +
> +	test_cmp_rev HEAD~3 refs/heads/first &&
> +	test_cmp_rev HEAD~3 refs/heads/second &&
> +	test_cmp_rev HEAD~1 refs/heads/third &&
> +	test_cmp_rev HEAD refs/heads/no-conflict-branch
> +'
> +
>   # This must be the last test in this file
>   test_expect_success '$EDITOR and friends are unchanged' '
>   	test_editor_unchanged

