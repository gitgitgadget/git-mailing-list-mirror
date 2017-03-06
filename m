Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7416520133
	for <e@80x24.org>; Mon,  6 Mar 2017 18:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbdCFSvo (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 13:51:44 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34922 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbdCFSvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 13:51:42 -0500
Received: by mail-pf0-f169.google.com with SMTP id j5so64003693pfb.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 10:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BSjboCRfZo61+D/urTG1DWEsSbv22AIhYaWq/ovxeak=;
        b=SDEHMqRdqrTIyKViE/5QwProEWhX7NrIST6myPstV8wL5pZM3OrM2J60R917hIMINb
         SIKSA2POLgHS77ZlEZK7YGvQxRqNyS2yoDHxHJqF6kS6MaDLENsbJLYjSJFBnd1AiWRf
         XMgTgNvW+2zcKT1m8XXjO1M0JSArS1XSqoJDmNdIcVl5ldfsCeV/b/dPqxj+FfKKPByb
         od72OnUxb3oT7uJMu+nSu0jJUiOvlYaDAITNhYfq79Kp9h4c3ruITTNnl7dHUxgQY0yb
         26H444IqDXMXJLRACBHImimPiWrU4/dPx++81rsOuj75o7DOI81Kd+1lkCgbEa3Z88mR
         zgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BSjboCRfZo61+D/urTG1DWEsSbv22AIhYaWq/ovxeak=;
        b=ZuasUscrhVLNyO402l7ovUADoT8R+fXRYOJz/PTOkwC5x+3eGxDxwlGtbjKwvHUal4
         j8lb5x5om/CqEPpinuhARBhNsBVEAP2EtoKdBWfS89I/oy/C1jcv7neGNLinT857nLNW
         rZsYvjKC+ekhgPepBxcpGp+B8MtwOZwUmZkgDZHYruycwMOYdp19BMj7c/5xzVqUBjjL
         cQ8E6p/XmbYn8PpgClJP7r7Gb8GTAfBphEb6FWEUFCEq7awultPchEhoUVYfFGQIXWYB
         K5msfv2b2EQ/T6D5gYivb5/suZ2Y7DHvyKcOxWKJzUDTe5XiYZpxVnk2b5U26y2rojIm
         36xw==
X-Gm-Message-State: AMke39kvSHGG01zqxfqcQqgbmQS4nURw5agblFZxpvT8ePZTGdPH6MrEEssJjwweyLET/Bj/
X-Received: by 10.84.146.140 with SMTP id g12mr28107702pla.70.1488826250417;
        Mon, 06 Mar 2017 10:50:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:10a1:c255:c5bd:a65f])
        by smtp.gmail.com with ESMTPSA id e16sm10490430pfb.102.2017.03.06.10.50.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 10:50:49 -0800 (PST)
Date:   Mon, 6 Mar 2017 10:50:48 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 01/10] submodule: decouple url and submodule existence
Message-ID: <20170306185048.GC183239@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170223234728.164111-2-bmwill@google.com>
 <xmqq8tov1ev7.fsf@gitster.mtv.corp.google.com>
 <20170301200230.GA30622@google.com>
 <CAGZ79kb9Fhb0z5AbygBx9wNyLr-ovb-74xeaD8p+C5Xz9Dekcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kb9Fhb0z5AbygBx9wNyLr-ovb-74xeaD8p+C5Xz9Dekcw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01, Stefan Beller wrote:

Sorry I've been slow at rerolling this.  I'll send out a reroll today.

> IIRC most of the series is actually refactoring, i.e.
> providing a central function that answers
> "is this submodule active/initialized?" and then making use of this
> function.
> 
> Maybe it would be easier to reroll these refactorings first without adding
> in the change of behavior.

I agree, when I resend out the series I can drop the first patch so that
the series as a whole just moves to using a standardized function to
check that a submodule is active.  I can then resend out the first patch
in the series on its own so that we can more easily discuss the best
route to take.

> 
> Off the list we talked about different models how to indicate that
> a submodule is active.
> 
> Current situation:
> submodule.<name>.URL is used as a boolean flag
> 
> Possible future A:
> 1) If submodule.active exists use that
> 2) otherwise go be individual .URL configs
> 
> submodule.active is a config that contains a pathspec,
> i.e. specifies the group of submodules instead of marking
> each submodule individually.
> 
> How to get to future A:
> * apply this patch series
> 
> Possible future B:
> 1) the boolean submodule.<name>.exists is used
>     if existent
> 2) If that boolean is missing we'd respect a grouping
>    feature such as submodule.active
> 3) fallback to the .URL as a boolean indicator.

Thinking on this, and to maintain simplicity and uniformity, we could
have the per-submodule boolean flag to be "submodule.<name>.active"
while the general pathspec based config option would be
"submodule.active".

> 
> How to get to future B:
> 1) possibly take the refactoring part from this series
> 2) implement the .exists flag (that can solve the worktree
>   problem, as then we don't have to abuse the .URL
>   as a boolean indicator any more.)
> 3) implement the grouping feature that takes precedence
>   over .URL, but yields precedence to the .exists flag.
>   (This would solve the grouping problem)
> 
> By having two different series (2) and (3) we'd solve
> just one thing at a time with each series, such that
> this seems easier to understand and review.
> 
> The question is if this future B is also easier to use for
> users and I think it would be, despite being technically more
> complex.
> 
> Most users only have a few submodules. Also the assumption
> is to have either interest in very few specific submodules
> or all of them. For both of these cases the .exists is a good idea
> as it is very explicit, but verbose.
> 
> The grouping feature would help in the case of lots of
> submodules, e.g. to select all of them you would just give
> an easy pathspec "." and that would help going forward
> as by such a submodule spec all new submodules would
> be "auto-on".

And if you wanted all but one you could have submodule.active="." while
submodule.dontwant.active=false instead of having a multi value
submodule.active with an exclusion pathspec.  Both work but one may be
easier for a user to understand.

> 
> Possible future C:
> Similar to B, but with branch specific configuration.
> submodule.<branchname>.active would work as a
> grouping feature. I wonder how it would work with
> the .exists flag.
> 
> Stefan

-- 
Brandon Williams
