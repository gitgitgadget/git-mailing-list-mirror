Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF00C64ED6
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 20:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBIUvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 15:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBIUum (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 15:50:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9153E6A30A
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 12:50:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ba1so3125863wrb.5
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwGseBffcQ40nwLeJ52JI8dbnIQXUevQOdtXsdqQuz0=;
        b=dTcRTaDD5H6KP/coExa0RYeP2OR4u0MGhjuC8AOR945WgzdyXbswKYrt1NpcF1NTUy
         J2OAgb5l8m9EMsDXLfsLoQ6lmHlzD/ediZ+9LVxA5APAgeq66k5tE7NaSXG9Cs/1TSg+
         /It5Aws0sKsXt7vWdKZ+oW6WR42LyPDHLBzhiQidvZFXHtAcQUjxdnWtzSV2t2VWTTov
         +QsLCj5AXQIen2UBT9WZUwrZ8e8m1R6CkD/XpGnQnRaK5RyZlTYyiVwdzRAQDWRXLKzC
         SVz7EI71I6VXmGNkhluEONpxTtISwcY/65YBdink8VUI3US6gjoQCRCfdblw2A3GdGEo
         w77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwGseBffcQ40nwLeJ52JI8dbnIQXUevQOdtXsdqQuz0=;
        b=pfLKA9C4kX9KOVVgm4866nmCteup4C6vEHkumuzWzQTkYcvrPRXOL4xBLIbBlYSRCK
         jhDmNTg3AI7aRwsvR2wc90T+37hsUsa6OY7X644enysBswlc0x+9NHRCSrx7AH3E1JuC
         GKo0PJh2Nq+kQ/nYSvyQtccPVTxT79W/MEIxmBT1qLaenXmKNo6AHlugN2e4gVdT3Rbl
         F72EX3WU20GE9CkP2XFv1pzKxoBRvsnP2f7NJ0MDheMjCQgUPpn4zUM8pln4tl/q8rTh
         lkwE9eUg1C4RhJ5DrrvgX9VNgy56rXjQDc1ivFoOEO7EAwIemIw6ypdyJgGCfOv4sIzA
         NrYA==
X-Gm-Message-State: AO0yUKVtvCSOhnB+iox78aJGfKE3e5PTR4kGU3VgruVAfR4lachOZTJa
        cOoX6YcJqJevUAxUomjhbEnNaXis6V8=
X-Google-Smtp-Source: AK7set/pCqRrh7EO7Bogcdq7Frk1lddDWR2i967YFk6WL+mrvP6g3QOS9/NyTUSxS595esOT7dhkhg==
X-Received: by 2002:adf:f288:0:b0:2bd:e87c:e831 with SMTP id k8-20020adff288000000b002bde87ce831mr14136585wro.69.1675975838881;
        Thu, 09 Feb 2023 12:50:38 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id t9-20020adff609000000b002c3ea68c58asm2060471wrp.1.2023.02.09.12.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 12:50:38 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0e1858f1-8772-30eb-b6c9-5b0854d082a5@dunelm.org.uk>
Date:   Thu, 9 Feb 2023 20:50:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 0/6] submodule: parallelize diff
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com, phillip.wood123@gmail.com
References: <20230207181706.363453-1-calvinwan@google.com>
 <20230209000212.1892457-1-calvinwan@google.com>
