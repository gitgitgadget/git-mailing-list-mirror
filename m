Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D3AC1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeH2BVX (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:21:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52453 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeH2BVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:21:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id y139-v6so3244008wmc.2
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9qI9YGVxHhAnPHaM2V8kfrW6tc1ordgaVymY1dN67B0=;
        b=cPDFXJrt9SkBAgY+y59QjlVLjseXlZA1hAdGxGMeW3+P50LkNziNf2F+ybQ0xvXIGG
         OF7kij8UKqqnpn/TjC0UJzw+bXaeAqfy/DithfDF3YSnsnt9Pp8vSfKxTHFnbfN6DJFF
         QNBCfjYxynlY9pLFA0f+D8S4KmFuzx5SH8VDOh0j1hcrUaNgWt50y//jyJXXltk7NUaV
         VjxmPxvC4nXe1a4VGoTuFbhU3hsGhLOWIn1TWWHsM+C1ovLtejVMIoDvi7dSP02++JHn
         Oh50yQl0V9Clki0Y/l+Gaj4EUIxQd4JETBLw5iwjYUq5ryg+mbcSp964DClBb0cnLRar
         PfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9qI9YGVxHhAnPHaM2V8kfrW6tc1ordgaVymY1dN67B0=;
        b=hNSsfognsYkR9TOAnKMKxfbjy0b+27/MLfn5AWdY4kFxeQEY66yI/97+VVeIr3pMUw
         sEQiGwpiGIfOS+1fC7GpL8pJIJopa4Yhw4N+CQmr838dfpCWeKu7JzWK4nQ7vZNnn98y
         yVUs+lRw04JrWq40wMWVbH5jgXTurUL3NgkAVMsLQ+FQ83T45z1Iklob6alf+vknZr7M
         cxSLverhaot1GNGI1IJu2fDAMetqspVmc47IIoSRx876N35A8S5yjiGOYcqSZD82eh76
         Ngp3b3hm9fLKHFaDxYVEd8Ri/dBJJNscimCw1E5jnRvb2jMTfdQHLeRCDz3prR0qkaEM
         auTg==
X-Gm-Message-State: APzg51AuvWs2e08WGfESLAKeSBvgTe0L7G0SL2prRC20AKNHxxBdpEhV
        qtQALwuC3gm1JNpg5ZLhLyDxIgAg
X-Google-Smtp-Source: ANB0VdbbMq2Hg1uCQ0C1oFhLhDJWntwzvyRsgvnUy1kC/T+pIx0fkBmU/REur8+1w1SoAufcgF+BYA==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr2360060wma.85.1535491669715;
        Tue, 28 Aug 2018 14:27:49 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id 199-v6sm3778184wmp.37.2018.08.28.14.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 14:27:48 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/2] rerere: add note about files with existing conflict markers
Date:   Tue, 28 Aug 2018 22:27:44 +0100
Message-Id: <20180828212744.18714-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.1088.ge017bf2cd1
In-Reply-To: <20180828212744.18714-1-t.gummerer@gmail.com>
References: <20180824221005.5983-1-t.gummerer@gmail.com>
 <20180828212744.18714-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a file contains lines that look like conflict markers, 'git
rerere' may fail not be able to record a conflict resolution.
Emphasize that in the man page, and mention a possible workaround for
the issue.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Compared to v1, this now mentions the workaround of setting the
'conflict-marker-size', as mentioned in
<xmqqk1oblnor.fsf@gitster-ct.c.googlers.com>

 Documentation/git-rerere.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 031f31fa47..df310d2a58 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -211,6 +211,12 @@ would conflict the same way as the test merge you resolved earlier.
 'git rerere' will be run by 'git rebase' to help you resolve this
 conflict.
 
+[NOTE] 'git rerere' relies on the conflict markers in the file to
+detect the conflict.  If the file already contains lines that look the
+same as lines with conflict markers, 'git rerere' may fail to record a
+conflict resolution.  To work around this, the `conflict-marker-size`
+setting in linkgit:gitattributes[5] can be used.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.18.0.1088.ge017bf2cd1

