Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249611B965
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660124; cv=none; b=ek5rpl0feYvU5DyejSlpHPf3s55QgTiwqkUPJy0DAxc2NtWHNey1M+ButXR6ul8+p32/HsYoPpHa2hSLdGIbxuSNlC1mx1hfuJIC+d6aLlgmSLzt+vN5bwWk8/Qenmqi18B1HLkaEva5uX/uglkJEtMWIIbt46HQ9NV4DrJN+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660124; c=relaxed/simple;
	bh=zuNSn9DhCw6Ow1Go+PRAMJr6NrLexYgr4WwI9VTb9+s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EFyFqFSBuR+m8za52DwaZPsSMeD6mTNw3/C8Z2mxfhCjqQvjjopIFoKKvLHQ6FaVH5J9sRfRalCHzcDqqidFZ3JRLoOEQLuqpXowVQ6rKyH/O60RuC09Jq+C6tvDfyBw9grUyY0g0fQIyo7bwKC1gCl8c+Yj4JvigN1GfAKdSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO6genn/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO6genn/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4128e15d5e5so3036805e9.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708660118; x=1709264918; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHVT+69kEiRUOzPdcfjDU0VbSyYGSlyjD0ZPJwzS4KQ=;
        b=fO6genn/k6E2xeAm3XO1y+Q3+36jWU2IAIc4329M6vnvpPC0I1CUDApHs2Gk5DVUY1
         uvAWi7jfam3CAtkySSGN/6ow6PXcibUZzuJLYwsFxrfBEnXrKmyf8CGic+/NxzpD9EOg
         lwwknflrmSD7wEkM72J7bs6HibzhuHuFNa2lN0h/3mPTSeSP630F92jT+bC1xcXlnzIq
         uVIDBSjwMcBImzPrhZhAekmypHT9lBRUPTPQAvIcq9vh+BTcqOZ7Oq1l1b8trcqYhagi
         w1pp6r1DdiK/845CErtQSCnzsmrwIxeWuky4RU/xVusQga4F38Ryon8gbGPP8v+vNU5F
         35Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708660118; x=1709264918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHVT+69kEiRUOzPdcfjDU0VbSyYGSlyjD0ZPJwzS4KQ=;
        b=dYg54Wcd0nLQg3GlP95laamV8wBAKmRY17OfFVGvX5s7DiPT1tNZ+Htpe5EP42ixRx
         XQYApJf+TfpfFydmu6wjEWzq8F+QYoYGm5XQkK08b2MzcXIE6cxupVd3TpwoQeky/z+l
         5cIU7YNZcwmJvO4qMAMGS9+i3Z9QXWW+yEnReVL7bD7A1WDE7NAMjwH+/b5bNgWoBmKU
         4TR8W/GNPJWkquMH+FfxKESWVVKDNCDo+QDHoS6+vD6lauT44j1HI2xTNhv3/xLPHT5v
         +0ErgRPT1V0AudSQcV+Oz7M18irqg0PhA6iAQ46ygzFnqjfjo5XnhNBmbd1H1F6w5LZp
         fakQ==
X-Gm-Message-State: AOJu0YxS64jBOA+9G1phw0AwdBqeNLDrtT0oy3FODzElxu7QcHWKIoVQ
	4l8tY/8ySYaG51qn/DlQacWvH1gGtRyjDefynqtlArgTwb6WVst/BBs0hSzA
X-Google-Smtp-Source: AGHT+IFlIfB8qUSYmRmDc4HpP2rhqgTJ1b+22EgXwgdqGbzmpqXLBZHhlgRmXtY+Plaj2RbJCRfCvw==
X-Received: by 2002:a05:600c:34c9:b0:412:8f3f:9f83 with SMTP id d9-20020a05600c34c900b004128f3f9f83mr338778wmq.1.1708660118497;
        Thu, 22 Feb 2024 19:48:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0041270c2b95esm653413wms.29.2024.02.22.19.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:48:36 -0800 (PST)
Message-ID: <05df5d7e2d50cba77f53273c781f97d24144efc6.1708660111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
References: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
	<pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:48:31 +0000
Subject: [PATCH v2 2/2] an improvement: removed configure.ac changes
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
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

Hello Reviewers, as an improvement, I have
removed the CC_LD_DYNPATH changes because
I was able to achieve the desired outcome
by passing it to the make step.

Signed-off-by: Haritha D <harithamma.d@ibm.com>
---
 configure.ac | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 64569a80d53..d1a96da14eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -463,9 +463,6 @@ else
             CC_LD_DYNPATH=-Wl,+b,
           else
              CC_LD_DYNPATH=
-	     if test "$(uname -s)" = "OS/390"; then
-		     CC_LD_DYNPATH=-L
-	     fi
              AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
           fi
       fi
-- 
gitgitgadget
