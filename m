Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11AD1F404
	for <e@80x24.org>; Sat, 10 Feb 2018 20:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBJULX (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 15:11:23 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:47021 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeBJULW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 15:11:22 -0500
Received: by mail-wr0-f195.google.com with SMTP id 34so1214456wre.13
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 12:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WNjXuRiIlyZ2XGrh5BdUUoB8zdQ/PEBGokHUgF2T1zI=;
        b=MRv8RO1h8kaaniKhJOrWwZ3bG2L/HKhQlueUqThG3U2JhfmnMYuKzk3mbykDgeMtr/
         ez0FdsnXAlsXkL5Wlwupy6R/75DlUUgCjPnbM1dKlmBDt15TXFVCSwLo/zvP1cmYocrz
         MDe8YiGlUJ9+BWf4/z0EaUKhnTE2B4SuOkhaQTBlr1bfFur3SQSBu71NCXpsfWVGdSTI
         DlNOkyb0a4AHjDsLcAq99MYbQMQb1CbPJA8FTYfNsenTXfTCMTEfZSn9Mb/f+Tbv3WJ2
         u+anQfYZH2OyS+U5pF77exEtMkf1ZFb3kAkvDXuJvEqFMfLIZTsxspBUiSysS7ELbGIR
         xIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WNjXuRiIlyZ2XGrh5BdUUoB8zdQ/PEBGokHUgF2T1zI=;
        b=iU1/VPSyLKLeROOjwBwzS+BB8Tml5RTXpoumrUoYbCo7xPp1awIGeMOcwOzIi4J5o+
         rnLua0Cr/W0NQA23eVkNeho2DG6+yiojSzxTa3NM4YrqRiJU0K3BXtojoA6V0S/KLBVI
         R+aUaSKlLOPcFGT/BweBlE5o7DjdOWMByR6QYIYgvw7TKs1dVvS16T8x7B5fijSeeJvo
         rbzE3CmOFgBTDmQKXJe+rGCeXKo+12+xxsjW4XaEcpxvRfe/0tNM0RVrrNYT1Kv2vj2P
         +VJqeBw2xZYpFUmycJP0eS1BDVUgPPVGkldk0zcOIhJNT8Ko/ElkzIr1f08Hq7+ZFN+A
         RnWg==
X-Gm-Message-State: APf1xPCQfm9YdNWmKKtrrB7ItnwdCFAxp+r9uAowsP+afHzill4pafMV
        eY24+DTa8LsrUOoc/K5n5R+xRcPg
X-Google-Smtp-Source: AH8x224GhDJ/AbK6VTFMlO6ivaGXcsgHfxOa3nQOOMCYjXEGJR9zNXjonDOWyJOJMyZAqC27cfR4YA==
X-Received: by 10.223.197.75 with SMTP id s11mr1508200wrf.143.1518293481233;
        Sat, 10 Feb 2018 12:11:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x65sm1783254wmg.29.2018.02.10.12.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Feb 2018 12:11:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [RFC PATCH 3/3] fsck: Check HEAD of other worktrees as well
References: <20180209231330.4457-1-newren@gmail.com>
        <20180209231330.4457-4-newren@gmail.com> <20180210095952.GA9035@ash>
Date:   Sat, 10 Feb 2018 12:11:19 -0800
In-Reply-To: <20180210095952.GA9035@ash> (Duy Nguyen's message of "Sat, 10 Feb
        2018 16:59:52 +0700")
Message-ID: <xmqqmv0gtxjs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Feb 09, 2018 at 03:13:30PM -0800, Elijah Newren wrote:
>> This takes advantage of the fact that "worktrees/$WORKTREE/HEAD" will
>> currently resolve as a ref, which may not be true in the future with
>> different ref backends.  I don't think it locks us in to supporting
>> resolving other worktree HEADs with this syntax, as I view the
>> user-visible error message as more of a pointer to a pathname that the
>> user will need to fix.  If the underlying ref storage changes, naturally
>> both this code and the hint may need to change to match.
>
> I'm leaning more about something like this patch below (which does not
> even build, just to demonstrate). A couple points:
>
> - Instead of doing the hacky refs worktrees/foo/HEAD, we get the
>   correct ref store for each worktree
> - We have an API for getting all (non-broken) worktrees. I realize for
>   fsck, we may even want to examine semi-broken worktrees as well, but
>   get_worktrees() can take a flag to accomplish that if needed.

Very sensible.  

When I saw that "fsck" thing, the first thing I wondered was "wait,
how are we doing prune and repack while making sure objects
reachable only from HEAD in other worktrees are not lost?  we must
already have an API that gives us where the refs of them are stored
in".

Thanks for a quick response for course correction.
