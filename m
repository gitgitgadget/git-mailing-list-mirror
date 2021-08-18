Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5D4C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8556108F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhHRKDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhHRKCw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 06:02:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F2BC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 03:02:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k29so2573362wrd.7
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Vzj2gnnSr8n3GSr8TXPEnRoh0BYcE3iD3qiDUr0bh4=;
        b=O9tf8VaVe9/2MYpCbfd1dqF4mAgDLgNQBxAmNSp1t0ucyJZlyy2phc0MOA8qPQozJs
         0n4DZ2TBqB46q3X37mqvPhijPJMDYqY/9ymBMgQSjC2qVoNlwsXt0RLw0331RfEqMgx0
         n8D1R/R71VCPecfMRoyALh6TaZuYJf8zarN9vBxWWg8fNT6+mCze2a7HEvvyUPbSslzX
         5FhxJDHy9cHY8WU5zXazTU7ZXWWgj3REruR9lB21rqIQndX/vig4BZISBlKtsU59AkSA
         CgbqBNOG9mHmLzRHkoYDsFoob/ptcTS9f/BXAxkXHPiKPA4XmxHgyOXh8+mQd0LdHxnJ
         pKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9Vzj2gnnSr8n3GSr8TXPEnRoh0BYcE3iD3qiDUr0bh4=;
        b=JI1ihg3YYrPcdPWJ9kJwYzq6Ty0tUSnUW26N55+G9VvpD+dO1f0Rxrrx/7XjF/q8c8
         LG5F1kpol1Qp2qLxKZQm4+NrgAG4Ei2+vUZxnpeDpwRH3egmLciZhe965Ck9LckdifHS
         wE7M6CuQaS2GEp8cGf/DycmfdVj0p09GUnIq7tGcGEUpCH6oGwFjUY6VR9zgnyJR4pBO
         LiHAeLwKY03T4CqrCcUs8sx78qn8iAd3IlBxW6r1l45uJvfoKD8YD8OeUMch+CXF78YR
         5raFkyYao69h9eLAZcU5SVSgrKjuiBO4ZNuY+uUcxnEB5OUZ3Cw4RBzLSJX6LJMITonq
         rpzg==
X-Gm-Message-State: AOAM533J4xbReO6Fw5bPBXDD7iZcMFtgWMK8+EqppYsq09gqMk4Ah1HU
        SadVvP7VJGnjEvqMWhvBa2A=
X-Google-Smtp-Source: ABdhPJwMH5s05AE/U3fnLlAqSZsLyTv4yK6HCVUDXdgyHD/0JRmcmkdQV/Jjcf5oZBYuH7HueEbbDw==
X-Received: by 2002:adf:f552:: with SMTP id j18mr9275012wrp.273.1629280934169;
        Wed, 18 Aug 2021 03:02:14 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id c8sm5386710wrx.53.2021.08.18.03.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 03:02:13 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
 <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
 <c185a396-c498-b2ef-1c86-cec7d5751f3d@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e363df27-a99e-1a43-f493-ed90de7b6363@gmail.com>
