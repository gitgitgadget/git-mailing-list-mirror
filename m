Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD551F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeCWVQN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:16:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55529 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWVQM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:16:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id t7so5895625wmh.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VB+dh6ER8KtsMbHdjGC8b+gkkH53yAU5nzzfAdzLrG8=;
        b=PHWUnhQvjdW6DrxPN6VdHWsq/qPXIBoF+mTUDiGc2R7kz1Fdg9PPZ6oRXs70tyJiJf
         O6S9GfytOkDu7VJgyubnfnv8mpYd9oX1fmMrnjsZAFH8gl/nB5hwn/nd+PuJEYZd38q5
         kEX8hH+rgSGrWnfm+m6k72xU2f6+foN6qXbcRXgNxX46owTzwWk2gSStGixQKeYuHf1B
         ST+73T2XcGO8TS4tMZflvWZ3SVoimUs2AjN2yyGXiu0E9qixKmug6oh+4wQUpuPblOjI
         47HroPwKVQy8pYFgt1nDx1/wFEre1iup0rcvEVItPVrRYOwt8KBIum/MZG2Jd6FdsauA
         PLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VB+dh6ER8KtsMbHdjGC8b+gkkH53yAU5nzzfAdzLrG8=;
        b=Y0otPSYfIC/gH7C09B6K2vrBYJu4JuZpS9oa3H2GPusoJ/svucFU/ve/+niDR516pI
         9yMTs6oqfTlhsYEpeLw9zeDyhy/CbeRoE0HWZ5AaPTYSB39w8KzU+JoYa0sfcYc5VIbG
         0Ose9q4Hlv0yWXBDjlDRYwYpIYrOtodALGhoB3SEtQqTyDpqf6cGLfGM5qXM2aYgYaKR
         JCy0SfWSz93+cyFZylYD0CUiOWGa9SEfXxNgXkIDao7KBtmdCHeTP2+OGmzG8Y5BDW8i
         lYh7YmzQamgNabGULSEGwe+P27CXJWkBzTXETRIZB+QLfHeOfQeRh1t6vzwCxGz9XLID
         CWpw==
X-Gm-Message-State: AElRT7EtNkXAu4abq2EaVu69Y0V7z7Wzuef9nZa5BoIQ6XL80+sC5YGa
        UeiNVh6UBfwTP8qY3N3i8GZ0G3c/
X-Google-Smtp-Source: AG47ELs8UTgYNGE6D56V0ReBfg7T92DOx5iUhjRrYZPv4jiWYk4/SRsfOk8mhijrMI9BQaxwrrqcDA==
X-Received: by 10.28.195.67 with SMTP id t64mr6410441wmf.113.1521839771107;
        Fri, 23 Mar 2018 14:16:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t142sm3553303wmt.12.2018.03.23.14.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 14:16:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v1 0/2] perf/aggregate: sort result by regression
References: <20180323140007.12096-1-chriscool@tuxfamily.org>
Date:   Fri, 23 Mar 2018 14:16:09 -0700
In-Reply-To: <20180323140007.12096-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 23 Mar 2018 15:00:05 +0100")
Message-ID: <xmqq7eq2ijc6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This small patch series makes it easy to spot big performance
> regressions, so that they can later be investigated.
>
> For example:
>
> $ ./aggregate.perl --sortbyregression --subsection "without libpcre" v2.14.3 v2.15.1 v2.16.2 p4220-log-grep-engines.sh 

Are we comfortable with the idea that other kinds of sorting, when
invented in the future, would have to say

    $ ./aggregate.perl --sortbysomethingelse --subsection "without libpcre" \
        A B C p4220-log-grep-engines.sh

or will we regret that and wish if we could write it as

    $ ./aggregate.perl --sort-by=somethingelse --subsection "without libpcre" \
        A B C p4220-log-grep-engines.sh

If the latter, perhaps we should use --soft-by=regression from day one.

Do we expect that "taking a lot more more rtime than the previous"
will stay to be the only kind of "regression" we care about in the
context of t/perf?  If so, there is no need for further suggestion,
but if not, perhaps we should plan if/how we could also parameterize
the "rtime" part from the command line.  E.g.

    $ ./aggregate.perl --sort-by=regression:stime

might be a way to say "we only care about the stime part" in the
future, even though --sort-by=regression may be a short-hand to say
"we care about rtime regression" i.e. "--sort-by=regression:rtime".

