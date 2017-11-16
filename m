Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27AA9202D7
	for <e@80x24.org>; Thu, 16 Nov 2017 17:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbdKPRFF (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 12:05:05 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:47963 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936193AbdKPRCu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 12:02:50 -0500
Received: by mail-pg0-f50.google.com with SMTP id o7so21006856pgc.4
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Znfqlzj7Qw/C6tu0Poc0mUW0nsEWNoq4Os7JMqyPMTs=;
        b=DT6QTHHIcFDj+CyLKeey2/rkwxYxAOP77rY8ECU4e8F5hKyjvHV8Br9qzSt9rmChwo
         5S4iPG8GJXXPHRLICUWykSVdMmpjwZd4/e4c+gMNo2Bgpd2shJ3gSVmIXwZJI/gVe7l/
         ftX002P0MNOVPsr64WJlRHoLRrIwFVD/TwQYgKbntJCKdW+8tb4ocia31On0ryNDIqYT
         a/MI7hMKCjpO+2cunAhMtqH5yVZJeBxHA6U+eLZ45p2jMhIPbor3jlRgXoHrjReidRhT
         U7sZkItPZdJCwiPH1Pzp/GApamdoDmVvB6ZnHXw+eoR7AjK4Fm9w8AvgK3jdQftQMGEi
         vReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Znfqlzj7Qw/C6tu0Poc0mUW0nsEWNoq4Os7JMqyPMTs=;
        b=GXO8dmlsjsbBS3BBmzVU1kb03NDk8qrgAO+j7hA/AVaWF+IKPm/JtC9y5I5TtzPGjn
         FIGSwYk+baortTAw9MvWDl9v1GGqhJzBta2VA+9zMLyZx2vJBcGCmXezZaj1rdq4m2n1
         k/iywPBWxFWwxx2iZBH1RC98mXYU1HKEBOosg60uet+uLzqHx2ipWkE2gMJOchgpCNJT
         5NubaS5nbO9grpkgez2KmIqpVRqhzTpfyTCZn9UGL0UZMERnSNRCNbqOxoVTiPftt5qd
         Wx76WshwnMPkOrUGoyJDLBAjeh4d8fm+xEj+dbo1gOA8Y1/ArbMUQlbwexhBTP/gh2JS
         0yZA==
X-Gm-Message-State: AJaThX6F/W0byTI48b60V4vMY/tOszdh5iMr6MLvDB8zOCbhLhD5igGE
        dhfiyq0d0WnmgXmLi0HUyAc=
X-Google-Smtp-Source: AGs4zMbYy7mhS0VlGcdjcJfa5CPh1MQ9UwfxvtO6LzFcDZRPg0p4HqLjBRnfJZAp3giK0CCPihhAKQ==
X-Received: by 10.84.169.36 with SMTP id g33mr2375713plb.10.1510851769770;
        Thu, 16 Nov 2017 09:02:49 -0800 (PST)
Received: from ?IPv6:2405:204:72c0:fc36:f2a4:a5ab:70fc:f807? ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id k20sm4909361pfg.141.2017.11.16.09.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 09:02:48 -0800 (PST)
Subject: Re: [PATCH 3/4] branch: correctly reject refs/heads/{-dash,HEAD}
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20171013051132.3973-1-gitster@pobox.com>
 <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
 <0f8166ab-7955-aa78-7d32-0ec80944f007@gmail.com>
 <xmqq375g3nkf.fsf@gitster.mtv.corp.google.com>
 <bb3485d0-71bc-452e-e4b9-8a7d767753a5@gmail.com>
 <xmqqpo8jyyti.fsf_-_@gitster.mtv.corp.google.com>
 <471c7b6e-d3a0-4aee-8f80-282ff0b8d972@gmail.com>
 <xmqqlgj6uv8k.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <d2bd10c1-be6a-25e2-47cf-613f34ed9513@gmail.com>
Date:   Thu, 16 Nov 2017 22:32:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgj6uv8k.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 16 November 2017 08:27 PM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> I guess this series is not yet ready for 'next'. When I tried to apply
>> this patch it doesn't seem to be applying cleanly. I get some
>> conflicts in 'sha1_name.c' possibly as a consequence of the changes to
>> the file that aren't accounted by the patch.
> 
> Oh, it is totally expected that this patch (and others) may not
> apply on 'next' without conflict resolution, as this topic, as all
> the other topics, are designed to apply cleanly to either 'master'
> or 'maint' or one of the older 'maint-*' series, if it is a bugfix
> topic.  A patch series that only applies cleanly to 'next' would be
> useless---it would mean all the topics that are already in 'next'
> that interacts with it must graduate first before it can go in.

Thanks for the explanation. Seems I still have to become accustomed to 
the workflow.


> Make it a habit to build on 'master' or older and then merge to
> higher integration branches to make sure it fits with others.
>

Though I don't clearly understand how to do that, I'll let experience 
teach me the same (if possible). :-)


> What you could do is to inspect origin/pu branch after you fetch,
> and look at the commit that merges this topic to learn how the
> conflicts are resolved (the contrib/rerere-train.sh script may help
> this process).
> 

Sure thing.


>>> +	if (*name == '-' ||
>>> +	    !strcmp(sb->buf, "refs/heads/HEAD"))
>>
>> I guess this check should be made more consistent. Possibly either of,
> 
> Among these two, this one
> 
>> 	if (starts_with(sb->buf, "refs/heads/-") ||
>> 	    !strcmp(sb->buf, "refs/heads/HEAD"))
> 
> has more chance to be correct.  Also, if we were to check the result
> of expansion in sb->buf[], I would think that we should keep a
> separate variable that points at &sb->buf[11] and compare the
> remainder against fixed strings, as we already know sb->buf[] starts
> with "refs/heads/" due to our splicing in the fixed string.
> 
> Because the point of using strbuf_branchname() is to allow us expand
> funny notations like @{-1} to refs/heads/foo, and the result of
> expansion is what eventually matters, checking name[] is wrong, I
> would think, even though I haven't thought things through.
> 
> In any case, I would say thinking this part through should be left
> as a theme for a follow-on patch, and not within the scope of this
> one.  After all, checking *name against '-' was part of the original
> code, so it is safer to keep the thing we are not touching bug-to-bug
> compatible and fixing things one step at a time (the one fix we made
> with this patch is to make sure we store refs/heads/-dash in sb when
> we reject name=="-dash").
> 

Good point. This is better for a follow-up patch as there's a 
possibility that we might be introducing new bugs which weren't present 
previously as a consequence of changing that conditional (bug-to-bug 
compatibility, good term that (possibly) summarizes my long-winded 
explanation ;-)
