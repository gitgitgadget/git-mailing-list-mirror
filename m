Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA85E1F91D6
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772331803; cv=none; b=G573a1wCOOaM8xSiNSJ1aALGKYl31HbsD/isB44n282WBjLo56NKWKCYAmk7HMyfttL/7pKm/r3rzn2+5YsXdg8dgJsfP6ldZo5a8ojgRcmkp1edRRmvWf1O6vD2dHWjXqMtODqFFOL8m77QDTMTBjNG0Xsa53q8b0G1q57tuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772331803; c=relaxed/simple;
	bh=OaGtQo5Lb3Kt7UuYET9dMjEtHXc+6k8QyU/lMtRk9+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYxD7C5Ar5EMKPCOiSm8gttdHre9Ehese7CFisg5eeuoqA/l83mG1tQ4bncD1R5wnnKGOwk8jb7HK9Qtlj10AZogplwZIK7tcgwqeC6zcPQVFcko1EU4qKafB4tB0AYeY/ggy0aA1DU6ekgqT5V0s2OfgFaBVSLecEasybtG3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrBx8YAi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrBx8YAi"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3562258142fso1885733a91.3
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 18:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772331801; x=1772936601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qK0x7CPfuMlhtjkCoN6Vwcuaw3OfsvBMCZreHFJL1tQ=;
        b=XrBx8YAiOCnzbKuUytNElXtqu8wZKVk5Npe/Zcyv1Hw7E9t3CN/OpUdzVmKOhqhT9W
         Mk40lW58J75eTpcwwjgiT/m4e3jrI+IAwuIrD+K5ODVIit2/CEENABtWoNlCI11bGKhX
         UYh2Zog8Gi8GQyWJQAvIebXhtb9pYsKQx9FoCak+poT1O0Bn1Cfpdc9UoscAzBYOvs8f
         RvdWl9zdhP07aovVvlfAN9bUXvFpW1ustiYZTOsmzv/xMrBQ+UUQTneIOsoUt7Wzmc+6
         5+/hYZFit5z+Ew1iscXgmrNagug5Rawiv0p+DW2wq4KPDCseeiWNMG5AqNIPYiBX283+
         bUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772331801; x=1772936601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qK0x7CPfuMlhtjkCoN6Vwcuaw3OfsvBMCZreHFJL1tQ=;
        b=lWXzMSVV+lmqwbTXLTw94eI9CSoP+QbfhKW6swZGYM36ZpWfFAK1HfDSP301XhzrHt
         6d7ZZKtPT26i0T/0mUwGKoR0cdzowO4nNSM/LRVfhtqzCKhUhytIYueO5rOKNDc1pjjq
         2OreeVWnJGWlTBEej1e5eT94OsgyM8XqYwus5do2nPMaR8SfRxWkmFS0iBYPJie9Z2y/
         YRzawv3d7ft0+XhH1V5PbDkw5rSuHGEsdPG4aJPgFD5pmo46BdCYvLyD9HfwG1N76qgL
         89tmNCEVnlXgKxnzJqf5m0wIAkusTDmjvI0XUm3vRbs+AAcRY9DutsOfwR+B4C3ZvwAb
         tVyQ==
X-Gm-Message-State: AOJu0YzcgsfkCE5cXgYcXhET9vh1sQd/hyLhzZmBjrENa2wxkGkiaS3W
	Fi3K3qaK6NBAH1QCb7efFxlHFmoAC9/Hbk+OzajSIeWuPW4FZZlX9HpjOkdV0dwUvts=
X-Gm-Gg: ATEYQzwHdQQbkUPiWy8Ls/bXriFB3iemua12ru9SI063V5nVdKK6sC7Ncms+EefmxfT
	zFDmL5PXYH88BTr7qvEfHwSNdu6c1gK2dbB7NW/lKooWB5CKFAHB/c1fE6dYrBvizU7PNbv78Jt
	Req3S3hn1Serb2LHT+gyDNjR18TzuNOkgYeMDxRNVwYqjCt6B5TiGnoQ+wHbpGBttD9A1DgMAKf
	GuZK83oJGmd55NyMZjldjVd2OyxnbAH+aelrCROe489w0LM5vs7fP/dlR9N2UJtHC0cvNgGOpys
	Dxrup0ZX38X4M+Nj8IyaVXC16b3lzSShfIvEvNKIyvSkhVFRbM+SWH6eA7uy8lWkuk5iSoLoitx
	0KuYR5UU4b+DyhjJqAwCm+7Gc9e4PWdX02m7lxDVUO0cKfxAGX7wqaC7lozZgYFV8knI6BT2Vx7
	jJi2gsPeyAvhwDWDK4j16y3CjjuZ0oqToSWsDbnSAHRE8EwMYadsc=
X-Received: by 2002:a17:90b:3f46:b0:359:8312:90a2 with SMTP id 98e67ed59e1d1-35983129490mr1348681a91.11.1772331801040;
        Sat, 28 Feb 2026 18:23:21 -0800 (PST)
Received: from santhosh-sandy-07.. ([2401:4900:4df9:82e9:fe5:9745:9644:a9ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcc9c37sm9029320a91.8.2026.02.28.18.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 18:23:20 -0800 (PST)
From: Santhosh <santhoshprogrammer07@gmail.com>
To: git@vger.kernel.org
Cc: Santhosh <santhoshprogrammer07@gmail.com>
Subject: [PATCH] t/perf/p5304: catch git count-objects failures
Date: Sun,  1 Mar 2026 07:52:53 +0530
Message-ID: <20260301022253.129736-1-santhoshprogrammer07@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Piping `git count-objects` into `grep` masks the exit code of the
git command. If `count-objects` fails but `grep` succeeds, the
pipeline reports success, potentially hiding bugs.

Write the output to a temporary file instead to ensure the exit
code of the git command is properly evaluated.

Signed-off-by: Santhosh <santhoshprogrammer07@gmail.com>
---
 t/perf/p5304-prune.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p5304-prune.sh b/t/perf/p5304-prune.sh
index 83baedb8a4..af59424de8 100755
--- a/t/perf/p5304-prune.sh
+++ b/t/perf/p5304-prune.sh
@@ -14,7 +14,7 @@ test_expect_success 'remove unreachable loose objects' '
 '
 
 test_expect_success 'confirm there are no loose objects' '
-	git count-objects | grep ^0
+	git count-objects >out && grep ^0 out
 '
 
 test_perf 'prune with no objects' '
-- 
2.43.0

