Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED3B1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966999AbeFSR6e (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:58:34 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41670 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeFSR6d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:58:33 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so546240wrq.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4MTbVQLpOr8SbQFo5KJwpECxIyRWoiT03F40Pw+nT2Y=;
        b=eLZTbxtaxyZlAYmqqYWqQmPRQzMtq0UK3NDdTwngvvJDxbKhdWRJ3DC0pM4hOiKqCM
         RqHwuxqIHPdHQ/lVnvqymkRefyEC4aWNGHxBB24JFNHGvfpXqk5EJAqhDbP06K8rnnD8
         R+TwguSTPD+aCClaXr/3eEdwAnyCYSlJoT/w9k0nlK01GvykhGSvto5wx9j9M7Boq6m9
         25zbyAuPqIgiQUObVuZpv7BH8OCsFVbauuDuMDUVkGbBODYzTJBl4VelcAKQUJIMTBro
         J4IvmG8V5hV4dJ9TLxaXbL0bIKWFslfkFvIPERqiba+vD1GcxDsnlBi5SNkGFWn0AgVP
         u39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4MTbVQLpOr8SbQFo5KJwpECxIyRWoiT03F40Pw+nT2Y=;
        b=aThtdB7VYe6IPlD20GnFTFir7ZwATVklATTiIyBx2kVuzYeRq6wxBoBskfHQvoPHxi
         ZFZXemSkF8i9DfIMlAXpDs5b3RpUx0YFLqdrYF+gEj0/rra2iG6QWWL2zKudVSKlHtXw
         BQYOvf0vCcGJxKQCl+lMAsY8U3i5Abc1xTFYqbecWj+I3tCs4MSH70FBS/Oa1Iy9gO3E
         JAiw2Vma24CLz6tWpms4W7EeUiTg2IsFcL45gaZYMzxO3L2wEoITojkHUexiO0RlmO85
         1FRoWu3N1/POeag+hrjIyRMkYIUb/Rv798kwragUY6hnr29aMaWG3M+dPhsBGbkufDt1
         iJUA==
X-Gm-Message-State: APt69E0R/IP2h4XbJtwPMiYvH9WGwvz04P58PLWkHyXB7mEgGBNL4bOK
        5wV1j47QUz4X+0RxOLHymIg=
X-Google-Smtp-Source: ADUXVKJ/0xv0GnM+LNd8h+S214yanylZXmr6htD4fSlQjcErOr0TIfQHxQet9aW1qv9u6Ai6ycy3RQ==
X-Received: by 2002:adf:8747:: with SMTP id 7-v6mr13902782wrz.117.1529431111521;
        Tue, 19 Jun 2018 10:58:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w102-v6sm634284wrc.23.2018.06.19.10.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 10:58:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
References: <cover.1529365072.git.me@ttaylorr.com>
        <20180619163506.GB22034@sigill.intra.peff.net>
        <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
        <20180619174846.GA27820@sigill.intra.peff.net>
Date:   Tue, 19 Jun 2018 10:58:30 -0700
In-Reply-To: <20180619174846.GA27820@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 19 Jun 2018 13:48:47 -0400")
Message-ID: <xmqqo9g6vet5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Although there are interesting cases around inversion. For example:
>
>   git grep --not \( --not -e a --and --not -e b \)
>
> is equivalent to:
>
>   git grep -e a --or -e b
>
> Do people care if we actually hunt down the exact column where we
> _didn't_ match "b" in the first case?  The two are equivalent, but I
> have to wonder if somebody writing the first one really cares.

I may be misunderstanding the question, but I personally would feel
that "git grep --not <ANYTHING>" is OK to say "the entire line is at
fault that it did not satisify the criteria to match <ANYTHING>".
I.e., I'd be happy if --column marked the first column as the
beginning of the match, or --color painted the entire line in the
output of the former.


