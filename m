Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2DB01F597
	for <e@80x24.org>; Fri, 20 Jul 2018 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeGTXfs (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 19:35:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33736 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeGTXfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 19:35:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so5242190wma.0
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g5sg7tUPR/piP7acLgW6dnlSlOOLAObalhtvBMpNOJc=;
        b=jao8ck/s0ZYroL3oU6hRcrQzkMJ70nJcWr8l0+EcZwFri3sPHHn8/rxd3zSEjwxWh/
         Bcp92RHLvXQZPp2NksKGEzzuaYLQo5nUvYptVG/cYJp97Prp8bmRoV5JW85s8HsJqEsi
         eaVqbFgANPLFDvvPNssC7196x4HrtPkT4ePUjXe0/K8PocAkPRl+iuG5QcPYAZVC3Skc
         VozfI6VQPUAw8pZnZanXElwQnXQy9m/KqWZIaSMHm216iNyZXKWiSI30hmOapGEQYcal
         7kEv9zQWSr2p84ia4EsNQA0wfUV3duyDMIs7gjnfUo6lZgByeEq9Tkk2oGfwq4YFV4DA
         EB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g5sg7tUPR/piP7acLgW6dnlSlOOLAObalhtvBMpNOJc=;
        b=kFxYN0LF5Ewodd6gQtd8abh0ECZZ1lR06g2Wf13VS6VLMtsrLzUNwDK1p2pROpv+5r
         jonSduhGtEJyrW+8aL5r+oAkElifsifESd5hdHRX4aHtFrNcJhcQvfODoMjCCLci8EHK
         Y/mnbOwJo8mcw8nbPSPDDzoqR05H8bOMEO8XkrytVQm524J40UfdpPG8JSB2f2V5dngF
         pZM9uVMC4DAMfg5X3H/AYhy+SCC4uhMOqfu6WPu5+M/4IbfyfcV3Ih86+GehZbWOkoiL
         vAhXeFytTlT+CmQEPyscqSR2MWV0ULw3YfPlk6CaSDhmqfHz9tn0YqLG6k5H1ThRhIhY
         EJ9A==
X-Gm-Message-State: AOUpUlGwXktV2mr3rq31J/h6CnS8wp4DM1wCgMDNmTcCAkNEt7ZdmwGD
        832W3VyqfaiVd2+C+LeNPD0=
X-Google-Smtp-Source: AAOMgpcuYOSx8uAaVh210cGo+Kad86hqbBH7GsIvnxdeAUly3QioyTDj995fu8yytpflprRXaUjOBA==
X-Received: by 2002:a1c:c289:: with SMTP id s131-v6mr2779239wmf.65.1532126727564;
        Fri, 20 Jul 2018 15:45:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z11-v6sm3903531wrm.94.2018.07.20.15.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 15:45:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller\@google.com" <sbeller@google.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
References: <pull.10.git.gitgitgadget@gmail.com>
        <20180720163227.105950-1-dstolee@microsoft.com>
Date:   Fri, 20 Jul 2018 15:45:26 -0700
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 20 Jul 2018 16:33:00 +0000")
Message-ID: <xmqqsh4d8r21.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> There are many places in Git that use a commit walk to determine
> reachability between commits and/or refs. A lot of this logic is
> duplicated.
>
> I wanted to achieve the following:
>
> Consolidate several different commit walks into one file
> Reduce duplicate reachability logic
> Increase testability (correctness and performance)
> Improve performance of reachability queries

All of these are good goals to shoot at.

> This series is based on jt/commit-graph-per-object-store

As such, it has some interactions with another topic [*1*] that is
based on the same, but my trial merge seems to suggest that the
interactions are minimum and do not pose a serious problem.

Will push out as part of the next integration run, as I've already
pushed out today's.

Thanks.


[Footnote]

*1* ds/commit-graph-with-grafts topic that is in 'pu', slated to go
    'next' soonish.
