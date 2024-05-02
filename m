Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5FA24A0E
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625674; cv=none; b=K20RMgyMyVkmXE9XOrF7YMc9ayFd3wjzzABr1E+5tcbc+eeL6zd+qRMqBDzSnR5WHNvVWg8UCY0kDCaG7BpDIQvGdb6CUu//lqR2MJaSWmIK0azDKFmPxiU2biZ4LvZnaI066JIRSMNfg3V1HLSryTgU8CkxSnwq7rmo9IUcKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625674; c=relaxed/simple;
	bh=yTTNOJw+bgqYx6sq4o7FfuHJXJwSHwSeBLlGpNLuJpA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tyhXkkvxa/sa6qJMw/QYOS49LjXc4xi1+deb981tyra3HzY7d+kTqZFkSMRRwgGQQqgBSplFEyc2/7Xhe+jh6giZJafQkTSqJSoCHadq2RCaVLOFkjsYyfL6BFH4dpbKI3Mi/pxWce5nyvZtKSddrVC8zS9BG0WEzqy2zYcydcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCfZ/yce; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCfZ/yce"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34dc9065606so687336f8f.1
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625671; x=1715230471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgga1YobWZAZi6qF0+Oew5+ux5Rz6Z1eug/vhXlcR34=;
        b=WCfZ/ycexUMLbElm+SuNyESdPcpmye9S2gGoVnvmofbue6sTvszdWXd38eOq2BMnZV
         /SCz4i6OMfynCtoZs82GZXjGP603czOqIT0dazRX6QnhM2U/KzGXhMvCAJoj0832ik0c
         psa643l6nDdThNI9V5bMLrPadPBlKrZVr3lOfpOGggD5TCYdotm+Rph8vg03cOAgWsRH
         xEBhjlz34B9EBy9Xb2HNokJJgOr4j8uW85zMO4uFQwHSGEHNbt1fdcOdEnBm35wufusf
         6ox9QSQHzGSNvU5xSiveiVnLDW5JkdKrJHkDV+QR05zmmd9dODlg+uv6o/nb4w2tn3tg
         +Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625671; x=1715230471;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bgga1YobWZAZi6qF0+Oew5+ux5Rz6Z1eug/vhXlcR34=;
        b=m3OBjTCT8GplxjtysUU21Sluxl3Czx+Ty3SmlOBlMM+fNnxWcB7q0rLojDfGwhRyvO
         ceRn/2gsYlBZgpCqqZFiHICzz6o57nX1/vMsLlTYwhgw8Isrq2DgCYFk846L63V5RaLR
         Dy53f1IwrSflTQ+0VrFs56KVTvnNtL21OUU5xfpiBsdZGCKxIWH6xf85D5K2KJUUd4XZ
         kRs5G+34uR4FpbRfvy0Q6wMTsNIpdh6v2GrX8+Qg12iLAnbr+DZd2u3W3ZIXBN38QPQE
         C6BZybNZRNzSkEx2rnr7cefjEfnZv7xfwQ6P+aW65LkpaKlcS29rc0HpTwEmKpFFpj5g
         JAqQ==
X-Gm-Message-State: AOJu0YxaGmet70Y33XDd5HOSi9qVLTh18iFDR58AkrWCT9d5BGEnsfVK
	Qe/ecp4rOuPhGN47Ux94WAjmC0Qz6du+JaRJXNT5MHGAaGWNMrQ/o0CLuQ==
X-Google-Smtp-Source: AGHT+IHccp7iz/CNfOvmz66ReZSBlF+nRx9QoXebCb9tR6wkeaXtNNFw+6MZ4vRrN3mx7Nrk/GonjQ==
X-Received: by 2002:adf:a30d:0:b0:34c:c53e:f2ca with SMTP id c13-20020adfa30d000000b0034cc53ef2camr1072167wrb.14.1714625670746;
        Wed, 01 May 2024 21:54:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30-20020a5d6e5e000000b0034db5f648a8sm244105wrz.77.2024.05.01.21.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:30 -0700 (PDT)
Message-Id: <8a9f71442d8a5ae6bb0cc9e2d098e85b7e4a4764.1714625667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:18 +0000
Subject: [PATCH v4 01/10] Makefile: sort UNIT_TEST_PROGRAMS
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linus@ucla.edu>

From: Linus Arver <linus@ucla.edu>

Signed-off-by: Linus Arver <linus@ucla.edu>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4e255c81f22..d3a3f16f076 100644
--- a/Makefile
+++ b/Makefile
@@ -1343,10 +1343,10 @@ THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-basic
-UNIT_TEST_PROGRAMS += t-mem-pool
-UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-ctype
+UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
-- 
gitgitgadget

