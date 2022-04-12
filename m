Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF6CC433FE
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 09:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbiDLKAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357499AbiDLJtT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 05:49:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8706472D
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 01:55:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l7so30502747ejn.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JQQY3d7Wvb3hkato2Q+mTrgt7xfnBkcsdkE8Q7mp0Zk=;
        b=nNkct8MTIYi/8CqvSBnHJQATs8ZXpjoqnLx7VzowglbNnw6foJtfCgUFts/C185pQl
         ZY8M+f3NMIT06VQgT+Cv8R7da0hBXGTlNRghbXV7e2+Xtw9Ca0OVJNtLPo9yevooi21h
         yAz4bcqzqis88i2BJVUo9wZMlS9kRW/D/JCDUtTjhwG6SYenfzoDQJNgyBwwhOcacyT0
         M8e4mD4hDZDBBO+G4yaR/kUz22PNbPB/4IfdEUvsGk6tsK+duT1iDJoDCv1OmeQ/it12
         zyZyDXueRSc/kL3buSKfGokyOfL2xne/bfo4/PsC5p78TaeHMN6nAFFquTBMitVcf612
         lRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JQQY3d7Wvb3hkato2Q+mTrgt7xfnBkcsdkE8Q7mp0Zk=;
        b=3pGcvJFYJoffU1BcAtj3IQaPYKBPF5Zpp+AovL0a4ngu+QkqeVmK2tEaWUUss0iMTB
         iICCOS07NIKQfjhp8bWG1yEUJXsOfF8DM3ApM9ZXVRPj6/Zprw7bbWUq2RlKjP5xXhi1
         Qg/loq8hXTl2/SAc9obOQV9DidbnETwHcapWiZKWiynmXNOYY+jbm+ZR8Ue1zz4jiszU
         KsSGrQw2B600xnYUdK8+U/0sGQdDuU1d7jxRn1wR6nyoIMJnPY58MjL5O2iLemN5Mu/3
         tTLmmWFESV5afYUXuLSDFEEyMeQF8hrazAGey9RwCMC9ivrXhIbLfcbyYtPtxkvZGkst
         tIOw==
X-Gm-Message-State: AOAM5338g/f+w57XnHoIHidX+/tOyYeN3coM/XZuJ8NgVgUaQC4LUA+5
        H/DJ5urHdb8byzunFY9bE4g=
X-Google-Smtp-Source: ABdhPJzoIAmL5QCRVqvP4wodUflp9/QNOxzwe5BU4n3aIjwC9kjw4MOWbwgDyYJUvRk3G57UDY0x4w==
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr33544280ejc.762.1649753746320;
        Tue, 12 Apr 2022 01:55:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709064e9500b006e8973a14d0sm1992498eju.174.2022.04.12.01.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:55:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neCJN-004XNQ-11;
        Tue, 12 Apr 2022 10:55:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] git-log: add a --since=... --as-filter option
Date:   Tue, 12 Apr 2022 10:47:15 +0200
References: <xmqqtub3moa0.fsf@gitster.g> <xmqqv8vkpara.fsf@gitster.g>
 <YlCiqgO6rL908Zsi@vmiklos.hu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YlCiqgO6rL908Zsi@vmiklos.hu>
Message-ID: <220412.86pmlmhe9a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 08 2022, Miklos Vajna wrote:

> On Thu, Apr 07, 2022 at 07:30:33PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> As a single-shot change, "--since-as-filter" is certainly an easy to
>> explain approach of least resistance.
>> 
>> But when viewed from a higher level as a general design problem, I
>> am unsure if it is a good direction to go in.
>> 
>> Giving "--since" the "as-filter" variant sets a precedent, and
>> closes the door for a better UI that we can extend more generally
>> without having to add "--X-as-filter" for each and every conceivable
>> "--X" that is a traversal stopper into a filtering kind.
>
> I like the idea of doing this mode as "--since=... --as-filter". I can
> still implement it just for --since=... initially, but it can be
> extended for other flags as well in the future if there is a need.

Yes, I think this is much better.

>> If we pursue the possibility further, perhaps we may realize that
>> there isn't much room for us to add too many "traversal stoppers" in
>> the future, in which case giving "as-filter" to a very limited few
>> traversal stoppers may not be too bad.  I just do not think we have
>> explored that enough to decide that "--since-as-filter" is a good UI
>
> My understanding is that get_revision_1() has a special-case for the max
> age case to be a "traversal stopper", and all other options are just 
> filtering in limit_range(). But perhaps I missed something.
> [...]
>  Documentation/rev-list-options.txt |  5 +++++
>  revision.c                         | 14 +++++++++++--
>  revision.h                         |  1 +
>  t/t4217-log-limit.sh               | 32 ++++++++++++++++++++++++++++++
>  4 files changed, 50 insertions(+), 2 deletions(-)
>  create mode 100755 t/t4217-log-limit.sh
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index fd4f4e26c9..8565299264 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -25,6 +25,11 @@ ordering and formatting options, such as `--reverse`.
>  --after=<date>::
>  	Show commits more recent than a specific date.
>  
> +--as-filter::
> +	When combined with `--since=<date>`, show all commits more recent than
> +	a specific date. This visits all commits in the range, rather than stopping at
> +	the first commit which is older than a specific date.

