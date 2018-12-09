Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6E120A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 23:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeLIXBv (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 18:01:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeLIXBu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 18:01:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so4449347pfb.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 15:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FSgWTSkkZ8iWPV9n7Kkxj45mBMRgCeaeMTw731GT5Ds=;
        b=UJLwcrjFrqAglqTOWWWUbiFW9SQgXgzeWMYtK0CEhDp3WkBJ8g6QEvo2oQZ10up4AO
         is7T+0TEylInPm+K+MugFMi9JnluZNgiZnWL0CkHzM+r31eRf3ZpqvChaoSAAnLsC5rs
         mQFXRFWghW2tar9vQCqNHnI/HBbduZmPfSAC9lLIstqTkjIkABxaQ7aYF6ZMB2W2aYkq
         NyMReyVqC9EraPyPtVZtu9l/gkTxpO2+CbLG1qrkXUh/DqjVWcCTLAbno/FFzXkQBCoN
         c5iq1Wk7ZiwPfWrERJnmQyliB1rXK2tNjn9TYRdOGqi7mbC4Fx7Ws+t12xnn7LViAd1P
         TMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FSgWTSkkZ8iWPV9n7Kkxj45mBMRgCeaeMTw731GT5Ds=;
        b=WGGMgK4cei0BHJ1BymUFz8m0BYBEbtJ150KdQn5bV/5MWDnDeM0p6k+awJq/8fRAGJ
         5NPJpyAsrUp2FqV1zeKMrK27fg5VQ9mg1DHbCapOyyv5oR+Roqw5bsqhruTu4b8g+BN1
         1lpENelwrGpwSjO+C2VQ0Ol+SevxXVACDIhXK+LITO5mKLoce1W3XKmmDNvLfPxgipns
         RiBv23kFul+UygcXODSFkukl//NRgIIE9OjpPNO1Pd22cxHSzZE3Vgb960WcF+ijFNRD
         YKBIgtdnCcgPUtSkCYC/caUsMV0yga8+SJa4xrVUUknvQnH4PJ1MTmhp2jdp1GZrohd6
         Ldag==
X-Gm-Message-State: AA+aEWYCC44/3d78zvU4ovh0s8YvdD0pUEw5bxUwkBPPpx3/U5C53hPR
        eBvi/Hu6GOabBC2fQguCKk1rlcch
X-Google-Smtp-Source: AFSGD/V2hGANUAvKHdpV3XuJQ+Lw80CLmFnGGJ1n+XfL+ytEMA/S+K8JPA9d5O7UPUekDhe8kJAACw==
X-Received: by 2002:a65:6392:: with SMTP id h18mr9051297pgv.107.1544396509562;
        Sun, 09 Dec 2018 15:01:49 -0800 (PST)
Received: from localhost.localdomain ([172.58.92.208])
        by smtp.gmail.com with ESMTPSA id y5sm15110414pge.49.2018.12.09.15.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 15:01:49 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [RFC PATCH 0/2] fallback to interpreter if JIT fails with pcre
Date:   Sun,  9 Dec 2018 15:00:22 -0800
Message-Id: <20181209230024.43444-1-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

while testing in NetBSD 8, was surprised to find that most test cases
using PCRE2 where failing with some cryptic error from git :

  fatal: Couldn't JIT the PCRE2 pattern '$PATTERN', got '-48'

interestingly enough, using a JIT enabled PCRE1 library (not the default)
will show a similar error but a different error code.

the underlying problem is the same though; NetBSD includes PAX support
which restricts the use of memory that is both writeable and executable
and that prevents the JIT to create a compiled expression to jump into,
and while the "fix" for NetBSD is simple it would seem the user experience
could be improved if instead of aborting, git will instead return the matches
using the slower interpreter (which seem to be also the recomendation from
the library developers)

it is important to note that the problem is not unique to NetBSD and had
reproduced it in OpenBSD where working around the issue is more complicated
as WˆX exceptions require a filesystem mount option, and I can see it being
problematic with linux (as shown by the open bug[1] and the development of
an alternative allocator to workaround the issue with seLinux) and with
macOS (specially versions older than 10.14) where there are restrictions to
the number of maps allowed with those flags.

I am also curious if expanding NO_LIBPCRE1_JIT as an option to disable JIT
with PCRE2 (with a different name) might be worth pursuing? as well as some
ways to narrow the failures that will trigger the fallback, but the later
is likely to need library changes which might not be possible with the old
version anyway.

[1] https://bugs.exim.org/show_bug.cgi?id=1749

Carlo Marcelo Arenas Belón (2):
  grep: fallback to interpreter if JIT fails with pcre1
  grep: fallback to interpreter if JIT fails with pcre2

 Makefile | 12 ++++++------
 grep.c   | 13 +++++++++++--
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.20.0

