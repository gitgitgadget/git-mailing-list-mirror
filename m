Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C913D1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfBUU1t (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:27:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41528 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfBUU1t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:27:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so19905273wrw.8
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+wEDhINMrZ2Lv2dfNP8xJWl2cRWxTXxdg7npZamNhg8=;
        b=OzRotvq6W3GtgNQNlcfSgQkAf11t5xXSD5Zr+yx8wDgW637HSLdi0a8LcTZZL4i/a4
         q8B1qeuKcWJ+mw/x2PdRXRv3pp7joco/vS52E7jvADzRFzfzigNcqwnBk7nR65mfZQU3
         Lx+w5ZhdnV7zqf9rRbTvnasWr4kzzeWL1lsiZ/oma9gEvqBp5Zj1df123quwhOIk0MtZ
         sjLII5iRvXqNgD5XRAdxwtHb0KzAXoyvLZ1KGP3jwkR2Ct4OELL7r/zqVOK9qnfga8PI
         KbHmYCHgO+pVG7z2Q3Zr0wAQcuw2J7TOIvOHTAhiJqyroYXJq4i6tEJO51prEIpA3pLq
         HFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+wEDhINMrZ2Lv2dfNP8xJWl2cRWxTXxdg7npZamNhg8=;
        b=mwu9NQIwgtog/mFNXj6NdUQJ+k2u5uVr8tDbOjupPtBrm3LqN4/wGLQGhrvzsTGMRV
         QHH9APSnJRC+vegXWGFtrnyV2ZyVSOj7gPZUIEkiBMZZwFmRzR0gPDAwgsJn//F25e7H
         UvlOU2EeB+orTnhDoXT6Afy04lDcYOi3ns0jEvPcB0xeajDlPiOpXMAZCO8ilrzRZxCv
         NuZ+g/CfgczGgrF00l/1zGsmJ3+Yi5pks8VrHUAV1C2FJdSlY01cad64jKmwloKgWVEO
         yJ+ZYzc8C0vAApM8PHh4TADlIc6CpC+IfO+jQqE2nF35vGAzSyvCvkTgrtrIBq/LiWoB
         4BAQ==
X-Gm-Message-State: AHQUAuZVDIrrrI7sxAlkatk8Wu6yLC+tAY1XikvIHkQV0mU3G7FkjVEy
        zjg1G4u47vMj38o6HyaZgUc=
X-Google-Smtp-Source: AHgI3IbVKWuujOOY42+b4BmpFoErCVbfmcfgDA2kF3oJnMvw6F9i432snm0wcZsWMz4P39k32nIsww==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr241188wrx.11.1550780866184;
        Thu, 21 Feb 2019 12:27:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x22sm8544604wmc.19.2019.02.21.12.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 12:27:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH v5 03/10] add-interactive.c: implement list_modified
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
        <8790ffaa394603279927f9cd4c80f1d06bb5f976.1550662887.git.gitgitgadget@gmail.com>
        <xmqqtvgxt0ze.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Feb 2019 12:27:45 -0800
In-Reply-To: <xmqqtvgxt0ze.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Feb 2019 11:06:45 -0800")
Message-ID: <xmqqef80ubsu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

A few things I missed in the previous message.

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
>
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
>
> As the set of phases will not going to grow, not having the final
> 'else BUG("phase is neither WORKTREE nor INDEX");' here is OK.
>
> But stepping back a bit, if we know we will not grow the phases,
> then it may be simpler *and* equally descriptive to rename .phase
> field to a boolean ".collecting_from_index" that literally means
> "are we collecting from the index?" and that way we can also get rid
> of the enum.

... so that this can become

	if (s->collecting_from_index) {
		entry->index.added = stat.files[i]->added;
		entry->index.deleted = stat.files[i]->deleted;
	} else {
		...
	}

without "else if" and without having to worry about "what if phase
is neither?".

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

And before such a clean-up happens, the implementation of the helper
would want to be improved.  "Does 'rev-parse --verify HEAD' work?"
was an easiest way to see if we are on an unborn branch from a
script that works most of the time, but as we are rewriting it in C,
we should use the more direct and correct API to see if "HEAD" is
a symref, and if it points at a branch that does not yet exist,
which is available in the refs API as resolve_ref_unsafe().

One issue with lazy use of get_oid("HEAD") is that the function
dwims and tries to find HEAD in common hierarchies like
.git/refs/heads/HEAD etc. when .git/HEAD does not work.  We do not
want such a dwimmery when seeing "are we on an unborn branch?".

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

The non-error codepath of this function does not do any output, but
we see two "just emit newline" before returning NUULL to signal an
error to the caller" in the above.  Such a printing from this level
in the callchain (although we haven't seen callers of this function
yet at this point in the series) is wrong.  Presumably, the caller, 
when it obtains a non-NULL 's', does something useful and maybe as a
part of the "useful" thing prints something to the standard output.
Then the caller is also responsible for handling a NULL return.  I.e.
upon seeing such a NULL collection status, if the party that invoked
the caller wants to see a single empty line for whatever reason (which
in turn is a questionable practice, if you ask me, but at this point
in the series we haven't seen what that invoker is doing, so for now
lets assume that it is sane to want to see an empty line), the caller
should do the putchar('\n').

Also, these two "return NULL" leaks 's'.
