Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7F8C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C52206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a17fmO0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgGWUVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:21:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50313 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 16:21:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 449307F100;
        Thu, 23 Jul 2020 16:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fVVSwcq43pQCPyzf6V+BZTgP0+Y=; b=a17fmO
        0H1hW++h53H+QfVagRraqW0K0incNvvEi6CxuGTOwuw83Hc7mmF4gLRVt1xoUlrY
        5eYBhaeoFrwYn1u/MGZoTms0UJHyfm5k3QebYaOP/ZS80t+jYLeQkeK0D+95p36v
        V1RCII8jTA8j5gEsGMEvLI0sA9j2d/TyBhwWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GrrV7KTcvV+d/ICb7NukE2UeRH/Y9C1a
        4iPgJlqVwaHTo8ePW/qCjXUaRdIDvWLVpjjebTKPu66Ekbg4ugHL7URA8/LI0edg
        XO0+SqrhQP5jtQ5Cf8PKxxj5dPkIcbJ4so/WYW+hbb+AEy2cibzPcEP79iTEcZhb
        Ri9ZZljc39E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A35F7F0FF;
        Thu, 23 Jul 2020 16:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A02A7F0FC;
        Thu, 23 Jul 2020 16:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 06/18] maintenance: add --task option
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <a09b1c16874c0fad6dd0df3ace573a2ffe34519e.1595527000.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 13:21:43 -0700
In-Reply-To: <a09b1c16874c0fad6dd0df3ace573a2ffe34519e.1595527000.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 23 Jul 2020
        17:56:28 +0000")
Message-ID: <xmqqimeeq8x4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 207337EA-CD22-11EA-B2FB-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 35b0be7d40..9204762e21 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -73,6 +73,10 @@ OPTIONS
>  --quiet::
>  	Do not report progress or other information over `stderr`.
>  
> +--task=<task>::
> +	If this option is specified one or more times, then only run the
> +	specified tasks in the specified order.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 2cd17398ec..c58dea6fa5 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -710,6 +710,7 @@ static const char * const builtin_maintenance_usage[] = {
>  static struct maintenance_opts {
>  	int auto_flag;
>  	int quiet;
> +	int tasks_selected;
>  } opts;
>  
>  static int run_write_commit_graph(void)
> @@ -804,20 +805,38 @@ typedef int maintenance_task_fn(void);
>  struct maintenance_task {
>  	const char *name;
>  	maintenance_task_fn *fn;
> -	unsigned enabled:1;
> +	int task_order;
> +	unsigned enabled:1,
> +		 selected:1;
>  };
>  
>  static struct maintenance_task *tasks[MAX_NUM_TASKS];
>  static int num_tasks;
>  
> +static int compare_tasks_by_selection(const void *a_, const void *b_)
> +{
> +	const struct maintenance_task *a, *b;
> +	a = (const struct maintenance_task *)a_;
> +	b = (const struct maintenance_task *)b_;
> +
> +	return b->task_order - a->task_order;
> +}

It forces the reader to know intimately that task_order *is*
selection order in order to understand why this is "tasks by
selection".  Perhaps rename the field to match what it is
(i.e. "selection_order")?

>  static int maintenance_run(void)
>  {
>  	int i;
>  	int result = 0;
>  
> +	if (opts.tasks_selected)
> +		QSORT(tasks, num_tasks, compare_tasks_by_selection);
> +
>  	for (i = 0; !result && i < num_tasks; i++) {
> -		if (!tasks[i]->enabled)
> +		if (opts.tasks_selected && !tasks[i]->selected)
> +			continue;
> +
> +		if (!opts.tasks_selected && !tasks[i]->enabled)
>  			continue;

I am not sure about this.  Even if the task <x> is disabled, if the
user says --task=<x>, it is run anyway?  Doesn't make an immediate
sense to me.

As I am bad at deciphering de Morgan, I'd find it easier to read if
the first were written more like so:

		if (!(!opts.tasks_selected || tasks[i]->selected))
			continue;

That is, "do not skip any when not limited, and do not skip the ones
that are selected when limited".  And that would easily extend to

		if (!tasks[i]->enabled ||
		    !(!opts.tasks_selected || tasks[i]->selected))
			continue;
> +
>  		result = tasks[i]->fn();
>  	}

> @@ -842,6 +861,44 @@ static void initialize_tasks(void)
>  	num_tasks++;
>  }
>  
> +static int task_option_parse(const struct option *opt,
> +			     const char *arg, int unset)
> +{
> +	int i;
> +	struct maintenance_task *task = NULL;
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (!arg || !strlen(arg)) {
> +		error(_("--task requires a value"));
> +		return 1;

There is no need to special case an empty string that was explicitly
given as the value---it will be caught as "'' is not a valid task".

> +	}
> +
> +	opts.tasks_selected++;
> +
> +	for (i = 0; i < MAX_NUM_TASKS; i++) {
> +		if (tasks[i] && !strcasecmp(tasks[i]->name, arg)) {
> +			task = tasks[i];
> +			break;
> +		}
> +	}
> +
> +	if (!task) {
> +		error(_("'%s' is not a valid task"), arg);
> +		return 1;
> +	}
> +
> +	if (task->selected) {
> +		error(_("task '%s' cannot be selected multiple times"), arg);
> +		return 1;
> +	}
> +
> +	task->selected = 1;
> +	task->task_order = opts.tasks_selected;
> +
> +	return 0;
> +}
