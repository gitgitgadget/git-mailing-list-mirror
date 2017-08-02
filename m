Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0BF20899
	for <e@80x24.org>; Wed,  2 Aug 2017 20:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbdHBUfC (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 16:35:02 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:38786 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdHBUfB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 16:35:01 -0400
Received: by mail-lf0-f54.google.com with SMTP id y15so24615941lfd.5
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JbzcgSj3YxD/6XJ6cE4q8NtDCuWkW6EmpP2ir9aLAJ4=;
        b=s5hwiyqq9rXFuDHq3JdJlyifs3SBrSS494+0H9aDKETpATklo8XKzpuVmo0jD2KgeG
         1MceeyCOL2NOjosnjgB2eqJnlfzBr9X4T5t77TMrtXV8AoWpUQBFz8utfuy0V7ymMLG2
         iAfLw3j5Ly0ra8S61UruRuZjg3PxHKnyQ5JzwH5y0Q9uF4zSH/jEuQM0bX/pGlCiIgem
         S38ghc6IbUPf1ww6zSXNAmsQmfjrKnVn1RxxDOHcux4tBz/2KA9qtPKvyfdOj8VzsSNM
         p8DXYKsCyqiL30YDefAYpx56ekTwG1rEXifwdC13IzWdfcEv8FI54w2TvnXkzoZvqdIv
         uqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JbzcgSj3YxD/6XJ6cE4q8NtDCuWkW6EmpP2ir9aLAJ4=;
        b=S8gKeBenZXIR5xQ+BUuHxSXJRjLkj+cHsRzLsy/W0sZ9ytdK7sYCO++tc+16OZVp74
         K+NVEaZdeoPp2XP06VvHul3WnbaaJ2AIAeXmcQz4OlAPPPlH/QqoBCClboiXrNdCpcEy
         5Cx+Vgb2+ftdXnoyDF84Jy0t8kA1Oyx5+WR4avVbbBt0nLt9DStJvGpTJ3aDwClV/TxI
         zVEsTRQ7xdEVhgINg881vL0iq2rikI/Qi4DOiO3ZK/ueExzu4+8Y1mS2rf2ECB4vGo7m
         J4f6Y7YzDJN4QWRTqHLk0Q7dZEqMP7GOQ0Y73riNVsmp8jwt4raEhFSYxjse9Kx8xVIi
         Z0fA==
X-Gm-Message-State: AIVw110SAXH6Z8tBZ30fkDVy9D9AKC8JpQ4nPkJ3XjASnl7RiPmOTxJc
        W5pQPt7IdXNESEFz3A3QsGmhJvvb6DIj
X-Received: by 10.25.204.149 with SMTP id c143mr7120672lfg.195.1501706099849;
 Wed, 02 Aug 2017 13:34:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 2 Aug 2017 13:34:58 -0700 (PDT)
In-Reply-To: <598215C8.4000100@game-point.net>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com> <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
 <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com> <538F6E52.9000009@web.de>
 <xmqq4mzzte2z.fsf@gitster.dls.corp.google.com> <20140606052601.GB77405@book.hvoigt.net>
 <598215C8.4000100@game-point.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 2 Aug 2017 13:34:58 -0700
Message-ID: <CAGZ79kYy3oBvKXNDnBj01AoOz_JMEg409OTOm+rePz2q+14Hdw@mail.gmail.com>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
To:     Jeremy Morton <admin@game-point.net>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Chris Packham <judge.packham@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 2, 2017 at 11:11 AM, Jeremy Morton <admin@game-point.net> wrote:
> Did this ever get anywhere?  If not why not?  It would be very useful to me
> to be able to clone recursively by default, especially considering you can't
> use 'alias' to override the existing 'clone' command.
>

Note that there is 3c548de378 (Merge branch 'sb/submodule-blanket-recursive',
2017-06-13), which adds recursing into submodules to a couple of commands.

clone is not one of them, because at that time I thought you'd want to select
explicitly at clone time which submodules you want. Unlike most other commands
that can recurse into submodules, clone supports a pathspec for the recurse
parameter, such that you can express a fine grained selection of submodules
that you are interested in.

I wonder if submodule.recurse is set if we'd just want to recurse into
all submodules for clone? That may have negative consequences though
as people may have forgotten that they set that config a long time ago and then
are surprised to get so many submodules.
