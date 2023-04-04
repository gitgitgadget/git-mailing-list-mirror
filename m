Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A4BC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 13:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjDDNDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 09:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjDDNDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 09:03:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F198A19AC
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 06:03:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e18so32713698wra.9
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680613380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wCYzeVWXD/8afPUZRQzC0YzECLEm6ptWKLL0rNy4Ues=;
        b=FYmnnvLPDKX9/Tx45zv5iIytNvxHOwtsqkN2Ht1x0ofbOARMacSDlhBWG+inJCPT9z
         GdpVTSrgTcgSKTy7BR+8pGUS/VLwQM1sKApUP/zNxOtYlZmjpRIioFU3XDSlswzwzYIA
         hSNkTd6ivjqrrmIxET9nWFyJFqTLT9+jaZK7F2SqMNn912xKDbITsLcAgnwxONtvD2Zy
         /S+hRzjFHzHmnbDvLHwrw8qggRknBAolXTLzWdr4b9neyHrRnpeyxDQTJkG+rxCUPR6d
         iPIvRdf4w5tyKeWLLAzZgEI90jbdkxXqHunQMnXJVMB4kqHAvNyMMZSLvlcCyxsd3JIp
         kL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680613380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCYzeVWXD/8afPUZRQzC0YzECLEm6ptWKLL0rNy4Ues=;
        b=fdzgV6GJ44WsgB/oRknN4k0R23vSZSm2/M912yh9Vq/Mj/UdmOYq5AS3Bj5ReP+FSz
         x0/JQmbh+CmKP8hOe2ZTR5cYNbIBYuH2M/KXiy0NMDWQsuT4JwENsDrjiidYxjPDX3vA
         rQ+RiLLFbjr9Fg1fGyh+iQ2TqzxqU8f11fN0uwoXxxMo7ddhPVTzeJQ1dZ2ZPhHm6GcK
         l8clgbhweoezZ7gtBLGw4ytO+i+mIFmTETpnLggsUBOpJIMufewb/nt9mNfW9ASzu2+Q
         9q91Ba0iaxaFw5Ki5YGMiu/UfNNrkbr0mNvqRyaQ90xUE3Hq/oHNcP4SuzUJscl8ZwhY
         2CTg==
X-Gm-Message-State: AAQBX9dhc0AP1cG0w3YOSLPcwNyqMUED9C5t/hZlS/13TxFqM9wqQJX9
        d92Kr+YBupKTDqKVZ+tKxfS8nvSiW5g=
X-Google-Smtp-Source: AKy350bhTico8MN9yie+sDu4iP6SwUx/6FA4B9U7ZRwEUxe6gqCyV1FsxI25dq7Qol2ojW8LZi+LoA==
X-Received: by 2002:a5d:6391:0:b0:2e4:cc1c:1036 with SMTP id p17-20020a5d6391000000b002e4cc1c1036mr1595852wru.62.1680613380149;
        Tue, 04 Apr 2023 06:03:00 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id l4-20020a5d6744000000b002da76acfee1sm12235296wrw.28.2023.04.04.06.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:02:59 -0700 (PDT)
Message-ID: <743d228c-99d0-c753-e606-41208d00f246@gmail.com>
Date:   Tue, 4 Apr 2023 14:02:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] rebase -m: fix serialization of strategy options
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
 <9af68cb065871d9b89e99ef6b48870d322bb5faa.1678893298.git.phillip.wood@dunelm.org.uk>
 <CABPp-BF6_gmDCTo5j2fR5_KQfJYVuYZuYv6TdhsMvPYshXzu+g@mail.gmail.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BF6_gmDCTo5j2fR5_KQfJYVuYZuYv6TdhsMvPYshXzu+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04/2023 20:27, Elijah Newren wrote:
> On Wed, Mar 15, 2023 at 8:51 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> To store the strategy options rebase prepends " --" to each one and
>> writes them to a file. To load them it reads the file and passes the
>> contents to split_cmdline(). This roughly mimics the behavior of the
>> scripted rebase but has a couple of limitations, (1) options containing
>> whitespace are not properly preserved (this is true of the scripted
>> rebase as well) and (2) options containing '"' or '\' are incorrectly
>> parsed and may cause the parser to return an error.
>>
>> Fix these limitations by quoting each option when they are stored so
>> that they can be parsed correctly. Now that "--preserve-merges" no
>> longer exist this change also stops prepending "--" to the options when
>> they are stored as that was an artifact of the scripted rebase.
>>
>> These changes are backwards compatible so the files written by an older
>> version of git can be still be read. They are also forwards compatible,
>> the file can still be parsed by recent versions of git as they treat the
>> "--" prefix as optional.
> 
> I'm not sure we want to tie ourselves to support completing a rebase
> with git version X+1 that was started with git version X.  But, it's
> really nice that you're paying attention to that level of detail.  :-)

In the past we've had complaints when we've made backwards incompatible 
changes but I'm not sure we've ever promised never to do it. Part of the 
problem for users is that they may not be in control of when git gets 
upgraded. Also we've had reports where a macos user started a rebase 
with tig which used a bundled version of git that was different to what 
the user had available on the command line when the continued the rebase.

