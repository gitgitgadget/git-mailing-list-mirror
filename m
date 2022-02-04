Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75E3C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 00:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiBDAeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 19:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiBDAec (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 19:34:32 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3CC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 16:34:31 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id e6so3650477pfc.7
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 16:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ocv5ysxrxOcsNHRAezvZBNfOvbdd+fBJLpgNRfqoaG0=;
        b=h6xGlaLw1HGmb1vxUe3FgRqSsq73Dmy9aXvL8qyQvmz2q6ASUmZbzo+HsOZ88b6a1c
         yBP+XEmNOdcl6vpLy7IPn55YL3aNIZO/OZ6kf3H9CM5O0fwri4NcrFkCkRF/sZLrZ87z
         3TFK5NHJlhMp3+qWycZMM5naszVWdcw/rkaN59tb8gdtyC195O7s7IKv6ONQauyALEay
         KE15455+DCe4juXLEIOKMtPkPfSctoE38Rw8uiTdcbSVSZfpARBpABrc76yOjIEyh2EI
         BqvS4INdTgsJOTMNIf3aiQvtdDwZ59BmT6ha7veVZFoTYFS6pZ8i7SThcJFSMv7n4Im0
         OloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ocv5ysxrxOcsNHRAezvZBNfOvbdd+fBJLpgNRfqoaG0=;
        b=g2SXaMn+NkxIMPjUEhLSLIvQdAbFlZ2psD4r+8O+DDLjR5gkPy9XQYOIQNfzluHwmA
         Q42VLj3rdf3yPZtizNDe5QPMdyIN+QbFxdh940AUCQXAI2rcCYssfgdAdR0X5yUjbZ6t
         FeNqnSvHHnjqJZDtxzgt6QtVnIThLqS76aIuhL1hsFqBE07D3NjcZL/DlO25OIsXAsHu
         HARxWIYXbc4WZW+YidLBI4BDo1OmHpk0/zlXOQ5B16BV5XxXjmXEvwVH7m9ZZOTNuEG1
         4Y/I3f6wWHoq1qziw31A0qj/BPFJJP1alpoSNrejRJ7M1CN2XNAEis5mrRfKFodkOQd8
         hrdw==
X-Gm-Message-State: AOAM5317JCxYlQVQ4fDK5OI06/ZES7lpe85zxycA5HXwycMChGLWt5PC
        BKfLsfuNTJHQlQKCs5hPvF0=
X-Google-Smtp-Source: ABdhPJxaSoYXCPur/mCK3qJyy+8bkdb3Mnrk/SIIXV3O2nxwBIyjYsJPLV/YOmu0nTayeK+UpbrGQQ==
X-Received: by 2002:a63:a102:: with SMTP id b2mr460030pgf.459.1643934870967;
        Thu, 03 Feb 2022 16:34:30 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:51c6:c5ef:caca:5a98? ([2601:602:9e81:12c0:51c6:c5ef:caca:5a98])
        by smtp.gmail.com with ESMTPSA id t3sm195535pfg.28.2022.02.03.16.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 16:34:30 -0800 (PST)
Message-ID: <d7f7a36d-daa1-395b-2df0-2bf135c6ec4a@gmail.com>
Date:   Thu, 3 Feb 2022 16:34:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v5 1/3] completion: address sparse-checkout issues
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <a1c46c763fd4c832a6784e2a368199efedce17e9.1643921091.git.gitgitgadget@gmail.com>
 <CABPp-BF0V7SomKSU4QYZGiwSOSpm_=pCrmyuUVGweCEKfV7RwQ@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BF0V7SomKSU4QYZGiwSOSpm_=pCrmyuUVGweCEKfV7RwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/3/22 3:52 PM, Elijah Newren wrote:
