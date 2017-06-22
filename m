Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A95E20802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbdFVUQL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:16:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35501 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdFVUQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:16:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so4479130pfs.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KeThj/LmDRqIa2YfNrTEwjO/UtKUHMqE2zBbYqs1TSg=;
        b=K1KSnQuKsDFDxwGUN26wZ9YNJyWfm+jlbxKnEO+237nd/mVHC2FK9aYu32AUUHq503
         TuYCdSRIimeGByu5qCxflvEj6H5Y+CHofw7mSNzWpbl4BrsnVaDXTz67nk/cvLi8gZ8L
         7qGA4EJcxsRugEDR3INanUF+MYEBaZqbija767A7Yj+AZraBgdO8ASpvKshK13PHmnb5
         tKHDpWxsriRI2RbIFFHzSa8Rx1II0gE+CbFtz1W+QCjdXS9QnQmM0xMMrmiRKK8/JKd2
         n+NTofpg9KWgYW6oadRnPNIW+sdV54u6pGidi2Fhmyx39TtiEmmd4hoV4uvhxaqh2F4f
         LHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KeThj/LmDRqIa2YfNrTEwjO/UtKUHMqE2zBbYqs1TSg=;
        b=o1ElV8a+nvzz9pHHbiUelPhFLvTD6TMcgRdNv8WntQLWcAGFbKPxX1dfxcqDcuAfi/
         CmoCH9LQGG6SckwQ8P4vaAMUnojlP9GOnO/dTH0GLUbvxr+nsQVQGoKgXQVvHrumpSCT
         rmSZId8c6coLaJyGnMYlGrpj12gVKIXTafWAfXa6huerSFXBqWHk5Y6rIost0YtMJn5W
         EBvmOs9IJVKxQ8XSSFZfbHFEpkmpw26yP7C2nGtGVNwI6OmXwjybFkoGtUtAlq6lGDGt
         H2vlTMqRX14f/61dBtPEcPKlKG8GZPhgi3Pgc6kdyjVP3pgMoYN9oHSa8EAl01t6wqb8
         Lk5A==
X-Gm-Message-State: AKS2vOz1PSy15DjTuYwF09V02IHCAx00mpEAUsFazy0GIgID54YIq7y+
        YZZkePiKQXaXUg==
X-Received: by 10.98.88.132 with SMTP id m126mr4447530pfb.180.1498162569989;
        Thu, 22 Jun 2017 13:16:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id t128sm5100099pfd.64.2017.06.22.13.16.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 13:16:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, peff@peff.net, git@jeffhostetler.com,
        avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 15/20] repository: add index_state to struct repo
References: <20170620191951.84791-1-bmwill@google.com>
        <20170622184348.56497-1-bmwill@google.com>
        <20170622184348.56497-16-bmwill@google.com>
Date:   Thu, 22 Jun 2017 13:16:06 -0700
In-Reply-To: <20170622184348.56497-16-bmwill@google.com> (Brandon Williams's
        message of "Thu, 22 Jun 2017 11:43:43 -0700")
Message-ID: <xmqqshirixrt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>  struct repository {
>  	/* Environment */
> @@ -49,6 +50,12 @@ struct repository {
>  	 */
>  	struct config_set *config;
>  
> +	/*
> +	 * Repository's in-memory index.
> +	 * 'repo_read_index()' can be used to populate 'index'.
> +	 */
> +	struct index_state *index;
> +
>  	/* Configurations */
>  	/*
>  	 * Bit used during initialization to indicate if repository state (like
> @@ -71,4 +78,6 @@ extern void repo_set_worktree(struct repository *repo, const char *path);
>  extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
>  extern void repo_clear(struct repository *repo);
>  
> +extern int repo_read_index(struct repository *repo);
> +
>  #endif /* REPOSITORY_H */

While you are working on a simple read-only operation like
"ls-files", you can get away with just a singleton (the equivalent
to "the_index" in the repository object world) in-core index
instance, and having a way to tell the system to read things into
the default thing without having to name what that default thing is
is a very useful thing to have.  It is a good thing that this only
needs "struct repository *" and no "struct index_state *" parameter.

But you will need a way to read, update, write it out as a tree,
etc. to a non-default in-core index, once you start doing more
complex things.  The function signature of the lowest level
primitive helper for them will be:

    extern int (*)(struct repository *, struct index_state *);

And you would want to reserve "index" suffix for such a function,
following the "if you use the default in-core thing, you do not have
to pass it as a parameter---just call _cache() convenience macro;
but you can explicitly pass it to the underlying _index() function"
convention we established long time ago.

So I'd suggest renaming the above one that uses the default in-core
index instance to

	extern int repo_read_cache(struct repository *);

or you will regret later.

