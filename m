Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B572239570
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842071; cv=none; b=bJAo9M0u7XBRNUUv73Nqt8g4w4N60sXXYzxdHeiYqtq7sgHwDNBPTURJsiYMIciXKvYvm9/Eidq1M6uN5qekVq37dM2Q9z7ZV+xmnbBAlD7533rwNl/+MO/GqBGqPf3QkoMYlec7X7QTXQl4kBqqopRGg1SGoF5vIKM9P3h+OgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842071; c=relaxed/simple;
	bh=MxRnaWQepURwCMv/hlZTYA5hpsLIukj77cJW256BKnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1mt7yFtNRC6iDv9ytUrQlsGO5tfTEndChRlBFkKratxNXpqHu3GGmwt1ArRVZ+sWn42EOypt75ml2qAPISNEq/OP9w4r36GeUwBwn4iSvoa7q7AccUkfGsOJN95QTiYGzU0fRD0GE3LJjUb4Ch98LTO+v+rravqrE66qh+NNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8pDfp5S; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8pDfp5S"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f39438187so2421472b3a.2
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 09:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768842069; x=1769446869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OtOoU2t85N1EvVkarqCLIHAq/KghqEKoDzfVkEH9Q8=;
        b=T8pDfp5SKCnImS/qsi8wLGME0Y5bT/dJzGz4QQv5VzeGLAQEz6COVTU/Hq+0TCu4xp
         +LfMbQNB9M4QB9RnYjuxAQlI1yB6uo8Mlge1FACXVDXm7XhlSUGv1kfzPyP/av4ghzKH
         g/7OfQ1HGhMq1t6vVBafPww1laVH0ovCs68nuEM/AOYUeYqWb/cDTf4M4r90MogqHwHj
         rFbgKO/9tCXz5wgQ0vAQTSbQm+XFyQPeSnApewXAdcXFoiLRt89yNzIUUtEv7GT7EWiN
         VM17FFargMDht0s33zqijNdpT86MbP5mGxkt7yhHwlxi6AH+icDNb3Hqino1EUB/MPM7
         qt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842069; x=1769446869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OtOoU2t85N1EvVkarqCLIHAq/KghqEKoDzfVkEH9Q8=;
        b=EtxCmZR0TnQHI/I3nB3557qaZut50hDaRoWhbDLeEqOPaknMyJOUZMMyJNndJDdGgg
         oWMwqdFEvOamQG/m3QdAN5/ILAqChVbU0lWvRx5JD+9RQ4hiUpkkS9zzkmaIG9bv/qwm
         Dm+ezPrBqQRMtO7lVgIcHS9DC4LFfChuUGDAALgyEAYO4t4qE6O+NkbPc4IYjshaAZid
         ZcOxYSVQ2fTtyyvqKux5MrdlC1YNxcexje/qbJ/HcjFNgaSRGeBDuS2AdZuV6dgGfYnY
         2iB48cmC7/gpxi8DcvUiIrlaLzYZoDt47afDMxQUDJceZ5hpa66KKShj2rhTOWWjHeId
         6dkg==
X-Gm-Message-State: AOJu0YzpOd6owmqIw9nU6RzCz27ZpMm1QS3DhadZwIwIqyXXNNPq/b87
	kAc2hakSS8u/iyNEtDoDBA23yQO/M4wxID9PKYhoohatiAPqJt8p4rECYsDc9g==
X-Gm-Gg: AY/fxX4R7IKiQn6xZgXvEZfwp8qQZi7XLp3INktxdMc81ImfrJKUYL7+nuUb0zlr/Pj
	IW7qodVXkGpNg151Ei+u2idPAhIpNMEWHbBQ8eVQwTryFBGUHM2osUrGD+xcyJeDkzCuKJO+KHo
	gTNnym7dMI37AA4Git5hN0MlUY95vlLjofaMoLdtOyarjvE+sm6R79iPOpYp5KcJ/PbXJa18Pwj
	J07J/1KGoG1pRp0j2rPJ4DWKndERqsbCLu2e37/uAI1XkFpytqGoi8RykdV9q/iUySsmhaUEUAT
	u8EvSmBp1fMdZ6Mn1ziPLKiszBatoTDk/WqbQKOfjTER9/oYy6XqSIUHQiJPHWYL3VGGZyQKGKo
	G7YBX0yUJ3dp8M7Fg23wUBqxYuOcXc/QWCJZnFey6cK2WLM5ILt/UfUsurWN3ZVh+FZeYfFk2Hp
	N/HXdxQN5v68AFPCbZmKAEdTyBWHrwJXSO
X-Received: by 2002:a05:6a20:2d08:b0:38d:fe2a:4b11 with SMTP id adf61e73a8af0-38dfe71d9c7mr12028242637.46.1768842068859;
        Mon, 19 Jan 2026 09:01:08 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf24dd20sm9858229a12.14.2026.01.19.09.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:01:07 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] t1091: cone mode list deduplicates and normalizes paths
Date: Mon, 19 Jan 2026 16:57:26 +0000
Message-ID: <20260119165724.7339-3-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that git sparse-checkout list in cone mode collapses
semantically identical paths (e.g. "folder1", "folder1/",
and "./folder1") into a single canonical entry.

This protects user-visible behavior across different ways
of specifying sparse-checkout patterns.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b2da4feaef..d4ed215aa5 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -321,6 +321,21 @@ test_expect_success 'cone mode: list' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cone mode: list deduplicates and normalizes paths' '
+	git -C repo sparse-checkout disable &&
+	rm -f repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout init --cone &&
+
+	printf "folder1\nfolder1/\n./folder1\n" |
+		git -C repo sparse-checkout set --stdin &&
+
+	git -C repo sparse-checkout list >actual &&
+	cat >expect <<-\EOF &&
+	folder1
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'cone mode: set with nested folders' '
 	git -C repo sparse-checkout set deep deep/deeper1/deepest 2>err &&
 	test_line_count = 0 err &&
-- 
2.43.0

