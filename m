Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FCB1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932273AbcJNU0O (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 16:26:14 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:34389 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933112AbcJNU0L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 16:26:11 -0400
Received: by mail-yb0-f170.google.com with SMTP id o189so21143159yba.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=KRpY4UTUs5RqWQgtEOUqcyy6gST94CVjn6IoLpfQ0e0=;
        b=PJz7Q4MB5FYB3I27QO/hZP0BMKgTod4GMzj2wqeKYK3lKgS68FuMY3UeGBlhfA+5P5
         On58gzwId1HISYGowO5iCkozfGyXpRRDca8hrhUCKf4+ICtajyDcv2k2t7EYzFLEai0g
         +jmadXAq7ILR2ZVJD0xlnizc/KPeaka3LBnKnFSsuzfn21W3SY4m0UqdIuFDoWQIGR7l
         alAmP43BRerm9V09NLKafyL8R6xkNh6gYaAbhLUgvif3enGAqNhjWXQHspUl8XwXtlXY
         B2e5TcdoLgRj3HCnmCyexcyAjPkiZD+y/VKe4EVatY8Svl/6YDhMF1XhYk6KtQauHB1W
         S4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KRpY4UTUs5RqWQgtEOUqcyy6gST94CVjn6IoLpfQ0e0=;
        b=cmgwvuHUEnCDcRaPOJDgK5MO8700B5WWfXRfemavGNp49poDKKUi0HLErepSF5hqWC
         UlAC6wVjXkSiPr5TqcL2CGgV/xM0Y3WmNohL0DoGyLpxf0pBLjf1dtgP9W4/wt+BG8vO
         ffRCNoGHCtxIRMpTNA7U4+s1dwjolinmiWcykOkb7+gnO6e9DdA+GEs63HrJqMB/L2tC
         /EKMIX7WRti9G/xxTOMFm4lL8cbmLRF15MrfLkdcGzu1Ij/jHbtt/gjVSbREBxec/ze5
         hV02x1gvW7pakadjphPIlVMBDFQigQI5WgnQ3hYsUYb4PZ+iPCr1QpJnbtLA8idhzd4t
         0ljQ==
X-Gm-Message-State: AA6/9RkQN1S6j+axPad2lpkeBeyOd3j5HPMhVVqBnrUSpZh3ULrvwByeF/VEv0kcg7712TzObVyXsvj4J9kukg==
X-Received: by 10.37.228.2 with SMTP id b2mr7277983ybh.5.1476476770280; Fri,
 14 Oct 2016 13:26:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.208.3 with HTTP; Fri, 14 Oct 2016 13:25:49 -0700 (PDT)
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Fri, 14 Oct 2016 16:25:49 -0400
Message-ID: <CACPiFC+8+wVEcDt9JZgTW1dwCCFKszyXD6ysDxNQorcNkom7Lw@mail.gmail.com>
Subject: Automagic `git checkout branchname` mysteriously fails
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a (private) repo project I have, I recently tried (and failed) to do:

  git checkout v4.1-support

getting a "pathspec did not match any files known to git" error.

There's an origin/v4.1-support, there is no v4.1-support "local"
branch. Creating the tracking branch explicitly worked.

Other similar branches in existence upstream did work. Autocomplete
matched git's own behaviour for this; where git checkout foo woudn't
work, autocomplete would not offer a completion.

Why is this?

One theory I have not explored is that I have other remotes, and some
have a v4.1-support branch. If that's the case, the error message is
not very helpful, and could be improved.

git --version
2.7.4

DWIM in git is remarkably good, even addictive... when it works :-)

cheers,



m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
