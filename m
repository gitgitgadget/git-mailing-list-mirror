Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951ACC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjBWJPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjBWJPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F8311D9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so10174066wrz.7
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLzl5Nnmpb6ZWi0HOdk5F4kYn6w/3YalLglkZXtyiUs=;
        b=WXfCiPESPVk2tSVIuI1+tfndnJjvL+5Xej4F8AuFWyS1Q2GG3aJ6HRleRWg3BtoZ66
         xVHNZpQS+dYiV4NeAVzx2rtME6oHOkcCdyLyz4qu28WBvTXNxk87X9odZGF5bPNNbj1K
         byauxKLAtXKs6quJdvN5KwPGEErqX4+fynNa9OV9RkBl77hD4xIsV7LY+7qdbI122YJU
         XFe1Q37Cz/2KbhSC5slc2ouiExR9/vR7XZ5vzwnHGF81FbgOcaQGrY3mMse2MzzK3eWf
         xzuyxi+fFbmoSs6NNsaKl+OcjDZz7OasbBamz+S5ELkZJhlEnyZsoLvjjyKlgitxVFrx
         wo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLzl5Nnmpb6ZWi0HOdk5F4kYn6w/3YalLglkZXtyiUs=;
        b=AdmfElvDpXZFWZQZpE/cstSnJuFNyvld9t7kIAfZuyXBGGmuZGSudONwWqf3J+mPJs
         0RlS/+A7WOeBepJ45EJnjdifzRAAm0BN4TcaDEBq82hyg3myAcnijFLx61khm2o9U6XG
         8NNFphPx1lN78nuevk8hiez0XzK8p8gnNn/KxKIvBkqnA2MZjn5bZwBbVlEC1j6TZ/oJ
         Qb65tqtjxE+zy70FP1ZL7onOO7ukUC9z4K3PM/ytWWFrQknygaRGNJyx0TbX0oNg12rk
         7/Na5YWdI8ccBOUJjKiUH38N+FN16HSlhwnemdKzH7ydTHMhnTjeM4weDoZSzNkq70WJ
         fTig==
X-Gm-Message-State: AO0yUKVOjMTBilN481FJZb3Ce5Mu9kt5ggjyt44qlgGWQewJrQXONtZd
        CXQMQYLGDJvbz+Za6MSsJYhSD4vPtQ4=
X-Google-Smtp-Source: AK7set/dRp0WMUM0JQjLsdA/4FKwCJa1QNKPAjl335l3/ojsdowEDEQdN0rlfAVPKtAb3na/4Pf0+g==
X-Received: by 2002:a5d:53c1:0:b0:2c5:5234:882c with SMTP id a1-20020a5d53c1000000b002c55234882cmr8442465wrw.7.1677143702670;
        Thu, 23 Feb 2023 01:15:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12-20020adff38c000000b002c567881dbcsm6668402wro.48.2023.02.23.01.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:02 -0800 (PST)
Message-Id: <239b10e11812d99be587265c0a5e283da45ca315.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:51 +0000
Subject: [PATCH 02/11] dir: add a usage note to exclude_per_dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/dir.h b/dir.h
index 33fd848fc8d..2196e12630c 100644
--- a/dir.h
+++ b/dir.h
@@ -295,8 +295,12 @@ struct dir_struct {
 	struct untracked_cache *untracked;
 
 	/**
-	 * The name of the file to be read in each directory for excluded files
-	 * (typically `.gitignore`).
+	 * Deprecated: ls-files is the only allowed caller; all other callers
+	 * should leave this as NULL; it pre-dated the
+	 * setup_standard_excludes() mechanism that replaces this.
+	 *
+	 * This field tracks the name of the file to be read in each directory
+	 * for excluded files (typically `.gitignore`).
 	 */
 	const char *exclude_per_dir;
 
-- 
gitgitgadget

