Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111E31F406
	for <e@80x24.org>; Mon, 14 May 2018 22:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeENWIE (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 18:08:04 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:50596 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeENWIC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 18:08:02 -0400
Received: by mail-it0-f52.google.com with SMTP id p3-v6so14278322itc.0
        for <git@vger.kernel.org>; Mon, 14 May 2018 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Goj3g0sCNvd+7qe6cDkBOdPVaI+cqmhurmWznjrfr/o=;
        b=LxUkqrkDM96lTADsLmeNmIyWA6lKo5aIGdgirB7lS7lHXPp79CFi2B8jt7gSU8Fm0c
         jxc4psDRM/lQOOW+dymfCFAMslrw4VCn/Horl7LGjWFEZeDPWWk3wshFmCckkfNpRW+G
         fzZ+TfVAuhfmuwiyXIcNPHwTpmEl8uRzASrLTZrCAy02pkUmrsUSW8Ht3wdzJX0PbGul
         r4/ReM99oNfssrnSF0hCzjSoq9PpFhwifJK/toGl0NMmFVR6F/HEKCKMkksx7fXmafxT
         huAzBaSUwWZeA4C8Ky8XCeyaiI0jQWP0Qz6PfIDOSVUZO/xB49q/7ijMOVdqhf2vv1Yc
         0LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Goj3g0sCNvd+7qe6cDkBOdPVaI+cqmhurmWznjrfr/o=;
        b=bDZP1mUQ3C7cr8kgf6GiYlPya6DrrCQo+1EQZ1BK6o/pJgr1BNjPCl7URjkv1qLIff
         O4yh+cLguQqud8PaMfWUBbBiXenk4Cp6FCAKod4Zt2OtO2CXGOEk3qvc7nSTRunRxG/g
         ZB5bHi7n14S/TmUpzbyq2b7Ib/bjsBGpyDDlKl/EeI/nvh7JOTUFssevQgN9Kv49cmhI
         TMYH8HVpSmXZjdpmHX/04YFyck/Id7cvcU4NAvr9z8l9lytpgiPIZ/mppUgnA9EA1wva
         gXdqCXlahrDbssXlVx+TOqqGxKYx0/TTp3VxdDsfd9L8e2wZI52g3/xG9yt8Lbt/tnBT
         /JuQ==
X-Gm-Message-State: ALKqPwdZ+OSEgnKQ1J3ZFxfQJe1WZeuA3JxyRjyQ++yfGg/iqoZWDvgY
        JafZIJvk3Spudf+J4no89ETArMPc0EM+H4L4C/KoP43C
X-Google-Smtp-Source: AB8JxZphcXtodNKeqkbkC6mjfTXLBzOtkBhhiGskWbWDVw0aAGC+h6yRzf7MomeGT+Dj+QdkDgVSw3Js3U6HfmL7UxE=
X-Received: by 2002:a6b:ab82:: with SMTP id u124-v6mr11820671ioe.234.1526335680992;
 Mon, 14 May 2018 15:08:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.139.88 with HTTP; Mon, 14 May 2018 15:08:00 -0700 (PDT)
From:   demerphq <demerphq@gmail.com>
Date:   Tue, 15 May 2018 00:08:00 +0200
Message-ID: <CANgJU+VFCY0LNRLMSGtD7ScpcLaPFMzUOyw6Bjgk6q=Kx9DvCg@mail.gmail.com>
Subject: could `git merge --no-ff origin/master` be made more useful?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first time I tried to use --no-ff I tried to do something like this:

  git checkout master
  git commit -a -m'whatever'
  git commit -a -m'whatever2'
  git merge --no-ff origin/master

and was disappointed when "it didn't work" and git told me there was
nothing to do as the branch was up to date. (Which I found a bit
confusing.)

I realize now my expectations were incorrect, and that the argument to
merge needs to resolve to a commit that is ahead of the current
commit, and in the above sequence it is the other way around. So to do
what I want I can do:

  git checkout master
  git checkout -b topic
  git commit -a -m'whatever'
  git commit -a -m'whatever2'
  git checkout master
  git merge --no-ff topic

and iiuir this works because 'master' would be behind 'topic' in this case.

But I have a few questions, 1) is there is an argument to feed to git
merge to make the first recipe work like the second? And 2) is this
asymmetry necessary with --no-ff?

More specifically would something horrible break if --no-ff
origin/trunk detected that the current branch was ahead of the named
branch and "swapped"  the implicit order of the two so that the first
recipe could behave like the second?

Anyway, even if the above makes no sense, would it be hard to make the
message provided by git merge in the first recipe a bit more
suggestive of what is going on? For instance if it had said "Cannot
--no-ff merge, origin/master is behind master" it would have been much
more clear what was going on.

Yves










-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
