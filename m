Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA5C1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 17:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934490AbeGFR46 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 13:56:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36375 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeGFR44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 13:56:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so4967812wro.3
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RGk9hO0LWlmyNkAo2qVW6zIDiowY+r8/fDFNnygOc2k=;
        b=Fr5Hlb3UjVETunbsQ5aijfVktQEb3AR3GHlIlI45ZDKExNY/CNMGOBpAfie/jfUpLE
         E66UQNlF0BrtCbuOVaDSEro6TMevwKoEU3kjreMpiqH5O8q0WEIAqDMwK8YSpuyWnPdR
         sKtlJb255K2HUR98B/wWW1DoyvgX0k7o7COYfb7dzNTMTHupHHrqX/IhPdo5noIiUTo9
         SoP3KP4XU0kt6jbrl9nKSx0fjQWwWOkdxLw6i48OvIxErYyaEQraFOY93nVzUW65445U
         YBHQ7NMYx0Zl+P+xuroXk4HnEC2szy8uHnkRQpX1mLM4ayfvYh4dGB1AgP0EfI4/JnGT
         b4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RGk9hO0LWlmyNkAo2qVW6zIDiowY+r8/fDFNnygOc2k=;
        b=oOaak0+7fPtTaXkkMi3UGe6/I2CPgkX3TLd+zxOy6vPnWbiYFxmKzCV66g2Suun43Q
         JND9FRPp2rpabMb4acf93dykaUy4v+LMB8UNowcPlNUsKaoIBrZJqmxPoo3HlSdLqngS
         BjxtFXFf9O1/FUal/WEKLPO8yNu6R7ob83LUUcVIEBrN35VZ2WuUSKpfys3wMWA8wnoI
         uPIs15nJPvzpHmxw2zX5RtvF/xkh2aT8wcGvEZBEIrxt1hihqkOoF8tgYkeITpf1Viwl
         Jz80n5FaClPEzr+kjMx7c88rAO/T4KroXqplb65liTuaXq+c01AKe/7k7AwpkPtW2sOI
         dH4A==
X-Gm-Message-State: APt69E28/AOASzfj3bwne2i2tjpy7QAk1HVK3Io3de/c4CikVZVSyW41
        xJLASFqcpL4BQg5uoGrf+MZudUXc
X-Google-Smtp-Source: AAOMgpfb7Bcp6SlgKwAVbm4rU6nRKwdHCWcUFIHNlOArLUWzzT/aV8dXe9Lz5sUVeVqwOmqqrZW43w==
X-Received: by 2002:adf:ac66:: with SMTP id v93-v6mr7940683wrc.7.1530899815065;
        Fri, 06 Jul 2018 10:56:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b6-v6sm9028271wru.66.2018.07.06.10.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:56:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/10] rerere: handle nested conflicts
References: <20180520211210.1248-1-t.gummerer@gmail.com>
        <20180605215219.28783-1-t.gummerer@gmail.com>
        <20180703210515.GA31234@hank.intra.tgummerer.com>
Date:   Fri, 06 Jul 2018 10:56:53 -0700
In-Reply-To: <20180703210515.GA31234@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 3 Jul 2018 22:05:15 +0100")
Message-ID: <xmqq1scgmemy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 06/05, Thomas Gummerer wrote:
>> The previous round was at
>> <20180520211210.1248-1-t.gummerer@gmail.com>.
>> 
>> Thanks Junio for the comments on the previous round.
>> 
>> Changes since v2:
>>  - lowercase the first letter in some error/warning messages before
>>    marking them for translation
>>  - wrap paths in output in single quotes, for consistency, and to make
>>    some of the messages the same as ones that are already translated
>>  - mark messages in builtin/rerere.c for translation as well, which I
>>    had previously forgotten.
>>  - expanded the technical documentation on rerere.  The entire
>>    document is basically rewritten.
>>  - changed the test in 6/10 to just fake a conflict marker inside of
>>    one of the hunks instead of using an inner conflict created by a
>>    merge.  This is to make sure the codepath is still hit after we
>>    handle inner conflicts properly.
>>  - added tests for handling inner conflict markers
>>  - added one commit to recalculate the conflict ID when an unresolved
>>    conflict is committed, and the subsequent operation conflicts again
>>    in the same file.  More explanation in the commit message of that
>>    commit.
>
> Now that 2.18 is out (and I'm caught up on the list after being away
> from it for a few days), is there any interest in this series? I guess
> it was overlooked as it's been sent in the rc phase for 2.18.

I deliberately ignored, not because I wasn't interested in it, but
because I'd be distracted during the pre-release feature freeze as
I'd be heavily intereseted in it.

Now is a good time to repost to stir/re-ignite the interest from
others, possibly after rebasing on v2.18.0 and polishing further.

Thanks.

>
> I think the most important bit here is 6/10 which fixes a crash that
> can happen in "normal" usage of git.  The translation bits are also
> nice to have I think, but I could send them in a different series if
> that's preferred.
>
> The other patches would be nice to have, but are arguably less
> important.
>
>> range-diff below.  A few commits changed enough for range-diff
>> to give up showing the differences in those, they are probably best
>> reviewed as the whole patch anyway:
>>
>> [snip]
>> 
>> Thomas Gummerer (10):
>>   rerere: unify error messages when read_cache fails
>>   rerere: lowercase error messages
>>   rerere: wrap paths in output in sq
>>   rerere: mark strings for translation
>>   rerere: add some documentation
>>   rerere: fix crash when conflict goes unresolved
>>   rerere: only return whether a path has conflicts or not
>>   rerere: factor out handle_conflict function
>>   rerere: teach rerere to handle nested conflicts
>>   rerere: recalculate conflict ID when unresolved conflict is committed
>> 
>>  Documentation/technical/rerere.txt | 182 +++++++++++++++++++++
>>  builtin/rerere.c                   |   4 +-
>>  rerere.c                           | 246 ++++++++++++++---------------
>>  t/t4200-rerere.sh                  |  67 ++++++++
>>  4 files changed, 372 insertions(+), 127 deletions(-)
>>  create mode 100644 Documentation/technical/rerere.txt
>> 
>> -- 
>> 2.18.0.rc1.242.g61856ae69
>> 
