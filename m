Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1046C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 09:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiKHJ6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiKHJ6x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 04:58:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD2FE03C
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 01:58:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bk15so20052511wrb.13
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 01:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrtAF91cQmJwcTIBBKD2izWtdBl7vmKoqfNaRO8WXuE=;
        b=XaQZ2bRpocHoUdExtk8C2n+MAg6HYwqUZccGJO6fDFJBmkrtS1mWOXGE6KfDDP3kbI
         rJML020LCLe8vfPfprze+Bh6riqZWaI8ftfGydmFnasGB7uHN4OvF7aw241HV+Ju31ip
         tWIFFC3hQh5Fv4oDypnys6Oy6y/K6w3J4F8wEDZXgHL3WIutu/5xwwPRUdfVYQUI+ufL
         nHlekWLyxKP/9t+t1X/1tertIyFYtIoxUNJNCNVuNHp0GV4l52cq+TXF35M73woU4DpT
         l9px4yTZ2RtYgRuSwwc+RNywJnLO6xUwz5oF0mI99eJ0gMoGF86WN3wNCea6H1Q4rFje
         2CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrtAF91cQmJwcTIBBKD2izWtdBl7vmKoqfNaRO8WXuE=;
        b=M6SjBIM+zCCkxtrDOCpEVUFYsHWwYrI4MA1OsCjc8ufBHcKNF5vCLVgzYfeMMmRXd4
         9R91kh+dQZomUJuas1H21K3m/zvfZDB/gThE0W0STkkYRWlFyN93Y5P8vabORsgfQ/BO
         FKhxVT5DuycnF9JzUi5bcctdst2H7Al18+1Wt0YBneaC/C1Jd88iHPzeOx6qVLgYDj2u
         UehfR/1hlLc8W7GBBbynQtck+IF7aGNmN3Y7FoquObcdK50NMLfW4vtYkeda/kaTEpKs
         amUO/nLnL0VmapJ7woa6nVQc1lwVgGXGY6ohuqcbXcy17L4/K5VE4iYMvyCQN/WfNOZd
         +CmA==
X-Gm-Message-State: ACrzQf1dXgAMbYKiYLpOzgZm1RWX9ey8tpsyzXdYlThgujMMaUue/VhT
        CE2ttZ5M2MXJLTekqMpuFnbdaPz9Dus=
X-Google-Smtp-Source: AMsMyM7r2BGIOmU1e/Rsrbm7v+IgDV+HqP95ZXCDb9Enl1FviWhbY8HAH3QpvmBG91Ol5qP63F75DA==
X-Received: by 2002:adf:c082:0:b0:236:d057:3fff with SMTP id d2-20020adfc082000000b00236d0573fffmr28187167wrf.206.1667901527609;
        Tue, 08 Nov 2022 01:58:47 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id n25-20020a1c7219000000b003cf774c31a0sm13722417wmc.16.2022.11.08.01.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 01:58:47 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <934a0862-2713-7705-9155-6584449397c7@dunelm.org.uk>
Date:   Tue, 8 Nov 2022 09:58:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rebase --update-refs: avoid unintended ref deletion
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "herr.kaste" <herr.kaste@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <20221104165735.68899-1-vdye@github.com>
 <20221107174752.91186-1-vdye@github.com>
