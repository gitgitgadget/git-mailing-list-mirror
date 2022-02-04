Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0B1C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 04:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356913AbiBDELO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 23:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240714AbiBDELN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 23:11:13 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D51C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 20:11:13 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h8so4716773qtk.13
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 20:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=Frd2pppSuWvY338Tu8o4JzXOjp0A71adIn7mzgQQuFg=;
        b=C/aIcBqyXfO56TjpmqtjSqcwfVplxgkHvh0qlxDqW5REPWnsW5MV69CMuLTCexQ13U
         IV41HcsNiANlgKxTQ6hSa8kT/12/qdUERs9BP3ouY2N1O0iLrU1VuCzWswow46nOjbZL
         lNLcNrZkntXxvk07zp4urefyiKmByjC+iOGYqKWCza6yQ4Obfhke1/fljrS1iKY9Rq4S
         n1jWW4PmQQ86h+/G9dhWWM7tAsBVwlb5eG1/Pz9E6tnYKxicY7uuiScZq8eCiWiUTgws
         P0zCpwCoszgAKQC2Cqyn4SiUNV4/mMCJzFVJlbgRrJUsuv55Kkdu6A+eC0NFLwCiMAI9
         stoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=Frd2pppSuWvY338Tu8o4JzXOjp0A71adIn7mzgQQuFg=;
        b=jvKs1jJyEmDWHx/voNreMMK6X359OjcCXKo1P8IGp1XkwMVi2B8LaCLqg0rduy1/ly
         ynQ5rypVIs3Px8qcwj9fyyDvvuN/6yykdCqpPdiNgRu3DkIl8rllNbUOZojGNiWEurMa
         UDz3R/ogjRW8pmKrogajNwpmsEmP+yb/zTgT14OZF6/CBSR9LgS7Nn45pSqex3Y1CWaY
         baqqlpMYszSVJoOYIKI34XxdBSIGsTGF9lECWNX81G8YqLof17RICxVal4V7O/jCLGuD
         o5sKL+jYA2blIdV6u2AveilecE5fUFmsTJ7ygmSl/3hrPh7nEbTh+1rT/E/OIz2PCdkA
         sa2g==
X-Gm-Message-State: AOAM530nCEHXqEXEk0qKJmeaQ7ldflOGEWISZ9MmX4tDFHx1qRw9FTpy
        Cl4L7UxZi656tIR8j6zWlJM=
X-Google-Smtp-Source: ABdhPJxkrPn/doyG0yJBZFe9w6Fe3UB7po/qACtLJM1anH6tR5gx81R+5UL9U4d/hye7ELSQv6XvhQ==
X-Received: by 2002:ac8:5891:: with SMTP id t17mr859928qta.285.1643947872751;
        Thu, 03 Feb 2022 20:11:12 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id x4sm445134qkm.47.2022.02.03.20.11.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Feb 2022 20:11:12 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com
Subject: Re: [PATCH 2/2] catfile.c: add --batch-command mode
Date:   Thu, 03 Feb 2022 23:11:10 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <74E01F50-D5B4-41F0-A6F0-BBCA462ED74A@gmail.com>
In-Reply-To: <xmqqo83nsoxs.fsf@gitster.g>
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
 <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
 <xmqqo83nsoxs.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, thanks for the review!

On 3 Feb 2022, at 14:57, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Subject: Re: [PATCH 2/2] catfile.c: add --batch-command mode
>
> "cat-file: add --batch-command mode" perhaps.  The patch touching
> the file "catfile.c" (which does not even exist) is an irrelevant
> implementation detail to spend 2 extra bytes in "git shortlog"
> output.
>
>> From: John Cai <johncai86@gmail.com>
>>
>> Add new flag --batch-command that will accept commands and arguments
>> from stdin, similar to git-update-ref --stdin.
>>
>> At GitLab, we use a pair of long running cat-file processes when
>> accessing object content. One for iterating over object metadata with
>> --batch-check, and the other to grab object contents with --batch.
>>
>> However, if we had --batch-command, we wouldnt need to keep both
>> processes around, and instead just have one process where we can flip
>> between getting object info, and getting object contents. This means we
>> can get rid of roughly half of long lived git cat-file processes. This
>> can lead to huge savings since on a given server there could be hundreds
>> of git cat-file processes running.
>
> Hmph, why hundreds, not two you listed?
>
> Do you mean "we have two per repository, but by combining, we can do
> with just one per repository, halving the number of processes"?

Yes, exactly. I'll reword this in the next version to be more clear.

