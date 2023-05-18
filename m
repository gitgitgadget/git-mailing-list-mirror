Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14082C77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjERUEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjERUDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F6210E6
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3078d1c8828so2341221f8f.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440215; x=1687032215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdzRST7dXwJS32J+quJIiHJUCxEYeHVLa5ls61tRwk4=;
        b=mxPw8taOxHDRGzCllz+8O5yM4RdhwhZERywBqzj9Eez6V57CmjxR6RGgtOrF39466l
         fJVvgGNMh24dCQmwjKW7ikR5vMF0dBga6bHPMtZgsZbl6IdW4Vtwbjw95+DooRV2w0U4
         JKoW5JH8Hz2PHOltJ3HXuIyfzjrxCx6OZWTPUWZVFCTxQ9v1YroIjw4Z3e8jWL5Ikocr
         V8LljlNN58Zuz9t0qDN4H+eVfQkNPG1BjkDQNgg+zLEyTF/qd6BJVYLaMFOhq7cN7Qvb
         Qix1h/6Re1lj1c/ddtNPmlFczSuEQq+q3+I4ffLWdxAA9l+gd1viQVxjv06naicfksjg
         GOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440215; x=1687032215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdzRST7dXwJS32J+quJIiHJUCxEYeHVLa5ls61tRwk4=;
        b=PuA44AcW/pcyJWCcwAwPoCFMOuO9U/w7Ddyz4wuvkRwHTmvZIP0LHScMmjzb55J0Ip
         QICRvXsccn4Wjgk+g+nHFvgz9e/62vVepQ5KLtDR2KEl7gkIj64v+AqseajSeXfdR3bd
         2Rd9guNIC75DKQ/nT7RGcVt95M7ctRqTPCZAPp9jD1O+4PkUu/hY5yJbayMzJ05wd7Bg
         t4qDw16lWogeIMFiq/jSOwqowL/dlradfxb2Az0fp8uyBB9ddFZFzKrO/ICPAeTURuRm
         wiYf8VOJwCgnV+OXJa2k3CbSLOU8AqSLYK2cmVq8GHo1esKNJSlPrZzC8IPUrbRmrHTD
         zihw==
X-Gm-Message-State: AC+VfDzlkCXsTXlbNcGI7PFOrczq5wqIROWp61CJ5NsFyqRaIqRFKyou
        qZW7Vkr4tb0cplU72z+KNEtI4sBsRBc=
X-Google-Smtp-Source: ACHHUZ52FAXhGC2OONUL4Kmvvgp9yndHvIhioPIF1oFaBgLbuQqBnQiI/2IMkrvuj9et/fqWqEJGDw==
X-Received: by 2002:a5d:6a52:0:b0:309:3bc3:7d1f with SMTP id t18-20020a5d6a52000000b003093bc37d1fmr2128293wrw.70.1684440215274;
        Thu, 18 May 2023 13:03:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003f4247fbb5fsm240767wmc.10.2023.05.18.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:34 -0700 (PDT)
Message-Id: <7c2903d1fe913ec3cc38cda7ec18bcc225751dc3.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:18 +0000
Subject: [PATCH 13/20] t4202-log: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t4202-log.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index ae73aef922f..f5c0f06a56b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2343,10 +2343,10 @@ test_expect_success 'log --decorate does not include things outside filter' '
 '
 
 test_expect_success 'log --end-of-options' '
-       git update-ref refs/heads/--source HEAD &&
-       git log --end-of-options --source >actual &&
-       git log >expect &&
-       test_cmp expect actual
+	git update-ref refs/heads/--source HEAD &&
+	git log --end-of-options --source >actual &&
+	git log >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'set up commits with different authors' '
-- 
gitgitgadget

