Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA1A1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 16:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933470AbeFUQiu (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 12:38:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38286 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933297AbeFUQit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 12:38:49 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so3879181wrs.5
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QpT4v+u1lIfH7IWjTFUCXp5kEiuL/SNcqBpcW951/tc=;
        b=Z5ALCFK34SVI+TbOBfVypK/nfUsQPnQd7/h/xuuOQ1smA+ADAF7wMf7yNww9MoZgc5
         k+phMgSTTrcK4ofWc4JuQCRA5BMtvI7k853fHMbfVjHBxbmbcMBqL9iq8/32Ud/Fv4PJ
         k9IsR0uBaW2jzl/0GXY9qOssi4yxXadQT3VHqBhPfGCLZ12WxOYW5Nc9PjaWsXlZPS4S
         aLetjhP+xoPToQcYBItz0/nPQKOFGKFzlCAP3c/BZZC2FQ1Qcezn9MxYxwZffGuhNxLK
         wbhObo7SV3Otnjr+0lH7+n1SIlS8LGFkdcHcFC1ScaYAY1sEbo0WvzOQ5UxXp44wjRnx
         BM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QpT4v+u1lIfH7IWjTFUCXp5kEiuL/SNcqBpcW951/tc=;
        b=mti1u5L/IG41ZwbIEMMi9LaT06cxFAHfNxTUnA1HtfB1h9sBDFLn9KSICgUdhRHSoi
         lz0gfqvIRxT1jaKy/UFF+VLmEI9ECGMnT4Mt/XeaoH29z7s7HqtFvP9yjmSYCWeXZyCm
         aN3/r/qjPSnYXNjESU77TgIrthB3v93cUQxScONsKqRH/YQucXz1TR530Hq19wGJfRz9
         iKGFeCVDKONIGEbhTx/E+UFSL16LuaEwjV2N4bkxOhCjfIcFrjORLz/GUhGEJy9TYY1i
         MHZGsp5JD8tJa4KKXtVAyz54xtQA1YwaMcdMhe/ia6SS8odfH7iqXv1gSYHaMtmlTXCJ
         /38g==
X-Gm-Message-State: APt69E3tB+1c+2JgbToFZuSz7tB4fKPKVTTOM6aBGfGXDhthlfuSj4tZ
        VWoQshcnEXgbUDdhN/hB8SNlu8DW
X-Google-Smtp-Source: ADUXVKIaMoDH5JOWz67FzXa+QvAmIVHgLjCROMveILoSlaCveu+26NFNSOY6VEv+WBWFUR/sU84mKg==
X-Received: by 2002:adf:fec2:: with SMTP id q2-v6mr23493557wrs.165.1529599128395;
        Thu, 21 Jun 2018 09:38:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w126-v6sm6774195wmw.29.2018.06.21.09.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 09:38:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 2/8] upload-pack: implement ref-in-want
References: <20180605175144.4225-1-bmwill@google.com>
        <20180613213925.10560-1-bmwill@google.com>
        <20180613213925.10560-3-bmwill@google.com>
        <xmqq602jzriy.fsf@gitster-ct.c.googlers.com>
        <20180619185033.GC199585@google.com>
        <xmqqbmc6v7gl.fsf@gitster-ct.c.googlers.com>
        <20180619231404.GA232723@google.com>
Date:   Thu, 21 Jun 2018 09:38:46 -0700
In-Reply-To: <20180619231404.GA232723@google.com> (Brandon Williams's message
        of "Tue, 19 Jun 2018 16:14:04 -0700")
Message-ID: <xmqqo9g4t7qh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 06/19, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>> 
>> > I also think that we should keep this first implementation of
>> > ref-in-want simple and *not* include patterns, even if that's what we
>> > may want someday down the road.  Adding a new capability in the future
>> > for support of such patterns would be relatively simple and easy.
>> 
>> I am all for many-small-steps over a single-giant-step approach.
>> 
>> >  The
>> > reason why I don't think we should add pattern support just yet is due
>> > to a request for "want-ref refs/tags/*" or a like request resulting in a
>> > larger than expected packfile every time "fetch --tags" is run.  The
>> > issue being that in a fetch request "refs/tags/*" is too broad of a
>> > request and could be requesting 100s of tags when all we really wanted
>> > was to get the one or two new tags which are present on the remote
>> > (because we already have all the other tags present locally).
>> 
>> I do not quite get this.  Why does it have to result in a large
>> packfile?  Doesn't the requester of refs/tags/* still show what it
>> has via "have" exchange?
>
> Sorry Jonathan Tan said it much clearer here:
> https://public-inbox.org/git/20180615190458.147775-1-jonathantanmy@google.com/

Hmph, it feels like that the real culprit in that illustration is
that the negotiation stops after seeing A, and assumes that the
chain leading to B and C need to be re-sent, without the parties in
the negotiation even discussing that lines of the history.  When you
say "want-ref refs/tags/*", intending to update remote-tracking refs
on your side with the result, shouldn't the protocol make sure that
the current state of the remote-tracking refs (i.e. B and C in the
example) is taken into account?  It does not quite sound like a
problem inherent to "want-ref refs/tags/*" or a like request; the
real cause of the problem seems to lie elsewhere, at least to me.

Thanks.