>
>> git cat-file --batch-command
>>
>> would enter an interactive command mode whereby the user can enter in
>> commands and their arguments:
>>
>> <command> [arg1] [arg2] NL
>>
>> This patch adds the basic structure for add command which can be
>> extended in the future to add more commands.
>>
>> This patch also adds the following commands:
>>
>> contents <object> NL
>> info <object> NL
>>
>> The contents command takes an <object> argument and prints out the object
>> contents.
>>
>> The info command takes a <object> argument and prints out the object
>> metadata.
>>
>> In addition, we need a set of commands that enable a "read session".
>>
>> When a separate process (A) is connected to a git cat-file process (B)
>
> This description misleads readers into thinking as if we have just
> created a daemon process that is running, and an unrelated process
> can connect to it, which obviously poses a question about securing
> the connection.  It is my understanding that what this creates is
> just a consumer process (A) starts the cat-file process (B) locally
> on its behalf under process (A)'s privilege, and they talk over pipe
> without allowing any third-party to participate in the exchange, so
> we should avoid misleading users by saying "is connected to" here.

Yes this understanding is correct. Will fix wording in next version

>
>> and is interactively writing to and reading from it in --buffer mode,
>> (A) needs to be able to know when the buffer is flushed to stdout.
>
> If A and B are talking over a pair pipes, in order to avoid
> deadlocking, both ends need to be able to control whose turn it is
> to speak (and it is turn for the other side to listen).  A needs to
> be able to _control_ (not "know") when the buffer it uses to write
> to B gets flushed, in order to reliably say "I am done for now, it
> is your turn to speak" and be assured that it reaches B.  The story
> is the same for the other side.  When a request by A needs to be
> responded with multiple lines of output, B needs to be able to say
> "And that concludes my response, and I am ready to accept a new
> request from you" and make sure it reaches A.  "know when..." is
> probably a wrong phrase here.

Correct, "know" is not exactly right. _control_ would be the more accurate description.
>
>> Currently, from (A)'s perspective, the only way is to either 1. exit
>> (B)'s process or 2. send an invalid object to stdin. 1. is not ideal
>> from a performance perspective as it will require spawning a new cat-file
>> process each time, and 2. is hacky and not a good long term solution.
>
> Writing enumeration as bulletted or enumerated list would make it
> much easier to read, I would think.
>
>     From (A)'s perspective, the only way is to either
>
>     1. exit (B)'s process or
>     2. send an invalid object to stdin.
>
>     1. is not ideal from a performance perspective, as it will
>     require spawning a new cat-file process each time, and 2. is
>     hacky and not a good long term solution.
>
> I am not sure what you exactly mean by "exit" in the above.  Do you
> mean "kill" instead?

Yes

>
>> With the following commands, process (A) can begin a "session" and
>> send a list of object names over stdin. When "get contents" or "get info"
>> is issued, this list of object names will be fed into batch_one_object()
>> to retrieve either info or contents. Finally an fflush() will be called
>> to end the session.
>>
>> begin NL
>> get contents NL
>> get info NL
>>
>> These can be used in the following way:
>>
>> begin
>> <sha1>
>> <sha1>
>> <sha1>
>> <sha1>
>> get info
>>
>> begin
>> <sha1>
>> <sha1>
>> <sha1>
>> <sha1>
>> get contents
>>
>> With this mechanism, process (A) can be guaranteed to receive all of the
>> output even in --buffer mode.
>
> OK, so do these "get blah" serve both as command and an implicit
> "flush"?

yes, that's the idea.

>
> With an implicit "flush", do we really need "begin"?
>
> Also, from the point of view of extensibility, not saying what kind
> of operation is started when given "begin" is probably not a good
> idea.  "get info" and "get contents" may happen to be the only
> commands that are supported right now, and the parameters to them
> may happen to be just list of object names and nothing else, but
> what happens when a new "git frotz" command is added and its
> operation is extended with something other than object names and
> pathnames?  The way to parse these parameter lines for the "get"
> would be different for different commands, and if "cat-file" knows
> upfront what is to be done to these parameters, it can even start
> prefetching and precomputing to reduce latency observed by the
> client before the final "get info" command is given.
>
> So, from that point of view,
>
>     begin <cmd>
>     <parameter>
>     <parameter>
>     ...
>     end
>
> may be a better design, no?

Good point. Now I'm wondering if we can simplify where commands get queued up
and a "get" will execute them along with an implicit flush.

<cmd> <parameter>
<cmd> <parameter>
<cmd> <parameter>
get
