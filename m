Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21691C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 09:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03409600D1
	for <git@archiver.kernel.org>; Wed, 26 May 2021 09:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhEZJLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhEZJLy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 05:11:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA5C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 02:10:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id df21so482387edb.3
        for <git@vger.kernel.org>; Wed, 26 May 2021 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0pl8RQI7Qnq7frBMWRgzj6QFdupvkkyO9RCBHeWxnD0=;
        b=QWS2POaPXQOwHiCOQqn5oJto7N58/WDNmTBy/ZVrFy3zcIRUwP4oVgpIXnjIhQXWsR
         d223mFVZ+4N9iS2dYYcVCp0cwNgifV4zEQctwmI/lRmN9uXlvmuWqDf/hvB/F8fKqeFK
         glF7qPrOlpwaqraQVQtymdkn+FU8kDCMr4ZhBNbHYxA8sF/dY1Y69LkcKy1qKA7wlBS+
         oB+1qSco2kRCspC6N+BacLUKlAXFrkBDf0ZhaMCBs2FQKlpWViTsy0g+uUDNs8AZuDFA
         MYVRlUVuT8dTp3ilOk44ORB30wC5xo/aAcoaMkhP2+hcSBH5oI5P/rDKh5escQF8oMUh
         6KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0pl8RQI7Qnq7frBMWRgzj6QFdupvkkyO9RCBHeWxnD0=;
        b=hL6XvjsEq+zCqt8pIaUxYJlOqwLzGnyNx7Rpj4ZBsBI6m/hUskZ5l+HS+mjEKOf2tw
         ndtDQJwajOyuO8FwIEimcnOMQHb9QwPJ7ieDdyIhdleS25MyuqChQtqX8ANzqG0KOvrS
         Pcb+3f/RtsA7VQwEzUShlnYv/YsgKQqdxIOEcne8rycX24EdekfAI2ddu/9/mya3s4d6
         pwIzg0ITD1kQa35Y9EJZzw4aH7SzMowcYZ4k8r9/Mmm8wIt+hXNmG/jXrcOCFYHxZd9y
         BWxVbfnJrdxLHY2v9GqcPry3xyc9XnLnTIRWwZ2rsqvD3QVRz85ZQCayfrDKwQOEP6nU
         HDxg==
X-Gm-Message-State: AOAM530gVSRfj6QhkWphKARP7loCpLi6z09qCoxhrdOBLKTu7Vj3zg8M
        MjVggVbCZCzaZGstrr+ET+0=
X-Google-Smtp-Source: ABdhPJxapcOrLEwZUeFGD+5PS4zDUIFKVttnn0cc8eMS98loNJ0LePG7kDqRfaYHWSfdbujZrBL3rg==
X-Received: by 2002:a50:9346:: with SMTP id n6mr36549308eda.365.1622020219828;
        Wed, 26 May 2021 02:10:19 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lz15sm10151064ejb.27.2021.05.26.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 02:10:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
Date:   Wed, 26 May 2021 10:21:41 +0200
References: <YKWggLGDhTOY+lcy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YKWggLGDhTOY+lcy@google.com>
Message-ID: <87sg29n9mt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 19 2021, Jonathan Nieder wrote:

> Hi,
>
> (Danger, jrn is wading into error handling again...)
>
> At $DAYJOB we are setting up some alerting for some bot fleets and
> developer workstations, using trace2 as the data source.  Having
> trace2 has been great --- combined with gradual weekly rollouts of
> "next", it helps us to understand quickly when a change is creating a
> regression for users, which hopefully improves the quality of Git for
> everyone.
>
> One kind of signal we haven't been able to make good use of is error
> rates.  The problem is that a die() call can be an indication of
>
>  a. the user asked to do something that isn't sensible, and we kindly
>     rebuked the user
>
>  b. we contacted a server, and the server was not happy with our
>     request
>
>  c. the local Git repository is corrupt
>
>  d. we ran out of resources (e.g., disk space)
>
>  e. we encountered an internal error in handling the user's
>     legitimate request
> [...]
> Further down the line I can imagine making use of git_error_code
> elsewhere for e.g. some limited retries of the corresponding
> transaction when we fail to lock a file.
>
> Thoughts?  Good idea?  Bad idea?

Having read the thread at large (and some of this is a more general
response) a few points, not against or as a retort to this, just related
thoughts, complimentary suggestions etc:

 1. As shown in my f6d25d78789 (api docs: document that BUG() emits a
    trace2 error event, 2021-04-13) all of BUG/die/error/warning just
    emit "error" under trace2.

    It seems to me a good place to start with this effort would be for
    someone to split that up. It requires changing the trace2 schema,
    but it can be done in some backwards compatible way. Perhaps event:
    error, error_type: [bug,die,error,warning] ?

 1.5. Split up error_errno() from error() for trace2 purposes? This gets
      you partway to your "d".

 2. Similarly we need to log the correct line numbers for
    die/error/warning. They need to be a macro/function like BUG() /
    BUG_fl().

 3. You can then key error events/frequencies on the "fmt".

 4. To the extent tha #3 isn't true on client machines due to i18n we
    could change the API in a backwards-compatible way from
    e.g. error(_("string") to error(_N("string")). We'd then always
    transmit the C locale "fmt".

Basically I wonder if a more granular approach with just better logging
of information we have now (but lose in trace2) + maybe some split-up of
the current functions, e.g. having a user_error() distinct from
repository_error() or whatever wouldn't get us most/all of the way to
this.

> Further down the line I can imagine making use of git_error_code
> elsewhere for e.g. some limited retries of the corresponding
> transaction when we fail to lock a file.

Maybe, but that seems highly problem-dependant, and not e.g. something
where we'd like to just do a blind retry in one of our own porcelain
tools if a plumbing one failed with a "had an issue, retries might work"
code.
