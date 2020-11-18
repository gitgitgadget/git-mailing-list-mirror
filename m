Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D69C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3A7246A7
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZo6Yyp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgKRTml (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgKRTml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 14:42:41 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC164C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:42:40 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n11so2970374ota.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W74xEhKsqs9Ie8bfpmqtkRuOu8HP9s1TCaMl2M7E0f8=;
        b=FZo6Yyp7ARmcg+URbPEK5VlycCPyq+YPb1+swZqJEgs3Rp7/kAl2UFVPBXqw3b9TOI
         j0GcbKmon9VN3h5UQiXZh00+ZzTprgr0FTnelzo6j3IsNo35rHFATRCVHIlSo16tTJ7g
         aa0yeVYyYADnrcyX0z889mABEMy6YPbs53eNIfkgDMa8qmh4R/aLnX5tgCcez8S+NvGC
         Qa9k8GNmjOEM+O9noTYxxmbBrsWoiW4WJR5M5vFQbx99UN0siZ3y+EN5n20qb5qYWNBZ
         Fkg5bcycTMo4kojK8vilKzx6zonH0ktQz2OeeZMniM3wLCUl3ue/Mjl7WwSYermtv0ag
         5mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W74xEhKsqs9Ie8bfpmqtkRuOu8HP9s1TCaMl2M7E0f8=;
        b=j3mfEZRKnL1ztAFOFbL3zMrWu8VTtkO+gTXRwYcENUdADc400ozPkJsRAQtp74Y3m8
         fMulVyL1tn42KvJexXdg+LQXiE7a9EbhYP1njH/j9RaPXLCOZ7wg1wQjTm6MclMHbr4X
         4OwYRLkCEEbZrKQUssw9xJHY9b/Wy/Ut2PJPmbZp2BNlWcgihQPVsY1nrReRrxBpnAAb
         2WdJMvYzECDIGU81LvbtuzVZVbrHfqA72uw0xMG9cnN3bDIs2yE0UhYxG/d45G3TuhiL
         /WRYLT1jV4UvrLij19XF7/GQVhUj6UBcqNIRsCftrnal0GARtNkKNM7OgSachaLXBc8S
         w/fw==
X-Gm-Message-State: AOAM531CJOOL0xK/4eih6qhwHoI5xQ4DQJu4O3cG7d8f30TOcM6DeOle
        CmE5SktBFSXcbHFzAHExla0=
X-Google-Smtp-Source: ABdhPJyVWY1Q0rXqEvMBLX6CqzsA0EKh3jwTAls0/Hv6srIeVDVLzzcQWeP757mR5QTVInTm1DTbiA==
X-Received: by 2002:a9d:7c98:: with SMTP id q24mr6962415otn.147.1605728560077;
        Wed, 18 Nov 2020 11:42:40 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:805f:b8ae:cbb3:6b01? ([2600:1700:e72:80a0:805f:b8ae:cbb3:6b01])
        by smtp.gmail.com with UTF8SMTPSA id l184sm262881oih.27.2020.11.18.11.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 11:42:39 -0800 (PST)
Subject: Re: [BUG?] "git config --replace-all key value value_regex" ignores
 value_regex?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
References: <466ee1d8-efaa-fc91-f3d9-230672289ffb@gmail.com>
 <xmqqo8ju1ooc.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c7dfbd1b-44bc-d074-5ec9-1011738c1522@gmail.com>
Date:   Wed, 18 Nov 2020 14:42:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8ju1ooc.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2020 1:54 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> --replace-all::
>> 	Default behavior is to replace at most one line. This replaces
>> 	all lines matching the key (and optionally the value_regex).
>>
>> However, this test fails:
>>
>> test_expect_success '--replace-all and value_regex' '
>> 	q_to_tab >.git/config <<-\EOF &&
>> 	[abc]
>> 	Qkey = one
>> 	Qkey = two
>> 	Qkey = three
>> 	EOF
>> 	q_to_tab >expect <<-\EOF &&
>> 	[abc]
>> 	Qkey = four
>> 	Qkey = two
>> 	Qkey = three
>> 	EOF
>> 	git config --replace-all abc.key four "o*" &&
>> 	test_cmp expect .git/config
>> '
> 
> I do not know or try to guess the original intention (I thought this
> is Dscho's thing, no?), but if there are one/two/three and I were
> asked to replace all of those that have zero or more 'o' in it with
> 'four' I would expect that
> 
>  (1) all three be removed, because they all have zero or more 'o',
>      and then
> 
>  (2) one instance of 'four' be added,
> 
> resulting in a single 'four' left.
>
> If the value_regex were "o+" (since it takes ERE) to mean one or
> more, then my expectation would be
> 
>  (1) one and two be removed, because 'three' does not match, and
>      then
> 
>  (2) one instance of 'four' be added,
> 
> resulting in two items, 'three' and 'four'.
> 
> An alternative interpretation would be that each of the removed
> entries is replaced with a new one, resulting in three entries
> (i.e. with "o*", it would leave three identical entries 'four',
> with "o+", it would leave 'four', 'four' and 'three'), but that
> may be less useful in practice.

Thank you. Naturally, PEBKAC and my lack of understanding the
regex I was using in my own test. Clearly this is behaving
correctly. Modifying as suggested shows this works properly.

Thanks,
-Stolee

 

