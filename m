Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E588FECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 11:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiISLA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiISLAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 07:00:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A843E0F0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 03:59:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e17so40696551edc.5
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=1gJGuL23cF7XfD6fFg6Y1Mf4vzcvNQgu4aKI5d9ZsKw=;
        b=Qm9GKAvZJJkcadYBHpXIvEoc+J2U+s1uM4GDMVwxkbKmyfiRx1uAXkxmf60Dtff4Sq
         gwnPOuHfz1erjF8hekE7U0sVBFvaHUzzxkFH6wFIaXevDt5fzGOtQSaeiFx1WdOZW4E6
         5PWHituBjpEZrTXEA2kK3HPvcqKlW8YTZYyzE8qJbgSlgYivmhmwGn/D6bGZ0mExT7ag
         yxC9Zqjgn9BMW0T2A4HcbYs1c7li8g+aXq5W+IhdujSq+wI3uIY/OqG/ZRVxZ6Eeo8mQ
         g9Zvw31ccUhv05I/K2q3vTrlDRGT2YXnQ5fG5oVGqU600PTj3A0/SbYwFnSLcx810b1v
         Tfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1gJGuL23cF7XfD6fFg6Y1Mf4vzcvNQgu4aKI5d9ZsKw=;
        b=VqxU50fH9VOTwKLsSmHZsSchorrpbbGx/Atusi6ExSAvNgDOIrMOM40mghF9BA7am2
         XBxUOn1kvGmZ+65D7bRA2vJbpKvzmBYnkjo/St0e0EEYFfFYecy4llcb44gQLehyCt2G
         TMuiiyMouoiCFS2j/LC6ePMKBHKsU7v3JGbV9sKfm8S7MU2KXt40M/EIulcV2HOmuL2M
         lnZzAzIi+z4lEK2jZ8TWRt4LV0urwyE67mTwKtDKsFKoym9NoObGO02ZVXgxYj/tPPER
         bfPkbITVuxYjcBFNAuXAXiMa5SoevQhYUEN2YrkoojOy8r9CeJdvcpXdyVpGz1SJokVy
         wHHw==
X-Gm-Message-State: ACrzQf1ouCQIf8L8r+qd3maXQAZ8otvywoq8HMQZdZaENKkx/AoYKORK
        Pkj0/pt44ya9zIF0Ro0kaEdkm5C/l+o=
X-Google-Smtp-Source: AMsMyM6EH51uiPWLENefDGPfUtVGHCZitHNgDwtuJk8AmzMDzAgRcMKL+wQKMXvrtm6cWbKp2xyN1A==
X-Received: by 2002:a05:6402:27c8:b0:451:440a:2f48 with SMTP id c8-20020a05640227c800b00451440a2f48mr14772225ede.1.1663585146391;
        Mon, 19 Sep 2022 03:59:06 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fs32-20020a170907602000b007707ec25071sm15380178ejc.220.2022.09.19.03.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:59:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oaEUS-000bEu-34;
        Mon, 19 Sep 2022 12:59:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Skrab Sah <skrab.sah@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: what if i use makeheader tool to generate c header file, it
 would be accepted.
Date:   Mon, 19 Sep 2022 12:45:06 +0200
References: <CA+J78MWhp3qmbBhhSoioJP+d5eh-iEd_vHZdTNB69o7EvvXWYQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CA+J78MWhp3qmbBhhSoioJP+d5eh-iEd_vHZdTNB69o7EvvXWYQ@mail.gmail.com>
Message-ID: <220919.86zgev635z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 19 2022, Skrab Sah wrote:

Just sending a $subject is rather light on details, so I'm having to do
a lot of guessing, but here goes.

In case this is a genuine "prep question" that you're asking in
wonderining if you should even waste time on coming up with a patch to
do $subject I want to say that:

- Yes, this project would definitely be interested in the general topic
  of "fixing our headers". E.g. as I noted in passing in [1] (and this
  is just a case I happen to remember) we have obviously "bad" cases of
  headers being included when they don't need to that e.g. the iwyu tool
  spots.

- I think it's *very unlikely* that a patch that just drops in some
  external tool to generale a bunch of our code or headers would be
  accepted without a very strong case being made for its advantages.

Now, this does *not* mean that we're not interested, but just that we're
very big on a "show your work" approach to things.

So I'd think that you'd want to pursue a more incremental approach,
e.g. are there cases that makeheader spots now that can be looked at and
turned into patches? Can we perhaps get to a point whene we can run
"makeheader" in CI and spot changes that make header definitions
obsolete?

I think you'd also want to look at some prior art in this
area. E.g. COMPUTE_HEADER_DEPENDENCIES is something we use to get a
"perfect" dependency graph of headers right now.

I'm not sure how that overlaps with the makeheader use-case, but any
patches in the area should aim to review related existing work & tools,
and how a new tool is better, or fills in previous blind-spots.

For those trying to follow-along, this is the documentation for the
"makeheaders" program (which I've only skimmed, and I haven't yet used
the tool): https://fossil-scm.org/home/doc/trunk/tools/makeheaders.html

I think the biggest problem with our headers is not that we over-do
interface definitions sometimes, or that we miss some includes, but that
most things genuinely end up depending on git-compat-util.h, and
cache.h. The latter of those is a big bag of random unrelated
functions. It would be nice to split it up, so that if you e.g. need to
change just one function in cache.h we don't need to re-build the entire
project.

But that "biggest problem" isn't so big, it's only something people
working on git find occasionally annoying, and ccache mostly mitigates
it...

1. https://lore.kernel.org/git/220825.86a67s4e6r.gmgdl@evledraar.gmail.com/
