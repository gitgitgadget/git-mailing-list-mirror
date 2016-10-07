Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D9520986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbcJGSTR (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:19:17 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34119 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753136AbcJGSTP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:19:15 -0400
Received: by mail-pf0-f169.google.com with SMTP id e6so26863684pfk.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=37BefD+fUMF6QrJEqtpkBDeDTbGFQmIjpxSy6i8EcAc=;
        b=OMCwyWQnRLrFpZiasw/ZkCcO/ndokR8/VHCWbJVwKL3wDDRWrmOd+cIZPdPSx0N+Ad
         p3jRBLy8qJhcrLgKv7ICiaARMPcdRjBZTVfKT7Vea0fqVZUtgi3R3M3qDYr7N0OPc/yG
         IKH6OXAM2vT9SFpPoWGTFZG0PNc5LmD8OBMx/ppj1bOhlaS6Pyw3F0TcTHQKjp7FKOAH
         x6Qxp6wJ3sggcThcG3B/SIb0+8yPOBTz8p4/uLaCO2BXiJej7IlmstQRP0DasUgJEYYc
         Vq2KPmZ5nwBtLqfk8NeQxp6QOKOQdFdbsDwlKK8rDqODVRCRTO9wNPIiUcRrSSA8snri
         TTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=37BefD+fUMF6QrJEqtpkBDeDTbGFQmIjpxSy6i8EcAc=;
        b=HjnVSR2I7y5SYdw43+7aK5Mua66ciPVQzDa0SeyOFMnTUCXDgqysprezOcbzK/dzFb
         Q7jUCA3nMWasbFL5SmpqvBZzQlJFUuEhc9q004NF1L09QBuGF+4c+uWazffmj8laEfqC
         Gvftqx896bGo24JuFizfMMQDMCIM6AxDjq7Hp9qCTZj+VkMTEx2Ftt2bg1l7ug1tOY7T
         VJnqGvnLNEowh6vImPznbP5wzoQBwlT7cAzXWWCg3sNyFmSPkxHUT/A41+0eJyoc5pgN
         o0nFMTCtlzNm/31B4T9N3r/L94enWm4RSAuRlal1bGlvREoWSJr+B9CLz4kJSjDNgsZD
         I/yw==
X-Gm-Message-State: AA6/9RmTB5KNdsEnDPw9MHduwglNy15aH7G4xNbBropSVKcc8AcDs24l8qF/mGTDt5+wilQn
X-Received: by 10.98.216.134 with SMTP id e128mr31083644pfg.184.1475864354461;
        Fri, 07 Oct 2016 11:19:14 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.36.144])
        by smtp.gmail.com with ESMTPSA id s74sm15641281pfk.61.2016.10.07.11.19.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 07 Oct 2016 11:19:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v7 0/4] recursive support for ls-files
Date:   Fri,  7 Oct 2016 11:18:47 -0700
Message-Id: <20161007181851.15063-1-bmwill@google.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <1475185723-36871-1-git-send-email-bmwill@google.com>
References: <1475185723-36871-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Few minor fixes pointed out Stefan

Brandon Williams (4):
  git: make super-prefix option
  ls-files: optionally recurse into submodules
  ls-files: pass through safe options for --recurse-submodules
  ls-files: add pathspec matching for submodules

 Documentation/git-ls-files.txt         |   7 +-
 Documentation/git.txt                  |   6 +
 builtin/ls-files.c                     | 181 +++++++++++++++++++++-------
 cache.h                                |   2 +
 dir.c                                  |  46 +++++++-
 dir.h                                  |   4 +
 environment.c                          |  13 ++
 git.c                                  |  27 ++++-
 t/t3007-ls-files-recurse-submodules.sh | 210 +++++++++++++++++++++++++++++++++
 9 files changed, 452 insertions(+), 44 deletions(-)
 create mode 100755 t/t3007-ls-files-recurse-submodules.sh

-- 
2.10.0

