Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B39620954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbdKVRp7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:45:59 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:42645 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdKVRp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:45:57 -0500
Received: by mail-pg0-f42.google.com with SMTP id j16so12866655pgn.9
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 09:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GkC349RWh7a/thkBHaJMyALnigwqwnyydVkwu2hEEN0=;
        b=HZ7Rj8hxpb/gE4o2sDyZ+Hf1MIoM1ASDv94e1pbl89mQ/fPXtdpXUcf9cRMfZ/x5f6
         jpwhrt0XhzoZ1ozh+2zfpfEaF3OFuYjcJIewzRjoj2GhdCiTpYAwByReGoY1jMW74+sq
         yOefyzqP4sxYI0nBg13g8ZvK0W5mhsaieepB41TNTQH6Zjz/HRZ2GvJ4NognmHW52m/0
         WhUet7gKG/OKatCHq36HJnXE+RMksIeaLuZfNF8YJit0BrJa9ZIsAztCEGZK3sLGJ5Cq
         T8cSmcGAO4jxqvT1jvxcKoi65jyMeTNTeAzT5ho9GqRfvh7LC+q+jwcav51Wc+Fyrkmp
         awAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GkC349RWh7a/thkBHaJMyALnigwqwnyydVkwu2hEEN0=;
        b=BFP+Ch6q1RuFsmXRzQxcXm8GY1YZq7kTV1sm9mfybXNUw1KmxhDjmBofaahY6GpzZH
         Q0DjWPFRGwFE3T3YxrpZ8rp2AMUCCn8YX4D+kvljB0BHy/fnEfqZfMEkq3O81RZNnwq9
         x1AIl5UKG1HB8EcTVVZiBQfTdEJeeqPcKps1nb6zdru6n8fBMl0HccP97fGXtZP1WUTQ
         N7/0FK19j5cYsyY5YS+Lntr+hQUKYmSLBFH2GxqhuaZzxGkosYNb0hLOqIHCZIX84fO5
         JcBabl0KRvQDt6tSDCJbP02qMeoy2pEJTrQLa+sh8Z7FCWNLMGS3DNhLYBwA85VehOgL
         5I8w==
X-Gm-Message-State: AJaThX77zXja3rrwThYGJJ48Ix54rw3iDsreWmo5nQaeDuYQT2sOChOu
        KpHOnaPaulwJu8O0XPDAZmvz8S+t
X-Google-Smtp-Source: AGs4zMZiLU8RHIAHy7zH6GPF1GsLDwnTH7GzNqszBqejv7O+5Qcb1NX0lG0TewFnMRcMQVQmVqO34g==
X-Received: by 10.98.237.5 with SMTP id u5mr19861247pfh.209.1511372757222;
        Wed, 22 Nov 2017 09:45:57 -0800 (PST)
Received: from ?IPv6:2405:204:73cd:cf11:6767:b6f6:4b9c:e3f? ([2405:204:73cd:cf11:6767:b6f6:4b9c:e3f])
        by smtp.gmail.com with ESMTPSA id c1sm29198877pfa.12.2017.11.22.09.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 09:45:56 -0800 (PST)
Subject: Re: [PATCH v2 4/4] builtin/branch: strip refs/heads/ using
 skip_prefix
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
References: <20171121141852.551-1-kaartic.sivaraam@gmail.com>
 <CAPig+cSGu-+6Bw3YBzMwzxO8vKt7jdf9xgtr9FUdOAQpXzi2rQ@mail.gmail.com>
 <60caf5c8-4dc3-481a-80d6-37a697e31b52@gmail.com>
 <CAPig+cRK8+pzf3EWuoG+36CRNaaGv6CQk27d4CrzTv=8beoQGg@mail.gmail.com>
 <xmqqeforxdx6.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b5083b36-c91b-f3c7-2a22-237a1e08f993@gmail.com>
Date:   Wed, 22 Nov 2017 23:15:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqeforxdx6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 22 November 2017 07:39 AM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Tue, Nov 21, 2017 at 2:12 PM, Kaartic Sivaraam
>> <kaartic.sivaraam@gmail.com> wrote:
>>> On Wednesday 22 November 2017 12:08 AM, Eric Sunshine wrote:
>>>> The original code unconditionally uses "+ 11", which says that the
>>>> prefix is _always_ present. This commit message muddies the waters [...]
>>>
>>> That muddiness of that statement is a consequence of my recent encounter[1]
>>> in which the assumption (that the prefix(refs/heads/ always exists) of that
>>> code failed. I had a little suspicion, when I wrote that commit message,
>>> that there might be other cases in which assumption might fail. The issue
>>> has been resolved only in 3/4 of jc/branch-name-sanity but that was only
>>> after I wrote the commit message initially.  So, it does make sense to
>>> remove that muddiness now. Thanks for noting that.
>>>
>>> [1]: Note the 'warning: ' message in the following mail. That ugly '|�?' was
>>> a consequence of the assumption that the 'prefix' always existed!
>>> https://public-inbox.org/git/1509209933.2256.4.camel@gmail.com/
>>
>> Thanks for the explanation and history reference.
> 
> I have a suspicion that it wasn't the case.  The ugly uninitialized
> byte sequence came from an error codepath of a function that is asked
> to fill a strbuf with "refs/heads/$something" returning early when it
> found an error in the input, without realizing that the caller still
> looks at the strbuf even when it got an error.  That caller-callee pair
> was updated.
> 

You seem to be right when viewing from the perspective of the callee 
(strbuf_check_branch_ref). IOW, you *seem* to be telling that the 
"callee" should have known that the caller was expecting the 'prefix' 
even in case of an error and should have "inserted" it regardless of the 
error (I thought the strbuf was initialized and contained the result of 
strbuf_branchname even in the case of an error) ?

I thought that the 'caller' should have known that the 'callee' would 
not insert the prefix when there was an error in the branch name thus it 
should have anticipated that there would be a case in which the prefix 
(refs/heads/) doesn't exist in the buf (the assumption).


> It is just a bug and +11 is always correct; passing the data that
> does not begin with "refs/heads/" there, including the case where an
> uninitialized buffer is passed, is simply a bug.

Let me see if I could correlate your statement with that error. AFAIK, I 
don't think the buffer was uninitialized in the case of that error. It 
had in it the result of interpretation of 'strbuf_branchname', didn't 
it? So that clears one case and leads me to the interpretation that,

"Passing the data (at an offset of 11 bytes from the beginning of the 
buf) that does not begin with "refs/heads/" is a bug"

Which seems to be in line with my statement that it was wrong (in the 
part of the "caller") to assume that "strbuf_check_branch_ref" always 
returns a buf with the prefix "refs/heads/" ?


> 
> In other words, skip_prefix() is a good change, but if we are to use
> it, we should also check the result and error out if we do not see
> "refs/heads/" there--you already bothered to spend extra cycles for
> that.
> 

Makes sense. I should have better done this initially instead of giving 
a muddy justification for not doing it.


Thanks,
Kaartic
