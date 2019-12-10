Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20292C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E553720838
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uct62cGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfLJUAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39406 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUAd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so21493419wrt.6
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H1rfc3Xakcj/y7/qH6kpuw834RYNToBjdWGDvsRGWdg=;
        b=uct62cGwhQxj7rBRZqbJvB+i/1SmS9Bh1eTx1CmmjS4qDYAoL2crQyWBUafh146V/G
         49TCUATPbNOSkGecozq5pSQ03oT3A8dBf1eJZCJgWEdvEuipT4aB7rAg0ryd9Hxeri8Y
         mZxYWFMSWGxPaLMOnk9sVZbgHnI+E66rLw15Om+d+ceodJjYXVpjE96LgN1Qn48NT55i
         QxAjbDnSkKWUQT56/gDcNybkOXOdhVRxHjSqtJlfqgD6jXesOjwwKJR8yokzAjyfXqdR
         Af8wIxYPai+f2apU+To4m+HuGNWNc7eSEYfWWUTY0R+pqcYQfcJWDoXsU4XqfsmLgIlh
         ltLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H1rfc3Xakcj/y7/qH6kpuw834RYNToBjdWGDvsRGWdg=;
        b=FUBiG2ikNQ8pqJDFgN9OQiwVAQv1RHRx+xquC1m7xMbRGQHM4cHHWkScb29g2gfqDN
         evwiuIVpL7BVdRzK6tYuOm+Uw4jifgvUp63RknxD1EnlTKkq1NBoihi1f9WzPMsheyTv
         g/A1lykynIphzEtz5zh4i4vvK7Vq4myJ8/U+8H3FNjV4SHOVIvXvwxXlhWHnYf1nh/gF
         DYx/U7NqBqZ8ORbe46TKfPAlB09kDA5Ee7JezVCFvijy4TD6QjVhjvJPWXVplmGK7qmp
         nLjCcl404OO8Sdu2celU7mXI5lOb8rh6NCL72pGrDJ0YbemmNal6U2qZLkUwe7BQwhJx
         oLPA==
X-Gm-Message-State: APjAAAV0poiFBxtbHeOOcBYvugDFdTHlF1Q6Th4bVWI6VmaUlQXlhxYS
        NJZI7NUCQv3Q+0ZK6QHowFKlg0QG
X-Google-Smtp-Source: APXvYqyF4gYUhlKL9tLCsfbH8YbCxQAQhdtndtDbTgF09fMWLWAHreP25dW5xZdhNV/BYsqrr4oxcQ==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr4881837wrr.215.1576008031802;
        Tue, 10 Dec 2019 12:00:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 60sm4610644wrn.86.2019.12.10.12.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:00:31 -0800 (PST)
Message-Id: <d6f858cab122869425f5801d98713bcbb6d00334.1576008027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 20:00:22 +0000
Subject: [PATCH v2 3/8] dir: remove stray quote character in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
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

