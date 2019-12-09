Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D80C04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50151206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpxYq8tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfLIUrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:47:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56017 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLIUru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:47:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so801695wmj.5
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 12:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H1rfc3Xakcj/y7/qH6kpuw834RYNToBjdWGDvsRGWdg=;
        b=RpxYq8tDR3SDanmflqYAWCw6j1NaRw0Cb4rTRJg9IH1BH+8Oc2wY60JbpyN4G4kS90
         ljyEVhQwmzPUAD8UFktu63nW2nU2Un/vPMx3LggwWFeh9XTWeELBdgOrBMbVBLDWsifL
         2J5tckTjgq9t4drKk+OIEsipW5daeHoPqeP5fDuPHoSshCs8tH7ovVdL/t3xezONmUni
         KsavwZie8mxBLFDSVehcUshElSHs7AAWA+2NRTWsCD1imqbq37j4COCswEWv8whg17XR
         qAQap5VSOoUTtsk+t7Ri7bhxY5KShkpVA1FAMjFEdgbqMZAQ/ykMPe4AknVNW0xM1+J9
         J8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H1rfc3Xakcj/y7/qH6kpuw834RYNToBjdWGDvsRGWdg=;
        b=nzhxrDAhRknffGEBKNd99UeXIx21QCnK0b59ALP//1LQ4v4vR97Uab5m0GOiJcBZCF
         l4+t3Wa8nSK9HPW9YQafSxF98UKJ0SjKm0JN5BBkfgBXuWri3ho73bm5welkH/+5rAEd
         fP4PcIwb8S2KoLuzNUJRa53SE3qThwm39X8vq+lfyAKSXwhrIbsXLqmhkET/yRoliyN4
         7eX0Y32+xjHdMOKaVuvhCen9D0WphfeV9j8OZMtsiYsybuNTlk0iwfgKKe0bbaOm9ZJR
         2oRR/IDoVC11PkliDCBV3pVGZeCcTcDm1qfPzwhirclEB82msppnW9oZH40jDrit0zK+
         S9Dg==
X-Gm-Message-State: APjAAAXoGgPAjuaDfJ8v/9VwsQhfy3ZYqLFU/envNC5KZ8MuKCWTM+Kq
        g+bv80DCgLgI7vYz3k4pS6hjhL5a
X-Google-Smtp-Source: APXvYqxKdSoJpKvNv3HhfNlKnxevKaIeOK6NOfXtIa5WTHWqDywPg4jJv/KHz9DirFRX0C8NPk+SdQ==
X-Received: by 2002:a1c:730e:: with SMTP id d14mr967739wmb.88.1575924469141;
        Mon, 09 Dec 2019 12:47:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm667523wrt.91.2019.12.09.12.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:47:48 -0800 (PST)
Message-Id: <ea2588e87cd4f42f685eef0aa41da83c8fd7333f.1575924465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 20:47:40 +0000
Subject: [PATCH 3/8] dir: remove stray quote character in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
index 0dd5266629..5dacacd469 100644
--- a/dir.c
+++ b/dir.c
@@ -373,7 +373,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		    !ps_strncmp(item, match, name, namelen))
 			return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 
-		/* name" doesn't match up to the first wild character */
+		/* name doesn't match up to the first wild character */
 		if (item->nowildcard_len < item->len &&
 		    ps_strncmp(item, match, name,
 			       item->nowildcard_len - prefix))
-- 
gitgitgadget

