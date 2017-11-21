Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD762036D
	for <e@80x24.org>; Tue, 21 Nov 2017 19:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdKUTMs (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 14:12:48 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:40451 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdKUTMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 14:12:47 -0500
Received: by mail-pg0-f45.google.com with SMTP id u3so10905166pgn.7
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 11:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytUeZUPzSUFwuNbWZ2aMnAp4PlKuUKBQDFmE+wDuBLc=;
        b=JcY1lzanXTgsGWgwFK/2wiEPkszl91L/UMHol9anvp4HCLW4oRGqAKyJJzKSWp40vQ
         l+myuMS0D4o/BcZmjXRnyA47bkKycHcB6L5ysbrIgfOZXh7Fk4C4u4l0YySpoOCYV4Rw
         wO7zpCKUxAPhNY7D9It5Z7Ur760klugfxm7Jdolpdm098MRi58ROIfTaHAQ5Xkq/DYb3
         L6U/6oZQnwOc+0fczYjqEkdvJsP07zpgBMo+Emyr9OXXrLjZe8pspRlkJaoJEfLCGsd9
         WyPFvTWZTJxE2LSyAeeGrnlHU5DmKqjfoVUH7L1cwk/wmjNej/o0oTrqeePFmiFG8fYC
         tcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytUeZUPzSUFwuNbWZ2aMnAp4PlKuUKBQDFmE+wDuBLc=;
        b=QOVEd/iZvHf3gm5ZwaVOLTWc4ISlNxcWfuBmZkIoXjIyb0ivoP6rkiMxV0KmAQT4bn
         BukJyxCw/2ptHmfXhpmhmu+iIk3JgsqYewftbvm1u7QA9c4ZVGSYjM+uPmYsfkj/MXgQ
         j7hhccNNM65DOx7aHOEoRqsxro0WQQVIwAnjIs+DVmFPBO+B7gb8QAsXBJ45oKld3TH7
         7GWQ4Ntj0vFfGsj/ppe6KPG+EmIIPTH91/jOEKBcXdNAeST464SQH8BLFcBReMgfyVwT
         ncSr/jDTBVoHPLBQ3NXp5nO8qRzFOio/E89lCQD7eHoZX6gps3FY7TdMTyZ9i2sT7Y49
         duug==
X-Gm-Message-State: AJaThX449Tsn5mxfltSALaMgxx8Dcj02VKLuTUXhEWI7VeXiEJhsqpKC
        vtntwerC0+j/5OPjumWclLFREGVK
X-Google-Smtp-Source: AGs4zMZIUiG9XkgIWap5+28Od4ANZRPzGIeHwgFpMYwfaXxgDEuxUDtmBuxHxwWACOKOm9Ub2zEEyA==
X-Received: by 10.84.211.79 with SMTP id b73mr18592937pli.419.1511291567047;
        Tue, 21 Nov 2017 11:12:47 -0800 (PST)
Received: from ?IPv6:2405:204:7280:849f:7a33:ea78:e714:400? ([2405:204:7280:849f:7a33:ea78:e714:400])
        by smtp.gmail.com with ESMTPSA id f9sm9559280pgq.11.2017.11.21.11.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 11:12:45 -0800 (PST)
Subject: Re: [PATCH v2 4/4] builtin/branch: strip refs/heads/ using
 skip_prefix
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20171121141852.551-1-kaartic.sivaraam@gmail.com>
 <CAPig+cSGu-+6Bw3YBzMwzxO8vKt7jdf9xgtr9FUdOAQpXzi2rQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <60caf5c8-4dc3-481a-80d6-37a697e31b52@gmail.com>
Date:   Wed, 22 Nov 2017 00:42:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSGu-+6Bw3YBzMwzxO8vKt7jdf9xgtr9FUdOAQpXzi2rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 22 November 2017 12:08 AM, Eric Sunshine wrote:
> On Tue, Nov 21, 2017 at 9:18 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>>
>> Though we don't check for the result of verification here as
>> it's (almost) always the case that the string does start
>> with "refs/heads", it's just better to avoid hard-coding and
>> be more communicative.
> 
> The original code unconditionally uses "+ 11", which says that the
> prefix is _always_ present. This commit message muddies the waters by
> saying the prefix might or might not be present. Which is correct? If
> the code is correct, then the commit message is misleading; if the
> message is correct, then the code is buggy and the commit message
> should say that it is fixing a bug.
> 

That muddiness of that statement is a consequence of my recent 
encounter[1] in which the assumption (that the prefix(refs/heads/ always 
exists) of that code failed. I had a little suspicion, when I wrote that 
commit message, that there might be other cases in which assumption 
might fail. The issue has been resolved only in 3/4 of 
jc/branch-name-sanity but that was only after I wrote the commit message 
initially.  So, it does make sense to remove that muddiness now. Thanks 
for noting that.


>> diff --git a/builtin/branch.c b/builtin/branch.c
>> @@ -493,13 +495,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>> +       /* At this point it should be safe to believe that the refs have the
>> +          prefix "refs/heads/" */
>> +       skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname);
>> +       skip_prefix(newref.buf, "refs/heads/", &interpreted_newname);
> 
>      /*
>       * Format mult-line comments
>       * like this.
>       */
> 
> However, this in-code comment shares the same problem as the commit
> message. It muddies the waters by saying that the prefix may or may
> not be present, whereas the original code unconditionally stated that
> it was present. Moreover, the comment adds very little or any value
> since it's pretty much repeating what the code itself already says.
> Consequently, it probably would be best to drop the comment
> altogether.

Makes sense. Of course, only if there aren't any code paths that lead to 
a state where the expected prefix doesn't exist. Hope, there's none!


> 
>>          if (copy)
>>                  strbuf_addf(&logmsg, "Branch: copied %s to %s",
>>                              oldref.buf, newref.buf);
>>          else
>>                  strbuf_addf(&logmsg, "Branch: renamed %s to %s",
>>                              oldref.buf, newref.buf);
>> -
>>          if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
> 
> Was the blank line removal intentional?

Nope.


Footnotes:
[1]: Note the 'warning: ' message in the following mail. That ugly '|�?' 
was a consequence of the assumption that the 'prefix' always existed!

https://public-inbox.org/git/1509209933.2256.4.camel@gmail.com/


---
Kaartic
