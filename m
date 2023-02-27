Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5851CC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjB0P3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjB0P3D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:29:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB5E3A8
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e37so4170493wri.10
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31Y4dPoAZJ/DJSbINQlLzmb6PNUb4te5nJmnpDMstGk=;
        b=KmGny+WPJceBM9bHIpoiyXa5oviPNLmEn/ahLCRQ739QksPXuhv9UQwYQnI84YZgI3
         ClkDoESLl86CFOkJh49PHtWsraMDT2unXul/AkZnEu6xyJMQc3zfxEk0y41jJKr7UwCI
         jYCKMrNWHdTxOVVqMizP+rFYJdbd/nwkmyHLGO12450XP7654ZAQ4c3J8BlThgj+3LU9
         qnWiE7h8th2+fqAmf2g86i12xw/wHTcWzEgK8LjWx0AaX+rM6UAF+2DkgWrrtSULEPik
         XMuaF3G52pPUM4AdfxmMJRMdH76k5Km9aVpGfFi+sz2J95pAXuJgQgZM9wVq+FjtIykp
         Uqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31Y4dPoAZJ/DJSbINQlLzmb6PNUb4te5nJmnpDMstGk=;
        b=kwW42yF+uWjmflELaET6Le/6qm/z7wIBtBMugytd3IWD4Av2F9KswYRGUJZnd4vQ3a
         fEEm5E3kK5mtjKL0Rs8Q+sAeFLles+P98tGMRHJSKexeOzc+CydUPhumsQZ17I9Zu8nj
         BnT6X4g75hVMydmkhkjL3d6VYzq85deqzxLN5UDdsMz33esx72nkwpi2tFpzGAxXpaDn
         c3OqLWFRk9jDfuliJ4Yuuhjkxr21yJcaY/TLJrmVDaKpIXi4doKi9g/HyTWk53r/NBUT
         QY2q009A1VR/eE804IDWPSOoo0HCPMftKv685OfxFyMx/8vuwVTX7oT7gsPlz7qtVnn0
         IxCg==
X-Gm-Message-State: AO0yUKXF8iyzh61zvrFve/9LzQAC/VUOBevD85rv8Qib+YSLG7Ezxhzg
        YyMJMUPMqSVqg7Q/jewtqJfC22VjIKs=
X-Google-Smtp-Source: AK7set+WYHh1DSBHVKy6Tw/ZPMUsYXnqy7DGxqHG2weX4Cr4Z8BbssPm2ZNsbyQE1YisA3IDBlqduA==
X-Received: by 2002:a5d:47a1:0:b0:2c5:519f:307a with SMTP id 1-20020a5d47a1000000b002c5519f307amr7088468wrb.30.1677511712151;
        Mon, 27 Feb 2023 07:28:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b002c54911f50bsm7387398wru.84.2023.02.27.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:31 -0800 (PST)
Message-Id: <6575c007577c0ae78125bc138ff0eb56ef1c4c1e.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:20 +0000
Subject: [PATCH v3 13/13] unpack-trees: add usage notices around
 df_conflict_entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Avoid making users believe they need to initialize df_conflict_entry
to something (as happened with other output only fields before) with
a quick comment and a small sanity check.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 2 ++
 unpack-trees.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3e5f4bd2355..a37ab292bbd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1876,6 +1876,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		BUG("o->internal.dir is for internal use only");
 	if (o->internal.pl)
 		BUG("o->internal.pl is for internal use only");
+	if (o->df_conflict_entry)
+		BUG("o->df_conflict_entry is an output only field");
 
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
diff --git a/unpack-trees.h b/unpack-trees.h
index e8737adfeda..61c06eb7c50 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -78,7 +78,7 @@ struct unpack_trees_options {
 
 	int head_idx;
 
-	struct cache_entry *df_conflict_entry;
+	struct cache_entry *df_conflict_entry; /* output only */
 	void *unpack_data;
 
 	struct index_state *dst_index;
-- 
gitgitgadget
