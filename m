Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6AD208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 17:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbeHGTor (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 15:44:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34022 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390234AbeHGTor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 15:44:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so15007212wme.1
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gS84pi/CTqqy37wwT1PRPN3X2qKE4DlaFQn1YzREGf0=;
        b=aYlhPAjCYaWMcO/++G7agSWVRlGffuQ4fYMgVAhXRWQskerUeELC5UVC7KSTn3NCbt
         oD+ZOHRPt/TlP7/KK9Y1RW17N1PtLnjOK/6PQCeIuAfDoL8f/zaJq9sZbeO/11wYFxwc
         bByL4r2e9T5Ye+cMNDAIYdsRoiyJAxGWfy67HcGegLul10u5FBJMufA1a9FOw88HleTS
         ZUXAvZEBOw8pmAZlGfkCr8kYkp7qaGMSFWp5bSJmN5TIw7PVAgLDO6Ht5AguxvWzKvmK
         FO/YrDyWd3i7J40xf6LWT5NvTJpLytX596zaVeHvdoAxpK6AOagmLj2GMNjJ0+aPx10y
         wZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gS84pi/CTqqy37wwT1PRPN3X2qKE4DlaFQn1YzREGf0=;
        b=S1xqN0fHH+7P7XpOzwdSIZ0EJ5S1YSMu6jL1kgga3f8Ko71U2LF7GCVRl93LP+H3pM
         wYCKz7tDDi0qhHPKPKjDW3hIGDM5VohWoK74GarQfVVSs2MBQPn0Khh8fd/4SFTieANX
         IFh1OTdbjcaJGuj6dS25j77+Yf08DwNwJMZ8StaIulz85Mce6GtEZ5kDeMQ2ByG0ggkP
         vuuwWkUlSWoUwLA/QGZnfpoy2+Hgnme6H0cAXfnR3cZo/5xN25gdIY54IHd5It8/bFsZ
         G0fp8wOA4DWFRRKknXn/0sQBCIT8nlnhIqpnjVftlENhFYFD445szyLM7n9VmuWo/r67
         Ksrw==
X-Gm-Message-State: AOUpUlHEFr9p2wtIKoufEKaxUGgHlA7GZyjxlUWikiSGsZ9zdzSyKBbm
        xp3YOOPzMgwBpkqDLzBZu3hmAyjK
X-Google-Smtp-Source: AA+uWPzYIA8IRta5qUOuLB3sUUGQTfhifW/+XkgtZ+TkLQuFBnDNHbsz0WTDp9aEl+wtmCApAZvWuQ==
X-Received: by 2002:a1c:87c9:: with SMTP id j192-v6mr2145808wmd.71.1533662964488;
        Tue, 07 Aug 2018 10:29:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h7-v6sm2369682wrs.8.2018.08.07.10.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:29:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCHv3 1/5] t7406: simplify by using diff --name-only instead of diff --raw
References: <20180806152524.27516-1-newren@gmail.com>
        <20180807164905.3859-1-newren@gmail.com>
        <20180807164905.3859-2-newren@gmail.com>
Date:   Tue, 07 Aug 2018 10:29:23 -0700
In-Reply-To: <20180807164905.3859-2-newren@gmail.com> (Elijah Newren's message
        of "Tue, 7 Aug 2018 09:49:01 -0700")
Message-ID: <xmqqo9eekrv0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> We can get rid of some quoted tabs and make a few tests slightly easier
> to read and edit by just asking for the names of the files modified,
> since that's all these tests were interested in anyway.

Technically the quoted tab was making sure that we do not mistake
"subsubmodule" (if existed) as "submodule" we seek, so a faithful
replacement would be to find "^submodule", and "^submodule$" would
be an improvement.  But we do not have paths with confusing names in
these tests, so we can leave it as-is, I guess.

I think 0/5 should fix the real bug you are deliberately keeping in
this patch, from the point of view of organization.


> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t7406-submodule-update.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index f604ef7a72..e2405c96b5 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -579,9 +579,9 @@ test_expect_success 'submodule update - update=none in .git/config' '
>  	  git checkout master &&
>  	  compare_head
>  	 ) &&
> -	 git diff --raw | grep "	submodule" &&
> +	 git diff --name-only | grep submodule &&
>  	 git submodule update &&
> -	 git diff --raw | grep "	submodule" &&
> +	 git diff --name-only | grep submodule &&
>  	 (cd submodule &&
>  	  compare_head
>  	 ) &&
> @@ -597,9 +597,9 @@ test_expect_success 'submodule update - update=none in .git/config but --checkou
>  	  git checkout master &&
>  	  compare_head
>  	 ) &&
> -	 git diff --raw | grep "	submodule" &&
> +	 git diff --name-only | grep submodule &&
>  	 git submodule update --checkout &&
> -	 test_must_fail git diff --raw \| grep "	submodule" &&
> +	 test_must_fail git diff --name-only \| grep submodule &&
>  	 (cd submodule &&
>  	  test_must_fail compare_head
>  	 ) &&
