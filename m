Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4591F597
	for <e@80x24.org>; Tue, 24 Jul 2018 20:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbeGXVOx (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 17:14:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40423 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388628AbeGXVOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 17:14:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so2931301wma.5
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p9wHvSSORinEw1rIgY5UEEDLHrUK69oYF1OMOQHFcjU=;
        b=Sis9qR0Md5SdzIg0zeCIaXWwk4j/Q5CkGNiCMF6IWrEgWqzUMI1rZyOQp4KTvABsnc
         bdy0punffu0Pni0/ltvZTc3sKGjJan2DG4cMP955uggaWVI7CX+iiBlGrP/Pvf3ter+C
         yHCCEbnCWYlcdHmvt6dj7idKG92gI1r4QF1kFYj64w4W1KVQDMsE0MSXvDJbKr5mzFsz
         ndvB2wy1kmNgIz7cgB8cvtcCjj5VQ+IBjZDnJcDMwIjVVmYXenZnn2eeMCA3Z5MX9O0K
         C5EluxBK4pQj8+eAwKI4qblt23Ste9IZnfSgG1e48CQHNqjoU0eDnXZzNtFRVxvv0R4E
         /5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p9wHvSSORinEw1rIgY5UEEDLHrUK69oYF1OMOQHFcjU=;
        b=gd2NmpmvZwOax9usKaOXAgWjRlE2S4SrvkoumvhzDS8DjQ6PpCldsdDqvU14WDcuiJ
         CD/GBYOZOPhRjGulkTpUhUx1EAgqGmhScIkihRH75o3jmp8SS01eaVrHpbZo4LkHxdRp
         Exqn5b846Le6vBuF0n5S96wZPCRsjzRAL4VLkxxr2Vc11iUsnNGEPfkMIBEe8nvFMLbu
         5x+WauZiEOHzD63YQ5URlxfgiM282zMGzpGuYiyRa/1RQqApFhe8yHj8qf1eE1sYOIa3
         FF13+DnNedLinXI3d2ZK3GYsZKBlbCJUCpQHdPHvr8KU2mZZ3QGqmvzLPlG63Xu93stH
         satw==
X-Gm-Message-State: AOUpUlEc0haIElpJeT6F1Qyk/8riYinI60YtbzZmmODQ4ydyBCtvnLPo
        41iafbNaNs+5771HJne7YpXUk2UZ
X-Google-Smtp-Source: AAOMgpeDVjpSuRiyyLjuWba2WCLpKVy79kldHrBVp4k6DBGbIWEWKEWg42fWYbkf21OT0N4jKZWAAA==
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr3007665wmf.89.1532462806147;
        Tue, 24 Jul 2018 13:06:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s16-v6sm11326714wrq.20.2018.07.24.13.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 13:06:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/diff-options: explain different diff algorithms
References: <20180724003619.185290-1-sbeller@google.com>
        <20180724044051.GA208393@aiede.svl.corp.google.com>
        <CAGZ79kap9TovN2ia4pEgz33dh=9y89cVYZWnB_1e6iHpR=kDOQ@mail.gmail.com>
Date:   Tue, 24 Jul 2018 13:06:44 -0700
In-Reply-To: <CAGZ79kap9TovN2ia4pEgz33dh=9y89cVYZWnB_1e6iHpR=kDOQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 24 Jul 2018 10:38:03 -0700")
Message-ID: <xmqq4lgoxusr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jul 23, 2018 at 9:41 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> Hi,
>>
>> Stefan Beller wrote:
>>
>> > As a user I wondered what the diff algorithms are about. Offer at least
>> > a basic explanation on the differences of the diff algorithms.
>>
>> Interesting.  Let's see.
>>
>> [...]
>> > --- a/Documentation/diff-options.txt
>> > +++ b/Documentation/diff-options.txt
>> > @@ -94,16 +94,34 @@ diff" algorithm internally.
>> >       Choose a diff algorithm. The variants are as follows:
>> >  +
>> >  --
>> > -`default`, `myers`;;
>> > -     The basic greedy diff algorithm. Currently, this is the default.
>> >  `minimal`;;
>> > +     A diff as produced by the basic greedy algorithm described in
>>
>> Why this reordering?
>
> because Myers (below) is constructed from minimal + heuristic.
> ...
> So the "minimal" algorithm is the basic myers algorithm,
> and the "myers" algorithm is the extended version (extended
> with a heuristic to be fast in corner cases, still producing good
> enough diffs).

I am not sure that is a good reason for the target readers of this
document to move the default from the beginning to somewhere in the
middle.  For a textbook that explains different algorithms and gives
overview of how they work, that order may be appropriate, though.

>> > -     Spend extra time to make sure the smallest possible diff is
>> > -     produced.
>> > +`default`, `myers`;;
>> > +     The same algorithm as `minimal`, extended with a heuristic to
>> > +     reduce extensive searches. Currently, this is the default.
>>
>> Amusing --- this means that the Myers diff is spelled as "minimal"
>> instead of "myers".

Yeah, I had the same thought---for an end-user documentation update,
this change and the reordering does not feel like an improvement.

>> I wonder if these details (about all the algorithms) should go in a
>> separate Diff Algorithms section and this section could focus on
>> what use cases warrant using each, referring to that section for
>> details.  What do you think?

Good suggestion.
