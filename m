Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5EB1F829
	for <e@80x24.org>; Mon,  1 May 2017 03:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034880AbdEADL5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 23:11:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35787 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034816AbdEADLz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 23:11:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id o68so7203539pfj.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 20:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=TxFkUQgOavZIeFuLsXbLfvqZphJRD8xOdhmRHKdGSjw=;
        b=iQALiEF+R7RUYU4Bq2hpTmhM19i3G8Az95DgCSGy9p9TyrWIPX6b9d0xhvdngR52ID
         c5JrCZJByoWS4AL3d7g7w22KXp2dm9BWHSLCsKNzRK//p6YZEGKmATvYzr77pvt8IH7m
         Ajo1W4th+2kdM6lqQl7PFQOXhi2Ox5gbyPBvcMCSX06e2d6k4OVoxDJKa1WveEIijE+H
         NBjMoKfGFPq3Crsm2J4Y2488GWSl9papZsspfHdq5+uIm2rlBaQ+3INmFu7h7scxoH1d
         qEMdu+n7Fibz98Dv4Xp6aeXDNMmTriZ6/pBwWd8PjymCcrD/AVSz13cod0pGOftQR9qN
         BzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=TxFkUQgOavZIeFuLsXbLfvqZphJRD8xOdhmRHKdGSjw=;
        b=qqQS1rn8vMuuaDq+rcGjxObj6MqZohtNuy6kFNgqoiNHsQfUc0YsnFCOvy2h7n/RJf
         VmqffRmN5BzJB4Sx9W1JQRypYDiVT0IQwTmtUvnZIKDKUG++oRymKHhDgcU5IcDEuIyS
         X2XdHgWSP/uBmkscvTmw1IHu0ucjoXhKbSQThkHeUhBu1asppW8aEEEJzUdR0Tr4GEoT
         zbq8yuvfpZ29HUC8+h7a9gaUDI9A9Gb+q7yvscZlG00U/CCEmhF8ViLFPdX0melka+Jj
         KqvMOWg2ugysNjW3SqCy8jAu0gWXjFGRsRCVqZuhKapL3ZnKWXIbnRECKKJIh5B/TSG5
         P2JA==
X-Gm-Message-State: AN3rC/5d8RyVM1eXo8CdIHhZ8KL/meiVcPVV1T+k9Ja/nAG/1l2Qcohr
        AXZVpKyBPFmjXyOh6D4=
X-Received: by 10.99.111.1 with SMTP id k1mr24710163pgc.194.1493608314772;
        Sun, 30 Apr 2017 20:11:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id c83sm20974576pfd.113.2017.04.30.20.11.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 20:11:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via rebase--helper
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
        <xmqqvapqo4i8.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704271607550.3480@virtualbox>
        <xmqqbmrhmlsw.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704281711540.3480@virtualbox>
Date:   Sun, 30 Apr 2017 20:11:53 -0700
Message-ID: <xmqq4lx5i83q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In that case, I would strongly advise to consider redesigning the API.

The API we currently have and is used by "log", "rev-list" and
friends is to have setup_revisions() parse the av[], i.e. the
textual API, and it is sufficient to hide from the caller the
implementation detail of what bit rev_info structure has and which
bits are flipped when reacting to say "--format=..."  option [*1*].

As the implementaiton detail of which bits are flipped when reacting
to each options is _not_ the API, we are essentially left with two
choices: write this series to the current textual API, or invent an
alternate API [*2*] and write this series to that new API.

Besides, the original was already using the textual interface to
set-up the revision traversal machinery (after all, it was a shell
script that invoked rev-list), and the series attempts a faithful
rewrite of it in C; writing to the current textual API is a
future-proof way to do so, and something you can do without waiting
for a new API to materialize (that is, assuming that we need an
alternate API, favoured over the current textual API).


[Footnote]

*1* You'll notice that there already are (and were in 2010) users
    that cheated and peeked into the implementation detail by
    looking at unnecessary places the patch that added pretty_given
    bit; some of the places it needed to touch probably didn't have
    to be touched if they were writing to the API and had their av[]
    parsed.

*2* Quite honestly, I do not get how much you would gain dumping the
    current API.  It uses the same codepath "git rev-list" and
    friends use to parse the requests by the end-users and scripts,
    guaranteeing that it will stay stable, unlike the underlying
    implementation that may and will change.  And the set-up of the
    machinery is not even the expensive part anyway.
