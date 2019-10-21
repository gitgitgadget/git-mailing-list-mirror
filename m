Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993F71F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 01:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfJUBgO (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 21:36:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53613 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfJUBgO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 21:36:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE5641EFF2;
        Sun, 20 Oct 2019 21:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XYOXhk31qFCXeYdvK7oBmSW/HO4=; b=P+pDa4
        CbOs4MopHZHwxPCcpt4lsmkpMdLduUDsoP+MhzBppdMnjEHDHMdzRVq+FG+SpT4o
        OcS9K8vzrZLFxus6roIsMm3gfkIh2wOauVblRf0rfe9B/fYJLZ82xaZ34OcNBjyE
        XlRYY/xBLNxH1VsCu+QGnCD9Ag2jXRvvjL4i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dM/AFJZ8B1tzvBMYIkfu3asKONiCEfCO
        5vaV83u6jGJcgjDqFknze6Zv9/E6eHcZITBVLWfJJZfHqcjLsE8RGu7wFWQn8Sok
        wFkornDFFqS5mbA57KuPdaijoV7tmO+P72jYHWreCz9dueALPzzHzmy6yBP+mAN6
        1sigefMR9Kg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B60081EFF0;
        Sun, 20 Oct 2019 21:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23EA01EFEF;
        Sun, 20 Oct 2019 21:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Jones <pjones@redhat.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/4] libgit: Add a read-only helper to test the worktree lock
References: <20191018194317.wvqphshpkfskvkyh@redhat.com>
        <20191018194542.1316981-1-pjones@redhat.com>
Date:   Mon, 21 Oct 2019 10:36:06 +0900
In-Reply-To: <20191018194542.1316981-1-pjones@redhat.com> (Peter Jones's
        message of "Fri, 18 Oct 2019 15:45:39 -0400")
Message-ID: <xmqqwocynam1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27092910-F3A3-11E9-83C8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Jones <pjones@redhat.com> writes:

> Subject: Re: [PATCH v2 1/4] libgit: Add a read-only helper to test the worktree lock

Having a word "worktree" somewhere on the title is good, but have it
as the "I am changing this area"; "libgit" does not give readers the
hint that this is a step about the worktree subsystem.

    Subject: [PATCH v2 1/4] worktree: add is_worktree_locked() helper

When the new helper function is properly named, like yours, there is
not much need to explain what it does (i.e. "to test the worktree
lock"), so just "worktree: add is_worktree_locked()" is sufficient.

> Add the function is_worktree_locked(), which is a helper to tell if a
> worktree is locked without having to be able to modify it.

I do not see the reason why your proposed title and log message
stress the fact that this helper can be used even by callers that
are not permitted to modify the worktree (i.e. the emphasis on
"read-only").  Asking for worktree_lock_reason() can be done by
anybody, but I do not think we particularly advertise it as
read-only.

Perhaps drop "without having to..."?

> -	locked = !!worktree_lock_reason(wt);
> +	locked = is_worktree_locked(wt);
>  	if ((!locked && opts->force) || (locked && opts->force > 1)) {
>  		if (delete_git_dir(wt->id))
>  		    die(_("unable to re-add worktree '%s'"), path);
> diff --git a/worktree.c b/worktree.c
> index 5b4793caa34..4924805c389 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -244,6 +244,22 @@ int is_main_worktree(const struct worktree *wt)
>  	return !wt->id;
>  }
>  
> +int is_worktree_locked(const struct worktree *wt)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	int locked = 0;
> +
> +	if (wt->lock_reason_valid && wt->lock_reason)
> +		return 1;
> +
> +	strbuf_addstr(&path, worktree_git_path(wt, "locked"));
> +	if (file_exists(path.buf))
> +		locked = 1;

If you write

	locked = file_exists(path.buf);

here, then readers do not have to scan backwards and find that the
variable is initialized to zero, and that no other statement since
its initialization touches its value, in order to see what value is
returned when file does not exist.  Writing the RHS !!file_exists()
concisely allows readers to tell that this function returns only 0
or 1 without having to check what file_exists() returns, but that
may probably be overkill.

> +	strbuf_release(&path);
> +	return locked;
> +}

I wondered why this is not just

	#define is_worktree_locked(wt) (!!worktree_lock_reason(wt))

There are a few differences compared to worktree_lock_reason():

 - this can be called on the main worktree by mistake and would
   probably yield "not locked" (but the existing guard is a mere
   assert() which probably is stripped away in production builds)

 - this can be used by a process that cannot even read the contents
   of the locked file for the reason;

 - because reason is not read, reason or reason_valid fields are not
   updated, and repeated calls on the same worktree structure would
   result in repeated lstat() calls.

Shouldn't we be advising the callers that the last one as a
potential downside?  The fact that the new helper is usable even by
read-only callers hints that any caching of earlier results is
disabled, but it is somewhat a round-about way to say so.

As I do not see why being able to take "const struct worktree *", as
opposed to non-const version is a huge advantage, for this helper, I
wonder if it would make even more sense to introduce one more level
to "lock-reason-valid" and allow caching of is_worktree_locked().

Currently, "lock-reason-valid" only tells us "lock-reason may be
NULL, but that does not necessarily mean it is not locked---you have
to check it" boolean, but it could be instead a tristate:

    A: lock-reason may be NULL but that is only because we haven't
       even tried to see if the lock file exists

    B: NULL-ness of lock-reason reliably tells if the worktree is
       locked or not because we have tried file_exists(), but if the
       field has non-NULL value, that is *not* the string we read;
       if you want to know the reason, you must read the file.

    C: NULL in lock-reason means it is not locked; non-NULL in
       lock-reason is what we read form the file.

Also, it may make sense to correct the first difference and in a
more meaningful way than assert(), given that the reason why this
helper is introduced is eventually to perform an destructive action
later in the series.  Perhaps

	if (is_main_worktree(wt))
		BUG("is-worktree-locked called for the main worktree");

at the front.

Thanks.

>  const char *worktree_lock_reason(struct worktree *wt)
>  {
>  	assert(!is_main_worktree(wt));
> diff --git a/worktree.h b/worktree.h
> index caecc7a281c..5ff16c414b5 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -56,6 +56,11 @@ struct worktree *find_worktree(struct worktree **list,
>   */
>  int is_main_worktree(const struct worktree *wt);
>  
> +/*
> + * Return true if the given worktree is locked
> + */
> +int is_worktree_locked(const struct worktree *wt);
> +
>  /*
>   * Return the reason string if the given worktree is locked or NULL
>   * otherwise.
