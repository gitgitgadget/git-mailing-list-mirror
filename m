Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B451F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756086AbeBOV4t (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:56:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50902 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755954AbeBOV4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:56:24 -0500
Received: by mail-wm0-f67.google.com with SMTP id k87so3512558wmi.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 13:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5THuskS5myWi9hh/LkCc4qjJz0dWR/O7AW/uXvPwo4o=;
        b=SAJcH6gqI73ZAXeF+4ET32RoWS47HgI70nfgxtH5GBHY1vxflH5IYVjMSSNlCrCgdn
         IOc2mPjhE/13BdETfebyx7U0/NDkLbMMIvm/8lgnLu+86iuMkyeCL+bRCy9uC3XvLLNe
         uYPw+xJBh0R9/aKbAT6F9DEvcuS0BKSR4jLko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5THuskS5myWi9hh/LkCc4qjJz0dWR/O7AW/uXvPwo4o=;
        b=B0M7aypVz9i3U3Veje/ZRvTP2u9h4nweoNiUPs+r2y1NRJ3IIjIo/TQTyH9/XOwO4Q
         qkOn7iO/jqSpg1+igNLcc0LKWNqHhw5lIrSeUiy7cX1ygOWZsNhPYYxLQbByUWk9ACHd
         nyO0wvyv7MJnOsirdfbuheHHqChJ4CA+BsFMzkM9z925TDL77CtuILVaXggPVxJXznON
         J0DhYDn7vlW7Fxry/zZM/zQu8pziHYaRUVRQ1zEV3ddDIbd8PEg0MYo+Yz1RbOpPR1Z3
         Y2iWW09wOCfM0htyxjmGBvZJGTWTwSykSR25IoJyVYYN9w0/MFgT5z/2S9Jqr4JglnVJ
         UdyA==
X-Gm-Message-State: APf1xPD9xnBMwITZ7coGkrpdykJYnOEmrmuC1zt0E+I9b8zCJrvEXZS2
        VZMBBEx9hWYdOlSxMQoP7n2xOpzPb0A=
X-Google-Smtp-Source: AH8x226i3w5qYqmqGSjSajW40dnvcjcC7OgIgHMkUv23syj7XD48f4NMVjVrtRoq7Qt0rIj9g/C6cA==
X-Received: by 10.80.204.3 with SMTP id m3mr3796004edi.69.1518731782873;
        Thu, 15 Feb 2018 13:56:22 -0800 (PST)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-126-104.cgn.ip.fibianet.dk. [5.186.126.104])
        by smtp.gmail.com with ESMTPSA id d60sm11476124edc.40.2018.02.15.13.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Feb 2018 13:56:22 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 0/3] a few grep patches
Date:   Thu, 15 Feb 2018 22:56:12 +0100
Message-Id: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I believe the first two should be ok, but I'm not sure what I myself
think of the third one. Perhaps the saving is not worth the
complexity, but it does annoy my optimization nerve to see all the
unnecessary duplicated work being done.

Rasmus Villemoes (3):
  grep: move grep_source_init outside critical section
  grep: simplify grep_oid and grep_file
  grep: avoid one strdup() per file

 builtin/grep.c | 25 ++++++++++++-------------
 grep.c         |  8 ++++++--
 2 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.15.1

