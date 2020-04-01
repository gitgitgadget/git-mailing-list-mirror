Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E49C10F26
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC9D2077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMvL4gFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgDAERy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:17:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33561 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgDAERy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so28940940wrd.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ip1sdkCAke+L9RTot1ew8WG61s7QEX3alK/LLGEt0Fk=;
        b=jMvL4gFAMb3jA9KxgnmbPHKjYS3/lmB1XXRNMZN+onuwydJusASJJu5uIT/AfHZW3y
         vci25R/dGbREZu/OC2JYGRrpiDJe3c8Mm43Fz0pGMcqjmJVDVjb4tpQbbfR9r3ZP981T
         R3biofYh6OCGUOkeNhn3ppRkP+W8pWKh4mMPZzjNdOKB7uDvSPXaiKa0uDe8OWmu1X0I
         M76QmqRrMTkXiaSmILryV+qnVOwiG47trTrH30yRjaTiD+9j/UMSqnkgJ8jcCLlweplX
         PjAZ0ZJcU8U50cPpDedvi5hXVgC5BkFqi5tRyCdkP4dWW9VZ3DwX2JU7O2poi33ayBta
         xA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ip1sdkCAke+L9RTot1ew8WG61s7QEX3alK/LLGEt0Fk=;
        b=hX7voI/bfdCwOrFQa/0S2Gf5OIAQKh21WMhgADlpm7S/MR9YvinJ0yPlxo4r89XNMF
         KIrX77px7LzKdflFt3r0C8UGamI+72LRkDcipLZJuqFE+BIffH2O/y8998QAnypREbQ1
         0Djlm/VsuzEGai1ZYNpLC9aJTaBXngK/JcbsrhwPrPcI4bhaz+1ltTszppeoOLWzyn5I
         hGb1JhN4ZOFCa6B18EUziUldOk2yfDds/WEcjiHpTY9m2RFSqEcHpj+pkeAhDsmHQOzP
         H8oBBJtt1GSN3xkJSETDVJ3gycOXApfKUPw5MGp68zIKHbJRBKs5UXDFY8nHazUo/MiB
         cgbA==
X-Gm-Message-State: ANhLgQ3hX+szN/5+kKY1MU4rvlyNuuSuUBVRrU8UpG9jVGiqunITZD2t
        HbT0N1mo0lWhNpnKQmXo5o9POSCH
X-Google-Smtp-Source: ADFU+vsMAqDdAfSvzKD7xk8OJEMUXz6EyuVRvPmZzGId0fMm5sKT6A2WXCE/oFEuEI0MbcK2bGCQKA==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr20378062wrx.148.1585714672511;
        Tue, 31 Mar 2020 21:17:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w67sm946686wmb.41.2020.03.31.21.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:51 -0700 (PDT)
Message-Id: <6e29f1f6aecca986f1c901eede948399eb50fb5a.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:39 +0000
Subject: [PATCH v5 05/12] dir: fix broken comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index d0f3d660850..3a367683661 100644
--- a/dir.c
+++ b/dir.c
@@ -2259,7 +2259,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 					add_untracked(untracked, path.buf + baselen);
 				break;
 			}
-			/* skip the dir_add_* part */
+			/* skip the add_path_to_appropriate_result_list() */
 			continue;
 		}
 
-- 
gitgitgadget

