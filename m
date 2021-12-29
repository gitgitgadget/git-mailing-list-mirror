Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CD1C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 21:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhL2VjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 16:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhL2VjN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 16:39:13 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C8C061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 13:39:13 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id v30-20020a4a315e000000b002c52d555875so7344977oog.12
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 13:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yyq/1uCLgMMsPkK79GSqDJp04aHJj5iw/Roq7y9PmqU=;
        b=MBwZL6p13pEJKHJ0Nxtel291nLrbw9Iox3DkLiH+cdWtBRtkVbBUaMeIvpjtcQrj9o
         I/xsYjJDrph0wqDROJmh77pIhLhrcj+ggBzIB844T1JXJaTB2Fgq5ywQ+wkvMF4RctWN
         INaRhiuLZun5NxA2pBLhP+hjvuLNQMLM1PMoGw8RjTuQrGQPMkg+njb5hKcw1PbtWgat
         kYBi5wVKYdDqISLTb2HlVas0dYANeBHE2WzZ2ttcwwQfdRJ+nwa6xejGL9lP1mvGav10
         WijYYsNZPNXK1w43pZYHvTEFG3n23QTxzUYSfibEYnl91UtGowUI6px80iuTmADX+NHw
         3c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yyq/1uCLgMMsPkK79GSqDJp04aHJj5iw/Roq7y9PmqU=;
        b=S45OUk4n5kXaOAxWgnl37L7Inlvz71AAlf8joc8huRLXaPT1Qq4jdItZGFqM3Pstln
         /jH4lw6uwNHD3K/30LN9UDg0ORrQ9dR7ML/UxSNC4xQ7S84xAO8fuM/LJej45ui42U4R
         CyJ2NzRawd1LJ2j6Nx4wpT5XFg7TH0f4hNASGtWfWDd5909WDWcGeD5OpIDId1oC+qKr
         Uxpj3Q3Y3+nhw9TLYpVGGDOYVlJxJF/G2YLyGmB3gSPBrLASLjFmq24BQDD/9ddjRjuk
         zu97vgoamlobQNrUvh9DxTC3ziK+3T5kaswqNQ0eNm4h5DEWpZv+eAOJkgLKpM8X9NSf
         JoXw==
X-Gm-Message-State: AOAM531Zc+bkIG20lAH53nBsmjGdaAvEjF7QvxKV9ZrwmYE+TBvw8KE+
        bWlqBBQBWmIDh1jBTl6q0iJBswteLoo=
X-Google-Smtp-Source: ABdhPJwQQcuB2KiV1QKevLbYSOiBgb+5qDDMWb71z2v1hxWNIKacg4bNEOpOelmXBTB8ehx8wdui3w==
X-Received: by 2002:a4a:cf09:: with SMTP id l9mr15930564oos.89.1640813952429;
        Wed, 29 Dec 2021 13:39:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2566:73c:fa6f:8d49? ([2600:1700:e72:80a0:2566:73c:fa6f:8d49])
        by smtp.gmail.com with ESMTPSA id a17sm5042650oiw.43.2021.12.29.13.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 13:39:11 -0800 (PST)
Message-ID: <0aa32f4d-9101-16ff-58b8-29a8651a69f8@gmail.com>
Date:   Wed, 29 Dec 2021 16:39:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 6/6] worktree: copy sparse-checkout patterns and config
 on add
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <fcece09546cbdb5f1bcd0d0c5aaa3a54e9d3b852.1640727143.git.gitgitgadget@gmail.com>
 <CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com>
 <e2ef25b5-9802-1dd9-b96c-ea85d2082b48@gmail.com>
 <CABPp-BE9umOTkjfnB0X+9nTZaBmeXd4z5DmiZ1Upzds=m1spPw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BE9umOTkjfnB0X+9nTZaBmeXd4z5DmiZ1Upzds=m1spPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2021 2:51 PM, Elijah Newren wrote:
> On Wed, Dec 29, 2021 at 9:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 12/29/2021 1:37 AM, Eric Sunshine wrote:
>>> On Tue, Dec 28, 2021 at 4:32 PM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
> 
>>> The obvious way to work around this problem is to (again) special-case
>>> `core.bare` and `core.worktree` to remove them when copying the
>>> worktree-specific configuration. Whether or not that is the best
>>> solution or even desirable is a different question. (I haven't thought
>>> it through enough to have an opinion.)
>>
>> It makes sense to special case these two settings since we want to
>> allow creating a working worktree from a bare repo, even if it has
>> worktree config stating that it is bare.
> 
> Agreed.
> 
>> As far as the implementation goes, we could do the copy and then
>> unset those two values in the new file. That's an easy enough change.
> 
>> I'll wait for more feedback on the overall ideas (and names of things
>> like the init-worktree-config subcommand).
> 
> What value does the init-worktree-config subcommand provide; why
> shouldn't we just get rid of it?
> 
> I know Eric was strongly suggesting it, but he was thinking in terms
> of always doing that full switchover step, or never doing it.  Both
> extremes had the potential to cause user-visible bugs, and thus he
> suggested providing a command to allow users to pick their poison.  I
> provided a suggestion avoiding both extremes that doesn't have that
> pick-your-poison approach, so I don't see why forcing users into this
> extra step makes any sense.
> 
> But perhaps I missed something.  Is there a usecase for users to
> explicitly use this?

I think the motivation is that worktree config is something that is
harder to set up than to just run a 'git config' command, and we
should guide users into a best practice for using it. The
documentation becomes "run this command to enable it".

It also provides a place to update the steps if we were to change
something in the future around worktree config, but I'm guessing
the ship has sailed and backwards compatibility will keep us from
introducing a new setting that would need to be added here.

Thanks,
-Stolee
