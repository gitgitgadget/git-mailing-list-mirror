Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D93161B4
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552538; cv=none; b=NaaWIsZRdpaG5zpumk8IUI5DXmjolBgRBcnx0BryPqs5pDOQloZOKGXJy/2MaGbr4ELgP/OBBEwH5FqoiNnsC4zQTpSQ2WkYkbRp+1IJA9fi/HHwu7TZUfrMt414XRYq7YAXC/PC9MXmiFL8+xUfmepi77nve5fKWwyW0mXtSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552538; c=relaxed/simple;
	bh=hkXbUpzhx3KK/9K2BjBfvg26oj5sdjf1D69b2oosUbo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Qmhw8xaNp7J3MDDnyOic+yzv7SEHAIeyNbALqnNHMuvq59VmXnc/yNh5SXjWOKrPr5i2Kt8WNK8gjJMWD70GNXTvlHUzOxZcsF0Dzt9JSkSPvMn+V1Smjk+MHf7XqUWUjipm5c4c6sFSw8iFguF+2JG3XVHf7gudIuJqFROQ6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQHrKdye; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQHrKdye"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bde0f62468cso1297153a12.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765552536; x=1766157336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veiawbdCkc4NsrjgiSyIQuf3qjzXbQOqV5XHm0Elmrs=;
        b=QQHrKdyeWOkXUiK3HJAEz02et4Qy6aZJGvWvvzdKAyiV/FBxPwXssZhLNLNEOdRZjQ
         LrLl4hzQHGUdJBwusZBAB+W4mSxGXohfAUnPwTZbewBmGfSq81Ohzu3mgFtiufbDihqD
         hZxhTnJEChmyliN5Dz/MDFP1mAH2LXc4QTHyGxZlWE2z1VRwXiRjyQMKfOv9yOcR5K2E
         HYuyYFVxLFBf227WBW5YE6sdUXIg+t8tpItbWO9JJAO2KOdqTldSTDeKvVVU3TCF+tAy
         1Aj0Cz8s+79m5nbxRSUvWcV1J77RWfNyptBSAnSDdei/nZE1xt1ynwaSk2hV9bmR2rVY
         XyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552536; x=1766157336;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=veiawbdCkc4NsrjgiSyIQuf3qjzXbQOqV5XHm0Elmrs=;
        b=WIyaYHyQq+S0OCmIuVJhVX1T0qXF3YwNFeAPsCfqWJSlqyArPCNTjyFV4OXD1MdDj7
         CV5dn0h4f1/kcXWNKgSE6uA8voatnjrt7qPBSlkLcmHdoEqCm2wIWUhCYLY6qvXhSyg2
         nzVGrkygMs4N8I7rRF9sey6CqibQ8VHXNNYsHfcpPZQUL0/QqmvXJV1kqWbLRLh7gSQJ
         XuCGk6RxCi/nvzkTjx6XiXkTgKI/eaELVQhRXmwQaOFxqnpXTrT3xTLikY8eSx6bZEAu
         uH5O+/XKnkLEELSLzVZj3r106AanA+D7CIoE6PgLvXcZQrUdIu0mqgZZRytTbdk65Ao6
         Dvhw==
X-Gm-Message-State: AOJu0Yyx80aMbs/2f1Wys+441vySZUf3i4XvjqceoWMh5CFRb9xtOQwu
	rJtaIklQdEw+jxCDS2qU4Cu2/ckaNMt437w8TGTkoKAuVfHTl0x/4CTEUbjEW3cK
X-Gm-Gg: AY/fxX5nbq9xe9PA6plhYe56NNjNWyxK6ZHYIYm0Igyq8Coe6defqSdiSrSzpe0YilA
	2SvU+6jR8xd8PlXkEx/ZmF8MTLZcrhNF0F3Mobc/PqRLalG0V9M/Y7r6bQzPXGhfOAqfj8LW8wV
	mZKmqOrB+KRa78TuDeBFudAh/tuU8nZk5R4fKAZO5dm1/F0Z1qqokhNlo2qpLDUiF8PqxDp1Lug
	LGjPCrDmlNtv+oweF/rU1S/IK4gu0L6gjO54VOrk6EFvtZkdMcdcoSolE3DsdYlIMvW4UlvNU4t
	nKZxcX2hGd8XhRoOEz3b56ONa/ZV46q+Adj3Y3Gn4qTSejewMeb39sLWa/NYc4Xs4GEHntUOtvj
	3A6fWR1yvlUy+NIFG0OIhDjtveXy07OqspR38+QYg+tlm95SgHpgZ+S4zVrrbdEUjJnOzu0ly+o
	wUqJ/kivC7qXTpTA==
X-Google-Smtp-Source: AGHT+IF8H6TytQDRLswnQJ0cI2s6xrDsZ1yGWFxBV3TODhq680fHeTHdlfbcdTnnnrMwj1TOYfNVxg==
X-Received: by 2002:a05:7301:138d:b0:2ac:1826:58d8 with SMTP id 5a478bee46e88-2ac3027e06cmr1258574eec.29.1765552535916;
        Fri, 12 Dec 2025 07:15:35 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac3c13d60bsm1198497eec.0.2025.12.12.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:15:35 -0800 (PST)
