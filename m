Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A27C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 07:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKYHLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 02:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYHLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 02:11:07 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33161193F8
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:11:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c21so1492899pfb.10
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3fmxp0uDwh2uULe8BqSe+lEhl5ZuU7U2ZdZJkI75B1M=;
        b=XTsVp/AI8jlgP9UKlHuMmpz8EGu7D47RdobAkYkbxhVMpg6bAQNy4p9KBbyU37J27R
         QNNOQG5H2x2z0ULT7XJP2NE0fgtLuzAfqeJZylW4v5mBvj09ObLHytSjStE15vxrxSPE
         nsmPUOwVehJyqWVGKUUlqINGMqczcxiKbEEICc+D9xcEN/KbWR+UaGvHjpkjKqenvJDX
         lvk+nQVhB7E81xpeZ8BAPE9dxk5SsqJronBQ9o18TQyBkyzwzKsSPOG4FyqWKeKuELph
         dKqBCGkamvR0J70bvAsuB7KFH2f8WgvOA3psdcpP59EaMKIiHsyrMQWLQfd3smDYO4DS
         FrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fmxp0uDwh2uULe8BqSe+lEhl5ZuU7U2ZdZJkI75B1M=;
        b=8RtHvkYyRx1yiQWhmwKekNeXeFvejdlrMR/6NrE4DwPpU82mnDxRayrndKFQw1ZNSd
         bQrjcosm3HUlMJGtVJYk3JQnJlh7rAN3I9XD21EtYLqos43nDALhMile+R1gJW11Z9/R
         2jiL7l4sDhq7apw1cYRjVFb55YvCPAlg4z4xasUpZww3LxLE/U3KNwHbZlr9KDEJBpOd
         H9Hjk3JLr0G6kHPBIZvyCqpHe94HcwuactcRiYM1qlkJFvSNQv8kJN4GJGO9MZXu2I7Z
         REZYu7grQwjuN63Mg4HFjqiG+1edj3XIHs1wwS1c6ZmH9OhnXk8CcFXfGfSv8JHbOVWb
         b6Mw==
X-Gm-Message-State: ANoB5pkWlG0KEunVYiIICnm3AkHwXQh2ICFXJs4JH2rDI/ubou27hVu7
        0q1jbC7x3PbFYy/fvFJrycU=
X-Google-Smtp-Source: AA0mqf4wokaP4UMnyXNVn1ZxmTTHk/vIIwxHfkVa0CK1NzNsfkht0nGSy/B2GjSJCq8FHSD7EUFVLg==
X-Received: by 2002:a63:dd16:0:b0:476:d2d9:5151 with SMTP id t22-20020a63dd16000000b00476d2d95151mr13811936pgg.487.1669360265496;
        Thu, 24 Nov 2022 23:11:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a129-20020a621a87000000b0056dde9895e2sm2356907pfa.30.2022.11.24.23.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:11:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without
 ellipsis, options
References: <20221102120853.2013-1-philipoakley@iee.email>
        <20221112143616.1429-1-philipoakley@iee.email>
        <xmqqfsedywli.fsf@gitster.g>
        <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email>
        <xmqqedtvu7py.fsf@gitster.g>
        <7a6c3d32-4494-e209-9877-e8784f0c3502@iee.email>
Date:   Fri, 25 Nov 2022 16:11:04 +0900
Message-ID: <xmqq7czjecfr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 22/11/2022 00:57, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>>> As a design question, what should "Trunc" do in such a case now?  I
>>>> do not think we can still call it "hard truncate" if the feature
>>>> gives "[][]" (i.e. fill only 4 display columns, resulting in a
>>>> string that is not wide enough) or "[][][]" (i.e. exceed 5 columns
>>>> that are given), but of course chomping a letter in the middle is
>>>> not acceptable behaviour, so ...
>>> The design had already covered those cases. The author already had those
>>> thoughts
>> Sorry, I was saying that none of
>>
>>  * giving only [][] to fill only 4 display columns, without filling
>>    the given 5 display columns,
>>
>>  * giving [][][] to fill 6 display columns, exceeding the given 5
>>    display columns,
>>
>>  * giving [][][ that chomps a letter in the middle, in a failed
>>    attempt to fill exactly 5 displya columns.
>>
>> would be a sensible design of the behaviour for "Trunc", so I am not
>> sure what "had already covered" really mean...
>>
> I'm still unsure what you are trying to say here.
>
> Is this a question about the prior `trunc`, `mtrunc`, and `ltrunc`
> design and tests?
> e.g. how complete are their tests?

No.  As I said, the existing lowercase ones may already be buggy (I
didn't check), in that they may do "[][].." or "[][][]" when told to
"trunc" fill a string with four or more double-width letters into a
5 display space.  But the point is at least for these with ellipsis
it is fairly clear what the desired behaviour is.  For "trunc" in
the above example, I think the right thing for it to do would be to
do "[][].", i.e. consume exactly 5 display columns, and avoid
exceeding the given space by not giving two dots but just one.

But with "hard truncate", I do not think we can define any sensible
behaviour when we ask it to do the same.  Giving "[][]" leaves one
display space unconsumed and giving "[][][]" would exceed the given
space, so anything you would write after that would be unaligned on
the line.

As to the tests, the question was, whatever the designed behaviour
for the above case, if they record the design choice made by this
series (even though, as I said, I suspect no design choice for the
"hard-fill/trunc odd number of columns with a run of double-width
letters" problem is satisfactory).
