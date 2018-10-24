Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90741F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeJXLka (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:40:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45208 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeJXLka (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:40:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id n5-v6so51202wrw.12
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 20:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3xM14t30W8kyhq3CX9BspUzv7Iulb1E1l644SUDr2Mw=;
        b=gBqErLLW/dKoSvyQN7XaKZdvWRnCUWQZsaULV1F1y8GFBM154LVFsWA28rFTeHkqqt
         uUo0CdF3fU/Zwh8Tg9v2YAI2gSBznEnzXxMs85LhW0GxZNgCrU38U3eUyDvjPWxRSMKA
         XyjUUpgmIXnZurXalhFE6U3mFbYoJ3C9ssMVV5+hxRQ+KV5zg47dGJ7mwh5CbbcHdMA3
         5kGEHVdGY2Y2zofPTfGS1jDEGe7Ear6NzvT+UFnkQQiWS0op6QYlSH/WahjUEHcaPeFW
         0zjHECZ9EL9SG7WdW51KzBCONBYVyemMeBtSbilXHbgLFxXvbKt7VJG2rkmGNFgQ5DNO
         hktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3xM14t30W8kyhq3CX9BspUzv7Iulb1E1l644SUDr2Mw=;
        b=ti6PN9pQB5045FdlaLmRpg/jsQlBublIDsfH7OHNCaeOLcdD9F7oIeBckJ/YnGuRAA
         D8uuMhHDrJVAsBkYZJxaWiDBR742vvvMzzPVhSeogSYB+1ww1D4rRM3DBD5rq8KvQVCY
         7lI9TJK/cyteWmU4wAUAPtqLn3OOIRWLLfFCRSsmFwWrDwux/kU1RzSbJOato18BfdT8
         3n2A6zGu62erfreP56CDiop9CTdplLjCJxWqq+ex1vFniEYMNF3Fm/WlfOScQfinGUeD
         n+xddnSCCWfQS4L/Umi4BK7LXmEZYKhNQrU972ZwJkZJECSm4Q2Tc/3brHCmAZ3S8QbY
         KOaA==
X-Gm-Message-State: AGRZ1gKtWQZDrEv42j6Ws0DOgUtY9kMH1bnH0sOzSDTD+mkQdDbl+MPw
        Ro6bugwG20W2Ld+qo55MWmrVNJ+p3NE=
X-Google-Smtp-Source: AJdET5eNLsjBNBun4hTblmuJkKuQfZT26kKjokiD58ILvrPaf5xrfgMGTAQw9/JGKoHxlxj71vyx1w==
X-Received: by 2002:adf:e588:: with SMTP id l8-v6mr607128wrm.269.1540347172752;
        Tue, 23 Oct 2018 19:12:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p1-v6sm3017691wrw.12.2018.10.23.19.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 19:12:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        lucas.de.marchi@gmail.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
        <87in29dj55.fsf@evledraar.gmail.com>
        <xmqqmurkgaap.fsf@gitster-ct.c.googlers.com>
        <20181023140710.GA7073@ldmartin-desk.jf.intel.com>
Date:   Wed, 24 Oct 2018 11:12:51 +0900
In-Reply-To: <20181023140710.GA7073@ldmartin-desk.jf.intel.com> (Lucas De
        Marchi's message of "Tue, 23 Oct 2018 07:07:10 -0700")
Message-ID: <xmqqh8hcqeho.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lucas De Marchi <lucas.demarchi@intel.com> writes:

>> Yes, I agree on both counts (i.e. it was totally unclear what
>> problem is being solved and what the root cause of the problem is,
>> and we would want a new test to protect this "fix" from getting
>> broken in the future.
>
> have you seen I sent a v2 with proper test?

No, otherwise I wouln't have said it needs tests, and no, because I
haven't seen the v2, I do not know if it came with proper test or
other issues pointed out and fixes suggested in the review round
were addressed in v2.  Sorry.

When you ask such a question, please accompany it with "this is the
message-id" to avoid the receiver of the question locating a wrong
version of your patch from the archive.

Thanks.
