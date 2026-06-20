Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01B2EF67A
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781971251; cv=none; b=qBs2k9RiWmu6V2C+V+DfcDdpNgoMLC6Ntzdt5WZwTP+sKMAO4Gqe0q20gXP7vTpINfGmQQg8x4Q6SsZMqbeEF8522FQMSkk2SclgMNCOlsLNHfcFzDFva0jkXg8nDEkDZufNoYtuccg+DNgTn/a5PweqtAnLMCkDY4lXf4qbHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781971251; c=relaxed/simple;
	bh=8SKpqy+fiX6c+O0v5Tj8S1TbXzV8gafMi19dljLBgdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTHRNHoW+8/mC5Yqmv0VY+ktbTnJ0xlW7ZoVHj+bQdLRoND/4XOXuG8MCR8B5YFu6pItxusmeLKnqSR5bcHgHG9piC1IWpWnBDdXRaY8UIUWtCfBJfCDtarR8IjG8bxluai+qL1/xi55gmJU8/WCWxCNhvvD958PhVydOUzXu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHXbabxW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHXbabxW"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7fd3801ca22so22638447b3.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781971248; x=1782576048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3AZv/j5eWBbPXZ1GWIxdD1Z0SBCOuv4dyMrHcyyimIA=;
        b=WHXbabxWaRtyevRqEURVUxL4K52ooBT15llQ2GE28AmIdEEVNxUmxDjB+y0B4xwtvF
         NlBhR+A7LGoG/N2Y90d4rqLaDAaJtYXjEMKrC7UYEd4Nid6UzG5Wue28SaCLlXBtWOSr
         jSzhPQF8YvqbyLrG4loBgDkV4nSdZOWB2RLcDAhFJS8Ek6aor1PUa1YrtGNIbkM21rov
         Jo6WwdhJbDAxr9tfBkUjgyFSuQnshYxXVUtGfb+kUM5lz77uvxJfidKxMkiLQ5jxbje7
         r8YOHAGuhnHcggUWQ4uVqYtQbX+xYqiwV8pd9Jx6lJ5YA6NU531pde0byXygNjIh8kvH
         IEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781971248; x=1782576048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AZv/j5eWBbPXZ1GWIxdD1Z0SBCOuv4dyMrHcyyimIA=;
        b=GDx8pfGHu3A2rCB58g4bOXUeSbv2lAMgp4KbigyeQoxWYFY7fuBuLwzy0NLnICcbF3
         OUqC98AFybcW4KECLQnhZk58CNB9dahojDi7P6zrWGHg4rNA+gN+0iWhakQvj1X38Pvc
         6B+ycJa3Rm/3DcDI6ga//4YxIw19fC9snsV5ytpIy6BXbBLhESHanFKNIMCU+V4KLLvG
         wii1+oVdSxCLanQGPaFs5QcOoAOdUtDXiUCS0fG6mXztUCUgk+H1s8AFbBr/Cq6mla25
         dT9rKf+vP2/dsk4Zr0gDAFVfJ5+ogqdK9nx6uKUbAubSwHcWWgpGc0rH9twDqN4AeYJG
         VDaQ==
X-Gm-Message-State: AOJu0YyI2Hy6h/UiKQH78GKxw2PLXBmw5blbcNjhzxb83nzpE3V7wzsu
	h8MIGzAEbD1yd/DNyWddNPJwAfs3QzNNH7CuByjzG/o7nXrSH6yQ4OIvJrYXBG6xxa4=
X-Gm-Gg: AfdE7cnMSnkn9Cf2nJUB2XKFHuAa0MYAPRdcSDR2eLcjdqo+xsfJqQ7VRAfGLcjVzrM
	LzOrZJWTs9ziWZPWwio4MF5wrGHDcYFfLvWc0ACDr6ZVMC/vPg5YnghXw/EHrKKa8P7jh0KXirP
	ykDH65VZN32VulD3dUWm6AjjfUQV3IEtuwgRQfQ+h6B5iGtx6Cle4Exk3/oJgf7kys9JcAXC5BP
	YNy7IrlCN7bl0GnMYeeIuZLvPyjMg/AFmLo+I9iHvIGsY7JA+WynGGkQGa/mCh57+ba/dYHY1//
	eN9Cn6Ssioo8w9n5RGM814oKyxqKITJJKn2iizESmRdbShJay1UABYby0odHbxli0Oe8fSzNSAN
	S0LlpbkHlsYacmztvdM9IsKKy0YOHgdgY+vB1Gj3H8Pm2D0F8sEmGd5654WlgtUYmKCIsm7E0KG
	PrzUrtTiglfoE3EGJg+54WVJVJpR9Sv2fj7MuF5kvrDqXGZ5TdGfYXoBJBMvQNv7ylNnX9fYZur
	1WFoXRv4dBxxutMDg==
X-Received: by 2002:a05:690c:6e89:b0:7bf:107b:f85b with SMTP id 00721157ae682-802645c9870mr40107987b3.13.1781971247839;
        Sat, 20 Jun 2026 09:00:47 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90fb:c300::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf66f6dsm11588037b3.17.2026.06.20.09.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 09:00:47 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] meson: wire up USE_NSEC build knob
Date: Sat, 20 Jun 2026 12:00:24 -0400
Message-ID: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Autotools-style builds permit enabling USE_NSEC for cases where that's
desired; the equivalent knob is missing from meson-based builds.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 meson.build       | 4 ++++
 meson_options.txt | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index 3247697f74..85a11119c5 100644
--- a/meson.build
+++ b/meson.build
@@ -838,6 +838,10 @@ if help_format_opt != 'man'
     libgit_c_args += '-DDEFAULT_HELP_FORMAT="' + help_format_opt + '"'
 endif
 
+if get_option('nanosec')
+  libgit_c_args += '-DUSE_NSEC'
+endif
+
 libgit_include_directories = [ '.' ]
 libgit_dependencies = [ ]
 
diff --git a/meson_options.txt b/meson_options.txt
index d936ada098..1bc75278a8 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -21,6 +21,8 @@ option('runtime_prefix', type: 'boolean', value: false,
   description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
 option('sane_tool_path', type: 'array', value: [],
   description: 'An array of paths to pick up tools from in case the normal tools are broken or lacking.')
+option('nanosec', type: 'boolean', value: false,
+  description: 'Care about sub-second file mtimes and ctimes.')
 
 # Build information compiled into Git and other parts like documentation.
 option('build_date', type: 'string', value: '',

base-commit: 0c8ab3ebcc76981376809c8fe632d0fe18e93347
-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

