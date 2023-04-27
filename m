Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2BFC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 10:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbjD0KPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243288AbjD0KPr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 06:15:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80330A0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:15:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3003b97fa12so5073083f8f.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682590541; x=1685182541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NURd9vaKRojgNeIM8zOwm+YnMEZ+uIEvrhyR3IlyvtA=;
        b=fUWWi0Juhvoeg54qCyulBg+Icy4NLrG2GoATi+wnxXdExhLw93L4464wS+tEpSccR5
         bJZ2jJIqZ518rfusPrXAWD2nGG9E7atBUWPufVfNOcqtfytBuNuegQDZqOTOZFnDPIam
         R/aSygA9rJPi7eKZFxRJaCTVPRpnBNUhdKD+tHRtQL5rD2QCssLdtxWEHA7Z5lArav5e
         OBMBZ2KYAG534rfIB9oriuTaWID93K9SteglA/mcwFMRk2FZO8j85/RCmu+5Gl9h2PeR
         ZzGYV+/LX3B/49D4X09kIsK3IA5DETQ9dFJDO9P6sxMBsXzbThi0lYVfu7u9XfZBavfF
         ygNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590541; x=1685182541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NURd9vaKRojgNeIM8zOwm+YnMEZ+uIEvrhyR3IlyvtA=;
        b=SQB11b9qXo+Io4in07F6vqMui6t/XvDdU5PLLruWMr8LAyqF81QdYyIKCpxZc1dWZ7
         QgvjWBQMjbDeRKEh/VNch1W+S8z/3qKsDe7i9BPB3OiehmA3F6LrBwcNGBVCjB1rqPLt
         mev3J0fH3KEwdVgBOZyHHQENadW+ZKiD16ZtPqfob/0O7SAqKjwJ/XcNlvekNeMuj7sZ
         g/CIoi+yLBLxJw3YEByPHFmidcej29SVx+Or80ikguGu0aRrJEvE5p+htjO318a8emE4
         i8JJ4P+BEkammN6RLHDmgte3MiU2U8qxNlDpu2GZ22IiMeDnMX09odfM0l1zh6CUbVbI
         ak0A==
X-Gm-Message-State: AC+VfDwtwhl56hVtJ5hyWmARkK+yMOrN0dlQviqrVQmZY8I4Iwq8QQKH
        gjev4wVMMyRPoXibVU1bVv4=
X-Google-Smtp-Source: ACHHUZ493RBuDwFoCpEhyhvoqEmjrWTjxLZhRmtZ19ze/Cj+SoA36e92dpHoBKVAa3kaO7956Zm1tA==
X-Received: by 2002:a5d:63d2:0:b0:2c3:e7d8:245c with SMTP id c18-20020a5d63d2000000b002c3e7d8245cmr906079wrw.13.1682590540850;
        Thu, 27 Apr 2023 03:15:40 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id z17-20020adfdf91000000b002d97529b3bbsm18059817wrl.96.2023.04.27.03.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 03:15:40 -0700 (PDT)
Message-ID: <5d5413a2-d3fe-4a5b-25e5-d0132034c11f@gmail.com>
Date:   Thu, 27 Apr 2023 11:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/6] rebase -i: move unlink() calls
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <3dfb2c6903bcc61258c72ba5c8e4201c9db2665b.1682089074.git.gitgitgadget@gmail.com>
 <xmqq8relkv52.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8relkv52.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/04/2023 18:22, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> At the start of each iteration the loop that picks commits removes
>> state files from the previous pick. However some of these are only
>> written if there are conflicts so only need to be removed before
>> starting the loop, not in each iteration.
> 
> I do not doubt your reasoning is correct, but could you explain this
> a bit better?
> 
> I think the reason why others, e.g. author-script, need to be
> removed on every iteration is because the previous iteration that
> called do_pick_commit() can come back successfully after calling
> write_author_script(), and we would want to clear the deck before
> going into the next iteration, so I can guess that you meant by "if
> there are conflicts" that the loop will not iterate to the next step
> after conflicts happened (and these files like "amend" and
> "stopped-sha" may have been written)?  The latter, i.e. the loop
> will not iterate any further, is the more direct reason to justify
> this change, I think, and it would help readers of "git log" to say
> so, instead of forcing them to infer "are conflicts" imply "hence
> loop will stop".

Yes, that's right. I'll expand the commit message when I re-roll.

> Is this a pure clean-up, or will there be behaviour change?  I do
> not think there is with this patch alone, but does this change make
> future steps easier to understand or something?

It is a pure cleanup. I noticed it when adding the unlink() call in the 
next patch, it doesn't really have anything to do with the subject of 
this series, but I felt it was worth doing as a preparation for the next 
patch.

Best Wishes

Phillip

> IOW, the proposed log message may explain why this is not a wrong
> change to make, but it is unclear why this is a good change we want
> to have in this part of the series.
> 
> Thanks.
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index d2c7698c48c..5073ec5902b 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4639,6 +4639,10 @@ static int pick_commits(struct repository *r,
>>   	if (read_and_refresh_cache(r, opts))
>>   		return -1;
>>   
>> +	unlink(rebase_path_message());
>> +	unlink(rebase_path_stopped_sha());
>> +	unlink(rebase_path_amend());
>> +
>>   	while (todo_list->current < todo_list->nr) {
>>   		struct todo_item *item = todo_list->items + todo_list->current;
>>   		const char *arg = todo_item_get_arg(todo_list, item);
>> @@ -4662,10 +4666,7 @@ static int pick_commits(struct repository *r,
>>   						todo_list->total_nr,
>>   						opts->verbose ? "\n" : "\r");
>>   			}
>> -			unlink(rebase_path_message());
>>   			unlink(rebase_path_author_script());
>> -			unlink(rebase_path_stopped_sha());
>> -			unlink(rebase_path_amend());
>>   			unlink(git_path_merge_head(r));
>>   			unlink(git_path_auto_merge(r));
>>   			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);

