Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95E11F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 23:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbeJGGZs (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 02:25:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40309 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJGGZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 02:25:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id z204-v6so4971665wmc.5
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1piP9duEMRn4mRdXh3impF06uZe1jrNZTGxYNOW/Bpc=;
        b=Y0A1uEyc7R/WRk4RdIs3fsA7Rs4qc0sHsKJ37U9EZmXi0FNlxOqZz+u7VDTiHjPZWD
         zGgyO+6cWB/4TEpa4/UMoXVEVj1UYnnChuAzLl67XZTgqO3iCP3QIF8ubNUMFZFjNRSd
         V/tzUY9Ee4srMSLAYdvZhoKPcegBFPCR39IsowhyyyEXE2OkNiTnarN30si2xGPt5g3T
         0PjXU310sEYRZ+g61ap0KJeXfgb/Oz2AR6eEhxYoBBMMOsIsjPHB7jCqHcM2+pIsZtIS
         xNZCFV2/pPsr1lXEfH6JG4TKIf/dxS36HqQfWt2ZcucI5xaoPaw9ufITKRbLkrKY+odZ
         iHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1piP9duEMRn4mRdXh3impF06uZe1jrNZTGxYNOW/Bpc=;
        b=De6H0v5EeGuCRMOT3El4ayir3l08nJyyOMBK6LqtVqPnjuRmb6MeUaXQkYx6JMo0im
         Sc/eWgtKIIiVlXA6io5wqULOI4ff6MGenunJwd3BEHFPPZWRdgY/i/ve6zgvl34QtXtG
         1i5HTS2MhmQOTf28kfifvcJ+p7RTkA4YMyym7mJVfdAgDE6KNBEShSR5VLJMPC7tEFQO
         eTGudh3dcn/PKQ4n1mQZoyaW1qvjrtWQ/A3r4gsZ+vHyyzahPP0AI/+1D7lzAuAz1smg
         G8MXYOs5HR6loWne9V6AmarZkouRPg2VZjPc6KoB/CChW93IZjJqJqsmehPtIggfKdg+
         pJqQ==
X-Gm-Message-State: ABuFfohPvb65o5tr0JrfajGZD+431OlSiqKi20ygi4MTITkgrIdcyRkM
        BzllyF8MQHuPQXgvYNOhgj0=
X-Google-Smtp-Source: ACcGV62fplCZrvGmm4gML0XBX5SIQxji60lsLkh5dEoD2rldPNSbDZ014XG3JjbKkE2cq/iNka/adQ==
X-Received: by 2002:a1c:5505:: with SMTP id j5-v6mr11086101wmb.146.1538868039212;
        Sat, 06 Oct 2018 16:20:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5742744wmt.16.2018.10.06.16.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 16:20:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] refs: new ref types to make per-worktree refs visible to all worktrees
References: <20180922180500.4689-1-pclouds@gmail.com>
        <20180922180500.4689-4-pclouds@gmail.com>
        <xmqqy3bpnupm.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AiVdXHNz362rixeUWj0Y4HknU93qqcT2EFMWVbsjwpJg@mail.gmail.com>
Date:   Sun, 07 Oct 2018 08:20:35 +0900
In-Reply-To: <CACsJy8AiVdXHNz362rixeUWj0Y4HknU93qqcT2EFMWVbsjwpJg@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 29 Sep 2018 20:26:59 +0200")
Message-ID: <xmqqbm86wtks.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> > The main worktree has to be treated specially because well.. it's
>> > special from the beginning. So HEAD from the main worktree is
>> > acccessible via the name "main/HEAD" (we can't use
>> > "worktrees/main/HEAD" because "main" under "worktrees" is not
>> > reserved).
>>
>> I do not quite follow.  So with this, both refs/heads/master and
>> main/refs/heads/master are good names for the master branch (even
>> though the local branch names are not per worktree), because
>> in the main worktree, refs/bisect/bad and main/refs/bisect/bad ought
>> to mean the same thing.
>
> True. I think the ambiguation here is about the main worktree versus a
> secondary worktree that is accidentally named "main". Then suddenly we
> have to worktrees of the same name, and accessing them both via
> worktrees/<id>/HEAD will not work, and there is no other way to
> disambiguate them.

So those who have happily been referring 'refs/heads/main/foo' as
'main/foo' now suddenly have to say 'refs/heads/main/foo' instead?

> The rules are not touched. But it looks like everything still works as
> expected (I'm adding tests to verify this)

What I am worried about is that _your_ expectation may not coincide
with the expectations of users, especially with ones with existing
refs that overlap with the namespaces this series suddenly starts
carving out and squatting on.  As long as that won't be a problem, I
think it is OK, even with 'main' not renamed to 'worktree-main' or
somesuch.


