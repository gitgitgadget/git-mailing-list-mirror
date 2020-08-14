Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA8EC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D6A20855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyLmhIvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHNBFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHNBFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 21:05:53 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFB5C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 18:05:53 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so5871711qtm.10
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/iK1SmV2ZsyAJVU4Y0wvHTZv8EavRr+KuAz4pMb+IYQ=;
        b=cyLmhIvx8gWECg583MPwtgs92uYUeDP8a0ch7WGkfa2QwlGWXUIIlddXFgbdP9+k6b
         Y6jQ8igEqy5TQAiEck8Sd/vk7GFr7mxxOJhDy4ypQren2Zh/bDtusE0tlFgDAIp2YpN9
         1dd91ixfDzZj+3HsTPXuf6eZi5hJjcJJIh2lv6lbPekJBMM2HTnbQg0DY/BdiPVyK+2P
         sb7YJ9Q/jzy+EsBYDttXpIYeHciT2kkccwwlgqkLlPRIisjVGZ34x2AkvGU7vlfLzo6w
         7sdzNaXW8gV8LjhDtifdSC7qwiQVc5OdFDcKAqeRC+gGxKuKVW9BvIyzYHTQZmgAIFWm
         QMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/iK1SmV2ZsyAJVU4Y0wvHTZv8EavRr+KuAz4pMb+IYQ=;
        b=W335Y62vfX5r0vlB0vFg4Vj3xJp/k/bdeoOyUqbuHxuaaXrh/NCPkp8c/KUog4IAKl
         1/tnB/HYbKMPj/1p13PqqM23dtPG5TMbS1rsnHBiE8ESB2kowR/0o7Hc6+uVk2VKUWgB
         bk8ZMFR6W691Hkj88Z44tcIRND1uC2g0TX21pBzqk5YnT7cJibMSKdTjTcPWS7pbCfMv
         X9vnLeJ1CHnc7wFlWSdBklOqj9cPUEYHvs7bpNEFFbwVQ4cCBSQ9DwuTlwxDtRI6Jdpc
         n2+hS0O8vO5lxmu1PaGDTxvOHieHzi6ZibCO/cAGzustmIrMnJd6rAhVizq3Gyhhz4Hp
         6HAQ==
X-Gm-Message-State: AOAM5317Nsq/nSWtKfJ9maB2LIlG0/X/bmExSbXSc/pEFym/9XEskUp5
        XqelckMC4yf62Ag6EXL9fsQ=
X-Google-Smtp-Source: ABdhPJwxp7DOu6dTJ8f4RSebCKAUuCrzoMOcHsoRA5Hjsf55bSOTyaNlTECLYCLKFGhVFKLexTYppA==
X-Received: by 2002:aed:2ca5:: with SMTP id g34mr2664qtd.337.1597367150693;
        Thu, 13 Aug 2020 18:05:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id n6sm6427956qkh.74.2020.08.13.18.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 18:05:49 -0700 (PDT)
Subject: Re: [PATCH 01/11] maintenance: create basic maintenance runner
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
 <2b9deb6d6a23e53bec75e109f2e3ef9217420425.1596728921.git.gitgitgadget@gmail.com>
 <20200812210326.GA104953@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b9db68dc-95a8-f8c3-a015-9d3390e30f7c@gmail.com>
