Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F76C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E33C206D8
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 13:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSO+w/07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgG2Njw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgG2Njw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 09:39:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B7DC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 06:39:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so21672524wrh.10
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1O5YLrMD6UBAo8LidSc2ZKFcCsoXwe0b47LYbcJVrfU=;
        b=NSO+w/07CgIUgpiPRaSmD/TXNT5/6GnCPvG71lk0Eqj2bqPIe1yiRMxoR4S+D8KLhl
         wHivYqrBAb7n3ghMZxo8GYUrx7WYV0ox/UgFBWohzk5WxYyadmkB+BYWyTdoU7sBTWdy
         xXZT518ShPsLrCHfA4vyjEWY5tmw4vsXTNzhbGbohgKOSDHaPzXcmawVDpRfkBy1KhnA
         qEhy24D4kIn3sz8OQjP9gaXSkI7e8Y4g7dXv+abG/ma7vgnlTVirTwZm7gMZ1A0WNNPz
         uiWJwI5qAUK6rvCEzXg8+4T+O2clrlpomjhaxR8swNGr6Bcla2Ky4uYAnkattn6ejtlT
         NHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1O5YLrMD6UBAo8LidSc2ZKFcCsoXwe0b47LYbcJVrfU=;
        b=t6W2hccrKbbNKhCwpF7GU0krnax63zet5GWoC/d2X9PEMfzLfDaQPnV3hnuqtbqvht
         Rl5rEpOBvaSl/OhKRaU2/RGvRPMbXyRKQKcfOx3kz+iL+LRM3fHoCr5t3Re5atbBavL6
         Sv7bzsXTMZPV0PgA+QDiVBUjjZAGat79DkZWoXOHA6UFqCQ++IEbnARk2ol/ommRpurX
         9AdYYMUluYZwv6ugXfABocjNvUgtoacXZyJBQk1uzO2EBVdiEBUi/J3mvLA0e4kwe20J
         GZXqjj1IfuqjaDLaTfrluNhjCaENBufkBL73KHKSeQMsjuUAtGApzPG/aXPZtcVI+pAf
         KoyA==
X-Gm-Message-State: AOAM530QjvOZMfciJ/gb2q7JgV1jFrBmIK6FguMubVjc4v/OqYxWHd9K
        OO73quQlQLuGSJSOuPt28JGmeRjc
X-Google-Smtp-Source: ABdhPJwQHzOeKc2Af0+W5d40zD3yXMLJOXA2jZ/h8FD0fqg0ofVcTQfwMr4OZGG/sWgruFqFc35/xA==
X-Received: by 2002:adf:c986:: with SMTP id f6mr30291474wrh.168.1596029990348;
        Wed, 29 Jul 2020 06:39:50 -0700 (PDT)
Received: from rybak.office.devexperts.com (aftr-62-216-206-115.dynamic.mnet-online.de. [62.216.206.115])
        by smtp.googlemail.com with ESMTPSA id o7sm5292619wrv.50.2020.07.29.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 06:39:49 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org, philipoakley@iee.email
Subject: [PATCH] git-help.txt: fix mentions of option --guides
Date:   Wed, 29 Jul 2020 15:39:48 +0200
Message-Id: <20200729133948.538-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix typos introduced in commit a133737b80 ("doc: include --guide option
description for "git help"", 2013-04-02).

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/git-help.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index f71db0daa2..69c0c5c34e 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all [--[no-]verbose]] [-g|--guide]
+'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
@@ -21,7 +21,7 @@ on the standard output.
 If the option `--all` or `-a` is given, all available commands are
 printed on the standard output.
 
-If the option `--guide` or `-g` is given, a list of the useful
+If the option `--guides` or `-g` is given, a list of the useful
 Git guides is also printed on the standard output.
 
 If a command, or a guide, is given, a manual page for that command or
-- 
2.28.0.windows.1

