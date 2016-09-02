Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB901FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 20:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754107AbcIBU7m (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 16:59:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35885 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbcIBU7l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 16:59:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so4313017wmf.3
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmtUDsShcB2+h2JRc/ZCLI5Fg0dh3fAHMfJe4acqv08=;
        b=OLHENkcf8OHkUq8eCL3i25X6/uRE3j51wDGU28JKbSu4ooMaPVlqre8IgWBBeqJ4kN
         JDszp3OcFCjY8ucOvkYNxmUCdM+rqRefJKiDTZSdfUeM0L/n7NbBHUhqyAVAnno0Y+0D
         H+wcRRLV6hZR3Cmg/VknYAdzvorwdYu56pHcmSfJyUo/YFi7scE0Cp5BysEwf5Rklgse
         oVgxHTFdbhdXWINIu2AGps9JfS+HNnpkDiBUHCt9SMKpUuD44mkkcNpjmnG+CZUoLBvN
         /D4pQz8AR2aTgB+msdRNCDYtO/129N9LZlN8yXiqH2247Sx/jf5vDaC/Yb6jk5EDqQ4U
         5FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmtUDsShcB2+h2JRc/ZCLI5Fg0dh3fAHMfJe4acqv08=;
        b=L0eZW0sM8NLCsLW0zGj1Pu8mWkC5jVBy5l42U79TuUyg2tSYM37HFBM6BLNdLHItWB
         eLioKCPLvW3HIHEWAaLP92EcwkJyYSSMgqiKDRRzj+ZLeSqMb48K/i3uHOZOBUJqj/SL
         AimSe//cbmWU1/wN2H003LqAvTfDENMQ6Jj87mZNwbMCx5eL7LoNAjtmQimbLswPtzBf
         8cbnRe9jExunLm8FYJSwLaW37pLMRkEhkveJ4ti1K93bBGJD18XXfiN52EWFVEBxWqKi
         eQF+jMERvzRM6nufnXS2/RHjLXmD/YGVcZtMe/bYnLM7sHnMES3yeYlJ1cMEtWZb9aUG
         L1gw==
X-Gm-Message-State: AE9vXwOX2SMDhelFkw01xdzJ1RKG4Gyt//ipS6FnPg+JinxoASXvYlHTJgsNUoqrJYuOgg==
X-Received: by 10.28.19.134 with SMTP id 128mr4818045wmt.40.1472849980303;
        Fri, 02 Sep 2016 13:59:40 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id bc5sm5551537wjb.37.2016.09.02.13.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 13:59:39 -0700 (PDT)
Message-ID: <1472849978.4680.66.camel@kaarsemaker.net>
Subject: Re: [PATCH 6/9] rebase -i: check for missing commits in the
 rebase--helper
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Fri, 02 Sep 2016 22:59:38 +0200
In-Reply-To: <6d28acb59d7c217f1f8d6d364e5a52c8bde35085.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
         <6d28acb59d7c217f1f8d6d364e5a52c8bde35085.1472833365.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On vr, 2016-09-02 at 18:23 +0200, Johannes Schindelin wrote:
> In particular on Windows, where shell scripts are even more expensive
> than on MacOSX or Linux, it makes sense to move a loop that forks
> Git at least once for every line in the todo list into a builtin.

Heh, this was the one thing that made me hesitate sending the
suggestion about rebase-helper --edit-todo, but with this bit already
moved, I think rebase-helper --edit-todo makes even more sense to do.

D.
