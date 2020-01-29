Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB11C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4588C206D5
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGs5d9Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgA2WDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:03:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35045 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgA2WDv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 17:03:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so1441997wro.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+EEP5cvZz+JJ7/eTYAgYq85d/6J7CRuOEJVck0LRXxw=;
        b=jGs5d9Xi6uGbIRnvXJjTAWDotS5W9x+C7Uy7alF3o5IAoLZTgNtB22mGjgkcruMDiY
         uxdMaycFjwrMR9XQOxKKyF4ZH78/BgissRzlnvaEaRQbbaufDT3OwiL41eOojyj2WW4C
         xwSxKLiaCYhHmSMGbjuq/sDB13EidlyCUWO7CXAjpwIgTbU4+oN8lFuiydp3j4cSThaA
         qTS9ybnw0fSa2KYhkKSm15MTSOox5ZDE6iHGj9sUQ/oPwqArggAmhet8lS45NyrWY+Zv
         3z0ctQCbRnev1ygvQbu8xmeaeHrK6lHB2tLWo7QzbNo99Wp1b2GB4TXbR1hZed+GqDne
         xbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+EEP5cvZz+JJ7/eTYAgYq85d/6J7CRuOEJVck0LRXxw=;
        b=FDm8oQZnHkanQ79l4W7F3TNCjlo7va+UOrolc5BV8FFLE4c9CryJzzoxjq/IP6xy+y
         q2mqXdfZxRmKLwpL2MFfYah7waPWnnfK+sHn48mU00gdF+WD+fmWCIMqnCVp7xCqNuCS
         otlZ4M24V0SNjmXkpQHp8dyfZXZ8edMOGt8pY2H/aolFBl8SxuOBsWBWdSVLmCES8f82
         kg52uz39hb5adsvpScOwpM5YOYvIOcZoTStk81qe6UAo2IMHwIeymlUVv1Vh7aELl5QX
         FeDNm4/XI2j2gteePZZpsngJZiGiPTPcM5NAs6bHgYB6eUdLUjkK2Z4APBSbu0QU6drZ
         uGtA==
X-Gm-Message-State: APjAAAW993UF8FiHLTTVnqlpEVUO8Paaktw85zz6tFI0X/5WhhS3IrCb
        Kr5AZXO152z71NDWnT2piBT7qOjx
X-Google-Smtp-Source: APXvYqzdgPaH5PtF5xhg3x223vBiNh5Y4Y+nRJNVAxjASSnd4F7o9egN+xMrcIb+XvF5G6ffLZAMRw==
X-Received: by 2002:adf:f581:: with SMTP id f1mr1048018wro.264.1580335428864;
        Wed, 29 Jan 2020 14:03:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s22sm3711705wmh.4.2020.01.29.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 14:03:48 -0800 (PST)
Message-Id: <3b2ec5eaf65c9fe44c4337a4cc2fc3dae6203d54.1580335424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 22:03:41 +0000
Subject: [PATCH 4/6] dir: move setting of nested_repo next to its actual usage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 225f0bc082..ef3307718a 100644
--- a/dir.c
+++ b/dir.c
@@ -1659,7 +1659,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	const char *dirname, int len, int baselen, int excluded,
 	const struct pathspec *pathspec)
 {
-	int nested_repo = 0;
+	int nested_repo;
 
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(istate, dirname, len-1)) {
@@ -1670,6 +1670,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_none;
 
 	case index_nonexistent:
+		nested_repo = 0;
 		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
 		    !(dir->flags & DIR_NO_GITLINKS)) {
 			struct strbuf sb = STRBUF_INIT;
-- 
gitgitgadget

