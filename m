Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2F1BF24
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099050; cv=none; b=OOv164Bu/NnLsCylZY9q1xHqKaZ9IEPnXOsOqkDln2vkVoyOJvzcu/d1wJHcQeAATvP4hFHYYpJWZJrGF59Kyh2zyYUAUxutf3hbGbKcHW9FHarsNOfoVD7iMQ/pw2Jo2qBYc6yzTQ0rGan5CBGt+W5tlVd38C5z7pvb5Uvxzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099050; c=relaxed/simple;
	bh=RwSw2n0VGxAinrFutu8sBIvZqSbF0hYODfcduSUKH/E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RBD/+8vVRTzCcjHAHIxazHszcYZVPyLjLE5PStj01HnOPmyn9DMv77xbpHbLE4IGxrC1nBq6HPRlU6gN3mldN9i77kqFjhYsdbRpWRtyoQylibfXPMjoCArLaXqhJfDAphzmgKUInWcgmzXNgxNYi66ojgPxwRnYqZtmZ4izWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVUlNSg4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVUlNSg4"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso358635466b.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 20:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728099047; x=1728703847; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvXWV3eIL+YO9QwpdbtM7lr2gqNwX9dCeM2yR1rvk+Y=;
        b=XVUlNSg4sfvfZzzVyXAML5oFHrQn57xvevy6hwUDJAWn8qQbRMe5mq6FsfUsbQprUk
         IEvQ5FSfABy4c6YqT1QogO9gVTw828pujFqFIhkrfry8M+NwuqGS1+bZwue9vHHWu1lK
         kAfmOk1mjfwDcIpM8QgAZcXHXqQirKVLpXlA5nFxe2Vitv5wqhDMAojS2z3uK5rWs09A
         4WEe9Ld6Uny4vRcJYm21FXK5Oog8NSHT1Vkud+gqjhBN1NYp/p0XOzls3tkIm45M/yln
         ARAiwU7aZd/9pUAGoYBJ/C2qpQcOyBPh/SezZq1Hj3oOrngm+ukIECquXH1sUaus3xgf
         Z7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099047; x=1728703847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvXWV3eIL+YO9QwpdbtM7lr2gqNwX9dCeM2yR1rvk+Y=;
        b=hxHf4qhvAb2Au/AxQJuTqoIZv7cqhBxkeKWONkpDiL3I3D9dskzOjUa2IYLqieOF0/
         HFyOtVkUC2z7gcUjVDaZX4Yr0puY+iOheaUFlJAgX6PU5W/EBzTooiVCQuRQS/16+MHz
         xzEp9IBtQ3gOee0rORhmkHHRvdrQiH06MZEfbwGN2rnEFC9qouwNxWe4xcLctn/ld5vJ
         Gx+7X01+dvCOmT7DoVmScBDlC7DKVWLirQqA+WqSPHWnbGa6/CTNxJYKbJmLphxBrJVS
         rvMaAgu5CP4pAQ9DzRZMsjN9z3qa/IW45Ax38IcfO40O2KmtNA+XFMaluEZSvf0heZ1l
         ZOMA==
X-Gm-Message-State: AOJu0YyKlreHERebZK/xU4JtyoGnpB/nYhqNzdgde4FBb7fYk8ZhMFk0
	AB13FTGCesQEjkU/e9WP3fihvP2SEKvJ4d1XMGyGpse9pMC5f48Rnj8XZg==
X-Google-Smtp-Source: AGHT+IGUq4YQttDcOC09hWyh/EYNFk1ueadLbf8Dkbd099aBTjYh3PkbashpjHj2sT4dtPHwxekCXQ==
X-Received: by 2002:a17:906:bc14:b0:a86:6d39:cbfd with SMTP id a640c23a62f3a-a991bed85f5mr393210966b.57.1728099046379;
        Fri, 04 Oct 2024 20:30:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7e1900sm74096666b.201.2024.10.04.20.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 20:30:46 -0700 (PDT)
Message-Id: <1b82b5dc6782e21eebf019585d2aac704ec9e8f0.1728099043.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
References: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
	<pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Oct 2024 03:30:42 +0000
Subject: [PATCH v3 2/3] annotate: remove usage of the_repository global
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Remove the the_repository with the repository argument that gets passed
down through the builtin function.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/annotate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/annotate.c b/builtin/annotate.c
index a99179fe4dd..ce3dfaafb28 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2006 Ryan Anderson
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "strvec.h"
@@ -12,7 +11,7 @@
 int cmd_annotate(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	struct strvec args = STRVEC_INIT;
 	int i;
@@ -23,5 +22,5 @@ int cmd_annotate(int argc,
 		strvec_push(&args, argv[i]);
 	}
 
-	return cmd_blame(args.nr, args.v, prefix, the_repository);
+	return cmd_blame(args.nr, args.v, prefix, repo);
 }
-- 
gitgitgadget

