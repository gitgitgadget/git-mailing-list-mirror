Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E65B1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 17:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfH1RIL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 13:08:11 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:34220 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfH1RIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 13:08:11 -0400
Received: by mail-io1-f49.google.com with SMTP id s21so1090119ioa.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WMsPHUsoiNFqTRo6vn3z3P8sIg2SfzFoRb6D9UBQngg=;
        b=rFZ49Ebn3Uv82h/1pijGo1Q8tx+82miYB89LkMPHvUkdArRU+V2plOoccyEQ01cW7/
         Btv7G0zn+kWuF8DmFHdbgaQOO3L+aLSMDKHBnO6VIt0faeU7SSJXX8FSmZd3zivGDtfm
         MdGcwz7/cYmCZmfIq9prr6eraryg5Xwikw6pL318llV22o75vcaVsIXYSOdQTaEkBFB7
         RYvQGlXthrJoKwcEpp0xCbH9MrBJ62zckC5tG+MjH0U8K0l2wDdijwxnx3lyDXdZDBwl
         +YpXjL6SKVIQTFP1hsnSb9CI4zUHWnca6lkNsbbCCloXo+HTXYth4+SnyI1uqXNuQF4l
         I3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WMsPHUsoiNFqTRo6vn3z3P8sIg2SfzFoRb6D9UBQngg=;
        b=kBne0jsBZHnOzbCHqhdSsa+vGmnpgdFb73xkOqnaZ74n3XPcUgnYU+IUOvAzZ2K/IU
         /SuDgc0cQUXdLmM6T3wtqy9DkiVL8IbaGKUwlk5IAMKGWyiOaZa/aVQju+tw6m2dFCfH
         gNbZeeac5HRy9XK+T9kiFwuCFh6oWSPaL0jXbplhKdc0wRp7NzypOhfoO+1X2N0FGaJY
         ADmeb6olNctWPLof8whia52r0ON6g7o+V/Ac+VSJ5Hq/e32wP7TMjn17fw/EDcgS+c5z
         XEqHE2qfGhI0YHBxdcBQ2lkZIwmzL4OJ0w0PLmCBIC0mpR7O3OPW1IWmEIAR5a5swo2V
         3+/g==
X-Gm-Message-State: APjAAAVCPhrQGJoqIQq96/hVQe0Dw/Iz/U3O9HuMctdirhABNivhy8Xv
        NNo41vHwTD/P4rPugOMjw4HHcYJiCWv7tOESLcxR0QPr2zM=
X-Google-Smtp-Source: APXvYqzMx/a+Mr8mwK52hHZ82IsjmYnNez2HkWQtz4FeHT4emmRcLw0pW24Gt0m4ji8/303PwJn6S+Q9UDT7eR3ggRY=
X-Received: by 2002:a5e:9412:: with SMTP id q18mr5958754ioj.112.1567012089963;
 Wed, 28 Aug 2019 10:08:09 -0700 (PDT)
MIME-Version: 1.0
From:   Terry Davis <terry.y.davis@gmail.com>
Date:   Wed, 28 Aug 2019 10:07:59 -0700
Message-ID: <CAEziGD9bWPfV+L5z_-drATT8Fxvj=8hzNAQcNH9f9Ez+ncaEvw@mail.gmail.com>
Subject: blame --ignore-rev - add place to specify defaults at repo level
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new blame options (--ignore-rev, --ignore-revs-file) and config options
(blame.markIgnoredLines,  blame.markUnblamables,  blame.ignoreRevsFile) are
great, and much appreciated. However, for my primary use (one-time
automated reformatting of an entire repository), there is still some
friction preventing adoption.

Adding a default location for the config options (much like .gitignore)
specified above would have the following benefits:

   1. New users of a repository would not need to take the extra step of
   configuring their workspace for blame. This is most impactful for open
   source projects with many contributors.
   2. Git services (github, gitlab, etc.) could incorporate this feature
   into their blame systems automatically.

If this has already been discussed, please point me to the thread, as I am
a new member of this list.

If my proposal is worth considering, I'd be happy to provide more input.

--Terry
