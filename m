Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408818AED
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123346; cv=none; b=iH5EdPj7R75vu0wkhY53UJbCuTNeEJ2jqxY/O97RZkqvt+SE4MOVLgGg1pauZkyylysWpvFZv3oZPGM7Bk4smdT9XGev76HiglfXqM08PttyKtaMXWpP8OJLeUbfHt47YGCa3wqsgkQmiYmBy4VtU2FSNRtAO2SGOv5PSS9nZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123346; c=relaxed/simple;
	bh=38qDBlZLlnfC3tcRH/BvpSz5TwsEmat5y8nZ0ZSFOq0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pETIVvrpakKddL763qpvMkDYurKgbpzircwnQg3K+jO7HgvAXnO16MDWhsUs9LeK9n0cTLOQSN3X5Pj2OWky0NSkNeN9qsaw6X2vX0sMLqFyt+N0MvFbMXQ1K9MD7I15gqnZ/JhglRKfHsXB01Yc/o+9WKIqcpeNcEzTkqnf0Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7TFf8WW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7TFf8WW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-425814992aeso6395235e9.1
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720123343; x=1720728143; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ILcFlOMAi9kG9NzfT2rwD0eNKOAN4sfWc9VgjgjRbrs=;
        b=e7TFf8WWPBg9U7JjDYimxYSEG+Y+EB0b9/7DI9lTYykn+fn9fAG0f8f9ntTDqgwN8L
         bDupHUizn7Z88EIJdArP6Y+F4diCtNxYsitt4tolAnLvTvpwVw6Y0T9srUoyH+iuWDbA
         LwFSkv+LWVgRByAwwsg1boFVfEOKwRiwtD+dHxyK6rcbBOS3l7QTwW0pyMQ4d+YkGrPp
         ymNx/PhlZZsuVvIh+/eVHj6j1WVzrH3zTY5MBePF+zzWCOA05SG540dI6Xv/3ruBoFTx
         h+CzkqCWqq6zu68Bpf+CcB666//nE0ChCKqyenyMMFQ/J/5virgrHzAiIctRrpBn9K14
         AfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720123343; x=1720728143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILcFlOMAi9kG9NzfT2rwD0eNKOAN4sfWc9VgjgjRbrs=;
        b=smebx1raqBQygC27piGfMRsOuM+TUcbG9ZJdK8HuwegfSbKUUeizmv2SSXgEAXX7m9
         zZNDeSd+56plvY4F89YZTU2d9EIVTzoegzUMNClvSXnY1oDDEpO1F32fSM6YYBojwW+S
         uxK5ZO5rVeO44M015+NkWBX8MKNtrUuszEEAlXSfd0vpLQe4j1mkGFwb7AXhCUbFm4lK
         WiYPPtlnRUosnWWLtrRl5rZBMqw+rDurChiMxPsMJPtMJCOorD1/XeqeRPngr+0qB0YQ
         nUTfx71LvfInpvKsn8wio48oQTOHGMU7GtckcL8CRDyIDClSfLRHgEUCp6rtCc5mXOvi
         lbzg==
X-Gm-Message-State: AOJu0YzEs9iwUzICqEk+MjoRAjSS4pnO6jJU2sJKbFDAO8BLE9+Arj1L
	FKRKqiJtmMoNjcbFfHdr9PSadvWcpUvSdF2kRYKtJrBOkleAMHHnzzhGrQ==
X-Google-Smtp-Source: AGHT+IFMLGkkTaJ6KHvYSikLGGGBLlHdrlLnHTdzeLENB9EOzfOOCn9+A5rAktNB3w7zTURVhtYStQ==
X-Received: by 2002:a5d:574e:0:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-3679dd66e59mr1783690f8f.45.1720123342439;
        Thu, 04 Jul 2024 13:02:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36783e9faa8sm8109532f8f.64.2024.07.04.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:02:22 -0700 (PDT)
Message-Id: <pull.1758.git.1720123341342.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jul 2024 20:02:21 +0000
Subject: [PATCH] merge-ort: fix missing early return
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

One of the conversions in 500433edf49 ("merge-ort: convert more error()
cases to path_msg()", 2024-06-10) accidentally lost the early return.
Restore it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: fix missing early return
    
    This is a patch on top of en/ort-inner-merge-error-fix which is in next.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1758%2Fnewren%2Ffix-fix-error-cases-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1758/newren/fix-fix-error-cases-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1758

 merge-ort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/merge-ort.c b/merge-ort.c
index 8dfe80f1009..d9ba6e3e523 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3618,6 +3618,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 		path_msg(opt, ERROR_OBJECT_NOT_A_BLOB, 0,
 			 path, NULL, NULL, NULL,
 			 _("error: object %s is not a blob"), oid_to_hex(oid));
+		return -1;
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;

base-commit: f19b9165351a4058832bb43560178474c7501925
-- 
gitgitgadget
