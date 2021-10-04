Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EBDC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288BB60F6E
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhJDTDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbhJDTDU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 15:03:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509FCC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 12:01:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x7so66627355edd.6
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dgj5lg7aBlw0FduMwbwfje/QFmuDp5IV0mw9ALApOpM=;
        b=ptU96YHqKAuHv1xJrqeKm5WMTBTQ/VpMX/KZxSdjeY1aSh2TT2Ky+7Aq5MPYKxD0wT
         YHSyXTtXlGG5oVtY4O+vR2RPt1Ju6C1zeXJGV36CWvAkrYDZlveh9Fii5JHD+9aW1Z6H
         8Wz/ev1ck5sDfUZwa+Wt7kRAOwoazVZEf0oFPAYPQnr3kzK3QOIhLqSpEclom6oQ/mOQ
         iFuV6svocicPl3T2zb3cblbsTCQ7RQVhc7H+qvKoAu7KiwzECfcyJDxfyg64sTR+gn0w
         BsjqVTs16V355HpTK3PYUutcY/Pza3TfFvIzROwxbWkxRc+zz70PfZMB8QohWVE5a+4f
         0L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dgj5lg7aBlw0FduMwbwfje/QFmuDp5IV0mw9ALApOpM=;
        b=EgNcy8W9DXWCPzW3c/PkqcR18RRXrzp9/tvrLQH3NKv1KBxTrvRFWCqUvwFqjZutDt
         8/h7x/DPCKkNoW0aUQFWM3ad525pfu5b5hulYmPwHltSaVOPHs8n8pnj9TWH8IcUbxCf
         25CkG27JvQmsRoHYFdgm/dGaoCr6VkXenoxRutbgpl5XhCBeZ2YnoyAw4R/BZCDuNooq
         Xp69JGoZOVBS0+LQSkmGlVBk+LufX1CA8XWEyenFG7YjyOK1xTpbf0zqpjoWoIO2WuXN
         yGKkyliAz72OqUR00GkInimqCAjDNU24Ad8Y/Pa4cQYdtmd6PKPZOLja68vKv7gpJlrt
         mmvA==
X-Gm-Message-State: AOAM5300wO+35obhaDJ9MBmHijDlLYnbX7e8cdwf+b+ZfnNorv9NwncJ
        MfTuSMsS53rZJmi8A3OPJwQ=
X-Google-Smtp-Source: ABdhPJyT+QSeGCLkWIVryM/gtQ4A/+uAnPY7ITObszm+6+TCf7imL5stw8RGOpFTHTYP9xgDwEYOFw==
X-Received: by 2002:a17:906:4c4a:: with SMTP id d10mr19649760ejw.391.1633374089957;
        Mon, 04 Oct 2021 12:01:29 -0700 (PDT)
Received: from localhost.localdomain (178.115.74.220.wireless.dyn.drei.com. [178.115.74.220])
        by smtp.gmail.com with ESMTPSA id v13sm6759357ejo.36.2021.10.04.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:01:29 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     newren@gmail.com
Cc:     aclopte@gmail.com, git@vger.kernel.org
Subject: [PATCH v2 3/4] Documentation/git-status: document porcelain status T (typechange)
Date:   Mon,  4 Oct 2021 21:00:49 +0200
Message-Id: <20211004190050.921109-3-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.dirty
In-Reply-To: <20211004190050.921109-1-aclopte@gmail.com>
References: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
 <20211004190050.921109-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported in [1], T is missing from the description of porcelain
status letters in git-status(1) (whereas T *is* documented in
git-diff-files(1) and friends). Document T right after M (modified)
because the two are very similar.

[1] https://github.com/fish-shell/fish-shell/issues/8311

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 Documentation/git-status.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 20f496094a..255dc6af9b 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -207,6 +207,7 @@ show tracked paths:
 
 * ' ' = unmodified
 * 'M' = modified
+* 'T' = file type changed (regular file, symbolic link or submodule)
 * 'A' = added
 * 'D' = deleted
 * 'R' = renamed
@@ -217,14 +218,16 @@ show tracked paths:
 X          Y     Meaning
 -------------------------------------------------
 	 [AMD]   not updated
-M        [ MD]   updated in index
-A        [ MD]   added to index
+M        [ MTD]  updated in index
+T        [ MTD]  type changed in index
+A        [ MTD]  added to index
 D                deleted from index
-R        [ MD]   renamed in index
-C        [ MD]   copied in index
-[MARC]           index and work tree matches
-[ MARC]     M    work tree changed since index
-[ MARC]     D    deleted in work tree
+R        [ MTD]  renamed in index
+C        [ MTD]  copied in index
+[MTARC]          index and work tree matches
+[ MTARC]    M    work tree changed since index
+[ MTARC]    T    type changed in work tree since index
+[ MTARC]    D    deleted in work tree
 	    R    renamed in work tree
 	    C    copied in work tree
 -------------------------------------------------
-- 
2.33.0.rc2.dirty

