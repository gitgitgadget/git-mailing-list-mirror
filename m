Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D13A208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 23:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeHHBmL (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 21:42:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47069 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHHBmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 21:42:11 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so136232ply.13
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UbVYlGYQgxMwkIhLnRzJK5ENekckD/E069ILDT99Z+w=;
        b=pYlVM9i3lPigycu4QZT+/CAInWuDOVn/WVaXmzvg4mu/gnyc/StycdIKGDNKaYQi74
         NnCpSUH9IVNtrp08hhTfhbZzy0v1bx4fkFJkDPnkiuXm57f/IOJ1K0nEs72qN8+yctqa
         H3AjvmVHWVVAySw42goGpyKcGgJfj28UHc4Fj25Gqdau3ERkOosplxzzf2tnhrceVr5X
         SRbyVwvfcUOvJ03nNZbubnX6XqpAIhu+26ZGqLu61nPnuOP5f4LbHCBJbF1z3RZtAlSB
         /0AM165I9NF31Xtf4ZCW403HFHE4DnexxgU2GghBalooDjOvTtRtKKnUej036763zoKA
         jIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UbVYlGYQgxMwkIhLnRzJK5ENekckD/E069ILDT99Z+w=;
        b=NSdZ0Sps+BPhuw+/e4Hq1hOwbosK/whV7h8HLyOUkwdvACGrbaaRLQuz52K24vOQck
         qbNnjdyAQsBSECiLPDfpXJA8hgHxTY9xxyZ7nLWp+PL61RfTJVByeP6GrdYEQtndNJ3g
         k3HEuDwV5cyO8ZZlCm05bQ2MzdJ0Js++sC8spr6UjfwEakB+mJs+M5BTysAH+99X3rap
         LustA95PaDlGrc/OY4q13ovSF6kuaWmHv0KhVLJAHyl1PQjsC9KirCwJiEZaUWC7gooq
         idmQd4XCihbpnFUEycLmYhprUSod4whX5FMYwyJe1a5mx+q5dyojXsWBdVScdYj95qZ6
         fZ1A==
X-Gm-Message-State: AOUpUlFs925fXWPdWjE5kqt+upnjHWWPxu5CFl2MUNagXgji/DfLihBc
        QVP3M+o/NuZ8/rlhGJkQoK7KBnUX
X-Google-Smtp-Source: AA+uWPxr/l0fvR9BN7NP9lx7aZvs1t7nTO5HkuKo9/tvsbgqgLcx87NoIEeSmGdzozcf9uMPI2mycQ==
X-Received: by 2002:a17:902:740a:: with SMTP id g10-v6mr334815pll.204.1533684326630;
        Tue, 07 Aug 2018 16:25:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 143-v6sm4121263pfy.156.2018.08.07.16.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 16:25:26 -0700 (PDT)
Date:   Tue, 7 Aug 2018 16:25:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] submodule: munge paths to submodule git directories
Message-ID: <20180807232524.GB249457@aiede.svl.corp.google.com>
References: <20180807230637.247200-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807230637.247200-1-bmwill@google.com>
User-Agent: Mutt/+ (31e72e18) (2018-08-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Commit 0383bbb901 (submodule-config: verify submodule names as paths,
> 2018-04-30) introduced some checks to ensure that submodule names don't
> include directory traversal components (e.g. "../").
>
> This addresses the vulnerability identified in 0383bbb901 but the root
> cause is that we use submodule names to construct paths to the
> submodule's git directory.  What we really should do is munge the
> submodule name before using it to construct a path.
>
> Introduce a function "strbuf_submodule_gitdir()" which callers can use
> to build a path to a submodule's gitdir.  This allows for a single
> location where we can munge the submodule name (by url encoding it)
> before using it as part of a path.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
> Using submodule names as is continues to be not such a good idea.  Maybe
> we could apply something like this to stop using them as is.  url
> encoding seems like the easiest approach, but I've also heard
> suggestions that would could use the SHA1 of the submodule name.
>
> Any thoughts?

I like this idea.  It avoids the security and complexity problems of
funny nested directories, while still making the submodule git dirs
easy to find.

The current behavior has been particularly a problem in practice when
submodule names are nested:

	[submodule "a"]
		url = https://www.example.com/a
		path = a/1

	[submodule "a/b"]
		url = https://www.example.com/a/b
		path = a/2

We don't enforce any constraint on submodule names to prevent that,
but it causes hard to diagnose errors at clone time:

	fatal: not a git repository: superproject/a/1/../../.git/modules/a
	Unable to fetch in submodule path 'a/1'
	fatal: not a git repository: superproject/a/1/../../.git/modules/a
	fatal: not a git repository: superproject/a/1/../../.git/modules/a
	fatal: not a git repository: superproject/a/1/../../.git/modules/a
	Fetched in submodule 'a/1', but it did not contain 55ca6286e3e4f4fba5d0448333fa99fc5a404a73. Direct fetching of that commit failed.

because the fetch in .git/modules/a is interfered with by
.git/modules/a/b.

[...]
> --- a/submodule.c
> +++ b/submodule.c
[...]
> @@ -1933,9 +1938,29 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
>  			goto cleanup;
>  		}
>  		strbuf_reset(buf);
> -		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
> +		strbuf_submodule_gitdir(buf, the_repository, sub->name);
>  	}
>  
>  cleanup:
>  	return ret;
>  }
> +
> +void strbuf_submodule_gitdir(struct strbuf *buf, struct repository *r,
> +			     const char *submodule_name)
> +{
> +	int modules_len;

nit: size_t

> +
> +	strbuf_git_common_path(buf, r, "modules/");
> +	modules_len = buf->len;
> +	strbuf_addstr(buf, submodule_name);
> +
> +	/*
> +	 * If the submodule gitdir already exists using the old location then
> +	 * return that.
> +	 */

nit: "old-fashioned location" or something.  Maybe the function could
use an API comment describing what's going on (that there are two
naming conventions and we try first the old, then the new).

Should we validate the submodule_name here when accessing following the old
convention?

> +	if (!access(buf->buf, F_OK))
> +		return;
> +
> +	strbuf_setlen(buf, modules_len);
> +	strbuf_addstr_urlencode(buf, submodule_name, 1);
> +}
[...]
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -932,7 +932,7 @@ test_expect_success 'recursive relative submodules stay relative' '
>  		cd clone2 &&
>  		git submodule update --init --recursive &&
>  		echo "gitdir: ../.git/modules/sub3" >./sub3/.git_expect &&
> -		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
> +		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir%2fsubsub" >./sub3/dirdir/subsub/.git_expect
>  	) &&
>  	test_cmp clone2/sub3/.git_expect clone2/sub3/.git &&
>  	test_cmp clone2/sub3/dirdir/subsub/.git_expect clone2/sub3/dirdir/subsub/.git

Sensible.

Can there be a test of the compatibility code as well?  (I mean a test
that manually sets up a submodule in .git/modules/dirdir/subsub and
ensures that it gets reused.)

I'll apply this, experiment with it, and report back.  Thanks for
writing it.

Sincerely,
Jonathan
