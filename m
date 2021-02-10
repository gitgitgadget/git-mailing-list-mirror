Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C28C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 12:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9ED64E3B
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 12:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhBJM1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 07:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhBJMZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 07:25:27 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D651C061788
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 04:24:47 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id e9so132045qvy.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 04:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/wohsc9YI0V8+vjDqBZwujZcfakFmJjJTLvXKJyzMh4=;
        b=BNflEkxNgy5Tkl3UoodISWCgERaXl8DnIgy1tDXE7CYE3D+1lgZJfzkivJF+V9y4LP
         57pAqfNHLq5BWuN+e7r/XxmTwAPqLUZ2x33DdZ1ifKbdxwFlz8YEcnNQK++vBPU2G6hv
         ZNH9Hqrvr8WIw1sHA5uH9eOyPFKQM1q8ZFGca3mIMQupOA46F4qDyRFgDtWpdk1NjWS8
         QzuOZ+9Cqbe8uybpH+qwCyXV2uF0ReJ9RWwRLG67nsx2Hxb6tRbjY2ZCHvKbw0gZsKmh
         b/ny5wrXHbz5pDkG2xEAdNTqeq7OoMPq5TS3g4QrhtkvXSaNtEKuOD5Y2ndc9XZWw0/5
         C6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/wohsc9YI0V8+vjDqBZwujZcfakFmJjJTLvXKJyzMh4=;
        b=SE5dlqQSQxCXxabomczkBHoG8RXwvVHym+nXOno3NCgtx1+1lq82ip/Vx9FNhs/iz0
         k6SidkK8TrupAl+SDzobn7cByKqTPZBjV6XjP6Gg5LCKObF3Gx7+PdFuz4ldQqyMv+A6
         thbpqi9fdjds2chZJ6dzLFi9ux+k+qX51GbtVQE39euYsNMUH1MGqyScfLR9Vj51pXnk
         DRJyCZE1oZ52MHiRlJkPcuDMN/ESNddC9KOaHEvOW0zIhIs9JAllsPhpLbkN/JSaAxdg
         vmaQWZr2pt7tNRfYttMrYFT9Hl9vr2/raKuXDd/nv3tlabzSaTLvgMEyYrD9M8PQ8pe8
         GHVA==
X-Gm-Message-State: AOAM532ODeZMkJj2tPIMhjZdLD0p2AUB3VJosyWDTQ0NMWNi/h3nTVa8
        pMImkIqhg3jf2b048rRtmteRzxqNF57FFA==
X-Google-Smtp-Source: ABdhPJydr6sqXAgRo4sn9jtE0I6I00cIFnWvtSDOcHkGU3Vpk3s1ee9b4lYwx+WcFvfeSrp5ATQB3g==
X-Received: by 2002:ad4:5a42:: with SMTP id ej2mr1166403qvb.60.1612959886133;
        Wed, 10 Feb 2021 04:24:46 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:3593:b85d:ba2c:2d31? ([2600:1700:e72:80a0:3593:b85d:ba2c:2d31])
        by smtp.gmail.com with UTF8SMTPSA id q8sm1341892qkm.38.2021.02.10.04.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:24:45 -0800 (PST)
Message-ID: <962a2abc-6352-4d19-c39f-29f3c744f861@gmail.com>
Date:   Wed, 10 Feb 2021 07:24:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: BUG: commit-reach.c:66: bad generation skip
Content-Language: en-US
To:     Filippo Valsorda <valsorda@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
References: <CA+2K_KotVrV=rjE6fcd_FfxxS0sewkywvO0EMVZdoHbSiqJTQw@mail.gmail.com>
 <CA+2K_KqH=Gn=Yx-UYzMBO+gZje3G3PJ_3-5HeO81wyZKvVwOSA@mail.gmail.com>
 <c19b6e23-96cd-fd0a-163d-826b46b51da0@gmail.com>
 <CA+2K_KqEzH7XmrHXd0Vniu+tBQpFwFnYPyzoj-kMhyN2NnoZFQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CA+2K_KqEzH7XmrHXd0Vniu+tBQpFwFnYPyzoj-kMhyN2NnoZFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/2021 7:18 AM, Filippo Valsorda wrote:
> On Mon, Feb 8, 2021 at 3:26 AM Derrick Stolee <stolee@gmail.com> wrote:
>> _This_ is interesting. I haven't heard of this problem happening
>> in a released version of Git.
>>
>> I'm CC'ing Jonathan Nieder who recently saw this happening, but that
>> was on a newer version than 2.30.0 with a topic that is not part
>> of 2.30.0. But maybe the version shipped internally is versioned
>> without extra information on top of the latest tag? (I see your
>> @google.com email, which makes me think you have an internal version.)
> 
> Ah, the issue indeed first showed up as I was using the internal
> version. I then installed mainline 2.30.0 to check that it reproduced
> on the same local repository before reporting a bug.

The mainline does have the BUG() statement, but it's really reflecting
bad data in the commit-graph file. That data was written by the internal
version and was not reset until you rewrote the file.

>> To better understand your situation, could you please run the
>> following commands?
>>
>>         git config --get-regexp graph
>>         git config features.experimental
>>
>> I'm specifically looking for values of fetch.writeCommitGraph and
>> gc.writeCommitGraph.
> 
> fetch.writecommitgraph is enabled on the internal version.
> 
> $ git version
> git version 2.30.0.478.g8a0d178c01-goog
> $ git config --get-regexp graph
> fetch.writecommitgraph true
> $ git config features.experimental
> $ ~/homebrew/bin/git version
> git version 2.30.0
> $ ~/homebrew/bin/git config --get-regexp graph
> $ ~/homebrew/bin/git config features.experimental
> 
> I zipped up the repository and the worktree before running gc, so I can
> run other commands for you if you need, but unfortunately I can't share
> the archive, as it fetched from a private branch with security fixes.

Thanks, but let me know if it reproduces again. The bug should be fixed
in ds/commit-graph-genno-fix [1], and I think the Google internal release
has been rolled back until that branch is included.

[1] https://github.com/gitster/git/commits/ds/commit-graph-genno-fix

Thanks,
-Stolee