Date:   Thu, 13 Aug 2020 21:05:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200812210326.GA104953@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/12/2020 5:03 PM, Jonathan Nieder wrote:
> Derrick Stolee wrote:
> 
>> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  .gitignore                        |  1 +
>>  Documentation/git-maintenance.txt | 57 +++++++++++++++++++++++++++++++
>>  builtin.h                         |  1 +
>>  builtin/gc.c                      | 57 +++++++++++++++++++++++++++++++
>>  git.c                             |  1 +
>>  t/t7900-maintenance.sh            | 19 +++++++++++
>>  t/test-lib-functions.sh           | 33 ++++++++++++++++++
>>  7 files changed, 169 insertions(+)
>>  create mode 100644 Documentation/git-maintenance.txt
>>  create mode 100755 t/t7900-maintenance.sh
> 
> Looks reasonable.
> 
> [...]
>> --- /dev/null
>> +++ b/Documentation/git-maintenance.txt
>> @@ -0,0 +1,57 @@
>> +git-maintenance(1)
>> +==================
>> +
>> +NAME
>> +----
>> +git-maintenance - Run tasks to optimize Git repository data
>> +
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git maintenance' run [<options>]
>> +
>> +
>> +DESCRIPTION
>> +-----------
>> +Run tasks to optimize Git repository data, speeding up other Git commands
>> +and reducing storage requirements for the repository.
>> ++
>> +Git commands that add repository data, such as `git add` or `git fetch`,
>> +are optimized for a responsive user experience. These commands do not take
>> +time to optimize the Git data, since such optimizations scale with the full
>> +size of the repository while these user commands each perform a relatively
>> +small action.
>> ++
>> +The `git maintenance` command provides flexibility for how to optimize the
>> +Git repository.
>> +
>> +SUBCOMMANDS
>> +-----------
>> +
>> +run::
>> +	Run one or more maintenance tasks.
> 
> This is still confusing --- shouldn't it say something like "Run the
> `gc` maintenance task (see below)"?

As I mentioned in the earlier version, I disagree with this.

> [...]
>> +TASKS
>> +-----
>> +
>> +gc::
>> +	Cleanup unnecessary files and optimize the local repository. "GC"
> 
> nit: cleanup is the noun, "clean up" is the verb
> 
>> +	stands for "garbage collection," but this task performs many
>> +	smaller tasks. This task can be rather expensive for large
> 
> nit: the word "rather" is not doing much work here, so we could leave
> it out

Both good.

> 
>> +	repositories, as it repacks all Git objects into a single pack-file.
>> +	It can also be disruptive in some situations, as it deletes stale
>> +	data.
> 
> What stale data is this referring to?  Where can I read more about
> what disruption it causes (or in other words, as a user, how would I
> decide when *not* to run this command)?

For this and the next comment, I prefer (for now) to keep all of the
deep details of the 'gc' task in the git-gc.txt documentation. However,
I should use "linkgit:git-gc[1]" to point users to that for reference.

Eventually, the maintenance builtin might replace the gc builtin, but
only after all of its behavior has been extracted into smaller tasks.
Those tasks would be documented in detail here, allowing us to make the
blurb for the 'gc' task be "Run the 'prune-reflog', 'pack-refs', ...,
and 'full-repack' tasks."

> [...]
>> +OPTIONS
>> +-------
>> +--auto::
>> +	When combined with the `run` subcommand, run maintenance tasks
>> +	only if certain thresholds are met. For example, the `gc` task
>> +	runs when the number of loose objects exceeds the number stored
>> +	in the `gc.auto` config setting, or when the number of pack-files
>> +	exceeds the `gc.autoPackLimit` config setting.
> 
> Hm, today I learned.  I had thought that --auto doesn't only affect
> thresholds but also would affect how aggressive the gc is when
> triggered, but the git-gc(1) manpage agrees with what's said above.
> 
> Is there a way we can share information between the two to avoid one
> falling out of date?  For example, should git-gc.txt point to this
> page for the authoritative description?

I remember Junio mentioning something about how 'gc' interprets '--auto'
as a "quick" mode, but like you I cannot find any reference to that in
the docs. Since it is not documented there and none of the other tasks
I am implementing here use that interpretation, I'll plan to leave this
portion as-is.
 