Message-Id: <c30ffc87dc9ae61f87087e2fb8b325ae4fdb984a.1765552528.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
	<pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Dec 2025 15:15:27 +0000
Subject: [PATCH v3 4/5] scalar: alphabetize and simplify config
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
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew Hughes <matthewhughes934@gmail.com>,
    Henrique Ferreiro <hferreiro@igalia.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The config values set by Scalar went through an audit in the previous
changes, so now reorganize the settings and simplify their purpose.

First, alphabetize the config options, except put the platform-specific
options at the end. This groups two Windows-specific settings and only
one non-Windows setting.

Also, this removes the 'overwrite_on_reconfigure' setting for many of
these options. That setting made nearly all of these options "required"
for scalar enlistments, restricting use for users. Instead, now nearly
all options have removed this setting.

However, there is one setting that still has this, which is
index.skipHash, which was previously being set to _false_ when we
actually prefer the value of true. Keep the overwrite here to help
Scalar users upgrade to the new version. We may remove that overwrite in
the future once we belive that most of the users who have the false
value have upgraded to a version that overwrites that to 'true'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 60 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/scalar.c b/scalar.c
index aeebea41fa..3b25fd3f35 100644
--- a/scalar.c
+++ b/scalar.c
@@ -133,10 +133,33 @@ static int have_fsmonitor_support(void)
 static int set_recommended_config(int reconfigure)
 {
 	struct scalar_config config[] = {
-		/* Required */
-		{ "am.keepCR", "true", 1 },
+		{ "am.keepCR", "true" },
+		{ "commitGraph.changedPaths", "true" },
+		{ "commitGraph.generationVersion", "1" },
+		{ "core.autoCRLF", "false" },
+		{ "core.logAllRefUpdates", "true" },
+		{ "core.safeCRLF", "false" },
+		{ "credential.https://dev.azure.com.useHttpPath", "true" },
+		{ "feature.experimental", "false" },
+		{ "feature.manyFiles", "false" },
+		{ "fetch.showForcedUpdates", "false" },
+		{ "fetch.unpackLimit", "1" },
+		{ "fetch.writeCommitGraph", "false" },
+		{ "gc.auto", "0" },
+		{ "gui.GCWarning", "false" },
+		{ "index.skipHash", "true", 1 /* Fix previous setting. */ },
+		{ "index.threads", "true"},
+		{ "index.version", "4" },
+		{ "merge.renames", "true" },
+		{ "merge.stat", "false" },
+		{ "pack.useBitmaps", "false" },
+		{ "pack.usePathWalk", "true" },
+		{ "receive.autoGC", "false" },
+		{ "status.aheadBehind", "false" },
+
+		/* platform-specific */
 #ifndef WIN32
-		{ "core.untrackedCache", "true", 1 },
+		{ "core.untrackedCache", "true" },
 #else
 		/*
 		 * Unfortunately, Scalar's Functional Tests demonstrated
@@ -150,34 +173,11 @@ static int set_recommended_config(int reconfigure)
 		 * Therefore, with a sad heart, we disable this very useful
 		 * feature on Windows.
 		 */
-		{ "core.untrackedCache", "false", 1 },
-#endif
-		{ "core.logAllRefUpdates", "true", 1 },
-		{ "credential.https://dev.azure.com.useHttpPath", "true", 1 },
-		{ "gc.auto", "0", 1 },
-		{ "gui.GCWarning", "false", 1 },
-		{ "index.skipHash", "true", 1 },
-		{ "index.threads", "true", 1 },
-		{ "index.version", "4", 1 },
-		{ "merge.stat", "false", 1 },
-		{ "merge.renames", "true", 1 },
-		{ "pack.useBitmaps", "false", 1 },
-		{ "receive.autoGC", "false", 1 },
-		{ "feature.manyFiles", "false", 1 },
-		{ "feature.experimental", "false", 1 },
-		{ "fetch.unpackLimit", "1", 1 },
-		{ "fetch.writeCommitGraph", "false", 1 },
-#ifdef WIN32
-		{ "http.sslBackend", "schannel", 1 },
+		{ "core.untrackedCache", "false" },
+
+		/* Other Windows-specific required settings: */
+		{ "http.sslBackend", "schannel" },
 #endif
-		/* Optional */
-		{ "status.aheadBehind", "false" },
-		{ "commitGraph.changedPaths", "true" },
-		{ "commitGraph.generationVersion", "1" },
-		{ "core.autoCRLF", "false" },
-		{ "core.safeCRLF", "false" },
-		{ "fetch.showForcedUpdates", "false" },
-		{ "pack.usePathWalk", "true" },
 		{ NULL, NULL },
 	};
 	int i;
-- 
gitgitgadget

