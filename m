Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F02C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 17:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbiFNR10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344893AbiFNR1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 13:27:25 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC533F
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 10:27:20 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d6so7073893ilm.4
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cE85wbRwRxHzN5EFC+gg6i99lZgjR8wQ1jA4wmUstZg=;
        b=LjdWQZIw58f1E9JXPuPu6GPr8qwZRW6UFXgKkjLRsJO5iCiJROFu36ARRlyHomsYht
         P8Ff4oEX1loRGvi8tgV+4CM8SMt8b8vaUnj4Wt2k45uL3ffXDHpZqu53tkQBU4Hf7GLR
         NLoa1IHFUJssC76lWUxbb1vZmT5nVyNgBUb+x3YQtrt+K5bCEzdI63IEC3s+83aDyfOY
         +/1RGPXW5ioRl9CkHy2Dt2CX0acPURtp+/Garndp7K8+XFO6bTngbC9zCmhRn9vXSUbe
         3I9atE+pTp92fiYyL1dylFDO9c+ajfj31v1/qsvQ9WhB3QfwdQaq6Z5tMIDniWhmOVGa
         9Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cE85wbRwRxHzN5EFC+gg6i99lZgjR8wQ1jA4wmUstZg=;
        b=mJbcxivvVpXy19oiFMU8Gs9UcGvO2PZlSTOhxNWyV09Li0I7zp7UWS06pAzVhHL5cd
         Am0i8zIVjeA4eilgWfNrqBedFqPO8bf4JUg2e0QfMSV0AdQRiPdHhzeUXWdVKNKdEo72
         XCXaJ/ePWUTuN89cVkkvc1o7UHRnuWiLDvw+xzzE9YccdjsbYvIZqmzfWMq/ddGUCMqj
         8PjSFLZl+t/P2JriNN07altPrrLYXDIKy5xLG33VQ4Zq3Qm9UtFDzh5oJzOT+TrrJYIn
         CriMZrZeiqtq2Opds5WAu92bzAPX/7M24NwBc9i1pyHZ3M0I97rRnz/MVDTXGXjpBjxJ
         R85g==
X-Gm-Message-State: AJIora9HBBJ82+XXU4+DnfWHwjHsP+Vt/8Pqol5tHrmMBXBskQX8HJw7
        1/HmK4lLbX/G3Lvjrocv8zM3
X-Google-Smtp-Source: AGRyM1vOngzrHtERQvoIQqXCjritdlbXZL8PVvMiMQckOr3t2id9oQRI1IRRU25L3uGPdWgZM8Ey/w==
X-Received: by 2002:a05:6e02:1bc8:b0:2d4:342:9c68 with SMTP id x8-20020a056e021bc800b002d403429c68mr3928750ilv.254.1655227640205;
        Tue, 14 Jun 2022 10:27:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id t5-20020a6bdb05000000b0065a47e16f49sm5640388ioc.27.2022.06.14.10.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:27:19 -0700 (PDT)
Message-ID: <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
Date:   Tue, 14 Jun 2022 13:27:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mktree: learn about promised objects
Content-Language: en-US
To:     Richard Oliver <roliver@roku.com>, git@vger.kernel.org
Cc:     jonathantanmy@google.com
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2022 12:33 PM, Richard Oliver wrote:
> On 14/06/2022 15:14, Derrick Stolee wrote:
>> On 6/14/2022 9:36 AM, Richard Oliver wrote:
>>> Do not use oid_object_info() to determine object type in mktree_line()
>>> as this can cause promised objects to be dynamically faulted-in one at a
>>> time which has poor performance. Instead, use a combination of
>>> oid_object_info_extended() (with OBJECT_INFO_SKIP_FETCH_OBJECT option),
>>> and the newly introduced promisor_object_type() to determine object type
>>> before defaulting to fetch from remote.
>>
>> Have you run some performance tests on this? It seems like this will
>> scan all packed objects, which is probably much slower than just asking
>> the remote for the object in most cases.
>>
>> Thanks,
>> -Stolee
> 
> 
> Hi Stolee,
> 
> I've put together a synthetic experiment below (adding a new blob to anexisting tree) to show you the behaviour that we've been seeing.  Our
> actual use-case (where we first encountered this behaviour) is updating
> submodules to a known hash. As you can see, the round-trip time of fetching
> objects one-by-one is very expensive.
> 
> Before, using system git (git version 2.32.0 (Apple Git-132)):
> 
>> $ git init
>> # Fetch a recent tree
>> $ git fetch --filter=tree:0 --depth 1 https://github.com/git/git cdb48006b0ec7fe19794daf7b5363ab42d9d9371
>> remote: Enumerating objects: 1, done.
>> remote: Counting objects: 100% (1/1), done.
>> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
>> Receiving objects: 100% (1/1), 13.12 KiB | 13.12 MiB/s, done.
>> From https://github.com/git/git
>>  * branch            cdb48006b0ec7fe19794daf7b5363ab42d9d9371 -> FETCH_HEAD
>>
>> $ NEW_BLOB=$(echo zzz | git hash-object --stdin -w)
>>
>> $ cat <(git ls-tree FETCH_HEAD) <(printf "100644 blob ${NEW_BLOB}\tzzz") | time git mktree
>> remote: Enumerating objects: 1, done.
>> remote: Counting objects: 100% (1/1), done.
>> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
>> Receiving objects: 100% (1/1), 334 bytes | 334.00 KiB/s, done.
>> remote: Enumerating objects: 1, done.
>> remote: Counting objects: 100% (1/1), done.
>> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
>> Receiving objects: 100% (1/1), 2.01 KiB | 2.01 MiB/s, done.
>> remote: Enumerating objects: 1, done.
>> remote: Counting objects: 100% (1/1), done.
>> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
>> Receiving objects: 100% (1/1), 256 bytes | 256.00 KiB/s, done.
>> # ...
>> # SOME TIME LATER
>> # ...
>> e26c7ce7357b1649da7b4200d4e80d0b668db8d4
>>       286.49 real        15.66 user        15.59 sys

I see. The problem here is that we are making _many requests_ for the same
tree, so maybe it would be better to introduce a batched download for the
list of missing objects. This would require iterating over the objects for
the tree to check existence (in quick mode) and adding the missing ones in
a list, then requesting that set altogether in a single request.

That probably won't be as fast as your modified mktree experiment below,
but would match my expectations of "probably faster assuming the repo is
big enough".

> Repeated experiment, but using modified mktree:
> 
>> $ cat <(git ls-tree FETCH_HEAD) <(printf "100644 blob ${NEW_BLOB}\tzzz") | time git mktree
>> e26c7ce7357b1649da7b4200d4e80d0b668db8d4
>>         0.06 real         0.01 user         0.03 sys
> 
> Did you have any other sort of performance test in mind? The remotes we
> typically deal with are geographically far away and deal with a high volume
> of traffic so we're keen to move behaviour to the client where it makes sense
> to do so.

I guess I wonder how large your promisor pack-files are in this test,
since your implementation depends on for_each_packed_object(), which
should be really inefficient if you're actually dealing with a large
partial clone.

Thanks,
-Stolee
