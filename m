Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274A19DF6F
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477135; cv=none; b=eHiBRednl7khDXtlLtjKB07DqteHWeEy6OYdPtOpB37mwSLN7LLMzNrQz6GsTCHnZOaUsTaD7En9pSgdPe0cMpTXbY5LJGMJQDcmTp7sZfFglaTnKg6A+0Vrx10URwmdT0G4HTfZ/5PXuWdtQ40NpKgTF0ry9XEx8es5QNy/Uxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477135; c=relaxed/simple;
	bh=EAPMNTEhL7anBQWJwC/AIHMVD1ITjJ9N+qlXgdbGI1Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qHS3UzYMwXA+uxEondxbzJI2OnnURsQEML/QQxJjvkC7o/6IOp/lD7pRGO9mENhKeDH6Ud17YXjM8Mk5gRbFTsxUUWX6Bu5VMugCUAnqmAzq/oUTNs/zNb0Tb3eRGuLCa0RUFSVM/wFb5uFylQOY/xiVYWwnZRIwSVejzQVNSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik5JVOAt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik5JVOAt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-418ee51e280so7054025e9.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477132; x=1714081932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIxLv7fyLh0XvcQ+/Q0x6RYPo93HdGIsjRRzS0B8NnY=;
        b=ik5JVOAtvJngpbiAaqyVFWtPVDl8K41/m08tMRb2DzTc9GfGzH/R1jwBfZTzC2bp0j
         UsRbn+n7hYTVgPcVvVj9L8ID8tpb11T1QmvvxPSMPWRxP6COwrcCjngQVj2wfEy9Ok4X
         JsUTzZo6WsnkOIBGKBbVlrJTlyGPaZPOVfhFZiR7TWthWTQJ+j56W+zi/g99Q2elMLHu
         /Fp8QG+0Gbe1oTZw6rTxt3mjan9aRbp92dbVBSI9D7UgS3pYbc1Snq+1YQRo8hiLwu3z
         C76FnkZ/o8U6cbR2uPXGuVSKax0HfCe41vmJi0I/1YAWbkpuBZ/Gpd8JVK9rxeZ/bAm6
         0OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477132; x=1714081932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIxLv7fyLh0XvcQ+/Q0x6RYPo93HdGIsjRRzS0B8NnY=;
        b=ogiiQ44pdyp62GNlws0E3fKJHjwBfNn/L5YWDYsIB87pPDvSJqYpNtnQB7IrqeHf0P
         IOTOg1XwnNhzYnXCw5pm27/Jij3+qarS5cg2eaTcA5R7S4vWqs9sJ2gs6rcurAPp2yAx
         NfaxHDN5DniypXqcD8xpXwuyZ6TcPhCoFtUJCljnZo61gG2oglBUNN89P7J61HlZeBJz
         X2vb1MF33+foBcGQNr4pFQmm+5eaYVrKdLUI9k3mBsvuLshue7+koPcwLWj//LMxjsQk
         nYRaRa4jJyxiNFUbr9IAXiTB8gmxbWKN1v8CAieyMhQfzN0JQdAXlZ7VkP1tVZC03zkK
         albQ==
X-Gm-Message-State: AOJu0Ywgs/m7Wq8kreOWq9eBWQhOjyqIPyfhZvyb3ut0qgZRtq6v6gw8
	+U+ol+9uFLBWWOhcg36r8Sio1CbYvGyH9AtAyIMm9Qt0fHKBxBBDm0biNQ==
X-Google-Smtp-Source: AGHT+IEne0a8XVONNadPxI2zrpbwd08Mtwl5xnAWdz00BKHNlTVaLVocQL+FVUYUeFmYX455XefcDQ==
X-Received: by 2002:adf:f48c:0:b0:34a:42d6:982a with SMTP id l12-20020adff48c000000b0034a42d6982amr88194wro.39.1713477132362;
        Thu, 18 Apr 2024 14:52:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600001cb00b0034a21842accsm2066006wrx.86.2024.04.18.14.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:11 -0700 (PDT)
Message-Id: <333775d4129bc94aac5f872113d07851ffc19040.1713477125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
	<pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 21:52:03 +0000
Subject: [PATCH v6 6/8] SubmittingPatches: dedupe discussion of security
 patches
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 5d5046fa954..dd248513a50 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -399,12 +399,11 @@ letter.
 
 ==== Choosing your reviewers
 
-:security-ml-ref: footnoteref:[security-ml]
+:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
 
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
+NOTE: Patches that may be
+security relevant should be submitted privately to the Git Security
+mailing list{security-ml}, instead of the public mailing list.
 
 :contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
 not part of the core `git` binary and must be called directly. Clone the Git +
@@ -431,12 +430,6 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
-:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
-
-Before sending any patches, please note that patches that may be
-security relevant should be submitted privately to the Git Security
-mailing list{security-ml}, instead of the public mailing list.
-
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget

