Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72B29CE1
	for <git@vger.kernel.org>; Sun, 13 Jul 2025 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752409444; cv=none; b=tKpGOhkrxAP/CIIVkLt0qyIaCsuoBsOBMDzW2OGrRztRYJ5vjD7QMOHB22x6bV71fHi9GyFgTKzrbufmIKwP6t4oMhFDi8RtwdRraJJBaowUn9IABvLAyKHPRpeC/kgv8jg5/QxhDoAvHlvgjEVY7BSDN2kT9g4YkEjC3rzPT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752409444; c=relaxed/simple;
	bh=EaAZXYnydbvEOL9uJWld6VvI8HvDi3KCedUzci+QqA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2vpHEFRy/GdlO3cY7hK+PJuyCg+I4WjLOh8cr3d481OW1gDSNLlUY1995gqtxTAEmOfGjfqdPE6U0bvjJ30/JKARtftC77ccLA5w3u38K97omj9IRFmoE7gD6G5FSChIMAB+od/+nxqelCRHqngUB89GjtDWfH/PLjETn+6OVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJgHifYL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJgHifYL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235d6de331fso38380915ad.3
        for <git@vger.kernel.org>; Sun, 13 Jul 2025 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752409441; x=1753014241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng/AJq5Pjlh5zOmhF3sHyXVtGCxqFGLPOnGwc2dVHas=;
        b=kJgHifYL+eFo1Z8Ftmb10ifhn6gOEvOydWLTzSfI1WpB9Qlq/61b+wDWHSgrHimY9S
         ycMTd6wd4+vfOGLWmryfOvAFqyFrA1+7ktVd9K2vwrIGkc36s4Mn85ZQMTEYma9PmbFo
         JoQZnfqjkxfr7c1s6YmG3o1t00blzd0L1d47uwHwDKB2Gz03y3F+h96KmsTX9FGLJAWJ
         YDlaLpBIdqbTz762qseZAa09WYiwtOZvRup2rFjEukBydRUgua9wsqzs6a0HhAqcRBTO
         G0+H0Y04naRKPDnt0XopKtDAdh9YCTuS6sHj92QhrPZZtxlrlvJTnjEr6AOuzkTyRDQZ
         p24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752409442; x=1753014242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ng/AJq5Pjlh5zOmhF3sHyXVtGCxqFGLPOnGwc2dVHas=;
        b=nwrpMus4utCZ6B1MTvAkA8j7gYXTdwqmRFbbj2uzeE0cxjFQEXlD06aBXVBJV+p/e3
         TXrH4ELBz3zVIDzd0DjIB958wsaLDQVnS39arC/5QDZE9tTP1gL0dX4kGeTRd3Uj74eB
         pI0YFVPyM6PIMlLAG6R7RVLZAf/chl/oCXcT+bTAGKhFkR504SoA1Wr2iqO5gaIPtnjz
         /mFwH6rEv7PrYmLNQ0NicyJjsFCXtjnQV71MkXWsBGbs/hfMFLWResy4rYKx322gbipd
         +BgwGmQrLpq1pZSAJgWPt8K9obOh4oDmoKPDT9WRvSu0nw4Wbz5sLZB09rc8DCTBqfR9
         MOzA==
X-Gm-Message-State: AOJu0YzVxDs0jw7We0HHxSqDSGOjuDGg2VU2XUtL5OfOKLNBWJRxWdGU
	v3ErpoyzhqbVtGwRXlxsDJ88JEnf4KLY5X4hSqoKavE/mFrfV0+Fm4vA7jO7Mg==
