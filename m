Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B4B1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 05:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeKFPUt (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 10:20:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36050 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbeKFPUs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 10:20:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id z13-v6so9634302wrs.3
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 21:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3oeUxHBx+YfeaCXyH9gj58lj+AvTcv+DQxLRY6PNjuA=;
        b=h3iJ3HivsT01HTT8UuYLlb5RITtOnnMIUCg0MHhw9DahlQ1ud0GnyQEbhvFg6369xZ
         9nCtwsQbJHWLMX2I3Q1QIKiLUY1oL/mJwXyZVqATeVamWwkmlPDH8dQSi9e0ACHyxPFJ
         nBrVM6Nzzui8V4dVSRQTQTBGbD+VmKeaSM2LGn4nj+wOTH5YCeMG7yg3cGkTYNJev2B4
         8L7gKDDrUyaNBTHa+Iwpg5JRHR8Z88rh7iozJJTZAElRddr6vnr7Oln5WrgDobQUkIIa
         ugk8ImxS4MBkUFBjqHmzQML6aEMCt7hB+SCV8wLBmeUnm18UVygWuVHYDmdLmKU5C3cg
         V34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3oeUxHBx+YfeaCXyH9gj58lj+AvTcv+DQxLRY6PNjuA=;
        b=AgmGBKwi9tkgJWDs0vCqE0smP8cvnFlzcWEhOzGhM//4hk+AWmwTRUE9LHfURM9mLv
         ByLxWeDXzc5MsZDU3vR0yhydyqw2APb4OQKny26DVn45O8IrEpP6FC6tzxeHIPZYxSFi
         4NaQseFCKKq3O8uoYlefUHufHUd5BNTWeELLAYXrphGA41cL3rWSrmPXi3LbFiysP9jA
         Oi+JDijHZMGvdBefUBiWjEY7qhFaMHFAEj0oMxXVvdVqX/VTuw67GSjOxLMgKhO6Gng2
         QSHBU8xqBnfCjxWZ1zzygntXq0YIr7JSvA5VUi0UT7nRUExj4uufjTDw91EUHBDrS6sx
         O46w==
X-Gm-Message-State: AGRZ1gIWi0fmp7QNnijWcpHawg24sWftSf+1w2G6zWKoBG8JQs2YQ/lw
        ez+eJucPiuDiNTdLWBkNztU=
X-Google-Smtp-Source: AJdET5cA0AMsmH864uvbwHzJ5oAS9NzUOZvJjl2lyMJgD1zeYupJ3295F1ad4nSQF7dinow8W0fKEw==
X-Received: by 2002:a5d:69ce:: with SMTP id s14-v6mr22820300wrw.177.1541483834873;
        Mon, 05 Nov 2018 21:57:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y76-v6sm1177606wmd.37.2018.11.05.21.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 21:57:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, lucas.demarchi@intel.com,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
References: <20181105200650.31177-1-avarab@gmail.com>
        <xmqqva5aet72.fsf@gitster-ct.c.googlers.com>
        <CAPig+cR85-7wMYCGGFoRT3jSQzQmda_84Ox1kF6roa5j-1XZ0Q@mail.gmail.com>
Date:   Tue, 06 Nov 2018 14:57:12 +0900
In-Reply-To: <CAPig+cR85-7wMYCGGFoRT3jSQzQmda_84Ox1kF6roa5j-1XZ0Q@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 6 Nov 2018 00:15:40 -0500")
Message-ID: <xmqqin1aeojr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Calling this --[no-]patch might make it harder to integrate it to
>> format-patch later, though.  I suspect that people would expect
>> "format-patch --no-patch ..." to omit both the patch part of the
>> range-diff output *AND* the patch that should be applied to the
>> codebase (it of course would defeat the point of format-patch, so
>> today's format-patch would not pay attention to --no-patch, of
>> course).  We need to be careful not to break that when it happens.
>
> Same concern on my side, which is why I was thinking of other, less
> confusing, names, such as --summarize or such, though even that is too
> general against the full set of git-format-patch options. It could,
> perhaps be a separate option, say, "git format-patch
> --range-changes=<prev>" or something, which would embed the equivalent
> of "git range-diff --no-patch <prev>...<current>" in the cover letter.

I actually am perfectly fine with --no-patch.  My "concern" was
merely that we should be careful to make sure that we do not stop
producing patches when we plug this patch to format-patch when
"format-patch --no-patch" is given; rather, it should only suppress
the patch part of range-diff shown in the cover letter.
