Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755E14F124
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185373; cv=none; b=DFec/YBBKeB1lR7bBVZgP0vnQGGR4yIQlC4fGwlb+D8bjmtrhdvFMLhveJglnqFeD7nEQ2RTBl3zjHqiVaBH7TYS8S6cbNjmYrKXIznBWLG9pO5ePPQrFWeIuHMxNauOF0WEsU4EvEElvcOzG63rxBOYtVdpgQCmQ4YHw/7qt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185373; c=relaxed/simple;
	bh=4ufd+lnF/x/gbVvxt6igaQdaCfeXszeiZxur2NDEL3w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RcgSMzlaaCnT5ZLPxMQ2wKAtErapKsq5fc2XKfhaIwHkd3gGj7LmFk8VNiuRvLnMio6T9uSh/3qoITGoZPYQ3hmG1RHsj2LGB+k75QY8HTMIIAGyJYd430RzBDOAiY0UXj0sMSlSa2lAZFHOGaTP50Ot0yktd92XBlSQHZAdRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6XGL+Dk; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6XGL+Dk"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso56414911fa.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727185369; x=1727790169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e356y39zVXRBnY/Z3w2k2oq9FSHT+mnTZxHfqON7Uzk=;
        b=H6XGL+DkFKg7ZgW8tkUii3ZWm9vpEtiqKqjbInY7lE0eikvYzQ9psCSNylX6tMEdON
         ej1rSsJzj/iUdn8EEDFYLmDdGj6K/WH2tK+WmpYa1APL4lDX+YQoZcbFEUbYvUUn9cu9
         W4OECv+NzxYPFiLMIpKJ82MMuTMxaFGoeS6e6wd9N+FZ1HUuc9zkWFxEbujrFswjiitD
         ptAId+dP7JmQyWN8Rxy/b4qjQvOUhu4PMc9/mmaEvGLlAPdWpzwtR1IZnxp8n5/PqLV4
         Z86YKp3R9MiWx85JejeIxXJWZ0drCcBb5cQPqrn57quGsBP/d7XRJvzFFY4mpVACGT1s
         3uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185369; x=1727790169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e356y39zVXRBnY/Z3w2k2oq9FSHT+mnTZxHfqON7Uzk=;
        b=v6vPVo1ubGE76ajknPTdds3Gg+Y4Vs89/nOsZYlfKh93tOMGaO+LF0aEb12sV4/tbr
         62Pm6CwU21m2dkE/qcPZH9rip3oBt1n1+YxRkR58qob0CaoRHhk7thnfDta4XiAHnMs6
         cROA97OivEQDMOUGh+0QvgfC8d0lk+8D7XaqDd8riKujRqQ2PZ9LAwunBm8a57p2bg5z
         k24UXBKB3A388JHxt+oh7CymG3RgNnIq9+oGK6chpWyi5ueXqo15vs2ZYQQnTWwQ+fio
         NcUCcwxypn3PiveWhHxsbczOGDM9O03wdBVoxS6BvuxP1UZF22Df1W5jOYdxSs71Zo5p
         OBcA==
X-Gm-Message-State: AOJu0YzmHSm3b8M0aFXrwdKrzE7nAj4wLoywsnhYXV/m743PFv66mVQb
	o2IIwRsNyOuwACSPibcdKFuTP6I/b5j2a69ymNu9ufU66KfyJBqPdJj8fg==
X-Google-Smtp-Source: AGHT+IGy2l7KBTWk0jkgRRgoJM5bOI2EN5dZthfFuzzA7T0Tmviz79YsFKlRwzllCtBfbZ9Y09f+TA==
X-Received: by 2002:a05:6512:ba4:b0:536:741a:6bbc with SMTP id 2adb3069b0e04-536ad180359mr7711093e87.28.1727185369342;
        Tue, 24 Sep 2024 06:42:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f787dsm84772066b.157.2024.09.24.06.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:42:48 -0700 (PDT)
Message-Id: <f6c32ec609cca56f1c02a75929dc7cc19d4834cd.1727185364.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 13:42:44 +0000
Subject: [PATCH 4/4] archive: remove the_repository global variable
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Replace the_repository with the repository argument that gets passed
down through the builtin function.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/archive.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index dc926d1a3df..13ea7308c8b 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
@@ -79,7 +78,7 @@ static int run_remote_archiver(int argc, const char **argv,
 int cmd_archive(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char *exec = "git-upload-archive";
 	char *output = NULL;
@@ -110,7 +109,7 @@ int cmd_archive(int argc,
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
+	ret = write_archive(argc, argv, prefix, repo, output, 0);
 
 out:
 	free(output);
-- 
gitgitgadget
