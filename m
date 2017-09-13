Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775A020286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdIMVzC (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:55:02 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:48972 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbdIMVzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:55:01 -0400
Received: by mail-pg0-f48.google.com with SMTP id v66so2775871pgb.5
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+gsq2FLGozTpNWRq3ZhGmJsUkjfSd6++DM1B/T74sGQ=;
        b=HMqN/qg/tuFqiIZxpAz6rGGZn7gocRid5dgEyjcDazm/t4D8+LpStnJ59dm7NwkgmH
         Ppm46O95v0QkXU/7ge3icSgn3/EPO8M4NY7ktxMv0hIv4Jv+SZm6N9mbHgdklPe0AMF5
         bJiUsKEk1a1r2vKjCTHpEqbWIHc2OD36JLT9agw3svGpYXrsakut5mfEedAh2CcEgsEO
         XTQmryILoVqLySkuw0q/TG4MkGF/Yx8U/z9fdjVDb3xyJ3T6IGZrJmQspPuhy1tkIOHM
         24D/eVgNieThD3Fr4ZCajYk5anLs+NI9Pnc+mPk2lY4h2ZPJMcSn99Hu8w/uebVzsFyd
         bJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+gsq2FLGozTpNWRq3ZhGmJsUkjfSd6++DM1B/T74sGQ=;
        b=qvPanEYEUqrfdm4Nj5i5V3R/tutx+JtwfKiiSqHAOT8/z324KAPp/mWeTlw0ltBMjY
         wigkLCBn6tCUPWNsoK/JqHUBYUCpanS02lSE3PqTfL/PggihTwO6YJ8NXhveQ26JtKfY
         V+91jdLEMV6bUvy8v2CWLQurd/yAcdBhdwZ3Wtw3koBUNd2fmJE8CAbUf0onIJuLRKUf
         WOqX0pp9kZx/emza8RbtxkbC+xWWPvSkIuITQddhZ3cQfiGEdZCvpMwX8p1EzZx6+aty
         Aa0CDruk3MfbQrHG1Vu0CcCm0hYlIrgr88V/cB8kDIE+R/q5mJe5kxk7n1ERYr//eFW8
         kDxw==
X-Gm-Message-State: AHPjjUhx0HpI4Ixbsk9cCw7yh0k7k3llWEvjC7Fb3w6yYsrJZ7yMrfeW
        0tHr1/D5QqXNKxc/xc5gBg==
X-Google-Smtp-Source: ADKCNb46cvkaDSLf4YvY5hjgW6F0CC3S7xL/Z+DkAZsGzwfxHhohUJZpye95HXPRl+3nWUjgAEz/Tg==
X-Received: by 10.84.232.76 with SMTP id f12mr21267358pln.297.1505339700643;
        Wed, 13 Sep 2017 14:55:00 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q13sm23152639pgt.87.2017.09.13.14.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:54:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/8] protocol transition
Date:   Wed, 13 Sep 2017 14:54:40 -0700
Message-Id: <20170913215448.84674-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.690.gbb1197296e-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the non-RFC version of of my proposed protocol transition plan which
can be found here:
https://public-inbox.org/git/20170824225328.8174-1-bmwill@google.com/

The main take away from the comments on the RFC were that the first transition
shouldn't be drastic, so this patch set introduces protocol v1 which is simply
protocol v0 (which is what I'm calling the current git wire protocol) with a
single pkt-line containing a version string before the ref advertisement.

I have included tests for protocol version 1 to verify that it works with the
following transports: git://, file://, ssh://, and http://.  I have also
included an interop test to ensure that sending the version request out of band
doesn't cause issues with older servers.

Any and all comments and feedback are welcome, thanks!

Brandon Williams (8):
  pkt-line: add packet_write function
  protocol: introduce protocol extention mechanisms
  daemon: recognize hidden request arguments
  upload-pack, receive-pack: introduce protocol version 1
  connect: teach client to recognize v1 server response
  connect: tell server that the client understands v1
  http: tell server that the client understands v1
  i5700: add interop test for protocol transition

 Documentation/config.txt               |  16 ++
 Documentation/git.txt                  |   5 +
 Makefile                               |   1 +
 builtin/receive-pack.c                 |  14 ++
 cache.h                                |   9 +
 connect.c                              |  59 ++++++-
 daemon.c                               |  71 ++++++--
 http.c                                 |  18 ++
 pkt-line.c                             |   6 +
 pkt-line.h                             |   1 +
 protocol.c                             |  72 ++++++++
 protocol.h                             |  15 ++
 t/interop/i5700-protocol-transition.sh |  68 ++++++++
 t/lib-httpd/apache.conf                |   7 +
 t/t5700-protocol-v1.sh                 | 292 +++++++++++++++++++++++++++++++++
 upload-pack.c                          |  17 +-
 16 files changed, 655 insertions(+), 16 deletions(-)
 create mode 100644 protocol.c
 create mode 100644 protocol.h
 create mode 100755 t/interop/i5700-protocol-transition.sh
 create mode 100755 t/t5700-protocol-v1.sh

-- 
2.14.1.690.gbb1197296e-goog

