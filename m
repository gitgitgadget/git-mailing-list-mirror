Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187861C461F
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898835; cv=none; b=OnZ2R5kHIXsfJKDwPvEW+CguXYiJPWFB9r6u+UbcCDKvTKxbAhmMRWbR7/i2rm0LboAO96PVnZ7yICW+I7RGW5X3eFGQn8ldQU80eEFZ99IpguVxhnXl/L+hJcHYR2dVV2xbtV26kbcPR0tLpfHAGFxkDaOUtwbnFjLNdbXH4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898835; c=relaxed/simple;
	bh=n/SgS0D1kkStv0/3Q0fUqEhxyEgITxIeMACvKczgwPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckJQkm2hwXQRIl/ZGrxaDO3b59SjMI2Xz3e4y0iPi+nM6D4hL0i2yd1Mbg8rmCt7RIQnRkv4jk5lK1Jg08uhllECFnwBUcOIE3T/8Suh/h04elI263iM4zbWoOJLIvAv3PS8/WHNvueCCf5vxRy2dp0Nu8mA4N3uH6Z0i2T+BWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmFymw7I; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmFymw7I"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0b85c5574so763702a12.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898832; x=1734503632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3OYHh8iTbnHQf0CS+eSVEVY5/X91gHZdPmDyMNtY70=;
        b=ZmFymw7IzMrZUTrZ6w+47fQwtUGepuz8gDbIJg2O4AsvLCjxwmdKs3NTwkC8hE0GLJ
         3sfGYTtSOy9rbWGyYiPch3z//GtbqnKLOueeMWQyMmEDIJEZpjC06p0fvi0DN4Y792+F
         cMmbaBBqsP1pN0kgC1Jq7GTAFjoUqDII7M35QN0u10ijsWtA/USshfmEkLc07SsYohzG
         lclS5xKAuGeUXid7VMXzcWcxwnnvtIlID563tC/nr6LY/bLo7iUdHzplAiK1xEFgosC5
         5BGxztqbicFGIfol/sBNImswBOiQWsQfEsKQa4sUVXa4ZWrCID2iPq0j/72mxqSTviVt
         Rliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898832; x=1734503632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3OYHh8iTbnHQf0CS+eSVEVY5/X91gHZdPmDyMNtY70=;
        b=RA+bAvTHyXzzXhnyF4w6Y5/BT1We42y48nJxXk/V9Q+mH2iT+fBu6rkW1y0JgoW7L7
         MhTgzURFg+pFya6s5Z6iugB8l/bJEuhHDJngIremFWMagudRIykWbu+4Q7yPdDlxpymv
         Tc1JVZX+S72n6d/AllztRvrDxQbwxWE0b1UBRYjpPcna7Soft6cmTOhHIylEq2egcxgl
         y3qsaF7GY7HC0/MR1EXAOPFUwvmmcTOm5cgk7hwJ8mGfjZDmCC8s1dnmLTgmsUjG/K67
         Sv4JmWS+LWH5iNYydzqDdcaXV+gYM7Pgi35xVfkDOBhwclcdqSgY+VOam+GNDRZTMgOU
         So+A==
X-Gm-Message-State: AOJu0Ywl7VlphL6q2qDNWBGZxMbNQd0s68xpoGxv22lW3ShHgJeaxhM7
	R3BcaNKy7pD+hxH9ltxZ8KqhGD2jV3zDXuTJ3uN+hBx+QcZ60QqlW9D+l2dr
X-Gm-Gg: ASbGncvmtiWeRsEUcIQGjjHscy44kYazWv+z1ybc8ZsEl7zipdlCgFfFjtViIBcw/iH
	fTUpKWCNHkh541jOnVzHi0H5vOpRNb4RoMQbwl2JT+AmZRjKPmzIHD4dmCS0/4yO8UddxsXTWw6
	SC4c+I8r09ONXy6a3CFizAT2GL6Fczy7s/TQNBFnQqO/I3gCMZqabhYZ5EEMmBUrhOfJ0gmsQub
	cnj0Hh7YBBb1TUuzLKNpWOLWKQW5ZlnIzPqDISLWH/AlfN0E+/wnf9Yxfi7uYU=
X-Google-Smtp-Source: AGHT+IF7cHnbrtjIZrZiPJcepXJjtpu4RqKnEXe3sgLVsgT3cXLGXSHPJrdUq8rNtgzT0rp875vwzg==
X-Received: by 2002:a05:6402:5193:b0:5d0:bf79:e925 with SMTP id 4fb4d7f45d1cf-5d43314d34cmr466092a12.6.1733898832110;
        Tue, 10 Dec 2024 22:33:52 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm6875803a12.6.2024.12.10.22.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:33:51 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v4 5/7] git-submodule.sh: add some comments
Date: Wed, 11 Dec 2024 08:32:32 +0200
Message-Id: <20241211063234.7610-6-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241211063234.7610-1-royeldar0@gmail.com>
References: <20241210184442.10723-1-royeldar0@gmail.com>
 <20241211063234.7610-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a couple of comments in a few functions where they were missing.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index ba3bef8821..ee86e4de46 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -418,6 +418,7 @@ cmd_set_branch() {
 	default=
 	branch=
 
+	# parse $args after "submodule ... set-branch".
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -466,6 +467,7 @@ cmd_set_branch() {
 # $@ = requested path, requested url
 #
 cmd_set_url() {
+	# parse $args after "submodule ... set-url".
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -604,6 +606,7 @@ cmd_status()
 #
 cmd_sync()
 {
+	# parse $args after "submodule ... sync".
 	while test $# -ne 0
 	do
 		case "$1" in
-- 
2.30.2