X-Gm-Gg: ASbGnctkalGuqesJHdUyR3nGOdjhOlZ6r66VqTRbgWDMqkNcWaoGX6/mqB0OUvksy5t
	MsfUL9vpm5L42coZvOY763oel+joIrDT1Re2D+wozM/cnkvR3GJwvuroEfIVmukSRgM5kq6BpKJ
	gR2IKrf0bIc/T0I1YVeNCQ47MjU1F5QIlCHN5mI3qRM2QpNKUIp7r0OLzlETaJKgGQOLkLIbe6P
	Zu5bjnAUu1GIYMiEki1T0cKUpc37aFhMx50prYvNTRNpMhoYiBrqVPvXNbPtIfSe/TJltaa0+oA
	lskA12opU6T6QRT3x57/h4nymLw0UL6dhVaRxsf2SOBkcSuxJiOeumA8AtupQ+r3IPVgdqMokm8
	PsqNal0DRZeGvCbsNYrE2ESuOxAznwNvR8LwPImxvzquejGAq+kMhYPdmQ6JB/DBDBO0qmg4zWO
	9gJkVswRQ=
X-Google-Smtp-Source: AGHT+IGWRiIy2Pfzea2XgOkxOUMDa0uA0TccreIeAGRNLkY/Vp/0ts/7fsgp4WdIh//zt4ufM6YbPw==
X-Received: by 2002:a17:903:3e2f:b0:235:ecf2:393 with SMTP id d9443c01a7336-23dedea49e4mr121877195ad.53.1752409441402;
        Sun, 13 Jul 2025 05:24:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de436e8ccsm74974805ad.254.2025.07.13.05.24.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Jul 2025 05:24:00 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v2] meson: disable PCRE2 dependency by default in macOS
Date: Sun, 13 Jul 2025 05:23:41 -0700
Message-Id: <20250713122341.17976-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250712172615.11364-1-carenas@gmail.com>
References: <20250712172615.11364-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Makefile requires the user to provide the USE_LIBPCRE2 flag to
enable this dependency, but meson has it enabled by default,
which can be problematic, at least in macOS.

macOS provides a PCRE2 library in base that is not usable and not
configured properly, as it installs a pkgconf module that
points to a non existent pcre2.h header in /usr/local/include.

Add an option that will need to be turned to true once an
alternative PCRE2 library is installed (which hopefully provides
its own pkgconf module earlier in PKG_CONFIG_PATH) or meson has
been instructed to use the wrap by `--force-fallback-for=pcre2`

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 meson.build       | 3 ++-
 meson_options.txt | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 7fea4a34d6..e1475be6c8 100644
--- a/meson.build
+++ b/meson.build
@@ -1055,7 +1055,8 @@ else
   build_options_config.set('NO_ICONV', '1')
 endif
 
-pcre2 = dependency('libpcre2-8', required: get_option('pcre2'), default_options: ['default_library=static', 'test=false'])
+pcre2_feature = get_option('pcre2').disable_auto_if(host_machine.system() == 'darwin' and not get_option('macos_workaround_system_pcre2'))
+pcre2 = dependency('libpcre2-8', required: pcre2_feature, default_options: ['default_library=static', 'test=false'])
 if pcre2.found()
   libgit_dependencies += pcre2
   libgit_c_args += '-DUSE_LIBPCRE2'
diff --git a/meson_options.txt b/meson_options.txt
index e7f768df24..9c0cb6bbfa 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
   description: 'Build Git web interface. Requires Perl.')
 option('iconv', type: 'feature', value: 'auto',
   description: 'Support reencoding strings with different encodings.')
-option('pcre2', type: 'feature', value: 'enabled',
+option('pcre2', type: 'feature', value: 'auto',
   description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
 option('perl', type: 'feature', value: 'auto',
   description: 'Build tools written in Perl.')
@@ -73,6 +73,8 @@ option('breaking_changes', type: 'boolean', value: false,
   description: 'Enable upcoming breaking changes.')
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,
   description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
+option('macos_workaround_system_pcre2', type: 'boolean', value: false,
+  description: 'A working PCRE2 was provided or the fallback to the wrap is being forced.')
 
 # gitweb configuration.
 option('gitweb_config', type: 'string', value: 'gitweb_config.perl')
-- 
2.39.5 (Apple Git-154)

