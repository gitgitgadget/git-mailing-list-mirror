Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O40JWDG3"
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D98710C
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d81864e3fso39697f8f.2
        for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680719; x=1701285519; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfUGHqGmJVI7mFma8+kdCMSVrhbvh3TgjSJ7W16vJpg=;
        b=O40JWDG3tSvNrsn+zg8fn1Nf10wRprE0MwvrIrOMDDG1sLm4nZLS50RjIQFpWO9naM
         vzxK58BU3DF/Y4evX+NW+U3CvrAuh+3DtQso2dBlsLwIGBVxdYCXXW5wyQDvmBb5BiPm
         igw/t8uNT5VZvtVze94MeHAHKUyyT7jFXZe/AN4ZP6M+Uy+RINvp05zj+101Jp17nWER
         PXP9sTzLNOq2I8F6PXVLRTqKhQz/khdzQVHhswapw+yRbLdcQgbOAT0RoqWjIEVyOLJX
         p9XokdeO8J7jMCgVmcPlwJ8nx7HBMEQPA+3N5nv5hbIR9rLD9zPpiK94PDH2hXPblGuB
         EfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680719; x=1701285519;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfUGHqGmJVI7mFma8+kdCMSVrhbvh3TgjSJ7W16vJpg=;
        b=r8v/9wkr14mOLIqd5q6BCNIUwWhb2eXzCxnfB8kmbbx5j/nYd9Dx1fl/1uczu+Xchv
         7YQmH9hssSi1A5ksuviZ6JKo/xZ8shy9BzTK7GZ/nmhisHSQBcbjsn5GVJLKfx8Ul5Bh
         0L1YcpmLWadGiApc4ZSnXm6jBQamcE0K7pHYEP7VPMuL/JXkceSOK9P7NEM+7gwGUenR
         cXGTcV1zEyApGQrW5oY1/TpxlUcSr37Hx3uO3kvzw9dABwjQyUxB5P4UjvNO4pjAoJ9r
         p+x4wMId0Gj//TjhVn6zxRRbLkmX0PHRNDK5GQsT6LNxoxIWLHxLXWQPpAtyOYqBRx9k
         +aUw==
X-Gm-Message-State: AOJu0YxLy2wdv/7VRdpWn5J6GVG+v4ieWhTHZDTrgJuIGMn5IWa5HVc3
	onbFpS88mI1sFpiUYSwpPlXf8h8EhMY=
X-Google-Smtp-Source: AGHT+IEpWSbp0Fyt9Ia9IvwNwWPxBjQzRHXrqP2OBTs10zr1E2g8RGH+oZJ1tqNdkhAR0dbQtL5vSg==
X-Received: by 2002:a05:6000:112:b0:331:6961:6cc7 with SMTP id o18-20020a056000011200b0033169616cc7mr2427953wrx.25.1700680718909;
        Wed, 22 Nov 2023 11:18:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d46c3000000b00323287186aasm142471wrs.32.2023.11.22.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:18:38 -0800 (PST)
Message-ID: <97d17c22ff310c26c3ec391c7bf870e7e5bab4f8.1700680717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
References: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Nov 2023 19:18:34 +0000
Subject: [PATCH 1/4] trace2: fix signature of trace2_def_param() macro
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
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Add `struct key_value_info` argument to `trace2_def_param()`.

In dc90208497 (trace2: plumb config kvi, 2023-06-28) a `kvi`
argument was added to `trace2_def_param_fl()` but the macro
was not up updated. Let's fix that.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 trace2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace2.h b/trace2.h
index 40d8c2e02a5..1f0669bbd2d 100644
--- a/trace2.h
+++ b/trace2.h
@@ -337,8 +337,8 @@ struct key_value_info;
 void trace2_def_param_fl(const char *file, int line, const char *param,
 			 const char *value, const struct key_value_info *kvi);
 
-#define trace2_def_param(param, value) \
-	trace2_def_param_fl(__FILE__, __LINE__, (param), (value))
+#define trace2_def_param(param, value, kvi) \
+	trace2_def_param_fl(__FILE__, __LINE__, (param), (value), (kvi))
 
 /*
  * Tell trace2 about a newly instantiated repo object and assign
-- 
gitgitgadget

