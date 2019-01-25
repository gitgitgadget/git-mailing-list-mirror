Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA64F1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 22:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfAYWVJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 17:21:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43049 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYWVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 17:21:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so11867817wrs.10
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TWkjFDmUCDSQsCqtmeAqAZCwQsBasprpO8m/X84fPgg=;
        b=MCP+KnPypWfoq4RucAZ9lLTuhR1viLcqBAAdw0RgPrerqq/LyuPXO+VZrFhgltEVSp
         Xh58wCtMa9F+6RDBFKfJEKY4lFiFboslkJuh/w+i1cXEsFmZxPeCPx+60wKc6RqLqELY
         v1Bh+bxM9qIAjITYxSJWNkRKjLyXFfDK8y0MMgmHRX3UhddtK2Bd6E7MQv2JhVBJcfaX
         sU+8Z2ldtCOnRaHbfgCH0LT2sxaiRAGSaObN3wDQQSbLnJwY4XTAqkFQsSFOs20GqB40
         XBqCMCgaltPzMAfV5r8EkcjAxP4fkisWlAzynhjUpqDS3Pp31a41fBm7FBlYsKkbl6T0
         UBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TWkjFDmUCDSQsCqtmeAqAZCwQsBasprpO8m/X84fPgg=;
        b=pRbPELAQugLx5YBz2vR9Ev1BoBJPa+EfhMVOxbh0cyhgw6lVE+iuDjJ+DAxKG6YuCB
         F9Vjl0buNudixF/+r4bU465DWVOT0nkHnZbQuFnlP2nu1bS6Tbabh0q+klDxVtXBdbUH
         mz2VM9IzINPBsVkfm1AO0nXuk1+R9WkPWeDe/VDtJWjnzjJ1P4+feZiiSlWyphoU6VH9
         deazGJ6t9FKatuHy2RgEfL1M5AP0UykWBpnoIOHruSpfr2vnb3dvddm554LGYKAdMmgR
         5uar53BhoXihZ5Fbsi5gPKRvfrIzzs6T53CY8G0QiAFGCWr0TFm8poGwL7PM7FhwkYne
         udGQ==
X-Gm-Message-State: AJcUukf7CSOrPNCXOm0z83uKOyY5eUlRS6nEKyUF1wQsGrUbHr6TzOuz
        /rbYCpJkRklHLcO2AACKD7o=
X-Google-Smtp-Source: ALg8bN7pTWLIJKORzmzS+f/9Oy/HyNxi+OW13MFcl2Ud97yaRLOvId0aNg58htU0tyWR3nX1U+1gfg==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr12511879wrs.86.1548454867240;
        Fri, 25 Jan 2019 14:21:07 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m21sm46262470wmi.43.2019.01.25.14.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 14:21:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] log,diff-tree: add --combined-with-paths options for merges with renames
References: <20190124164654.1923-1-newren@gmail.com>
        <xmqqmunofsdv.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFjUgY5htSbPpnamPDRM3bCLNsQv-K35uXoRzaT2f85tA@mail.gmail.com>
Date:   Fri, 25 Jan 2019 14:21:05 -0800
In-Reply-To: <CABPp-BFjUgY5htSbPpnamPDRM3bCLNsQv-K35uXoRzaT2f85tA@mail.gmail.com>
        (Elijah Newren's message of "Fri, 25 Jan 2019 12:04:13 -0800")
Message-ID: <xmqq8sz8fkfi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Also, my first version of the patch actually showed all names, on all
> lines, but I found the heavy repetition really annoying, and not in
> keeping with how non-merge commits are handled (where original
> filenames are only shown when they differ).  Granted, my change isn't
> the only one.  We could just have all names shown if they are not all
> identical, as you suggest and I also considered, but I liked this way
> slightly better.  If others feel strongly, I can change it, that was
> just my gut feel and preference.

I do not have a strong _preference_; I am only worried about ease of
use by consumers of the raw output, i.e. scripts.  From that point
of view, --all-names showing all names always even when there is no
rename is involved would certainly be the easiest to write a parser
for, and lines being overly repetitive is a non-issue.  For human
consumption, it would be a separate matter, but they won't be
reading from the --raw output that lists blob object names
repetitively (the object names may or may not be different, but they
are all equally gibberish) before showing the human-readble part,
which are names.

> You could kind of ask the same question of -c -p, actually.  I looked
> into that, but I was only interested in raw format output and --cc is
> only about coalescing uninteresting hunks in patches.  Whenever git
> shows a combined diff in patch format, it always lists two files in
> the header, e.g.:
>   a/foo.c
>   b/foo.c

Yeah, but with a new option, it does not have to stay that way.  It
is OK to show a/foo.c, b/bar.c, c/baz.c, or perhaps an easy way to
avoid overlong unreadable lines in these human readable output may
be to only show b/foo.c to report the result and list the original
names using the "rename from" "rename to" extended diff-headers
shown in normal diff output with rename detection enabled.

> ...  I guess the "combined" patch is already kind of
> special, so it could make sense, ...

Absolutely.  -c/--cc output with -p departs from the usual "diff is
to compare two things" by having two +/- indicator columns and more
than two '@'s in hunk header to begin with.  It is only natural if
we are showing more/all names in --raw, we should avoid losing info
in the same way.
