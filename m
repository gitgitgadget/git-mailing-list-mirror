Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7212EC0B3
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673026; cv=none; b=llR272C9epgGZkF6YTPFbNJPpzZ9B73BQY+jWxsr7P9s6lqK5J0WQyaGHV2Tj4tI3MQmLpueiUH9MLfJPwBchtbFIsQ2vCTVRq2hCrjFutgALJLkDImbQHlMXtbafGQYTs/pikLVr8z/QvuR5ClgI1beFYp5391bbTqXJIK0nNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673026; c=relaxed/simple;
	bh=kYaX/YYAYC0iY+dLN5XW5TG+Y4i3b2SnB/My2IJ/LC0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uaO/C8KVCpfZVITncmhkWuy7YTUBG7VVd9fed6s0ZURzwHma+f0kL5AkwyAu4ocODfen0/kl3vZjzuPVno3W5RQtmaqBHH8EEEE/uSZB5fjiuV+a3yD8Qqk7LOHIxF4ixxCjNrHR1dSLn/sGYVa+fohjucCC/YpPkOant03Pv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhN/OihP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhN/OihP"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77256e75eacso1603300b3a.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757673024; x=1758277824; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1JDVG8xygfjlObDXvP+4b3WYLTw5LH+IDQnYWvtrA0=;
        b=EhN/OihP3hxUNZzsO8CBC0ozlC/qVazHGkRYHPn6OPO7W5rfxy5foSPmC1jQ/dMHlD
         uJrhvBiJs91RbnSxY0lTenAvSOzC2edsJ1jr8fE4F+yY6qFLPl5s/4yYJP7azLl1r2Kw
         9dIa4utmnDV1VAEltzAURx1gSlxM2KQ8iRFOSe4A1cf9XEn2yhf+Dx9ES1zUxt/vKPbT
         fLXzsN5a6blbI5spUvMgE1tVs5rQyAQPq3bubnQKIysgfNbpvqRJTBrmiAve2ebVnBQp
         +IggQi1Wb78fVFWOuqN+2q36ACIocgS1FJ3b4DPQkyCXHZb1X7wvogbTl8M57quiNU7u
         32SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673024; x=1758277824;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1JDVG8xygfjlObDXvP+4b3WYLTw5LH+IDQnYWvtrA0=;
        b=Pzkau4HWioaGW4LuQF6CND+59VHMnef8ax9lNBqmhtZokbGsPXzsAzE56+29r3aY+K
         CJh/yroVzDwX+xaR7JKbhIYiZX3/30CF6iF4NpC4fGNUzHt8ywFr62yTqqfrElsUkSr5
         ViIGtd8DNlc0504M/6PaIUPibHrixB33/F54buri2hZtWyY/i6pS28SE0m95eQMLVnwF
         0ahzMndLE2osxqZPpMp2oVLItklKWrKKguI3t0jEOThXK52FU3TPsbDUij2AD+dIBizr
         1d2lUCpO6JbXOo89SmiiXKR5BHFZgPGn6DxurEx/EIga9+5VAnq5RGVF2Cz3yD826jvu
         uRUg==
X-Gm-Message-State: AOJu0YyUAPKjwbTQXUGbbVKbs9Qt8gBOdeeXhZxyu6Inz079psG7EvPs
	1PhMNOQRQCiAHkY4Sp5MzLFmov71yEGcQ7cJ0h+TZ/2vMRr9oAA8XWGr3Q4fFg==
X-Gm-Gg: ASbGncsWchYy493WxESukyzYoHwOt/eKQ9c76z1u3lZVl0twTljvk3t4OMbD0Ljw6Mn
	lMeEuzeTVbUE3HCiIRa0Q8vUXcMvYtLeRbQKxnabQQ/n3wsNi5tEdP0oFX+2Gye6mzRq480qDaH
	cipEXGzvgqhIsKvB8+XODYOZ8khOfJu0D7sIRB+DQAbqInJJJeVeTtj/PCEHrg4/5HGHhS3qyBl
	Nhg7KTk59c7fYL2vJeljNN2/1gEs1GINwJp+cP/ySJDOwUWXv0gPsBnTPwZfDxv0gUOvBx8lWlj
	X3DhUSCQSyXCf+z6K4af0I6Xt/jNWjI662R9sWJL2wlCooppBMJydRzhQ8qxZ1YsxTJv8auKN0Q
	OJmK5SfykDS7ILkZWcL3x5CBDJCnla412r6L9mw==
X-Google-Smtp-Source: AGHT+IF+XG8UA39WwHDezZopRVOxz4FPopPxdWMx6U2mwOHH7pLpZ7XwI/bPF+apv1zGvU2YAxbqow==
X-Received: by 2002:a05:6a20:a10d:b0:240:1ad8:1821 with SMTP id adf61e73a8af0-2602a5936cbmr3137154637.19.1757673024133;
        Fri, 12 Sep 2025 03:30:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.175.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd982476csm5190469a91.11.2025.09.12.03.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:30:23 -0700 (PDT)
Message-Id: <460e5e8157fc87a4246c49f53e34495bc33d4432.1757673011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 10:30:10 +0000
Subject: [PATCH v3 6/7] sparse-index: point users to new 'clean' action
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
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In my experience, the most-common reason that the sparse index must
expand to a full one is because there is some leftover file in a tracked
directory that is now outside of the sparse-checkout. The new 'git
sparse-checkout clean' command will find and delete these directories,
so point users to it when they hit the sparse index expansion advice.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 5634abafaa..5d14795063 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -32,7 +32,8 @@ int give_advice_on_expansion = 1;
 	"Your working directory likely has contents that are outside of\n"     \
 	"your sparse-checkout patterns. Use 'git sparse-checkout list' to\n"   \
 	"see your sparse-checkout definition and compare it to your working\n" \
-	"directory contents. Running 'git clean' may assist in this cleanup."
+	"directory contents. Running 'git sparse-checkout clean' may assist\n" \
+	"in this cleanup."
 
 struct modify_index_context {
 	struct index_state *write;
-- 
gitgitgadget

