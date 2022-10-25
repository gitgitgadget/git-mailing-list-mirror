Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7289EC67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 03:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJYDRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 23:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJYDRs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 23:17:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063582F666
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 20:17:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so10133849wrh.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 20:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xL7G5R3HzNE57fyT3GgHOsXUDF3Dd1ZMe8OKFy4Yos=;
        b=GZfcAzp/7ZuT3jkX3UN+heZepQrl3waAVIWRNQrBBlvPC1gd9nlGBkCTFGNU011CpA
         gD/2NQFozjOCPLHoz4WUMKWntM6B+JyM1kIQoGvNUEnjLeTRldAAOkNo0fJiKlzUxnIS
         nbI9s7p0N7CDnjRMfC8GRcdDZ5R/JuboWobBen79jR9XiFk/omYTBS0AAPNqWu30Cf8m
         DQf6QC+uNp1MRzLBbwtuJ39UQ8wfStTMnH5ui1wU8i+Ctae6cbCzK8mSbxTJc5fpGUwr
         x9PSM4O51juWBRAskYaeFXc45uw+fSSyH0xIQrT4KsEvHMNWOq4PQRc+gR+1e0IMT6Sy
         wmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xL7G5R3HzNE57fyT3GgHOsXUDF3Dd1ZMe8OKFy4Yos=;
        b=jTxBnZLgAR18I2tswHtttahxNmw0yHN133euj+jpGWfaQGBmfSPlwOOXMHBIZZw5ly
         bSVnKjUMdY0mDXom9geunNNKFqOyNVWX1BEkyflA+U00pFjdNcV5Y/QUmTMkGOxB6PLQ
         S/lsQVNzXnGjhHot2yDuC8B0e6XcHYtTHIGyRrbkrioQmsQa2rbW1dTYdYb2Qwot7ZSm
         2b6gbaywydyxh3WtKsK2vQT885F4X9J3zcuXHo4hnt/ooBIXrSlI24NtTnUyWPwdVdWH
         8BP/JwND5DskrlNfOfIO3Of6iAIQPfCrg7jwt02qdS71jFMMjEnOh43WP784K5+Ep74b
         H5rg==
X-Gm-Message-State: ACrzQf3DRImTdi/HgQVYTjkqhjUscB/i2INuOHhoOyTMuaV2e8GLDRQU
        cE3E8vHCWQIZgslwXb2ZXsvig5y6SBs=
X-Google-Smtp-Source: AMsMyM4IG0zakinr/Kq8VZv/ktEAwsTaoAMYcSQVGrjGO33reMR/XdbpmSoEuyCHBefAr6YXJHc2Wg==
X-Received: by 2002:adf:f48e:0:b0:236:5e6b:a1dc with SMTP id l14-20020adff48e000000b002365e6ba1dcmr10007395wro.20.1666667866276;
        Mon, 24 Oct 2022 20:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a05600c1c0300b003b4ff30e566sm614341wms.3.2022.10.24.20.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 20:17:45 -0700 (PDT)
Message-Id: <797c625167120ddb676db07fdab99ce4986a4dd9.1666667864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
        <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Oct 2022 03:17:43 +0000
Subject: [PATCH v2 1/2] fsck: remove the unused BAD_TAG_OBJECT
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

2175a0c6 (fsck: stop checking tag->tagged, 2019-10-18) stopped
checking the tagged object referred to by a tag object, which is what the
error message BAD_TAG_OBJECT was for. Since then the BAD_TAG_OBJECT
message is no longer used anywhere.

Remove the BAD_TAG_OBJECT msg-id.

Signed-off-by: John Cai <johncai86@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
 fsck.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index 6f801e53b1d..7d99f6ea337 100644
--- a/fsck.h
+++ b/fsck.h
@@ -24,7 +24,6 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
-	FUNC(BAD_TAG_OBJECT, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
-- 
gitgitgadget