I wonder if we should be more future-proof here and say that we'll run
anything as a filter, and that --since is the one option currently
affected.

But maybe there's no reason to do so...

In any case these docs are inaccurate because they cover --since, but if
you check revision.c we'll set "max_age" on other options too
(synonyms?).

All in all I wonder if this wouldn't be much more understandable if we
advertised is as another option to do "HISTORY SIMPLIFICATION", which
looking at e.g. get_commit_action() and "prune" is kind of what we're
doing with the existing --since behavior.

>  --until=<date>::
>  --before=<date>::
>  	Show commits older than a specific date.
> diff --git a/revision.c b/revision.c
> index 7d435f8048..41ea72e516 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1440,6 +1440,9 @@ static int limit_list(struct rev_info *revs)
>  		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
>  		    !revs->line_level_traverse)
>  			continue;
> +		if (revs->max_age != -1 && revs->as_filter && (commit->date < revs->max_age) &&
> +		    !revs->line_level_traverse)
> +			continue;
>  		date = commit->date;
>  		p = &commit_list_insert(commit, p)->next;
>  
> @@ -1838,6 +1841,7 @@ void repo_init_revisions(struct repository *r,
>  	revs->dense = 1;
>  	revs->prefix = prefix;
>  	revs->max_age = -1;
> +	revs->as_filter = 0;
>  	revs->min_age = -1;
>  	revs->skip_count = -1;
>  	revs->max_count = -1;
> @@ -2218,6 +2222,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if ((argcount = parse_long_opt("since", argv, &optarg))) {
>  		revs->max_age = approxidate(optarg);
>  		return argcount;
> +	} else if (!strcmp(arg, "--as-filter")) {
> +		revs->as_filter = 1;
> +		return argcount;
>  	} else if ((argcount = parse_long_opt("after", argv, &optarg))) {
>  		revs->max_age = approxidate(optarg);
>  		return argcount;
> @@ -3365,7 +3372,7 @@ static void explore_walk_step(struct rev_info *revs)
>  	if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
>  		record_author_date(&info->author_date, c);
>  
> -	if (revs->max_age != -1 && (c->date < revs->max_age))
> +	if (revs->max_age != -1 && !revs->as_filter && (c->date < revs->max_age))
>  		c->object.flags |= UNINTERESTING;
>  
>  	if (process_parents(revs, c, NULL, NULL) < 0)
> @@ -3862,6 +3869,9 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>  	if (revs->min_age != -1 &&
>  	    comparison_date(revs, commit) > revs->min_age)
>  			return commit_ignore;
> +	if (revs->max_age != -1 && revs->as_filter &&
> +	    comparison_date(revs, commit) < revs->max_age)
> +			return commit_ignore;
>  	if (revs->min_parents || (revs->max_parents >= 0)) {
>  		int n = commit_list_count(commit->parents);
>  		if ((n < revs->min_parents) ||
> @@ -4019,7 +4029,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
>  		 * that we'd otherwise have done in limit_list().
>  		 */
>  		if (!revs->limited) {
> -			if (revs->max_age != -1 &&
> +			if (revs->max_age != -1 && !revs->as_filter &&
>  			    comparison_date(revs, commit) < revs->max_age)
>  				continue;

I think it's good to do this as a general mechanism, but if you now
remove the "max_age" field from "struct rev_info" and:

	make -k

You'll see a bunch of callers who check "max_age" outside of revision.c,
since those will accept these revision options are they doing the right
thing now too?

...

> diff --git a/revision.h b/revision.h
> index 5bc59c7bfe..fe37ebd83d 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -263,6 +263,7 @@ struct rev_info {
>  	int skip_count;
>  	int max_count;
>  	timestamp_t max_age;
> +	int as_filter;
>  	timestamp_t min_age;
>  	int min_parents;
>  	int max_parents;
> diff --git a/t/t4217-log-limit.sh b/t/t4217-log-limit.sh
> new file mode 100755
> index 0000000000..a66830e3d7
> --- /dev/null
> +++ b/t/t4217-log-limit.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +
> +test_description='git log with filter options limiting the output'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +GIT_TEST_COMMIT_GRAPH=0
> +GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
> +
> +test_expect_success 'setup test' '
> +	git init &&
> +	echo a > file &&
> +	git add file &&
> +	GIT_COMMITTER_DATE="2022-02-01 0:00" git commit -m init &&
> +	echo a >> file &&
> +	git add file &&
> +	GIT_COMMITTER_DATE="2021-01-01 0:00" git commit -m second &&
> +	echo a >> file &&
> +	git add file &&
> +	GIT_COMMITTER_DATE="2022-03-01 0:00" git commit -m third
> +'
> +
> +test_expect_success 'git log --since-as-filter' '
> +	git log --since="2022-01-01" --as-filter --pretty="format:%s" > actual &&
> +	test_i18ngrep init actual &&
> +	! test_i18ngrep second actual &&
> +	test_i18ngrep third actual
> +'
> +
> +test_done

In any case we should have tests for those callers, i.e. blame, bundle
etc.
