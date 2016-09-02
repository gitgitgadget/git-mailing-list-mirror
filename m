Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F7221FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 20:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbcIBU4m (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 16:56:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35246 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbcIBU4m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 16:56:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id c133so4311361wmd.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 13:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6CQFkc+bqFb4oqo4F0/vf9Y+QqCLP5y3Q/wVbL513e0=;
        b=q5eWTyBpcvAY4ml4Uf399IsIkU1AWGjNIWmd35Q/OZnz+hYfcA4wGa/6Ga7ebaJvVv
         01jkCVxUamSytALDEnSKPaF2VH2egH1TPbubrJKBM8xtEOcYc/V0JZ/FA7KTqe0b1rYj
         37T83za/PKQi4vMHMO4q3XhXHEJXldbCrZmM8KtXjZYx46xkJUvMWIZqhO3XgteE2t4T
         oXxxQBZ4VM4GxBgcZZiY+1oqcFN8Hcr9hj4z9p+w/yWH8EBeM5ctlu1171RPwrYRJYg4
         P01UFsPq6tNtxrk/ybjMIkz7kzrglHltB7WCT8740uAkWzbvrdiiih/YuTPm6ShJIp5w
         WS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6CQFkc+bqFb4oqo4F0/vf9Y+QqCLP5y3Q/wVbL513e0=;
        b=m8Q2M2FFTPMoLp4Tcj+FDP0FDZL9HUjgzyC/MSflebLVPKNgYexZ5gRfjeXQarlM0X
         FiCdq/xBLbsWI5TN/yCRpL17yPhrFlkqBj8VQIg4poT3cnU6zMtpKIPPA48NKO7c1zuD
         73XtpeLxOYnu3s6UePPe2lCow5BSamNJHl1QugzG+8St8jDusJpJKHHCc0Ajr0zwjP8G
         nlUUcDIjnCGi2K4aYucKes5SjWqaQpi91WjRtStfjimBdWtC5nYlSk5AHxqG7jGVexHc
         E1CrCkqNF9QD5onPB6Kdejtmbr6T5KECvLZr8myDK0+b77Ik/HP3auztDWFYhJdw2bLZ
         iJzA==
X-Gm-Message-State: AE9vXwOCI20xWcqVo5KL/2v8NHPpnMA0lF4FaONWJo+AU9GHB8V3oEAkJbInbxcKou5Knw==
X-Received: by 10.28.52.135 with SMTP id b129mr5176992wma.107.1472849800565;
        Fri, 02 Sep 2016 13:56:40 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id z17sm5281742wmz.23.2016.09.02.13.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 13:56:40 -0700 (PDT)
Message-ID: <1472849798.4680.63.camel@kaarsemaker.net>
Subject: Re: [PATCH 4/9] rebase -i: also expand/collapse the SHA-1s via the
 rebase--helper
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Fri, 02 Sep 2016 22:56:38 +0200
In-Reply-To: <fe53c109c757ede9cd1b0d2944d2b5e16575c49b.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
         <fe53c109c757ede9cd1b0d2944d2b5e16575c49b.1472833365.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On vr, 2016-09-02 at 18:23 +0200, Johannes Schindelin wrote:
> This is crucial to improve performance on Windows, as the speed is now
> mostly dominated by the SHA-1 transformation (because it spawns a new
> rev-parse process for *every* line, and spawning processes is pretty
> slow from Git for Windows' MSYS2 Bash).

I see these functions only used as part of an shorten-edit-expand
sequence. Why not do a git rebase-helper --edit-todo instead? Saves
another few process spawnings.

Something for yet another later followup patch?

D.
