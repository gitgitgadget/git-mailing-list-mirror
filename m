Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC538F654
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461331; cv=none; b=a5mEi7zyiIxnWNzymMSKXAPwyG3yyTQB6033ljRxFy9mS/z982caf5QPtbcHZSki5IKSUfV4GqwSGiNqr2v5GAezB3qp+OchxFUIFi0PSHvl9mDokPhhDqlWh54roB0uzDPaSnz0SpwqKtBTEK+/a8XptfpT6VokNkwW5JUevqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461331; c=relaxed/simple;
	bh=KPaay3zOtBE2+vHwU6Th8yw2WNX6+W1407oC/+A07k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3VE/Z3CHnP/HU6PAp+tdSG5gFPDJvIv5ilJjCMgHn+7+GojaNTlFBhs5XfTsHcXSQ7zrrGEZ7uSIaqT84huBVwUDgGNBmZEAbq35ehCaxe93y8ruxD+St5njCp0sOhh+fitPqjqiRAOHXlY2c4BAjTxYdPDx9qFduvmRKvFSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFZ5ZtFv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFZ5ZtFv"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-827390e8a3cso2905611b3a.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 06:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461330; x=1773066130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bheFZ/T8q8CojwuEIJvulCetcv/fIQqEDFCzyx2NMkQ=;
        b=WFZ5ZtFv23ecSWML8h8nLX12coYmR7SZScY+6hgRliBQU7O1xUFrUz0K/mBEOsBv1T
         MnnCOn+l/ucfC7kXwyjDZoQxy+eaBWHVnnyFd+auDiATP21BQ6b+E2rW8kZCAPmHMkSi
         JNyBzDhgG6lt/pArJQEkDYt5wddLjFxpOHxdYLzRkCpYGQXHlZtiMC4r+B5JZnhOcqYf
         kvbMgzDDh7STz5c8JxyIMGwdTc1CpFmNbGxRMktyK27pAoDAutwom+G+AhRu0C9CxaSg
         IwqfiqHqhidnclWF2seHRDy7YxrI2EVH+GRoA1dOcOAuJ/j68zxZTxPZuIM0z89qUO+B
         7qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461330; x=1773066130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bheFZ/T8q8CojwuEIJvulCetcv/fIQqEDFCzyx2NMkQ=;
        b=eM+rtsiaN4/uyBRq0cMSVUx8eadg5tH74gmcUpADZMQHInL7LzT5EoJz6nnmR61L6S
         r38q5/7JTTShQlye6ImOv+oENmyNHm4DX05EgZMB8EAN7YySmNpsTdctyrG9d/bMMd/k
         psMWCisy3061dlQqKtVq9FAX5IONeTbTIgQRDUMpln0uEbyJHnH5EPiJezATDDF3uvP3
         ZC2za3G5yTTJtKGI0hn3udxbBWWysQ3IDvY8bXpsygKXQBfY51KRHuGLma9AQNuSz9Rk
         Ed62OaVHL3mACbi3kuqQk+w5bHFxA7TFqgp6ESW+ti+7MSRK5JnA5rWlGNvqZiKdUg3o
         tKyw==
X-Gm-Message-State: AOJu0YyBl6HbLlfT5ld5DlGcVrtlK5U2yTriXL6dYQbIbckmt8aZmJ45
	2B/qz/80yQnLlV+eYdg1177Uiifg1jD+3CLvP/STC7w6tA87fqTsW7gRgo8aGDDp
X-Gm-Gg: ATEYQzyQOiRRIpGKKOhAmW7uKtIlByMbutglaHMTWc2v2Gw6xg2TNpJuACZWkgGjqom
	dpKQ3uze7MnKgZ4E8jxw+CY8wMLL97cfsdi8n2h5/lhIyC+UG1lnK8KcpwWBwg1Wjj0f+qwvLZx
	XaOMd62te0ZPEkso+hO0T4sh13pIkuzG4yZTTJ/CemrugrHxbRxRZPbUk7zuvDxb25Ik8U4hdlf
	NzZqgxr3CIpCraysG0fwHTn5IOYQkx19QOumqlSDnJx2OcewRuyrO4kgYOydRqUNEkN9eBVIfWb
	NtJLJnd56iYTw+cBjMDh1sIlJL4plDgqOeqMisa7q+ZlCrehApkelGfdO5CF7SdEum5gihVnG/M
	wvRC8nR9cyJZBFk5pbsgNIi1Y+1nRcyK4LpUgDAO9SCWEvB1Hk/5Cul8Ye2AyGZqfz/4UwSyXs5
	6iOqw/LDBVZI+PN+B09kz5QMkJWjVgsd5iQfuLwbIIfllWLvbW104+zeHtesYvha4kaUNvlhVEB
	jP5Ii7Sm9g5uEMV5lxl66yE3pmRIIibRAEKd3eMttA=
X-Received: by 2002:a05:6a21:498:b0:389:8e40:a150 with SMTP id adf61e73a8af0-395c4535625mr10768938637.6.1772461329817;
        Mon, 02 Mar 2026 06:22:09 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912fbc363sm11329843a91.2.2026.03.02.06.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:22:09 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH 1/3] path: remove unused header
Date: Mon,  2 Mar 2026 19:51:36 +0530
Message-ID: <20260302142138.712273-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "environment.h" header is included in "path.c", but none of the
functions or macros it provides are used in this file.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/path.c b/path.c
index d726537622..f613d8bbd1 100644
--- a/path.c
+++ b/path.c
@@ -4,7 +4,6 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "environment.h"
 #include "gettext.h"
 #include "repository.h"
 #include "strbuf.h"
-- 
2.53.0

