Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9940D2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 22:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdBOWWH (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 17:22:07 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35820 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbdBOWWH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 17:22:07 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so6655pfx.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 14:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lNw9kT485UPbwV1gmwaLdUunEEL3v36OIqyrx+4frhg=;
        b=r8btvaJa7NV1vi5CcEbLHaawRGyLWoEUkJQU4aZbU34zYQY8sT3ofok0XQ+K5GMMkm
         8gEkT3CT7E4j5+oXzCAp4jUtKJ5aGF34Tn8XsE9m3KnnRoQMh6APIP2X/ca5BkJ9rss8
         OJ7cZeeMxktFtL7at3JhPeZIqeOLxDO5+H5PU93Nplm8VsUDDpGLyR6NBXcEHc0WhqYx
         nkgoPdeMO3swi6ZnpFU1fG6z81+RUloKO43tY+PucEvd2pQ2/eDteqcmC1HHsm+Tuh/v
         0EhVQl6tk/oLcx1Q0D88kLhZf7OfjJeT0h3hQyftG75kJ0h98T/Z6OIDY6tBmjS72UcJ
         m2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lNw9kT485UPbwV1gmwaLdUunEEL3v36OIqyrx+4frhg=;
        b=ACMCoIYH5CYddXmGYkIzcA0+349Fd9V/TLbN1O3I62Ak94H4TuZe4vOdZDBVOLM9F5
         TLcAzSTNEWrKBtW0vYcxhAxqX8PMWCZ87GO4uIiJOgfP4hrt/qOhlORQTZDaEfJjW40T
         E0R8nXNoJan6S1Upgq3gTZobPywk9hCCK5UkeEToNRCU6Nm9MDF8ByMcIieeJ7TACMtT
         lP+wiQPhX6uAmXiOrJGKQ0/W3TvZJR+Wwv/EA+aa7J4BVF7SaGVj6CFfuPDD9Tq9GItO
         kyti5BtDqECmvhO3eIvlq2htVjCGHuubHqqqriB2swx8tK9DKg7OahwtY7Wp8zoo+3KN
         cIww==
X-Gm-Message-State: AMke39lEeRclgC8dENUnl3u69TrxQ+XONRBuaLa6nYBowYCePtaOyz/Li0omx/gYXnGy5Q==
X-Received: by 10.98.84.193 with SMTP id i184mr40225643pfb.27.1487197326089;
        Wed, 15 Feb 2017 14:22:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id h14sm9391129pgn.41.2017.02.15.14.22.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 14:22:05 -0800 (PST)
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
Date:   Wed, 15 Feb 2017 14:22:04 -0800
In-Reply-To: <alpine.DEB.2.20.1702151332540.3496@virtualbox> (Johannes
        Schindelin's message of "Wed, 15 Feb 2017 13:48:46 +0100 (CET)")
Message-ID: <xmqqbmu32iyb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
> ...
> The hat of a person who sees how patches are reviewed before they enter
> pu/next/master/maint of git.git.
> ...
> make sense. This makes my life harder, but I believe that the alternative
> would be *not* to have those patches in git.git *at all*.

You wrote a lot, what you wrote were readable, and perhaps were good
material to support your answer/conclusion, but you forgot to answer
a simple question I asked.  I think your description of where things
currently are would support any of the possible answers below, and I
cannot guess which one it would be.

The question was:

    Is our position "unless you are extremely competent and are willing
    to cherry-pick missing things from Git for Windows tree as needed,
    we recommend you to build Git for Windows source instead"?

Or is it "please ignore upstream and work off of Git for Windows?"

Or is it "please try to work with upstream and if you find Windows
specific glitches, after checking to see if Git for Windows has
already a fix for it and otherwise feed your fix to Git for Windows,
so that we can upstream your fix for you, together with changes from
others"?

Or is it "please try to work with upstream and if you find Windows
specific glitches, after checking to see if Git for Windows has
already a fix for it and otherwise upstream your fix, so that next
pull from upstream into Git for Windows would have your fix"?

Or is it something else?


> FWIW I wish it were different, that git.git's `master` reflected more
> closely what the current Git for Windows version has.

Well, we two wishing the same thing together without doing anything
else would make it happen.

As an experiment to see if our process can be improved, I've been
meaning to suggest (which is what was behind my "question at a bit
higher level" to Hannes [*1*]) asking you to throw me occasional
pull requests for changes that are only about Windows specific
issues, bypassing "patches on the list" for things like a hotfix to
js/mingw-isatty [*2*] and use of OpenSSL SHA-1 on Windows [*3*],
essentially treating Windows specific changes as "a sub-maintainer
makes pull requests" we already do with Paul, Eric and Pat.

Interested parties would instead see only the pull request sent by
you to me, either on the list or directly CC'ed to them, and do
their own fetch to assess if it is a good idea for me to actually
pull.  Suggestions to the changes from bystanders like Peff's
comment [*4*] may need to reproduce the patch text when sent to the
list, which would burden reviewers a bit more, but they still are
possible.

Such a pull-request workflow would either hide the communication
from the list or force people to go to multiple places (i.e. both to
the list and to GitHub comments) in order to view the whole picture,
and I am still reluctant to extend it to other areas (e.g. a change
that adds "#if WINDOWS" to a more generic codepath), but a trial on
a limited scope may give us a better feel of how well such an
updated workflow would work for us.


[References]

*1* <xmqq60kdev2r.fsf@gitster.mtv.corp.google.com>

*2* <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>

*3* <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>

*4* <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
