Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA6F2035A
	for <e@80x24.org>; Wed, 12 Jul 2017 00:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755374AbdGLAZi (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 20:25:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35667 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753701AbdGLAZh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 20:25:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so939509pfq.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 17:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l9XnKMzRtF3tHkKLHn6J8Acj2B/Z+HMC9RkeK0ZG/DY=;
        b=YGCHWmLMg3tqqhiXzFg6uy1+JL8iLljd1WvdmTmpeH0KyxomrZ1QyRvTcUKSPhfs8f
         pf7rtcDOG8D40qk7oD211v3GgelNLd2/zcGc7OpJbzIH0H1CaVf7KDWDngEglnZ9Cbmn
         ahXubSvHVVCVGTlCeC4sXeX5hSGUt7cqOFGtsM3z2rdz7ZFO/NCjx6cQh/Q7fvY3R9uu
         Q2q1Gm18hAbT0KFbWr7fjJUCa/o59I9rIxNcUUaCoZnuQjC9QbSIOaNSdVZtN961pUHZ
         uQa4rq7r1stExtdli7m1GiQrvBsjsQih/qTsYmbezP7R6WdRos5LYLzNqetSXMIuPWS8
         +IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9XnKMzRtF3tHkKLHn6J8Acj2B/Z+HMC9RkeK0ZG/DY=;
        b=MQbAQape8H/rqMpylkynnQqCkLpvA043Y7ihhw+uCB82RBcJlTEBuuMXYsDtMiZ1TO
         uMWOrBiK5MdSq4NhDKSBF/hjr2wlh7LzxE5Wx+gXA6f/JTjOHrMRUULy1PW0tbkomdcg
         V1s3hQN1znCLdXaOzFd7RgZ1FVgVcYoRYACPBueA39P2qclXAF7al0D8PF6VhU0rFN7J
         slKBkGmVOGJDtZESCh0ljDMElF+Bptgci0cw1cFDo4w+liti5Z6jtWPZBywJ8N0uYrTn
         YLlCwllOMnLXDBLLlddLVXBgRPSKziqzMnEWDliTUKwKbGci1P7RQvgfRJLm7qhvKAGp
         mGfg==
X-Gm-Message-State: AIVw113lrsUQ3TXqWeCLmE47TEQpJJw2pxVaRjTzlIQUj0KYp/SRdtx/
        Xv0x5EVQB4EdX2GV0JA=
X-Received: by 10.84.130.42 with SMTP id 39mr1149694plc.60.1499819136376;
        Tue, 11 Jul 2017 17:25:36 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:114c:7a1:940:72cc])
        by smtp.gmail.com with ESMTPSA id l78sm925355pfb.59.2017.07.11.17.25.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 17:25:35 -0700 (PDT)
Date:   Tue, 11 Jul 2017 17:25:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 3/3] grep: recurse in-process using 'struct repository'
Message-ID: <20170712002533.GD93855@aiede.mtv.corp.google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-4-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711220408.173269-4-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Convert grep to use 'struct repository' which enables recursing into
> submodules to be handled in-process.

\o/

This will be even nicer with the changes described at
https://public-inbox.org/git/20170706202739.6056-1-sbeller@google.com/.
Until then, I fear it will cause a regression --- see (*) below.

[...]
>  Documentation/git-grep.txt |   7 -
>  builtin/grep.c             | 390 +++++++++------------------------------------
>  cache.h                    |   1 -
>  git.c                      |   2 +-
>  grep.c                     |  13 --
>  grep.h                     |   1 -
>  setup.c                    |  12 +-
>  7 files changed, 81 insertions(+), 345 deletions(-)

Yay, tests still pass.

[..]
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -95,13 +95,6 @@ OPTIONS
>  	<tree> option the prefix of all submodule output will be the name of
>  	the parent project's <tree> object.
>  
> ---parent-basename <basename>::
> -	For internal use only.  In order to produce uniform output with the
> -	--recurse-submodules option, this option can be used to provide the
> -	basename of a parent's <tree> object to a submodule so the submodule
> -	can prefix its output with the parent's name rather than the SHA1 of
> -	the submodule.

Being able to get rid of this is a very nice change.

[...]
> +++ b/builtin/grep.c
[...]
> @@ -366,14 +349,10 @@ static int grep_file(struct grep_opt *opt, const char *filename)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  
> -	if (super_prefix)
> -		strbuf_addstr(&buf, super_prefix);
> -	strbuf_addstr(&buf, filename);
> -
>  	if (opt->relative && opt->prefix_length) {
> -		char *name = strbuf_detach(&buf, NULL);
> -		quote_path_relative(name, opt->prefix, &buf);
> -		free(name);
> +		quote_path_relative(filename, opt->prefix, &buf);
> +	} else {
> +		strbuf_addstr(&buf, filename);
>  	}

style micronit: can avoid these braces since both branches are
single-line.

[...]
> @@ -421,284 +400,80 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
>  		exit(status);
>  }
>  
> -static void compile_submodule_options(const struct grep_opt *opt,
> -				      const char **argv,
> -				      int cached, int untracked,
> -				      int opt_exclude, int use_index,
> -				      int pattern_type_arg)
> -{
[...]
> -	/*
> -	 * Limit number of threads for child process to use.
> -	 * This is to prevent potential fork-bomb behavior of git-grep as each
> -	 * submodule process has its own thread pool.
> -	 */
> -	argv_array_pushf(&submodule_options, "--threads=%d",
> -			 (num_threads + 1) / 2);

Being able to get rid of this is another very nice change.

[...]
> +	/* add objects to alternates */
> +	add_to_alternates_memory(submodule.objectdir);

(*) This sets up a single in-memory object store with all the
processed submodules.  Processed objects are never freed.
This means that if I run a command like

	git grep --recurse-submodules -e neverfound HEAD

in a project with many submodules then memory consumption scales in
the same way as if the project were all one repository.  By contrast,
without this patch, git is able to take advantage of the implicit
free() when each child exits to limit its memory usage.

Worse, this increases the number of pack files git has to pay
attention to the sum of the numbers of pack files in all the
repositories processed so far.  A single object lookup can take
O(number of packs * log(number of objects in each pack)) time.  That
means performance is likely to suffer as the number of submodules
increases (n^2 performance) even on systems with a lot of memory.

Once the object store is part of the repository struct and freeable,
those problems go away and this patch becomes a no-brainer.

What should happen until then?  Should this go in "next" so we can get
experience with it but with care not to let it graduate to "master"?

Aside from those two concerns, this patch looks very good from a quick
skim, though I haven't reviewed it closely line-by-line.  Once we know
how to go forward, I'm happy to look at it again.

Thanks,
Jonathan
