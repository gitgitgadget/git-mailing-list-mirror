Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889ACC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 14:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC7D20BED
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 14:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGMWxXSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgIXOFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgIXOFU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 10:05:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C202C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 07:05:20 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 26so3770490ois.5
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kz69BF+JvQoL/bvNlANqlIdNfV6q5jzB98/XTu1Zv3I=;
        b=CGMWxXSQTaxsdKUOxGqr4B0ZQ2voDcGHpgcz+rKanzStjTMxWDBNsaKGVhqbjSCp6C
         UQf+ViQtCi7UcGW7W6nqH1lARiS940HqbW3snmhEFUWfbabD9xPaNf8Q3vX5BhSt104N
         V5gJRRy+x+RNKARNaUZXIzXcgz2CYlAxEr1a66OdriZRjSBH6oGtrD4QWRIxfSBZTZfU
         DoQnVe4WGICyvFzpmwlK8VbXnzZlE3cJ2laZe/5l5BIcV6BF3UGiv9zfvTamhlsLnYlO
         C8tn8e4OcT2lPrYYKILtZsPDFEuT7zD/Q4RMsTuJYOggFuGPWDskk4yE49EpryOYuuIP
         YPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kz69BF+JvQoL/bvNlANqlIdNfV6q5jzB98/XTu1Zv3I=;
        b=EnYfYdDUabFVW7spk2ip9y5UD7/1m4qO35a9jGwki1a8DLQ7grz2sQEu4v1VYb4wtr
         +awOy2YK5cKg4hD7PiknrzTIOj+FDDMxASAIN1J2jGt7hBKCNdUhCexhCFiUdksNDX63
         nB4mNlUdVfBdgOwjhmBVJMvWc05kUXw/12Tn5ppIF/yLzEJtsZOyngr8ctWo+tJKUYbN
         kb1c8fuej+BLnqpZo8RFZL6qsALnmdeKlqW04qV/NQYx73E7+wUWuzEut2tYVFRGy/2w
         DcdtCAIxH7mky0j5n4RIQzgeoXa+DbYTIZfFpBMkoiHcgjFWpgp3zHzuJ2tBdqWWa8aN
         HNHA==
X-Gm-Message-State: AOAM531BYknJI4pjB7a8E/vo+Rp3XHFbSpZLDZ1t84JB2SBXVEkcMLNw
        wiCJrYWQqQzpGX6kFIOj04U=
X-Google-Smtp-Source: ABdhPJwFU06/nZ+/9owMCHSdDFc0TVPPKhBG+aMfqKaU4fHMdyIdN5oUvIxju7FG+ObH4E4TcV4LXA==
X-Received: by 2002:a05:6808:3ce:: with SMTP id o14mr2380334oie.157.1600956319640;
        Thu, 24 Sep 2020 07:05:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79a4:d6bb:a424:ecd4? ([2600:1700:e72:80a0:79a4:d6bb:a424:ecd4])
        by smtp.gmail.com with ESMTPSA id g22sm818495ots.35.2020.09.24.07.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 07:05:19 -0700 (PDT)
Subject: Re: [PATCH v3 6/8] maintenance: add incremental-repack task
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com
References: <0dd26bb584bb7e8b9616eb32f7b1235462df77fa.1598380599.git.gitgitgadget@gmail.com>
 <20200922232654.914862-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <691ac9f0-0678-8c95-18ad-7b54f92ae531@gmail.com>
Date:   Thu, 24 Sep 2020 10:05:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200922232654.914862-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2020 7:26 PM, Jonathan Tan wrote:
>> +incremental-repack::
>> +	The `incremental-repack` job repacks the object directory
>> +	using the `multi-pack-index` feature. In order to prevent race
>> +	conditions with concurrent Git commands, it follows a two-step
>> +	process.
> 
> [snip]
> 
>> First, it deletes any pack-files included in the
>> +	`multi-pack-index` where none of the objects in the
>> +	`multi-pack-index` reference those pack-files; this only happens
>> +	if all objects in the pack-file are also stored in a newer
>> +	pack-file. Second, it selects a group of pack-files whose "expected
>> +	size" is below the batch size until the group has total expected
>> +	size at least the batch size; see the `--batch-size` option for
>> +	the `repack` subcommand in linkgit:git-multi-pack-index[1]. The
>> +	default batch-size is zero, which is a special case that attempts
>> +	to repack all pack-files into a single pack-file.
> 
> This lacks the detail of what happens to the selected group of packfiles
> (in the second step) - in particular, that a new packfile is created and
> the MIDX is rewritten so that all references to the selected group are
> updated to refer to the new packfile instead, thus making it possible to
> delete the selected group of packfiles in a subsequent first step. All
> this is explained in the documentation of git-multi-pack-index (expire
> and repack), though, so it might be better to refer to that. E.g.

Here is my attempt to incorporate your recommendations into this doc:

incremental-repack::
	The `incremental-repack` job repacks the object directory
	using the `multi-pack-index` feature. In order to prevent race
	conditions with concurrent Git commands, it follows a two-step
	process. First, it calls `git multi-pack-index expire` to delete
	pack-files unreferenced by the `multi-pack-index` file. Second, it
	calls `git multi-pack-index repack` to select several small
	pack-files and repack them into a bigger one, and then update the
	`multi-pack-index` entries that refer to the small pack-files to
	refer to the new pack-file. This prepares those small pack-files
	for deletion upon the next run of `git multi-pack-index expire`.
	The selection of the small pack-files is such that the expected
	size of the big pack-file is at least the batch size; see the
	`--batch-size` option for the `repack` subcommand in
	linkgit:git-multi-pack-index[1]. The default batch-size is zero,
	which is a special case that attempts to repack all pack-files
	into a single pack-file.

> Do we need get_midx_filename() to be global?

No, that does not appear to be important (to this patch). It _was_
necessary when doing the "verify, then delete if problematic" mode.
Thanks for catching it now that it is not necessary.

Thanks,
-Stolee
 

