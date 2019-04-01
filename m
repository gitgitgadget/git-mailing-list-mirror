Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4FB820248
	for <e@80x24.org>; Mon,  1 Apr 2019 09:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfDAJ3J (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 05:29:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47026 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfDAJ3J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 05:29:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so10976438wrw.13
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=qKSQ1ap13h6ulqRDg/d/CLOGehdff/GuFycu0SQTyK0=;
        b=gTSFj1xopIBsu7Yizo2ga0z6nlvMTtFn092WLGgS/fPDmpleur8znEoJ2uEyhSGMkq
         gjPRDmGPIAVr1lgCMFC786muJTXRW/012CyRX7n9thIjWnaVS2jmPQOmEEZZu4iyDlP3
         tBj1lEzpVmHuVcqFXx1THDwmM27oujYiXuUrzXjpJSbzi7CCRHsmRNvOC0e9YCaNiCPq
         DTK3rRHju72MsydHvx7oTXz1Q1JC4Avgx+yY0HzdimQ44rH43RVSKZHHWS0PTc/wRBvn
         2o0ydcEtR3/yu6u2VRu1xUituv8u/YQX46kYsO88psamBYKqrJ9i+dOKQCYEnrdQnMoP
         v3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=qKSQ1ap13h6ulqRDg/d/CLOGehdff/GuFycu0SQTyK0=;
        b=P5jAoFZFSHPrhXBT6Rcdl/dhSiBJWe7mZtCi1zCn5rYSb1FZ+B/BAW7ycAGQm7dDq4
         aD6yo1Pl1iqYQVAXeWKBy5ul6VtnPVYMoFSSoMBwWIMLWq24wnXB1pad6b58ZLEGf8FS
         P3XpX7vjXBOMfG1fz3x7Ls/dt+PcaUDHjAhjsPTsKNK8iG8lRWRyixFoe3BiyKyB0W6I
         +6QwK1/V8l3XQZKOBiqaVBXOD1gQCTJAH5XCR5fayyMY57fOBxvcPBM9e8ETIqDXEOFo
         xzG6nr2NrW9MDPfFdoeS9jpVA94DUJ9CVbQzaIcC/nvUGI6fBxaPGgpnjMeZdvYz20nj
         nJ9g==
X-Gm-Message-State: APjAAAWd9CP9AXm6HMWL/FFi0Ymrg0i8HKpKAfRJE5vVJ56UhkFMoYWX
        O8Hx3PDiasKoEyLq1E/h5xODSS3+xQw=
X-Google-Smtp-Source: APXvYqyv6RCz8hyKENXS3noeIqHGFdQHSF1GJUEM/EmLZGQ/qGc6olDS7JjokdAymYkrV6f/y4RdeA==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr41343225wrx.115.1554110947730;
        Mon, 01 Apr 2019 02:29:07 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v14sm9336531wrr.20.2019.04.01.02.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 02:29:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
References: <20190208090401.14793-1-pclouds@gmail.com>
        <20190308095752.8574-1-pclouds@gmail.com>
        <20190308095752.8574-11-pclouds@gmail.com>
        <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
        <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
        <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
        <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
        <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
Date:   Mon, 01 Apr 2019 18:29:06 +0900
Message-ID: <xmqqbm1qxee5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Mar 26, 2019 at 8:24 AM Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Mar 26, 2019 at 10:01 PM Elijah Newren <newren@gmail.com> wrote:
>
>> Yeah.. --ignore-in-process does not necessarily mean aborting
>> something when you just want to get out to examine some other commit.
>> And I agree doing nothing seems like the best (or least
>> confusing/surprising) option.
> ...
> Yes, and in the middle of a cherry-pick with a range you've added some
> commits to one branch and some to another.  In the middle of a revert
> you're doing similar.  It sounds like crazytown to me (and maybe we
> shouldn't provide the --ignore-in-process flag unless users clamor for
> it ...

It really sounds like --ignore-in-process that _leaves_ the state
files around which are known to be unrelated to the new commit
pointed out by HEAD is asking for trouble.

We just should tell the users "if you want to go examine something
else during an in-progress operation, do it elsewhere, or cancel the
in-progress operation with 'cmd --abort' (or perhaps 'reset --hard')
which will allow 'switch' to move away".

The thing is, "switch temporarily to another commit, do some
sightseeing and then switch back to the original commit--we did not
touch the in-progress state files while doing so, so we ought to
come back to exactly the same state to be able to continue" is
brittle.  Temporarily switching to another commit or branch would
need to touch the index (in some irrevocable way) and with future
versions of Git, underlying machineries (like UNDO data) other than
the index as well.  What the user would do after (temporarily)
switching out of the in-process state (e.g. controlled by the
sequencer) may be destructive (e.g. "switch away temporarily, forget
that you've switched away and try to run cherry-pick or rebase").

