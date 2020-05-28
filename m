Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4E7C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 08:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D6D2063A
	for <git@archiver.kernel.org>; Thu, 28 May 2020 08:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVh6sFdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgE1Ih7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 04:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgE1Ih6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 04:37:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA9AC05BD1E
        for <git@vger.kernel.org>; Thu, 28 May 2020 01:37:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z15so1935018pjb.0
        for <git@vger.kernel.org>; Thu, 28 May 2020 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3tYNF5OIXHAHKJZ+8I7e+vdmXfqleFT72/a7tvS0DE=;
        b=qVh6sFdqKQK7o8kSTe086ir7L0s1fFN8AcOwHWScYsfFq1JGTnN0q+nSJXTsWrlzPY
         2Dkc+QTq8KWIBGZlfHaRNV4IPcpoOMatIoocpShPkGr968JCtnPVUA3787QGyThMcLva
         Mcz+Ar+12y9Zkq21IVTBHk/S1km4QEnv/SrWeo15tMzfrl8HlZpE3ph2l/lrIUn7XnZy
         BMqURqKnYIVr6tkmXCzOjt/CU7kxDOyWM+7s1fES9j/zar9lUi5/aGN2Fy6O+oyz4K3p
         vzVl2teUJk0QAMfZjblc1obtB8N1vY2Ro/SHstGZ/xQjNEn6PjPHOi7EiOHL0MNip7B1
         2dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3tYNF5OIXHAHKJZ+8I7e+vdmXfqleFT72/a7tvS0DE=;
        b=tCtlDSEh4kgUsfYTdeTmKGb31ODMQ+gs2JE3vETufrTc7Zr8G9mWkf0JiQZ6ZHLFcg
         Ycih/pTPM4wFzptGyKnOVVgKQK7qR30puJEB3Ezr9I3betB+zhB2dkQ58n/1H4UGwka7
         +U7yLjBzpzntcCARBa/QhrRZOZ90hl5kwPTmq+6UkHjSrF8R6U6iZGw5vzzFp4QC/Xap
         iQvKwCsKsz81X06aKoLWYO1WUrCs3vCC3RcPnVvjHnT+EDr0LHNz+MCn7A6+TQvsorQe
         9+9BT4baXdd7ZqZW6+kVEa5u0HbPx/k3+thozNGkMOAXLmOQcLa1nAfgGAiK8ydjff52
         kImg==
X-Gm-Message-State: AOAM532bD40S1aTyFQuFvIMCAkKRIbhhKTxEBFP9eOUo40/rzfaN93Bp
        lFaENEWKi5dmQebtohksS7AOGn8S
X-Google-Smtp-Source: ABdhPJzvXzs6Qxq3MUxj5e0R8IWsgeaOTMCo7sm5hd8KEWeVBKnHpbJufp46BhE1gCXqxUQraX9/9Q==
X-Received: by 2002:a17:90b:b0e:: with SMTP id bf14mr2555451pjb.98.1590655077693;
        Thu, 28 May 2020 01:37:57 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id y5sm4041886pff.150.2020.05.28.01.37.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 01:37:57 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hji@dyntopia.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] t: avoid alternation (not POSIX) in grep's BRE
Date:   Thu, 28 May 2020 01:37:45 -0700
Message-Id: <20200528083745.15273-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc2.257.gaada2199e1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using and escaped '|' for alternations is allowed in some implementations
of grep (GNU and busybox, al least), but it is no suppored by POSIX[1]
and therefore will fail in at least macOS and the BSD.

Change syntax to ERE and use Extended regular expression with grep
explicitly.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03

Fixes: f1e3df3169 (t: increase test coverage of signature verification
       output, 2020-03-04)
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t4202-log.sh           | 2 +-
 t/t6200-fmt-merge-msg.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index f1ea7d97f5..a0930599aa 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1692,7 +1692,7 @@ test_expect_success GPG 'log --graph --show-signature for merged tag with missin
 	GNUPGHOME=. git log --graph --show-signature -n1 plain-nokey >actual &&
 	grep "^|\\\  merged tag" actual &&
 	grep "^| | gpg: Signature made" actual &&
-	grep "^| | gpg: Can'"'"'t check signature: \(public key not found\|No public key\)" actual
+	grep -E "^| | gpg: Can'"'"'t check signature: (public key not found|No public key)" actual
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag with bad signature' '
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index b15582a7a2..e4c2a6eca4 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -103,7 +103,7 @@ test_expect_success GPG 'message for merging local tag signed by unknown key' '
 	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
 	grep "^# gpg: Signature made" actual &&
-	grep "^# gpg: Can${apos}t check signature: \(public key not found\|No public key\)" actual
+	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
 '
 
 test_expect_success 'message for merging external branch' '
-- 
2.27.0.rc2.257.gaada2199e1

