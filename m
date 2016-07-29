Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A0A1F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 09:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcG2JRT (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 05:17:19 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36617 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbcG2JRR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 05:17:17 -0400
Received: by mail-vk0-f68.google.com with SMTP id r135so2861155vkf.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 02:17:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=qPlNq1Xp/OmgD/PVnAKFxgqfMFqLwbKSNmLBivt7sOQ=;
        b=x9lI7FoFo9Zqb8lSsfRUJ8QcP2AsMrlfA+me/ORtjNurflvYvz9/ordX0Gg5plRXmf
         ZCA3BMN+HtE1QvTnrHs3X3HoImMYppnuSBwOZXBgvIjbrD+nqZNgj3X/Vs3EnsO4Q/mL
         nD4pkUZouFfUQD5cRG6VWMFVOy9OSopQoJJT1LLpElP7Lvhilmjsa2lIuBtRTZJLMBWa
         3mcOcdOu4v8e4vuwMcfBadEtPcwdu8bQGHCQuYYsYw2eAY/FrvrIp6LXBy7dSypQembd
         dRfZavlTwb4bjmy3zBka++6Q+Kp9w9ZuGK4miNjkLmhJyWqqhsWFQUskaz8UFLlY5k2K
         C7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qPlNq1Xp/OmgD/PVnAKFxgqfMFqLwbKSNmLBivt7sOQ=;
        b=SlWhT0zVQ6fqagdxY/OcwXo4SzKhwc/1MU12l8Pa+Nvhjat17+mgBZICRodtqIe5I4
         ypjo4u0R5WkSbRn147e1F6O7Q3i15A3jp4OZLUtpYJGPmpAIQuhBxJIlQTFZIQYf+jfF
         9oKeZw1dBaZCRImbB2QVsxeI3DwhX86S2ecAcccn8Ha/gfiIPrAfyjV6M7AP/feEYC+F
         oeEGvYJsns8+QjlqE1bRaUaJ42EZWeEWqd4LaDGTwq1pWFjCiOaV5RB2aiScwShYwjOG
         xcEVKb38ESoi/foeZlS3FboAaWnqLkThJCBDYPzZy44lqrJ6ZDOVObcwhYUYInPs6de9
         G41Q==
X-Gm-Message-State: AEkooutFGAFPuOi8MyI35x+1W+UytmABp+wQI7nRaqxXxyq6NI/+eX5Hvhp5Nx+7llU/GYvMzbaARzGGVYJm4g==
X-Received: by 10.31.186.77 with SMTP id k74mr15952613vkf.26.1469783836303;
 Fri, 29 Jul 2016 02:17:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.33.135 with HTTP; Fri, 29 Jul 2016 02:17:15 -0700 (PDT)
From:	Dakota Hawkins <dakotahawkins@gmail.com>
Date:	Fri, 29 Jul 2016 05:17:15 -0400
Message-ID: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
Subject: Issue with global config defaults "user.useConfigOnly = true" +
 "pull.rebase = preserve" - "user.email"
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

I have a question which may be a bug (I'm a bit skeptical), but here goes:

In my global .gitconfig, I have "user.useConfigOnly = true" and
user.email isn't set there (I prefer to be forced to set it on a
per-repo basis, as I use different emails for work and personal
repos). I ALSO have "pull.rebase = preserve" set.

An example of the problem I have is with tools like golang (I filed an
issue there, they closed it and suggested the problem is with git or
my config: https://github.com/golang/go/issues/16516#issuecomment-235800085)
that use git to pull in package repos without any real user
interaction. When something like that runs a git pull for me (to
update a package repo) my global config makes it try to rebase, which
fails because git doesn't know who I am.

With golang, at least, there's no help setting-up all of its cloned
repos with my user information in local configs, it's a manual step
and I have to repeat it anytime anything decided to clone a new repo
to use as a package, so it's at least persistently frustrating. Hence
the golang bug, which I think is still a bug because they should
handle this better.

In those cases specifically, I never have local commits that differ
from the remote, so a "pull --ff-only" should leave me in the same
state as a "pull --rebase".

Is this a case of rebase trying to make sure it has enough information
for me to be a committer before knowing whether I even need to rewrite
any commits, and could/should that be avoided? Alternatively (or also)
could/should rebase detect that a fast-forward is possible and prefer
to do that instead?

I would not be surprised to learn that there's something I don't know
or haven't considered that explains why those things aren't really
do-able, but if that's the case I'd be interested to know what they
are (I'd love to go back to the golang people and tell them to re-open
my bug because there's nothing wrong with git).

Thanks for your time, and please let me know if you'd like any
additional information.

- Dakota Hawkins
