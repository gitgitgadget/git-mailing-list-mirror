Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2484EE95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344523AbjJHGp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344496AbjJHGpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BBADF
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4054496bde3so32184925e9.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747538; x=1697352338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/1SDvXfsUtWSWBFkWmy7XN1ArggkElL0U4XLCF98DU=;
        b=cbhjZdkiY8tH/KPiW94twAn+6CUsJW2I1lxFuxp8VQZKaXthOc1tdqZ1nhArLbsKxo
         I8DR2XKDowikuk7prAJaVrB4XiN8CCrCw+pp8dScvne25YvDopyb+LDcAgKmi5Ji48Zw
         7gSR9ckic8AJe15FmzdmeqElc+XHwISmFNUWRc7hZ/GjCncyRzBQxapHMtNx13YrRsp6
         fR65DSmy48YQDzRJmR3aQPoFi+25Q2dn+rS8GmQF6pKTFP51voYjqozXp08n9Z1p/NcK
         +Mr394qeYAzQZ+Ui5MUV8+ULFBO1miBq3hgvK3Zjhm3s/1tTIc8MCiKCfsBOoFbg/DLI
         xDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747538; x=1697352338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/1SDvXfsUtWSWBFkWmy7XN1ArggkElL0U4XLCF98DU=;
        b=YMcQV0VLjRif57XSdEFcZSgA+ptkH+dI7EquQDzynMahBmVcP9tbVjI6RJ/k0KieiZ
         Th57zo6A36epLFMBUhmQfA2L/jR5RY73MF9672ZnBpiCXUS6SSds0mWKFAoREOE6lMtM
         SrpN7PDR9bktnddHVj2l3jeIgrtBTixnJfEFF7v+08fKAFfKIy0vHCDW2/KJNTZc+bAE
         Tebboqyc5Z1tHjd08PcRFHHLgB787tBQUHrhrGRS1rl1TNV2PU+ZO81QTGj5kFvD4evN
         pIheD6OaOteN4QlU8NQVkB4OI8GSUpC6yFjqOkshawmsmaZ//2sDHoxJa65jiYjHdWcT
         euNA==
X-Gm-Message-State: AOJu0YxQ0/RDrB0KiNhh3PZYkoVRRIeGIZkxMrn9sZgQvTH6WUKayBFk
        C7bFex5sUTs5ovfpUx8nf+1A1rhveyk=
X-Google-Smtp-Source: AGHT+IG3+88LNtcle55HVDjm1Ge9uPPLR8vdjZgA1CaUrw8V/4/oM57TPAE+A1Vh+vpJLE8bv4su3w==
X-Received: by 2002:a7b:c40a:0:b0:401:23fc:1f92 with SMTP id k10-20020a7bc40a000000b0040123fc1f92mr11318566wmi.25.1696747537724;
        Sat, 07 Oct 2023 23:45:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b004054dcbf92asm7773276wmi.20.2023.10.07.23.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:37 -0700 (PDT)
Message-ID: <4ff24f3cb24605a892d84baf98a327f55b5817fa.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:13 +0000
Subject: [PATCH 11/25] documentation: fix verb vs. noun
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/imap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/imap.txt b/Documentation/config/imap.txt
index fa0dccc3d83..3d28f726437 100644
--- a/Documentation/config/imap.txt
+++ b/Documentation/config/imap.txt
@@ -4,7 +4,7 @@ imap.folder::
 	"[Gmail]/Drafts". Required.
 
 imap.tunnel::
-	Command used to setup a tunnel to the IMAP server through which
+	Command used to set up a tunnel to the IMAP server through which
 	commands will be piped instead of using a direct network connection
 	to the server. Required when imap.host is not set.
 
-- 
gitgitgadget

