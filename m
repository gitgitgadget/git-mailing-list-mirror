Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8CC1BC3C
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673865; cv=none; b=D5QxHzrxBNwPt/5dFJza+Jq8nkk/rVHFmliOIf4NqRhFaKoC//xkPrcwi1BbrOc8B7UN9Den7XG+EbcprLfd//7wyvsxO1djlbzp+smsbNoJnielrHvjIgZqSk0+ZcpzRQFg06R3z8NH141rH0RJ9Bc+NVAzHIZorZtsd+uBv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673865; c=relaxed/simple;
	bh=vcPVIFBkuU/Er/YlBULJfyzYQqqW+Udx5mz4vffEQDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbF6/qZEa7uoGdsWvPKd2HRy+gLHDA1DLf/HbLpu9Y9gBEKGBo6CBHp0P11G2WkRit8Fqg5KIIdp64DxaHWGsJ/D+ZHDpPwajnOSWe2fPvTcGNhoQr/cZo6HgXWbQGZYPvxc0H16VCDf/qH786x0oVO5MEv3ZQIs5h4v+zqRyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR2xc1fi; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR2xc1fi"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-21634338cfdso35976295ad.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 04:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738673863; x=1739278663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQgocEi/FFCZHjcH15Naj0odcFSIHlQ9I+ewE7VxIbs=;
        b=fR2xc1fiNeMPGCU/ePNhaIXI6tE0gXhzLGo0+p/vewcmNn/FEPF8s+kX7LpnSkNLfm
         JOHuDZI/TL8wUzJBSztPmagVfMQ9is4tjC84NLL0aL/un9/g4a6w5UEQbFXleT+Cwlr1
         G/xL7ii09ByvLUZ4Se/SVlYBQpiJMmHww8cWOmLOV1iaNMvZ73dr1diFipSlWld0BpTA
         uF1GdisrUagerUmppyvqSs+kzitVApMSd7vpXSBJwJgI3nbvcOUZ4NZaYvkEi3vzzFs6
         DA39+cSTFo6JmAnI3WdBqOUxzcwd2RPIlswSV1p/3wYIywx7IyTcVcVpbd8aIWwFaWaH
         OZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673863; x=1739278663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQgocEi/FFCZHjcH15Naj0odcFSIHlQ9I+ewE7VxIbs=;
        b=CoRKmamWpit8Zzpk8DsnOSVaP3gAvMwr8VZ+YUYdlX2SAorNSaLLz38mpFm33NLF6M
         29OzcKTfFFK2VLVi8mpp9jCCLU88QMoquyuQY2saG/Eu9vBNf6341mYfqbBKfw3inxAx
         tMqD8gTahg2syvf4Uz4IWMNSvtajtWOxFUhP4QPCzeajS6nvdl498HbUfWShlKMGUp/7
         by9lTJs/erFA1BrfdhabhKIoW+lUc3Vc3NdhyAgIpiWWHKyH9O0H0onBzUBHIz9e4Y9R
         J8XWgGNO1Ate8HPISOBk0vCqs30ZfsA1fLuaBDG9VnUmu9RIEXQ0/CDttz85BlrTu0dq
         2fpg==
X-Gm-Message-State: AOJu0Yx7wfqdS8CqYV613WQPVYbzrH+1I0KospbhfGxP+bkcRI7iwVjY
	bkTGkMsExWBWvsRSqAUmW4Ul1Yp90jqb24x9gxAD+uaBnljMdC/2Og8dW9NncDgBFg==
X-Gm-Gg: ASbGncvVeDY+KRQnyV0C07TEM6/k9dg+XWaLeK2UkkcACvpDbJ6qLhuRMDLA3SszdA5
	X8tC80jpb7RoHW0UkZ1EKrM1lv+u7ziKrQFWfwAAnYVMamR4uH7f9JX8DW7TeQN+GPl8iFEtaGH
	5v4norcS6J7Ru+nHZiXk3B/w0QkQHHLzlGYmW9lXsmPL2NnQUwiInJ8e9iXiVqKdggHIvVzcFe3
	Oxz0+yKO1vQQCa5CC5bJ1IcLJ8bYlfkNc6rA2oBStN2oGMLOJEeUsJWq75bVXcUghY9dSIf/RW0
	sTdWQzQ54wjwUfJ3nMPT/p8mtiCtoD9s04gam8SHlw5i7WEVERqvz74CSPEt5klotviA3SNy+zS
	T5ZhH6eo3O46tPbOMRouoUKcpY5UNLdvV8+UY
X-Google-Smtp-Source: AGHT+IEkqJZArFpuERbIbB0lbgtpx7XIWSS3PkdEB1ToA2lHH9OJ7BcVfG5Lxt8PTQBl0C4feQevBw==
X-Received: by 2002:a05:6a20:d04c:b0:1e0:f05b:e727 with SMTP id adf61e73a8af0-1ed7a48c8b9mr44391073637.2.1738673863145;
        Tue, 04 Feb 2025 04:57:43 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-16-163-105-204.ap-east-1.compute.amazonaws.com. [16.163.105.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe64267a1sm10412079b3a.40.2025.02.04.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 04:57:42 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de,
	Zejun Zhao <jelly.zhao.42@gmail.com>
Subject: [PATCH] contrib/vscode: respect configurable options of IntelliSense
Date: Tue,  4 Feb 2025 12:57:21 +0000
Message-ID: <20250204125721.11357-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initialization script of VSCode development environment uses removed configurable options of IntelliSense, e.g. C_Cpp.intelliSenseEngineFallback and therefore triggers some warnings.

Fix this by strictly respecting the latest configuration manual of VSCode IntelliSense.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 contrib/vscode/init.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index f2d61bb0e6..17f5b6161e 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -15,8 +15,7 @@ die "Could not create .vscode/"
 
 cat >.vscode/settings.json.new <<\EOF ||
 {
-    "C_Cpp.intelliSenseEngine": "Default",
-    "C_Cpp.intelliSenseEngineFallback": "Disabled",
+    "C_Cpp.intelliSenseEngine": "default",
     "[git-commit]": {
         "editor.wordWrap": "wordWrapColumn",
         "editor.wordWrapColumn": 72
@@ -203,8 +202,8 @@ cat >.vscode/settings.json.new <<\EOF ||
         "\\Wchar *\\*\\W*utfs\\W",
         "cURL's",
         "nedmalloc'ed",
-        "ntifs\\.h",
-    ],
+        "ntifs\\.h"
+    ]
 }
 EOF
 die "Could not write settings.json"

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
-- 
2.43.0

