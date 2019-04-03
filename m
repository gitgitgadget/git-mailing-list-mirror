Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2C420248
	for <e@80x24.org>; Wed,  3 Apr 2019 08:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDCIFQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 04:05:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45689 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfDCIFP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 04:05:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so701936wra.12
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 01:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3CzJbWaxh8jyVMEnZN1illolCzfIKzk/wPjoAtkFYgA=;
        b=uGEVmIX26mgHzMbR+hkK4SaZM3iWuXiwYDzEXCfxzsMXCuCFleqLjFH+PgJ+rWFS/S
         96mJBfwmpZc4sowKYL7CTAk3YNIWa9EJ2YfcdevgytPZfnsHGNNzREXrr0H4B/2qa08c
         4ldZfpqK8i6NLnobfoEmpOXsoMzTRD7UAE067+A/0e7enQjR5GCnBMzxzX9TDdme+3ZC
         XOEq4TAuestvdJGzyo7/IZLSo78YQWyVEG5vSYqq4ivtG4vgvM+HPaGatRl3fdaFfbUs
         XqGZdwZtyVyxraQoqXfvUTOiITquBmjPHsyw4BVX59yYbgvcetyH8PlD53Ujrh1z7pY+
         5PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3CzJbWaxh8jyVMEnZN1illolCzfIKzk/wPjoAtkFYgA=;
        b=kH6JUkG92Tb0o+BmQ+GtHOKB3Y4R3hyVF7xfoAltmjfIZid+vktE/bOb0qJokJzts2
         M+MTZpsW1uJcv0n1IpwK5ulITzsbcY2Xcp7p+mGeguqkZ/TjmMjf0FZpmVLREwErJF7u
         np4nREleBdGC7YIr/AxsL6BKiQDTv+yNvHZJtogz9BuwXApeyUHgmaMlqPxeDxZAchfW
         nhWHxeiCtF3yPWzKP28iIOu8PBqWeWZZjdLVIkHqGPvwJJcfljfHvJjsKVjD6FU++wm0
         3QVdZCjx8gsP/D/6iXldvRk+QcS1Th7ueKwSIAl37gaImG+2uGWQHNJzgYxPRpXa4Kuh
         DlOA==
X-Gm-Message-State: APjAAAU9gNNC4OfinHFNm16wkBzW1HbKJOnb8uAozQfea4YA5qmWRQAO
        p00pjf7p5eINv9EYr7Kuhrk=
X-Google-Smtp-Source: APXvYqwD3jSyIswlYVz7+oBvnr11gk74+xRRx+nGxguiarJKSq4iBSGiInssU5Nyy1MP8Q02DmdfDg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr40117350wro.251.1554278713576;
        Wed, 03 Apr 2019 01:05:13 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c10sm19607085wru.83.2019.04.03.01.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:05:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, debian@onerussian.com
Subject: Re: [PATCH v2 4/4] dir: do not traverse repositories with no commits
References: <87lg1eq146.fsf@kyleam.com>
        <20190402183505.31512-1-kyle@kyleam.com>
        <20190402183505.31512-5-kyle@kyleam.com>
Date:   Wed, 03 Apr 2019 17:05:12 +0900
In-Reply-To: <20190402183505.31512-5-kyle@kyleam.com> (Kyle Meyer's message of
        "Tue, 2 Apr 2019 14:35:05 -0400")
Message-ID: <xmqqef6jsedj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> The above case is a corner case in an already unusual situation of the
> working tree containing a repository that is not a tracked submodule,
> but we might as well treat anything that looks like a repository
> consistently.

Makes sense.

> As the required update to t3700-add shows, being looser with the check
> means that we're stricter when adding empty repositories to the index:
>
>   % git add repo
>   warning: adding embedded git repository: repo
>   hint: You've added another git repository inside your current repository.
>   hint: [...]
>   error: unable to index file 'repo/'
>   fatal: adding files failed

Hmph, why should we have the initial "warning" with hint?  Shouldn't
the above result in an outright error?  Something like:

    $ git add repo ;# or git add repo/
    error: repo does not have a commit checked out
    fatal: adding files failed

because the entire purpose of "git add repo" (or "git add repo/") when
"repo" is a repository is to register the commit that is checked out
in that sub-repository to the index of the top-level repository, as
part of updating (or starting) a submodule.

I very much like the direction these four patches want to take us.
I just have small troubles here and there in their execution, though
;-)

Thanks.