Date:   Wed, 18 Aug 2021 11:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c185a396-c498-b2ef-1c86-cec7d5751f3d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08/2021 18:45, Philippe Blain wrote:
> Hi Josh,
> [...]
>> diff --git a/sequencer.c b/sequencer.c
>> index 7f07cd00f3..1235f61c9d 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -5099,6 +5099,7 @@ static int make_script_with_merges(struct 
>> pretty_print_context *pp,
>>       int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
>>       int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
>>       int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
>> +    int skipped_commit = 0;
>>       struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
>>       struct strbuf label = STRBUF_INIT;
>>       struct commit_list *commits = NULL, **tail = &commits, *iter;
>> @@ -5149,8 +5150,13 @@ static int make_script_with_merges(struct 
>> pretty_print_context *pp,
>>           oidset_insert(&interesting, &commit->object.oid);
>>           is_empty = is_original_commit_empty(commit);
>> -        if (!is_empty && (commit->object.flags & PATCHSAME))
>> +        if (!is_empty && (commit->object.flags & PATCHSAME)) {
>> +            advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
>> +                    _("skipped previously applied commit %s"),
>> +                    short_commit_name(commit));
>> +            skipped_commit = 1;
>>               continue;
>> +        }
>>           if (is_empty && !keep_empty)
>>               continue;
> 
> For interactive rebase, an alternate implementation, that I suggested in 
> [1] last summer, would be to keep
> the cherry-picks in the todo list, but mark them as 'drop' and add a 
> comment at the
> end of their line, like '# already applied' or something like this, similar
> to how empty commits have '# empty' appended. I think that for 
> interactive rebase, I
> would prefer this, since it is easier for the user to notice it and 
> change the 'drop'
> to 'pick' right away if they realise they do not want to drop those 
> commits (easier
> than seeing the warning, realising they did not want to drop them, 
> aborting the rebase
> and redoing it with '--reapply-cherry-picks').

That would be nice, but we could always add it in the future if Josh 
does not want to implement it now. At the moment the function that 
creates the todo list does not know if it is going to be edited, I'm not 
sure how easy it would be to pass that information down.

> For non-interactive rebase adding a warning/advice like your patch does 
> seems to
> be a good solution.
> 
>> @@ -5214,6 +5220,9 @@ static int make_script_with_merges(struct 
>> pretty_print_context *pp,
>>           oidcpy(&entry->entry.oid, &commit->object.oid);
>>           oidmap_put(&commit2todo, entry);
>>       }
>> +    if (skipped_commit)
>> +        advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
>> +                  _("use --reapply-cherry-picks to include skipped 
>> commits"));
>>       /*
>>        * Second phase:
>> @@ -5334,6 +5343,7 @@ int sequencer_make_script(struct repository *r, 
>> struct strbuf *out, int argc,
>>       const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : 
>> "pick";
>>       int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
>>       int reapply_cherry_picks = flags & TODO_LIST_REAPPLY_CHERRY_PICKS;
>> +    int skipped_commit = 0;
>>       repo_init_revisions(r, &revs, NULL);
>>       revs.verbose_header = 1;
>> @@ -5369,8 +5379,13 @@ int sequencer_make_script(struct repository *r, 
>> struct strbuf *out, int argc,
>>       while ((commit = get_revision(&revs))) {
>>           int is_empty = is_original_commit_empty(commit);
>> -        if (!is_empty && (commit->object.flags & PATCHSAME))
>> +        if (!is_empty && (commit->object.flags & PATCHSAME)) {
>> +            advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
>> +                      _("skipped previously applied commit %s"),
>> +                      short_commit_name(commit));
>> +            skipped_commit = 1;
>>               continue;
>> +        }
>>           if (is_empty && !keep_empty)
>>               continue;
>>           strbuf_addf(out, "%s %s ", insn,
>> @@ -5380,6 +5395,9 @@ int sequencer_make_script(struct repository *r, 
>> struct strbuf *out, int argc,
>>               strbuf_addf(out, " %c empty", comment_line_char);
>>           strbuf_addch(out, '\n');
>>       }
>> +    if (skipped_commit)
>> +        advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
>> +                  _("use --reapply-cherry-picks to include skipped 
>> commits"));
>>       return 0;
>>   }
>>
> 
> Like Junio remarked, it is a little unfortunate that some logic is 
> duplicated between
> 'sequencer_make_script' and 'make_script_with_merges', such that your 
> patch has to do
> the same thing at two different code locations. Maybe a preparatory 
> cleanup could add
> a new function that takes care of the duplicated logic and call if from 
> both ? I'm
> just thinking out loud here, I did not analyze in details if this would 
> be easy/feasible...

I think feasible but not easy (or required for this change), it would 
also complicate the code in a different way as I think we'd have to add 
some conditionals for whether we are recreating merges or not.

Best Wishes

Phillip


> Thanks for suggesting this change,
> 
> Philippe.
> 
> 
> [1] 
> https://lore.kernel.org/git/0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com/

