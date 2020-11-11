Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09029C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908942072C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnZ2PB5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgKKQvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgKKQvX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:51:23 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204ECC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 08:51:23 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id n132so2306644qke.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 08:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fQN5qF2kAtsMEXd0NMoRgLrnxBKKjTf3r4tXWMLrpHw=;
        b=DnZ2PB5KCn1mC/ve8G3rXr/2ZEpsaNwGWhseS7eYeqIlWgwyt/g8jme+0Hov9BIORv
         6GbZrdhAMVXqWCMs5MGsErmUh+h3w79JkykkAKG0MavrWq4bmgm/O4b0T/PQB8NH/Gm+
         bPNITbf/RSiqGS+H+i0kADB2ctDnm2l4iJPQjJqOFBQCsB7N0edg5KhlA67i0zHp5J8w
         mLdC17sNuG3xJ5FUXoaV/O277Pd5RwScF3JIeyMIoCbRfco0D6JiS8RhoashgFMCJyzN
         ZWQ1Dz8QwY/uUtM+/5UhdoChy53I1H68iueyDpJkTHgDrNEnMun6tD1bRoE70r5EZ5Ns
         lBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fQN5qF2kAtsMEXd0NMoRgLrnxBKKjTf3r4tXWMLrpHw=;
        b=I9uh9PoO9amLPRDuYMTUPIozwxZCumbpPqZGtL1gRWb0P+BpCY4RQASElC2z3FAJwP
         YZK+PWnpGGbLjV823m7Cyf7E3keAtJZUALjEe6WLFh1kAS3KZGhkec73WqVXVRWoEUP5
         T1WBBQMugpxB8z6KdFgQkHsIP+/nlkFHGHFbp3kSKEkAUQaSdjNFo0Of5MCI6EPwzs7q
         CyrB/HIbPWg7w+/k9Z5YRBqEcIRj4XvX5ysU5zebYO2/pAftc6VKhqsG/dhmsTHo5//M
         tvw6vlzUU2ijdSihtDP2p5Z+uEmZNOZ3ui0MHHkMvbDe5CQSX7BZprNz+iaG0PbNYpoF
         lkBg==
X-Gm-Message-State: AOAM530ONv2npeJHryf3SlaFYkBKXAhK1QT3Y2cjfBs80dW3LlsyQtfV
        0ZvoqbMq3OTUfAzrgfcwtmqlA3/thbMnJw==
X-Google-Smtp-Source: ABdhPJzcOJC0ZHHzr7L8I2XmYImD5AW5ERTN/IwnebeyLfolxy0/sq4S3Nj5sn9IyXcqEKlmzVEB+w==
X-Received: by 2002:ae9:c210:: with SMTP id j16mr25211189qkg.53.1605113481634;
        Wed, 11 Nov 2020 08:51:21 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id w45sm2753197qtw.96.2020.11.11.08.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:51:20 -0800 (PST)
Subject: Re: [PATCH v2 04/20] merge-ort: use histogram diff
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-5-newren@gmail.com>
 <cd05d258-a526-9843-f646-d2d42f1b8cbc@gmail.com>
 <CABPp-BFd2Wg-9h9+Gx20szX=YfKLqvBMWGg-eZU0yL8_DPh6kw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91898d2a-174f-a9c6-f174-3c7809f79b34@gmail.com>
Date:   Wed, 11 Nov 2020 11:51:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFd2Wg-9h9+Gx20szX=YfKLqvBMWGg-eZU0yL8_DPh6kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2020 11:47 AM, Elijah Newren wrote:
> On Wed, Nov 11, 2020 at 5:54 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 11/2/2020 3:43 PM, Elijah Newren wrote:
>>> I have some ideas for using a histogram diff to improve content merges,
>>> which fundamentally relies on the idea of a histogram.  Since the diffs
>>> are never displayed to the user but just used internally for merging,
>>> the typical user preference shouldn't matter anyway, and I want to make
>>> sure that all my testing works with this algorithm.
>>>
>>> Granted, I don't yet know if those ideas will pan out and I haven't even
>>> tried any of them out yet, but it's easy to change the diff algorithm in
>>> the future if needed or wanted.  For now, just set it to histogram.
>>
>> If you are not making use of the histogram yet, then could you set this
>> patch aside until you _do_ use it? Or are there performance implications
>> that are also a side benefit?
> 
> Long story...

...

> Does that help?

In summary, you have some concrete reasons to prefer the histogram
diff other than just "I have some ideas that might pan out later" so
this code change is a good one but could be better justified in the
commit message. Does that sound correct?

Thanks,
-Stolee

