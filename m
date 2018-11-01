Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B9D1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 06:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeKAPN7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 11:13:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39970 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeKAPN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 11:13:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id i17-v6so18856479wre.7
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 23:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IXL5GtN8NW3WRXpuAh5soeC76KEbghYqliecF62sbc0=;
        b=Xo4+csfe7sitsU29SsK0PpQ4GaIOIZ6YnYtz7DYZHNdOTldIoScVWC+umU+hncYYMv
         ztE/nqfaqnL9WcHKuXu1yio/w2QIg5y/oy/a58hIAI6sJlzy8pys/WWSkMipTEL1cmDp
         5i5l2J//7Jxjmxx5xa97JU+3OXaaDd2dHQEOzQkHirrfoCHYRIaMksKZEipYkgCZhGyv
         mYxp7G65oAkwm8GJlAuSqgiUf6JSyeeb9N91lrVVqUR8+zO43liUw2GNN+cUlgYonlNA
         fX6F6ERdBXCJgzluoQZYhVbaTALO+SVG4A+KBsRvRU7+PcWk+2chRp90Ls8s8Ytjykbc
         RTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IXL5GtN8NW3WRXpuAh5soeC76KEbghYqliecF62sbc0=;
        b=o3Nn1LAVTT8TQfHD3e7EIPFFlPbtnH4eMsnzZBxA7M2YSQkgCZUXerBDnEuWloDRuf
         lEyxUYR2sp063W3QlxLDgLgRApxwJUxh3mRPkgwPYFMA5Jn61SF4OtLGYqWIDJ7rZ27S
         8MuM0Z95jByu8VtWDPdp63Ru2g4n/U4f9oaVV+ykpMZWmQUXv60D89N5pipLV+t9cymv
         J4CHtxXOaD28xJnYQzROBhXDb6+0/nMP2Ljv5SnoPVsAhX39tjoG+ly4ZgS1E5GFUEGa
         Zwmz+FJamO06Oimq2F8kKDswTVifGI4yiwzUY2wQnoNLGYaBkdartRejB37VQl7QqWZP
         Jazg==
X-Gm-Message-State: AGRZ1gLyDv7DBrhsylfWQJOvgoP5xXpf+yOLeGRVXw5Q95+aT5S2EF9g
        POrahfFkwopueXT0dE9mS/5CpYcRyGk=
X-Google-Smtp-Source: AJdET5dmSrrmzg/d/hAyHYI8A+qAeItQfr8g3CGhbMMEI2lqUUowkCorLWWtiHUStENXIzhaDk+qxA==
X-Received: by 2002:adf:eec1:: with SMTP id a1-v6mr5584491wrp.242.1541052744047;
        Wed, 31 Oct 2018 23:12:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c24-v6sm51759344wre.44.2018.10.31.23.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 23:12:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] tests: optionally skip `git rebase -p` tests
References: <pull.63.git.gitgitgadget@gmail.com>
        <39734e4805cbd695cd69e7c1a3016de629ac9b3c.1541016115.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Nov 2018 15:12:22 +0900
In-Reply-To: <39734e4805cbd695cd69e7c1a3016de629ac9b3c.1541016115.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 31 Oct 2018
        13:02:02 -0700 (PDT)")
Message-ID: <xmqqh8h1tjg9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The `--preserve-merges` mode of the `rebase` command is slated to be
> deprecated soon, ...

Is everybody on board on this statement?  I vaguely recall that some
people wanted to have something different from what rebase-merges
does (e.g. wrt first-parent history), and extending perserve-merges
might be one way to do so.

I do not mind at all if the way forward were to extend rebase-merges
for any future features.  To me, it is preferrable having to deal
with just one codepath than two written in different languages.

I just want to make sure we know everybody is on board the plan that
we will eventually remove preserve-merges, tell those who want to
use it to switch to rebase-merges, and we will extend rebase-merges
when they raise issues with it saying that they cannot do something
preserve-merges would have served them well with rebase-merges.
