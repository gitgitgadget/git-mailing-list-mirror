Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FC3C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 13:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAF361441
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 13:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhD1NzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:55:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:41285 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhD1NzK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 09:55:10 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9B1703F40E4;
        Wed, 28 Apr 2021 09:54:24 -0400 (EDT)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 695323F40DA;
        Wed, 28 Apr 2021 09:54:24 -0400 (EDT)
Subject: Re: [PATCH 01/23] fsmonitor--daemon: man page and documentation
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <074273330f8d6c656dfec7c8778fad20314c6ad1.1617291666.git.gitgitgadget@gmail.com>
 <b868522c-f07f-c431-aa2c-14af84015ced@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e3ef8d87-355e-d3df-9f04-fb52456734dd@jeffhostetler.com>
Date:   Wed, 28 Apr 2021 09:54:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b868522c-f07f-c431-aa2c-14af84015ced@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 10:13 AM, Derrick Stolee wrote:
> On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create a manual page describing the `git fsmonitor--daemon` feature.
>>
>> Update references to `core.fsmonitor`, `core.fsmonitorHookVersion` and
>> pointers to `watchman` to mention the built-in FSMonitor.
> 
> Make sense to add clarity here, since there will be new ways
> to interact with a fileystem monitor.
>>   core.fsmonitorHookVersion::
>> -	Sets the version of hook that is to be used when calling fsmonitor.
>> -	There are currently versions 1 and 2. When this is not set,
>> -	version 2 will be tried first and if it fails then version 1
>> -	will be tried. Version 1 uses a timestamp as input to determine
>> -	which files have changes since that time but some monitors
>> -	like watchman have race conditions when used with a timestamp.
>> -	Version 2 uses an opaque string so that the monitor can return
>> -	something that can be used to determine what files have changed
>> -	without race conditions.
>> +	Sets the version of hook that is to be used when calling the
>> +	FSMonitor hook (as configured via `core.fsmonitor`).
>> ++
>> +There are currently versions 1 and 2. When this is not set,
>> +version 2 will be tried first and if it fails then version 1
>> +will be tried. Version 1 uses a timestamp as input to determine
>> +which files have changes since that time but some monitors
>> +like watchman have race conditions when used with a timestamp.
>> +Version 2 uses an opaque string so that the monitor can return
>> +something that can be used to determine what files have changed
>> +without race conditions.
> 
> This initially seemed like a big edit, but you just split the single
> paragraph into multiple, with a better leading sentence and a final
> statement about the built-in FSMonitor. Good.
>> ++
>> +Note: FSMonitor hooks (and this config setting) are ignored if the
>> +built-in FSMonitor is enabled (see `core.useBuiltinFSMonitor`).
>> +
>> +core.useBuiltinFSMonitor::
>> +	If set to true, enable the built-in filesystem event watcher (for
>> +	technical details, see linkgit:git-fsmonitor--daemon[1]).
>> ++
>> +Like external (hook-based) FSMonitors, the built-in FSMonitor can speed up
>> +Git commands that need to refresh the Git index (e.g. `git status`) in a
>> +worktree with many files. The built-in FSMonitor facility eliminates the
>> +need to install and maintain an external third-party monitoring tool.
>> ++
>> +The built-in FSMonitor is currently available only on a limited set of
>> +supported platforms.
> 
> Is there a way for users to know this set of platforms? Can they run
> a command to find out? Will 'git fsmonitor--daemon --start' send a
> helpful message to assist here? Or, could there be a 'git
> fsmonitor--daemon --test' command?

I do have a `git fsmonitor--daemon --is-supported` option.  It will
exit with 0 if the current platform is supported.

It would probably be helpful to list the current platforms and/or
add a statement about the `--is-supported` command here.

> 
>> +Note: if this config setting is set to `true`, any FSMonitor hook
>> +configured via `core.fsmonitor` (and possibly `core.fsmonitorHookVersion`)
>> +is ignored.
> ...
>> +git-fsmonitor--daemon(1)
>> +========================
>> +
>> +NAME
>> +----
>> +git-fsmonitor--daemon - Builtin file system monitor daemon
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git fsmonitor--daemon' --start
>> +'git fsmonitor--daemon' --run
>> +'git fsmonitor--daemon' --stop
>> +'git fsmonitor--daemon' --is-running
>> +'git fsmonitor--daemon' --is-supported
>> +'git fsmonitor--daemon' --query <token>
>> +'git fsmonitor--daemon' --query-index
>> +'git fsmonitor--daemon' --flush
> 
> These arguments with the "--" prefix make it seem like they are
> options that could be grouped together, but you really want these
> to be verbs within the daemon. What do you think about removing
> the "--" prefixes?

That's easy enough.  The OPT_CMDMODE() made it easy to do it this
way.

> 
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +Monitors files and directories in the working directory for changes using
>> +platform-specific file system notification facilities.
>> +
>> +It communicates directly with commands like `git status` using the
>> +link:technical/api-simple-ipc.html[simple IPC] interface instead of
>> +the slower linkgit:githooks[5] interface.
>> +
>> +OPTIONS
>> +-------
> 
> I typically view "OPTIONS" as arguments that can be grouped together,
> but you are describing things more like verbs or subcommands. The
> most recent example I know about is 'git maintenance <subcommand>',
> documented at [1].
> 
> [1] https://git-scm.com/docs/git-maintenance#_subcommands

