Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32B71F404
	for <e@80x24.org>; Sat, 14 Apr 2018 00:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbeDNAdn (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 20:33:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37206 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeDNAdn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 20:33:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id l49so12067820wrl.4
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 17:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h49z7a4o85HdtuJz0rf202CoAYDEKHPSu2qCDuA9dOA=;
        b=bi39MiNPs/7rNe0CEmoC4u8VpiqX1AiWBhDXUxbQN0MM7U7K5o85VOGmx8kvZy8lZE
         R3gxGEIUNac/TOQ7LlgVqFN400Dvj5OEluHTaWLHUo4KPQLGtVjb8ue3tDRm0DEXtoCh
         o7BtC4v/kpJk8FteymanM7TVK8/Cu46zC2yAOo9IZ9tPBloJD0GNo77Gw20cS3boMCAE
         T1ZkeTXfougwslVBXnBsct5flY8+HBNPrfxFPEs855JBojDndwq43iB3xOzP79UW5dpK
         Hol//VZBUG+kcc9GIHk/kiyP9oYxqbEDPtMYE/4Y7EhIrVl53L+3r4xatJrAHxEQ/eT8
         6t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h49z7a4o85HdtuJz0rf202CoAYDEKHPSu2qCDuA9dOA=;
        b=AfKdV4jmvXEQQv+v3J6jo9vJU3zV46WgiSG86czU5bRH3tOdTEWyfxnfrm6gUfd7fK
         23gi+Q4e7lmOaZhQcXwatx99igAQjRLfxZynrIAz8xVTj7fdCTMc+6CM2YPxFczdxuNn
         GHigFKvQLsFZOAPwQWy3Kig59QILaQkuLPXX2JUChEfgGEgdZoY9WvzZ/ejZfV8xvhWf
         N/azdXvMZj1k+Woc/jX1v/VGmFKGEF9CH1VPWLckiW7zH9SSvevE4/pe7XfNLKXBBcf2
         /a3p5qZA19pT0VSRLNvI+AS9AMl956bpZPMWhH52+lzp6voON3m522CqiOwYIFP8uJ3H
         5kQQ==
X-Gm-Message-State: ALQs6tDrJ5UZuyjmdUal3cgYpeB9x4MSWIDifUVeutLaWtW5UYOVY69L
        Oo7LyGU6CGhf3E5FgnlXHzrEuPXo
X-Google-Smtp-Source: AIpwx4+/LF792p1dFGQ4wXJQS3rCX2D5SRnRK886lZEHmc4NxrHnY1qCVt9unwaEMlvMyMlwv+wVYA==
X-Received: by 10.80.137.149 with SMTP id g21mr22620622edg.25.1523666021570;
        Fri, 13 Apr 2018 17:33:41 -0700 (PDT)
Received: from klatch.dhcp.info.ucl.ac.be ([2001:6a8:308f:2:3600:5fac:3b21:8777])
        by smtp.gmail.com with ESMTPSA id h38sm2288465edb.10.2018.04.13.17.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 17:33:41 -0700 (PDT)
From:   Guillaume Maudoux <layus.on@gmail.com>
X-Google-Original-From: Guillaume Maudoux <layus.on@gail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Guillaume Maudoux <layus.on@gmail.com>
Subject: [RFC PATCH] tests: fix PATH for GIT_TEST_INSTALLED tests
Date:   Sat, 14 Apr 2018 02:33:38 +0200
Message-Id: <20180414003338.27091-1-layus.on@gail.com>
X-Mailer: git-send-email 2.17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Guillaume Maudoux <layus.on@gmail.com>

When running tests on an existing git installation with
GIT_TEST_INSTALLED (as described in t/README), the test helpers are
missing in the PATH.

This fixes the test suite in a way that allows all the tests to pass.

Signed-off-by: Guillaume Maudoux <layus.on@gmail.com>
---

This is more a bug report than a real patch. The issue is described
above and this patch does solve it. I however think that someone with
more knowledge should refactor all that chunck of code that was last
changed in 2010.

In particular, it seems that the GIT_TEST_INSTALLED path does not use
bin-wrappers at all. This may imply that --with-dashes also breaks
tests.

 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git t/test-lib.sh t/test-lib.sh
index 7740d511d..0d51261f7 100644
--- t/test-lib.sh
+++ t/test-lib.sh
@@ -923,7 +923,7 @@ elif test -n "$GIT_TEST_INSTALLED"
 then
 	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
 	error "Cannot run git from $GIT_TEST_INSTALLED."
-	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
+	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$GIT_BUILD_DIR:$PATH
 	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
 else # normal case, use ../bin-wrappers only unless $with_dashes:
 	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
-- 
2.17.0

