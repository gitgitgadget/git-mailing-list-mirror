Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 800211F406
	for <e@80x24.org>; Thu, 10 May 2018 19:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeEJTqu (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:46:50 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36371 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeEJTqr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:46:47 -0400
Received: by mail-it0-f45.google.com with SMTP id e20-v6so4611816itc.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CyAbhiPJS7nREGxMTSy15MhvtZl0eUtjywkVoL2Op3E=;
        b=sfRYE5P3Ed2U5LeEUS/TzWFAg2kOK4MwEwWsg2JmLqZfNbYlw5HdoQPXBkRhPj/MDJ
         MjfpX2V8KkXDvdmB1XvrBL25wHgYDqL/bfhT2NGudcsfOYuiOa5d5+0ZCDqvS296Lmhq
         6QQJ+BrtDXlix3EynB6XlhQU6miOoUcceR6GUC9/BxprlCam19QvuW1+IOS9nMwVXQNm
         Pio1GABK71cWuQk7dDy43E9n/5zhc2F6zqsmlQ3l+D7Cfq+eOFvnGgTyRncddOSk4vcp
         P9MaSR4o3uxLngwcwbeq1jHhgcxiYVffhHECtzdW9S30UkImBgTNre8Zz55+tPXCusOH
         Wh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CyAbhiPJS7nREGxMTSy15MhvtZl0eUtjywkVoL2Op3E=;
        b=drLrnH5Cy0suBiqqSG9Wg3WA5XxHQZuRTl9WmYRwzNt1uWgsE9OgNeSyUHtPxGW8Ux
         zljOu4aFlPSX9+PgHGcdQiLbHfKJ0HvWvv5+bh12vKC4RI+r1EDVMa8CXVgLcrZoyFMo
         RLLXLS64K4JlBkP1RdjvACFwrXBJtZMESLlu63LO7Ng6q0vxaDMKD/2thn0BFqHYYxkJ
         AxtU3xHZMGhzyz9+qsoB+4zT3Hqtu2Yx6FatgSPK6GrTo/pW3LaEtAZnKk+J4PArJCML
         IKf+ZjqTOd5ubjw+kpNhMGef2f71R4EBzqvwQ5O/nu+wxrz2eGRaq9mxiby1LsocyINd
         uozw==
X-Gm-Message-State: ALKqPwfg/Mn6SQ9kGDSaapG3ro5Y1P1J5sOxZbaLSe332SAVxlAStEsC
        thFKloQzWOG9iI/1TaHTLWNk+g4AHgxl2NJut4IBUg==
X-Google-Smtp-Source: AB8JxZrYlYjgpJo10WbDMhDklWkI6M05lJFLP20QLAnOSQ1tF08QEKVzNNLH3Ado0G7O6y0zaamv4NB5iAhT7V7Kea8=
X-Received: by 2002:a24:e3c7:: with SMTP id d190-v6mr405127ith.22.1525981606768;
 Thu, 10 May 2018 12:46:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:71cd:0:0:0:0:0 with HTTP; Thu, 10 May 2018 12:46:46
 -0700 (PDT)
From:   Cliff <miliways@gmail.com>
Date:   Thu, 10 May 2018 14:46:46 -0500
Message-ID: <CAKsGxtUpu66fj=puTxioTwCrint+U83a3R-DPhx5gXKF8Phm3A@mail.gmail.com>
Subject: Git case-sensitivity bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I believe I have discovered a bug with git tools.

If you create a git branch, you can refer to that branch with
case-insensitive alterations and it will track as the same branch.

If I create branch "test" I cannot then create branch "Test" because
the same name is already used.

However, git commands ARE case-sensitive, causing unspecified behavior!

If you create branch "test" and then run "git checkout Test" and then
run "git branch" it will list the branches "master" and "test" and
NEITHER ONE will be flagged * as the current branch! (It does not list
Test and does not show any branch as being the current branch)

As far as git is concerned... you're not on a branch! But you're
secretly on the "test" branch.

Also, I think this may cause further issues. Switching to "test" tells
me that I am 1 commit behind master, but switching to "Test" gives no
such message, and appears to want me to --set-upstream again, for the
same branch.

This is really bad behavior.

I'm on MacOS so this may be unique to the Mac version of git tools.