In-Reply-To: <20221107174752.91186-1-vdye@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 07/11/2022 17:47, Victoria Dye wrote:
> In b3b1a21d1a5 (sequencer: rewrite update-refs as user edits todo list,
> 2022-07-19), the 'todo_list_filter_update_refs()' step was added to handle
> the removal of 'update-ref' lines from a 'rebase-todo'. Specifically, it
> removes potential ref updates from the "update refs state" if a ref does not
> have a corresponding 'update-ref' line.
> 
> However, because 'write_update_refs_state()' will not update the state if
> the 'refs_to_oids' list was empty, removing *all* 'update-ref' lines will
> result in the state remaining unchanged from how it was initialized (with
> all refs' "after" OID being null). Then, when the ref update is applied, all
> refs will be updated to null and consequently deleted.
> 
> To fix this, delete the 'update-refs' state file when 'refs_to_oids' is
> empty. Additionally, add a tests covering "all update-ref lines removed"
> cases.

Thanks for re-rolling, unsurprisingly I prefer the unlink() approach to 
the previous version. As Stolee said the test coverage looks good too.

Best Wishes

Phillip


> Reported-by: herr.kaste <herr.kaste@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
> Changes since v1:
> - Modified approach to handling empty 'refs_to_oids' from "optional force write
>    empty file" to "always unlink"
> - Added/updated tests
> 
>   sequencer.c                   |   9 ++-
>   t/t3404-rebase-interactive.sh | 107 ++++++++++++++++++++++++++++++++++
>   2 files changed, 113 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e658df7e8ff..798a9702961 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4130,11 +4130,14 @@ static int write_update_refs_state(struct string_list *refs_to_oids)
>   	struct string_list_item *item;
>   	char *path;
> 
> -	if (!refs_to_oids->nr)
> -		return 0;
> -
>   	path = rebase_path_update_refs(the_repository->gitdir);
> 
> +	if (!refs_to_oids->nr) {
> +		if (unlink(path) && errno != ENOENT)
> +			result = error_errno(_("could not unlink: %s"), path);
> +		goto cleanup;
> +	}
> +
>   	if (safe_create_leading_directories(path)) {
>   		result = error(_("unable to create leading directories of %s"),
>   			       path);
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 4f5abb5ad25..462cefd25df 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1964,6 +1964,113 @@ test_expect_success 'respect user edits to update-ref steps' '
>   	test_cmp_rev HEAD refs/heads/no-conflict-branch
>   '
> 
> +test_expect_success '--update-refs: all update-ref lines removed' '
> +	git checkout -b test-refs-not-removed no-conflict-branch &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~3 &&
> +	git branch -f third HEAD~1 &&
> +	git branch -f tip &&
> +
> +	test_commit test-refs-not-removed &&
> +	git commit --amend --fixup first &&
> +
> +	git rev-parse first second third tip no-conflict-branch >expect-oids &&
> +
> +	(
> +		set_cat_todo_editor &&
> +		test_must_fail git rebase -i --update-refs base >todo.raw &&
> +		sed -e "/^update-ref/d" <todo.raw >todo
> +	) &&
> +	(
> +		set_replace_editor todo &&
> +		git rebase -i --update-refs base
> +	) &&
> +
> +	# Ensure refs are not deleted and their OIDs have not changed
> +	git rev-parse first second third tip no-conflict-branch >actual-oids &&
> +	test_cmp expect-oids actual-oids
> +'
> +
> +test_expect_success '--update-refs: all update-ref lines removed, then some re-added' '
> +	git checkout -b test-refs-not-removed2 no-conflict-branch &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~3 &&
> +	git branch -f third HEAD~1 &&
> +	git branch -f tip &&
> +
> +	test_commit test-refs-not-removed2 &&
> +	git commit --amend --fixup first &&
> +
> +	git rev-parse first second third >expect-oids &&
> +
> +	(
> +		set_cat_todo_editor &&
> +		test_must_fail git rebase -i \
> +			--autosquash --update-refs \
> +			base >todo.raw &&
> +		sed -e "/^update-ref/d" <todo.raw >todo
> +	) &&
> +
> +	# Add a break to the end of the todo so we can edit later
> +	echo "break" >>todo &&
> +
> +	(
> +		set_replace_editor todo &&
> +		git rebase -i --autosquash --update-refs base &&
> +		echo "update-ref refs/heads/tip" >todo &&
> +		git rebase --edit-todo &&
> +		git rebase --continue
> +	) &&
> +
> +	# Ensure first/second/third are unchanged, but tip is updated
> +	git rev-parse first second third >actual-oids &&
> +	test_cmp expect-oids actual-oids &&
> +	test_cmp_rev HEAD tip
> +'
> +
> +test_expect_success '--update-refs: --edit-todo with no update-ref lines' '
> +	git checkout -b test-refs-not-removed3 no-conflict-branch &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~3 &&
> +	git branch -f third HEAD~1 &&
> +	git branch -f tip &&
> +
> +	test_commit test-refs-not-removed3 &&
> +	git commit --amend --fixup first &&
> +
> +	git rev-parse first second third tip no-conflict-branch >expect-oids &&
> +
> +	(
> +		set_cat_todo_editor &&
> +		test_must_fail git rebase -i \
> +			--autosquash --update-refs \
> +			base >todo.raw &&
> +		sed -e "/^update-ref/d" <todo.raw >todo
> +	) &&
> +
> +	# Add a break to the beginning of the todo so we can resume with no
> +	# update-ref lines
> +	echo "break" >todo.new &&
> +	cat todo >>todo.new &&
> +
> +	(
> +		set_replace_editor todo.new &&
> +		git rebase -i --autosquash --update-refs base &&
> +
> +		# Make no changes when editing so update-refs is still empty
> +		cat todo >todo.new &&
> +		git rebase --edit-todo &&
> +		git rebase --continue
> +	) &&
> +
> +	# Ensure refs are not deleted and their OIDs have not changed
> +	git rev-parse first second third tip no-conflict-branch >actual-oids &&
> +	test_cmp expect-oids actual-oids
> +'
> +
>   test_expect_success '--update-refs: check failed ref update' '
>   	git checkout -B update-refs-error no-conflict-branch &&
>   	git branch -f base HEAD~4 &&
> --
> 2.38.0
> 