> On Thu, Feb 3, 2022 at 12:44 PM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Correct multiple issues with tab completion of the git sparse-checkout
>> command. These issues were:
>>
>> 1. git sparse-checkout <TAB> previously resulted in an incomplete list of
>> subcommands (it was missing reapply and add).
>> 2. Subcommand options were not tab-completable.
>> 3. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> showed
>> both file names and directory names. While this may be a less surprising
>> behavior for non-cone mode, cone mode sparse checkouts should complete
>> only directory names.
>>
>> Note that while the new strategy of just using git ls-tree to complete on
>> directory names is simple and a step in the right direction, it does have
>> some caveats. These are:
>>
>> 1. Likelihood of poor performance in large monorepos (as a result of
>> recursively completing directory names).
>> 2. Inability to handle paths containing unusual characters.
>>
>> These caveats will be fixed by subsequent commits in this series.
>>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   contrib/completion/git-completion.bash | 16 ++---
>>   t/t9902-completion.sh                  | 83 ++++++++++++++++++++++++++
>>   2 files changed, 91 insertions(+), 8 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index c82ccaebcc7..2976f63747f 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2988,7 +2988,7 @@ _git_show_branch ()
>>
>>   _git_sparse_checkout ()
>>   {
>> -       local subcommands="list init set disable"
>> +       local subcommands="list init set disable add reapply"
>>          local subcommand="$(__git_find_on_cmdline "$subcommands")"
>>          if [ -z "$subcommand" ]; then
>>                  __gitcomp "$subcommands"
>> @@ -2996,14 +2996,14 @@ _git_sparse_checkout ()
>>          fi
>>
>>          case "$subcommand,$cur" in
>> -       init,--*)
>> -               __gitcomp "--cone"
>> -               ;;
>> -       set,--*)
>> -               __gitcomp "--stdin"
>> -               ;;
>> -       *)
>> +       *,--*)
>> +               __gitcomp_builtin sparse-checkout_$subcommand "" "--"
>>                  ;;
>> +       set,*|add,*)
>> +               if [ $(__git config core.sparseCheckoutCone) ] ||
> 
> Shouldn't this be
> 
>                   if [ "$(__git config core.sparseCheckoutCone)" == "true" ] ||
> 
> otherwise I think you'd trigger when it's manually set to false.
> 
>> +               [ "$(__git_find_on_cmdline --cone)" ]; then
> 
> This might read better as
> 
>                  [ -n "$(__git_find_on_cmdline --cone)" ]; then
> 
> because otherwise you are relying on
> 
>       [ "--cone" ]
> 
> to evaluate as true which just seems slightly weird.
> 
Yup, this was causing some problems. Odd that the failure only cropped up
when merged with 'seen' but I have a fix prepared and will submit as soon
as GGG CI completes.
>> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
>> +               fi
>>          esac
>>   }
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 518203fbe07..f6eeb9aa035 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -1447,6 +1447,89 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>>          EOF
>>   '
>>
>> +test_expect_success 'setup sparse-checkout tests' '
>> +       # set up sparse-checkout repo
>> +       git init sparse-checkout &&
>> +       (
>> +               cd sparse-checkout &&
>> +               mkdir -p folder1/0/1 folder2/0 folder3 &&
>> +               touch folder1/0/1/t.txt &&
>> +               touch folder2/0/t.txt &&
>> +               touch folder3/t.txt &&
>> +               git add . &&
>> +               git commit -am "Initial commit"
>> +       )
>> +'
>> +
>> +test_expect_success 'sparse-checkout completes subcommands' '
>> +       test_completion "git sparse-checkout " <<-\EOF
>> +       list Z
>> +       init Z
>> +       set Z
>> +       add Z
>> +       reapply Z
>> +       disable Z
>> +       EOF
>> +'
>> +
>> +test_expect_success 'cone mode sparse-checkout completes directory names' '
>> +       # initialize sparse-checkout definitions
>> +       git -C sparse-checkout sparse-checkout set --cone folder1/0 folder3 &&
>> +
>> +       # test tab completion
>> +       (
>> +               cd sparse-checkout &&
>> +               test_completion "git sparse-checkout set f" <<-\EOF
>> +               folder1 Z
>> +               folder1/0 Z
>> +               folder1/0/1 Z
>> +               folder2 Z
>> +               folder2/0 Z
>> +               folder3 Z
>> +               EOF
>> +       ) &&
>> +
>> +       (
>> +               cd sparse-checkout/folder1 &&
>> +               test_completion "git sparse-checkout add " <<-\EOF
>> +               ./ Z
>> +               0 Z
>> +               0/1 Z
>> +               EOF
>> +       )
>> +'
>> +
>> +test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
>> +       # reset sparse-checkout repo to non-cone mode
>> +       git -C sparse-checkout sparse-checkout disable &&
>> +       git -C sparse-checkout sparse-checkout set --no-cone &&
>> +
>> +       (
>> +               cd sparse-checkout &&
>> +               # expected to be empty since we have not configured
>> +               # custom completion for non-cone mode
>> +               test_completion "git sparse-checkout set f" <<-\EOF
>> +
>> +               EOF
>> +       )
>> +'
>> +
>> +test_expect_success 'git sparse-checkout set --cone completes directory names' '
>> +       git -C sparse-checkout sparse-checkout disable &&
>> +
>> +       (
>> +               cd sparse-checkout &&
>> +               test_completion "git sparse-checkout set --cone f" <<-\EOF
>> +               folder1 Z
>> +               folder1/0 Z
>> +               folder1/0/1 Z
>> +               folder2 Z
>> +               folder2/0 Z
>> +               folder3 Z
>> +               EOF
>> +       )
>> +'
>> +
>>   test_expect_success 'git switch - with -d, complete all references' '
>>          test_completion "git switch -d " <<-\EOF
>>          HEAD Z
> 
> The rest looks good to me.
