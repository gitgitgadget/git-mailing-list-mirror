Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478A29AAEF
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313153; cv=none; b=Xvgkp99s+yqHd1TJ7U6ex63o06+7rFtMdE6fg/petRJ6tAPH7viaqfs5Vh4F4uJ3o/YM5FAfmXenWuPu7CYgftwAFOWcupoJ8f22t+uDbEpPOQvhf3zLEMKOGWHiEhU/l3RasFak6mcmqZ+5rpzNknHXEYDKw9fcDXSfyHYFHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313153; c=relaxed/simple;
	bh=LcIHOnMixK3fKy1bKEFgSh/aVG18GPLXXV0OBdg2Kxo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tXSwcU7LPeHKffgjosj4c+sf0yLaNS5bWHQjxVtCy8P6STokw9eNTpwFfMhF94OR+eN7K4LvMgcqCpbM7AUM+KASq6Nl0xpIrFAKoF7HoWNSczODK4X2l50qV40z44EJfdtHKlihCEaIDTLey9tACCfzhQVBkiUZWcTW0AxAxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrSWmsg/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrSWmsg/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442f9043f56so3709835e9.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313150; x=1747917950; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDgHhef/1jGq+XtYl+NetCUEm7+tb5WfEfQdnfyawBo=;
        b=VrSWmsg/4RG881jnRcBi4wmzThT73HeREOiQHdR3zxS+0+aw+PkJyYvXTj4hG6iabh
         wRyCOuCwwNZWgBGo9dchbBpBUwrYszoKksTCBoPVWsdl9ML620pZqbf1hi0JJCNK41u6
         SIH9ql10mZCysFTkCDmx0I8E/YASoYh4NKOqPz2K/JlqM2Ll4sebt6RxWSei09CM0xH8
         /cXzEvp4e5UfCsJuOxsbIBwAPt16GEgtIGUiY4lrexl1YAytMVYs/Rj0ODOH/qdArse2
         KkCgZZJTrul+d5GXK1iz1f0vO5zDUgek6BcU/V+w5JKWOdY9hrslT8oj1c3auKvjaAx1
         b1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313150; x=1747917950;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDgHhef/1jGq+XtYl+NetCUEm7+tb5WfEfQdnfyawBo=;
        b=lSvPbsrD56i9j6/bUpva7ttRWZTsMNsF8xjk8kiOBI5u2o/+LeL7owd5aTcdMjhF0i
         2400kpTHb5ihZZeHp8P8ZFKQYxtnJy3s1MB4THfxnjD/J62kQ4KOMGyawUBlLiRlheBT
         YQwJkVv9fdjjrGqJtO9FmRUMef8ZIeFS1QtVZEjD157KjyVE0nDg66HCiYlN088BHLap
         bwnmokdSU+rRpYsZKx1Z/ctOyZGTwdjUWvfN/+hOOkyRw0t58awewfjKPiOHGVDJ4TFj
         eRvUgOrjVtQx9zpsxWpN+vronoGBEpm2xUFiUi+CXjA9PRBziUccS5lq95tOCp6bGWCM
         QHLQ==
X-Gm-Message-State: AOJu0YxuOAyo1yQcE3+6zAb2io67SJVjtmMmaBTR//jU77LhzzeNWv9g
	EbxUY4nujs0WMhHHlYaXO/tgit9FTecDBkBR0TqGFq5VIdNZ91PzxFHt/w==
X-Gm-Gg: ASbGnctTY3HE/dVgGofz8HAaAUaXLidNGmkRb5My1Uqv+gzYKV3y9cy7r96PnHwdQxK
	AYb4hgc+3yRdvKOw1Tw6OrY6aZaZi+3uwRl6PtnErtPQllAw4kz3CtGovizpdRxuqn2V9coMkZH
	/VMzUv3IjW0rOg7GSYpe8p4fQtcoNkkiC6aAyGLzb7Bch/v+OQWEaIisE72r9EinygMDlorqkqB
	VcBKBELeWmU+xmsiJrXF6Mlz+w93odsnD4TiqH7W7t4BPl1OTf75E3bhF4KdqXbr751/4kvdAr1
	8psaA30QS4U0dHtfGJAbxDWJO93x0KNw8BCWFkBmpFgZ0RSENooioLnlm3Y+ORg=
X-Google-Smtp-Source: AGHT+IGO6J8d449vV/ijnjo5OQePDIhjekIMk+6DRQ0dW7GBtYK8DO0kFqi3vTupZOjuU83gAUfCsg==
X-Received: by 2002:a05:600c:5304:b0:43d:97ea:2f4 with SMTP id 5b1f17b1804b1-442f20da57fmr76641065e9.12.1747313149943;
        Thu, 15 May 2025 05:45:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f33804d9sm67498075e9.12.2025.05.15.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:48 -0700 (PDT)
Message-Id: <d8397662bcf72445dd06a09a6615b066c9166cf4.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:34 +0000
Subject: [PATCH 09/14] fetch: defensive programming
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

CodeQL points out that `branch_get()` can return NULL values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fetch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95fd0018b981..e7523c531407 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -553,7 +553,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		if (remote &&
 		    (remote->fetch.nr ||
 		     /* Note: has_merge implies non-NULL branch->remote_name */
-		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
+		     (has_merge && branch && !strcmp(branch->remote_name, remote->name)))) {
 			for (i = 0; i < remote->fetch.nr; i++) {
 				get_fetch_map(remote_refs, &remote->fetch.items[i], &tail, 0);
 				if (remote->fetch.items[i].dst &&
@@ -571,6 +571,7 @@ static struct ref *get_ref_map(struct remote *remote,
 			 * Note: has_merge implies non-NULL branch->remote_name
 			 */
 			if (has_merge &&
+			    branch &&
 			    !strcmp(branch->remote_name, remote->name))
 				add_merge_config(&ref_map, remote_refs, branch, &tail);
 		} else if (!prefetch) {
-- 
gitgitgadget

