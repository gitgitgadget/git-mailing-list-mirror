Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932CE1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 18:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeC2Scy (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 14:32:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33620 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeC2Scv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 14:32:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id o23so19626654wmf.0
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=keqkRElNWagR6yPXtw+uF+kInEaT6aF32jxtXZHZz8k=;
        b=AAm/EzeJw3LEnfuqzG82LcNvvN59nCe067wDxQF7qDMvP24vh8l8yAv5QjYgve9G+d
         gBASMpBtuysd1myiMPHf3nWKizH56N20keU6UwQHWF59lXetl+EbTD68NI+MYdLyrd9/
         Q4AbzLr977Rx6Lquij/KJfpH6qWNCNF8/UY+wEHp5dmxRQcFil9VaB8fXlv0iZ7kA316
         SL5nvbQ2n/I71tNDTld7PGc5O2IKaK5vCgjOdaxdBzfd6xDKgcAxvXTy+8KD6K6mDGHD
         UOSCLALHpyB/53H9eNm6UrN4HuYiopbImGdnQKOn7SQ20ptizb1e5BNslS/L1df5OTgZ
         eRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=keqkRElNWagR6yPXtw+uF+kInEaT6aF32jxtXZHZz8k=;
        b=YNSZJd/cu8FJwfGElLaO0sum8x07G1nyyfxkBIO3yWPPsgv+WhvoPPsF1TNItlUJsw
         eIFd3MRXnUlTf5+bvde/DEeFYnWYwH+nQPBXPzxZEnuyJhy1nWbBEvKNGmWpn03mWPeG
         u5YQ5fJZ5WquHEg2/XdVhUqm0eddHXOpawM5xBkY1Oh43gocz+t5r4CztpyLgtpQGqyD
         41/jKqIVSqH83laPtjd2OqafKLmgI8bYyP2zaflH3F4Aoo7JJ7flYtzRU54a08flf6NA
         6Jl+gBALGZ7NDravAWARqHVtnisDzhbsyjwv+MY50OUFnJbZGH5rlLFxvkhV7lwVNN06
         J+Ew==
X-Gm-Message-State: AElRT7FVvlqGSYEOmp/nD+TB+OeZsodqlrsQtrO3QdoHW+SWlcEOK3W7
        auMA7rRlMnt1BV+JDh1lh37Zl3Og
X-Google-Smtp-Source: AIpwx48mDISOvH2BqfYi4j+CDv6X9vOn3gGPY1OK5JI/iBDMZ8Ev60b5JhbVLCkDPYIyViAf43puBA==
X-Received: by 10.28.108.5 with SMTP id h5mr50649wmc.35.1522348369688;
        Thu, 29 Mar 2018 11:32:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z66sm2640400wmh.14.2018.03.29.11.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 11:32:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/3] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180316101346.7137-1-phillip.wood@talktalk.net>
Date:   Thu, 29 Mar 2018 11:32:48 -0700
In-Reply-To: <20180316101346.7137-1-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Fri, 16 Mar 2018 10:13:43 +0000")
Message-ID: <xmqq1sg27mwf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Since v2 I've updated the patches to use '-' instead of '^' to invert
> the selection to match the rest of add -i and clean -i.
>
> These patches build on top of the recount fixes in [1]. The commit
> message for the first patch describes the motivation:
>
> "When I end up editing hunks it is almost always because I want to
> stage a subset of the lines in the hunk. Doing this by editing the
> hunk is inconvenient and error prone (especially so if the patch is
> going to be reversed before being applied). Instead offer an option
> for add -p to stage individual lines. When the user presses 'l' the
> hunk is redrawn with labels by the insertions and deletions and they
> are prompted to enter a list of the lines they wish to stage. Ranges
> of lines may be specified using 'a-b' where either 'a' or 'b' may be
> omitted to mean all lines from 'a' to the end of the hunk or all lines
> from 1 upto and including 'b'."

I haven't seen any review comments on this round, and as I am not a
heavy user of "add -i" interface (even though I admit that I
originally wrote it), I haven't had a chance to exercise the code
myself in the two weeks since the patches have been queued in my
tree.

I am inclihned to merge them to 'next' soonish, but please stop me
if anybody (including the original author) has further comments.

Thanks.
