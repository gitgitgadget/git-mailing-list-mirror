Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39195A0FB
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711191; cv=none; b=RnB49CK229qB8UxzJUx2TGUIEr6zVXwpww+tlvQNmysSBMHbaC3JRP2bRBpKnLhjE5a1LPmA7LwBOX19NSpWprjTTTNy43vwcOWLK9InbBmv/oOluKHkXkHYzRHUeAdiycUDJCAiydFoVIXj+IL6hIhy6ExlMXQLDJGoXj5Dx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711191; c=relaxed/simple;
	bh=8enfg2q9CuXi39g3xvOzYmOvYmrXAbZUTaddBmrDfU0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=aDWG+N+PxRwe2YMBu8B0UmGyXgaaDVJstcf1iRS8B3AXZrruEN4lh3hi32u92MMHq318QEPvaJ4lBogeZlxkxmyvvy9JVOYEWkB4n+YZz6IferOgCTspKeAGtYXgMChhFFxPZBifGPgEhlf6FdAYVluru591Fao8cTXUBN+DZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToX/Gi5P; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToX/Gi5P"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d23114b19dso25544981fa.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711711187; x=1712315987; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUH1t06zi2sSZWyI7qXaaHY4XUZjIy++o7/U9Pxv0VI=;
        b=ToX/Gi5Py0lZATgSrSnfR/B7rIiYhd4FPFmRJLGm+dC9Jg/VACmduiCYv/KCEgsbpw
         I3W03vN2FJ1G75c2OoNnROZGWiaKfaxyXKHBR0Q1OrR4vfkP/X6QuQ8YivnMhkVYZpfh
         /+d7SfUrefhtyGbFr8wak9RzRRbphyvFLaA3JmAJUEU33mK1HV2qrt3OrYgEJvRfhcC2
         Zx4ZHrd0nSwY66SuBY7VWVAh5ePXTZ7zV++PaUw6Oj1d4122tqFKK8vAfSyLrrFshbqd
         7yPUxFjJeAbtnSwj4fH3cX9zl6HPlXmcolIPPE4FCNMz2CEKDJy5tQoHnvmBi6VT1pYH
         ixpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711187; x=1712315987;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUH1t06zi2sSZWyI7qXaaHY4XUZjIy++o7/U9Pxv0VI=;
        b=BZlQC2lpZPEEgGl5OWrd61M8SHkfti6AVZbf2FdEltf9PksGCUP36pzAhMYLx0I5s2
         2VktkpAD0FbIDm4DNM6A7f/D0MoUIwAKFA0wUyVZ3eCEmqH4D/haN0NhmoeXj3armWmS
         uacYBmWjIPywLZhewnQgxyKfyv4/Cus43bnjUXMuY3TMILLEN+IsnS2NqTRjohhwJacA
         8Rlo3MEYJfhgZU9S4qcKfkpYlE3ti/MqEuUwFuMsJ8WWCylE3Sl3VBn5WfrvkaBPy86M
         tsNuH9ia18w5sM6SgiIY3sP8Y2xVa0LWdDjVVfZ4NanQCnLva0OQaGKXie73lR9kzCGT
         DmPg==
X-Gm-Message-State: AOJu0YxxYZwjwAbS98pHNjOeLDd55A+phboOAlUM1/4rHVAOPd7U+fWr
	jy6M1OxnIHwOFTNLw3WlNEGPee6TS6JcAXRN0yiukanRiB1QjQZEw9m2u2K4
X-Google-Smtp-Source: AGHT+IHtd8H4eTE6h144CJ8JLbSl2yov+af1qsVpF9skbqkFVp5/YudzeBXesbQpYYEdyRHdrzHqBw==
X-Received: by 2002:a2e:87ca:0:b0:2d6:ec7b:b69b with SMTP id v10-20020a2e87ca000000b002d6ec7bb69bmr1159446ljj.7.1711711186782;
        Fri, 29 Mar 2024 04:19:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jb2-20020a05600c54e200b004155387c08esm345552wmb.27.2024.03.29.04.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:19:45 -0700 (PDT)
Message-Id: <1a4feff2aea2e25dc11cbc83f94d0ac6a40964c5.1711711181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
	<pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 11:19:38 +0000
Subject: [PATCH v2 2/5] doc: allow literal and emphasis format in doc vs help
 tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    Jeff King <peff@peff.net>,
    Eric Sunshine <sunshine@sunshineco.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

As the new formatting of literal and placeholders is introduced,
the synopsis in the man pages can now hold additional markup with
respect to the command help.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 t/t0450-txt-doc-vs-help.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index cd3969e852b..69917d7b845 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -59,7 +59,9 @@ txt_to_synopsis () {
 		-e '/^\[verse\]$/,/^$/ {
 			/^$/d;
 			/^\[verse\]$/d;
-
+			s/_//g;
+			s/++//g;
+			s/`//g;
 			s/{litdd}/--/g;
 			s/'\''\(git[ a-z-]*\)'\''/\1/g;
 
-- 
gitgitgadget

