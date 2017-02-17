Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B04201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964980AbdBQXtq (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:49:46 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35764 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964905AbdBQXto (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:49:44 -0500
Received: by mail-pg0-f67.google.com with SMTP id y6so4921581pgy.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mF75eUYQ0nXzxFf5/3ACr1abye9PWP1lSKTXjlJ62hg=;
        b=OVD4sPGjNcy0EmiVd0Ao2aMnUWugfiQNMd3aBpKgzutITQ01zlelZ00tXsZm6IDvTS
         m7dylOgnvi09QOaHRR7ufYjIMNlUhAKX++oecrOgOZFRoVByZSFo7TyqvSKIHcjCizsJ
         Mt74ins8TBWDqX/x2cgIS//ohl8Aq9DaPD6YN4JglTZKD0g82OrNFYbKmTJ1buurGYbs
         XetCG8+Brn1bOk1/uKwM35Njbk70jstyJRX0tR0ES7vAeH+wGL/a3sSii23Qrkthjqsc
         3AgXiayXjKZuSmjYSRFq5OWVIwQln8rGFbhTVWurme4l/NaoyQ+LN8hyRDkIhEDjK+OV
         +Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mF75eUYQ0nXzxFf5/3ACr1abye9PWP1lSKTXjlJ62hg=;
        b=TFQ8iUF58DFFxWhi69IAe+vMF9SvOc4QCZ1Hw4B8OkjQwkHqdnt1zgl4a+IyjK48pz
         EI0hj6WR4Kk+zH6uDsak4kNaPLaxNnFcSZwncm5WRw0EaAvA1L5c3AwgOiY5zPppSilO
         dfRYYYmVbITargoX0Y/f6LwnvFwFYKofismxGNP4gLtLujzMETy7fGRoh7bxiAU+eYWz
         xV/sAh3G1i/s2Ff+FiLlWzXdDitNKIjGGG50fN5R/PwBCEnqTkySl1fthZaf+tfN8P8v
         lKJNdU037R4mQBHZKcTdH6djTwM2PtB72mABHmWrN9FPPYaIj8vSxkNppOY1WyW2wiHW
         Zhxw==
X-Gm-Message-State: AMke39lbLqARwJg9pREDvj+ytk6+Qh/XN5OvxirUOQn5SB4WsgH/oNzhLnkzAvd6aKf0LA==
X-Received: by 10.98.1.213 with SMTP id 204mr12285009pfb.61.1487375379015;
        Fri, 17 Feb 2017 15:49:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id m21sm21711496pgh.4.2017.02.17.15.49.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 15:49:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
        <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702141545380.3496@virtualbox>
        <xmqq37fga9rn.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702151332540.3496@virtualbox>
        <xmqqbmu32iyb.fsf@gitster.mtv.corp.google.com>
        <xmqqlgt7110q.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702171626160.3496@virtualbox>
Date:   Fri, 17 Feb 2017 15:49:37 -0800
In-Reply-To: <alpine.DEB.2.20.1702171626160.3496@virtualbox> (Johannes
        Schindelin's message of "Fri, 17 Feb 2017 17:00:36 +0100 (CET)")
Message-ID: <xmqqvas8nzse.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... there is a different problem here: you stated very explicitly
> that it is okay for `pu` to be broken [*1*]. If it were different, if any
> breakage would imply that a fix is really, really required lest the patch
> series be evicted from `pu`, we could easily modify my Continuous Testing
> setup to report more visibly what is broken.

I think you misread me.

Regarding 'pu', there is a chicken-and-egg problem involved.  Most
of the days, the tip of 'pu' passes the test at least for me.

At the end of day's integration cycle, I may find that 'pu' does not
pass the test for me [*1*].  It is not unusual to see new multiple
topics come to 'pu', each of which may test well in isolation but
have hidden interactions with topics already in 'next' or 'pu' that
are exposed only when merged to 'pu', and it may be too late in the
day for me to find which one of these new topics is problematic.

I could choose not to merge any of them and push 'pu' out with no
new topics.  Or I may choose to push it out anyway, so that other
people who are working during the remainder of 24-hour in different
timezones can notice and find which new topic is broken [*2*].

And that is why I explicitly say that 'pu' may not even build.  It
shouldn't be taken as a discouragement to people from looking at it,
which seems to be how I read you to misinterpret it.  It is the
opposite---a breakage at the tip of 'pu' is an invitation for people
to help.

If nobody steps up and says "the tip of 'pu' does not build and that
is because of this topic", I'd be irritated enough to find which
topic is broken myself and then ask the author of the offencing
topic for help.  If the topic is left broken after that, it will be
ejected from 'pu', because I cannot use 'pu' for helping to polish
other new topics that wants to cook there unless I do so.

Of course there are platform- or environment-dependent breakages
that would not cause my tests to fail [*3*]. Again, people with
different environment can step up to help, if these topics are
included in 'pu'.  You would recall that you called out one topic
[*4*] that did not build in your environment and the topic was
ejected after your message (but not before---there wasn't a way for
Window-less folks to tell that it was broken IIRC) from 'pu'.

In a near-by thread, somebody wondered if we can add an integration
branch 'pr' that is beyond 'pu' and includes everything ever posted
to the list, and I explained why I won't have time for that.  But I
think the spirit of suggested 'pr' is what 'pu' already is---it is a
collection of promising topics that can be merged into a seemingly
consistent whole, which may or may not build and the purpose of the
branch is to contain them in one place so that people can find which
ones need unbreaking.  Testing the tip of it alone and complaining
that it is broken does not help much, but figuiring out which topic
merged to it is broken does, by unblocking other topics in 'pu'.


[Footnote]

*1* If any other integration branch (including 'jch', which is
    somewhere between 'master' and 'pu' and beyond the commit with a
    tree that matches 'next' aka "pu^{/^### match next}") does not
    build, I pull overtime ;-)


*2* When there is only a new topic that breaks 'pu' for me, it is
    easy to decide not to queue it and send a note to the author of
    the offending topic, and that does happen a lot, but not always.

*3* I do not have p4 and I may not have svn installed so my tests
    may not even cover them.

*4* I think it was nd/worktree-move but may have been another topic.
