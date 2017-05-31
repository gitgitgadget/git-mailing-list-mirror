Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71E51FD09
	for <e@80x24.org>; Wed, 31 May 2017 15:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbdEaPEm (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 11:04:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32847 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdEaPEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 11:04:41 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so2201452pgc.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AsWqGJkIwsaNXTe1hhxkw9/QZOeoj5nA3NbOt1RYfzA=;
        b=MrN1E5X0YSPDgwVGOFBHJw5fPwnS7TzrNFTUWWq+uC8NAludkb3Y9UGK92sdP7kx4r
         aRreIATzJTs3EiBty3GCBV9g3GCfN9FcsoVuR68bgYVa8CIBu+1/B/VUOAEGncEDI1a8
         JjgHFf1Dxpa0x47eDVshcfVZPOwAiOir/psEfffSJfK7ZHIo0AJT2zE6N5vhZbZVNbfw
         t9zd7NJd6OMJDHrxob6JVcLzvSEZuw9k7tpSn5/hR3/rOqOpeZrxkZNE/bIqo+auu5A8
         4DExxKUxccnvYnWlpnpI6AdcafC4AG9CwFmGRJeF9pEOQ08bM46k9mWxUi8OjTj6VbwZ
         RcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AsWqGJkIwsaNXTe1hhxkw9/QZOeoj5nA3NbOt1RYfzA=;
        b=YTPnwTWUad6sdvpgcvHgM4SH7uCjfNLCc2yf9U7UjKDdeDtV5D05Id390Pd9sDfxo0
         8eHZsedYrMC7SZ+YxJLeMroQTPuy52QsGrzlo4UsXp4kwRrLQC59Fw8uciqYkVHD9iqC
         Woj2qePX8Zrv63vLNB/2UG7NIPKr9qX67nHk5lTwGdWTIuR6qUjdZYF78WSqobNmonH5
         ECyFMdaxxGcqimM2gZdGJpucBDoA8zijjtYx7sPB4N9h9HtW12Z7VmY6qhf3HYlE0TBu
         W+L6th35vcCIVL8M9gIoGqyohe2C/ydOzIsRZNTZdGa89L1b/648BVMg9ffv3FMMybmx
         POZg==
X-Gm-Message-State: AODbwcAFhZ3S8g0iGgPPyhIp7ehcj5ZuGgLpVmA+zfMYnd+7VuuMguCR
        MzM29ubiUt82lk63/DM=
X-Received: by 10.98.33.133 with SMTP id o5mr30853376pfj.11.1496243080669;
        Wed, 31 May 2017 08:04:40 -0700 (PDT)
Received: from kewillf-git.redmond.corp.microsoft.com ([2001:4898:80e8:f::3b6])
        by smtp.gmail.com with ESMTPSA id g20sm30213737pfk.21.2017.05.31.08.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 08:04:39 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 0/2] Add progress to format-patch and rebase
Date:   Wed, 31 May 2017 08:04:25 -0700
Message-Id: <20170531150427.7820-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.13.0.92.g73a4ce6a77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is to add progress for the user when generating
patches in format-patch.  This is to aid the user when performing 
large rebases and have some indication to the user that progress
is being made.  

These patches just add the normal progress indication when
generating patches and makes it the default when running rebase.
It will also respect the -q[uiet] flag and not show when it
is present.

Kevin Willford (2):
  format-patch: have progress option while generating patches
  rebase: turn on progress option by default for format-patch

 Documentation/git-format-patch.txt |  8 ++++++++
 builtin/log.c                      | 10 ++++++++++
 git-rebase--am.sh                  |  5 +++--
 git-rebase.sh                      |  2 ++
 4 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.13.0.92.g73a4ce6a77

