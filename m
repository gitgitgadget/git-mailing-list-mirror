Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ACAC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 13:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbiDZNtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351197AbiDZNtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 09:49:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B45F74
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 06:46:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso1574801wms.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Y40uZQvb2zF3AmCG3xQez337MuFxpwiAAmmec2PoroQ=;
        b=aPp/qRmG6i3GtNV20wAE/Lk96rENCneeIUv+d1mxL0hMUygTqCCGt17s4HIqd1IVGp
         /Jvb/v5qoBeppTb5LkF3VV5xvVCdExfJPI2ipXvhoV/m1+EzgPP+or367Gm68lAqJ3RK
         wVCGk0+tXOBKlcmwfRGvkrX0qaX2KgtExYhcAmueSmWvsG6oXLORYDKM3YQGALp4L7fn
         i93hu7jvFQMD6YKGVblst3zt/lopAoDa+dWJu50gy/GeGH6cYq3J4rVV6BK+OouFRXcm
         nDGRKoCtTdAL6WmVrodtKQSm0NVjZydkdYSM8e6duk50LbPbwPqEn/NuE6wetiRG/RnJ
         RgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Y40uZQvb2zF3AmCG3xQez337MuFxpwiAAmmec2PoroQ=;
        b=MDMQ9ch1Dcigw2i4951Ppqf0y7+bsQI2FrXLobP65NrqmOJc42i8f4UP6T1xF4L817
         C4KKBpLeGJNUAP1qyaIEjNC1bcEHrzDm4kHSB3ZrgvRALZy2yLeWLlC+WE2y/CwR6gs0
         Tg98SibK74EM1ioxsootm648FtzSLii09fliwWaqoQFeQHYYlTebEFBx3OFcCXBuAZSR
         C0PLhXCqyz32ERNyFPxa6jQNKTipaxfVKq3J6ymfGhbjVDZTb57orz2ikYKwKwp2CM0B
         XGpnO+W7aYdax+4aIVC0vwtn0wIB3/iSWQN2eweU4cIubOxuAN7WZRlBZ3i5DLD70IRn
         RLHA==
X-Gm-Message-State: AOAM532FpSnsG8WpeRLJdMIdt8zU6f7+jP1IA6VEAI7Kvtm9psgPP57F
        ICG/FXq63hB05QAylePGKlc=
X-Google-Smtp-Source: ABdhPJywJHVYOkQ0cXp6RuyRjdzWR8Q3VG2T8rtClAIL1k2MQsgT8wCBrKmbr8ivg6ZVdHG5esdqIw==
X-Received: by 2002:a05:600c:2113:b0:38e:bc71:2b0 with SMTP id u19-20020a05600c211300b0038ebc7102b0mr20742230wml.153.1650980759752;
        Tue, 26 Apr 2022 06:45:59 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id n4-20020a1ca404000000b00392965e41d6sm14284309wme.39.2022.04.26.06.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 06:45:59 -0700 (PDT)
Message-ID: <6ac7e164-c4ba-0ffc-a8a4-4cede1d4e7ae@gmail.com>
Date:   Tue, 26 Apr 2022 14:45:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] 2.36 gitk/diff-tree --stdin regression fix
Content-Language: en-GB-large
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh76j3i3r.fsf@gitster.g> <xmqqbkwpvyyc.fsf@gitster.g>
 <83a76d46-5069-d6c7-b8b3-f3a063637abb@gmail.com>
