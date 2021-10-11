Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CEC433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9310160F23
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhJKEMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 00:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJKEMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 00:12:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A087DC061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:10:55 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z40so14030889qko.7
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=E/NApoVytVaK+m5WqG/YiX2YS5ZdXT03Pk2c6IiiE14zM268NqiYnAmKbck4vIyAqB
         HDiMKwDlIy3g31bEoOOGnvgiVMbCmUC5fc4WWwmqyLLwGiSAGvkMXB/yZaKIqGKt+2BH
         M1TmL7fOx/j7HfNIeIWPN9YnQdVTEQ6/flQ2YBH25ET+osND/Cxb2ClTa6xF4sjPsjbn
         zDU0GjiffcQu5ommdtzQhw7s0puQ0XZeNsxE0mxwibqZ4CQbsDph8jauwit4qIdxRzs/
         yHxUGIeOT+/voOPOqcepvPBuu5FN9BUwTwhzRabuMKIkYZmcMcvskmETzu1NTu+gfONE
         x+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=Cd0+N18X6sPPsmRoOjlgwl3xePzgTzKi3vOZNVzPY2QruJEyA67YKHNVebyzhlanNy
         7uq9XA2oRD+fck9PBvIMLu4ScnhCA7C85X3YnLQb9CT3FOfBf4/GF8/hP4Z4urn67yzQ
         5YBR2MU/JxB3XC0+druaNSaU1aY+OQewq3Awz51YmVzJq+qC6SsB/GUtQYzSBQF1TT/B
         0x4vRxlQeBQKaW02d8tm0LIEUaDFKCSShI0qDUg9WWQ0OriTOaZxk4Bmj1FO01OsLgHs
         0c95WUUZlLRSXthWonhk2y6Jf2ORSpSYkUsY4UG1fyOnpw1A5Vw2x2Ux0/OFdEjKC6TA
         6iyw==
X-Gm-Message-State: AOAM532BLIfq8oOusTJTuI4ugjzm39utJm2P0w4tIiqbGtOhusJAHIg8
        faZ1uUInIGSicOmdLjam1hc=
X-Google-Smtp-Source: ABdhPJxIgiTMGi7gfe94RSTx+PsPqJKwE16wuPP+FsAlEU+Zg0JiXfbEouYnpKfwOCEVNuskWmXjwg==
X-Received: by 2002:ae9:d842:: with SMTP id u63mr13462424qkf.44.1633925454920;
        Sun, 10 Oct 2021 21:10:54 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id 74sm3683814qke.109.2021.10.10.21.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 21:10:54 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v7 1/3] send-email: terminate --git-completion-helper with LF
Date:   Mon, 11 Oct 2021 00:10:31 -0400
Message-Id: <20211011041033.20004-2-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
References: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike other Git subcommands, "git send-email" leaves its output an
incomplete line when "--git-completion-helper" is asked.  Be consistent
by terminating the message with LF here.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e65d969d0b..d1731c1755 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -114,7 +114,7 @@ sub usage {
 }
 
 sub completion_helper {
-    print Git::command('format-patch', '--git-completion-helper');
+    print Git::command('format-patch', '--git-completion-helper'), "\n";
     exit(0);
 }
 
-- 
2.33.0

