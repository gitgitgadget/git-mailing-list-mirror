Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A02D208E9
	for <e@80x24.org>; Wed,  1 Aug 2018 15:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389733AbeHARhE (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:37:04 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:26544 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389557AbeHARhD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:37:03 -0400
Received: from [192.168.2.240] ([92.22.30.174])
        by smtp.talktalk.net with SMTP
        id ktOafIDWvdJAektOafP6th; Wed, 01 Aug 2018 16:50:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533138641;
        bh=ttHAYuqpHoZWRampivR+rzemtTGHqHn4M19LSkhEkZw=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=abew/cNw8tTBzV+a3g/f7BitfbHjgnNTyaaJaF51ZmEf/YrthBmfLCA4K6wLo4sVJ
         5+HAn+SgVi6yUbE+s8M5GopXoMxoRsfMj98nGEzCKnbxB5/xucF4T226ubIn9yg8T8
         9DZ6HOSVWdMKsD3xsslepM63l4qozHaiy9eR3VKI=
X-Originating-IP: [92.22.30.174]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=2xfjePbNG5I+/HyESt+5YA==:117
 a=2xfjePbNG5I+/HyESt+5YA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=5rxgeBVgAAAA:8 a=BCjA09oAAAAA:8 a=evINK-nbAAAA:8 a=2DLnnMrOBO9anznuW98A:9
 a=clQxp3oRzjrkGuJY:21 a=WJUMhjpDC4c25wPA:21 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=jYKBPJSq9nmHKCndOPe9:22 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] sequencer: fix quoting in write_author_script
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731111532.9358-1-phillip.wood@talktalk.net>
 <20180731111532.9358-3-phillip.wood@talktalk.net>
 <CAPig+cR5VHP8muo5_A_9t7OPZam8O_uPb0nd73B15Ye92n+p7Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1f9a9062-445d-0c37-9b21-941d8fef659b@talktalk.net>
Date:   Wed, 1 Aug 2018 16:50:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cR5VHP8muo5_A_9t7OPZam8O_uPb0nd73B15Ye92n+p7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIynKZRWAixhtJNrn/JkePCHccvPEJntCU7UTYSjCZsLHjTVj8DyChgc7DEaPur4IMujv8Or1Jj/8LyOoAZ/2i7QudtdYeIzZOv8xPGctzpLn1e+NseM
 w1ZzZo1Pf9tp3UQ99RpErXhAxM7DpSViTvuZG5ejIoJW1C2UJqtzOUUZWKeTBvNRXr4919MRW9yZJZdA5sixyPYECJxxKvQnnOrxcgFvSNTeumquIyRd+v6Z
 7nPavs9Vo2GQ+DDtCONBZn7tYcAtkLKSh4HgbkguE3DvMtlro8LZYCr+0S2MnoKGxa48w+89IKqkKV9AvWjQvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/07/18 22:39, Eric Sunshine wrote:
> On Tue, Jul 31, 2018 at 7:15 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> Single quotes should be escaped as \' not \\'. Note that this only
>> affects authors that contain a single quote and then only external
>> scripts that read the author script and users whose git is upgraded from
>> the shell version of rebase -i while rebase was stopped. This is because
>> the parsing in read_env_script() expected the broken version and for
>> some reason sq_dequote() called by read_author_ident() seems to handle
>> the broken quoting correctly.
> 
> Is the:
> 
>      ...for some reason sq_dequote() called by read_author_ident()
>      seems to handle the broken quoting correctly.
> 
> bit outdated? We know now from patch 2/4 of my series[1] that
> read_author_ident() wasn't handling it correctly at all. It was merely
> ignoring the return value from sq_dequote() and using whatever broken
> value came back from it.
> 
> [1]: https://public-inbox.org/git/20180731073331.40007-3-sunshine@sunshineco.com/
> 
>> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> diff --git a/sequencer.c b/sequencer.c
>> @@ -664,14 +664,25 @@ static int write_author_script(const char *message)
>>   static int read_env_script(struct argv_array *env)
>>   {
>>          if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>>                  return -1;
> 
> This is not a problem introduced by this patch, but since
> strbuf_read_file() doesn't guarantee that memory hasn't been allocated
> when it returns an error, this is leaking.
> 
>> +       /*
>> +        * write_author_script() used to fail to terminate the GIT_AUTHOR_DATE
>> +        * line with a "'" and also escaped "'" incorrectly as "'\\\\''" rather
>> +        * than "'\\''". We check for the terminating "'" on the last line to
>> +        * see how "'" has been escaped in case git was upgraded while rebase
>> +        * was stopped.
>> +        */
>> +       sq_bug = script.len && script.buf[script.len - 2] != '\'';
> 
> I think you need to be checking 'script.len > 1', not just
> 'script.len', otherwise you might access memory outside the allocated
> buffer.
> 
> This is a very "delicate" check, assuming that a hand-edited file
> won't end with, say, an extra newline. I wonder if this level of
> backward-compatibility is overkill for such an unlikely case.

I think I'll get rid of the check and instead use a version number 
written to .git/rebase-merge/interactive to indicate if we need to fix 
the quoting (if there's no number then it needs fixing). We can 
increment the version number in the future if we ever need to implement 
other fallbacks to handle the case where git got upgraded while rebase 
was stopped. I'll send a patch tomorrow

Best Wishes

Phillip

> 
>>          for (p = script.buf; *p; p++)
>> -               if (skip_prefix(p, "'\\\\''", (const char **)&p2))
>> +               if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
>> +                       strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
>> +               else if (skip_prefix(p, "'\\''", &p2))
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> @@ -75,6 +75,22 @@ test_expect_success 'rebase --keep-empty' '
>> +test_expect_success 'rebase -i writes correct author-script' '
>> +       test_when_finished "test_might_fail git rebase --abort" &&
>> +       git checkout -b author-with-sq master &&
>> +       GIT_AUTHOR_NAME="Auth O$SQ R" git commit --allow-empty -m with-sq &&
>> +       set_fake_editor &&
>> +       FAKE_LINES="edit 1" git rebase -ki HEAD^ &&
> 
> Hmph, -k doesn't seem to be documented in git-rebase.txt. Is it needed here?
> 

