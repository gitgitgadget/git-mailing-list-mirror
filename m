Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08D1804A
	for <git@vger.kernel.org>; Sat, 24 May 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748071879; cv=none; b=u0G8QwZeo0tI0myeH+0l+iprYF7AoaVxTxp6i71eidn/McubcnuWjLDftNLxqPif1CmwkQWrNoIlKDoTmPXWxg86TOzb8gijR1it2wzzMHtXHGSKp3xPURxm4pKIOJCkXu+ekClNSXjaVYkElGLctgSvZiZyKxV9xvAP7Vjem4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748071879; c=relaxed/simple;
	bh=RnMtofZIDZoynma4W2Tbjm57G3TyxGQTzi+woKaN9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fq2DlaNDsjvXsaDnko2HNxOwsEvCx5GiNVxhdY/CHgZsWi3uY3C1/qyB86hTTUyVpBWiOaVd9XmZ/Q8ovp/kyKO+X8Dw68WqDTgOLgPlfFjOU/EiNegtCZN+mGmmg8zAkaJJcAZLQ4lPYkCXHFcrSoXv9uXdCeXBauYg6yen8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCw059JY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCw059JY"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26ef4791a5so617338a12.1
        for <git@vger.kernel.org>; Sat, 24 May 2025 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748071877; x=1748676677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlxFCBHmLAumexA6WqI+UOdqF7l8xmVTfgHhScFXVaM=;
        b=fCw059JYAiOH6ELhf5buaCgdmTsT7TnCn+vvCaoJAqBKWcWVOlzvuycrs5o20E7RY7
         8mp1rrXndDdJvKmf4DNimorP9HBBtuRfWP1RsaRch3df3BEbZWke5D+7EMzAUkz5BRwa
         sFG3Cq/Y7GFJZ2Zv9MheRnoeCqgEjkkhWcBhKJxL3fIPypSSp+6cCYZI/XrDhYNSnHK3
         Gr7jreHOsbcWm0Wal8bDXv1CppIDZ+Rri8vdlAlBjh/0rL8udD/H01qOW64KvdD7Dhy/
         H3L7lCW4OhrhTNUZcyFlLfqXQM/Y81QclozVpIf4LojQ9MGScN+FuIyYIKLIPEqdJrpP
         /v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748071877; x=1748676677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlxFCBHmLAumexA6WqI+UOdqF7l8xmVTfgHhScFXVaM=;
        b=dm02LRMjc4mXF2CWzjZIQ7YBNK66xt6x8j3iaGsl1zHrRjvpvC3VPJVjoT/Wga72fK
         r6rLWid5Bnj3E1lmGd/u5aHNk47FcAAjZbV3YPKIUKHRirfc2++UYtRhr/Dy/Q+jF8i6
         IUTIs5BnJkGopVwDHvS9pClReoP3PF9L4OZvObAba/UUhZ0rdgo7qpZEz66DdKQYhz08
         lyQkViwRnePeMVftwtF+dHME7p7XMI/prP88IPB8u+oaJ7KMYVfoao3lcCwTT7U6Ws4p
         MgvTyY2Szp2WtcteHJCRmJhVxg0c56WL19Q/AL1xgNFL7+PEzs3sZg+/RG8DuqURiFcV
         zgyA==
X-Gm-Message-State: AOJu0Yz2LmBEgK7MU6zWDHcfD7XVyUMFw3K6+cEXD8qEa2etrqW6GSR2
	RxBWjOeUMbSGEoufnLV437XkOsQavxnyGdG7QSLE42rjmHHcrecjHsgL
X-Gm-Gg: ASbGncu4fs0V+afeEk5mpEUh6HD/2igIt70SLmVEJmzLPMY4Lm6X55Ty0Ops97Ls03s
	Ik4fd0LjPAwDjJJFKKLkOlVscLR/qmxcFf/OkR0+UBYUjeC29zQW9Q9c4VmFzmjWL08y+CbZfR2
	pM10AJINyb+eh7/6fobiGwOY8ox3Bz9en5zQE10rx/dLOS8YFATDeAzRCegpshBltINxMbnYhA5
	M/RClEwS1z0HLnezDSywIf5PMl8xkGweTe3g3cogHlX3Vyf37EeitYXvjFB+yareNrsR68FpvQr
	+G9eceKZ5jH4jnyGMbsX2HqWR1XqpCqHJssXrKZ/7mDQCh/+K07K+5lPmPa0fSYtUTc=
X-Google-Smtp-Source: AGHT+IFLF+hjfzdQUOT5NJVSETUk8a3koyUZ65gNyu8u8bvPi18IcwdB5SZrYcvJ6koG32c2CRdK+A==
X-Received: by 2002:a17:902:da47:b0:22e:4cae:5958 with SMTP id d9443c01a7336-23414f9ee78mr32213705ad.18.1748071877374;
        Sat, 24 May 2025 00:31:17 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23414e86538sm8737935ad.184.2025.05.24.00.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 00:31:17 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	mlell08@gmail.com
Subject: [PATCH v7 1/2] The seventeenth batch
Date: Sat, 24 May 2025 13:00:54 +0530
Message-ID: <20250524073055.58092-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250524073055.58092-1-jayatheerthkulkarni2005@gmail.com>
References: <CA+rGoLdbZvD_aMfB=J_cJay-4Ptgf+=R3es9vmdrsHkGhCtPmw@mail.gmail.com>
 <20250524073055.58092-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.50.0.adoc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/RelNotes/2.50.0.adoc b/Documentation/RelNotes/2.50.0.adoc
index bf73de114e..f721ea350d 100644
--- a/Documentation/RelNotes/2.50.0.adoc
+++ b/Documentation/RelNotes/2.50.0.adoc
@@ -72,6 +72,10 @@ UI, Workflows & Features
  * The `send-email` documentation has been updated with OAuth2.0
    related examples.
 
+ * Two of the "scalar" subcommands that add a repository that hasn't
+   been under "scalar"'s control are taught an option not to enable the
+   scheduled maintenance on it.
+
 
 Performance, Internal Implementation, Development Support etc.
 --------------------------------------------------------------
@@ -157,6 +161,12 @@ Performance, Internal Implementation, Development Support etc.
 
  * Build performance fix.
 
+ * Teach "git send-email" to also consult `hostname -f` for mail
+   domain to compute the identity given to SMTP servers.
+
+ * The dependency on the_repository variable has been reduced from the
+   code paths in "git replay".
+
 
 Fixes since v2.49
 -----------------
@@ -306,6 +316,15 @@ Fixes since v2.49
  * Use-after-free fix in the sequencer.
    (merge 5dbaec628d pw/sequencer-reflog-use-after-free later to maint).
 
+ * win+Meson CI pipeline, unlike other pipelines for Windows,
+   used to build artifacts in develper mode, which has been changed to
+   build them in release mode for consistency.
+   (merge 184abdcf05 js/ci-build-win-in-release-mode later to maint).
+
+ * CI settings at GitLab has been updated to run MSVC based Meson job
+   automatically (as opposed to be done only upon manual request).
+   (merge 6389579b2f ps/ci-gitlab-enable-msvc-meson-job later to maint).
+
  * Other code cleanup, docfix, build fix, etc.
    (merge 227c4f33a0 ja/doc-block-delimiter-markup-fix later to maint).
    (merge 2bfd3b3685 ab/decorate-code-cleanup later to maint).
-- 
2.49.GIT

