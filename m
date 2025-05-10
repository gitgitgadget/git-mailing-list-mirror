Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC4182B7
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902065; cv=none; b=au+VxO+OquX3Gp+cD9oNB86hKcUwgNYBhvse9S451Xd6DxGeDCxAkmoNIsdWSc+5mudgr3IUXGoGzCM1qQ/8VPGfA6Gae8nLe+JN/2O7oi2LADWNoQ2tAubXwtCGIQFkKhJ39WzuRH5xTM3izqPHXWwjkwGkNIX30poxHKd+foQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902065; c=relaxed/simple;
	bh=tjDm00X51D+soRcPSfusFfQ3kozU4ElPqn9bKZ9nIQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCPuixqsfsldJXGWbFcc71NkNY510DIYNGB0MTR9pikrxoecgD13IdLY3Jc7PkFI+c8JfMlR72ogoGD6GqGs0CQJirh1A59YoM5ZgI5g0ZkAt8o44Oefq2UFfNeUVxC6dg6PA3ajmoABkhSCe/AzIbpgWBbMKtzo9U+kEkNIBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOS4gpE6; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOS4gpE6"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e6df1419f94so2579110276.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902062; x=1747506862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Esk++tH1jEYsfXOsP1JttRh39Gshc8kyJov4m0nkA0o=;
        b=JOS4gpE6iAUPjT55d72kXzfvMlPvktl083U16uC2Fkpu337XU/vCjHi+MOl8cKcUev
         3qkHXGPv8eiO9C1TbzuH2w5DhKcqrNDj/C5Rw/LATCUYFTKkbkzXrBz5nFUipXsEQHe/
         +C9enOKCYnjfKVVGzGz1LND+h7MQst7Eurx8iqwOoPqmsD2ZGnqZBSYMGD/yZsNwK+8D
         MaWotB88KJbqLDKwNXfBe7mMpuXYTw4S3A5SD9cd/PkAaiDWp9V9cfXIze9rgpYp5rYV
         JcNrckLG5xZsfkJRa6aluO2fanRi8eSG9Y8i2NxwhqfDSYsrBxP03zmXapFeoUWkk6RH
         twJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902062; x=1747506862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Esk++tH1jEYsfXOsP1JttRh39Gshc8kyJov4m0nkA0o=;
        b=JT9XuCa4uq7tWWjpkx4ClHL+VjANAYTKmTVoM4DL0eG1Au8DmAmKhmwOtLHN1rCgLh
         XLQvRAyFxpUiOVCDyw78vOtg5nE1iq3HOIC71DIehsj2YMdGnZmtrxquxBhtBVGd9169
         ffwT8bprTX4q4hMC0nwPB0iW9pncbxzTeC8mzSipBz6o7bq3mPMyXo70vgQ6SMOIBlSx
         bkTs9SUEnxWX6oc0aTLqt6N8o6xyZRgAtSXqW5xae7h7DxWZkrO/6lBy+0bOpmzWe1ST
         DOo+v8yP3g4zMjUgVm2Cqq3iUnCtupgQI5AmfC2sn0o52oVrotGQV4axJX702MqQkMLj
         xX3w==
X-Gm-Message-State: AOJu0YxjOAxzJnQD8Mp4WVazg0IiTifrRktnFzY4bmhfXOFp4AqAU7hh
	3s3cxKpnxHdmzNs2NXZ+1/GAW+IMoP8LHwM4JjkyjVyQHqEB9vYUAXvfsQ==
X-Gm-Gg: ASbGncvUEX5gwmeeViCmQqrObp5cFgbyw4e+5lCuN6iy9+PhGeCM1qkiOzdq33XrX1s
	w6x3oSI3AoUoEpGg+aX6DGrrP5wjCDcWIcSJg3oXIPJY7eSRWk7iGMlRLhHpJFrbnFg3Sr4c5Xg
	3AhuCIwF3MR61AqHPMAA0ORYvK+6Ae/yukljKqHdV6NcZzGPsxNQ/WqtcylPl/FKTUZHChY10qr
	WeCffmhVGver5wobfQ9oNMT9dQdXl02rt6IX0dxqtAidzlyXsC1h+Wf2LRtJcgv7APsU3yq8seT
	EbJ+Qx2ilf6+sfBXKwP7GNR4a2NUs+MqC69UhPILRGueTv5xn8UeF7BgG+gSpKPVVNN4OpgvfEj
	okMiI3wPb1EZrG4wtNRSjP1s5
X-Google-Smtp-Source: AGHT+IE254y6RUOKqNlPsnpWKxlGu+uFm5PkjjIDdP3rZndlokVjG9k24AqZstUCpr8y1D1PdZMjmw==
X-Received: by 2002:a05:6902:230b:b0:e7a:b31c:ca33 with SMTP id 3f1490d57ef6-e7ab31ccbe1mr922540276.41.1746902061705;
        Sat, 10 May 2025 11:34:21 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:21 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] t3905: remove unneeded blank line
Date: Sat, 10 May 2025 14:33:37 -0400
Message-ID: <20250510183358.36806-3-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is leftover from 787513027a (stash: Add --include-untracked option
to stash and remove all untracked files, 2011-06-24) when it was
converted in bbaa45c3aa (t3905: move all commands into test cases,
2021-02-08).

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 1289ae3e07..7704709054 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -87,7 +87,6 @@
 
 test_expect_success 'clean up untracked/untracked file to prepare for next tests' '
 	git clean --force --quiet
-
 '
 
 test_expect_success 'stash pop after save --include-untracked leaves files untracked again' '
-- 
2.48.1

