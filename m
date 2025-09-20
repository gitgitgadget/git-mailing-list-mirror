Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0342882A9
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758393640; cv=none; b=vBf0vAmh3U8UHUW3Q1DrIMqCtXzo8/DT5TYBE+gXjgrBDaMQxCE0jzUF41XsgwrRer9Z8XMvEGyRneH92rp/k8+d+TMz9q/YIwLrYe7zYzqERs8nz5+di403gxfKrapY1WcNACifhsC/J7yEGHeM5LQJNPtuRAr65B4SVtc5kuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758393640; c=relaxed/simple;
	bh=zGiUlmTnzJYh9ovXSoxMrF5uGhrnEU3gA2ikVZK4mCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTEVMVAcRaouucJo84scd+VtcpIo5OlK1MPdS8OZA74mRta9GFnZlHz3/1TDS3FPnE5B8FXRQABgOj6M+MjXkEHph+9+GICoTdHiOdH+8llCuMSXbhI/YOSeiM47DaNUT3R9KeCGz7Sl8TB5AxQZPCFbBN6RpnS8R9MeCCnW1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjaQ50O7; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjaQ50O7"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ea5c1e394a8so2246677276.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758393637; x=1758998437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDoJdsPXX9L/ir0fZR0tiKUZalUk5eIXIasZekYG15g=;
        b=DjaQ50O7f2GCCavhY2X9TDQn5dOg3jpUqWwMSo+NjQq0XjX4v6apDC69sBZsCUN8P3
         8c+v0TjiSFFTD0wlLwcJllkQQW6HbV4Nkz8H1NTA1iAksdm5VdRKnJUFnoF1divpHY0a
         2Ep7gsHFsBjKlavfBdzfSHwDyBqan6Ue6ZHUZho7t9RZBQiuCAwfvGt12xtf9L7XtyD8
         dqxdGpL9+Jx2MuFwUrCn1xAO8wUSd8pTmLqnpF4JU49gREIzqDcyMH/sbKLPDjnMw53m
         bOkW2V55e98GrovGbcMX7uAcZz4OElX3Lb1s5/FhNkIksaJjr7GKA2VHr24v0YhWCfhI
         StwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758393637; x=1758998437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDoJdsPXX9L/ir0fZR0tiKUZalUk5eIXIasZekYG15g=;
        b=dtUKUz5RjpC4mzRMXgIbDvboLqRc2NHp8AZ/aBNZTen8zxgCfL1Qoma3UQx+InjPRK
         Hi/JSmMvhZAT08qGuTAQPAVe+SmwwzCOoxSPPbrxUGbUGYA2BfJOF2V2Z2E0LzAspwDg
         l3LvHMaBg+p5gu+G6Dxqqp2lg2xBKIwQ1J88TeT5Di/gvY7mpXHSns4TeoWEDskJnEyL
         BcLPJwL1WX+dun+Rcnpyayt+Mak4MDtejpPKtfrfHFWJrkTSsXSdAsD6u+Bxyr1oZimX
         YP0F0DKzDx1idcRjHOyLaHKnanaQvtUwvYlLUMFGJeGatFH37v77HIXra68lIcqRZ6+V
         poOQ==
X-Gm-Message-State: AOJu0YxVDJoI6cMEHV4Xqw2Q1feAQ4HEwkxQb17Lg+P93eP7NdFSu9hX
	n2MoXbSsjIP6s1DmfpNS25Ad/NjFpQINGun0NExc8OmB+T0a259y49ScQINCMiLj
X-Gm-Gg: ASbGncu9nvJb6Cm6qSNJMI3g5dJJ3gLjdQpTr0kriA6/Af+ue6fjximYU+jsMQQdmCM
	xBXgx/flM6rL+EovL3EYbyHDQadTr0Zgi6DPjsm8F8NO8ewfMYH4PThOtVRFD6ld5v0cpqL04Up
	b7yi9qV+7vzCqWli9owm3HF/61dGGNqRtPJSzWO/ZGCdmGumJiyq+U33Szvt8C/7BvZtPA1C/7N
	EFwcFr0lAIZYf/0gI/vKcwdgjTqgPNNg50utbF6Nim7G0tZYcPThXT78cy38fwSNGjU1ItF8kyx
	XKxUoxP2nDSatJeh2QUVb0wOMBZuk/SQD7cGB3jGelat/vxlgU6hWmoC/zK4DtKNDCBoroKNo22
	mpnrLbIGKs+inYJin1sUeGZ8GDBKxKXf7YfO7GXayXUWiD0VU2Wv35nRbHe02a85LGg8zZ2oe30
	DXyL1P5kyBDVjbXZ539NalmEU7F3nTpLE=
X-Google-Smtp-Source: AGHT+IGguVzQb7OkrLAYmm5R+pVQNm51gedB3TeLhoLu/6JyjeTrvDDGbTZ57nv3znEGcuEHxdC3bA==
X-Received: by 2002:a05:690e:1915:b0:633:a536:5866 with SMTP id 956f58d0204a3-6347f5bb4b3mr6072975d50.27.1758393636840;
        Sat, 20 Sep 2025 11:40:36 -0700 (PDT)
Received: from USROMMRAPPAZZ01.infor.com (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7397188c02asm22814067b3.49.2025.09.20.11.40.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Sep 2025 11:40:36 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 1/2] gitk: fix the position of the main main window on initialize
Date: Sat, 20 Sep 2025 14:40:06 -0400
Message-ID: <20250920184007.26183-2-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920184007.26183-1-rappazzo@gmail.com>
References: <20250920184007.26183-1-rappazzo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main window geometry was only restoring size but not position.
Use after idle to ensure proper timing on OS's where that is necessary.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitk b/gitk
index 6e4d71d585..95469a8fae 100755
--- a/gitk
+++ b/gitk
@@ -2775,6 +2775,8 @@ proc makewindow {} {
             }
             wm geometry . "${w}x$h"
         }
+        # Restore full geometry including position after window is mapped
+        after idle [list wm geometry . $geometry(main)]
     }
 
     if {[info exists geometry(state)] && $geometry(state) eq "zoomed"} {
-- 
2.51.0

