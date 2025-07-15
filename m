Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4034545
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579882; cv=none; b=cD2bPNfbQYiKMaPtHGennU5UG+jlYqIFC01o3/BEKE8CQYdl+RGF2HWbrbJTa3wTva0oW2oEBxg2Zkg89jOqhnoNw+NDjCpZ4kMT0v5uYu2KRqnFi1m1oeFwHJeBFgHx8sjHK7xA/x7N9eY2DzNeSJyWbSBdHC39vUjIBH94Pl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579882; c=relaxed/simple;
	bh=jpDpKoQRIOOLIb0LZhZi470uXd4V1x3btvJ9eN8prVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsvQDmJadmCqq4KgRQP/BgBMI5hZutBmwQV79gglcLfYq9cXUHQfl0l/Q9vPOQ02nSh4f90d3COtkmVKD3XaMl2rPSMgswPdgNjaOeWuo5WB28qvpLVSy5+pf3M32fEMFTjtOoZIL9v+eDby4p8gyUy9cSV3M/48jHq58rhke2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G62lMsnk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G62lMsnk"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2363616a1a6so45956465ad.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752579879; x=1753184679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGqGxkhm/xmshx0WTDK0vxciuGRNlj77LFG4pO34Gak=;
        b=G62lMsnk2vH+DbzTeD6SADMJKTqu592nEJfdNyg9crnZTr9NzrTEpLnEtiKDlwYi/5
         5iL50npgW3qPWKgbFg3sJfNjaDnkHvdXmtHYR7rlq7gmwU2vH7xI7qa//CNTjeVXVprK
         aue6dZEm+Gq7bObT0boAgmn7mj535ieHSQP0hxojSZMyDIc4grEQijiG0nPSOTRcnBXG
         qAqSDdfb0FQCtcX87o1MQBqB9NyDF5M5sq6iZk3TnZx1yZVHTpl2WHRznBStGEe+FAGy
         VvYrNu9pmKxo9uENdpEzOfVNIp5JEFQ5ciWQVRHU5UWd7oZKvy0azMxFfQGIcq8ZEhxr
         8Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752579879; x=1753184679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGqGxkhm/xmshx0WTDK0vxciuGRNlj77LFG4pO34Gak=;
        b=RiWpyAFo+l8hcxQHp1NYwv/g5nBNwUsmhPU+z8sqIn2map8wcfEzvDpo4fQZeaT0aZ
         zHn07XAatWrqeL7CiAVu8bSBOySfcmILAU7evWFJItyb+lq3uOWY8Vn6Md8Nn8ZxVwrC
         vysawFiuJEjpyVEbyDCYEOC9tqnmDdCmzVA4N6uqqHl1R6Xc3k0VYcKw2wJezz3HpIvZ
         u/6gKxnqiLdIsHHhXmrWesM7IWFoIgBZMc/fA0sz39BMkVU5VHjTqHrb0O7PsHQAoj74
         obHrLevzCyt0GvmbjciCWRhGTS4gvIXlrFPoGWsAVrN/Z5vr6PmrbBGIhNFWANowc6V7
         XxIQ==
X-Gm-Message-State: AOJu0YwJXfI5Og7RaA+4AQA0SyGjIbvCPpzTFCDWvylVLYJbac9EqL6v
	3gJrCl5f5YD7dxxA6PttcFm8/KAz0DaIbBWd+44F/bUaxVfbwBSwi/rhCslupA==
X-Gm-Gg: ASbGncshr8fXUtFKJj4vfJlYFzkj2cJL0VjS6CoSiMQG+E5b1v5eJxIiwpYewEFKvvW
	DFiA/sAZNVYnqhwxApm72uhZpISrYZlTGyAN/ou0lZeqbCkn1hphxnva2W3fvJYIjv9HPrWVLrk
	5kFc5zzVdLcRRBSbpSG4eYr2UEjzAj0mUmokb4hiq9iSETuRjd3s5h8MoD5Xue3tPIKg6HDmJhe
	vbC/UBJMdOi5cKQirejmNpMbN/l1K/zJVtl38/jDErRuO91cMWKOOAT78WIaqNrUMLgf161slkg
	o5nwK32q9zS2QRQXqa3k98DCWgFxJ62oL4Q6O50yICQTnLqCuOJDJRGTmkl8mH+gSgheZaO6qlg
	md9vADgXU/7wexAakhPaOzlCqTU9tmjAVRoLHLTihZxDpPbRpSJNOYuXnyUArbR934iidHCM3rJ
	KdyTyXsb4=
X-Google-Smtp-Source: AGHT+IFIKUv3nS+KcDyD/gBapbs8PbyF3IJ0BaixKnN1CYponAR3mOU+zQ/VDP3dGgZ++GZc86X4AA==
X-Received: by 2002:a17:902:e78c:b0:23d:deca:6eb5 with SMTP id d9443c01a7336-23dee27d5bcmr251662685ad.28.1752579879406;
        Tue, 15 Jul 2025 04:44:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4333d6asm107396215ad.154.2025.07.15.04.44.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Jul 2025 04:44:39 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sandals@crustytoothpaste.net,
	ps@pks.im,
	eschwartz@gentoo.org,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v4] meson: woraround broken system PCRE2 dependency in macOS
Date: Tue, 15 Jul 2025 04:44:07 -0700
Message-Id: <20250715114407.37955-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250713174807.32444-1-carenas@gmail.com>
References: <20250713174807.32444-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

macOS provides a PCRE2 library in base that is not usable and not
configured properly, as it installs a pkgconf module that
points to a non existent pcre2.h header in /usr/local/include.

Detect that case and allow a fallback to a wrapped submodule
if the feature is enabled and that is possible, or print a
warning and disable the feature if the feature was set to "auto".
which is the new default.

Suggested-by: Eli Schwartz <eschwartz@gentoo.org>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 meson.build       | 20 +++++++++++++++++++-
 meson_options.txt |  2 +-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 596f5ac711..0e480e65cf 100644
--- a/meson.build
+++ b/meson.build
@@ -1055,7 +1055,25 @@ else
   build_options_config.set('NO_ICONV', '1')
 endif
 
-pcre2 = dependency('libpcre2-8', required: get_option('pcre2'), default_options: ['default_library=static', 'test=false'])
+pcre2_feature = get_option('pcre2')
+pcre2 = dependency('libpcre2-8', required: pcre2_feature, default_options: ['default_library=static', 'test=false'])
+if pcre2.found() and pcre2.type_name() != 'internal' and host_machine.system() == 'darwin'
+  # macOS installs a broken system package, double check
+  if not compiler.has_header('pcre2.h', dependencies: pcre2)
+    if pcre2_feature.enabled()
+      # Attempt to fallback
+      pcre2 = dependency('libpcre2-8', required: true, method: 'builtin', default_options: ['default_library=static', 'test=false'])
+      if not pcre2.found()
+        error('only a broken pcre2 install found and pcre2 is required')
+      endif
+    elif pcre2_feature.auto()
+      # Replace with not-found-dependency
+      pcre2 = dependency('', required: false)
+      warning('broken pcre2 install found, disabling pcre2 feature')
+    endif
+  endif
+endif
+
 if pcre2.found()
   libgit_dependencies += pcre2
   libgit_c_args += '-DUSE_LIBPCRE2'
diff --git a/meson_options.txt b/meson_options.txt
index e7f768df24..1668f260a1 100644
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
-- 
2.39.5 (Apple Git-154)

