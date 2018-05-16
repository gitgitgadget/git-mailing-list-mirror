Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4D21F406
	for <e@80x24.org>; Wed, 16 May 2018 23:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeEPXs1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:48:27 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:52918 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeEPXs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 19:48:26 -0400
Received: by mail-yb0-f201.google.com with SMTP id x74-v6so1309785ybg.19
        for <git@vger.kernel.org>; Wed, 16 May 2018 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=FRCs4bWyKlI35Hkz0BcDZlRZt+ocV/Wcs9XM5WJRzBQ=;
        b=ItUfmRPbKCsHgeavBnBASGFituc7S9ZmLHmTtQ6XFf0/JStjFjZJa4Y4c5E6y+u7+l
         4pUrjtTYt5+dmefaL7k/IwNbqkh5MxBgmwbYyzx899xSDscpI5GcyUWUll5rW2kcQEwu
         hkTbBVO1bWnwKtjMqoATPkXtlYJox+wKOzU+Qw3Xb7vQRYZ1y6Fw43R4cRwcjyd2IdwB
         A1K8lKyeRFGFXKx0uRz1Oz0FAl0Y+pPOiV7HNnSAKORVntg2h3mbORu0LaG2GB80+SSk
         d2cdytfMcinPaBCblvHddD+1/O+omeroxH7HEaMJCPkALvgqMRJfxBVwmp5hMYq77p81
         n6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=FRCs4bWyKlI35Hkz0BcDZlRZt+ocV/Wcs9XM5WJRzBQ=;
        b=krGjPSGPU8y52xfZ1W+fc2g7RPmuliJdu0bP5UtNchRn6lkft51b3sX8flX2FvR7UB
         eOmi65s/ySo1v/TgwebsyfHMR6DIt6RRpS9orvaW5cXHTIrOhyBM6BJKEcUWEaarr0hl
         Ao5rQHWaazB4gyGMMgUgfIZiDxNY7wUdo/gIPKBzOiFXa9Qz/fX7x97brn15PBXBdS5K
         SsDrGrTxV3aw0ESPxim0A0+MKG8DoPEEgCrKv2iWv+xttFjnobyBYvuCkzuk1Fj5H1xY
         bqyB56E2j7tdi8CXGMlzzpHmQPSgMCNTnVO0YiAAjXUhFXsS/ABQn+IioQZB9XbHTZ4z
         iuFQ==
X-Gm-Message-State: ALKqPwc6jHJQhuGNPnPEQzD3RWUu1T7mKtr7u/i9wlAgAHUbtNFJw9Wq
        AZ/qJpT7WNNYyjnYz11TaO1SW8HE5CyUsjKn5t9haTzzNNiqVO6x2bsDuKjWBDX4cMs+sLpQ/qc
        aEYZhePSEv9fTUQj7P5Zs3GyDX6ouXEbRUJR9j0AdnLdwDQFOnKReUO5b3w==
X-Google-Smtp-Source: AB8JxZpHj1LsfYcbKgH6Nd5d9eSaDX6JK76gDtpFnESaJkwu4Xp04xZSMwyeiRUBr8OgmdL5oXtIw1iZaV0=
MIME-Version: 1.0
X-Received: by 2002:a5b:b8f:: with SMTP id l15-v6mr982955ybq.57.1526514506265;
 Wed, 16 May 2018 16:48:26 -0700 (PDT)
Date:   Wed, 16 May 2018 16:48:20 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516234822.182663-1-bmwill@google.com>
References: <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 0/2] generating ref-prefixes for configured refspecs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's my short follow on series to the refspec refactoring.

When v2 was introduced ref-prefixes were only generated for user
provided refspecs (given via the command line).  This means that you can
only benefit from server-side ref filtering if you explicitly provide a
refspec, so this short series extends this to generate the ref-prefixes
even for the refspecs which are configured in 'remote.<name>.fetch'.

This series is based on the v2 of the refspec refactoring series.

Brandon Williams (2):
  refspec: consolidate ref-prefix generation logic
  fetch: generate ref-prefixes when using a configured refspec

 builtin/fetch.c        | 19 ++++++++-----------
 refspec.c              | 29 +++++++++++++++++++++++++++++
 refspec.h              |  4 ++++
 t/t5702-protocol-v2.sh | 14 ++++++++++++++
 transport.c            | 21 +--------------------
 5 files changed, 56 insertions(+), 31 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog

