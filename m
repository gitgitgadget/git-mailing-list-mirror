Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18DF1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 17:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeHUVGj (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 17:06:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50800 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHUVGi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 17:06:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so3775938wmc.0
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hmeM05EC/qFQM0AJLa0wqRBtcPjenTnZnrk9JBsFGOs=;
        b=iC/ZIjvL/FjsFdMFP8huxRgAzpUxn/bYU2OsUBtCf4xuPFrD8qd+AR9YjMXbQYh5HH
         y9BRYo9cPotXP1Sw/Y2LXZB5p7w9zFcGJ+m6REZS8sWaR131jOTAmqNZysdKQgDGoFar
         yBemY3B2CY8nOWdZK4YwDX17QI4RAQ5VsSXLmYiWlT1PAqM0oRVqUMSm1xuF/ilVHHjD
         1F0Ui07KqpTlOICyXR/jBjwCf5UEfsd/lGHd2T6aFpJloRRhJ1RcsomhFE6miBYML2nM
         4Le1VvBZhoWUZn62sJNjwHQomDSngvUroEQCYjVone9I85DwDIk5Br1Rej+h4xyd4wU3
         Aq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hmeM05EC/qFQM0AJLa0wqRBtcPjenTnZnrk9JBsFGOs=;
        b=f8ub2weHC3V7PvJ9gOn6VkMHnmGcbXhPVoSU/0h0xYx1v1xAmf24hKh2QVb2XEv4mE
         MciHG+SklcXlzixln266bOQsn7+sRKOB7MJLnICyZBgwS+pQxX5Ddu4PFyBe0/bk/yc0
         tgktD+7wfrsr9ipFt03LOLSvPmdz26tsG1j9kZh+UcSas0coxuiUWpm5987Q8vBY9lS3
         FoT+nhwUIEXyb3gsqZzKvJrTpHejG1Sfkt3GcyU1U/ZTu9qA5MyddpSRiKZczs7NG8s8
         NFroH6BL9aMK7Ppf/wxxCs+/ZshXLlMB2VJBWDwUV9hHaX1b6EwfkVf5ghPDbpzd3LKJ
         ZY+A==
X-Gm-Message-State: APzg51DEVCByedNRUopecdGu4kU1PEnWuuJ9POWQVQnrOZdH/MyKBbnI
        GnZY71HP79sYxbB12tB9xyg=
X-Google-Smtp-Source: ANB0VdZzmUsPNfIzDs8gEzc0PMUxaARZ5VW42X7yEjeBqLTKTvR3k652cicWDJJ9s78T+XSFZfxiXQ==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr218893wme.109.1534873529578;
        Tue, 21 Aug 2018 10:45:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h8-v6sm8622148wre.15.2018.08.21.10.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 10:45:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>
Subject: Re: [PATCH v2 5/8] commit-graph: not compatible with replace objects
References: <pull.11.git.gitgitgadget@gmail.com>
        <20180820182359.165929-1-dstolee@microsoft.com>
        <20180820182359.165929-6-dstolee@microsoft.com>
Date:   Tue, 21 Aug 2018 10:45:26 -0700
In-Reply-To: <20180820182359.165929-6-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 20 Aug 2018 18:24:27 +0000")
Message-ID: <xmqqa7pfaa15.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Create new method commit_graph_compatible(r) to check if a given
> repository r is compatible with the commit-graph feature. Fill the
> method with a check to see if replace-objects exist. Test this
> interaction succeeds, including ignoring an existing commit-graph and
> failing to write a new commit-graph. However, we do ensure that
> we write a new commit-graph by setting read_replace_refs to 0, thereby
> ignoring the replace refs.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/commit-graph.c  |  4 ++++
>  commit-graph.c          | 21 +++++++++++++++++++++
>  replace-object.c        |  2 +-
>  replace-object.h        |  2 ++
>  t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
>  5 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 0bf0c48657..da737df321 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -120,6 +120,8 @@ static int graph_read(int argc, const char **argv)
>  	return 0;
>  }
>  
> +extern int read_replace_refs;
> +

Why do you need this (and also in commit-graph.c)?  I thought
cache.h includes it, which you can just make use of it.

> +static int commit_graph_compatible(struct repository *r)
> +{
> +	if (read_replace_refs) {
> +		prepare_replace_object(r);
> +		if (hashmap_get_size(&r->objects->replace_map->map))
> +			return 0;
> +	}
> +
> +	return 1;
> +}

> diff --git a/replace-object.c b/replace-object.c
> index 3c17864eb7..9821f1477e 100644
> --- a/replace-object.c
> +++ b/replace-object.c
> @@ -32,7 +32,7 @@ static int register_replace_ref(struct repository *r,
>  	return 0;
>  }
>  
> -static void prepare_replace_object(struct repository *r)
> +void prepare_replace_object(struct repository *r)
>  {
>  	if (r->objects->replace_map)
>  		return;

The way the new caller is written, I am wondering if this function
should return "we are (or, are not) using the replace object
feature", making it unnecessary for callers on the reading side to
know about "read-replace-refs" external variable, for example.

	/*
	 * To be called on-demand from codepaths that want to make
	 * sure that replacement objects can be found as necessary.
	 * 
	 * Return number of replacement defined for the repository, or
	 * -1 when !read_replace_refs tells us not to use replacement
	 * mechanism at all.
	 */
	int prepare_replace_object(struct repository *r)
	{
		if (!read_replace_refs)
			return -1;

		if (!r->objects->replace_map) {
			r->objects->replace_map =
				xmalloc(...);
			oidmap_init(r->objects->replace_map, 0);
			for_each_refplace_ref(r, register_...);
		}
		return hashmap_get_size(&r->objects->replace_map->map);
	}
			
Then, the caller side can simply become something like:

	#define cgraph_compat(r) (prepare_replace_object(r) <= 0)

There are various writers to read_replace_refs variable, but I think
they should first be replaced with calls to something like:

	void use_replace_refs(struct repository *r, int enable);

which allows us to hide the global variable and later make it per
repository if we wanted to.

