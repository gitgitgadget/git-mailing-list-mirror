Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FCA61F597
	for <e@80x24.org>; Fri, 27 Jul 2018 16:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbeG0Rgk (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 13:36:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42244 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732752AbeG0Rgj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 13:36:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so5577998wrs.9
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Nh2u59ImUhAIKKeb5+xj74QwbrGx+BISWC0812dvsNE=;
        b=h38F7sezLHw1PeAnR9v5dlsPWnTWa3ydpqyi3J+zkF+VabBQ6FC/IhUoiRVNI5tZ7C
         S3yx+bLSA4Om7G1oqGSD5TfuVdDG4Tga7Rj7NAp0wgwaCJmIA6iLAHNvwYOiT/yLHAbq
         x0/yD56KVfde68Vz8AWgayBseW349+CV79qeEacL41up7o21H0KRup40kn6N7HssVB0n
         JDxIEA03WTqWQNzdTUFtMCKl5CU6+ZJDWNjnk7qgIMVYGFPHpmmglNhCleU6FgsbolaZ
         2tHH72/mohawwjqbCJ+PG/XWYUrKfjfxi6mhDgdXCjbLqMH5zUoK+q2Hpx2tzvF1s6fn
         vdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Nh2u59ImUhAIKKeb5+xj74QwbrGx+BISWC0812dvsNE=;
        b=okpp97qKahvn0kmyM7/nNGhJhd1au0iTghOggT9/m4c2XQQbpgxpvMY0uJ9G0f0hcc
         vA96tgT7ACSSVYNnXxhBrbazKSbWe4deNumAfIX0M8F1jDW3/uQiBnSCO+zfkrzO7gF2
         pt8CYdV44Z2e1ytXUiUAfKqmqYlVuovRrGwZfN/zq0kfHc3l6R93y5lRPj80Lo071DqQ
         RJYXec7RITbFvZgYk53skqH3pSo+4zrdsRuFRW7Z2aOr/czzd8SR119b5Al1WYsGNcxe
         gC13Y5rPfUhKS+hbnTjxUxiXWK23kAxtHJizkUVOFlar/6yjym/Po1eXaGB0g75uAK5L
         nwXA==
X-Gm-Message-State: AOUpUlEB0PQN2AN8N0HpJY28aELPTXAAjKeZFv9Uok6m2Fe6DR4qKJEH
        xzPa8WX8JXtwa37gkE3LgPQ=
X-Google-Smtp-Source: AAOMgpdCKG3sag2SEHDnRNZfZ3HPx6khB5bqzqt17Q5qTOaF+H4oQABXeuLGtFyjZdpxBeYe6bUtEQ==
X-Received: by 2002:adf:f60a:: with SMTP id t10-v6mr4974364wrp.170.1532708042763;
        Fri, 27 Jul 2018 09:14:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h7-v6sm4646908wrs.8.2018.07.27.09.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 09:14:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH v5 2/4] add -p: select modified lines correctly
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180726155854.20832-1-phillip.wood@talktalk.net>
        <20180726155854.20832-3-phillip.wood@talktalk.net>
        <xmqqmuudpzfl.fsf@gitster-ct.c.googlers.com>
        <2e78e077-1801-9c92-6b53-badf588fe262@talktalk.net>
Date:   Fri, 27 Jul 2018 09:14:01 -0700
In-Reply-To: <2e78e077-1801-9c92-6b53-badf588fe262@talktalk.net> (Phillip
        Wood's message of "Fri, 27 Jul 2018 11:19:38 +0100")
Message-ID: <xmqqzhycodva.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> The code actually looks at the lines that are selected rather than
> omitted. So in the example above it groups them as [1,2] (because they
> are contiguous), [4],[5] (these are split because one is an insertion
> and one a deletion) and [7]. It then sees that there are two groups of
> deletions ([1,2],[4]) and two groups of insertions ([5],[7]) and so
> pairs up the deletions in [12] with the insertion in [5] and likewise
> with [4] and [7]. Lines 3 and 6 are never explicitly paired, although
> they basically behave as if they were. One the insertions are all paired
> up it walks over the list and creates a new hunk where the paired
> insertions come immediately after their corresponding deletions,
> unselected deletions are converted to context lines and unselected
> additions are dropped.

Now, without that much explanation in help text, can an average end
user use the feature, specifically, understand the reason why the
tool says it cannot handle a particular set of selected lines, and
follow the workaround suggested by the tool to do it in two (or
more) batches?  That was the real question I was getting at.  I
haven't played with the feature long enough to answer that question.

>>> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> 
>> Is this fixing any bug?  I usually see "Reported-by" only for a
>> bugfix patch but this seems to be adding a new feature (and lack of
>> feature is usually not a bug).
>
> I guess I meant that the previous series was effectively buggy as it
> would give the wrong result for modified lines. I wanted to acknowledge
> that Ævar spent some time testing it and pointed that out.

Ah, I see.  We generally throw these into "Helped-by", I'd think.

Thanks.

