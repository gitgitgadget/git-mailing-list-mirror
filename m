Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D7288C08
	for <git@vger.kernel.org>; Sun, 13 Jul 2025 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428938; cv=none; b=eQsWlSoLeyl4EkK6fI0/DyOgBAT6Nc4rjJECN8ZQOwL/CdEahhLHh2BFADR9B6Y+UMqftj7yEVws3AOr2EjMqYAvVv4rz1Y9lR3UZclOMM0NVmHJa5u9yTCXlGameVlQhoBVTWymfIOcdPhlgRBeyC9KLz67SSAKSZzRHO/VYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428938; c=relaxed/simple;
	bh=pcj+JwUDkZmfK/8jpvBKcqeAatM162eKu0oymyVz9T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOGgzo6+hTqJlsC+YqcACxkXVuE07aILsQvXHhSmflqpiDo0FF/PSaBJD1C7GUj7SfNOe2+KiyMBOnhM0gKLY3sU5048+sHEpLMlZfhdu4jdie4ezuk/dRKTQXT1SoM5eQF/+xVadFDl2K3SXpsoQuDnxY/VCqssGTtVnfnEDxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5mnE5Fq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5mnE5Fq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso2913998a91.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2025 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752428936; x=1753033736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DItmQFVrTCXuLI8s7IfP0BLq+5d/nxgHPhtWA9D1LRU=;
        b=V5mnE5FqD62wd5p9vPwWottqZZsaxRATv7VBtdQ468/hbA2EBfOK0StXcXaV+oj6hu
         K+qie7SSp1wvmVX3CETbzJsDK1Y46ARqwzXOSC5g4PNwUZvRJe3/0O9b4LGPucPJI3sF
         x6ha9zZ/OGZdoi5Q0iNxJ7PFcEo3KMZ1Zu3G1ZQmcP41mr2VAxuADtG8X+uW6ovOtzb2
         oYju00gif3ctsb4euAW1L816lKp9938VIbqurOnYHKSYajPbvSDpoinsAmc64rEVYND5
         J9RBO8ylAnAn1G+A4pTa/MimLl5lgtMkOV3LajtZPEyVCzzZCCmbB+4KGGZhCe1QByg9
         T2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752428936; x=1753033736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DItmQFVrTCXuLI8s7IfP0BLq+5d/nxgHPhtWA9D1LRU=;
        b=VdYPksHM01SaKJaWmAfGNZ8Eut90rhlze6/qCj+KdmgrkSMid5SVAws05pw7usLW+v
         VwSBlloFNAWs7bAJIna1Vlvei3eGXV29Wc066OqN6Z+PlScHnzxsow32eOmzTR+7oKjs
         EVtw+imBcF2+Jwbp+LP51UpniFYTDuzOe2HzN1PXnyMTMJlNy1uaIaei6VSYJXqppKSM
         mQtnD6T1Qxf7drXhKerspokB9gbfSOL/B9LUI68gg5Q5YJmi6SBbkEP6ndc/+lBHyCuw
         EbLyFi33KXMbFq9tccvs95hEHJosfguv41N/Tif8kUJxSQBaAObxR27p9XkwlQ3V0IUQ
         9MvA==
X-Gm-Message-State: AOJu0YwiCTiABB5kdhzZWrtT/F590kYEy3ezrwRiJ0uiEbA8K6NRhnJm
	m06bz00I8bcTk+7b5ez/hW9xgghz2CUN72dH8fpuxJ3n7TmH57G/EeKgw7Yp6g==
X-Gm-Gg: ASbGncvC64uMS8JEuLFLxJoMSAO8Tt+SWHPzEgswHG1o3QkLV4xumlngxTD2gCbxsMy
	O/QbaZ8th9zsgmeK6H84FjydkX7t3i1JPqWa/DskVxGMT/d2TOysbPK7XJlhwvZu3bGyyC+lYjL
	bptXm4wZWFvjwc54gMOlCSIWDsDnq5hy6sLw9q5VxLC72Yj1ZBErpgZepKutv5ePHTtoVb72YAm
	kqSLjrPaP+ucgn3JYmLC2VRdmBexCcZK9yuro1DUxeYb9GG5fYji5WCxf5N6K1cD3VHbR6nA5uV
	t2Kxq2WHLT6q6mgT/KOPmo/8UB5lJJpoxrHYVUNHkPnaCMMl8KEjvQYWs6gyIWyd82AUD6GvqoO
	SU8IESkBOZrxNNwgZlHHja44yH2fn+ootgSLqFtljEbm3vVj/gtOyHToTi/cK2Im/35E+tHzf
X-Google-Smtp-Source: AGHT+IGERxYIkP7Hk2Oawe9o77hiE0dB2GMM3n6FXSb5EMGUBpFpJgKwrLcS7ZheQwFm5Gd7hx504Q==
X-Received: by 2002:a17:90b:3844:b0:311:df4b:4b93 with SMTP id 98e67ed59e1d1-31c4cc9c984mr16015102a91.7.1752428935876;
        Sun, 13 Jul 2025 10:48:55 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c301a95ffsm11617280a91.40.2025.07.13.10.48.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Jul 2025 10:48:55 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	carenas@gmail.com,
	sandals@crustytoothpaste.net
Subject: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
Date: Sun, 13 Jul 2025 10:48:07 -0700
Message-Id: <20250713174807.32444-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250713122341.17976-1-carenas@gmail.com>
References: <20250713122341.17976-1-carenas@gmail.com>
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
been instructed to use its subproject as a suitable dependency
by `--force-fallback-for=pcre2`.

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
index e7f768df24..f63ff32556 100644
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
+  description: 'A working PCRE2 library is available or will be provided by a subproject.')
 
 # gitweb configuration.
 option('gitweb_config', type: 'string', value: 'gitweb_config.perl')
-- 
2.39.5 (Apple Git-154)

