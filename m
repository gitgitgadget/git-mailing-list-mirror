Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE07C4167E
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 11:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiB1LKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbiB1LJk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 06:09:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51B6C1E3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:09:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso5785674wmr.1
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Mv2YsUqtz5/sjnXlKQ/FJNb3ngzumBJcgfsI5W7l6JI=;
        b=ndpjPX+tan7PLpw7MHGyKj3Fi9GWXvGyS9KNtFgpM+g0BvJSwjRZYGaqZtsH6BFL14
         yr/AZcA0gNe4bxsR5I3eNKcPAAcMFvOh/+O+Q1OSncJMeaJcuJtbsTuzn5uAUQtDvo6o
         Zr1Rz0BYNWM4vM3lBYc01Qgbcsg+R5sVNVhtHWBeHtVPj13ODLNPiJIytscbQZYYS/j1
         eGCnBYxJXHg2pBDF8Ot64G5shPyN84Unselp+RoFd7Nypixvk4Jm2ALWOYSLDKPYA+tK
         e2ZAFkH7+soILyIwozVyIO2R/C1ZGMLbJUMoI7OSBJ177aFOykc1c7lcMRyl2BQvwAO8
         eOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Mv2YsUqtz5/sjnXlKQ/FJNb3ngzumBJcgfsI5W7l6JI=;
        b=t7270kumWyxgrb9ezC+fRDYXbnJSqKC5ui5wsgy4eR+hZVpGDAWvHjHFCk47Zwfs1v
         OdRltaAfVkJGNDQleUYxsHCKhqKOx/5BrtFm0TFub2jqTdawwckf8LUDMmhpStZKfRQF
         1joSdMK0gYBgtOkM0unJg9mOWqn5FBYwBB2dqO5z+pp+KHxcraYm4PYJm+rAEtptUM/l
         9pc0hb7a2/Jr8jwLWqm99P25KqwuxgZTdC5MN+ZLU4p1nn0n+Coe+U3f5789gAFYQgYL
         6gf0Qp/ChjVcB0ptgNdh0UJCNzDd8ivrMTNiuH6jaG8XDlxLfbUNBsGb/ehvwfT6jP+q
         GFtw==
X-Gm-Message-State: AOAM531bDOPaPGgG/Axkf+JBCZ3WzvfzxOuYhmmYzt7pxQRHCFc5LO0r
        r2Q66FeL4toAZzHBCobtyr8=
X-Google-Smtp-Source: ABdhPJypCHlj6GRU1pstyy+TGF6lyPOwlGhZxNZlIefmDhvW3xGzjyzYJPMsFndurWMxVoTzvyZ1gA==
X-Received: by 2002:a7b:ce83:0:b0:37b:f1f1:3a0c with SMTP id q3-20020a7bce83000000b0037bf1f13a0cmr12605016wmj.10.1646046539365;
        Mon, 28 Feb 2022 03:08:59 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id j12-20020a05600c190c00b00380ead5bc65sm12996058wmq.29.2022.02.28.03.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 03:08:59 -0800 (PST)
Message-ID: <dd16416d-15c4-7f80-aaf6-a36d101e8928@gmail.com>
Date:   Mon, 28 Feb 2022 11:08:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] worktree: add -z option for list subcommand
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
 <CAPig+cTx-n_WQqvVYyegtvW8gRbXEPsm5C7fmHq=9PZeANZ-wQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPig+cTx-n_WQqvVYyegtvW8gRbXEPsm5C7fmHq=9PZeANZ-wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 28/02/2022 08:16, Eric Sunshine wrote:
