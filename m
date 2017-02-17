Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA693201A8
	for <e@80x24.org>; Fri, 17 Feb 2017 01:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932090AbdBQBZp (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 20:25:45 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35433 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbdBQBZn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 20:25:43 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so2790455pfx.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 17:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+NwTZlNfz8n0eWnRR5dwecjzJ/xobF9ipYkAO1KYrFc=;
        b=jNq3nPAjJ56hwRJqslj1SqPIvmbfgu2/lfxBRI57yotyyURWqh6YgUriPwL9cMEWFt
         bNGMU/xyJH8NqgXmlFwqU9Z5wAq2cABy84Xz6EDWATI3IYCsiGpX7yBhBf5ZmV4t7eHx
         g/LWa0rbnT1OIhMQmkJq5Dx5/XXUBf3yunyVr4Z20k57FhseJOPg2sEU5hwG5Qzc4X2n
         BXY68hyAGG5wWRcFNt3a2iDe1M6U1HDk+S2PeaJNY4RVDMfaKsJxTY1/YITKAy1A2i8U
         UGXuRva/uUhpTvyUJ87xdEdjIcQpSON8znPFfkuvs96ayY4JdZqtX26mkEq2fS+eT5is
         oLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+NwTZlNfz8n0eWnRR5dwecjzJ/xobF9ipYkAO1KYrFc=;
        b=PuOqNa2yDv8yghy1cYSM1Z9+9wDjKggs2otIQtqBKb98oKB5jDRwqjBqSToNJw/gSH
         QHUb3lyuP0x67fjnQfsLaecZ2J7zBlUOkbYHpPAaacWMOxzS7ovbmGda7KUOw5N0d6YJ
         2XRY9xtLTSg6pkutb75nWhofs1uXjFFLJfys5egkhxM1cpRkU86fWQHUwoFvQaDQWDHE
         mZoEcoh1Yrzv9DnEdxAZuqPkSzsGTf0vKxvyspVFnqWzrCPbybcN3nfyi5R7x/AI1XO0
         QzQoab/QXMTCJmQX7J/C7H8Cn8Rv/8oq5ZW0dsLRtOXWQT7t8jRALQ8QbJPGHQ0yX1oi
         osDQ==
X-Gm-Message-State: AMke39mezDRIellYH2tyvnLdkRDGL4pS26lSFxL1vH1siirsFsz1gifhUp7wlFbDetBPyQ==
X-Received: by 10.98.153.25 with SMTP id d25mr6276366pfe.15.1487294737833;
        Thu, 16 Feb 2017 17:25:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id e13sm15803393pgf.48.2017.02.16.17.25.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 17:25:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH] config: preserve <subsection> case for one-shot config on the command line
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
        <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
Date:   Thu, 16 Feb 2017 17:25:35 -0800
In-Reply-To: <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 16 Feb 2017 18:27:30 -0500")
Message-ID: <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Feb 16, 2017 at 11:30:28AM +0100, Lars Schneider wrote:
>
>> 
>> > On 16 Feb 2017, at 00:48, Junio C Hamano <gitster@pobox.com> wrote:
>> > 
>> > The "git -c <var>=<val> cmd" mechanism is to pretend that a
>> 
>> The problem is also present for gitconfig variables e.g.
>> git config --local submodule.UPPERSUB.update none
>
> Hrm, is it?
>
>   $ git config --file foo submodule.UPPERSUB.update none
>   $ cat foo
>   [submodule "UPPERSUB"]
> 	update = none
>
> I could believe that some of the submodule code may try to pass it
> through "-c", though, so certain config ends up being missed.

You are right.  

The builtin/config.c::get_value() codepath, when it is not using the
hacky regexp interface, uses config.c::git_config_parse_key(), and
it does the right thing.  git_config_parse_parameter(), which is the
broken one we found, is not used.

When I did the patch in response to Jonathan's observation, I did
briefly wonder if it should be using git_config_parse_key() instead
of doing its own thing, but I didn't follow it up fully before
deciding that it is the quickest to replace the tolower thing.  If I
at least tried to see if it is feasible, I would have noticed that
the query from the command line wouldn't share the same problem as
Lars reported.

I still haven't queued any of the variants I posted (and I do not
think other people sent their own versions, either).  I need to pick
one and queue, with a test or two.  Perhaps after -rc2.  

Others are welcome to work on it while I cut -rc2 tomorrow, so that
by the time I see their patch all that is left for me to do is to
apply it ;-)
