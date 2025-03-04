Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA21FCF7C
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080453; cv=none; b=CIpeHflQx0HkaiX/vezKbK1JEDaz591x29/23/p/c6vjV7lKlhv/tvI3OsenLPy414elBkRuxwSz1ABz3u+V5Ra0HGn2fF59wT8Y9qjAecv/ke/jowSH8stRM+jzXDCZbxfJAA5ht848W9iixG+4YLUOSWeSj8RzKYkwqhVE0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080453; c=relaxed/simple;
	bh=G7T2hXAtaL1M0X+vGu/E6KsguYtyz6owh77MhwT0a5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7qYcPAG3MV8RIFpd8Ooe/aPc8JFNY7uQuuq2HuK3+m5FG/YK5rYKX9OaK7qDq3/UPf7EYIJnrfOjYJKecYI4GFGGkgcA8egVdjLAsTsj45A8r2eBfv7HR75HeUD6hqpsD0oMgUZB289EnV3Pz0CbSWy6ysRvhHteLW3YUZn+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1Y/1Fco; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Y/1Fco"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2235c5818a3so66655045ad.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 01:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741080451; x=1741685251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Qk7PHbGAO2P45jiVlOxlUZ0NSGvZDOG8uBk/PqG65s=;
        b=d1Y/1FcoNggoB0iZp2fAvjVLtNV9DkRqqFzurMqSURY7LNrmZINDnmIb27JRJkxp2q
         +SLF6cIFwI7yfKcFTrQUO0zgkkm33s5TAJopV6x5LKRbasP/NbM1e08QvM5TcXvoaHrf
         o1xIRJMlAZESMbCmqLpTKjkmvGseh8w/zSKnAHo8/gl7HbEelifGpXBzpIQZxSVKZKZV
         ExOLJ1b0As+B8zohWlq524GR8IuDApX2zxRA2NqQDq/aJH09n4XXKr+ZnQ9sH48pIDul
         izGQLNTrhuG9AzXFOK/lskVEam4/JWLFzNPlX9mqVfZwaE94YkhK3Hrv96zvLXUbkbKS
         jSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080451; x=1741685251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Qk7PHbGAO2P45jiVlOxlUZ0NSGvZDOG8uBk/PqG65s=;
        b=V83Cz++aJIXh2ehPchjRf74uelD5GeDLXdDMg1Pptijlghriotaa2CqoWcdliUiGWm
         80unQHHswIaKAYhY3qZkebbyaLPBjhnMRq7WLyB1+0kH3sa67TTjPVRHdA4+OycyLbBF
         8K74nYU25+OxoK7F0L/ykyXPU5J6mOmWA05sMjTKVypKhSNZPS9hvAbFFXUJn0qo7ws7
         Md9KLWGlNALdgz9tcFxodAZuuyzMiDuV0Kc2s5P0DMxegrqfM1NLbLcujMBYKRqhHtU3
         ARrEFnro42wb2PswtoHNYBAaBm9YWl6hRM2E60HPGvi3+8DmUe3rFJhtNedzyKPZAHOX
         TrGA==
X-Gm-Message-State: AOJu0YxSaYJTVqArt6C1ZUQ3tazBsLZy4VkgBRuPyO7OZ1cdHwIH2BlZ
	xQc4a7uqLxeHo2BzRM/uOC1+s4cd+4+VrnsmQGQgF1S/nMj69KHAepp+J0Bczx4=
X-Gm-Gg: ASbGncvMzJFiOrZIaMWPq92ovtFNPBtZJsuDS6PPtEcxdNIzmJE1Fw0ctrnH4ivUGNo
	a4RSzQw0pgS+/y/Q+j0NWs89BBQInWBxH5VYxlAxcYPF2JVyeUdIEre8E0xp9hAj94SfibLM5qq
	co4WbMXqTnT7dtD6hQm9d6vHPezeFAWTuoP+x/LGmOnCDAanId7QIIAVjPcUHRhX+VF7BmyVAEq
	G+r9a1wmtL2M7tMwrQiGiz0JXxvsbp3l4bIxPM6mBHDpjWaBgjrFA5ktDGMnnlgaSztLHN3Uvwx
	+io1BXONcyLIlL7BnAHi6X0yopdvbViXmk6eAisbCLzmzgjcMmsF79xXGaaNc8bTp8v+kdRTbMC
	Lk5vs0oM17WH305s=
X-Google-Smtp-Source: AGHT+IGEF/lq8Hg3PSKAzR+eHgyDy3rKPOhXGOU2ogpY3pw2Ua5ZoamaB7W7CEpNk7DmXv4izBVmCw==
X-Received: by 2002:a17:903:292:b0:21f:7e12:5642 with SMTP id d9443c01a7336-22368fbee43mr229958865ad.18.1741080450629;
        Tue, 04 Mar 2025 01:27:30 -0800 (PST)
Received: from localhost.localdomain ([2409:40c4:307:e1c:f069:cd37:99b2:31c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9da1sm91099985ad.68.2025.03.04.01.27.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Mar 2025 01:27:30 -0800 (PST)
From: Mahendra Dani <danimahendra0904@gmail.com>
To: git@vger.kernel.org
Cc: Mahendra Dani <danimahendra0904@gmail.com>
Subject: [PATCH v2 1/1] t1403: verify that path exists and is a file
Date: Tue,  4 Mar 2025 14:57:22 +0530
Message-Id: <20250304092722.25757-1-danimahendra0904@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250301105838.1481-1-danimahendra0904@gmail.com>
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -e does not provide a nice error message when
we hit test failures, so use test_path_exists() instead
and verify that if the path exists then it is a file using test_path_is_file().

Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
---
 t/t1403-show-ref.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9d698b3cc3..4afde01a29 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -196,7 +196,8 @@ test_expect_success 'show-ref --verify with dangling ref' '
 
 	remove_object() {
 		file=$(sha1_file "$*") &&
-		test -e "$file" &&
+		test_path_exists "$file" &&
+		test_path_is_file "$file" &&
 		rm -f "$file"
 	} &&
 
-- 
2.39.2 (Apple Git-143)