>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c                    | 23 +++++++++++++++++++----
>>   t/t3418-rebase-continue.sh     | 34 ++++++++++++++++++++++------------
>>   t/t3436-rebase-more-options.sh | 24 ------------------------
>>   3 files changed, 41 insertions(+), 40 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 83ea1016ae..8890d1f7a1 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2930,7 +2930,7 @@ static void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
>>          count = split_cmdline(strategy_opts_string,
>>                                (const char ***)&opts->xopts);
>>          if (count < 0)
>> -               die(_("could not split '%s': %s"), strategy_opts_string,
>> +               BUG("could not split '%s': %s", strategy_opts_string,
>>                              split_cmdline_strerror(count));
>>          opts->xopts_nr = count;
>>          for (i = 0; i < opts->xopts_nr; i++) {
>> @@ -3054,12 +3054,27 @@ static int read_populate_opts(struct replay_opts *opts)
>>
>>   static void write_strategy_opts(struct replay_opts *opts)
>>   {
>> -       int i;
>>          struct strbuf buf = STRBUF_INIT;
>>
>> -       for (i = 0; i < opts->xopts_nr; ++i)
>> -               strbuf_addf(&buf, " --%s", opts->xopts[i]);
>> +       /*
>> +        * Quote strategy options so that they can be read correctly
>> +        * by split_cmdline().
>> +        */
>> +       for (size_t i = 0; i < opts->xopts_nr; i++) {
>> +               char *arg = opts->xopts[i];
>>
>> +               if (i)
>> +                       strbuf_addch(&buf, ' ');
>> +               strbuf_addch(&buf, '"');
>> +               for (size_t j = 0; arg[j]; j++) {
>> +                       const char c = arg[j];
>> +
>> +                       if (c == '"' || c =='\\')
>> +                               strbuf_addch(&buf, '\\');
>> +                       strbuf_addch(&buf, c);
>> +               }
>> +               strbuf_addch(&buf, '"');
>> +       }
> 
> Do we not have a function in quote.[ch] that can handle this?  If not,
> should we add this code to a function in that file and call it?

No we don't and yes we should, though in the end I've added it to 
alias.c as that is where split_cmdline() lives.

Thanks for you comments, I'll post a re-roll in the next couple of days

Phillip

> 
>>          write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
>>          strbuf_release(&buf);
>>   }
>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>> index 130e2f9b55..42c3954125 100755
>> --- a/t/t3418-rebase-continue.sh
>> +++ b/t/t3418-rebase-continue.sh
>> @@ -62,29 +62,39 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
>>          rm -fr .git/rebase-* &&
>>          git reset --hard commit-new-file-F2-on-topic-branch &&
>>          test_commit "commit-new-file-F3-on-topic-branch" F3 32 &&
>> -       test_when_finished "rm -fr test-bin funny.was.run" &&
>> +       test_when_finished "rm -fr test-bin" &&
>>          mkdir test-bin &&
>> -       cat >test-bin/git-merge-funny <<-EOF &&
>> -       #!$SHELL_PATH
>> -       case "\$1" in --opt) ;; *) exit 2 ;; esac
>> -       shift &&
>> -       >funny.was.run &&
>> -       exec git merge-recursive "\$@"
>> +
>> +       write_script test-bin/git-merge-funny <<-\EOF &&
>> +       printf "[%s]\n" $# "$1" "$2" "$3" "$5" >actual
>> +       shift 3 &&
>> +       exec git merge-recursive "$@"
>>          EOF
>> -       chmod +x test-bin/git-merge-funny &&
>> +
>> +       cat >expect <<-\EOF &&
>> +       [7]
>> +       [--option=arg with space]
>> +       [--op"tion\]
>> +       [--new
>> +       line ]
>> +       [--]
>> +       EOF
>> +
>> +       rm -f actual &&
>>          (
>>                  PATH=./test-bin:$PATH &&
>> -               test_must_fail git rebase -s funny -Xopt main topic
>> +               test_must_fail git rebase -s funny -X"option=arg with space" \
>> +                               -Xop\"tion\\ -X"new${LF}line " main topic
>>          ) &&
>> -       test -f funny.was.run &&
>> -       rm funny.was.run &&
>> +       test_cmp expect actual &&
>> +       rm actual &&
>>          echo "Resolved" >F2 &&
>>          git add F2 &&
>>          (
>>                  PATH=./test-bin:$PATH &&
>>                  git rebase --continue
>>          ) &&
>> -       test -f funny.was.run
>> +       test_cmp expect actual
>>   '
> 
> I appreciate the more stringent test to cover these new special cases.  :-)
> 
>>
>>   test_expect_success 'rebase -i --continue handles merge strategy and options' '
>> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
>> index 3adf42f47d..94671d3c46 100755
>> --- a/t/t3436-rebase-more-options.sh
>> +++ b/t/t3436-rebase-more-options.sh
>> @@ -40,30 +40,6 @@ test_expect_success 'setup' '
>>          EOF
>>   '
>>
>> -test_expect_success 'bad -X <strategy-option> arguments: unclosed quote' '
>> -       test_when_finished "test_might_fail git rebase --abort" &&
>> -       cat >expect <<-\EOF &&
>> -       fatal: could not split '\''--bad'\'': unclosed quote
>> -       EOF
>> -       GIT_SEQUENCE_EDITOR="echo break >" \
>> -               git rebase -i -X"bad argument\"" side main &&
>> -       test_expect_code 128 git rebase --continue >out 2>actual &&
>> -       test_must_be_empty out &&
>> -       test_cmp expect actual
>> -'
>> -
>> -test_expect_success 'bad -X <strategy-option> arguments: bad escape' '
>> -       test_when_finished "test_might_fail git rebase --abort" &&
>> -       cat >expect <<-\EOF &&
>> -       fatal: could not split '\''--bad'\'': cmdline ends with \
>> -       EOF
>> -       GIT_SEQUENCE_EDITOR="echo break >" \
>> -               git rebase -i -X"bad escape \\" side main &&
>> -       test_expect_code 128 git rebase --continue >out 2>actual &&
>> -       test_must_be_empty out &&
>> -       test_cmp expect actual
>> -'
>> -
>>   test_expect_success '--ignore-whitespace works with apply backend' '
>>          test_must_fail git rebase --apply main side &&
>>          git rebase --abort &&
>> --
>> 2.39.2

