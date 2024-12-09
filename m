Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AA14F9F8
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763093; cv=none; b=NIEqAij8IN/UI/Wg0nbFDNiy8ipSJv6pSL2Zh7pJaHkFt3d0M67QG2t57TYJMLwLSu68SgBn67zMxno+N/C8N8ZR+axASIVz3Mn/7vEiKpwu+s+GWrQNMsTbxMOi4sVwzH/jMG54rTiAhXVLA4WkBsP6jsg2g+xRHhCVvWvKPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763093; c=relaxed/simple;
	bh=9F0y2XO9RYUbzwMVgqObLSiUEhSRN5IACzww9BgnJE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zf0ugML2haYQwamEGSITuO3QrZoYqUuVM1ufe4oBn+X3sjpZ7mv5n2QBTJB48A9xqJhJHUKq4QpktnF3g8RMIuZOCy6+QUSjG5rCaia6KxAQsT4UpUBH7wcRdpk+nX1UhHRGwqzAMcgH6c8ybvdFjTLbDOLuh3Db9CUnKesibM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDChcHzF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDChcHzF"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa69599b4b0so13976166b.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763089; x=1734367889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+jglJVP0bt4/I9CEdmN5hFPwHUD4fv5kYBbPt4xZHk=;
        b=YDChcHzFqPHoOUqE3/LU01prCAojKCwORSPidBPezbGwLm7wpUYKPBkHx7i1GpobcP
         A5tWvv3xGHhxtlky09cXFGVXg/ksQuFLZRY3M2HER71+BD1rK/vXxyOba2fhTQm3dZxN
         4TONZkXB7G5qIAKr5QRjTK5NfkzrSR5VTwk/GDUeglrBst/26zpnrVpBS3/pjgG4j0co
         3kb9fmS/FocHIDi0MqFCu4x2hWQgCZ2JzERzUQrVN7c4YD5crtcAa1r4tb9ei8l7T8IF
         Ml98tJePRsiW+3uun7oEGnaKOZczvrWQujq4ISFT7l2tTu8HmlnR5CCcBwYhBolEXsge
         H7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763089; x=1734367889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+jglJVP0bt4/I9CEdmN5hFPwHUD4fv5kYBbPt4xZHk=;
        b=r5yhLmBinnrGX89SH3tyCLXYeB4eicjHgCtAOXfyXNAIOWmPHJwUVzgAmZmWAUWnPc
         AY5JMaVCQGc2IwTgRkmsWDVq6leTL9vd1ND1UIL9t7ZMP3CYMieEMISGRsXYQyasulaB
         IpLg6aLFmndHxgQqgiBtplJylJeO58oHOqy/KEDwLeFIJk6Lb4XWuVnMs1TQ1Kh3IrnK
         ht6MAd4fnQ0F0E/DzhHCXelRXbdZXj0+Z/cWdgFRStZpnv/Xsf8vF4+jpwTHzfx8FnEN
         gXO4PNCP1Q6IdIbVvzY7XlsbBhNe4/WY+UZ4pEw/jss41hkWqW4DoCigUH14HtTJWxoZ
         rPuQ==
X-Gm-Message-State: AOJu0YxqyXI/tHyJR+uKFIgPJnft41h+awiHgIJS/rEsZyTX/D8IsDbZ
	PqUt5NWS07KK0jmnlHhCKQA7VHLidDHUSpKhK6MNX89xu7L9DDci6UZ3Nq4G
X-Gm-Gg: ASbGncv35r5ioDAdvalRi8jGvkodpstoBFUeyHLNCLlbH8kzNimUOOx+bTdSQNXKTHJ
	idKbohC2KvVOlXc0/XRRhZaR9sSPvHyvWnrTxapNd9hwuKpORYimZ6nelFwS546oHQ9uoG4K1cG
	AuBq1s0MehoFrIzD5QK2y83me16wqIHhW4+OcMLYhXjpzF6WXO4XeEQjLaqyBFyiLpLrYPpoaqD
	lpe58JhCOp4L3cwJ7Zr8A0/tHjusNe6RaZ9pNuaN6EbMY3BFjTA/wU4IE8=
X-Google-Smtp-Source: AGHT+IHrOYt1phgEk5rEa6KtgYcL2wuiT16o6rmAALavPAuEGm8H8OoRLvqtJOzdrPuVfM1CddwbMA==
X-Received: by 2002:a17:907:3e1d:b0:aa5:3e81:5abc with SMTP id a640c23a62f3a-aa63a025e12mr577365466b.1.1733763089170;
        Mon, 09 Dec 2024 08:51:29 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm300539766b.102.2024.12.09.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:51:28 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v2 6/8] git-submodule.sh: add some comments
Date: Mon,  9 Dec 2024 18:50:07 +0200
Message-Id: <20241209165009.40653-7-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241209165009.40653-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
 <20241209165009.40653-1-royeldar0@gmail.com>
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
index 67cdea331b..3b44aeddbf 100755
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