In-Reply-To: <83a76d46-5069-d6c7-b8b3-f3a063637abb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/04/2022 11:09, Phillip Wood wrote:
> On 25/04/2022 18:45, Junio C Hamano wrote:
>> This reverts commit 244c2724 (diff.[ch]: have diff_free() call
>> clear_pathspec(opts.pathspec), 2022-02-16).
>>
>> The diff_free() call is to be used after a diffopt structure is used
>> to compare two sets of paths to release resources that were needed
>> only for that comparison, and keep the data such as pathspec that
>> are reused by the diffopt structure to make the next and subsequent
>> comparison (imagine "git log -p -<options> -- <pathspec>" where the
>> options and pathspec are kept in the diffopt structure, used to
>> compare HEAD and HEAD~, then used again when HEAD~ and HEAD~2 are
>> compared).
>>
>> We by mistake started clearing the pathspec in diff_free(), so
>> programs like gitk that runs
>>
>>      git diff-tree --stdin -- <pathspec>
>>
>> downstream of a pipe, processing one commit after another, started
>> showing irrelevant comparison outside the given <pathspec> from the
>> second commit.
> 
> I notice from the patch context that we are still calling 
> diff_free_ignore_regex(options) which was added in c45dc9cf30 ("diff: 
> plug memory leak from regcomp() on {log,diff} -I", 2021-02-11). I think 
> that will need reverting as well as it freeing data that is needed when 
> options is reused by "diff-tree --stdin" or "log -p".

On further inspection we have tests for "log -p -I<regex>" in t4013 and 
e900d494dc ("diff: add an API for deferred freeing", 2021-02-11) 
modified builtin/log.c to set the new no_free flag so "log" should be 
OK. However "diff-tree --stdin -p -I<regex>" is not as 
builtin/diff-tree.c is unchanged by e900d494dc so the no_free flag is 
not set which I think is the cause of the problems reported here.

I think the close_file changes in e900d494dc should be safe as far as 
"diff-tree" is concerned as it never sets that flag.

In retrospect the no_free flag is pretty ugly and fragile. If we really 
cannot do it another way at least requiring callers to set a flag when 
they want things freeing would avoid nasty surprises like this at the 
expense of leaking when the caller forgets to set it. Perhaps once 
2.36.1 is out we should step back and think about exactly what we're 
trying to achieve by removing these bounded leaks rather than annotating 
them with UNLEAK().

Best Wishes

Phillip

> Best Wishes
> 
> Phillip
> 
>> The buggy commit may have been hiding the places where diff
>> machinery is used only once and called diff_free() to release that
>> per-comparison resources, but forgetting to call clear_pathspec() to
>> release the resource held for the (potentially) repeated comparison,
>> and we eventually would want to add clear_pathspec() to clear
>> resources to be released after a (potentially repeated) diff session
>> is done (if there are similar resources other than pathspec that
>> need to be cleared at the end, we should then know where to clear
>> them), but that is "per program invocation" leak that will be
>> cleaned up by calling exit(3) and of lower priority than fixing this
>> behavior-breaking regression.
>>
>> Reported-by: Matthias Aßhauer <mha1993@live.de>
>> Helped-by: René Scharfe <l.s.r@web.de>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   add-interactive.c | 6 +++---
>>   blame.c           | 3 +++
>>
>>   builtin/reset.c   | 1 +
>>   diff.c            | 1 -
>>   notes-merge.c     | 2 ++
>>   5 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/add-interactive.c b/add-interactive.c
>> index e1ab39cce3..6498ae196f 100644
>> --- a/add-interactive.c
>> +++ b/add-interactive.c
>> @@ -797,14 +797,14 @@ static int run_revert(struct add_i_state *s, 
>> const struct pathspec *ps,
>>       diffopt.flags.override_submodule_config = 1;
>>       diffopt.repo = s->r;
>> -    if (do_diff_cache(&oid, &diffopt)) {
>> -        diff_free(&diffopt);
>> +    if (do_diff_cache(&oid, &diffopt))
>>           res = -1;
>> -    } else {
>> +    else {
>>           diffcore_std(&diffopt);
>>           diff_flush(&diffopt);
>>       }
>>       free(paths);
>> +    clear_pathspec(&diffopt.pathspec);
>>       if (!res && write_locked_index(s->r->index, &index_lock,
>>                          COMMIT_LOCK) < 0)
>> diff --git a/blame.c b/blame.c
>> index 401990726e..206c295660 100644
>> --- a/blame.c
>> +++ b/blame.c
>> @@ -1403,6 +1403,7 @@ static struct blame_origin *find_origin(struct 
>> repository *r,
>>           }
>>       }
>>       diff_flush(&diff_opts);
>> +    clear_pathspec(&diff_opts.pathspec);
>>       return porigin;
>>   }
>> @@ -1446,6 +1447,7 @@ static struct blame_origin *find_rename(struct 
>> repository *r,
>>           }
>>       }
>>       diff_flush(&diff_opts);
>> +    clear_pathspec(&diff_opts.pathspec);
>>       return porigin;
>>   }
>> @@ -2326,6 +2328,7 @@ static void find_copy_in_parent(struct 
>> blame_scoreboard *sb,
>>       } while (unblamed);
>>       target->suspects = reverse_blame(leftover, NULL);
>>       diff_flush(&diff_opts);
>> +    clear_pathspec(&diff_opts.pathspec);
>>   }
>>   /*
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index 24968dd628..b97745ee94 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -274,6 +274,7 @@ static int read_from_tree(const struct pathspec 
>> *pathspec,
>>           return 1;
>>       diffcore_std(&opt);
>>       diff_flush(&opt);
>> +    clear_pathspec(&opt.pathspec);
>>       return 0;
>>   }
>> diff --git a/diff.c b/diff.c
>> index 0aef3db6e1..c862771a58 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -6345,7 +6345,6 @@ void diff_free(struct diff_options *options)
>>       diff_free_file(options);
>>       diff_free_ignore_regex(options);
>> -    clear_pathspec(&options->pathspec);
>>   }
>>   void diff_flush(struct diff_options *options)
>> diff --git a/notes-merge.c b/notes-merge.c
>> index 7ba40cfb08..b4a3a903e8 100644
>> --- a/notes-merge.c
>> +++ b/notes-merge.c
>> @@ -175,6 +175,7 @@ static struct notes_merge_pair 
>> *diff_tree_remote(struct notes_merge_options *o,
>>                  oid_to_hex(&mp->remote));
>>       }
>>       diff_flush(&opt);
>> +    clear_pathspec(&opt.pathspec);
>>       *num_changes = len;
>>       return changes;
>> @@ -260,6 +261,7 @@ static void diff_tree_local(struct 
>> notes_merge_options *o,
>>                  oid_to_hex(&mp->local));
>>       }
>>       diff_flush(&opt);
>> +    clear_pathspec(&opt.pathspec);
>>   }
>>   static void check_notes_merge_worktree(struct notes_merge_options *o)
