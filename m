Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93174C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B25C218AC
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy2mXPcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEHRYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEHRYs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 13:24:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CA0C061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 10:24:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e6so4578472pjt.4
        for <git@vger.kernel.org>; Fri, 08 May 2020 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Ztf84PpK4gwg8NGguOcVxzHOoE/tDrlo4fh5dS+dlrY=;
        b=Uy2mXPcrWNKQcHWOdxWT4z3hT8i8FhcRdkTJfqxpLowrhSq7po+WoukJ/5HXSxPOVH
         ktT4bs8FvYt/TmyklRfa1h93IB5Qf5nIYyC7FiP/HTgF2pd4x8T3LNMiN/ba1hWJaq7h
         8dDNgCzqiRHOz9gEiVyA2TfPH7bt1YBNcSOdYhswi+c5q1eplN1nq2DWHj/gpAfdIKPf
         4zHHO//h7GnbSueicM0CgYycdqh+pl8dR8qp/QJ/ypkmGJKl893YPxsuzO1c5EZukWuX
         UV9BIgOAiiAN4SHvWrM9Et3r3vERu0+5oOMR/PbkzNkEGXEiD9K7nkTqkw/kOxqo0f3z
         nAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Ztf84PpK4gwg8NGguOcVxzHOoE/tDrlo4fh5dS+dlrY=;
        b=D/SeOyGigp3H5ww/k0VVUjzbPnmgYCfiMthI6MA+bU2KlBRCQt/XL4QQJRp3ThZFun
         JyRm5XVXxnbab0MvdZs9bqPDUzOapZPDMOrTfND1Nk2/7LbfL721tp31m1xgUXBsUTSq
         GSoNxiASD1/aGo8WFxustCIDnzUk6tyBPT4KLnNGzv9thSQsKDsKB8p3WwVZqjkMHJF3
         f8I9QdzUuY5nGQO1SuyLliOgnnZRtewzD26FJ5uV8CY6pxN92yeYEwL/txhDQlgHiSi1
         AD5OmSfGAVEwCqrZa7U6acbI3AON6ivLerHIcaHREQZxLw9BNeTd/nuLDGsVQJ0RC8/F
         TFtQ==
X-Gm-Message-State: AGi0PuaTy/mXniutYFgyb0aoHNz+VqwCd0uIjoGT/xd7oW8CSpw3u2o/
        wRN4Qgrvi53jksYvGdnIinSMLHlD
X-Google-Smtp-Source: APiQypJywbil1D8yfTxAafqlghPZRHP2ts8058F/DXQDZhUkdzjgZoLvQNOppoIaVRhNhpB3bW0fCw==
X-Received: by 2002:a17:902:9b8f:: with SMTP id y15mr3402069plp.148.1588958686322;
        Fri, 08 May 2020 10:24:46 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id j32sm1724560pgb.55.2020.05.08.10.24.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 10:24:46 -0700 (PDT)
Date:   Fri, 8 May 2020 10:24:44 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: how is maint-x.xx updated?
Message-ID: <20200508172444.GA38186@Carlos-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While testing some potential fixes that would apply all the way to 2.17.5,
noticed there was no official "maint-2.17" branch documented anywhere, and
while I could obviously create my own based on the last released tag, it
was missing the following `make test` breaking fixes:

  macOS: 89c0b113a0 (test: correct detection of UTF8_NFD_TO_NFC for APFS, 2018-04-30)
  NetBSD: 5826b7b595 (test-lib: check Bash version for '-x' without using shell arrays, 2019-01-03)

which begs the question; is this something worth documenting?, should we care
about maint-2.16? where is the line in the sand? can whoever is the power to
be make sure if we ever do a 2.17.6 release to cherry-pick those 2 fixes?

Carlo
