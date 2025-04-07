Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7E23BF99
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024718; cv=none; b=utBbn8YE1xbghBu3DA/FYH00WMbiUKju1wcIlLUNxLFKuCkyGtZcIFUmZeuDlOhe3lrFIonJhJzPYjwMoxBdUmXw7xvTVbudFHw7KCusyPfC37Dipr2VUVq1XbfItk50P9dsk4SNAGb/bWlPwQ3cbNShuNT+yHj+VWFbSUZy3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024718; c=relaxed/simple;
	bh=ifMuZG9Iz71h4ItnLnz3UIGQy1c4doz7EYuPldJjPaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWJABb4ZMDPKqgE4jnSk6i/JI9nExY4qD8Zysk8aQ2PW7zMO/3p0MOzlYwTBnY9dbk4QsA6pxI8WATDj+uu96PzW0QistxaWvGAChzLFfNUlpxW81+0kXmuEwrhlwd/2zdPXlSz4gSNCQe/0hRzLLQ+RcOdetOXerSabStHf0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG/jiOp/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG/jiOp/"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2760569a12.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024715; x=1744629515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4fLZ22f7JoRp4VTn7PF6r/KMIOlDWHlEUpf6u8IrmU=;
        b=kG/jiOp/ZFftUpcl3O2aejjZycoho0SmdITMpqcRtM3Y9Pr2bR4bWWRGjgTHzO51Hu
         EZU0Jt+b9U3cRl4EoVbh+n7eTWTk1jpU9S2f+8J5964tKfaCky9abWBW8gD08P4zPhJP
         H9zBsXjipIGTawm31nt68T3TIrjCet5Yib+Y+qGUpBlA0T5VBYzSdtv9f0Taj8SeUZIF
         JqX8krT7Ov7Jp9xVGvy7JJQi89xkLxBERdjwFwXmZ64st9AchpWLyp5lpj7kX1etJig/
         w5xS7Uldn0JIV2XprYnKH197ZyGDiKNiuX+xPHrq4G2E1qgWxR//GH9fSgt80btXqUMd
         SthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024715; x=1744629515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4fLZ22f7JoRp4VTn7PF6r/KMIOlDWHlEUpf6u8IrmU=;
        b=u3DWBDhkVyq3MlNNut9x5G2ZPWhyDASvs2zZ26SoeaFHeXuc6yw0TfHUHhzs8RfbmW
         jLnCxhU2Eg4aI94mgXwVcatdCgz4T+MrvwkXFsKcM6N0O0vtD7ebKUbAEITN42JjVG7j
         2+0y7tlvNh6Pegjt2pLTnF58HPqzug8JsH1laVAbP5BqX8maTTwJvu/NpGuOD9Dt1LS8
         bv6ueoRNCoIInZnYwBcAUv9BJkrK42neXHSiMxupK2IgwuNP1dMjXsWZHf9IIqS6Kf3x
         qqwNJ3Xa0njGQ1KyDw5JSKsO1Qfrgnu5HYgnzL8dFGIdQ3ZPG/ZMW0XizbUxgCiCawUd
         ir1A==
X-Gm-Message-State: AOJu0YwUsg7batVleE5ebW9HWA2u5S9CuX6w6sKgsbD2yX8L0Hzb0h/C
	FJaysg2WlPN0es3IOxuZdxIpNaJ379U1jjpSmTQZRNt4gmiiokI=
X-Gm-Gg: ASbGncsETTKJsxQry9UCL28GGAwNJwON+REgpL+3ptKmlBcxpIAvFdNtYXy5K/WHs3h
	WCStDg9DAc4QyyaarzICgJFQjlhnIt0HuslESAA02y6XwaXYTX7EiWArAtqXJNDlVuVqbny8VxI
	/Ob8YhH4UXwaXJeJO7cbAIVMvbFYQAj8iggaYeyYg5W0gPcXmF4GoalPCzIlBWp08riLO6iCINa
	xlxgT2sGonAWatk+JmL8tLgAxzQPmSHz/HQwxMZI8E6euvgvOrodpXejZKlEeKMT0cPtK3Jq0Es
	188aGEBaHV1NN0kob3S1dCJ36uicAUKx5acjTsxcnS4OYG6UX7di1cdJdBghXZ62IF/wEzSbwsQ
	F5OjjuCoPOcBcDrdbsMRtR92jPJSVpIUOdEnyYUU87cOd4dPpV7oF/VfKvdMoLJm8nGSBGP6/Kc
	4b74z7gLOOhAGnmmklu1iO/W8=
X-Google-Smtp-Source: AGHT+IGtj3n5kdIplWUid/4PZd4VdMjsN7RjTy3TpXNXHtlY2nAH9tAtT6vDPy1RszZcgTgufT6HUw==
X-Received: by 2002:a05:6402:5204:b0:5e0:8840:5032 with SMTP id 4fb4d7f45d1cf-5f08412c8d4mr12703783a12.3.1744024714773;
        Mon, 07 Apr 2025 04:18:34 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088084f17sm6613826a12.61.2025.04.07.04.18.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 04:18:34 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Anthony Wang <anthonywang03@icloud.com>,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [PATCH v2 3/3] t9811: Change `grep` to `test_grep` for debug output
Date: Mon,  7 Apr 2025 13:18:24 +0200
Message-Id: <20250407111824.46518-4-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250407111824.46518-1-anthonywang03@icloud.com>
References: <Z_OEAxJENE_mGkVa@pks.im>
 <20250407111824.46518-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change `grep` to `test_grep` to provide helpful debug
output in case of test failure by printing contents of the non-matching file.

Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index e69dae55dc..e9c2aad2aa 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -96,9 +96,9 @@ test_expect_success 'two labels on the same changelist' '
 		git p4 sync --import-labels &&
 
 		git tag >output &&
-		grep TAG_F1 output &&
-		grep TAG_F1_1 output &&
-		grep TAG_F1_2 output &&
+		test_grep TAG_F1 output &&
+		test_grep TAG_F1_1 output &&
+		test_grep TAG_F1_2 output &&
 
 		cd main &&
 
-- 
2.39.5 (Apple Git-154)

