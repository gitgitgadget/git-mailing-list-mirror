Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35AEC83003
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8478D2073E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYMTPRHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD3DLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726357AbgD3DLm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 23:11:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07BBC035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 20:11:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so2204182pfd.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 20:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KhvxB1lZEkNl2HMjS8gKn+ufF2VlKApJQZ72XZW0XAQ=;
        b=DYMTPRHFvr1JlkwXzPsR8tV8Kg6MgSJdHA+cASPiYFlJvJkrqi0L+YQLXCf09KoFz9
         SJZbSsSgcknqPFCumoOLA/H1Z6RCMfm4i9z0Glp42jcJPOOG3CV30VIwiRpCiCaxvE8/
         ScuX2h0o5zuaZMpKgRdDLJaWIMc/O0j0QY4xYEXnEHeIgnAPI3CLO6WozcciTWMb7lRf
         Lp8pE2C0nMTO8ftCm5RCY90cbECuIzfg2Y2Ypx73kOmZasIAAQD0B0gWJINOe1j5KKt2
         +bu7VBY7DZzuoDx/u6BvBQLFWRo1KeKxjT+d4HPemdBjjOhPFH8LQ8oCz1RO2rgX6u2i
         zqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KhvxB1lZEkNl2HMjS8gKn+ufF2VlKApJQZ72XZW0XAQ=;
        b=crCnkjzZddB2T0gvT9KgIev6I3LBMcf1hnnXLnQDIjVgraZqNwur7nez7nn9cnLecI
         wlMhmQZgEAAklRJrLlABbMQhk6VdGgJaYEsn9cAdomBSr4cLNH/NaLOAlXqroySXjzkC
         2oVvbV1o5ULmxHJBwyhZ5ODejUTjSoSRy/XoGTZKZAQXD0b191x5PHNz/8YgUdXVR7/h
         tQ58T4dyYNI69dcN5zjBYBeoKzzxPqeFqoh5bUDiYgaW79GMU8lCaOzomCEYKcEGA1qj
         ZySg2czRQPvMZrcxsIaV39cBbqyXakzI71s5XuDQ2UhFsZzPWu/HV9mABmTNHJmMEUmF
         zLFw==
X-Gm-Message-State: AGi0PuY8noPyDF6JmnCT9fvKhYGWae0z+fRcbwXj/75hCeewiE7BlYD2
        S9pI+IWJZdRhSnjv3h/r42W1rpZF
X-Google-Smtp-Source: APiQypJ6xZ0FJmRKmR92jvmOU3KqGKTMibyZYrrIf+JHvCbIDow/KvgYI9IcJC3fZMbymly45qanPA==
X-Received: by 2002:aa7:988e:: with SMTP id r14mr1450589pfl.146.1588216301245;
        Wed, 29 Apr 2020 20:11:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id o11sm1975347pgd.58.2020.04.29.20.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 20:11:40 -0700 (PDT)
Date:   Wed, 29 Apr 2020 20:11:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] shallow: use struct 'shallow_lock' for additional
 safety
Message-ID: <20200430031138.GC115238@google.com>
References: <cover.1588199705.git.me@ttaylorr.com>
 <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:

> In previous patches, the functions 'commit_shallow_file' and
> 'rollback_shallow_file' were introduced to reset the shallowness
> validity checks on a repository after potentially modifying
> '.git/shallow'.
>
> These functions can be made safer by wrapping the 'struct lockfile *' in
> a new type, 'shallow_lock', so that they cannot be called with a raw
> lock (and potentially misused by other code that happens to possess a
> lockfile, but has nothing to do with shallowness).
>
> This patch introduces that type as a thin wrapper around 'struct
> lockfile', and updates the two aforementioned functions and their
> callers to use it.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/receive-pack.c |  2 +-
>  fetch-pack.c           |  2 +-
>  shallow.c              | 22 +++++++++++-----------
>  shallow.h              | 16 +++++++++++++---
>  4 files changed, 26 insertions(+), 16 deletions(-)

Yay!  Thanks for indulging the suggestion.

[...]
> --- a/shallow.h
> +++ b/shallow.h
> @@ -10,12 +10,22 @@ void set_alternate_shallow_file(struct repository *r, const char *path, int over
>  int register_shallow(struct repository *r, const struct object_id *oid);
>  int unregister_shallow(const struct object_id *oid);
>  int is_repository_shallow(struct repository *r);
> +
> +/*
> + * shallow_lock is a thin wrapper around 'struct lock_file' in order to restrict
> + * which locks can be used with '{commit,rollback}_shallow_file()'.
> + */
> +struct shallow_lock {
> +	struct lock_file lk;
> +};
> +#define SHALLOW_LOCK_INIT { LOCK_INIT }

I think I disagree with Eric here: it's useful to have a comment here
to describe the purpose of the struct (i.e., the "why" as opposed to
the "what").

I wonder if we can go further, though --- when using a shallow_lock,
how should I think of it as a caller?  In some sense, the use of
'struct lock_file' is an implementation detail, so we could say:

	/*
	 * Lock for updating the $GIT_DIR/shallow file.
	 *
	 * Use `commit_shallow_file()` to commit an update, or
	 * `rollback_shallow_file()` to roll it back.  In either case,
	 * any in-memory cached information about which commits are
	 * shallow will be appropriately invalidated so that future
	 * operations reflect the new state.
	 */

What do you think?

[...]
> --- a/shallow.c
> +++ b/shallow.c
[...]
> @@ -366,22 +366,22 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
>  	return "";
>  }
>  
> -void setup_alternate_shallow(struct lock_file *shallow_lock,
> +void setup_alternate_shallow(struct shallow_lock *shallow_lock,
>  			     const char **alternate_shallow_file,
>  			     const struct oid_array *extra)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	int fd;
>  
> -	fd = hold_lock_file_for_update(shallow_lock,
> +	fd = hold_lock_file_for_update(&shallow_lock->lk,
>  				       git_path_shallow(the_repository),
>  				       LOCK_DIE_ON_ERROR);

This is peeking into the underlying lock_file, so I should ask myself
whether it's hinting at some missing function in the shallow_lock
API.  My feeling is "no": setup_alternate_shallow is itself that
function. :)

[...]
> @@ -414,7 +414,7 @@ void advertise_shallow_grafts(int fd)
>   */
>  void prune_shallow(unsigned options)
>  {
> -	struct lock_file shallow_lock = LOCK_INIT;
> +	struct shallow_lock shallow_lock = SHALLOW_LOCK_INIT;
>  	struct strbuf sb = STRBUF_INIT;
>  	unsigned flags = SEEN_ONLY;
>  	int fd;
> @@ -428,14 +428,14 @@ void prune_shallow(unsigned options)
>  		strbuf_release(&sb);
>  		return;
>  	}
> -	fd = hold_lock_file_for_update(&shallow_lock,
> +	fd = hold_lock_file_for_update(&shallow_lock.lk,
>  				       git_path_shallow(the_repository),
>  				       LOCK_DIE_ON_ERROR);
>  	check_shallow_file_for_update(the_repository);
>  	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
>  		if (write_in_full(fd, sb.buf, sb.len) < 0)
>  			die_errno("failed to write to %s",
> -				  get_lock_file_path(&shallow_lock));
> +				  get_lock_file_path(&shallow_lock.lk));
>  		commit_shallow_file(the_repository, &shallow_lock);

There's no obvious helper to extract here either, so this looks good
to me.

With whatever tweaks based on Eric's and Jonathan's reviews seem
appropriate,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
