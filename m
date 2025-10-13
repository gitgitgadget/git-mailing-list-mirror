Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD162EBDE0
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345357; cv=none; b=q5YIZ6NjitEQSlSvYyXJU5vD1T/9qohEecyiG/XAenP/ew5FId8exi/rXVnp8vIY9ay4NDGUyFV9sMcY3Dgy5GWWQ0GHpds8+V4aDkOrXvPAiDE2rXO5TMrmQK2KKyI9KGv6rXFzhKcoCf3oi4gb6swe0Nkd4+XQMMbe7ec+Zu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345357; c=relaxed/simple;
	bh=EPlpRLPAt0PvvIT0aymZIM6kjo+83U3hvwn0g3knPDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+YWA6rgVTopWufkIfXif7BXd0kQ59fbfG7F1/BXFHEmmnuy7lzuBTk88aREpQHFnXyTFdcndi7F3bm4eE9gZG8IB9noswDQRot4xGpBJYMdRZE8dsirrBumnu1NgylF3Fl5IQBoYKL4zGH9sfEBkp1knzDl0b6yPOw/P1lcwfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvnQT35Y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvnQT35Y"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4256866958bso2129407f8f.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345353; x=1760950153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a4kxchNGrv+P8Kz7zmEbRlyXMSQniu0HjghZJl8fuo=;
        b=SvnQT35Ye0TFuyJS0lHi3CgEOIMNWHR0ygTHS1XVzVBBqlzl0fcKB/Mbz1SJPJ/qzm
         GqWT+Yn0CEY4WlNjef0PQmePmsMyeq7u/1DYtULGjxYDMrnNlqi9I3L+4D5uU/yx+8Dz
         7KOPH8dm0xNBVSHtvZ09gGTt9nsL8fbuQqFmyeTFOmKTatcz2Oz5Q3FfX31psGsYvGxa
         nNJfaDRT/41JpoORUflBP2Owbsj372Qp2pNPc93DYzRP2yNAh/Ed0rUS6a77qxbJ7TwP
         CapftiHZe2OuuYq/m42edaYFPTI8ZmBnCAVjlaSknMQNyJ7gFKcwXTeCANrTROoBH8VB
         b7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345353; x=1760950153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7a4kxchNGrv+P8Kz7zmEbRlyXMSQniu0HjghZJl8fuo=;
        b=tOQtXATL1toQ/1v/tXr5oG66U4SqbRf12xK9hOVcpsWGzgkmx5zSc2SoDZaqEw1DpJ
         1G5//3RY23DfZznMJLLvR2EjBJfiLJ0+nT+QOEqFipAdC1cWWFo2EMArVixrkwmUQ5xf
         6ihQQvxY2igcsZ4+9XRU9OtOFaGgSutxpDVHLyWwPI2GI8SbF3EAclQYdzZshXQ/VjxE
         VBrEO5xJPH3xJOocB3glWHd51NCO0TsueRELPZE1P3LgGLyhrVTKKYRF6oicRlLZMJbS
         ySzG2ow60OmCQUKWPVou0lI3GK+g/3kOVKDjHcKJiEAmgWFvZ5GGkh8g3Zq8YzucZu2q
         HiNQ==
X-Gm-Message-State: AOJu0YzlKdwH1eqjOqy5YE6MR7PZkKeVWxbsizQ6X1Wf6dR2Dhhhc79i
	NpcLaAulE8WaUDUbDuYUIt9Bck6zKEGUOq/hlHuG9LSEnqpHoAric5sug3o9L1XM
X-Gm-Gg: ASbGncvFIeXpqSbKXG7T5RKZ8P59Y68mkLwmGVAX0nXttcIjqKXDiDNQpcf09g85OER
	Q/RVzs6nxW+wKMwUglQZUKb6QfjY9N5QhokfQ2f0x9AaADaUXuE9Xh7aV3D09+7eEAAWeEamQCw
	n6EHz7J/G6YEO1TtutXWPx/sqDk0u+IC7NsA17UJ+MWvY/LHHKFvVQm+jYNq0N1J+5UYTtOJMa/
	9JLWvro6121snpYrvftT8p/K2NXLyajHzXYSR1VIKl31z1xFaES2dEe4+Rqg2Pi17DTwVSsUOXc
	jw+EYFb7bboN0zkOom8DUu+t8O9NRhVF/sf/EHVJwXjflc7uC74t2qx/8EUGKOEH3OY3vDrWk1p
	RW8juJFY8f/H66YR6m6BMk/EIZDi51TXt+xFB/tIWhGu6XVYAYHyjlngmsyltsAxoWI15
X-Google-Smtp-Source: AGHT+IG6Q8WbK8eoXjq/SBVVlEjneBHdo4XfZ+l4T7zgy1D7gEq1PIPiewuadrso5V88T/om+jIApA==
X-Received: by 2002:a05:6000:40db:b0:426:d5a1:572 with SMTP id ffacd0b85a97d-426d5a1058bmr4482038f8f.43.1760345353085;
        Mon, 13 Oct 2025 01:49:13 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426d0d9050bsm15630220f8f.13.2025.10.13.01.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:49:12 -0700 (PDT)
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
Subject: [PATCH v3 2/5] lib-gpg: allow tests with GPGSM or GPGSSH prereq first
Date: Mon, 13 Oct 2025 10:48:54 +0200
Message-ID: <20251013084857.1646783-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251013084857.1646783-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com>
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

