Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266F5C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 21:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbiCNVU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 17:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiCNVU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 17:20:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32912754
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 14:19:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q14so26066175wrc.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1KuyPgtA9Fv1s7wkmK1PRXndZkUB3bYMgFvvBZzUeeU=;
        b=iXVU2ZROixwMKzYMrRoaXw7G93GfHThVsa2UmvGxtgVzmgzYhTknQXRzssuTbnA3z1
         QgBoavpUDfWL57bp8mrB51FYSycw+ufZ9gi1vaUeG9Mn/3lSUhSjwZ2ZHal+eUEL24Mv
         hW0CbGnM2pycPp9Nz+lBXW9iUSKK6aLnnArRawvq/ActSrf17uSQ0mhJxXkNSPXjV2zK
         D/r+bK3cp84CC1Ueq/MSBPg8IIq0LBI4iZRCwh5EHHVr8YWBu3ONM5UqEqHzeSZ+B0jC
         TekOrpf99WG/OuCcJFMc63N9CVmaPPgNkiyEWxJ10Qka0//61IPQKmjI+G+pLsevqJYZ
         XIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1KuyPgtA9Fv1s7wkmK1PRXndZkUB3bYMgFvvBZzUeeU=;
        b=LLz6yrYVjbeSbMHgU0c0uwL5iua/0BSwceGKoLHbTSQTyT1iwdO/YLwR6U+0joGhtc
         vXeagnbCISPfElO0Hx/qCVpDGHCDoK9KGwB2a9mYTe+21WvHrVYHFJwvyInbKeaMntAN
         ZM0Iikxc2tebnmV08mLANhCrL/7uI0i9WhR9CfwggyW9JBnOgISAe2mkxKDG0W2x7+DV
         fdmk+h8b7djkDxJImAw+lfKhx83ktgS24YwrQXjgkrNina4hAK4U/3ZA56Y2RKvvIoxb
         d4WzUP+R6AjDZF6dLNqRKtazqKq0zWwbWXV+toZd2TSZGv0zvoAKYTjHaLwGxBf7q+5P
         2KWg==
X-Gm-Message-State: AOAM533GOGSJ4VqZPsro+ttWpuEjU9EDVuXN7MX5XpssYzGVJPKY0RPr
        e9V2EljWnMNj2WX3lk+FdSw=
X-Google-Smtp-Source: ABdhPJz5ZJtXdpJNARGZvz2Fb0hYy7vYjpmWsRyybKVcacyy16/7pQ3nTgpGWQkqLSG+BM0LlqqH+Q==
X-Received: by 2002:a5d:55cd:0:b0:1ef:6e69:9c78 with SMTP id i13-20020a5d55cd000000b001ef6e699c78mr17930253wrw.626.1647292752195;
        Mon, 14 Mar 2022 14:19:12 -0700 (PDT)
Received: from [192.168.1.240] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d4586000000b001f0436cb325sm14376344wrq.52.2022.03.14.14.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 14:19:11 -0700 (PDT)
Message-ID: <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
Date:   Mon, 14 Mar 2022 21:19:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/6] builtin/stash: provide a way to export stashes to a
 ref
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220310173236.4165310-5-sandals@crustytoothpaste.net>
 <220311.86bkydi65v.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220311.86bkydi65v.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian and Ævar

Firstly I think this is a useful feature to add to git stash, thanks for 
working on it Brian

On 11/03/2022 02:08, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 10 2022, brian m. carlson wrote:
> 
>> +	size_t author_len, committer_len;
>> +	struct commit *this = NULL;
>> +	const char *orig_author = NULL, *orig_committer = NULL;
>> +	char *author = NULL, *committer = NULL;
>> +	const char *buffer = NULL;
>> +	unsigned long bufsize;
>> +	const char *p;
>> +	char *msg = NULL;
> 
> These shouldn't be initialized unless they really need to..
> 
>> +	this = lookup_commit_reference(the_repository, &info->w_commit);
> 
> ..and some are clobbered right away here, so all of these should not be initializzed.
> 
>> +	buffer = get_commit_buffer(this, &bufsize);
>> +	orig_author = find_commit_header(buffer, "author", &author_len);
>> +	orig_committer = find_commit_header(buffer, "committer", &committer_len);
>> +	p = memmem(buffer, bufsize, "\n\n", 2);

You could start searching from orig_committer rather than buffer but I'm 
sure it doesn't make any real difference. The sequencer does something 
similar to this to replay commits when rebasing - is there any scope for 
sharing code between the two?

> ...since by doing so we hide genuine "uninitialized"
> warnings. E.g. "author_len" here isn't initialized, but is set by
> find_commit_header(), but if that line was removed we'd warn below, but
> not if it's initialized when the variables are declared..
> 
>> +		for (size_t i = 0;; i++, nitems++) {

Do we need i and nitems?

>> +			char buf[32];
>> +			int ret;
>> +
>> +			if (nalloc <= i) {
>> +				size_t new = nalloc * 3 / 2 + 5;
>> +				items = xrealloc(items, new * sizeof(*items));
>> +				nalloc = new;
> 
> Can't we just use the usual ALLOC_GROW() pattern here?
ALLOC_GROW_BY() zeros out the memory which would mean we could remove 
the memset() calls in the loops. I noticed in some other loops we know 
the size in advance and could use CALLOC_ARRAY().

>> +			}
>> +			snprintf(buf, sizeof(buf), "%zu", i);
> 
> Aren't the %z formats unportable (even with our newly found reliance on
> more C99)? I vaguely recall trying them recently and the windows CI jobs
> erroring...

According to [1] it has been available since at least 2015. It is 
certainly much nicer than casting every size_t to uintmax_t and having 
to use PRIuMAX.

>> +	for (ssize_t i = nitems - 1; i >= 0; i--) {
> 
> The ssize_t type can be really small (it's not a signed size_t), so this
> is unportable, but in practice maybe it's OK...

I'm not really convinced by this ssize_t can be small argument[2], do 
you know of any platforms where it is true?

Best Wishes

Phillip

[1] 
https://docs.microsoft.com/en-us/cpp/c-runtime-library/format-specification-syntax-printf-and-wprintf-functions?view=msvc-140#size

[2] 
https://lore.kernel.org/git/e881a455-88b5-9c87-03a8-caaee68bb344@gmail.com/

