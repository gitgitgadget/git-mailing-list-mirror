Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7F61FD0
	for <git@vger.kernel.org>; Mon, 27 May 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824525; cv=none; b=Kr1h0guUqubPmR3aqdjHxm5BAIF0G7k1tNpdR2DgVN2BA1kI2HTj+nxAcW6j3wS3VaKgeAYhQCNYrplROdicWK/N6+zewxJHv2l4pgyTyyrhSHoNcw/5wt24EcyLTGl1Dgs4d/Tn3KVv1ji7FoKHMaM0J+Bfo7rQwG6iu+5A96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824525; c=relaxed/simple;
	bh=VaQINdPwnKWx0Cdzi/NNqgmpaQMOPpIormqCRU/0ExI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lasDXBq6nUi0JEjmZzJ/Ban9FhTu+Yq6p0cvC/jzxbam+H5NDSPgSduMTpkH5uMyH03y2mKBsMdLoCiH9xHghz0gxFTl934Zhku3BwsbxMQO5zFOr+i7k4Ozlb2vwPzYw3UQpIElyMj50oXrrl+j9DL4TiKtJjgvkHZe/Yb3DRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcoPpBOq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcoPpBOq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so21717485e9.1
        for <git@vger.kernel.org>; Mon, 27 May 2024 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716824522; x=1717429322; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgF9KtgzsuAGSV8fxvGqrA+oiEfEQQ6g/JUWeEo157E=;
        b=JcoPpBOqQSqnlZqRXincWEqYgvty1DR+2bw1S/3LC1mVAQqiDJKGeAk6VvJJiEV292
         g0Xs/xYAx2iiAEPAZc5rUyXaEGwYwmOVxhUVnhjQb3UArBmVhkpxuGgUHSW6j+3ZRRXU
         ROlaj2V2tx8Ukp2uyNGsp1/G0WpYfyZ54CbTFuQMHSZI8A13SnD7+QuyjXLC0Rv2UwUt
         PI9N7oF6L1GXT7FCXnBycqKQiTtkSDuaYf8h6tgtq7xVxocMzGTEY8xQK8euKgLE22pM
         WNMIUp9veEI3fwbb5gQgD81zH4XmKuJcFgY6X4CNDik7XdGvvUvC4Cz3HsJyqiK0scso
         IfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716824522; x=1717429322;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgF9KtgzsuAGSV8fxvGqrA+oiEfEQQ6g/JUWeEo157E=;
        b=hKJ58rUjmh08gImEXm1MGDyMJkH1q95OMiHpqovwqcoLHcrAQRQm2YiXQz7zMrQUZy
         Mv7t6haEHuGXqs1quZFGMAh8Zxbfb+CMCDxogAz8z6tgkdqqY5L+pjWfSmI0sdY0NJQs
         uywXHxDdM/G9wjAgJp8ionjbZt+NaTJX1Y/FaO2k6Tn9TrgFO+SpKUTIq7I6MKsbBd6o
         GDAFW3+SERJWh0Tt76xQBZbole+sma+AlYtsRSvKGpiUJkKmUjf2yECVvgtaXaDi8Qnu
         IjmqdfOS3qaD+z+7nOzV7qsooWmpAzqzdn7t43FDJgaIqHQ9lkq1UTszo3bFtQxdkNg/
         WC/Q==
X-Gm-Message-State: AOJu0YxsRPtkYvJ49n2yI0gx7eHWDcK9xeT52HyUB7Z01t5TVfITn6CY
	QhqbQXg72QhuyZytSxc5inoxe9fyXql65Zc0mDyE9lwUKjqLh5So2D+JvQ==
X-Google-Smtp-Source: AGHT+IF659GPgddlDnlPLmPcSdXPCzSgd6Ou1Lt3GVBqXBX0HFU2ppzk2BwuBk0KFIQ3KLTWD4n41w==
X-Received: by 2002:a05:600c:212:b0:420:2a22:bd3e with SMTP id 5b1f17b1804b1-421089d975amr74745325e9.18.1716824522290;
        Mon, 27 May 2024 08:42:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a0908c7sm9323158f8f.51.2024.05.27.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:42:01 -0700 (PDT)
Message-Id: <67401d4fbcb3f07d31589bb8ec10060dcb77545e.1716824518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
	<pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 May 2024 15:41:56 +0000
Subject: [PATCH v3 3/4] fetch-pack: expose fsckObjects configuration logic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Currently we can use "transfer.fsckObjects" or "fetch.fsckObjects" to
control whether to enable checks for broken objects during fetching. But
these configs are only acknowledged by `fetch-pack.c:get_pack` and do
not make sense when fetching from bundles or using bundle-uris.

This commit exposed the fetch-then-transfer configuration logic by
adding a new function `fetch_pack_fsck_objects` in fetch-pack.h. In next
commit, this new function will be used by `unbundle` in fetching
scenarios.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 fetch-pack.c | 18 ++++++++++++------
 fetch-pack.h |  2 ++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7d2aef21add..81a64be6951 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -954,12 +954,7 @@ static int get_pack(struct fetch_pack_args *args,
 		strvec_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (fetch_fsck_objects >= 0
-	    ? fetch_fsck_objects
-	    : transfer_fsck_objects >= 0
-	    ? transfer_fsck_objects
-	    : 0)
-		fsck_objects = 1;
+	fsck_objects = fetch_pack_fsck_objects();
 
 	if (do_keep || args->from_promisor || index_pack_args || fsck_objects) {
 		if (pack_lockfiles || fsck_objects)
@@ -2046,6 +2041,17 @@ static const struct object_id *iterate_ref_map(void *cb_data)
 	return &ref->old_oid;
 }
 
+int fetch_pack_fsck_objects(void)
+{
+	fetch_pack_setup();
+
+	return fetch_fsck_objects >= 0
+	       ? fetch_fsck_objects
+	       : transfer_fsck_objects >= 0
+	       ? transfer_fsck_objects
+	       : 0;
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[],
 		       const struct ref *ref,
diff --git a/fetch-pack.h b/fetch-pack.h
index 6775d265175..38956d9b748 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -101,4 +101,6 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
  */
 int report_unmatched_refs(struct ref **sought, int nr_sought);
 
+int fetch_pack_fsck_objects(void);
+
 #endif
-- 
gitgitgadget

