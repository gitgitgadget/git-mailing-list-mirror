Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151C5C433E3
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 21:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC33F20B1F
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 21:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkGTIBj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHLVDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 17:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgHLVDa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 17:03:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A43BC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 14:03:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so1676821pgf.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7v9o/Gs5xJknN/eAqEcec6Bmqi9Peb7bEKG76AfZId8=;
        b=kkGTIBj4VW1d0P3UzXMY2dAJIkIYgjs/GR7EhxQX+HBRVazY+e076y6M1X/BQkflgO
         BXzDKuIfj0Bk94umM7fLIlFM7FC99nPO4yp+QQdyRpUSxIQLGrjX7lsUFDUgLHLNgKcp
         wf66Tjbuj5Sg1DUpkPUl+e0SutAyuWuf0Y4VxDEXql6qwUtvtJeLUFJ3CPz4I0nM3B8X
         skFwG7FhYkekSFCiG386sLTJIiVXH8QIRCwtNGUQLxD8KY5AJ7/K5tgKtb+Ofg31w/6b
         s0szV3STvGeQgLc5QV9mGl+gqoEcamKp9m96Yi91AKtqcY25+8WIR2OFaAmYTlcpoBcR
         du9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7v9o/Gs5xJknN/eAqEcec6Bmqi9Peb7bEKG76AfZId8=;
        b=ZzJapxUMxOcfrs6DDaDC/DD0DemU2U0el8dO+tCeD6nwnoBnBiysArH31v7J7wv1vA
         fqcigTozUhN4g44BGO5AavVHWdC+7eTWVX+CmH1AgAyp30R9Oxwf1L0yWZ5d3/RAOYZw
         pjn9dbkoh/ltOXldD8+OwS1GIuEAeJBma1k3Na8Q/t1maov5n5mxi3illT071/BKDwu/
         x5c13AXHI7/qhPaNFn5p7EURNbPhtgmPHFiRwcY5GfdkyWzzXqUvJyi+lN6ceRLvmKK6
         c7K09UAf6R1AXRKjBDQRCm25BivW6TeLbQLFTvebMsdm5fWiod5NrS986VbdpArjLUVK
         p8Xw==
X-Gm-Message-State: AOAM531FeghFGCnXpUacTe3Ziy3DdlAIIrSjVBNbsPAMV2zSIfHnJJfy
        Jqkqp+U6a4+17jbStZEg2pL2rPo8
X-Google-Smtp-Source: ABdhPJxsoMNN1orZffazIxzcFB6DHGqr41CaO/sFJNcgovBrVL+5r34zU27y7lsygjHB+O9xvPZZ/w==
X-Received: by 2002:a63:d10a:: with SMTP id k10mr905629pgg.382.1597266209531;
        Wed, 12 Aug 2020 14:03:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id y20sm3342749pfn.183.2020.08.12.14.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 14:03:28 -0700 (PDT)
Date:   Wed, 12 Aug 2020 14:03:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/11] maintenance: create basic maintenance runner
Message-ID: <20200812210326.GA104953@google.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
 <2b9deb6d6a23e53bec75e109f2e3ef9217420425.1596728921.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9deb6d6a23e53bec75e109f2e3ef9217420425.1596728921.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:

> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  .gitignore                        |  1 +
>  Documentation/git-maintenance.txt | 57 +++++++++++++++++++++++++++++++
>  builtin.h                         |  1 +
>  builtin/gc.c                      | 57 +++++++++++++++++++++++++++++++
>  git.c                             |  1 +
>  t/t7900-maintenance.sh            | 19 +++++++++++
>  t/test-lib-functions.sh           | 33 ++++++++++++++++++
>  7 files changed, 169 insertions(+)
>  create mode 100644 Documentation/git-maintenance.txt
>  create mode 100755 t/t7900-maintenance.sh

Looks reasonable.

[...]
> --- /dev/null
> +++ b/Documentation/git-maintenance.txt
> @@ -0,0 +1,57 @@
> +git-maintenance(1)
> +==================
> +
> +NAME
> +----
> +git-maintenance - Run tasks to optimize Git repository data
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git maintenance' run [<options>]
> +
> +
> +DESCRIPTION
> +-----------
> +Run tasks to optimize Git repository data, speeding up other Git commands
> +and reducing storage requirements for the repository.
> ++
> +Git commands that add repository data, such as `git add` or `git fetch`,
> +are optimized for a responsive user experience. These commands do not take
> +time to optimize the Git data, since such optimizations scale with the full
> +size of the repository while these user commands each perform a relatively
> +small action.
> ++
> +The `git maintenance` command provides flexibility for how to optimize the
> +Git repository.
> +
> +SUBCOMMANDS
> +-----------
> +
> +run::
> +	Run one or more maintenance tasks.

This is still confusing --- shouldn't it say something like "Run the
`gc` maintenance task (see below)"?

