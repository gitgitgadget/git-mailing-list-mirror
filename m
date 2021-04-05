Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF83C433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C6C613AD
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhDENUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 09:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhDENUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 09:20:51 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEA5C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 06:20:45 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so2398571otq.10
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LplSz/EFy4cJRc5wZ58I8XuCOlUaCgmZ2tXff6pv16I=;
        b=qd5PAdbGtq3ELqNJKdQ54p0rLx6tb+NY9/uTovv1uA47Ec7A3f08qurtXBR6NYR0uC
         ZlyAN4JkxH85ORd2DoUgGZ8alGSHPY+CaMZhGwx6emlJ20k4N9XtqWoaeSw4dAVsbNNz
         tTsETFTd7PGW284no6Ssuwp7Blot3NRSW3h6JOWftiK62WstIk5XlG9451vA3/vTAWaF
         3gGCte3XNBzP/Y3bezWH3UOC2CCPR+UyCDe90yS1OQJugc8jcQ1ut0jxG7jyLxS0fZXX
         N77FQmSRlJqNF5aogwX6zFIpuzdoDU+XvIirElQEYRinL/ZuQWc7HD7qDacfWp6RDrQ1
         aiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LplSz/EFy4cJRc5wZ58I8XuCOlUaCgmZ2tXff6pv16I=;
        b=lhrfvzUPQiZTg7GxfUaHC0GSkpgsT57yAPrW4z9T1wMEbpmoUEE90Ry/W1gktTGNrU
         6pR2lC17kOi6ZjBqOEPiotWGzOVqnb3w4TKaFZNt/WiqUlpIHxHcvrG/WHJLNzxfumDw
         vTQOdEZ+ON/MAkSoAMwp0KqTZIZ2plXoD537qzYb0n3FL/uiR+j/a8tw15h6+YauAsyQ
         TpxcSlCUDgx3hXaIKKe2VyvLizHHnQ8iYHvIKuVAPCKc4Jw4bP3I+Umn4XouCSJhAzAe
         nMUVtv8wyU1pnBdxfWsQ9tCpzjz4e7b7mw4XJnc7EFSWpKSkG76T1t4dhfahlORZSZZq
         CxFQ==
X-Gm-Message-State: AOAM5316gDv6HcEAL9qsNYYW507tNRNvC8aRrIAvG6PlTuL3i541YEGS
        ZmpCvy4CLXm027QlN1P6LrKzXozKIipUJQ==
X-Google-Smtp-Source: ABdhPJwgOgynjOEsy578m0YqcJqKacBdFpWJH1QNiLCl8iTXBxS8FUNeVFPwx1YIXtY4GAn6NOETsA==
X-Received: by 2002:a9d:7cd2:: with SMTP id r18mr13410953otn.240.1617628844998;
        Mon, 05 Apr 2021 06:20:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f9:c820:22ba:fec7? ([2600:1700:e72:80a0:91f9:c820:22ba:fec7])
        by smtp.gmail.com with ESMTPSA id d2sm4028693otl.48.2021.04.05.06.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 06:20:44 -0700 (PDT)
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>, git@vger.kernel.org
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com> <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com> <xmqq1rbs4c6t.fsf@gitster.g>
 <f113284b-a7fe-ba7f-ce1c-d214efd5d0c6@gmail.com> <xmqqft057ijc.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e75b1e72-6c9f-d466-ac52-24b324b44b3c@gmail.com>
Date:   Mon, 5 Apr 2021 09:20:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqft057ijc.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/4/2021 7:10 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> On 4/2/2021 5:19 PM, Junio C Hamano wrote:
>>> I do not recommend unparsed refspec and textually munging, by the
>>> way.  Doesn't
>>>
>>> 	git fetch master:remotes/origin/master
>>>
>>> first parse to normalize the src/dst sides to turn it into
>>>
>>> 	git fetch refs/heads/master:refs/remotes/origin/master
> 
> I tried to jug my memory in this area a bit by reading the relevant
> code.  For non-wildcard refspec, e.g. with
> 
>     [remote "origin"]
> 	url = ../git.git/
> 	fetch = master:remotes/origin/master
> 	tagopt = --no-tags
> 
> you'd get
> 
>     $ git fetch -v
>     From ../git
>      * [new branch]            master     -> origin/master
>     $ git for-each-ref
>     2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48 commit	refs/remotes/origin/master
> 
> It all happens inside remote.c::get_fetch_map(), I think.

I see there that some refs are being matched with some
expectation of remote refs inside get_remote_ref() (which
calls find_ref_by_name_abbrev() as a helper). There does not
appear to be any place that modifies the refs directly in
general, and instead refs are matched from the refspec using
standard short-ref rules.

This is particularly shown in examples like "git push topic"
never modifying the push-refspec from having 'src' equal to
"topic" and instead the ref machinery discovers that "topic"
really means "refs/heads/topic".

I took your advice to not munge raw refpsecs and instead
worked directly on the 'dst' of the struct refspec_item. This
required adding a method that formats a refspec, which I test
carefully. I spent about an hour trying to have parse_refspec()
add the appropriate "refs/" prefix, but it becomes difficult
when we intend to make a distinction between "refs/heads/" and
other sub-areas within "refs/". Finally, I punted on that
conversion and made the logic in 'prefetch' extremely obvious:

1. If the refspec's 'dst' starts with "refs/", then replace
   that prefix with "refs/prefetch/".

2. If the refspec's 'dst' does not start with "refs/", then
   concatenate "refs/prefetch/" and 'dst'.

This will keep a roughly-equivalent partition of refs (some
might have previously collided that will not any more).

I have posted my patch series [1], so please take a look. It
builds up the infrastructure to properly test such a refspec
expansion, if we wish to do so.

[1] https://lore.kernel.org/git/pull.924.git.1617627856.gitgitgadget@gmail.com/

Thanks,
-Stolee
