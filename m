Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720641F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeDWXqE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:46:04 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:43450 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeDWXqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:46:03 -0400
Received: by mail-wr0-f169.google.com with SMTP id v15-v6so27595849wrm.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+TRLkkr0K9cQCVLQO7dAysX7NPOkoyV+8TB0O1vlgLU=;
        b=sIXsfsq/Ul6v6eFhygxg5vL8S44ufOPs4db4VtEAMLKE5GGzVjDMVl+DlQH+MmzBsb
         1De57BqMomTWWzaZRJ/mGnEv5WLrZ07PghfIQILxdxfadpRNqjw2fnQTIYia+UIdmmAd
         s0nrfBPgsddKqkSVW5G/cgpVbLfTsxCtnXMAaIAAjKj1erLV2IW99NJSwc3HKQb7J40l
         YHvV4wq6duvN5NnmRBzAoU6v1yjF4lwMwmzCoip4Cx6hifP+9OIbZaNDOOLo4GIB/N2O
         nlnGhdGegCM+1tctwX9xNzJdAhBJNg3nEnctFqyfYaZp4P7oAseMuEzyPajuTD6cYkUb
         TBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+TRLkkr0K9cQCVLQO7dAysX7NPOkoyV+8TB0O1vlgLU=;
        b=EM/zhqjfasYDUpVvgQeM8cVnv94vaQ+DotJ3kJf6aN75DdcKkh8qm3tZo4r3EMpNjp
         moUYpyHAJGmnnJ8sj3G+OnkCDz7Tc8pQrZhdVHvnxS2Sr6zu8UxkZIPl6CuGx622fpsx
         19ui5h9Gk0rqLxJyefkWr9khJ139bO69iRMKZRfwH97KmwbtXGPjPXt9CN3X4rlmEHBk
         EGNGfjrQ3OZOc8Md9+yjXEeebXWKjc1IDSBCyVv7M53WAGo0DekN9VIgFmZ2Zo+MaMTX
         jkfrRto4jC0Hd248bBpndf7tc70QXfjwFhL/a9klCzrMv7gofLrqDe0187plgTfMHsTN
         iMHg==
X-Gm-Message-State: ALQs6tBnwgcq4HICsZuBwwmsinf9sfa7ntnQvKaq+JtnNJ6ttXbGBO6G
        2FX5aJ99WPLBBsZjD6C+qHw=
X-Google-Smtp-Source: AIpwx4/uiR427j59NEmiXzjNZ/aQkJEZJWNJ5qiKa+lTCOYeOLmh1l9PnTx9md6ah3kiihn50vuYdg==
X-Received: by 2002:adf:968b:: with SMTP id u11-v6mr18664892wrb.184.1524527162272;
        Mon, 23 Apr 2018 16:46:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s22sm10768723wma.45.2018.04.23.16.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:46:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v10 00/36] Add directory rename detection to git
References: <20180419175823.7946-1-newren@gmail.com>
        <CABPp-BHMt1Hjr8A_wkxvSExV9ALgG5032vV5uEE2-HtpYuA9QQ@mail.gmail.com>
Date:   Tue, 24 Apr 2018 08:46:01 +0900
In-Reply-To: <CABPp-BHMt1Hjr8A_wkxvSExV9ALgG5032vV5uEE2-HtpYuA9QQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 23 Apr 2018 10:28:23 -0700")
Message-ID: <xmqqmuxt8p1i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Out of 53288 merge commits with exactly two parents in linux.git:
>   - 48491 merged identically
>   - 4737 merged the same other than a few different "Auto-merging
>     <filename>" output lines (as expected due to patch 35/36)
>   - 53 merged the same other than different "Checking out files: ..."
>     output (I just did a plain merge; no flags like --no-progress)
>   - the remaining 7 commits had non-trivial merge differences, all
>     attributable to directory rename detection kicking in
>
> So, it looks good to me.  If anyone has suggestions for other testing
> to do, let me know.

There must have been some merges that stopped due to conflicts among
those 50k, and I am interested to hear how they were different.  Or
are they included in the above numbers (e.g. among 48491 there were
ones that stopped with conflicts, but the results these conflictted
merge left in the working tree and the index were identical)?
