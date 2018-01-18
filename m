Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DBC91FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 18:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755988AbeARSga (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 13:36:30 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41430 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755691AbeARSg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 13:36:28 -0500
Received: by mail-pg0-f66.google.com with SMTP id 136so14432493pgd.8
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NoRou8pnZ4FGaOBlZ1N3j92xnzWDjMx9NolNGjz5LXo=;
        b=W6ymPbBiPVrC3qy1DAWoxN0cwSz+GjiVqiz+nzH8f4Ycav5CkAUk8lIRTdhwymRrJw
         e3CbKHsjb9XhEvsA6QbZgXx48E0mIrXhK1g7p3NQqderj/Nc9FKLnR4stnTAlOmm66tv
         W+ZGjulAuQjLfLlLTLoN4lbUy+HRwIYJe+fn2Z1znxESoeigEjJS91bvskbl2PLr4Tvk
         M75HBAbaJBDxxKrP00T1Hczpu+8Te9taa2M9QfgShpyqeGw+/PdBVrbTW1ccYRZIqIsm
         FM+nGnKPJsmmx6y46Po6mU7n+vn8ch0dnI+8oBLLFVt3Kmo7J1j6y84qGiqVhD3tqRDl
         ZekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NoRou8pnZ4FGaOBlZ1N3j92xnzWDjMx9NolNGjz5LXo=;
        b=XRfVJYqmG6bvZkr4XR0zrptowGsk8hGGkftndNqdR9dZ5QCfUYuxo3bpoGQVUk1fxq
         n3hGqxNBqTQL/MQkwDsBiIfVGW3SMPGZzvWapKRh+KlpHJ8EQ46Ut72vjIbC2zHnSphc
         6R3av3rseAkr5xP+E6wiTBkogGtumtyRKtrQOxBw7rxe6x95emWo8wFdO5dSwVZ0n/eO
         8gV20okif+j7jrgrmy5rhOVlw8gOyit0YNQTArC5QznDbEX3Gba9yE1tziRQuMLhSAtp
         qLdT6roTFdOCHLlPLtDoyeMwsVVcNwMErhmFHIJ2bMFxIj6zlHnQmXDZaMTte3zxDXMg
         YHQw==
X-Gm-Message-State: AKGB3mKmhJV6W2Rg2F+EcpL2REjmFCOr+eLKirLOmB9Or43KIY8/3OkZ
        ire5eJWTUtzbZ7gEbcjpKa3g1w==
X-Google-Smtp-Source: ACJfBovNjOD4gcJLv2x+if+f2MdhiPj/6uWlxUpgkNn2ZmYA6Zj149X7HBkAqW/afHHKk1KKevSPCw==
X-Received: by 10.99.107.201 with SMTP id g192mr30659776pgc.295.1516300587723;
        Thu, 18 Jan 2018 10:36:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i9sm13578983pfi.154.2018.01.18.10.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 10:36:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 9, 10/8] interactive rebase feedback
Date:   Thu, 18 Jan 2018 10:36:16 -0800
Message-Id: <20180118183618.39853-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <cover.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I thought of writing a reply, but instead I wrote it in patch form.

Stefan Beller (2):
  [DO NOT APPLY, but squash?] git-rebase--interactive: clarify arguments
  [DO NOT APPLY, but improve?] rebase--interactive: introduce "stop"
    command

 git-rebase--interactive.sh | 23 ++++++++++++-----------
 sequencer.c                | 10 ++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog

