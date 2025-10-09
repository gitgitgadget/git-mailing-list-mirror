Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59425A659
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012719; cv=none; b=N5fed3aV9AVTnI/JmLWpRV4yzaeCkS5JG2kljiv/1iBlWFGNl8CpiWSjBtlLsnWmqvQCyn7XNLBhCHrxTsq6rcdAlugOO4ROAFF9R4X+luhJPvcfpxQZ2o0myXYIT+LsJJXqHsPafW5xhbUuOfvyjr1reKJR1BUslITP1A3/ajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012719; c=relaxed/simple;
	bh=EPlpRLPAt0PvvIT0aymZIM6kjo+83U3hvwn0g3knPDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmc3ji7K7msW8DzKUc40sy754VE4bxKUqMJgqUsFI7SS7ZdDw1+rDPXWdUXJvk6ZDZrtHtOQQgbqSGSCraDHi8KFsT+p6YndhC5ASe0agIWLzwyMn/b9M+9GJ9qAWI8l8YR/TDa0z7ZWtb/PJrOR4m924Egk3SBXq5fJgAZ+4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkL7+Ts0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkL7+Ts0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e430494ccso5444215e9.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012714; x=1760617514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a4kxchNGrv+P8Kz7zmEbRlyXMSQniu0HjghZJl8fuo=;
        b=RkL7+Ts0HC/j6Gq6/AgRJ0DuMKS/fz9Lwj/G3piS2wgk6tF8aUHS+y+n69naAUnN8V
         +LZQrESoQU3gT9OhNP/j5QrAeKf8QxUA2YwOUjWGd5vu/BRfu3NXBhLPdTxirQ6hpWFv
         Ehwgacq1y/xvBqG03cKNMKxsg4QTJe3p4Ds5uJ5sv1cspJYJmtfQp3IOtHjJcERaVe4j
         wcrQ4gVvPOxMqkfSQaO67xuFiQuHVEZ0KkawZk2L1NrynwjST7ZlyyF8iGlZHt684igT
         /9HazAltaKfllTehHdfYxYhfzaPj192DQ9AC1pUot/B8oiMjMd6GSRTsZTJ1BEpuODJT
         dShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012714; x=1760617514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7a4kxchNGrv+P8Kz7zmEbRlyXMSQniu0HjghZJl8fuo=;
        b=q3lwxsz7+SjLoP5GdOS12EZA4UKgX/8hinzSEdmpYQVo1GfLjhFcUlqyIhHhkmg/Gc
         liY0gskOgTxHgRZjOVMYDE7zh/vNi5yn6NvaHr+ZOgURgfvBYzASWeu/bPsLLs+sTk8N
         13RczqMZKAYGJ6xAmLdCvUvAZR5w0dUA528VQbYzX4q9QrzA8LgRB/b5R6RSncvT8CbY
         8K0QW9ZBg4Te7Tndby+TozTCqOMSqZEakGZ2TGWJSQskiB4G8D9j7wWu+SO95ruJa/KM
         zPCPkschp2LQbxX/kV50+ow8cRib8loNhKJ+7igJlRTB5h7ztLq9iUwhKm0rx2lXalN9
         bS7Q==
X-Gm-Message-State: AOJu0YyGSA5+va9E/uSaEC2hkCJQZNThr75OT7mJVP9x0vMQA8cTSLHw
	z+XPebpQ1RKWpFpOfTWGb4hqiDMIbNYAzkV2xMATZ3Fp6EFOvRaIeXfUeEM/xsfS
X-Gm-Gg: ASbGncvf5vFo9HwHJ05lfPr8veZiZxQ8gxdx+dHSMVMWUPixvvtBCcI/8z4zwjZ7cWt
	Oh6RQ0Ng6Te7x7g+dR9eVWJs6vrW+bW+tBhwZ3Dxs08oqRSBdTywWZDbwgEeiNFvGIrzI7LRMMX
	yza+XAN2LgOwWml8EyB9wF5bAnOc+ggI+zmNPYDiH3FUaTPem4UkYxSxgXhkA93aZFWUtTOnC+8
	6iv73XA3O3D9MF2FJB2IWyZ4qqD+CUONHZFDgPnJ51CO4BotS4GuMX4U8Rbt4zPaUh2FkBHuk/C
	aYD3/VHsPLXK08MdYw0Jk3LULaHw2L4YlsR7YmMh8Ow5vPempEA41d5PYzDqz8DacFPsKaFggvY
	fddjmxDzADOyALOc6eID3utUac6sFlxEz1xofih0TAF6EOjzBZk/8NjMxWcAZd1GC/sGIGsdkCg
	==
