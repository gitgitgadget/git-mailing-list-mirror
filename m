Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0621E0BD
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784114; cv=none; b=D/LAaXnH2NGYYJNZwXMXJJQ3enLKnUn85Tdy1wdlovRl09uWRDe5G7CacQMi5mmc7l7gV9BO+UtIUmY3MD3+iCJHG9Ku/fjvu9+t8Ieb436yipDIOsX3ULyXKGQFsFXoDJt0Xmp3eo/2uhT99dZHCy0Goq9kgkdfjCfwdYen6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784114; c=relaxed/simple;
	bh=gfKF2CzdSFvXmPppE9J2CqBJZ0s5CQAuc06r5UBl5GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jymHxcDUHI8IBtJ3WfEJubDI9RBJ5xXbje21UCCK8LkO13251vIHGPE3BIc2N1R/5/bepF8oG9uEsafXaLg4XJKg+1zWnv0RUqbQ+Pr+yCBLEYcENtQV58vcJvKCKJZHqIdfR4idMHO2Xv7BM2zdva3/s5/2Bb3i6cKcPZkd4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9h45xKO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9h45xKO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso6485936a91.3
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744784112; x=1745388912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLlmzLX+QzLz5nMkG9Wsw9/tZPOjKZT9Ci3msO8lTK8=;
        b=L9h45xKOGaa1FQILuPCQkOlDr3mAOmRToxLyAFiovdUiUfENHf4i0Lc185cBSOOzOy
         A0emlcOQhTjU9b93SzFvVOoTzNfregMT6nvrMILTVDh174eqQtWfymh9NBjzjhkRqm5R
         ZYWGZoEGcsOC0g5yU1zVYyg2Xv5FQNwgM9ch8JxLmGyGDFe5eszwbqSfaZv/C9koJbtK
         xsfb+SY7aiF3K/U7rAb3P3XPYcppIBXH/r5I0t2MUxemFs0ezm1kyHAEohS94SwwAAtq
         EbVz4ujDMbAAKx8XZ9tEMxgrcJ6lZ0BOVrEVer4UdZFJcz4ZSlGeeHl6wrqC9LNuzRnL
         /ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744784112; x=1745388912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLlmzLX+QzLz5nMkG9Wsw9/tZPOjKZT9Ci3msO8lTK8=;
        b=Ff4rzM4/6KuKP7/g8e9OdoGLhJcFosy2UiNCXSHJD4+ZYYT5RPbn0nwjLvTYW6RBvr
         aJW4zJgL28E1B1Y/N1xSZv+DA9Zm2ZQCvGF4gCQCLHTZH5Zlxm05zMgWs65qS0YbkKjZ
         RpSAw3goubSlWnT9Z5pJYR83tyStKDrstPaFbkrEIFYSs+CIuAvXjuG9prqwfQL2x2FK
         gTLQ4URoIGP5c2l5wo6J9ek5eUc3oF/glYtiDSbMiSWC0iSc0jhZXcnevqyGsbUSJ5df
         DRwAD/Tykj1rryL6AIlV/T6E0ZgauqUZVG8rbIo8oLh+yhitgRMm8p5qAzE0F9zTf4T+
         H2WA==
X-Gm-Message-State: AOJu0Yx3CoWCWYZFj0z6EiihequTuaO8velHdoUpq4T1veZtjN1vLBjl
	dqS11ArfuSRUF9DLPFXhcUV2B9tNc4Ef+lEy8mp5UsarqiK7o8YZdPUu8A==
X-Gm-Gg: ASbGncuiw5QJc4vM51pFM8DwuQHVPJQxIgCgn+v+/BVoKFouEew6XJnvZcdxhznw9HF
	/Fn+rUne0+CtEjan7+98hIaQxOiFjuzmIaJXjuMqdbvDYQq7CFoaj8bSbs8/yUaIsPBK7qdErkP
	zEQxeQS98BwQJfQGGWCXDel6w1zdYFXhqesCmTVJU0VwrcjVxjTLlhz02X6PPnXT25hELSA8RJT
	PKTh5VYhq/q/q/x9GWEAYXC3h2X8P4HsLcv3T6CRyQBxb/sgI3PyD9Mht/zRVRwGp/9SFukDNva
	XN2ylI/ejbgq0eKtkvWYo3+2JK8vJUQ7k8+F3GqxT61UM/VtNz/Do6z53g==
X-Google-Smtp-Source: AGHT+IG0OE1TrR9KDhG3bRiDErCo2VeSeSecdDdB1MLB3icYaBg5yJTKcvEI3RcvBzU5OFmdfH1V9Q==
X-Received: by 2002:a17:90b:3944:b0:2fa:1851:a023 with SMTP id 98e67ed59e1d1-3086417426bmr896338a91.35.1744784111907;
        Tue, 15 Apr 2025 23:15:11 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:5522:eab2:4cba:30d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308537cdb13sm1688603a91.0.2025.04.15.23.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:15:11 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH 2/4] Docs: Correct cmd_psuh and Explain UNUSED macro
Date: Wed, 16 Apr 2025 11:44:48 +0530
Message-ID: <20250416061450.25695-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `cmd_psuh` function signature in the documentation,
was missing the `struct repository *repo` argument,
which is standard for built-in commands.
This commit corrects the signature to include the `repo` argument.

Additionally, this commit adds an explanation,
for using the `UNUSED` macro to prevent compiler warnings.

This helps new contributors understand,
common practices in the Git codebase.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ef190d8748..b463d42f63 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -142,7 +142,15 @@ command in `builtin/psuh.c`. Create that file, and within it, write the entry
 point for your command in a function matching the style and signature:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
+----
+
+We also use the UNUSED macro to make sure we don't recieve compiler warnings
+for unused arguments from the function cmd_psuh.
+
+----
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, 
+			const char *prefix UNUSED, struct repository *repo UNUSED)
 ----
 
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
-- 
2.49.GIT

