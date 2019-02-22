Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56551F453
	for <e@80x24.org>; Fri, 22 Feb 2019 11:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBVLfe (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 06:35:34 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35622 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVLfe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 06:35:34 -0500
Received: by mail-wm1-f50.google.com with SMTP id y15so1670568wma.0
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 03:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6uDRVvhsXLEwRfaaCnteg8NBMaI/fDiE1q50sHFjndc=;
        b=fO31ee5gyu2o5X3bYrZz+OqTHqzuG5SqVu/RN/oBQnfVdCzWhX0TEi/tUEE/K3UETD
         HaLtsv68jup0lq6W8E9UPukvRrUPJnfJ+hCwxpr37O7lWNYRwhVbDOfR7gB5M0VDhBKl
         wMNA8Oy3469GwbdIa0DM/nFJ2ZdX9Xrv3dWRqfPJGQMTdXXQxJHEyrtT9NU1dlk9UAxE
         dNl8ciJCJYwczCs3C46nnUdDoR5YQKxsovKgPwlwysUyBvrky3kO9x4+krqSKqg4b3lk
         ViwJKVBsfgWXrxYEhmJUJCa73sOKAylEyko8TVXWrk/BjIeyI8S3T3qJcfQu8z8PPD2Y
         ZUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6uDRVvhsXLEwRfaaCnteg8NBMaI/fDiE1q50sHFjndc=;
        b=aN98a+6Xd+0geiWYAAZUN2YKJZDXv3xicHO0SwpQIfMFUuBz+43sVQCr+Es59THJqB
         Yq/SHVvaNLE/BlT4vKkggCMp3VMgCXj1P0que9w1V7EmdcWx2oVQeW5uY87jKQZmRmzD
         jZMEH+uyp8pe0ZhCTgIc3wPiv6L3oVJ543aYdyH9gUH0ftmd9FkemVtM8loyPxYeNVJn
         8YC3qhyXSZIrO+ZyRb6PftLmbJJs09kieYhrARw1lc0/F0PwxDOnTS63GhZBDK4vbiHy
         KZUwk28+qkUg3XpoK5eToxE4hfJsoIRBV/OSTd2oSD2S2sw4bNV8SaWNu7rMHf91Sav3
         4PcQ==
X-Gm-Message-State: AHQUAuZvtC8JvMYCPzmfqmtkI5DaoLK5khRl+/oZ8XagSpJusmQ1J4Ue
        qkoDk4GGFAO3vlWPuA95YKk=
X-Google-Smtp-Source: AHgI3IajBpq4C5TLukkseWH6W8vMTG1lagQBqK04GODnuU41CJ7IUrFC4ktsx8q+zGD266h1wQqc4w==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr2248454wme.45.1550835331431;
        Fri, 22 Feb 2019 03:35:31 -0800 (PST)
Received: from [192.168.1.3] ([31.223.156.163])
        by smtp.gmail.com with ESMTPSA id d15sm3838409wrw.36.2019.02.22.03.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 03:35:30 -0800 (PST)
Subject: Re: [PATCH v5 03/10] add-interactive.c: implement list_modified
To:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
 <pull.103.v5.git.gitgitgadget@gmail.com>
 <8790ffaa394603279927f9cd4c80f1d06bb5f976.1550662887.git.gitgitgadget@gmail.com>
 <xmqqtvgxt0ze.fsf@gitster-ct.c.googlers.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <750a1319-bf00-9cd3-088c-dae7645ffa8a@gmail.com>
Date:   Fri, 22 Feb 2019 12:35:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvgxt0ze.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 21-Feb-19 8:06 PM, Junio C Hamano wrote:
> "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/add-interactive.c b/add-interactive.c
>> new file mode 100644
>> index 0000000000..7d096207d4
>> --- /dev/null
>> +++ b/add-interactive.c
>> @@ -0,0 +1,188 @@
>> +#include "cache.h"
>> +#include "commit.h"
>> +#include "color.h"
>> +#include "config.h"
>> +#include "diffcore.h"
>> +#include "revision.h"
>> +
>> +enum collection_phase {
>> +	WORKTREE,
>> +	INDEX
>> +};
>> +
>> +struct file_stat {
>> +	struct hashmap_entry ent;
>> +	struct {
>> +		uintmax_t added, deleted;
>> +	} index, worktree;
>> +	char name[FLEX_ARRAY];
>> +};
>> +
>> +struct collection_status {
>> +	enum collection_phase phase;
>> +
>> +	const char *reference;
>> +	struct pathspec pathspec;
>> +
>> +	struct hashmap file_map;
>> +};
>> +
>> +static int hash_cmp(const void *unused_cmp_data, const void *entry,
>> +		    const void *entry_or_key, const void *keydata)
>> +{
>> +	const struct file_stat *e1 = entry, *e2 = entry_or_key;
>> +	const char *name = keydata ? keydata : e2->name;
>> +
>> +	return strcmp(e1->name, name);
>> +}
> This one is used with hashmap API, which gives unfortunate name
> "cmp_fn" to its callback, which does not necessarily need to
> compare.  It only needs to say "are they different (yes/no)?"
> without having to order them (iow, it would not break anything if
> the above is changed to return strcmp(name, e1->name)).
>
> Rather than naming the callback after the name of the API that calls
> it (i.e. "hash"), it would make it more descriptive if it were named
> after what is being compared for equality, in this case, pathname.
> Perhaps "pathname_equal()" or something?
>
>> +static int alphabetical_cmp(const void *a, const void *b)
>> +{
>> +	struct file_stat *f1 = *((struct file_stat **)a);
>> +	struct file_stat *f2 = *((struct file_stat **)b);
>> +
>> +	return strcmp(f1->name, f2->name);
>> +}
> This one is used with qsort(), and there are two things you may want
> the function name to tell the readers.  "what is compared" and "how
> it is compared".  Alphabetical is a bit fuzzy (different people sort
> "a.txt", "A.txt", and "b.txt" in different order) and it gives a
> piece of information of secondary importance (i.e. it only starts to
> make sense after you know you are ordering pathnames), so perhaps
> "pathname_cmp()" or something may be a better name.
>
>> +
>> +static void collect_changes_cb(struct diff_queue_struct *q,
>> +			       struct diff_options *options,
>> +			       void *data)
>> +{
>> +	struct collection_status *s = data;
>> +	struct diffstat_t stat = { 0 };
>> +	int i;
>> +
>> +	if (!q->nr)
>> +		return;
>> +
>> +	compute_diffstat(options, &stat);
> Remember what I said on patch 01/10?  This callback function is
> designed to take arbitrary diff_queue_struct q as its parameter and
> work on it, but compute_diffstat() is misdesigned and cannot work on
> anything but the singleton diff_queued_diff, which is an impedance
> mismatch that can easily be corrected by going back to 01/10 and
> fixing it.
>
>> +	for (i = 0; i < stat.nr; i++) {
>> +		struct file_stat *entry;
>> +		const char *name = stat.files[i]->name;
>> +		unsigned int hash = strhash(name);
>> +
>> +		entry = hashmap_get_from_hash(&s->file_map, hash, name);
>> +		if (!entry) {
>> +			FLEX_ALLOC_STR(entry, name, name);
>> +			hashmap_entry_init(entry, hash);
>> +			hashmap_add(&s->file_map, entry);
>> +		}
> The path may already be in the collection_status.file_map from the
> previous run when "diff-index --cached" is run, in which case we avoid
> adding it twice, which makes sense.
>
>> +		if (s->phase == WORKTREE) {
>> +			entry->worktree.added = stat.files[i]->added;
>> +			entry->worktree.deleted = stat.files[i]->deleted;
>> +		} else if (s->phase == INDEX) {
>> +			entry->index.added = stat.files[i]->added;
>> +			entry->index.deleted = stat.files[i]->deleted;
>> +		}
> As the set of phases will not going to grow, not having the final
> 'else BUG("phase is neither WORKTREE nor INDEX");' here is OK.
>
> But stepping back a bit, if we know we will not grow the phases,
> then it may be simpler *and* equally descriptive to rename .phase
> field to a boolean ".collecting_from_index" that literally means
> "are we collecting from the index?" and that way we can also get rid
> of the enum.
>
>> +	}
>> +}
>> +
>> +static void collect_changes_worktree(struct collection_status *s)
>> +{
>> +	struct rev_info rev;
>> +
>> +	s->phase = WORKTREE;
>> +
>> +	init_revisions(&rev, NULL);
>> +	setup_revisions(0, NULL, &rev, NULL);
>> +
>> +	rev.max_count = 0;
> The convention to (ab)use the max_count field to specify the
> unmerged stage, against which the working tree file is compared for
> an unmerged path, is one of the older quirks of the run_diff_files()
> API.  "git diff-files" itself when running cmd_diff_files() leaves
> rev.max_count untouched to get a normal output (as opposed to the
> case when it is told to do --base/--ours/--theirs), so it ends up
> passing -1 in this field in such a case.
>
> This explicit assignment to 0 must be explained with in-code comment
> why we want to do so.
>
>> +	rev.diffopt.flags.ignore_dirty_submodules = 1;
> OK, this matches what "sub list_modified" does.
>
>> +	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>> +	rev.diffopt.format_callback = collect_changes_cb;
>> +	rev.diffopt.format_callback_data = s;
>> +	run_diff_files(&rev, 0);
>> +}
>> +
>> +static void collect_changes_index(struct collection_status *s)
>> +{
>> +	struct rev_info rev;
>> +	struct setup_revision_opt opt = { 0 };
>> +
>> +	s->phase = INDEX;
>> +
>> +	init_revisions(&rev, NULL);
>> +	opt.def = s->reference;
>> +	setup_revisions(0, NULL, &rev, &opt);
>> +
>> +	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>> +	rev.diffopt.format_callback = collect_changes_cb;
>> +	rev.diffopt.format_callback_data = s;
>> +
>> +	run_diff_index(&rev, 1);
>> +}
>> +
>> +static int is_inital_commit(void)
>> +{
>> +	struct object_id sha1;
>> +	if (get_oid("HEAD", &sha1))
> Using the newer get_oid() API (as opposed to get_sha1() API) while
> calling the variable that receives its result "sha1" is an
> oxymoron.  Most users of the API call it "oid", I think.
>
>> +		return 1;
>> +	return 0;
>> +}
> inital???
>
> Grep for "unborn" in the codebase.  It probably makes sense to call
> it on_unborn_branch() instead.
>
> 	static int on_unborn_branch(void)
> 	{
> 		struct object_id oid;
> 		return !!get_oid("HEAD", &oid);
> 	}
>
> Eventually, the users of "unborn" in sequencer.c and builtin/reset.c
> may want to share the implementation but the helper is so small that
> we probably should not worry about it until the topic is done and
> leave it for a later clean-up.
>
>> +static const char *get_diff_reference(void)
>> +{
>> +	if(is_inital_commit())
> Style.  Do not forget SP between "if" and "(".
>
>> +		return empty_tree_oid_hex();
>> +	return "HEAD";
>> +}
> Although probably
>
> 	return on_unborn_branch() ? empty_tree_oid_hex() : "HEAD";
>
> is clear enough.
>
>> +static void filter_files(const char *filter, struct hashmap *file_map,
>> +			 struct file_stat **files)
>> +{
>> +
>> +	for (int i = 0; i < hashmap_get_size(file_map); i++) {
> The declaration of "int i" there is one of the C99ism we do not use,
> IIRC ("git grep 'for (int ' \*.c" comes up empty).
>
>> +		struct file_stat *f = files[i];
>> +
>> +		if ((!(f->worktree.added || f->worktree.deleted)) &&
>> +		   (!strcmp(filter, "file-only")))
>> +				hashmap_remove(file_map, f, NULL);
>> +
>> +		if ((!(f->index.added || f->index.deleted)) &&
>> +		   (!strcmp(filter, "index-only")))
>> +				hashmap_remove(file_map, f, NULL);
>> +	}
> As part of the "interactive" machinery, obvious inefficiency in the
> code may not matter that much, but having to make exact string
> comparison for an unmodified parameter twice for each iteration does
> not look like showing a good taste.
>
> What is the earliest time the code can decide that it is asked to do
> a "file-only" filtering?  What I am trying to get at is that if we
> know early enough, instead of grabbing outputs from "diff-files" and
> "diff-index --cached", only to drop such entries that do not have
> output in "diff-files", we could run only "diff-index --cached"
> without spending any cycle to run "diff-files" in the first place.
>
> Even if such a reorganizing of the callflow is impossible (I didn't
> check), at least a micro optimization would be:
>
> 	int i;
> 	int file_only = !strcmp(filter, "file-only");
> 	int index_only = !strcmp(filter, "index-only");
>
> 	for (i = 0; i < hashmap_get_size(file_map), i++) {
> 		struct file_stat *f = files[i];
> 		if (file_only && !(f->worktree.added || f->worktree.deleted))
> 			hashmap_remove(file_map, f, NULL);
> 		...
> 	}
>
>
>
>> +}
>> +
>> +static struct collection_status *list_modified(struct repository *r, const char *filter)
>> +{
>> +	int i = 0;
>> +	struct collection_status *s = xcalloc(1, sizeof(*s));
>> +	struct hashmap_iter iter;
>> +	struct file_stat **files;
>> +	struct file_stat *entry;
>> +
>> +	if (repo_read_index(r) < 0) {
>> +		printf("\n");
>> +		return NULL;
>> +	}
>> +
>> +	s->reference = get_diff_reference();
>> +	hashmap_init(&s->file_map, hash_cmp, NULL, 0);
>> +
>> +	collect_changes_worktree(s);
>> +	collect_changes_index(s);
>> +
>> +	if (hashmap_get_size(&s->file_map) < 1) {
>> +		printf("\n");
>> +		return NULL;
>> +	}
>> +
>> +	hashmap_iter_init(&s->file_map, &iter);
>> +
>> +	files = xcalloc(hashmap_get_size(&s->file_map), sizeof(struct file_stat *));
>> +	while ((entry = hashmap_iter_next(&iter))) {
>> +		files[i++] = entry;
>> +	}
>> +	QSORT(files, hashmap_get_size(&s->file_map), alphabetical_cmp);
>> +
>> +	if (filter)
>> +		filter_files(filter, &s->file_map, files);
> Ahh, this answers my previous question, no?  The "filter" parameter
> given to this function will never change, so we could inspect it
> even before we call collect_chagnes_{worktree,index}().  If the
> caller says "I want to see only the paths that appear in the
> diff-files output", there is no need to call collect_changes_index()
> at all, no?


Yes, this answers your previous question. The "filter" parameter doesn't
change and we can collect specific changes right away instead of collecting
all of them and applying filter after.

Thanks for this one and all the other comments.


>
>> +
>> +	free(files);
>> +	return s;
>> +}
