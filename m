Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224B2C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDNR65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjDNR6q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:58:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5067C83ED
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bi22-20020a05600c3d9600b003f0ad935166so2891953wmb.4
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681495123; x=1684087123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL8RywK3IbRfheNuCT7+B/rpq26oTVcacZsRBOSlJMo=;
        b=sdzcWyDx7MBi5FZLAkAhxd616ouI1TilYvdYlyI0TotdCcusiVXLx/VnQFXYaPxwWR
         Lwjkc+wNWetT4zBApe7u/gdu/lqPtFtH0cO3plp2QLg9gjnrXQkbGdpPAwe2+ihI+WO1
         yXwNgA5ANeOm0nD11o+en1IPYOKaRzVlcbOUmZwESQeOi9WmW99SWA91OuLwOcXU2c1f
         zVcI6TGZqosPe92LszB5wnipL579I+GaSWDg5HNANNN0jnPwVHjI3jKUV/2lDiRM2i05
         N8HekyC9IK1y0oLB/VrAVRhTdJTslvagzrIoKJMYLNKpzw1Gt4CUs9jwyyqCRj+M7vTo
         uuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681495123; x=1684087123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL8RywK3IbRfheNuCT7+B/rpq26oTVcacZsRBOSlJMo=;
        b=AAD0qCw9Yxpx41hR7wfpRNwY5BT8LIqBgSbAEM9QFWm3l6bA1eG8Fr34OkR6rLn8eH
         bTyaPSo0bgXL63f+GiPJhjq6zKqowrD9nd4oHZ6lJGK4PAefOdDsV+l7VArfFdJpKsVu
         XJDYZCohg2egAVANpis2Dz6DAnoa733e+fInJet/WOqsRsd32EgYa0H8xIJ7vm7VyKSJ
         uxIsTCcOSU9ymF0OuSZKD7t2m17liVMAzeyhDz3gZcQSfasNRCsx7dv7HBzvTZqyEz1C
         ahZu9H91a9OQslzLqMm1Y+nhs/+rVqLb26II9QbhYGdeRnzcbcAt4+GFCZECm4oWBfqO
         fA7A==
X-Gm-Message-State: AAQBX9eRRcv8FnZODn092a3eHmYfLJ+k9JfbNj8jdbydk5OPz6w8GSQR
        PcyzuxPCA5ZDHmEvpgkzOZmtql/SwNs=
X-Google-Smtp-Source: AKy350bKXqlfRlsXaOgSM0yeq2tXKC2okaD6i+hE8zn7pW6YU7U2R6UhMmzgxSroU/3NAaARk4U6nw==
X-Received: by 2002:a7b:cd86:0:b0:3ee:555:ea60 with SMTP id y6-20020a7bcd86000000b003ee0555ea60mr5454050wmj.8.1681495123527;
        Fri, 14 Apr 2023 10:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003ee5fa61f45sm8595737wmq.3.2023.04.14.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:58:43 -0700 (PDT)
Message-Id: <88cc7a80f313b5511e62d4df064887cc709f76ca.1681495119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 17:58:38 +0000
Subject: [PATCH 5/5] completion: complete AUTO_MERGE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The pseudoref AUTO_MERGE is documented since the previous commit. To
make it easier to use, let __git_refs in the Bash completion code
complete it.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bcda376735c..945d2543b07 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -767,7 +767,7 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD REVERT_HEAD BISECT_HEAD; do
+			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD REVERT_HEAD BISECT_HEAD AUTO_MERGE; do
 				case "$i" in
 				$match*|$umatch*)
 					if [ -e "$dir/$i" ]; then
-- 
gitgitgadget
