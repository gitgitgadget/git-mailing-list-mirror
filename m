Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0520E75433
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjJCIcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbjJCIcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:32:00 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7324FA9
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696321514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LvfYmotG7erL5rbnuC+IdRotg5lnpTcnMeZNVSOBIOs=;
        b=SL/boN+I24qaw2wfFzy+X3EQ1vznJa13F8qw9DyJmNMaPkmB2yaEmXbQYkpJXAFV2TxEbs
        p2l4aJceHQkp/3zQTb7mR5545qOVHoxI4AGecAicRuD0dsbiN8LWx6p/yY/uXhvBvUNWbZ
        /4TwEc3gry8/aeSKLSICqar5ZFuZfz1fqs6rpGP/zv6iYwxJqFGwfrXJKhd/RchdOHyTb4
        q71mHrzKUBRlo9tFUtaa+FjSmnp75/CZDGPh08EAVigrV70aSpWj30xOuMCpXU1CFg7vE2
        21Vq5ksshuMXfFtTWG50J27wW7f0FeTIqJYD85uRPS+AmKqBYV2UdZk+MIkR3Q==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 97f0ba4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Oct 2023 10:25:14 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [PATCH] doc/cat-file: clarify description regarding various command forms
Date:   Tue,  3 Oct 2023 10:25:13 +0200
Message-ID: <20231003082513.3003520-1-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The DESCRIPTION's "first form" is actually the 1st, 2nd, 3rd and 5th
form in SYNOPSIS, the "second form" is the 4th one.

Interestingly, this state of affairs was introduced in
97fe7250753b (cat-file docs: fix SYNOPSIS and "-h" output, 2021-12-28)
with the claim of "Now the two will match again." ("the two" being
DESCRIPTION and SYNOPSIS)...

Ordinals are hard, let's try talking about batch and non-batch mode
instead.

Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 Documentation/git-cat-file.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 0e4936d18263..1957f90335a4 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -20,12 +20,15 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-In its first form, the command provides the content or the type of an object in
+This command can operate in two modes, depending on whether an option from
+the `--batch` family is specified.
+
+In non-batch mode, the command provides the content or the type of an object in
 the repository. The type is required unless `-t` or `-p` is used to find the
 object type, or `-s` is used to find the object size, or `--textconv` or
 `--filters` is used (which imply type "blob").
 
-In the second form, a list of objects (separated by linefeeds) is provided on
+In batch mode, a list of objects (separated by linefeeds) is provided on
 stdin, and the SHA-1, type, and size of each object is printed on stdout. The
 output format can be overridden using the optional `<format>` argument. If
 either `--textconv` or `--filters` was specified, the input is expected to

base-commit: d0e8084c65cbf949038ae4cc344ac2c2efd77415
-- 
2.42.0