[...]
> +TASKS
> +-----
> +
> +gc::
> +	Cleanup unnecessary files and optimize the local repository. "GC"

nit: cleanup is the noun, "clean up" is the verb

> +	stands for "garbage collection," but this task performs many
> +	smaller tasks. This task can be rather expensive for large

nit: the word "rather" is not doing much work here, so we could leave
it out

> +	repositories, as it repacks all Git objects into a single pack-file.
> +	It can also be disruptive in some situations, as it deletes stale
> +	data.

What stale data is this referring to?  Where can I read more about
what disruption it causes (or in other words, as a user, how would I
decide when *not* to run this command)?

[...]
> +OPTIONS
> +-------
> +--auto::
> +	When combined with the `run` subcommand, run maintenance tasks
> +	only if certain thresholds are met. For example, the `gc` task
> +	runs when the number of loose objects exceeds the number stored
> +	in the `gc.auto` config setting, or when the number of pack-files
> +	exceeds the `gc.autoPackLimit` config setting.

Hm, today I learned.  I had thought that --auto doesn't only affect
thresholds but also would affect how aggressive the gc is when
triggered, but the git-gc(1) manpage agrees with what's said above.

Is there a way we can share information between the two to avoid one
falling out of date?  For example, should git-gc.txt point to this
page for the authoritative description?

[...]
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -699,3 +699,60 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  
>  	return 0;
>  }
> +
> +static const char * const builtin_maintenance_usage[] = {
> +	N_("git maintenance run [<options>]"),

not about this patch: I wish we could automatically generate a usage
string in this simple kind of case, to decrease the burden on
translators.

[...]
> +static int maintenance_task_gc(struct maintenance_opts *opts)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	child.git_cmd = 1;
> +	strvec_push(&child.args, "gc");
> +
> +	if (opts->auto_flag)
> +		strvec_push(&child.args, "--auto");
> +
> +	close_object_store(the_repository->objects);

Interesting --- what does this function call do?

> +	return run_command(&child);
> +}
> +
> +static int maintenance_run(struct maintenance_opts *opts)
> +{
> +	return maintenance_task_gc(opts);
> +}
> +
> +int cmd_maintenance(int argc, const char **argv, const char *prefix)
> +{
> +	static struct maintenance_opts opts;
> +	static struct option builtin_maintenance_options[] = {
> +		OPT_BOOL(0, "auto", &opts.auto_flag,
> +			 N_("run tasks based on the state of the repository")),
> +		OPT_END()
> +	};

optional: these could be local instead of static

> +
> +	memset(&opts, 0, sizeof(opts));

not needed if it's static.  If it's not static, could use `opts = {0}`
where it's declared to do the same thing in a simpler way.

> +
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(builtin_maintenance_usage,
> +				   builtin_maintenance_options);
> +
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_maintenance_options,
> +			     builtin_maintenance_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +
> +	if (argc == 1) {
> +		if (!strcmp(argv[0], "run"))
> +			return maintenance_run(&opts);
> +	}
> +
> +	usage_with_options(builtin_maintenance_usage,
> +			   builtin_maintenance_options);

optional: could reverse this test to get the uninteresting case out of
the way first:

	if (argc != 1)
		usage ...

	...

That would also allow making the usage string when argv[0] is not
"run" more specific.

[...]
> --- /dev/null
> +++ b/t/t7900-maintenance.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +
> +test_description='git maintenance builtin'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'help text' '
> +	test_expect_code 129 git maintenance -h 2>err &&
> +	test_i18ngrep "usage: git maintenance run" err
> +'
> +
> +test_expect_success 'run [--auto]' '
> +	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
> +	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
> +	test_subcommand git gc <run-no-auto.txt &&
> +	test_subcommand git gc --auto <run-auto.txt

Nice.

[...]
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1561,3 +1561,36 @@ test_path_is_hidden () {
>  	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
>  	return 1
>  }
> +
> +# Check that the given command was invoked as part of the
> +# trace2-format trace on stdin.
> +#
> +#	test_subcommand [!] <command> <args>... < <trace>
> +#
> +# For example, to look for an invocation of "git upload-pack
> +# /path/to/repo"
> +#
> +#	GIT_TRACE2_EVENT=event.log git fetch ... &&
> +#	test_subcommand git upload-pack "$PATH" <event.log
> +#
> +# If the first parameter passed is !, this instead checks that
> +# the given command was not called.
> +#
> +test_subcommand () {
> +	local negate=
> +	if test "$1" = "!"
> +	then
> +		negate=t
> +		shift
> +	fi
> +
> +	local expr=$(printf '"%s",' "$@")
> +	expr="${expr%,}"
> +
> +	if test -n "$negate"
> +	then
> +		! grep "\[$expr\]"
> +	else
> +		grep "\[$expr\]"
> +	fi
> +}

With whatever subset of the changes described above makes sense,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your patient work.
