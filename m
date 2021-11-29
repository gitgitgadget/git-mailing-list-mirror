Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A476C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbhK2XIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbhK2XHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:07:17 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CE5C06139C
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a18so38997816wrn.6
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PSFgT9kvFOoMZ0ZTJJHfE++msvyiVThB9xsajCaHxPA=;
        b=LfwkqfTBl9v0GvCyWdx/m+pXF1BS6DcU8Wjv/LhLGRXnOgc7aDhbRjMxob9U2HHumW
         g4JzXW1t+aEJlnCFi6HH3wA+H0Me8qpmquwwLcl9swl5UY6AdJToIaWqDLEtVZ4Hd6I1
         1duM5UoyewqgOeiTcFlsFdl6RcS6OwYI8NeFvPrNdKw3PHIjjD5ZSQ3AX3DmtNAic35O
         zYx3rYRfBTBikfnkSWf8GTeWNcO9/5cYE6x4NvBQXH9YA+11+JVQE6IXkqmRUNsjtJV9
         ESrN1e684ZGjqgGNNMAsspCqH/bkyv5fRSXkSpKuDF5+fHV/DuqdS0TnY/EXwdrFnkoD
         JCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PSFgT9kvFOoMZ0ZTJJHfE++msvyiVThB9xsajCaHxPA=;
        b=fxpeAXNXaD17Bg5EF538i52LskRBz1QYtFk7a8I1/d4XmZN8QANc/bKl6GYp8bbvqD
         +KqU/4+JdWmnPLUFi4sfx23aT2mvzYCKwlqLq7BM2Qg4+C+E5cjT4oL6+0NJOPc6cii7
         FsnQ4N1fkA/8qt7tjbdn+GFS0Vk5AoWuUXffLDEtZkQs4Uy3vFAJXicSMLhGTYpwdCfm
         0PsLIIdfsMML2FVhAvYd7ZqVdVrOI81lhbPwIGVKGA+zSu5yyBfz/cBnuTvKjrFMqtt5
         6sjH3H38jBQfx3Im8Z5IujF77zfWpCf60jf1BklqtiRjwAM9eLotYU7icePsM/QAq8fZ
         8cVA==
X-Gm-Message-State: AOAM532J2GtuOb42G/qExr4f4C9xZC6YFoVFmizOSNuyrCc6rPGxQ1gR
        nIbSm4ROcnc5NewIR5ClSHjtZCvsry8=
X-Google-Smtp-Source: ABdhPJzZVUTFwH1zHrjS6E+4/wgN82cLfsHJ2wnGGNhoglNNAw4BBAvGTzmPElbNQAy3hz6J/MQxag==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr36055619wrx.155.1638211788285;
        Mon, 29 Nov 2021 10:49:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19sm129874wmg.12.2021.11.29.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:49:48 -0800 (PST)
Message-Id: <82971ddbfcf233c4462fb13eff8b742d84c72db0.1638211786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 18:49:42 +0000
Subject: [PATCH v2 2/6] refs: update comment.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

REF_IS_PRUNING is right below this comment, so it clearly does not belong in
this comment. This was apparently introduced in commit 5ac95fee (Nov 5, 2017
"refs: tidy up and adjust visibility of the `ref_update` flags").

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 151b0056fe5..5cfdec1e820 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -16,8 +16,7 @@
  * This backend uses the following flags in `ref_update::flags` for
  * internal bookkeeping purposes. Their numerical values must not
  * conflict with REF_NO_DEREF, REF_FORCE_CREATE_REFLOG, REF_HAVE_NEW,
- * REF_HAVE_OLD, or REF_IS_PRUNING, which are also stored in
- * `ref_update::flags`.
+ * or REF_HAVE_OLD, which are also stored in `ref_update::flags`.
  */
 
 /*
-- 
gitgitgadget