> On Fri, Feb 25, 2022 at 10:08 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Add a -z option to be used in conjunction with --porcelain that gives
>> NUL-terminated output. This enables 'worktree list --porcelain' to
>> handle worktree paths that contain newlines.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>      For a previous discussion of the merits of adding a -z option vs quoting
>>      the worktree path see
>>      https://lore.kernel.org/git/CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com/
> 
> Thanks for resubmitting.
> 
>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
>> @@ -223,7 +223,13 @@ This can also be set up as the default behaviour by using the
>> +-z::
>> +       When `--porcelain` is specified with `list` terminate each line with a
> 
> Nit: s/`list`/&,/
> 
>> +       NUL rather than a newline. This makes it possible to parse the output
>> +       when a worktree path contains a newline character.
> 
> Or, perhaps:
> 
>      Terminate each line with NUL rather than a newline when
>      `--porcelain` is specified with `list`. This makes it possible...
> 
> might be simpler(?).
> 
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -575,35 +575,38 @@ static int add(int ac, const char **av, const char *prefix)
>> -static void show_worktree_porcelain(struct worktree *wt)
>> +static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
>>   {
>> -       printf("worktree %s\n", wt->path);
>> +       printf("worktree %s%c", wt->path, line_terminator);
>>          if (wt->is_bare)
>> -               printf("bare\n");
>> +               printf("bare%c", line_terminator);
>>          else {
>> -               printf("HEAD %s\n", oid_to_hex(&wt->head_oid));
>> +               printf("HEAD %s%c", oid_to_hex(&wt->head_oid), line_terminator);
>>                  if (wt->is_detached)
>> -                       printf("detached\n");
>> +                       printf("detached%c", line_terminator);
>>                  else if (wt->head_ref)
>> -                       printf("branch %s\n", wt->head_ref);
>> +                       printf("branch %s%c", wt->head_ref, line_terminator);
>>          }
> 
> Good, this is easier to read than the previous version which manually
> called `fputc(line_terminator, stdout)` repeatedly for the
> termination. The diff is also more easily digested.
> 
>>          if (reason && *reason) {
>>                  struct strbuf sb = STRBUF_INIT;
>> -               quote_c_style(reason, &sb, NULL, 0);
>> -               printf("locked %s\n", sb.buf);
>> +               if (line_terminator) {
>> +                       quote_c_style(reason, &sb, NULL, 0);
>> +                       reason = sb.buf;
>> +               }
>> +               printf("locked %s%c", reason, line_terminator);
> 
> Junio's suggestion downstream that write_name_quoted() would be
> simpler makes sense, but (as he says) is not necessarily worth a
> reroll.

Yes, I wasn't aware of that function but I'll update as I'm going to 
re-roll anyway

>> @@ -681,12 +684,15 @@ static void pathsort(struct worktree **wt)
>> +               OPT_SET_INT('z', NULL, &line_terminator,
>> +                           N_("fields are separated with NUL character"), '\0'),
> 
> Same comment as previous review [1]:
> 
>      "fields" sounds a little odd. "lines" might make more sense.
>      "records" might be even better and matches the wording of some
>      other Git commands accepting `-z`.

It would be good to standardize this, check-attr and check-ignore use 
"records", ls-files, ls-tree and status use "entries", config uses 
"values" (which probably makes sense in the context of that command).

>> @@ -696,6 +702,8 @@ static int list(int ac, const char **av, const char *prefix)
>>                  usage_with_options(worktree_usage, options);
>>          else if (verbose && porcelain)
>>                  die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--porcelain");
>> +       else if (!line_terminator && !porcelain)
>> +               die(_("'-z' requires '--porcelain'"));
> 
> Same comment as my previous review[1]:

Sorry I'd forgotten you'd left some comments before, I should have spent 
more time rereading that old thread

>      Other error messages in this file don't quote command-line
>      options, so `die(_("-z requires --porcelain"));` would be more
>      consistent.
> 
> However, considering all the recent work Jean-Noël Avila has been
> doing to recently, perhaps this should instead mirror his change to
> the die() message just above the new one and instead be:
> 
>      die(_("'%s' requires '%s'"), "-z", "--porcelain");

Yes, I'll update this, Jean-Noël made the same suggestion. I wish we had 
some functions/macros for these standard messages I think it would be 
easier to remember to use them than trying to remember the standard 
wording for messages like this.

>> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
>> @@ -64,6 +64,27 @@ test_expect_success '"list" all worktrees --porcelain' '
>> +test_expect_success '"list" all worktrees --porcelain -z' '
>> +       test_when_finished "rm -rf here _actual actual expect &&
>> +                               git worktree prune" &&
>> +       printf "worktree %sQHEAD %sQbranch %sQQ" \
>> +               "$(git rev-parse --show-toplevel)" \
>> +               $(git rev-parse HEAD --symbolic-full-name HEAD) >expect &&
>> +       git worktree add --detach here main &&
>> +       printf "worktree %sQHEAD %sQdetachedQQ" \
>> +               "$(git -C here rev-parse --show-toplevel)" \
>> +               "$(git rev-parse HEAD)" >>expect &&
>> +       git worktree list --porcelain -z >_actual &&
>> +       cat _actual | tr "\0" Q >actual &&
> 
> Same comment as my previous review[1]:
> 
>      Or just use nul_to_q():
>        nul_to_q <_actual >actual &&
>      (And there's no need to `cat` the file.)

That's a good idea

>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success '"list" -z fails without --porcelain' '
>> +       test_when_finished "rm -rf here && git worktree prune" &&
>> +       git worktree add --detach here main &&
>> +       test_must_fail git worktree list -z
>> +'
> 
> Same comment as my previous review[1]:
> 
>      I don't think there's any need for this test to create (and
>      cleanup) a worktree. So, the entire test could collapse to:
> 
>        test_expect_success '"list" -z fails without --porcelain' '
>          test_must_fail git worktree list -z
>        '

Good point

Thanks for your comments, sorry for making you repeat yourself from last 
time

Phillip

> [1]: https://lore.kernel.org/git/CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com/

