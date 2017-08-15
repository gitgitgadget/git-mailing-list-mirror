Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9BB208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbdHOMx2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:53:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38396 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752916AbdHOMx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:53:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id y206so1352433wmd.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqtbAvAHmmdh9xmOSDBaV1MZQO+Q4HHNpm/HXmo13CA=;
        b=RD1a5CQN+s3JwhZrCTAQokma2PFl0w7MaLYolSV5lZzCuxmH+N/hTub0OK0T876nz7
         tQNQqfGJ9wsDYwmovfcGk6QQTNMA8CcLCaP4s0Z+irXtiO+KbxsgMNMzSEy6QKvwpo33
         jGV3V5pWgfkHHQcm3nqkUl1a4/rSWZ/OW8g7RWHPgPPszsiikyUHM1c7O+DRdOGDF9yG
         Tyee2frA+CbxQfef1N3dKJoMcmZ6FpCsxapMPhjxONvcCOwju7t+8uloWa1jDkVusdck
         N8zUGJYtZW9eZNDGWtJrsLp3PDvXmAktk6I20Yaa74rUndfvhzk9ukiINxi/8k0xKbfK
         Xv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqtbAvAHmmdh9xmOSDBaV1MZQO+Q4HHNpm/HXmo13CA=;
        b=DOPXMWQac6rNVCcFUSjx2f5nLIhAeEY/qC27eSvrnRjh9mFJ65obVi6BZJaziDS8wT
         zWZld7FyZwKCDh3vnOirn3mlrnhBuNsuMzfS1o0R03k5rlgtqxUlnemuJvRe+ahkLbd5
         h4LF0g3/DGloN1Lppdohp/ETDvxMuc+4p0Dmrsrx93WtFqQIedgew1KuV7O0nLg2s0/N
         6+Gy5AB4Abwt/cnP5Iq0jFQ9b0xXSWschrVmw//KVQFcpLGURJf2ez3N49CSbP09mkue
         du6ByCtzbGP5qj7xMctEeYXQVq0f9uAVgizDrkl6W9i0gPWx4hxHIhpHt1SkcMlxM5ay
         P8Xg==
X-Gm-Message-State: AHYfb5gtOEw45C6Phaxi6Aq3s14TcyanGKZf8i1xLTfJ24OHQ7WdwwWM
        pR8Gf/Ysje1j/G45
X-Received: by 10.28.174.209 with SMTP id x200mr1245498wme.106.1502801605770;
        Tue, 15 Aug 2017 05:53:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id k14sm4006617wrg.11.2017.08.15.05.53.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 05:53:24 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH/RFC 0/5] Some ThreadSanitizer-results
Date:   Tue, 15 Aug 2017 14:53:00 +0200
Message-Id: <cover.1502780343.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried running the test suite on Git compiled with ThreadSanitizer
(SANITIZE=thread). Maybe this series could be useful for someone else
trying to do the same. I needed the first patch to avoid warnings when
compiling, although it actually has nothing to do with threads.

The last four patches are about avoiding some issues where
ThreadSanitizer complains for reasonable reasons, but which to the best
of my understanding are not real problems. These patches could be useful
to make "actual" problems stand out more. Of course, if no-one ever runs
ThreadSanitizer, they are of little to no (or even negative) value...

I'll follow up with the two remaining issues that I found but which I do
not try to address in this series.

Martin

Martin Ågren (5):
  convert: initialize attr_action in convert_attrs
  pack-objects: take lock before accessing `remaining`
  Makefile: define GIT_THREAD_SANITIZER
  strbuf_reset: don't write to slopbuf with ThreadSanitizer
  ThreadSanitizer: add suppressions

 strbuf.h               | 12 ++++++++++++
 builtin/pack-objects.c |  6 ++++++
 convert.c              |  2 +-
 Makefile               |  3 +++
 .tsan-suppressions     | 12 ++++++++++++
 5 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 .tsan-suppressions

-- 
2.14.1.151.gdfeca7a7e

