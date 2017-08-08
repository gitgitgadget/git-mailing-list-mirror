Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B587220899
	for <e@80x24.org>; Tue,  8 Aug 2017 14:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbdHHOSv (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 10:18:51 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36526 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbdHHOSr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 10:18:47 -0400
Received: by mail-qk0-f195.google.com with SMTP id d136so3227165qkg.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2mgeGEIoSaiTjtpVf0Gt9AwboKV+FjD6Lx3DuCXwxHg=;
        b=jpqcbjB6EcCDx1lsAY+w1uXYjdzrtkROepP+9eoAdUqZSqRy91hzSctHtUKdUw1pX6
         PPc9PkAuD5e9IGSROLN0WTMYuIiak9loU/IA3TB0Z4waFci5ghH1g7v9rL3nrwY+9Z5o
         auMKier0GJ9tqTvwQfOtcs+UyADL9rSR0dJVkqCAE1L8kaQnLWd/+9lUp6mfk1tU/TzC
         kj8BX+mQH2YlIj6CaDfV6he8o51T+na7cBX9SvdHig+QoCLPXUtKD9Zy553D00zMzDgI
         JEP9P4/bfluRoEt41kDHHJh5KCRwanuRM1PmLUm0CxfUA+uk4rrI4i8/zx8sHRkBFdmO
         hmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2mgeGEIoSaiTjtpVf0Gt9AwboKV+FjD6Lx3DuCXwxHg=;
        b=DNrNH82IsKmVgewRDb0kHUpQpeJ4MGFasS1wXaxmT4nqVBrraqrr6I91Iav15qegTf
         E4IkYTHSyzVdMnP8IQOQoQM1hEg1iSWN8BFdMXI75op7shB9Fp/tZYCDCyaKVDPYFOmk
         CRMfjjkM2c1i9Mb7EMoUQBxNTqD7gqC6fHqnrRB0/88IdXU+zJWAqWWH+smor2M/e2pt
         DLtdMDjVGWa+7XO4P4D+suqqbQfftAUX8gKKyOsdOQgtuoTGuEYckdotKTK0zHRsRINM
         H2RqkFcx7jsiyNLwkNBPjNns1Ke2ZcOKgh8YS9MxREoMWS6b/KrkglcZFZlWbJe0nlu2
         1woQ==
X-Gm-Message-State: AHYfb5gGoePMFfdgVIaall2PhxMB1e2wTKMjioBJ9DysijwAxdBMDSJq
        kIs06KKCWt6k2EuvJH4=
X-Received: by 10.55.78.23 with SMTP id c23mr5210649qkb.323.1502201926679;
        Tue, 08 Aug 2017 07:18:46 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f15sm724635qtf.93.2017.08.08.07.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 07:18:45 -0700 (PDT)
Subject: Re: Partial clone design (with connectivity check for locally-created
 objects)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        christian.couder@gmail.com
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
 <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
 <20170804172137.42f27653@twelve2.svl.corp.google.com>
 <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com>
 <20170807192151.GX13924@aiede.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <12fbcba3-1b31-2240-a330-e7cc11820f4a@gmail.com>
Date:   Tue, 8 Aug 2017 10:18:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170807192151.GX13924@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/7/2017 3:21 PM, Jonathan Nieder wrote:
> Hi,
> 
> Ben Peart wrote:
>>> On Fri, 04 Aug 2017 15:51:08 -0700
>>> Junio C Hamano <gitster@pobox.com> wrote:
>>>> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>>>>> "Imported" objects must be in a packfile that has a "<pack name>.remote"
>>>>> file with arbitrary text (similar to the ".keep" file). They come from
>>>>> clones, fetches, and the object loader (see below).
>>>>> ...
>>>>>
>>>>> A "homegrown" object is valid if each object it references:
>>>>>   1. is a "homegrown" object,
>>>>>   2. is an "imported" object, or
>>>>>   3. is referenced by an "imported" object.
>>>>
>>>> Overall it captures what was discussed, and I think it is a good
>>>> start.
>>
>> I missed the offline discussion and so am trying to piece together
>> what this latest design is trying to do.  Please let me know if I'm
>> not understanding something correctly.
> 
> I believe
> https://public-inbox.org/git/cover.1501532294.git.jonathantanmy@google.com/
> and the surrounding thread (especially
> https://public-inbox.org/git/xmqqefsudjqk.fsf@gitster.mtv.corp.google.com/)
> is the discussion Junio is referring to.
> 
> [...]
>> This segmentation is what is driving the need for the object loader
>> to build a new local pack file for every command that has to fetch a
>> missing object.  For example, we can't just write a tree object from
>> a "partial" clone into the loose object store as we have no way for
>> fsck to treat them differently and ignore any missing objects
>> referenced by that tree object.
> 
> That's related and how it got lumped into this proposal, but it's not
> the only motivation.
> 
> Other aspects:
> 
>   1. using pack files instead of loose objects means we can use deltas.
>      This is the primary motivation.
> 
>   2. pack files can use reachability bitmaps (I realize there are
>      obstacles to getting benefit out of this because git's bitmap
>      format currently requires a pack to be self-contained, but I
>      thought it was worth mentioning for completeness).
> 
>   3. existing git servers are oriented around pack files; they can
>      more cheaply serve objects from pack files in pack format,
>      including reusing deltas from them.
> 
>   4. file systems cope better with a few large files than many small
>      files
> 
> [...]
>> We all know that git doesn't scale well with a lot of pack files as
>> it has to do a linear search through all the pack files when
>> attempting to find an object.  I can see that very quickly, there
>> would be a lot of pack files generated and with gc ignoring
>> "partial" pack files, this would never get corrected.
> 
> Yes, that's an important point.  Regardless of this proposal, we need
> to get more aggressive about concatenating pack files (e.g. by
> implementing exponential rollup in "git gc --auto").
> 
>> In our usage scenarios, _all_ of the objects come from "partial"
>> clones so all of our objects would end up in a series of "partial"
>> pack files and would have pretty poor performance as a result.
> 
> Can you say more about this?  Why would the pack files (or loose
> objects, for that matter) never end up being consolidated into few
> pack files?
> 

Our initial clone is very sparse - we only pull down the commit we are 
about to checkout and none of the blobs. All missing objects are then 
downloaded on demand (and in this proposal, would end up in a "partial" 
pack file).  For performance reasons, we also (by default) download a 
server computed pack file of commits and trees to pre-populate the local 
cache.

Without modification, fsck, repack, prune, gc will trigger every object 
in the repo to be downloaded.  We punted for now and just block those 
commands but eventually they need to be aware of missing objects so that 
they do not cause them to be downloaded.  Jonathan is already working on 
this for fsck in another patch series.

> [...]
>> That thinking did lead me back to wondering again if we could live
>> with a repo specific flag.  If any clone/fetch was "partial" the
>> flag is set and fsck ignore missing objects whether they came from a
>> "partial" remote or not.
>>
>> I'll admit it isn't as robust if someone is mixing and matching
>> remotes from different servers some of which are partial and some of
>> which are not.  I'm not sure how often that would actually happen
>> but I _am_ certain a single repo specific flag is a _much_ simpler
>> model than anything else we've come up with so far.
> 
> The primary motivation in this thread is locally-created objects, not
> objects obtained from other remotes.  Objects obtained from other
> remotes are more of an edge case.
> 

Thank you - that helps me to better understand the requirements of the 
problem we're trying to solve.  In short, that means what we really need 
is a way to identify locally created objects so that fsck can do a 
complete connectivity check on them.  I'll have to think about a good 
way to do that - we've talked about a few but each has a different set 
of trade-offs and none of them are great (yet :)).

> Thanks for your thoughtful comments.
> 
> Jonathan
> 
