Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05843451C1
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728212; cv=none; b=UyZCHatZ6DrKP8vGRXNrVjsgXN8TGop1NHD3vdZ85aIyjOD/jlHrBqRlbtWlxybbkEp5E/CCOr5QRLlc9oEiMFOsmvKuXWmBz0xlLz6NeKu2wbmVov/FWjstgE6umO52UDDc/oRB5x3v/u0wuVmTl2+rKYJxG1J6+wPItfDA/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728212; c=relaxed/simple;
	bh=dWFWy40a1klYbbWBuc/y/M5xQiMIqrIAZtmFqoNBViI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4AYZkhF7EFh8EsQ2cW+CvCBA+z4z+YYSDBBWGfs40T4nAV2KQgTFGWwOjZRvJAPSQgRo0M7BT24cvrNaerz39F+a4k50WPWpQfflKnoE7I2G+Xcy6W2qD4v6a7YwNGEAH29nir1h+ufmcfxopRd0c76kBu5o722FrBTk74Kgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qACMSQq4; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qACMSQq4"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1213055a12.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728210; x=1775333010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af/yNj+kaKBelpm7Glzp6Fa35dpod92Ori0r2FuSuZc=;
        b=qACMSQq4QFkvbIN+qhLndjYqkuE0S3lg5GIKGFQkxPm3KwYTuRMJjUfKChmOgI9bWZ
         spKFmv2aLccca4CvyE6B9xhKim9WIP0TTMZ0+BTCXuf/9ZhzERF19hkJSpGNbO8Y8WYy
         JKsmfQ5e1V8gnrOLsX6XZcjxIu9c8doQQOSqioItXbWB+ovFzCPecrQYQjKkNfzflqnn
         GyVr5qkERT/LlPSbCxGB2Tarq0qvepi+nW+8HyFgHay3u+eBCmP1mxKezBTJrsDpKY64
         r2csjFVI9M6fs6zz893Aazq1CzzfP31XYV5DVH1j1G2a9J7rgO9ger74iMbrMG2vBR1D
         VMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728210; x=1775333010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=af/yNj+kaKBelpm7Glzp6Fa35dpod92Ori0r2FuSuZc=;
        b=daUEZpknTikyP9HLh7xnchgcNZpliIniOFGF6Su/Rh7WCWEP/HNcbj7BORH5RgHz1P
         kYqteItjGulT2OvI/tza0hMzji+LvHgktADEs4lgklizaBFpCYTfHuQglTswVme7bAXw
         tE043nfOztxu3H2tlMh5rVf6LDPN6ypEnV9RptVH6yYKCqq3rgKcL4I33cD6AvF5fBGf
         tNkqJEJy4DiWoayYX7eD7oUGmPfNF+cphFn7pBLcI+1sD6w3yFLat5c4kqKaKZOL6d/3
         l3whrktvhDtSk6ejHeQH3IOzqKeN6/TAT+Zx4xFnHuQul67T464wlex2TfXila5UQook
         7MPg==
X-Gm-Message-State: AOJu0YzQF2FV6OnR+d1eCG22c3jLXOBa4s34yZlyH8RVToHKgjIiNGey
	/OjLSqiUIGV+Kykc7BZn9JUrzQYI+DZtcRx3fi4F019yQhrOGLu66VNTyw+GA1L2
X-Gm-Gg: ATEYQzx9F9KPo23u/FLXimwf8taxw1Gnk5xgBNv89J06FNzfbX1qcdMv63zPvtG4ySA
	MVmzShpmSFiXizyaVBa6gL1uKt5AJTgPL0URWXuUEYSQSTDfLMI8HCsMhNsjpz3tnnSWsSqmf2p
	dq1tv0vFON36W02GGcyBUDdQEtVkppPR8hIb1KkgD5X1BGDzav9P8tTq++6z73faxBEPNURWUx8
	NttZdvCtXs4MG8VACIuMFi8FqEpkIMbgQ4cPCz10peqi1RpoXdXJfZPYrlwFcFwB5Qi93RmAk+K
	27VrKPIJ7c5ElJB4MtOthuIQIU6KGEeHLWuwpYVZP8c+91oioDz4M5OA07i0tSqS/irRoJpUDmM
	c3q5ytA45vgYIjAneFizYKyLVNXJATYNypB0Mino0wgqN9eFDT6mqdzEEZtl2GrocJtH/Fo6yXz
	PiZvwiaPNUqpXc8hWu5t/2+EKOGtBYcoKZWgjM8LVOhfYiavFiPY+IGYpzfN3hr22PxxmQBiCPZ
	IQNK/Wpaw==
X-Received: by 2002:a05:6a20:2592:b0:39b:ce34:f7fe with SMTP id adf61e73a8af0-39c8780e17dmr7571561637.13.1774728209984;
        Sat, 28 Mar 2026 13:03:29 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:29 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 15/16] t0100: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:54 +0900
Message-ID: <20260328200255.247759-16-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t0100-previous.sh to redirect git-cmds output to a
temporary file instead of piping it directly to not hide the
exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t0100-previous.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index dd5d9b4e5e..94a12e4ab6 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -40,7 +40,8 @@ test_expect_success 'merge @{-1}' '
 	git checkout other &&
 	git checkout main &&
 	git merge @{-1} &&
-	git cat-file commit HEAD | grep "Merge branch '\''other'\''"
+	git cat-file commit HEAD >actual &&
+	test_grep "Merge branch '\''other'\''" actual
 '
 
 test_expect_success 'merge @{-1}~1' '
-- 
2.43.0