Let me take a look at doing the subcommand way.

> 
>> +
>> +--start::
>> +	Starts the fsmonitor daemon in the background.
>> +
>> +--run::
>> +	Runs the fsmonitor daemon in the foreground.
>> +
>> +--stop::
>> +	Stops the fsmonitor daemon running for the current working
>> +	directory, if present.
> 
> I'm noticing "fsmonitor" in lowercase throughout this document. Is
> that the intended case for user-facing documentation? I've been
> seeing "FS Monitor", "filesystem monitor", or even "File System
> Monitor" in other places.

I think I want to rewrite this whole man-page and address all
of the different spellings and phrasing.


> 
>> +--is-running::
>> +	Exits with zero status if the fsmonitor daemon is watching the
>> +	current working directory.
> 
> Another potential name for this verb is "status".
> 
>> +--is-supported::
>> +	Exits with zero status if the fsmonitor daemon feature is supported
>> +	on this platform.
> 
> Ah, here is an indicator of whether the platform is supported. Please
> include details for this command in the earlier documentation. I'll
> check later to see if a message is also sent over 'stderr', which
> would be helpful. Documenting the exit status is good for third-party
> tools that might use this.
> 
>> +--query <token>::
>> +	Connects to the fsmonitor daemon (starting it if necessary) and
>> +	requests the list of changed files and directories since the
>> +	given token.
>> +	This is intended for testing purposes.
>> +
>> +--query-index::
>> +	Read the current `<token>` from the File System Monitor index
>> +	extension (if present) and use it to query the fsmonitor daemon.
>> +	This is intended for testing purposes.
> 
> These two could be grouped as "query [--token=X|--index]", especially
> because they are for testing purposes.
> 
>> +
>> +--flush::
>> +	Force the fsmonitor daemon to flush its in-memory cache and
>> +	re-sync with the file system.
>> +	This is intended for testing purposes.
> 
> Do you see benefits to these being available in the CLI? Could these
> be better served as a test helper?

I debated putting the 3 test options into a test helper.
Let me take a look at that.

> 
>> +REMARKS
>> +-------
>> +The fsmonitor daemon is a long running process that will watch a single
>> +working directory.  Commands, such as `git status`, should automatically
>> +start it (if necessary) when `core.useBuiltinFSMonitor` is set to `true`
>> +(see linkgit:git-config[1]).
>> +
>> +Configure the built-in FSMonitor via `core.useBuiltinFSMonitor` in each
>> +working directory separately, or globally via `git config --global
>> +core.useBuiltinFSMonitor true`.
>> +
>> +Tokens are opaque strings.  They are used by the fsmonitor daemon to
>> +mark a point in time and the associated internal state.  Callers should
>> +make no assumptions about the content of the token.  In particular,
>> +the should not assume that it is a timestamp.
>> +
>> +Query commands send a request-token to the daemon and it responds with
>> +a summary of the changes that have occurred since that token was
>> +created.  The daemon also returns a response-token that the client can
>> +use in a future query.
>> +
>> +For more information see the "File System Monitor" section in
>> +linkgit:git-update-index[1].
>> +
>> +CAVEATS
>> +-------
>> +
>> +The fsmonitor daemon does not currently know about submodules and does
>> +not know to filter out file system events that happen within a
>> +submodule.  If fsmonitor daemon is watching a super repo and a file is
>> +modified within the working directory of a submodule, it will report
>> +the change (as happening against the super repo).  However, the client
>> +should properly ignore these extra events, so performance may be affected
>> +but it should not cause an incorrect result.
> 
> There are several uses of the word "should" where I think "will" is a
> more appropriate word. That is, unless we do not actually have confidence
> in this behavior.

I think I was just being overly conservative in my language.

> 
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -498,7 +498,9 @@ FILE SYSTEM MONITOR
>>   This feature is intended to speed up git operations for repos that have
>>   large working directories.
>>   
>> -It enables git to work together with a file system monitor (see the
>> +It enables git to work together with a file system monitor (see
>> +linkgit:git-fsmonitor--daemon[1]
>> +and the
>>   "fsmonitor-watchman" section of linkgit:githooks[5]) that can
>>   inform it as to what files have been modified. This enables git to avoid
>>   having to lstat() every file to find modified files.
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index b51959ff9418..b7d5e926f7b0 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -593,7 +593,8 @@ fsmonitor-watchman
>>   
>>   This hook is invoked when the configuration option `core.fsmonitor` is
>>   set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
>> -depending on the version of the hook to use.
>> +depending on the version of the hook to use, unless overridden via
>> +`core.useBuiltinFSMonitor` (see linkgit:git-config[1]).
>>   
>>   Version 1 takes two arguments, a version (1) and the time in elapsed
>>   nanoseconds since midnight, January 1, 1970.
> 
> These are good connections to make.
> 
> Since the documentation for the fsmonitor--daemon is so deep, this
> patch might be served well to split into two: one that just documents
> the daemon, and another that updates existing documentation to point
> to the new file.

Good point.  Thanks!

> 
> This does provide a good basis for me to investigate during the rest
> of the review.
> 
> Thanks,
> -Stolee
> 

Thanks
Jeff
