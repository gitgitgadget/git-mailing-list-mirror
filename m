Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3677CCA47F
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 17:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiGSRZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiGSRZK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 13:25:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C7D2E2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:25:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so22642031wrq.7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6Wdk0yWu2g6RpIm6FVVGaxjmnLOMG+LIbB99uWjB4ic=;
        b=cNZKCnfZ7bHvkvUaVMtJIwQNRbncMAr1mRekiwcNvE+twi990PmtQI7b++UQroC5X/
         kHUTVFKqtNt91MO5nmRvudiWXBYN7FkB9Jqj+PtZWI1z4qggTOSQnkHr2CLti0YZavFC
         oaNfEPAwGItykFVwbEL3/XianeBS0Wdt7Z/T2LC+4VC5+Pe39PRgAl2sy2sV3XxkXPU2
         vWDQmsvdsnlrtg/HuDM+MgY3B8Mi4FTGj+ksghGAiBcEJaiEPlnoqfbuCQ8xGH3RmExS
         GQGuSZurH0E5psx9ydaTyvDy9j0jO1iS8RDMlw4v/F0Pv4MngLjRrR6kT+V3z1D4xR9t
         DJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Wdk0yWu2g6RpIm6FVVGaxjmnLOMG+LIbB99uWjB4ic=;
        b=4FwEQ5SubK4Xfr0hA1GW6rkwKAVSBJ84gEdQp+unn/cXmlbBTH+cJQvFOARtyCKDRU
         3v61HIYaJkRTtEmitNKFIAv89AhQVgp3xvfigncaMDR3ENJdWenAOemG59KTyB1B4OwD
         E3mLwhdAD1ibStCNOyQu1j0CW+OLYqyc1bx4CdIDcUEkFsFDk7cLED93mUaeMHYyXg7F
         yftDeaOkKmoIX79/0PcJmq8+SCNQmxx0uD+KJ8zQTC0JjKdsHL3pKyN/fZ0lNj0VLvuo
         DCewlBYSJ5Q2TH27AIRoFXIrwLbIUWTNBAy1TPc/DOQOu+I9aYJy64SigNSYtp9/p/vY
         3fNQ==
X-Gm-Message-State: AJIora+zmTMIpIXvzTvibhHsmIn5tM2IP/br9Vw820NrPij2gL0jaUGJ
        sYSSIL1IDAI96P/pip1ZvnDjMXzDYug=
X-Google-Smtp-Source: AGRyM1v7qOQh3+ekM7723Pe8MuYTkNCtyHrstzW0W0BmhcYWqQe0RWc5LjPXwuvuO6oUFltEEbj1dw==
X-Received: by 2002:a5d:5847:0:b0:21d:b75e:12d0 with SMTP id i7-20020a5d5847000000b0021db75e12d0mr26799869wrf.208.1658251505121;
        Tue, 19 Jul 2022 10:25:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b003a31fd05e0fsm5347038wms.2.2022.07.19.10.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:25:04 -0700 (PDT)
Message-Id: <pull.1293.git.1658251503775.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 17:25:03 +0000
Subject: [PATCH] osx-keychain: fix compiler warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Update git-credential-osxkeychain.c to remove 'format string is not a string
literal (potentially insecure)' compiler warning by treating the string as
an argument.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
    osx-keychain: fix compiler warning
    
    Running make in contrib/credential/osxkeychain currently shows the
    following warning:
    
    warning: format string is not a string literal (potentially insecure)
    
    This small change to treat the string as an argument fixes the issue.
    
    Thanks, Lessley

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1293%2Fldennington%2Ffix-osx-keychain-warning-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1293/ldennington/fix-osx-keychain-warning-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1293

 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 0b44a9b7cc6..bf77748d602 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -168,7 +168,7 @@ int main(int argc, const char **argv)
 		"usage: git credential-osxkeychain <get|store|erase>";
 
 	if (!argv[1])
-		die(usage);
+		die("%s", usage);
 
 	read_credential();
 

base-commit: 71a8fab31b70c417e8f5b5f716581f89955a7082
-- 
gitgitgadget
