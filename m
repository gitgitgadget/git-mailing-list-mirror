Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDC71F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 02:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750766AbeFACRt (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 22:17:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38058 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeFACRt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 22:17:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id m129-v6so59347wmb.3
        for <git@vger.kernel.org>; Thu, 31 May 2018 19:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0WudxENpRhS6FvVEhDzfmxcw0zd96DI2l3JfzWOwF58=;
        b=o1wyiqwRqSEJ3RHr/6+zzfGPuR2/ICt6t/0/PcmOQpRIDtdwAoBWAZCC3n5BGtOO6/
         +dBcAllKklt2i8VKHwpWOd6q7lFss+TY8IsJ1J9aJ3oc6/eboFa7Lkj+FYx0VgHNlLUw
         GVUg4/RDb95hrJZrn5U1yu8igOFpPlGOWfsqPZylIHC4F7fje5+q8FtFku1sckxPKZqe
         4R0sro83GhC9SRmkbG9ww3Q4+AOiIdSLEDYwAQ2E63yI5SFyk8ZqCI1cPOccsZO9OdHA
         EcphU3SwB02Ohs43NYhulfguZTLA2tq8Ubomc4p98yxm58Pbd56loZNAJs7ucB+HJbAZ
         xs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0WudxENpRhS6FvVEhDzfmxcw0zd96DI2l3JfzWOwF58=;
        b=PPxv9y3JqfKCtx6x83Izi3dC2keraKq4RpIO1f59nWkCPAXc+xNcAiMbc2cF6uoBWi
         pqQLfPbchQFrDpfMhG1NYH3AbKv6EO7xl+0y0g4PcZK9gEJiewrVPs8NFt6T8R1J40sE
         uobUu90SbTbclrC3T+g5okaCcGRkej+fSZwTlLoJzN+RTOZtcV2/yq8oGrC/xiu+Wmu1
         KEVRv7fj+WZsrVK6SE2fcgNLuBuPeLFXoFplxAkPO6+wH0wU/hLmWLHO6bwVycrVoKHB
         6Df4ZRjUY5wdXiVPCcX9deFfs4iil0q29MphMO+5SWreJtDtCSXsfxL57GezC403DUSs
         C9xA==
X-Gm-Message-State: APt69E2vP1e4RkI+8uAIOJ7axH1CzaKDLrCBOP+fjnGUngzBRjDN2df6
        VZoW1rhWnAcrFcRy0Ae81c8=
X-Google-Smtp-Source: ADUXVKKcMrbHq6/4XXDRzd+Wmxda6CvJOEyS6mJMvyxAkO5stsCc2FZrzmCfZQFWv1Rpq0SyFn1clg==
X-Received: by 2002:a1c:15c3:: with SMTP id 186-v6mr1422467wmv.39.1527819467724;
        Thu, 31 May 2018 19:17:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c53-v6sm31950156wrg.12.2018.05.31.19.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 19:17:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 9/9] checkout & worktree: introduce checkout.defaultRemote
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
        <20180531195252.29173-10-avarab@gmail.com>
        <20180531222253.GD26159@hank.intra.tgummerer.com>
Date:   Fri, 01 Jun 2018 11:17:46 +0900
In-Reply-To: <20180531222253.GD26159@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Thu, 31 May 2018 23:22:53 +0100")
Message-ID: <xmqqlgbz9rn9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> I considered splitting this into checkout.defaultRemote and
>> worktree.defaultRemote, but it's probably less confusing to break our
>> own rules that anything shared between config should live in core.*
>> than have two config settings, and I couldn't come up with a short
>> name under core.* that made sense (core.defaultRemoteForCheckout?).

I do think "checkout" in name is grately helpful.  I do not see why
it is a bad idea for the worktree codepath to pay attention to the
checkout.defaultRemote configuration variable, especially when those
who are discussing this thread agree "checkout" and "worktree add"
are quite similar in end-users' minds.
