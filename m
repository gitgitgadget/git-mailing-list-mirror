Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115ED20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 03:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeLKDHF (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 22:07:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35173 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbeLKDHE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 22:07:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so646551wmh.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 19:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LmRAgYj3K+DDCLZNabT76K9BGRoQeX5enpP7XmkfnDA=;
        b=oDsQ17dvBdw72Dd8Ud0WwdlsjxPOvdtLKdGh2kCQ/5tcaTuXLeYR5cbkQAVQChFxgb
         iCh3U1hQ9nDBl5zDfPRTfCFwYnYojso3jdOWoonf4o5GoPD62RhVqCk05hXgE7P5tldq
         dpPV+PVI1iqcdr87L55Tb3gi6fveH36X6CKWroj3n8HyFtrUdFH1Jzo6yW2y4fONWci/
         fPfBWE2TZJecs3nue05b+UvXWlUy90dxk1IETJvcVqulNyOMHRrdQZzn7571CodFeGcA
         wW35OY1xQztcu5kWqNtc4Mn90l/Q9+AMxRZeP/kjCP5tOfhwpLz323zs8/vYs3g1e4FY
         h/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LmRAgYj3K+DDCLZNabT76K9BGRoQeX5enpP7XmkfnDA=;
        b=s/+qbgeZr+4s+iyWsN0Ak/X1Ytf/pS8Ep7bk854RlM1D/lhC/Fbr1w5rcSa8HBxkym
         nKodpNHa55nGeQpSH57u36egqO062wYQSY2WOSMXq0rzVF0BbqiEkPleGue3tc7gU0kr
         sPjX1S3VQJXRU1f5R+RjTJiRTJe5szFyHHu66mS3z3/MsK9ueo8tqjRI5kXfBPIm6aI5
         Cqpisu0I5mKEBV3yIPUP0yEIl25DAYSvgAkCptFMppT1KVSjLEiQmm1ew5MXWA/iXRV5
         +CM7Y/D9x6cxBAHsol+UgRrksd9e2V1lPmS/KmVKsjb/GQuI2gzkQYFzj5iPdkEKfxjd
         xsDA==
X-Gm-Message-State: AA+aEWbemmC34Idws2QfERUK80K9tzLwUbHyQa9Pb4+Ig9uwYHGwq/6x
        V6YVRIU1MP5CQL7PQg7QDA2BP6shCkQ=
X-Google-Smtp-Source: AFSGD/V0zwjNOO7GR6HD1Ob77GseuvJskj62xktt7DDrrXzxIQ51FRQNpb4B0DLokmhUiAr5bCIuxw==
X-Received: by 2002:a1c:8d49:: with SMTP id p70mr745453wmd.68.1544497622562;
        Mon, 10 Dec 2018 19:07:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s202sm600793wme.40.2018.12.10.19.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 19:07:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [PATCH 5/8] checkout: introduce --{,no-}overlay option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-6-t.gummerer@gmail.com>
        <CABPp-BEk+7n2wcbjETishqnMBs5DGrTEvD7gahLtEj5bZ2AYvA@mail.gmail.com>
Date:   Tue, 11 Dec 2018 12:07:01 +0900
In-Reply-To: <CABPp-BEk+7n2wcbjETishqnMBs5DGrTEvD7gahLtEj5bZ2AYvA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 10 Dec 2018 10:19:40 -0800")
Message-ID: <xmqqzhtclq22.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Note that 'git checkout -p <tree-ish> -- [<pathspec>]' already works
>> this way, so no changes are needed for the patch mode.  We disallow
>> 'git checkout --overlay -p' to avoid confusing users who would expect
>> to be able to force overlay mode in 'git checkout -p' this way.
>
> Whoa...that's interesting.  To me, that argues even further that the
> traditional checkout behavior was wrong all along and the choice of
> --overlay vs. --no-overlay in the original implementation was a total
> oversight.  I'm really tempted to say that --no-overlay should just be
> the default in checkout too...but maybe that's too high a hill to
> climb, at least for now.

You are exhibiting a typical reaction to a shiny new toy.

The original "checkout paths out of the trees and/or the index to
recover what was lost" is modeled after "cp -R .../else/where .",
which is an overlay operation, and you wouldn't imagine complaining
that "cp -R" is wrong not to remove things in the target, to be
equivalent to "rm -fr where && cp -R .../else/where .".

Each has its own uses.  We just didn't have the other half of the
pair.

If anything, I would consider "checkout -p" that does not do overlay
is a bug that needs to be fixed.

