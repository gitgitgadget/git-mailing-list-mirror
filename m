Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A2C33CB2
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8416724658
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD15EvVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgANSoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:44:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53437 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgANSoE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:44:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so15040953wmc.3
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=prnawxM73KG9YEc4YMrhTFoFBf5A8wYjttJZSeSVNhc=;
        b=ZD15EvVkwAdd6BlfHe8AI/KRnmzWGQnJNbkXg5/2XH1hWykgE1kjLt4kIIxOXnU7tg
         dvCuuYyr0jUZYQo1M6fxjRBjfUjHoZIi3J3i9v4HgPqqpFfQuIiEskI9qb3T4GJltGf/
         HLRsnazSoJ/A4Xa5UHDgQEk9tneeW2tzodlKbeHYGACzMe/pAuzKsRfMapa/vhgUfb1L
         UUHlusmHSQf4coA9XbVPjmxSWKoRBHSbxXATyCpM6drgJhEEqxIzTmcjD/DFWo3ID/Sk
         FknB9IgD7cFhrnDcyDYmqJEsdwn2lFumYuJBlL8D/CYwVNsucubKwrxDVFiRoKT+gj0E
         eyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=prnawxM73KG9YEc4YMrhTFoFBf5A8wYjttJZSeSVNhc=;
        b=DfITWNH6LRu3oMgVu+RYgh5dbP4nIBgrwOR48gNsuasZO7yHpTjvst2BBsAeMFEnRA
         +9UMeZ5Gq0ipYs8xbO6BmJPV+ZjStE4TtD5BtaJooFXVDUC6q49oQ0JYCKPfJtkP+RYm
         radbN15sGli5gBoxocKyQBakypYd4mQuPcnmpR2Yl7Ey5c0bBcFYJ+URPwS0iDLNlC3x
         9YH+4//s5YmmnwGMzlIepblevtCs5LNyLffU3BhkJKIfQKxUliDep9fvBkYZOfQOKHmx
         nV73/hGf2y1MWrliozkb/OVsGIk60CHjH9Sh7UNY5PTIGf5EtpqQGtnfid37pY0dz5x0
         06Ag==
X-Gm-Message-State: APjAAAVWdPy5ADjn7scCjOMqHX7eGEkCE/+hA/UbbvmX336KVBMJ4zoL
        fxrsJl3uGLi45+wx0NljcxjyNWyY
X-Google-Smtp-Source: APXvYqwYwvKYXqSVqqUD7FVWYzacuf6ITTz03xg5mCm4n+gojanZCgsIcJXNOoNaVJXZGFIxMmwVrQ==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr27651277wmf.60.1579027442875;
        Tue, 14 Jan 2020 10:44:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm21015337wrp.69.2020.01.14.10.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:44:02 -0800 (PST)
Message-Id: <7ab7ec62d0d67c0adbef54d2a363c77a12d689bc.1579027433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:53 +0000
Subject: [PATCH v4 10/10] ci: include the built-in `git add -i` in the
 `linux-gcc` job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This job runs the test suite twice, once in regular mode, and once with
a whole slew of `GIT_TEST_*` variables set.

Now that the built-in version of `git add --interactive` is
feature-complete, let's also throw `GIT_TEST_ADD_I_USE_BUILTIN` into
that fray.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index ff0ef7f08e..4df54c4efe 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -20,6 +20,7 @@ linux-gcc)
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
+	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	make test
 	;;
 linux-gcc-4.8)
-- 
gitgitgadget