X-Google-Smtp-Source: AGHT+IG8m6DODyQ3PIP4v7eaV+N1ONbfLDNqNhKseEDKiLffIRA4tkDD2i0B7zS0zQ/52g06m0tJ+g==
X-Received: by 2002:a05:600c:3b29:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-46fa9aa1d79mr58002075e9.15.1760012714265;
        Thu, 09 Oct 2025 05:25:14 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07cbasm84831475e9.7.2025.10.09.05.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:25:13 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Todd Zullinger <tmz@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/5] lib-gpg: allow tests with GPGSM or GPGSSH prereq first
Date: Thu,  9 Oct 2025 14:24:54 +0200
Message-ID: <20251009122457.1273701-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251009122457.1273701-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251009122457.1273701-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the 'GPG' prereq is lazily tested, `mkdir "$GNUPGHOME"` could
fail if the "$GNUPGHOME" directory already exists. This can happen if
the 'GPGSM' or the 'GPGSSH' prereq has been lazily tested before as they
already create "$GNUPGHOME".

To allow the GPGSM or the GPGSSH prereq to appear before the GPG prereq
in some test scripts, let's refactor the creation and setup of the
"$GNUPGHOME"` directory in a new prepare_gnupghome() function that uses
`mkdir -p "$GNUPGHOME"`.

This will be useful in a following commit.

Unfortunately the new prepare_gnupghome() function cannot be used when
lazily testing the GPG2 prereq, because that would expose existing,
hidden bugs in "t1016-compatObjectFormat.sh", so let's just document
that with a NEEDSWORK comment.

Helped-by: Todd Zullinger <tmz@pobox.com>
Helped-by: Collin Funk <collin.funk1@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-gpg.sh | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 937b876bd0..b99ae39a06 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -9,6 +9,16 @@
 GNUPGHOME="$(pwd)/gpghome"
 export GNUPGHOME
 
+# All the "test_lazy_prereq GPG*" below should use
+# `prepare_gnupghome()` either directly or through a call to
+# `test_have_prereq GPG*`. That's because `gpg` and `gpgsm`
+# only create the directory specified using "$GNUPGHOME" or
+# `--homedir` if it's the default (usually "~/.gnupg").
+prepare_gnupghome() {
+	mkdir -p "$GNUPGHOME" &&
+	chmod 0700 "$GNUPGHOME"
+}
+
 test_lazy_prereq GPG '
 	gpg_version=$(gpg --version 2>&1)
 	test $? != 127 || exit 1
@@ -38,8 +48,7 @@ test_lazy_prereq GPG '
 		# To export ownertrust:
 		#	gpg --homedir /tmp/gpghome --export-ownertrust \
 		#		> lib-gpg/ownertrust
-		mkdir "$GNUPGHOME" &&
-		chmod 0700 "$GNUPGHOME" &&
+		prepare_gnupghome &&
 		(gpgconf --kill all || : ) &&
 		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
@@ -63,6 +72,14 @@ test_lazy_prereq GPG2 '
 		;;
 	*)
 		(gpgconf --kill all || : ) &&
+
+		# NEEDSWORK: prepare_gnupghome() should definitely be
+		# called here, but it looks like it exposes a
+		# pre-existing, hidden bug by allowing some tests in
+		# t1016-compatObjectFormat.sh to run instead of being
+		# skipped. See:
+		# https://lore.kernel.org/git/ZoV8b2RvYxLOotSJ@teonanacatl.net/
+
 		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
@@ -132,8 +149,7 @@ test_lazy_prereq GPGSSH '
 	test $? = 0 || exit 1;
 
 	# Setup some keys and an allowed signers file
-	mkdir -p "${GNUPGHOME}" &&
-	chmod 0700 "${GNUPGHOME}" &&
+	prepare_gnupghome &&
 	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
 	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMARY}" >/dev/null &&
 	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_SECONDARY}" >/dev/null &&
-- 
2.51.0.438.g6987fc0bae

