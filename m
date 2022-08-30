Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83543ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiH3JeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiH3JdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:33:21 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C4DE1AA1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:42 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so7668972otr.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=En/qzvd2MWFQVk4Ig8VWybp1FCNQVM/mH8JkN+VK72o=;
        b=bG433KIx+FyrYZamBkPTPwGFeb+9ap+U2SmXgVrLMMQw5T6aGQrEX+9rjuxVW5Q+/q
         pKWyN2lb4tscNu8zSFqfBLQ3QLs01iKOjfCFPxICbCtTamOjNSWkG5SFvMMiVP+S+cou
         9yBrZU7BIDAnoPAIWegu+FzxFXay9et9i3DRFT080jmE36VkJ5QB9uxZAMW+sGSN1htD
         Mw+lDLAtwsFdco5oHMpHsAa0RjXctV4S1DWT7MTgvoTB45U051552DfVwXZsyf7kroZ8
         CORPFJC+CzZn2cZLZJwA/E228ulmSvjicjFyciXOiq/qzPjJlfrn4ZGqwuZPw7C/jsRR
         cuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=En/qzvd2MWFQVk4Ig8VWybp1FCNQVM/mH8JkN+VK72o=;
        b=ve6G0xVdGxm2yi6Kpd08a/ZFbB1oCkIEECyCz/a3stRFOzw0mn9QQQDr4hyeXSBBsV
         zHzukN22EsN3sTTDXgOql2bGnotmUFNlQAi4kcbZv7QdTWO7+o19wxv2fOuQ5vF89Rol
         ky+BYDyjlyAItg9j2YVEK/8JVQRvaOwOqCIfffCFyh59fKU4Bx43DCj8Bg7G7+3X0FYz
         QLI3tZjJ+IaX1aLHwkDc79XuUo5yauo/IrvWkgHYoQiPp20CMQETKqsTckybwZTVCc7G
         Y/Q2ZTrYfheEjpfJlh3uTZZOG9JZYSBn9K3g0U9jix1j63+zx0x40zDRlyxr/kILzBbi
         BGRA==
X-Gm-Message-State: ACgBeo3PPJej16FNCBIm1GIoeL+60l8IA8rPTzeToY+N3jh8H1dygpmp
        sWgu5rW3KNp6HZbNAdr1H6EHqK3C3LU=
X-Google-Smtp-Source: AA6agR5OeI+sLvsm+lfZ882HvniADwZVXwfw95JgJ3xKf45lTtqMgkBfv76UONJ0bnFuJa/fMVRyTw==
X-Received: by 2002:a9d:5f8e:0:b0:638:87d9:11ed with SMTP id g14-20020a9d5f8e000000b0063887d911edmr7809562oti.354.1661851960224;
        Tue, 30 Aug 2022 02:32:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r2-20020a056830134200b006370815815asm7033167otq.61.2022.08.30.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 35/51] completion: bash: improve __gitcomp description
Date:   Tue, 30 Aug 2022 04:31:22 -0500
Message-Id: <20220830093138.1581538-36-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does a lot more than what is stated now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e15538f53..6610054e0e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -324,8 +324,7 @@ __gitcompadd ()
 	done
 }
 
-# Generates completion reply, appending a space to possible completion words,
-# if necessary.
+# Creates completion replies, reorganizing options and adding suffixes as needed.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words.
 # 2: A prefix to be added to each possible completion word (optional).
-- 
2.37.2.351.g9bf691b78c.dirty

