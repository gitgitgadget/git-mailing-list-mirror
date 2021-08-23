Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9DC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C55B61391
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhHWSBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhHWSA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 14:00:59 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00EEC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 11:00:16 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso23756911ota.8
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PZJSo0l4QS1KYZpjPO91LVE2pX5mqn/qq+wnTUzvh98=;
        b=cuT5egqvTKdfby3hktG/vRy54G8qR/GRF5z3q33qyEaClIyahdiiOAnFMxrQbAl+bf
         AmJQ2LUSq3bdQCAM4oHA1LhmuC/tNog9M60pePQwPQ3436Ave3i2bFvm57X/rl4EvB/U
         wUHwUHaipRi0vFYrL7dVF5QHnRiSdce3kjmggW/IDWMuWEIFwe0MLUojg5nfAe7KTFKq
         hxU/SMmHFc1s7VffNm+Y8qYIEQBzWDU7HmpISOUB4rlZS2H3qXszBRP/g8/wcEMX7Lx7
         +9h5buRgSgdrXhbBloVEk+WdWmfGGCsKpv02l39JGoKvxeSrQ9RoerHgoh6XRuwswtAw
         qmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZJSo0l4QS1KYZpjPO91LVE2pX5mqn/qq+wnTUzvh98=;
        b=LFE7uDGRHXzgGwEjjYEntoTKhpGde+vx4uYuM5WTtwUlyNAPhVAx2rLEJmq+KvM2HM
         uM18o6A0UP59KTfSqRNjF0Qv70njWc+txebjyrZQbLAyKW4Zd98X/h/AVNgbI4C0FHro
         tYWhRK/d0cyjXEkkH0VbQgwfdZEbmyRaap2akVca80i1IzJDeYRJaE8ttOwAcWimhEGd
         YN+Wame53HLsc8b9l4yvQuZUJlcbMe+oe+40K5t7lvmHIdHIrkgJsHshHKAq8xQ7bvCG
         M5E8DE80yjFpSADYC7p2U/Gi7xA/Lwen5eF8CeRg53pmWVaAHReF0LZVepZrLv+hVX2g
         lXDA==
X-Gm-Message-State: AOAM533Rq3FtC1bBFDfZl9DYK2dD0wRTLZg3xD6XNVoIXQxTKBDcN9dx
        AV2YcLp/qYLpmJRH1LEchzBBQchklMU=
X-Google-Smtp-Source: ABdhPJyXkhjo3LAEV86/MsMWVbrndnRiFELttU4vO8QIbUYunwIA8MrObrxmenqu5nGepE/VAIGYRQ==
X-Received: by 2002:aca:4b85:: with SMTP id y127mr12608845oia.169.1629741615882;
        Mon, 23 Aug 2021 11:00:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:48bd:24c0:4055:3255? ([2600:1700:e72:80a0:48bd:24c0:4055:3255])
        by smtp.gmail.com with ESMTPSA id o2sm2004728otl.54.2021.08.23.11.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 11:00:15 -0700 (PDT)
Subject: Re: [PATCH v2] multi-pack-index: fix *.rev cleanups with --object-dir
To:     Taylor Blau <me@ttaylorr.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20210823094049.44136-1-johannes@sipsolutions.net>
 <YSPHdofrDOQk3xmy@coredump.intra.peff.net>
 <be882704d7cf2a96a78c5c745c0bca2c53150a28.camel@sipsolutions.net>
 <YSPWQtOjKVgIKqsd@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <35654780-b0f7-d1b1-d7a1-0365e42f63b4@gmail.com>
Date:   Mon, 23 Aug 2021 14:00:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSPWQtOjKVgIKqsd@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 1:09 PM, Taylor Blau wrote:
> On Mon, Aug 23, 2021 at 07:05:31PM +0200, Johannes Berg wrote:
>> On Mon, 2021-08-23 at 12:06 -0400, Jeff King wrote:
>>> I'm not entirely convinced that writing a midx when not "inside" a repo
>>> is something that we want to support. But if we do, then...
>>
>> Seemed like that was the point of --object-dir?
> 
> Stolee (cc'd) would know more as the original author, but as I recall
> the point of `--object-dir` was to be able to write a midx in
> directories which were acting as Git repositories, but didn't contain a
> `.git` directory.
> 
> It's kind of a strange use-case, but I recall that it was important at
> the time. Maybe he could shed more light on why. (Either way, we're
> stuck with it ;)).

Yes, the point was for how VFS for Git (and now Scalar) built the
"shared object cache" directory. This is a directory that acts as
an alternate for VFS for Git and Scalar clones so objects downloaded
by one enlistment are immediately available in another.

When the multi-pack-index was created, it was designed to handle
this shared object cache through the --object-dir parameter. There
are custom patches in microsoft/git that shoehorn the option into
background maintenance via a config value.

If I were to redesign the feature for use by Git, then I would make
the clones create a bare copy of the repository (if it doesn't already
exist) and then create a worktree of that bare repo. The key is to
allow users to delete individual worktrees without losing the object
data.

In summary, there is a reason for its design like this, although its
due to an external tool. But we are using it a lot, so I'd prefer that
it stay.

Thanks,
-Stolee
