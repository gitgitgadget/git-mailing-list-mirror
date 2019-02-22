Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238D51F453
	for <e@80x24.org>; Fri, 22 Feb 2019 12:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfBVMSI (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 07:18:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36697 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVMSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 07:18:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so1782694wmj.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 04:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AiDBwavqkUsd7J7O3m2oe1J/d/10vhMLom4d0K0JLFs=;
        b=PXX0uCscSeccv9YzmoJ/H1vsFGayc9Uad5UbLgVdGXdFZiMBphmvFVM+WN0WV7xiu8
         2VR43bO0SIzzF+kDxJgryLk+5QhmTWgMDPNnSIxlreUkhyduzy8wDLIVTeaRujhiKWa1
         22A1tyM7gYskNlIzl1fcaQsS5MQsJY0RByw9XAJz9V+f5a2/wHscRc9zTaY5z/KG0ofg
         BjuAEOWuDeWrmKIu1hD6t0rkB7aYib1BF+m5oXtUz8BEk52eTxe5SKuO9pnmLpTmD9wA
         OUPvcR9Rl7+0FzKXrmIuxFZrs7d3T4OzQORmb+8jHWxWJqvSUvs2eMpkCnCa6E90OAEV
         YWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AiDBwavqkUsd7J7O3m2oe1J/d/10vhMLom4d0K0JLFs=;
        b=c9f0Af6uSfOi1pHZWWGU8Z5Dk+vP0ZChN5XgBVJqV8xFHlbBTlKpiNjLXkSVgC1nFp
         tFoXZw/PaWt+u9NMqts+ni39LwhMkFVAk6gguXqIw6mYsvauYltugKDcVGjrA5vyYamP
         SyfbnkhcSQC6ZHN+dK7tLVdyTG4Od7jBF5K6IdJ/l//ni/WK2CU2Hg0Pz/JlwAxD6UVi
         G/Bw75mi3djVCTdfEyh45BLbaec/RGTc7X3KiAgmwqTHWtPpyuYntmJoFmRD78qQ7ho1
         dSa+j6sHKpesA5PPLUpp0DpK6MYGZkE4Fq+XTL6DufCezUQ6G5SlZQxCklow9L3iWFhO
         xwSg==
X-Gm-Message-State: AHQUAubbF1S8j6WmEKJg2SkSZRatP4FVcKc7gZ4kjH/cBi3xSGD89BnF
        IxxDfT8EQsxhr957wVka7k8=
X-Google-Smtp-Source: AHgI3IbeXirVH0Q4FJHEUCWseJnceJUclccV68RJg4ssuriwm33FoadjOOtFsJfWPUcSTfFhfdCHsg==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr2244022wmd.89.1550837884493;
        Fri, 22 Feb 2019 04:18:04 -0800 (PST)
Received: from [192.168.1.3] ([31.223.156.163])
        by smtp.gmail.com with ESMTPSA id y22sm1267608wmj.6.2019.02.22.04.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:18:03 -0800 (PST)
Subject: Re: [PATCH v5 03/10] add-interactive.c: implement list_modified
To:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
 <pull.103.v5.git.gitgitgadget@gmail.com>
 <8790ffaa394603279927f9cd4c80f1d06bb5f976.1550662887.git.gitgitgadget@gmail.com>
 <xmqqtvgxt0ze.fsf@gitster-ct.c.googlers.com>
 <xmqqef80ubsu.fsf@gitster-ct.c.googlers.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <d9fda542-3a40-068e-280f-a1ea9f678b0e@gmail.com>
Date:   Fri, 22 Feb 2019 13:18:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqef80ubsu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 21-Feb-19 9:27 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> A few things I missed in the previous message.
>
>>> +	for (i = 0; i < stat.nr; i++) {
>>> +		struct file_stat *entry;
>>> +		const char *name = stat.files[i]->name;
>>> +		unsigned int hash = strhash(name);
>>> +
>>> +		entry = hashmap_get_from_hash(&s->file_map, hash, name);
>>> +		if (!entry) {
>>> +			FLEX_ALLOC_STR(entry, name, name);
>>> +			hashmap_entry_init(entry, hash);
>>> +			hashmap_add(&s->file_map, entry);
>>> +		}
>> The path may already be in the collection_status.file_map from the
>> previous run when "diff-index --cached" is run, in which case we avoid
>> adding it twice, which makes sense.
>>
>>> +		if (s->phase == WORKTREE) {
>>> +			entry->worktree.added = stat.files[i]->added;
>>> +			entry->worktree.deleted = stat.files[i]->deleted;
>>> +		} else if (s->phase == INDEX) {
>>> +			entry->index.added = stat.files[i]->added;
>>> +			entry->index.deleted = stat.files[i]->deleted;
>>> +		}
>> As the set of phases will not going to grow, not having the final
>> 'else BUG("phase is neither WORKTREE nor INDEX");' here is OK.
>>
>> But stepping back a bit, if we know we will not grow the phases,
>> then it may be simpler *and* equally descriptive to rename .phase
>> field to a boolean ".collecting_from_index" that literally means
>> "are we collecting from the index?" and that way we can also get rid
>> of the enum.
> ... so that this can become
>
> 	if (s->collecting_from_index) {
> 		entry->index.added = stat.files[i]->added;
> 		entry->index.deleted = stat.files[i]->deleted;
> 	} else {
> 		...
> 	}
>
> without "else if" and without having to worry about "what if phase
> is neither?".
>
>> Grep for "unborn" in the codebase.  It probably makes sense to call
>> it on_unborn_branch() instead.
>>
>> 	static int on_unborn_branch(void)
>> 	{
>> 		struct object_id oid;
>> 		return !!get_oid("HEAD", &oid);
>> 	}
>>
>> Eventually, the users of "unborn" in sequencer.c and builtin/reset.c
>> may want to share the implementation but the helper is so small that
>> we probably should not worry about it until the topic is done and
>> leave it for a later clean-up.
> And before such a clean-up happens, the implementation of the helper
> would want to be improved.  "Does 'rev-parse --verify HEAD' work?"
> was an easiest way to see if we are on an unborn branch from a
> script that works most of the time, but as we are rewriting it in C,
> we should use the more direct and correct API to see if "HEAD" is
> a symref, and if it points at a branch that does not yet exist,
> which is available in the refs API as resolve_ref_unsafe().
>
> One issue with lazy use of get_oid("HEAD") is that the function
> dwims and tries to find HEAD in common hierarchies like
> .git/refs/heads/HEAD etc. when .git/HEAD does not work.  We do not
> want such a dwimmery when seeing "are we on an unborn branch?".
>
>>> +static struct collection_status *list_modified(struct repository *r, const char *filter)
>>> +{
>>> +	int i = 0;
>>> +	struct collection_status *s = xcalloc(1, sizeof(*s));
>>> +	struct hashmap_iter iter;
>>> +	struct file_stat **files;
>>> +	struct file_stat *entry;
>>> +
>>> +	if (repo_read_index(r) < 0) {
>>> +		printf("\n");
>>> +		return NULL;
>>> +	}
>>> +
>>> +	s->reference = get_diff_reference();
>>> +	hashmap_init(&s->file_map, hash_cmp, NULL, 0);
>>> +
>>> +	collect_changes_worktree(s);
>>> +	collect_changes_index(s);
>>> +
>>> +	if (hashmap_get_size(&s->file_map) < 1) {
>>> +		printf("\n");
>>> +		return NULL;
>>> +	}
> The non-error codepath of this function does not do any output, but
> we see two "just emit newline" before returning NUULL to signal an
> error to the caller" in the above.  Such a printing from this level
> in the callchain (although we haven't seen callers of this function
> yet at this point in the series) is wrong.  Presumably, the caller,
> when it obtains a non-NULL 's', does something useful and maybe as a
> part of the "useful" thing prints something to the standard output.
> Then the caller is also responsible for handling a NULL return.  I.e.
> upon seeing such a NULL collection status, if the party that invoked
> the caller wants to see a single empty line for whatever reason (which
> in turn is a questionable practice, if you ask me, but at this point
> in the series we haven't seen what that invoker is doing, so for now
> lets assume that it is sane to want to see an empty line), the caller
> should do the putchar('\n').


Caller of list_modified is add_i_status in the later commit, and yes
it should definitely take care of this newline.
It should print it after calling list_modified *and* list_and_choose.

It is done in the same way in the Perl script:
sub status_cmd {
     list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
             list_modified());
     print "\n";
}

I overlooked this because print_modified (now list_modified) in
the previous iteration was equivalent of status command, and
everything was handled there.
After refactoring, I missed to pick up those printfs.


> Also, these two "return NULL" leaks 's'.


I guess I missed some more things. Thank you.


>
