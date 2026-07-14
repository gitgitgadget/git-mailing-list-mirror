Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01BF39060B
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029520; cv=none; b=jtKl7ZLf5/9ETspxMswHYznpHRo36oEcmKxWBg4Sg1pm4MlzHuQ1bhSkGk5X9dP2Jzm8HQP9Z0hhKhNWnrfx6zRFJeb8yizZuK5w+LpQegttOaEumPO/hSzHdGo+Y6YVexiLwVGHtO2JE+tgQ7t4aed+IhXPlzLjR36x+EUsVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029520; c=relaxed/simple;
	bh=y2uzU5vNFVRfM+pafKNQvRwbnLOIisGexNOTXTYbf9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TE1NDbrM5wnPvaacLUnP9HUuRKwH7XZyozeiHUe3IyyRJrmQ2ITg8YWCIFP/bx/ndBlLE/JY3NCZ0lPIoLo5haWH1Xb81orNi+6eMUqnM4Zdv4qs8g0Gfc9AbF6cSIg4euhOMPw9futUZezLdx846H2YFeEtU6pv67caKX0MYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGlMI9DZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGlMI9DZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f25d47dcso5823625e9.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029517; x=1784634317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JSnx+CNl4jzPlODplDUft8aIHfS/Wkjf56tQY273kxY=;
        b=RGlMI9DZ0pvWfu0P8tuCH8BwEI9B4EfFoh3Tvu+YPf5iKfg9sH9UVy8E15ZBEbwS2v
         ATW8HTjn5SeG/0TEgcLzQ1SEMtFziO0i8q5X96XlggJ5KdVOS6nz+rkBVdyv4eKHYyfq
         pFMmt+yQ5PeK8FvUH8MXuIf5+nDNuLKcwyIlgZUx0Djor9lqRgR6Fjtjoc1FE/KFTubW
         osyJpJ/OFMMkP8zMZTpDXn5TM9VVkZuWh5Bov1wBBmr6YYtT6qvOyETQ7UVt3IxY/dyr
         BHkGy0+ey/OhvJu5Nf3sFX1HfwZGotFf+5V8XTfocnxLLu7t99VYMf+HUy+39ycMWjgD
         hBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029517; x=1784634317;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JSnx+CNl4jzPlODplDUft8aIHfS/Wkjf56tQY273kxY=;
        b=Ck6D6wYY9GjBPuoRwjlPy2dM/T0nlpU3ZqHO3dq0S0Arwa5o2XpXE13KKWNODhz5zl
         DlgvN2YaG4Ae0G8mJ4DC0YSls3im9JflR1fcfJg1jbOveNq0FIq4PFY+WlJmhMoYi1Fc
         zjYIp3RsvyHMiu8F0AKIfmgluYHgtwciEhrUuGga5q4NqZ62TL5AWq1iKfcEvZKiZ/NV
         6Wd06DHja0kd1KWlurdG1PlMnG39at+KT4yd4OSgvbmJWZxMWrtuyAdNYVRZzi2TLfnT
         O4bWkcDwAZpNj5Jk/tQu5kzQnETgmfsDYrRRKriN2Sm8/oydCfYODFmolzOil5ppWm7Y
         +/xw==
X-Forwarded-Encrypted: i=1; AHgh+RoXt6nxw1vP+q1+p1WtuFfjZN3iyypxptfc7xPXm42fp7RzcW7qVDXmv6jKfEDWY4nVI3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7eG34pJfEe7ky4dUZPsQudZJ6W46tFhE39febJRp/jsvXNcf
	NxlzcBZFeiuAsunss298ojfEhy3DiGkZ2hfyoBK+wfznsTm2vqkiGSub
X-Gm-Gg: AfdE7cmthyUw5lW2TaiZIAvW5JZ2kZYBJXCkB9Emxg5HdWW49qnathGvilfEG1/JIzG
	d02tu3GKnwC5RmypwgyiUc9bi2otBKR3YPW+zRYPccCd1Sj5hlGUh6aTSKE/wHMkw/qP5/BFTct
	whu91g5K3mFj0Ke1avQRZzprzRu5TaQ4z3TcBYI+NmXiNUywsUgtISVtr05FEdMZt/EtH/ZT1Uo
	YtEsQa4Zw3WTxtd8Io/McF4TjfP33Ar+Do3dxj7KxmfMmti1Qjja/eCo8kWRBLOrz3i1IAWsi64
	4JAwXo4ZcEli/+a+NBpW/0dq8UAKG0O9aqe+s4+XfksG7jo7Em4WRaFYrLWtiqYO1cO3J+cSll4
	W1y1ZJ1InpAsCiXU7JSz2Aait4E0X3UziJucbULMbAwvs3fsoAOvvdshtkE0UC+0JSXfkvy0rCw
	vqDrwD8zWTRsuCL2iaOqPVoJRAh8lQa98Vpv6h5hiUeZVCroCL/yT8JrahT6/euHRlSvXqdtBPE
	bWKy1Af27ggunOXk1oKWlwbdNIUdtDZM0NOQTgc7ZrL0MMMF7bqCvCKp7mEbhtPW78Sx1uyCa4r
	UWxwO4WOeazxFJYVbwKJLIF0y0oO68ft7NJafKsgCbUQzsry156nt/qt7nAb5wQ1sf6FrqUSWUu
	FoR9E/mDJ91wHp6iUjpRm
X-Received: by 2002:a05:600c:1502:b0:493:c773:c3f4 with SMTP id 5b1f17b1804b1-493f881d64cmr80143305e9.22.1784029516826;
        Tue, 14 Jul 2026 04:45:16 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:16 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v17 03/13] t1006: split test utility functions into new 'lib-cat-file.sh'
Date: Tue, 14 Jul 2026 13:44:59 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-3-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
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
script 't1006-cat-file.sh' into a new 'lib-cat-file.sh' dedicated
library file.

A subsequent commit will need this functions, the goal is to improve
code reuse and readability,enabling future tests to leverage these
utilities without duplicating code.

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
