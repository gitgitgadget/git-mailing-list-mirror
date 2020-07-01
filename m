Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE5EC433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296A320760
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovQ5Kip8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGAE1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGAE1b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 00:27:31 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9093C03E979
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so10398182qkg.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAbR0wwvA+x9vSI9jWWmVAcNopC8aAbgSqCtK37T0D8=;
        b=ovQ5Kip8BsyouTRkyxQexHwZfXzAt3c+eQyk0BYTW3yfUz9ZDKTLv0GAWBpcG1q6NA
         h+OMElNAeOjx3cyqKYtXRHxjmv6Xj4eRPqDifvRk/1ZmF6Jm00KkTywzRwvThAYYhsVb
         Izge5ZWxqQpcdqV21p3bixpb44sz9VdlHPiMd4ine4fJeYzkcL8+/WCi4CrYXAjEe7Hm
         dGSvKvV921M1TBKlvQeFc8SEFuZwiV17tJ2bnfLPFguz1CdvwXY05odxbhIjiY+xNMmf
         SJEY8SZFeoyu4/OBqbJqKoHlYHPFVJOs0XSTOqEEJQ/Uq5E2aknUVTJnAL68eowoUfby
         hFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAbR0wwvA+x9vSI9jWWmVAcNopC8aAbgSqCtK37T0D8=;
        b=oa06lfg/niAqvqo2kipeJmS5stqCB6MN12SaOv90CfahnqgbBhKNj0il1zIG6ZUWjQ
         LzPTHQhFq//uExe66WsImzqJda5NXai5HDb8KtwNrLr/FbcZV1DAub0Ch6Pln0+A0uUf
         3AE5x//mcEkeHgc9w9j/kqjx9sBeMup1U+qAjmNBZWzCD9a1M5NOnGlPUBmJIL2ICnDR
         5z/bkH1jYf/S3Y7YkhJX2NnpMAlVCCuvmReBN0FPAXVgF3ZOGYRnBeZ99t8twSob7qlv
         jZ7WfJgDqYKQqDvM6Xa0EmMGPA/v7l25kriFY1Y1NRyw2ulVe4WDXFO/jgRIFC7cnpKu
         lHwQ==
X-Gm-Message-State: AOAM533cBgFDwWvs3EN/si5wUcR+HjOWtTF2HPNYUMThMvhoY4fdN77I
        iyBE8Q4xby4LO+SIW7cfSTMIDp+glb8=
X-Google-Smtp-Source: ABdhPJz6NWf9zqrOEU2IdbhWCuVKISF4gW1Z1hbyNsrr1KzlIxDY0nJ4ESaoKjBLg9O2o2q5RZLcUQ==
X-Received: by 2002:a05:620a:6c3:: with SMTP id 3mr23034158qky.400.1593577650027;
        Tue, 30 Jun 2020 21:27:30 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id x13sm4418813qts.57.2020.06.30.21.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 21:27:29 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] t9834: remove use of `test_might_fail p4`
Date:   Wed,  1 Jul 2020 00:27:12 -0400
Message-Id: <92d3b38428adaf0befc6eecb8a4669306d0d4276.1593576602.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593576601.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com> <cover.1593576601.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Replace test_might_fail() with
a compound command wrapping the old p4 invocation that always returns 0.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t9834-git-p4-file-dir-bug.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
index 031e1f8668..dac67e89d7 100755
--- a/t/t9834-git-p4-file-dir-bug.sh
+++ b/t/t9834-git-p4-file-dir-bug.sh
@@ -10,7 +10,7 @@ repository.'
 
 test_expect_success 'start p4d' '
 	start_p4d &&
-	test_might_fail p4 configure set submit.collision.check=0
+	{ p4 configure set submit.collision.check=0 || :; }
 '
 
 test_expect_success 'init depot' '
-- 
2.27.0.383.g050319c2ae