In-Reply-To: <20230209000212.1892457-1-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 09/02/2023 00:02, Calvin Wan wrote:
> Original cover letter for context:
> https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/
> 
> This reroll contains stylistic changes suggested by Avar and Phillip,
> and includes a range-diff below.
> 
> Calvin Wan (6):
>    run-command: add duplicate_output_fn to run_processes_parallel_opts
>    submodule: strbuf variable rename
>    submodule: move status parsing into function
>    submodule: refactor is_submodule_modified()
>    diff-lib: refactor out diff_change logic
>    diff-lib: parallelize run_diff_files for submodules
> 
>   Documentation/config/submodule.txt |  12 ++
>   diff-lib.c                         | 133 +++++++++++----
>   run-command.c                      |  16 +-
>   run-command.h                      |  25 +++
>   submodule.c                        | 266 ++++++++++++++++++++++++-----
>   submodule.h                        |   9 +
>   t/helper/test-run-command.c        |  20 +++
>   t/t0061-run-command.sh             |  39 +++++
>   t/t4027-diff-submodule.sh          |  31 ++++
>   t/t7506-status-submodule.sh        |  25 +++
>   10 files changed, 497 insertions(+), 79 deletions(-)
> 
> Range-diff against v7:
> 6:  0d35fcc38d < -:  ---------- diff-lib: refactor match_stat_with_submodule
> 7:  fd1eec974d ! 6:  bb25dadbe5 diff-lib: parallelize run_diff_files for submodules
>      @@ diff-lib.c: static int check_removed(const struct index_state *istate, const str
>       +				     unsigned *ignore_untracked)
>        {
>        	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
>      - 	struct diff_flags orig_flags;
>      +-	if (S_ISGITLINK(ce->ce_mode)) {
>      +-		struct diff_flags orig_flags = diffopt->flags;
>      +-		if (!diffopt->flags.override_submodule_config)
>      +-			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
>      +-		if (diffopt->flags.ignore_submodules)
>      +-			changed = 0;
>      +-		else if (!diffopt->flags.ignore_dirty_submodules &&
>      +-			 (!changed || diffopt->flags.dirty_submodules))
>      ++	struct diff_flags orig_flags;
>       +	int defer = 0;
>      -
>      - 	if (!S_ISGITLINK(ce->ce_mode))
>      --		return changed;
>      ++
>      ++	if (!S_ISGITLINK(ce->ce_mode))
>       +		goto ret;
>      -
>      - 	orig_flags = diffopt->flags;
>      - 	if (!diffopt->flags.override_submodule_config)
>      -@@ diff-lib.c: static int match_stat_with_submodule(struct diff_options *diffopt,
>      - 		goto cleanup;
>      - 	}
>      - 	if (!diffopt->flags.ignore_dirty_submodules &&
>      --	    (!changed || diffopt->flags.dirty_submodules))
>      --		*dirty_submodule = is_submodule_modified(ce->name,
>      ++
>      ++	orig_flags = diffopt->flags;
>      ++	if (!diffopt->flags.override_submodule_config)
>      ++		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
>      ++	if (diffopt->flags.ignore_submodules) {
>      ++		changed = 0;
>      ++		goto cleanup;
>      ++	}
>      ++	if (!diffopt->flags.ignore_dirty_submodules &&
>       +	    (!changed || diffopt->flags.dirty_submodules)) {
>       +		if (defer_submodule_status && *defer_submodule_status) {
>       +			defer = 1;
>       +			*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
>       +		} else {
>      -+			*dirty_submodule = is_submodule_modified(ce->name,
>      - 					 diffopt->flags.ignore_untracked_in_submodules);
>      + 			*dirty_submodule = is_submodule_modified(ce->name,
>      +-								 diffopt->flags.ignore_untracked_in_submodules);
>      +-		diffopt->flags = orig_flags;
>      ++					 diffopt->flags.ignore_untracked_in_submodules);
>       +		}
>      -+	}
>      - cleanup:
>      - 	diffopt->flags = orig_flags;
>      + 	}
>      ++cleanup:
>      ++	diffopt->flags = orig_flags;
>       +ret:
>       +	if (defer_submodule_status)

The idea behind the suggestion to drop the previous patch from the last 
version was to stop refactoring the if block and get away from having 
these labels. Can't you just add the "if (defer_submodule_status && 
...)" into the existing code?

Best Wishes

Phillip

>       +		*defer_submodule_status = defer;
>      @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
>        				       changed, istate, ce))
>        			continue;
>        	}
>      -+	if (submodules.nr > 0) {
>      -+		int parallel_jobs;
>      -+		if (git_config_get_int("submodule.diffjobs", &parallel_jobs))
>      ++	if (submodules.nr) {
>      ++		unsigned long parallel_jobs;
>      ++		struct string_list_item *item;
>      ++
>      ++		if (git_config_get_ulong("submodule.diffjobs", &parallel_jobs))
>       +			parallel_jobs = 1;
>       +		else if (!parallel_jobs)
>       +			parallel_jobs = online_cpus();
>      -+		else if (parallel_jobs < 0)
>      -+			die(_("submodule.diffjobs cannot be negative"));
>       +
>       +		if (get_submodules_status(&submodules, parallel_jobs))
>       +			die(_("submodule status failed"));
>      -+		for (size_t i = 0; i < submodules.nr; i++) {
>      -+			struct submodule_status_util *util = submodules.items[i].util;
>      ++		for_each_string_list_item(item, &submodules) {
>      ++			struct submodule_status_util *util = item->util;
>       +
>       +			if (diff_change_helper(&revs->diffopt, util->newmode,
>       +				       util->dirty_submodule, util->changed,
>      @@ submodule.c: int submodule_touches_in_range(struct repository *r,
>       +	int result;
>       +
>       +	struct string_list *submodule_names;
>      -+
>      -+	/* Pending statuses by OIDs */
>      -+	struct status_task **oid_status_tasks;
>      -+	int oid_status_tasks_nr, oid_status_tasks_alloc;
>       +};
>       +
>        struct submodule_parallel_fetch {
>      @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untrack
>       +	struct status_task *task = task_cb;
>       +
>       +	sps->result = 1;
>      -+	strbuf_addf(err,
>      -+	    _(status_porcelain_start_error),
>      -+	    task->path);
>      ++	strbuf_addf(err, _(STATUS_PORCELAIN_START_ERROR), task->path);
>       +	return 0;
>       +}
>       +
>      @@ submodule.c: unsigned is_submodule_modified(const char *path, int ignore_untrack
>       +
>       +	if (retvalue) {
>       +		sps->result = 1;
>      -+		strbuf_addf(err,
>      -+		    _(status_porcelain_fail_error),
>      -+		    task->path);
>      ++		strbuf_addf(err, _(STATUS_PORCELAIN_FAIL_ERROR), task->path);
>       +	}
>       +
>       +	parse_status_porcelain_strbuf(&task->out,
