Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B61E7C07
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460460; cv=none; b=a11vzJJrwRBXPOWL8oYwq674dDkFXdDRr1XGyslCz8Fv6p/1qQw53/26sPv0otZs9RMFhcoi+Tc74yBI/I80ZjfzOE1LZz3q10hSj4rSvfZ/PIjU//+cAHzLchOCeHi+JRPN5Ao/l3sVBSXPtFiV8VIqJ+VPVYDhwSNffXxztRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460460; c=relaxed/simple;
	bh=M9XsA+OSmsH4RsuXbNaJhjb92BbkVZfM2vzE7llGugg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=TeR9+413vdxLQ9dhGOPdaecB19AsTXXk3tB281GD8KcSgH/AloK+o3rXjC0RDrsba1DDfcjfK+hauTp6Ow2vYOXOgR+fiTq6PuMikLHkPOQOv1bTCQR0CxvwP/MrSpvU9jxfIRqt83MERvApLc4iakZVAPz0FsE1vLyt16wJ2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A//8Z4hv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A//8Z4hv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso13947175e9.3
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460457; x=1745065257; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Sy4Ddd+FQkwANT/sTwpIZiUSSES38kAezkndsJMIcI=;
        b=A//8Z4hvMZjzOPUzYEHBSlWCFlEi78ulAN/jOVhRzTC5ZS5Mnh+U1R+JbIA/NkOwkp
         QlmQtPLXxo7Bn0MDIHGhF4N4PqtdQBMIWvdksHxZaUe/XnjrTFkp7S8yDiv0Thi9uuOo
         bhizF1gNuhWjZl5CjrDC5BeVcFc+UOA6aqwOqcpeBC1Do9KsIsiuVX8IWcO2MW7jVUd0
         tpMsIpAr9afkOn9N9ym6tK5MHarnCHJn6RuHi3lQtazz8KGw6cA8sZfTKBRjTV1I8KUm
         93Se+vb9KUMYhNH5MbicZXeEjD0bfpF5GuJnALMJVybwohf13JExigd2CISTygTBB5MO
         BAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460457; x=1745065257;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Sy4Ddd+FQkwANT/sTwpIZiUSSES38kAezkndsJMIcI=;
        b=sp+OTWZVLLhkn4GMgx+awk6b+ZfngwexaY4eR8GPgUayyUe3zqkQcF8fwViQ9JMrJJ
         VvKdC0CaOATaSjiBYbpwLxvI8L9V0njrL4IdiJ813odk2x3w+g2bXYakxyJfjkZegygp
         gi7BfP9zzWixRvaNeUP2y7tRa+t1o3ulHkqD7kVdGPFGoBw0z9sQXcdov1mQucqlv/lg
         pqe+fSxnsBis4UXwNecn9R6y8N4LQGSqJUlx3HUr353vDtCNYl0DneXeFCizn8K8OhOw
         v8S+JkD9RoE9hW6ysSO2Fe9+VJHRZhx1Y9DUb/u8xbwtNRD4FtvEG7A9vbmh76yT+ejP
         ApcQ==
X-Gm-Message-State: AOJu0YxSxKeKpgFOM8mQINxFv5ezRiWL/JdDbt20qFY0yIKRluBzaRj6
	Ch3HALyAHaoyCxpBCJ9+q9K1NSbrZ6rylKU2QmywD/+4twOGoSM5+cDO7A==
X-Gm-Gg: ASbGncs+pUtOqRt3Q1I/WRkGYN7Zlcdd3ywO2Zazfza0AQAS+fzJeRUq3vl5Arq8KJt
	YisaX3Gp+n0UMNOU43Lc3MGAio8xVZFU9Iy54JDyFntaoh92TI9x1c1/lnApKe2wWN9FvP0GIuI
	shLVmhc07Mc4hGbWOsz6toLPnLIlxNMdZeWBNE/rOxTT2X8tdYutM/rwq0Qfjd3NgCA3b0ovY9e
	hM++FL5puKtLxKcwd1ti3bZkmrglT/0N8301ztj3yqHjDTg4YksV1Vfp05fou4IZHtWzx7aH7wl
	r4KEiFU0XJ1ZRbLR8WtzyYCk6lWe3AQAIbOfxnKC2w==
X-Google-Smtp-Source: AGHT+IEjafNrFjrC+wYxmLciHyT9TWGLXc0Kbtijjdwl5WXMBVOZZz/NH5xc+JG+iUhNTctJ073jOA==
X-Received: by 2002:a05:600c:3b15:b0:43d:300f:fa3d with SMTP id 5b1f17b1804b1-43f3a9266e0mr41102465e9.5.1744460456652;
        Sat, 12 Apr 2025 05:20:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c70csm5000350f8f.38.2025.04.12.05.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:20:55 -0700 (PDT)
Message-Id: <2a129734e3d6c7714186f48f916a48dc7535f91b.1744460450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
	<pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 12:20:47 +0000
Subject: [PATCH v2 4/7] doc: move synopsis git-mv commands in the synopsis
 section
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
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

This also entails changing the help output for the command to match the new
synopsis.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-mv.adoc | 6 ++----
 builtin/mv.c              | 3 ++-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-mv.adoc b/Documentation/git-mv.adoc
index dc1bf615341..08d660643fc 100644
--- a/Documentation/git-mv.adoc
+++ b/Documentation/git-mv.adoc
@@ -9,15 +9,13 @@ git-mv - Move or rename a file, a directory, or a symlink
 SYNOPSIS
 --------
 [verse]
-'git mv' [<options>] <source>... <destination>
+'git mv' [-v] [-f] [-n] [-k] <source> <destination>
+'git mv' [-v] [-f] [-n] [-k] <source> ... <destination-directory>
 
 DESCRIPTION
 -----------
 Move or rename a file, directory, or symlink.
 
- git mv [-v] [-f] [-n] [-k] <source> <destination>
- git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>
-
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
 In the second form, the last argument has to be an existing
diff --git a/builtin/mv.c b/builtin/mv.c
index 55a7d471dca..9e36b616ab6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -28,7 +28,8 @@
 #include "entry.h"
 
 static const char * const builtin_mv_usage[] = {
-	N_("git mv [<options>] <source>... <destination>"),
+	N_("git mv [-v] [-f] [-n] [-k] <source> <destination>"),
+	N_("git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>"),
 	NULL
 };
 
-- 
gitgitgadget

