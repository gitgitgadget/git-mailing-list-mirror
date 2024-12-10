Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA7214234
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856348; cv=none; b=d0F757xFSk7YltI+D47XNVTrj/fDBkiyOrni49KoInIES8Z1nFOlktn19yVLUOCl2RkywGHJKBXwWsO7awGzkPtnQX1S23TVx70b40mluhqLYuWI31VJgBbKq9CFzla16uswMfxAC6qCuIyctM6sCgHA5S+2go9BoQfLQ0Kj6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856348; c=relaxed/simple;
	bh=n/SgS0D1kkStv0/3Q0fUqEhxyEgITxIeMACvKczgwPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=liGaEfKs7zpYSu65gPvpkJjzgmFQsg/TvRyb1Eq0b8BvWevspeq5Vj1Ru4ZRqmKdqEpHSYXVO1OP+4pJbzjrFZ9W4a4gFt4t9NpeGAYenU+TD10BuMp5YDJZhNW/VC+durtc3CtgapRQCdjY6TO0u+QAKyAE543SZY07XmfwTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEpK9mqq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEpK9mqq"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3c1f68ef1so822811a12.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856345; x=1734461145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3OYHh8iTbnHQf0CS+eSVEVY5/X91gHZdPmDyMNtY70=;
        b=VEpK9mqqFhq+5iSxRvQRLxRIgY/onW9XLQrNXjur4d13NqXnnGyFXkGOQQLAgvEYP/
         nYBZ2GIrLm+a6xgz8y9txINeiYdYAwnjJiNji7rCN8gCK0QUK9wl+1ypbr6LM5oYqu6U
         m8buah1Krzfj6AOd11TgWPBpbuM46Hn86NDgw6ubZfwJbuf0x2oVIlvBm4lpU68DXFh1
         QNTWCV4GawX8tTrGgvfR3Ww8EIKoCh6fMruM5we0Bv92e668u+OOSsTckI+5eQ/Lfcov
         UQn8g7iNwqGFoQZ2mDKcXJpduuV1PNsZA4I+09QgnuJXHMC/bh6PAJPk9l159talIeJ0
         zoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856345; x=1734461145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3OYHh8iTbnHQf0CS+eSVEVY5/X91gHZdPmDyMNtY70=;
        b=qcFuuAfI5iTQIfR5vtt+oWWq7lWroM24OQSzad4STvTaoVN0n7TrpY9V/WJ1jg0MXy
         +cu1J9fySBfDXULt8k9VyllPV/5+PxOeB63wI18sQCS1QlKQq0zSsC05ptLiU/BQnx45
         MoRXFz6yHjT6V2RtdJtjpv+EBkthA9JnkKGgl2OE+i1YCnuPEJsgtJoNm0+W0F/yfFIv
         1p0BGEdC1YCyaht9eazBzKtYIwAkvFkrvdQqt0nf64Al6wvGImUnmYSQAmKtUP6tRnDq
         B3UXwN7mdgbmuJy5MgWKhqzm5b28EtYR4q4PP31Eiz8FHXFo8lnX6nQ32Tcn+yzkchyd
         GLnA==
X-Gm-Message-State: AOJu0YyVRtCot7u2k8u67vHIJTH/2H9uirT5OJSF+vFp3D3Z5T4j737O
	a7JIbDZRaKGSqPKhF36Q7n4WjIGOl3qG2Swp63xogO3ow6loaQb8ybTLpd9R
X-Gm-Gg: ASbGncvTYLcUJs6T1WLV/1h7pWwashxVNThzbhmV3hCXkCBFi7Nw7QdEHq6Ga/HKNGG
	t+vUALnaWDMtUXI7j5MnabmhVuDQLuYhaKgKTKnTxe7FKLzLM35iufwyYcBmZ+k2YigvLLfmbV2
	shAaz+buV0ruHDaLe+S6M7B2D28sUYsrz1GVr/YZH/AWMLJCSSmqd/ENbRVWHejIh63ACWwBPI+
	sD2GXV1azk+7Oh42J4A6gERRULobkuiohHab+X/3AcRC5LUAALrQ9U8vh32N2XIRA==
X-Google-Smtp-Source: AGHT+IEUg7ZQLrp9gm7318N4E6/1OYHpX32If9Zfqm5xWsEe1wuY/ek35ECrl5lgEWWC1nhnwJaFYA==
X-Received: by 2002:a05:6402:4311:b0:5cf:cc32:82f2 with SMTP id 4fb4d7f45d1cf-5d41c572f7cmr2048185a12.5.1733856344537;
        Tue, 10 Dec 2024 10:45:44 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48882sm7895896a12.24.2024.12.10.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:45:44 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v3 5/7] git-submodule.sh: add some comments
Date: Tue, 10 Dec 2024 20:44:40 +0200
Message-Id: <20241210184442.10723-6-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241210184442.10723-1-royeldar0@gmail.com>
References: <20241209165009.40653-1-royeldar0@gmail.com>
 <20241210184442.10723-1-royeldar0@gmail.com>
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

