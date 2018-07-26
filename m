Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012CB1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 15:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbeGZQaF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 12:30:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33370 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZQaF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 12:30:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id r24-v6so2367305wmh.0
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/2rxozBR30Ce4KVoJVjcWwI4U6BXhwIOInAEtWQhVpE=;
        b=fgQlhgiUpsbfK50tQzUl4aJSkGSa7BhlzbmJIH0Y4WQr6akUy5Ws3NL4nQG2hFziFe
         hG4iuzu/f2gpIQuRubvvolR/5cyA/44ZhjWS3EFwUxW26SYbLHKjOBji20p+9xnHwAFh
         R6w+7vZa4UmHYXReJZKYyRRst9r2laAmB4FaAuQ/ZNOfLKichE8rZWkR8aqsZsOJlLu5
         VuZ8cpWPSBnbX168XuDHTkkczwCU8QwZn+fVwcecwHbb9MTEWt3O5oKEItBSj3AOSrzO
         I4Rqu84BU50rYT0LbI4WkruZTMz9e5V+ZDelLsyYvZDQ30kglLazhaLHcB4EfonFahsW
         mfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/2rxozBR30Ce4KVoJVjcWwI4U6BXhwIOInAEtWQhVpE=;
        b=nCaYViqBG5taDCcSwd5ALelk00JxU2zAUQPRqh4fsYftJPHWqFPSvGG2qVQeAG8f1q
         DY5a5Dz9KLCZ2HZrZIZyLSHFjtMbEmdBve8v4IArj24syfoJojPe+NW2/0Rwl3EuK4KE
         1trroVxJI7kneIs3OJ6s1ZtOkMJCLL4fEDArrmSnEWFAZX5LUjOw4HjYG8K1REBsosMo
         jt4WVXYSb8R7WhFf+RuC/GkF+RqyR3egn0cJmfRDYzVNxH0+xW8zE2YItgyqDMbdgJj+
         grjFwVfDLHdHZYO5LKd9ivy0QIBR5zlilOCD3drD2BX1GWBkattcRfEbLEwWWLO8u9iC
         N85w==
X-Gm-Message-State: AOUpUlEPOiYN6F4zWShUJBHqOeZJZcfK2oiArv2Hbw3fxWwot/vr6Dtx
        4vepqNiZrccAGn74rJ0rvOY=
X-Google-Smtp-Source: AAOMgpeA7w9GiK960xd4ZTUVMzJLh4Yla6y16es+VE+5mwaHRvctMfkYhWOcRdwCIvES20pCKYJ6qQ==
X-Received: by 2002:a1c:1252:: with SMTP id 79-v6mr1800087wms.70.1532617966841;
        Thu, 26 Jul 2018 08:12:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a2-v6sm1300922wmb.6.2018.07.26.08.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 08:12:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     git@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] name_rev: add support for --cherry-picks
References: <20180726121346.GT1934745@devbig577.frc2.facebook.com>
        <20180726143930.GW1934745@devbig577.frc2.facebook.com>
Date:   Thu, 26 Jul 2018 08:12:45 -0700
In-Reply-To: <20180726143930.GW1934745@devbig577.frc2.facebook.com> (Tejun
        Heo's message of "Thu, 26 Jul 2018 07:39:30 -0700")
Message-ID: <xmqqa7qerpxu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> From a6a88c3da252d69547ac8b463098fc4f4c03f322 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Thu, 26 Jul 2018 04:14:52 -0700
> Subject: [PATCH] name_rev: add support for --cherry-picks

The above belongs to the mail header, not the body.

> It's often useful to track cherry-picks of a given commit.  Add
> --cherry-picks support to git-name-rev.  When specified, name_rev also
> shows the commits cherry-picked from the listed target commits with
> indentations.
>
>   $ git name-rev --cherry-picks 10f7ce0a0e524279f022
>   10f7ce0a0e524279f022 master~1
>     d433e3b4d5a19b3d29e2c8349fe88ceade5f6190 branch1
>       82cddd79f962de0bb1e7cdd95d48b48633335816 branch2
>     58a8d36b2532feb0a14b4fc2a50d587e64f38324 branch3
>     fa8b79edc5dfff21753c2ccfc1a1828336c4c070 branch4~1

"git name-rev X" asks "I want to know about X".  And the first line
of the above tells us that 10f7ce is the first parent of the master
branch.  What does the second line tell us?  10f7ce was created by
cherry picking d433e3b4 which sits at the tip of branch1?

It appears that you are showing the reverse (d433e3, 58a8d3 and
fa8b79 sit next to each other, but it cannot be that 10f7ce was
created by cherry-picking these three).  I do not mean to say that
the reverse information is not useful thing to learn about the
commit (i.e. "X got cherry-picked to all these places") but I am
having a hard time convincing myself that the feature sits well in
"describe" and "name-rev".

> Note that branch2 is further indented because it's a nested cherry
> pick from d433e3b4d5a1.
>
> "git-describe --contains" is a wrapper around git-name-rev.  Also add
> --cherry-picks support to git-describe.
>
> v2: - Remove a warning message for a malformed cherry-picked tag.
>       There isn't much user can do about it.
>     - Continue scanning cherry-pick tags until a working one is found
>       instead of aborting after trying the last one.  It might miss
>       nesting but still better to show than miss the commit entirely.
