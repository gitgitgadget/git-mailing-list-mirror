Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D73207D2
	for <e@80x24.org>; Sat, 24 Jun 2017 00:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754809AbdFXAv2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 20:51:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34574 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754075AbdFXAv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 20:51:27 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so9583701pfe.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 17:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KFU6vywADW4Vpx+x7lzLB0Q5F7jJSLY4JUbmw4lyMgM=;
        b=uc/Z6FuMSTva24mesePM4Jy18jRhxjBBI4EAeI3utoPBWna0V9YFvbjonyJFO9MjDh
         VsR9RYZ1YSEBYlbw6OULBwOsJljNBodD4TDybAmh15TVmIpVWon+Xsp0P1jHYWZkD84X
         BAW42xwLUGCJPeZQj/HNyXpbLnaO3rn5E5BAgs0AsPl/4a7wRmwaqFCgshRrioKqF7vS
         4vJyXWFLoirT0gzaR/xHwhtqqEP/Rd6ncwVutGX0UnHJmg9QrsUgDONYTgi7GAbx2+J9
         nwONLe4CkCcl3SX4n7QtnAXmW+JllrZupMafRuzY/X5H3tZ0bUA8hfef64+JuJYd+eM3
         qmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KFU6vywADW4Vpx+x7lzLB0Q5F7jJSLY4JUbmw4lyMgM=;
        b=JfBk2UcjDqL1h2xhkYz43tRsKSETgBzVjwLUj9rk9B3r7NMG+RzZwaOYxKedLyj5z3
         FMDSxM/YgcEYzRTBlfGCnBYQde3mxbvX9gwwRXC5zMmmnjDrY60RPAwJ1kwRR1/uQhxE
         3bsErVmemA1jqpaaxL5LJnf24pLnNZDYGepfkbYQBuQJ3EG/emaxbt2QP0TcJl3Ad40V
         P6T/yy4KvENtllACPjFICRMHVEWybFqgzT5h9EnTuGVjtgVgMq+fmxiGhGXpxDuOa4te
         nmolOf9rasKnSwbdlsIQ+jRa82+RKGvFZhaa8Pj9J/6l+yUe7Qv8nSpGwSB13l4GOir7
         FKcA==
X-Gm-Message-State: AKS2vOxdnbp7+2xO+nTTEJEf9K3H+PIcCoRumvZWzBy0Ife4XxgBFrFg
        cO5FQUAbVrLgdg==
X-Received: by 10.98.141.134 with SMTP id p6mr10991228pfk.68.1498265486981;
        Fri, 23 Jun 2017 17:51:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id r83sm12078467pfk.57.2017.06.23.17.51.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 17:51:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 2/3] builtin/fetch: parse recurse-submodules-default at default options parsing
References: <20170623191302.16053-1-sbeller@google.com>
        <20170623191302.16053-3-sbeller@google.com>
        <xmqqo9tebaco.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka+va5bRNQL3x3fvn+738iAfJXJfD2PKpt2hmGEg09mTQ@mail.gmail.com>
Date:   Fri, 23 Jun 2017 17:51:25 -0700
In-Reply-To: <CAGZ79ka+va5bRNQL3x3fvn+738iAfJXJfD2PKpt2hmGEg09mTQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 23 Jun 2017 15:49:54 -0700")
Message-ID: <xmqq1sqab436.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>>       if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
>>> -             if (recurse_submodules_default) {
>>> -                     int arg = parse_fetch_recurse_submodules_arg("--recurse-submodules-default", recurse_submodules_default);
>>> -                     set_config_fetch_recurse_submodules(arg);
>>> -             }
>>> +             if (recurse_submodules_default != RECURSE_SUBMODULES_DEFAULT)
>>> +                     set_config_fetch_recurse_submodules(recurse_submodules_default);
>>
>> This is not a new thing, and it may not even be a problem, but I
>> have to wonder why this needs to be done conditionally.  "The
>> ...
>
> As far as I suspect, the original author considered
> evaluating the additional config too expensive.
>
>     gitmodules_config(); // <- this specifically?
>     git_config(submodule_config, NULL);
>
> And that is why we only react if any switch is
> given to recurse. 

I am not talking about the outer "if" condition.  

The inner 

    "if (recurse_submodules_default != RECURSE_SUBMODULES_DEFAULT)"

block, is what I am questioning, i.e. I am wondering why
set_config_fetch_recurse_submodules() need to be conditionally
called.

The two statement you quoted above will be executed either way,
regardless of the value of recurse_submodule_default.

Unless --recurse-submodules=off is given, in which case the outer
"if" condition rejects.  And I think you are explaining that part,
but that was not what I am questioning.
