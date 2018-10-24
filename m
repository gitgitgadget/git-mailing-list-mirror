Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0041F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeJXMNh (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 08:13:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53315 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXMNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 08:13:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id f8-v6so1378066wmc.3
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 20:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rKBt3Q2lGYCS2pAMUZN18eHtcauAiABntWYMKR1QNXU=;
        b=g+AYn++ii+SHRxR0aPN8I+bJEgAyX6vtHbaloNHMmEauarfSMi+A32sGCyeqCfvX70
         hEOoXzMjGrfbIZsgve2j/P4Q5UO1KDHq/MbWH2XRY6NE2fV4HcbAF+QvFALaTCTsABeg
         0L2rBiSf71NkWI7v+UkgknszxFF1FIP/E5MGds6860nnvSpscHrCAwKF1z/GfQFVlh/b
         /AUx66zbuiTY2qtUhWlvWAd2hk1/POEk9f6BrAz4j8wgAowQOxmUXjgtnejMOlfdWHVP
         bTHG7F9fC8xoNd3m/hurSMJTpbIR4pMyA5CpN+nTGX5B2S942TGeko7hJbFGMVxREy4Y
         MdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rKBt3Q2lGYCS2pAMUZN18eHtcauAiABntWYMKR1QNXU=;
        b=TG1/mrfyLx5oflBjFr9NrO81V3KBK52NMCEsNya22loIWxMGLoWVRY3B4H5nXtWkR+
         zYdn/S6m7YokiyJJSTICp3oxnqCmPS5LKIxUGQ07m3VIvKdEFyTQPIBJ4w5ymo6GV52H
         peVTp1isS7YqmCzUaSlxZZbPv2LRNXZ/Z92rn5Mdur4xhw8Zmkmd7eDKiIlS6390PJJp
         UNty0J7FXUn9jwMh3sZdtCVAyZZ4d9BKBCVCaeiBC8KJAtlc8ikx0vpqKOfJA2TmboNz
         9yMFXCuaie++B10loFf/efbdMNJ5q71hx7RUX4PMYrWf0TqBmJfpNbm+AU/cggVx8ZE/
         pK9g==
X-Gm-Message-State: AGRZ1gJS2kHso7PajQafE3ufa7dslhlOWe3oDejImIyn1Gn6ethUpyes
        oiuVTMAWQhJq3Lk9+oIVTUY=
X-Google-Smtp-Source: AJdET5d539et3iDobEPe4SYId7dyfGJJqHpbPH4PgUAZazlR2mi3yfA4cT/FpsF3ogglkWr8zB+TgQ==
X-Received: by 2002:a7b:c10d:: with SMTP id w13-v6mr723469wmi.26.1540352840356;
        Tue, 23 Oct 2018 20:47:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e142-v6sm7780479wmf.20.2018.10.23.20.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 20:47:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] shallow: offer to prune only non-existing entries
References: <pull.9.v2.git.gitgitgadget@gmail.com>
        <pull.9.v3.git.gitgitgadget@gmail.com>
        <f085eb4f728f5cd102f56b7a90ce9b10fdb59dee.1540245934.git.gitgitgadget@gmail.com>
Date:   Wed, 24 Oct 2018 12:47:18 +0900
In-Reply-To: <f085eb4f728f5cd102f56b7a90ce9b10fdb59dee.1540245934.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 22 Oct 2018
        15:05:38 -0700 (PDT)")
Message-ID: <xmqqmur4ovjt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan, do you see any issues with the use of lookup_commit() in
this change wrt lazy clone?  I am wondering what happens when the
commit in question is at, an immediate parent of, or an immediate
child of a promisor object.  I _think_ this change won't make it
worse for two features in playing together, but thought that it
would be better to double check.

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `prune_shallow()` function wants a full reachability check to be
> completed before it goes to work, to ensure that all unreachable entries
> are removed from the shallow file.
>
> However, in the upcoming patch we do not even want to go that far. We
> really only need to remove entries corresponding to pruned commits, i.e.
> to commits that no longer exist.
>
> Let's support that use case.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/prune.c |  2 +-
>  commit.h        |  2 +-
>  shallow.c       | 22 +++++++++++++++++-----
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 41230f821..6d6ab6cf1 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -161,7 +161,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  	free(s);
>  
>  	if (is_repository_shallow(the_repository))
> -		prune_shallow(show_only);
> +		prune_shallow(show_only, 0);
>  
>  	return 0;
>  }
> diff --git a/commit.h b/commit.h
> index 1d260d62f..ff34447ab 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -249,7 +249,7 @@ extern void assign_shallow_commits_to_refs(struct shallow_info *info,
>  					   uint32_t **used,
>  					   int *ref_status);
>  extern int delayed_reachability_test(struct shallow_info *si, int c);
> -extern void prune_shallow(int show_only);
> +extern void prune_shallow(int show_only, int quick_prune);
>  extern struct trace_key trace_shallow;
>  
>  extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
> diff --git a/shallow.c b/shallow.c
> index 732e18d54..0a2671bc2 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -247,6 +247,7 @@ static void check_shallow_file_for_update(struct repository *r)
>  
>  #define SEEN_ONLY 1
>  #define VERBOSE   2
> +#define QUICK_PRUNE 4
>  
>  struct write_shallow_data {
>  	struct strbuf *out;
> @@ -261,7 +262,11 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
>  	const char *hex = oid_to_hex(&graft->oid);
>  	if (graft->nr_parent != -1)
>  		return 0;
> -	if (data->flags & SEEN_ONLY) {
> +	if (data->flags & QUICK_PRUNE) {
> +		struct commit *c = lookup_commit(the_repository, &graft->oid);
> +		if (!c || parse_commit(c))
> +			return 0;
> +	} else if (data->flags & SEEN_ONLY) {
>  		struct commit *c = lookup_commit(the_repository, &graft->oid);
>  		if (!c || !(c->object.flags & SEEN)) {
>  			if (data->flags & VERBOSE)
> @@ -371,16 +376,23 @@ void advertise_shallow_grafts(int fd)
>  
>  /*
>   * mark_reachable_objects() should have been run prior to this and all
> - * reachable commits marked as "SEEN".
> + * reachable commits marked as "SEEN", except when quick_prune is non-zero,
> + * in which case lines are excised from the shallow file if they refer to
> + * commits that do not exist (any longer).
>   */
> -void prune_shallow(int show_only)
> +void prune_shallow(int show_only, int quick_prune)
>  {
>  	struct lock_file shallow_lock = LOCK_INIT;
>  	struct strbuf sb = STRBUF_INIT;
> +	unsigned flags = SEEN_ONLY;
>  	int fd;
>  
> +	if (quick_prune)
> +		flags |= QUICK_PRUNE;
> +
>  	if (show_only) {
> -		write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY | VERBOSE);
> +		flags |= VERBOSE;
> +		write_shallow_commits_1(&sb, 0, NULL, flags);
>  		strbuf_release(&sb);
>  		return;
>  	}
> @@ -388,7 +400,7 @@ void prune_shallow(int show_only)
>  				       git_path_shallow(the_repository),
>  				       LOCK_DIE_ON_ERROR);
>  	check_shallow_file_for_update(the_repository);
> -	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
> +	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
>  		if (write_in_full(fd, sb.buf, sb.len) < 0)
>  			die_errno("failed to write to %s",
>  				  get_lock_file_path(&shallow_lock));
