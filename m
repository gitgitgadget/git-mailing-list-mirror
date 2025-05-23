Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488E1B3950
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029047; cv=none; b=lSa2e17aZ3fpBqGANIWtRQzxrVvr9kmBilI2uan3UjFrciLABP60FPv8BXNRMnXipXWjWJ3hQMxBCtMJvLnEAL74nY1JdUM+IIkTkoto2+Vur9DanjOVkObjewPWaee1WTdlvnlHsjZc1UengqIAgEGGE4+X9OQmWtUkauGU/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029047; c=relaxed/simple;
	bh=0+BPKQJ3Du//ZB9lUc/RyHdZalVTkaZGwfTnIUY92qY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvA5rUM/GyP/TAsooGVdMPE++syiZsJN0uP3CjCo7ymxOdU2hbDW7P854j8bc7db3XckcNdc9Dxo9CARyT653HzH6Pte/m9GJUYr7uJRTxkbKCTPaDTAkkIakCLfs3400GGNcWF0sLBkSaNNQ/PhRn0xGiMohNkqejdg186WsN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HodLEU2F; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HodLEU2F"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c9376c4dbaso33220385a.0
        for <git@vger.kernel.org>; Fri, 23 May 2025 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748029044; x=1748633844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dNip2mL94DBhWvPk7o+9Rm5QVtxU8W1NmbeDEbAvvA=;
        b=HodLEU2Fm63ylpA3vbqyYi7Clzl6HxqQL3FvCMA/Gab0CkaP0EWk2++oI+zOdPauJL
         TWUF7kaI6/167yEsw5AlUSggrQto5o1mgH6lIV/1Ma2eUj35jdTFBTYcOqeWs7qzbn72
         TPypyUnpWMuCcNRHoUic26xNZxkGrTCXRX7mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748029044; x=1748633844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dNip2mL94DBhWvPk7o+9Rm5QVtxU8W1NmbeDEbAvvA=;
        b=wfbaBcicufIaSJQJyzQYuvdd+y0wiD40295gGhrEw4W/MTS8XKJFE5cePXZrR2E8F6
         TQDKpJXfcxCGZQO+1LFSLOPOutULADwOrC+MrRmI9IiAQw/aLSsqXKMM/kpIrDOB1Lpk
         2XWcmVV7pRjf6abNKmRPxGM8JChmAMHMNKFGj08S+y6qgbhlHNdfMxzJrUZJTQqZ4Yuz
         jcd7EWbN2Tbkn0dMn5akUTJOCnvQz1Ecqt0FcRinASdgyj5pdPLgJcWZIj2kMsVf/qWI
         N/8ZDyDDA7PPrtHEbMJD9E3hgXgBYlbYflfFz1fTSe+x31NNach5icATOaQ1E3ypkvbL
         wPnw==
X-Gm-Message-State: AOJu0YxxDOn1+bM/ns322FlOXnLJPdeoD3Kt2HPMxLuvu4YjB7rWRf64
	y2oOG/zTXKbylBNhCxpsiwyiq7vzzjjofDMruM8sHRqbVX0qEuYBW3UFtlZivfyNRqK1Jh3UJBH
	VjSw5Pw==
X-Gm-Gg: ASbGncsv69ViTskIYG3KcKtv4baw0BLrlsXuBJO2aOeJqvVzSASTioJ7FdyhsiU9ZLz
	iXGo1Vptg/UlSsll1WgIiwZSPhvR+qDqUhu6+wwWiQdHgT1PDbL55gn6GWRIvfIG0aiOWbpnv0c
	prd1g5/huPMj3gAu2uOARa9RqHYUCT4y5A2yweH5sswNp+qZoLiHYxaIy+ZpxxGmI4dxCSXjYoK
	xQ/wCzvYtRzJ18aO1qLwJyxuKpLic+rKpdYDNPudyziYL6YqfxhOe7cVGFp0Z3huS3tDU/pfR0Z
	kpRv2OmW6y8wnVoLNt9CbpWRrqsBa/Ue+prclaF3N/K/fzqiuClIW70WlZGOaH9X8osrWN0=
X-Google-Smtp-Source: AGHT+IEtqlKlilIb4uEQ9Bzjz5ONzPxrw9j22MMH6mi317X2v1bbx67aectyQdqY2Ssq+XTDMm7+3A==
X-Received: by 2002:a05:620a:31a0:b0:7c5:95e6:62c9 with SMTP id af79cd13be357-7ceec4b8fb9mr115201285a.29.1748029044416;
        Fri, 23 May 2025 12:37:24 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6c7fsm1213825585a.68.2025.05.23.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 12:37:23 -0700 (PDT)
From: Mark Mentovai <mark@chromium.org>
To: Git Development <git@vger.kernel.org>
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] t7900: use pwd -P in macOS maintenance test
Date: Fri, 23 May 2025 15:37:22 -0400
Message-ID: <20250523193722.68344-1-mark@chromium.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

$pfx is the basis for the expectation that launchd plist paths formed by
`git maintenance start` will be compared against. These paths are formed
in `git maintenance` by builtin/gc.c launchctl_service_filename(), which
calls path.c interpolate_path() with real_home = 1, causing abspath.c
strbuf_realpath() to resolve a canonical absolute path. Since $pfx is
not determined according to the same realpath semantics, when t7900 is
run from a working directory that contains a symbolic link in its path,
the realpath operation will produce a different path than $pfx contains,
although both paths logically reference the same directory. The test
fails in this case.

Base $pfx on the physical working directory (pwd -P), with all symbolic
links fully resolved, so that the path that the test expects matches
what `git maintenance` generates, even when running from a working
directory whose path contains a symbolic link.

Signed-off-by: Mark Mentovai <mark@chromium.org>
---
 t/t7900-maintenance.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8cf89e285f49..677e92f1490e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -882,7 +882,7 @@ test_expect_success 'stop preserves surrounding schedule' '
 
 test_expect_success 'start and stop macOS maintenance' '
 	# ensure $HOME can be compared against hook arguments on all platforms
-	pfx=$(cd "$HOME" && pwd) &&
+	pfx=$(cd "$HOME" && pwd -P) &&
 
 	write_script print-args <<-\EOF &&
 	echo $* | sed "s:gui/[0-9][0-9]*:gui/[UID]:" >>args
-- 
2.49.0