> [...]
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -699,3 +699,60 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>  
>>  	return 0;
>>  }
>> +
>> +static const char * const builtin_maintenance_usage[] = {
>> +	N_("git maintenance run [<options>]"),
> 
> not about this patch: I wish we could automatically generate a usage
> string in this simple kind of case, to decrease the burden on
> translators.
> 
> [...]
>> +static int maintenance_task_gc(struct maintenance_opts *opts)
>> +{
>> +	struct child_process child = CHILD_PROCESS_INIT;
>> +
>> +	child.git_cmd = 1;
>> +	strvec_push(&child.args, "gc");
>> +
>> +	if (opts->auto_flag)
>> +		strvec_push(&child.args, "--auto");
>> +
>> +	close_object_store(the_repository->objects);
> 
> Interesting --- what does this function call do?

We need to close our file handles on the pack-files (and
commit-graph and multi-pack-index) or else the GC subcommand
cannot delete the files on Windows.

>> +	return run_command(&child);
>> +}
>> +
>> +static int maintenance_run(struct maintenance_opts *opts)
>> +{
>> +	return maintenance_task_gc(opts);
>> +}
>> +
>> +int cmd_maintenance(int argc, const char **argv, const char *prefix)
>> +{
>> +	static struct maintenance_opts opts;
>> +	static struct option builtin_maintenance_options[] = {
>> +		OPT_BOOL(0, "auto", &opts.auto_flag,
>> +			 N_("run tasks based on the state of the repository")),
>> +		OPT_END()
>> +	};
> 
> optional: these could be local instead of static

I see my problem here. The builtin_maintenance_options is static
(copied from another builtin, I'm sure) which is why the 'opts'
struct needs to be static or else this doesn't compile.

>> +
>> +	memset(&opts, 0, sizeof(opts));
> 
> not needed if it's static.  If it's not static, could use `opts = {0}`
> where it's declared to do the same thing in a simpler way.
> 
>> +
>> +	if (argc == 2 && !strcmp(argv[1], "-h"))
>> +		usage_with_options(builtin_maintenance_usage,
>> +				   builtin_maintenance_options);
>> +
>> +	argc = parse_options(argc, argv, prefix,
>> +			     builtin_maintenance_options,
>> +			     builtin_maintenance_usage,
>> +			     PARSE_OPT_KEEP_UNKNOWN);
>> +
>> +	if (argc == 1) {
>> +		if (!strcmp(argv[0], "run"))
>> +			return maintenance_run(&opts);
>> +	}
>> +
>> +	usage_with_options(builtin_maintenance_usage,
>> +			   builtin_maintenance_options);
> 
> optional: could reverse this test to get the uninteresting case out of
> the way first:
> 
> 	if (argc != 1)
> 		usage ...
> 
> 	...
> 
> That would also allow making the usage string when argv[0] is not
> "run" more specific.

Sure. Were you thinking of anything more specific than

	die(_("invalid subcommand: %s"), argv[0]);

? Of course, running "git maintenance barf" would result in

	fatal: invalid subcommand: barf

with an exit code of 128 instead of 129 like the usage string does,
so I'm not sure of the best way to make a custom "usage" error.

> [...]
>> --- /dev/null
>> +++ b/t/t7900-maintenance.sh
>> @@ -0,0 +1,19 @@
>> +#!/bin/sh
>> +
>> +test_description='git maintenance builtin'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'help text' '
>> +	test_expect_code 129 git maintenance -h 2>err &&
>> +	test_i18ngrep "usage: git maintenance run" err
>> +'
>> +
>> +test_expect_success 'run [--auto]' '
>> +	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
>> +	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
>> +	test_subcommand git gc <run-no-auto.txt &&
>> +	test_subcommand git gc --auto <run-auto.txt
> 
> Nice.
> 
> [...]
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -1561,3 +1561,36 @@ test_path_is_hidden () {
>>  	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
>>  	return 1
>>  }
>> +
>> +# Check that the given command was invoked as part of the
>> +# trace2-format trace on stdin.
>> +#
>> +#	test_subcommand [!] <command> <args>... < <trace>
>> +#
>> +# For example, to look for an invocation of "git upload-pack
>> +# /path/to/repo"
>> +#
>> +#	GIT_TRACE2_EVENT=event.log git fetch ... &&
>> +#	test_subcommand git upload-pack "$PATH" <event.log
>> +#
>> +# If the first parameter passed is !, this instead checks that
>> +# the given command was not called.
>> +#
>> +test_subcommand () {
>> +	local negate=
>> +	if test "$1" = "!"
>> +	then
>> +		negate=t
>> +		shift
>> +	fi
>> +
>> +	local expr=$(printf '"%s",' "$@")
>> +	expr="${expr%,}"
>> +
>> +	if test -n "$negate"
>> +	then
>> +		! grep "\[$expr\]"
>> +	else
>> +		grep "\[$expr\]"
>> +	fi
>> +}
> 
> With whatever subset of the changes described above makes sense,
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks for your patient work.

Thanks,
-Stolee

