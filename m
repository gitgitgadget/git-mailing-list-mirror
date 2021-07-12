Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E0C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFD76120A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhGLT0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:26:23 -0400
Received: from siwi.pair.com ([209.68.5.199]:16886 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236218AbhGLT0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 15:26:23 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7F9FB3F4096;
        Mon, 12 Jul 2021 15:23:34 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3BE7D3F4095;
        Mon, 12 Jul 2021 15:23:34 -0400 (EDT)
Subject: Re: [PATCH v3 02/34] fsmonitor--daemon: man page
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5db2c0390a657d5790cf24404201505c4ec3a829.1625150864.git.gitgitgadget@gmail.com>
 <877di9d5uz.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <533d47fc-ea37-1e6a-b6f4-ac4fdd24555e@jeffhostetler.com>
Date:   Mon, 12 Jul 2021 15:23:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <877di9d5uz.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 6:29 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create a manual page describing the `git fsmonitor--daemon` feature.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   Documentation/git-fsmonitor--daemon.txt | 75 +++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>   create mode 100644 Documentation/git-fsmonitor--daemon.txt
>>
>> diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
>> new file mode 100644
>> index 00000000000..154e7684daa
>> --- /dev/null
>> +++ b/Documentation/git-fsmonitor--daemon.txt
>> @@ -0,0 +1,75 @@
>> +git-fsmonitor--daemon(1)
>> +========================
>> +
>> +NAME
>> +----
>> +git-fsmonitor--daemon - A Built-in File System Monitor
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git fsmonitor--daemon' start
>> +'git fsmonitor--daemon' run
>> +'git fsmonitor--daemon' stop
>> +'git fsmonitor--daemon' status
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +A daemon to watch the working directory for file and directory
>> +changes using platform-specific file system notification facilities.
>> +
>> +This daemon communicates directly with commands like `git status`
>> +using the link:technical/api-simple-ipc.html[simple IPC] interface
>> +instead of the slower linkgit:githooks[5] interface.
>> +
>> +This daemon is built into Git so that no third-party tools are
>> +required.
>> +
>> +OPTIONS
>> +-------
>> +
>> +start::
>> +	Starts a daemon in the background.
>> +
>> +run::
>> +	Runs a daemon in the foreground.
>> +
>> +stop::
>> +	Stops the daemon running in the current working
>> +	directory, if present.
>> +
>> +status::
>> +	Exits with zero status if a daemon is watching the
>> +	current working directory.
>> +
>> +REMARKS
>> +-------
>> +
>> +This daemon is a long running process used to watch a single working
>> +directory and maintain a list of the recently changed files and
>> +directories.  Performance of commands such as `git status` can be
>> +increased if they just ask for a summary of changes to the working
>> +directory and can avoid scanning the disk.
>> +
>> +When `core.useBuiltinFSMonitor` is set to `true` (see
>> +linkgit:git-config[1]) commands, such as `git status`, will ask the
>> +daemon for changes and automatically start it (if necessary).
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
>> +will properly ignore these extra events, so performance may be affected
>> +but it will not cause an incorrect result.
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
> 
> Later in the series we incrementally add features to the daemon, so this
> is describing a state that doesn't exist yet at this point.
> 
> I think it would be better to start with a stup here and add
> documentation as we add features, e.g. the patch tha adds "start" should
> add that to the synopsis + options etc.
> 
> See the outstanding ab/config-based-hooks-base for a small example of
> that.
> 

I like to lead the series with the documentation that summarizes the
purpose of the entire feature or patch series.  This gives the reviewer
the context for the complete series that follows.  In the past, we've
had discussions on the list about how hard it is to review a series when
the foo.c comes (alphabetically) before foo.h in the patch and all
the documentation is attached to the prototypes in the .h file so the
reviewer needs to bounce around in the patch or series to read the
intent and then go back to the beginning to read the code.  In that
spirit, I think that having the complete man page come first provides
necessary context and is helpful.

The argument that the man-page should grow as the feature grows
presumes that there is a meaningful cut-point mid-series where you
would adopt the first portion and delay the second to a later release
or something.  That division would not be useful/usable.

And it just clutters up later commits in the series with man-page
deltas.

So I'd like to keep it as it unless there are further objections.

Jeff

