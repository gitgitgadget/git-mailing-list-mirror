Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE81C294
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256256; cv=none; b=LuAUDa9lhePS9y+pUtRkD5VJoFlSDVFeZva6zc3OSBXjAtnY3qK6pDlU48WhzIbmG1s1RxtvKlIm+3skgxpAJFD1dpJmd51Ci+H2hhYw8LNBw6c7MvMEoVXQpBQY8lfmv7uTuV4LD2V90L32Rc2/Jmk3xSAr4WbMumGz9jUxN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256256; c=relaxed/simple;
	bh=6h5e1f3ZIeMJQUz8oMhboJbNf+tiaXGt48DYcgHkjUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQ6n7opZ63y88NzhLTCS4F86tHPy3tiFiXSBjAdw5X32PEARYy/O8Xwwr1Qjt6s6mlFZapXlYSNxUFtK0ari5eNSu5G2Q4/P3dAzTHxuXLJcgdFsem1lxlQhRavz9O/XTvoHUesuF9QvysqlC6ipBZkC7XuomaIyf1SIaYfC1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bshxHlXH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bshxHlXH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d93f2c3701so33788995ad.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 13:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707256255; x=1707861055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mtZl/JLBY55f0TcDPFOUW1HtKEHIRTFgF3o82xinFE=;
        b=bshxHlXHG9/pbjXsNiEaDRJYHY7ZmHKC8WncZuJv8+PjGSLlHhhSiLyuuyETC7pWrn
         5121SJehJOD3oxcFhNeiRtjyVeQj90qVciaXIZz0URKqcwH9i1ygBZgauOj/SixhnQdq
         31jkj5UldW2EUo5yWhvM3HtaUqWHTAe63Xc5jrcLotwF1EcLxMTvMfNKQ6wbJZ8xu73h
         NoZKrpJZw/KoUR3dzpo/8ObWb1M3grN/9hYRymqniJWaVX/Ych2Slb7eNzd5JBkL02G8
         Ph0C2c4DEfZV0wbDkB5Pt5KMVkMz8zOy9uFFLJ/IzxX+giPGS3Y3FBv5kp4Ttu+YYLE7
         h+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256255; x=1707861055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mtZl/JLBY55f0TcDPFOUW1HtKEHIRTFgF3o82xinFE=;
        b=IiH0KBoCjww0QLlAV1dXSzuYOur1pHKq0AasIKrGzi6xm414gOmTsbEQduddJl2Dbm
         aRgwczB7DjTRvgOczGmTpjTMG6vA0BVykM2Y0adfW5mlvrC4KbdMhqlEO5RL47WQnK6j
         qc7zw1gGG6CKzRaJTxG6deOKGB4TrEDrxR2K6mT87F0+qqHfGl4OBEWdxN7jwjP0McmH
         euLDHY5gWlQuXo4ZfoXQqlnfuKlC2XnT9dd11n+ay7M52C5C/0fRzwCXX2B19Au+7Nun
         8Fd3GsP4YHdsp3STF/RS9TIQMWWmRZA8kn2Lsd8N4OCcvUxPNMco7oTUPvLySzYvDeZs
         VTLQ==
X-Gm-Message-State: AOJu0Yyoj9Gejtm8pygMk/HbZp98JxqqaJke2ejnOjFJ/fCaW+zwxNmU
	BN0ww8sWUeo4bIZhQ8VFcdwBOAOVqe49qr9AtG5tfnFI4mTJQoCQ
X-Google-Smtp-Source: AGHT+IElu4KVRh9S/xMhk+ySYnBMdseoh/sDOZ3j4X2fo6ZVWHB/vEygMNBxPy/OENnMFh+4RbWLKQ==
X-Received: by 2002:a17:902:d2c9:b0:1d9:9e4f:c0b3 with SMTP id n9-20020a170902d2c900b001d99e4fc0b3mr3595360plc.64.1707256254811;
        Tue, 06 Feb 2024 13:50:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV+TshEjxzF6porxSJJHRGqHdSTNCxklIhfMQB6n2xcCqkB9e4aIochtU8EUAsPWM08CHJLKjOdHDX6J7OQxVm0QzANZROcDTVdiE08rJ8MS5bI
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id ke5-20020a170903340500b001d995305c8bsm2369860plb.290.2024.02.06.13.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:50:51 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 45EB252016D; Tue,  6 Feb 2024 12:50:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v6 1/7] completion: tests: always use 'master' for default initial branch name
Date: Tue,  6 Feb 2024 12:50:42 -0900
Message-ID: <20240206215048.488344-2-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206215048.488344-1-britton.kerin@gmail.com>
References: <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206215048.488344-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default initial branch name can normally be configured using the
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME environment variable.  However,
when testing e.g. <rev> completion it's convenient to know the
exact initial branch name that will be used.

To achieve that without too much trouble it is considered sufficient
to force the default initial branch name to 'master' for all of
t9902-completion.sh.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 t/t9902-completion.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index aa9a614de3..a5d4e900a2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -5,6 +5,11 @@
 
 test_description='test bash completion'
 
+# Override environment and always use master for the default initial branch
+# name for these tests, so that rev completion candidates are as expected.
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-bash.sh
 
 complete ()
-- 
2.43.0

