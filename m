Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9ABC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3372364E6B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBQBtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 20:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBQBtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 20:49:16 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5248FC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 17:48:36 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lu16so4847454ejb.9
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 17:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LdqvmYq7hd2Vo1BfK88hCoDVvnTkW46tOfbldGTZYZE=;
        b=UQOuy8H4AZLsCFzJ9+hRpO86aHeGc8HoJa4oYg8rgZPmpsMgNjYsQRgixtIyeIrhkr
         qnbp1JdoQMF581TIgeqPR+oiV3KH+a7Hk2jExBPQ80h/DtzpxNRcnPxTonyAKth7mHng
         vx0eZDZso3gUBmfNEC1aHAbJfWyejPyOSI60E8rFTjPZoyocZDlzHXxB+LWae4LPuZAB
         iI1bm65U2w2KwM3dYUh4/znElvuowzdovD5oKYRy+JWs2dzgH/rp1ubQ/yNCAHTGDPpK
         Xc4wLUec5VM9DUdwDJBBGN8JuVWAQOfByBRIMRoU8eal5sLSSGUDTNrndYfwqa/NnnnF
         nZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LdqvmYq7hd2Vo1BfK88hCoDVvnTkW46tOfbldGTZYZE=;
        b=gYccp1n5B7f+4xE4Q+UHcCfGREghZc+6CxQHI3lHJTBwz7IB2fkLasVKpAN2akr/Hn
         KuTX5krFU8ac2J01e5SZhFQoSKvQXKpGyDDmkOvg7GA7e2WSzeboPk8GNWNoUdLclQ5F
         yiR464jyJElvp95FjEYLTIzp5Pk065ZXJUUF9q/tRFm7//TiKbvQwOpBgKEG5NKoCl2G
         fhHIAn1MclSWSUk6df0Sn+LrunezbZRCr8uSLV5MDGwOEund99Hs87UDdfInRzDSO7+b
         8U2a6HCOuFludMZDy3SAd0KSwkFaLJe3zdKIOhAd58bKmm7UtALsCvcfM43uMADPTEyP
         fWsQ==
X-Gm-Message-State: AOAM532CLSJ/LGz+OsOyhdXTcZMdEa7jGnrDmqa4Qh+ZC6qNTeZF5Mu3
        dicKzDkSnQaliPj89g+R97czT2CkdN0ZaQ==
X-Google-Smtp-Source: ABdhPJwN1AnFAQ9pHA5S0P3RMwbICw5BqlvaHk7IntoYGsg7FvnGyMFQHcRTQpOH55m6/Mp5815dYA==
X-Received: by 2002:a17:906:a099:: with SMTP id q25mr23100228ejy.549.1613526514891;
        Tue, 16 Feb 2021 17:48:34 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id z19sm260837edr.69.2021.02.16.17.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 17:48:34 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
References: <87ft2q7ck4.fsf@evledraar.gmail.com>
 <20210128010320.3880242-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210128010320.3880242-1-jonathantanmy@google.com>
Date:   Wed, 17 Feb 2021 02:48:33 +0100
Message-ID: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 28 2021, Jonathan Tan wrote:

Sorry I managed to miss this at the time. Hopefully a late reply is
better than never.

>> On Sun, Jan 24 2021, Jonathan Tan wrote:
>> 
>> > +void register_found_gitmodules(const struct object_id *oid)
>> > +{
>> > +	oidset_insert(&gitmodules_found, oid);
>> > +}
>> > +
>> 
>> In fsck.c we only use this variable to insert into it, or in fsck_blob()
>> to do the actual check, but then we either abort early if we've found
>> it, or right after that:
>
> By "this variable", do you mean gitmodules_found? fsck_finish() consumes
> it.

Yes, consumes it to emit errors with report(), no?

>>         if (object_on_skiplist(options, oid))
>>                 return 0;
>> 
>> So (along with comments I have below...) you could just use the existing
>> "skiplist" option instead, no?
>
> I don't understand this part (in particular, the part you quoted). About
> "skiplist", I'll reply to your other email [1] which has more details.
>
> [1] https://lore.kernel.org/git/87czxu7c15.fsf@evledraar.gmail.com/

*nod*

>> This whole thing seems just like the bad path I took in earlier rounds
>> of my in-flight mktag series. You don't need this new custom API. You
>> just setup an error handler for your fsck which ignores / prints / logs
>> / whatever the OIDs you want if you get a FSCK_MSG_GITMODULES_MISSING
>> error, which you then "return 0" on.
>> 
>> If you don't have FSCK_MSG_GITMODULES_MISSING punt and call
>> fsck_error_function().
>
> I tried that first, and the issue is that IDs like
> FSCK_MSG_GITMODULES_MISSING are internal to fsck.c. As for whether we
> should start exposing the IDs publicly, I think we should wait until a
> few new cases like this come up, so that we more fully understand the
> requirements first.

The requirement is that you want the objects ids we'd otherwise error
about in fsck_finish(). Yeah we don't pass the "fsck_msg_id" down in the
"report()" function, but you can reliably strstr() it out of the
message. We document & hard rely on that already, since it's also a
config key.

But yeah, we could just change the report function to pass down the id
and move the relevant macros from fsck.c to fsck.h. I think that would
be a smaller change conceptually than a special-case flag in
fsck_options for something we could otherwise do with the error
reporting.

