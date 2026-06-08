Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81703CEB99
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913696; cv=none; b=adUMCKZY7eNRp/2eRQaT3AKvlYZplz0Cie5yAweFsrxvuwg+wissmqsupdqvGV+FRtsopo0s58WhCi/gx+8JsJ8Jiiloql36St0OUVdIuIVhlTbUvIJU5ck+gw+TA+8a4VVS53oV4xx0jyEcNRQ1oiHxKed5XM5dEPzI02c9l9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913696; c=relaxed/simple;
	bh=A7l9hGc07E87yMZl0+Quk2FSzmmH9NcZ6FZMTcwMmG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qET0UBEyLu2nCIIY9bfNilvcgxh53FOOEEX995CDrqGrw7GG7zYaCFqthIvEvYjkeFbq1L0x1NozC1j/d0LRCzcHVO/lhdLdv8neTjPrzIXT0GC/QQCgdbpaWhOBfgiNGOvlH5V+bSOOsgZ79F9bABmjJjIum/Ccecaft/jrC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7lFcVD6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7lFcVD6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso27270495e9.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913693; x=1781518493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CJrwibuS8F5G6nQI5trc47fMr4AdXqLIPxkLGe4bKo=;
        b=O7lFcVD6qAl+xDn5EjgP6aExiU/WMmBPGNUY0Pe/HjZs4ibaubYhWimQLQtTIVzrni
         QVKIEECMhQ01dDS3IXV8EYeImdCjB8afcCdEDOUpqRNHuowtjaFVROou2XL4RijWqubC
         1f3Ks5qie9e02WMrjQQGAC4AVdxKdT8ZRhirC/l2k2dC40z02P06x2Z/LNLFL3Tp8UXI
         GahvERwWjJpuWzihh15z8S+AKiFDM778fM7NGNsZsyvoi1VeaQn8kbFJ6kw95eVWiX+G
         WVDwmrDu3NIIwP+Vg8bxtVjHUG2AcjojufJx9oJxNNyh3Tx1lyP/gDJT3D2gJd3lm/CW
         Cjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913693; x=1781518493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7CJrwibuS8F5G6nQI5trc47fMr4AdXqLIPxkLGe4bKo=;
        b=bZw1t0XG2RLszF5seEReTj1yLF7gbwkUTGtPIKt1Nr6DqlkzKZ7Fro+EbuedtWYZcw
         5aXZdnOOK3nQEDRBtUA456Np6vdPxi0hUJwoD3WuM9gevowwJdt+XdVxHpnL0NAzv37v
         QSCxr/AghDGWhWHM3mnf1il+2frdoNrEhUyFxuMYb5w/KFLmkAELMWAXmnQPja0jsqS8
         jg7KZvj79ropcULMljB/jYFMF0/ctSJ1ynRB6slIoOfPgk/n7l5kRMf4nyxz5dqQFKpp
         5CC+XbLJ1B/LCGJIx/iivEKbYgf14810i3rUTjtum+F6jzzDHkm9zikUVbZMDURYS+IL
         vrvg==
X-Forwarded-Encrypted: i=1; AFNElJ+uDVX4GMEyMUnlAVDBqzKqbxSD7Xc7LmvCHD5heTeG2gDil5meUCM8ljFGwM20+QH6k+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfU6VrYwpbXEVUbQQtZBd+GY6n671GC8QkuSZUVzXWtFQSa5nX
	oUNoFy2FXExATfby/TlZRtl0GaV/x6PoSy0mHrnhIdDQG+DW/xaOtbjC
X-Gm-Gg: Acq92OGQvMWntDb1F3Xb97Zn0KGAYxzTAfYQYFWLCt9UP4uIT58ROViZY1utMmtZTC8
	9m9JTRpnqAi9Ht0iW3k2MgwwcUih1uiQ+xo4W4FgNuTQyE8F1XFk0soG54/LAorC3c9LSuq+6tY
	HhhALF4jKbRO4ezHlwBHURiBTVuDRrwwArTFOB3d23hg6iJRxd0kEY9QJn/0vw/I/zf5PPiFPWY
	36HWY7gyfZPu6k6nUUoyqVglnO93JDhY6kXcmlPjCn24NFH6JYpPeyNLUm2lRrghsw9926afTYq
	zm0a99NV84TreXtMpUkuYx8N3/iyIUFNBlczwFqz4q9a09GEz0SiBgUZRikbXpWURzt21EPKNso
	WkYy8vPKa2chzXN7bSkL1btFChoS0ei+Z/eYwuB15IyrBMx5ddjX/FuYVKaMNnASwgIuN1OVHi7
	W4zMdhxdsJR7E8uUOOquhbKpY4j01DOeeRG0HbOS9fqYH0N4+5BDrNHo0SzndskE6AKWUnUwY6n
	yNiL2pPfc50Wb0BBaZ2cit/9xgRWvE89ApJGq8l/3rAPNpx2l4Qw2y5EyoIRyh9/Q2KeU6u/n8e
	yGoOatv8ksGF/aHsvNb7gXrtPmw0GLGa+SJHgbeO4UhFe5cTqnMHa4k4Dq+6hrD0pA==
X-Received: by 2002:a05:600c:6387:b0:490:b26f:a512 with SMTP id 5b1f17b1804b1-490c251d015mr252214365e9.0.1780913693125;
        Mon, 08 Jun 2026 03:14:53 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:14:52 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 04/12] t1006: split test utility functions into new "lib-cat-file.sh"
Date: Mon,  8 Jun 2026 12:14:27 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-4-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

This refactor extracts utility functions from the cat-file's test
script "t1006-cat-file.sh" into a new "lib-cat-file.sh" dedicated
library file. The goal is to improve code reuse and readability,
enabling future tests to leverage these utilities without duplicating
code.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 13 +------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
new file mode 100644
index 0000000000..44af232d74
--- /dev/null
+++ b/t/lib-cat-file.sh
@@ -0,0 +1,16 @@
+# Library of git-cat-file related test functions.
+
+# Print a string without a trailing newline.
+echo_without_newline () {
+	printf '%s' "$*"
+}
+
+# Print a string without newlines and replace them with a NULL character (\0).
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
+# Calculate the length of a string.
+strlen () {
+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8e2c52652c..8360f3bbd9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,7 @@ test_description='git cat-file'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-loose.sh"
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -99,18 +100,6 @@ do
 	'
 done
 
-echo_without_newline () {
-    printf '%s' "$*"
-}
-
-echo_without_newline_nul () {
-	echo_without_newline "$@" | tr '\n' '\0'
-}
-
-strlen () {
-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
-}
-
 run_tests () {
     type=$1
     object_name="$2"

-- 
2.54.0
