Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B071FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 20:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756555AbcLTUtR (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 15:49:17 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35203 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756519AbcLTUtP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 15:49:15 -0500
Received: by mail-qt0-f173.google.com with SMTP id c47so188323867qtc.2
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OE3sUJOnuQSFDe8qMf5aWUG3DMx05tXo0wpSfqVQRUw=;
        b=Db9XEpLTvHZOlqFhzMBAbcQhR+zWNLOQwRIK56h1/Tb2HbB2f1trSyLl07SgdEEP8w
         kU6YdFmBKv9t0wSHxgLvgKlyzBJyRjimPZVc1b0IHsYU0C/fm24rq66s5cYkdh8Wbo8t
         7A7ch6KB/p7eIgBhnG4ex9j2YykEuIaG++/Y4uCt+0ZMNyP66teEUtSdLf9ozphvjZOW
         WV2WeL63KmgJH4AQJ3T+PxQURmv7dp8vhB4I0a6BVxWtxQhvrspQBmPONkKcSDhzwNt9
         1cDdGDM3/1zgsaeVUww2F8V8xcXXR82VN1LTsAZm4Kfo0jcqYs7y3RgWki1uFNow0TnI
         vPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OE3sUJOnuQSFDe8qMf5aWUG3DMx05tXo0wpSfqVQRUw=;
        b=jGH/JjDcIolYs4CsVlJnh5bB+osP9KbLACBuWhLJzXCPfDmjj5VcQ//Wu3TkBGZ7wm
         BA9jDf6D0FyrSDw0z6+ic2p4UwF8jXnnzgN+UDNRu95CyezJQWEYer+cGLE2v5Mt+MSz
         6A7wO9j/NhrHhARBQ2t8PTlyFLotuaVCNsavpsvnBteNYmr3uXeUsabglMsAAUxhI3H4
         ja3QirWgQCNwsA91uh+Rk9fsqC19bm2NlsrOEzLqhS82+9WyBo1I5jV7hmBRmwVAUqLw
         tkU+QDYp8SLWDYZDiskEJ9Tdr+D+Y6ARSJ2LndQ00IKOaf+ImmtB7DregA/YqvoW5L+X
         DRJA==
X-Gm-Message-State: AIkVDXLSzxVEbyuoQUKjsFn+bz8SJtKp3YGbupo4fBJsQQBK/qnaVBfhQgBKaBqi+dDhww5FByiK3RrpMLljFsHb
X-Received: by 10.237.34.206 with SMTP id q14mr1346927qtc.101.1482266953822;
 Tue, 20 Dec 2016 12:49:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 20 Dec 2016 12:49:13 -0800 (PST)
In-Reply-To: <f14ee492-8297-c8ec-f80f-f8f24caf91e1@kdbg.org>
References: <20161219232828.5075-1-sbeller@google.com> <20161219232828.5075-4-sbeller@google.com>
 <aad0af97-7588-632d-a113-5d8372b8b7a8@kdbg.org> <CAGZ79kYNKWfnEXWJfyRUutFyaQiRD9qW--LkK4Nbwdf7FtdPQA@mail.gmail.com>
 <f14ee492-8297-c8ec-f80f-f8f24caf91e1@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Dec 2016 12:49:13 -0800
Message-ID: <CAGZ79kYG-veuWNFh6G1g5MiQHBGk2i1qbH_NBtnMS6jFcoWocg@mail.gmail.com>
Subject: Re: [PATCHv4 3/5] run-command: add {run,start,finish}_command_or_die
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 12:12 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 20.12.2016 um 20:23 schrieb Stefan Beller:
>>
>> In a reroll I'll drop this patch and instead introduce
>> a function `char *get_child_command_line(struct child_process*);`, which
>> a caller can call before calling finish_command and then use the
>> resulting string
>> to assemble an error message without lego.
>
>
> That sounds a lot better, thank you. Note though, that the function would
> have to be called before start_command(), because when it fails, it would be
> too late.

Yes, the pattern to use it would be

    // first assemble the child process struct with conditions

    char *cmdline = get_child_command_line(&child)

    if (start_command(&child))
        // use cmdline here for error reporting.


>
> I have to ask, though: Is it so much necessary to report the exact command
> line in an error message?

Have a look at https://github.com/git/git/blob/master/submodule.c#L1122

    die("Could not run 'git status --porcelain -uall \
        --ignore-submodules=none' in submodule %s", path);

There are 2 things:
1) The error message is not very informative, as your question hints at.
    I consider changing it to add more meaning. I think the end user
    would also be interested in "Why did we run this command?".
2) We really want to report the correct command line here.
    Currently that is the case, but if you look at the prior patch that extends
    the arguments conditionally (and then also uses the same condition
    to format the error message... that hints at hard to maintain error
    messages.)

So the new proposed function really only addresses 2) here.

> If someone is interested in which command failed,
> it would be "sufficient" to run the command under GIT_TRACE=2.
>

Yes, while at it, I may just move up the error reporting to the builtin
command giving a higher level message.

Thanks,
Stefan
