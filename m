Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83803217663
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046717; cv=none; b=elKRheIwSthWCTX0VwOs4l2bIoq18GgHD2qxQI9fUZbuoVNbGB5L51gSfwq3KjbD6+v81wz47JvUkOH/W0usnGwodZF/qc+jgN1HDbXXGtt/b1kbdbERC/6JImU7vWMj9/lZ2SOvwhgyhQfh5b0Gc7UMjsCsJALimBisVPEHs/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046717; c=relaxed/simple;
	bh=zO5NuZSc/5QKpxw6nkSer/VUV479W1c6DWz3JVxWGqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXfu2dolBiZvlNMHiAij4t68tLCYHckQ7t5sMm6v0wICvYg9Hcbgk0tDA4ravwpmj9kGBQfpCJDF5DhhvYecSsh18wLZe5okKJNI47hKdsuIUYmciphaU01dTD5GgR+Dx9TV3/C3ybT+8OxURJGvjIXTR2TBGJPFwKyJiL0KTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3s0M6hq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3s0M6hq"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso836375866b.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046714; x=1744651514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfdsbpsPxMG7xSh58eXa9dD3duB+SHJ9c8UsSQ3GTJk=;
        b=N3s0M6hq+CVUsmynPCGxCcrK6xfzHq5XZjyR1l0OJ/QdMzhq0G9fjoWSPwI8+HTHW6
         aK2NNpL2HQ5S4xgbkel4hDxvwufsIsewDhTqxXIAze6KbcAwwPGnndaLOsvwCKKhLTwt
         p+chH+U5MRq7Ua6P6QmmnSsynPmmPhxnzXJRZaZ5rGNBie/azB+vMVSbNJ25YpnDxpKu
         bqtjfcAMo/g2ZG8vG8apLyqaPnHfosgGFG8UDgz6wfnlJ5Locqg6qDaskwyv3liRbMzb
         oEicReYH92Z0HeviTGvLZLLamYcLUULgbARjO2euwsom0V0ek4VElDZAB1O1XlaUjBeo
         4Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046714; x=1744651514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfdsbpsPxMG7xSh58eXa9dD3duB+SHJ9c8UsSQ3GTJk=;
        b=UZm6zdYjUgmbFicOY/Ty70a6rcGokA7t36qqJwIgxC/ZIm2esFzGbKzJt+YuKQookl
         T7qMGtpwEKjjvvA0xkl+zxSeRr57GCJ2Iyt5HKhX2IyDRj2nKf8Qi5ZA/vFzwtWxmCO3
         YXOp4xmC4vtDsHIWiRtC7QmV+xgiGSC2QlmxuSz4Rltb0vc+obEa3YLDaj5bVMEYiWg1
         IyCf0boe0cDPWv0iFmAI0MSIe8IM4JALDvYGdewQ3VLHJsmpsSKPcVY7zc/G4SmeBYWp
         KUZHuL1SB6YgtK6BOXYSgE8NR8UNGUXXxAK70/fGV2JuB1zA7EsHriQycOuZ+h3D0RIS
         Whww==
X-Gm-Message-State: AOJu0YwvVp36LKJKxkT9u6xf3tvIkd17u2HQUTlwROckeg9t5qS4OaTe
	VrP/8Dq5NjIml5NcZ+Q+wTHmlGoqPoZU1yhgI3kaZTlPg28wgDY=
X-Gm-Gg: ASbGncsNZCnCVc439y5mzq+WnSBULyjumf9MctiKVUBrR7vq8jAmEplxqUs8yMCChzo
	qG0OjNKHuh48C97yqJNwvLdPwYQqHjanbQugt//0cEKAEzBrDKerinfzS3iSasSCAZjPxul8/FD
	rkunB+RPBsTq7/E/eQF8DLCFi7XpjlGSm2nlrG+RR0K8mEN9DIEMRpZsqg7AnHuhwzxJClndJmt
	8xg8Zd1Tk2gC17/vskL6gMmti9VCdTluDnM3uv2/l292u7bTmNyiou5pMRLsklKTvZBY1i3e+oT
	allH/yWPijJ/ddsvV0cn8CYQEyVpgSTlR9hSXSkaFKQ5i8MJSdQT/5VI004whTzmdqEzsgD6CxV
	Crq/GVBEZNUSS
X-Google-Smtp-Source: AGHT+IHzDzeqz9d/yzN85rtXl9jDx/VBBjrU8eTfuDlnnkNYnphr2c+iAD77qejuUGCuoMmOQQgcwQ==
X-Received: by 2002:a17:907:7f8b:b0:ac1:ecb0:ca98 with SMTP id a640c23a62f3a-ac81a8790cdmr19543366b.26.1744046713691;
        Mon, 07 Apr 2025 10:25:13 -0700 (PDT)
Received: from localhost.localdomain (generic-nat.unisi.it. [193.205.5.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01c0fb1sm790193966b.179.2025.04.07.10.25.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 10:25:13 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	Anthony Wang <anthonywang03@icloud.com>,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [PATCH v3 2/3] t9811: Remove the -q quiet mode from some instances of grep
Date: Mon,  7 Apr 2025 19:25:03 +0200
Message-Id: <20250407172504.50849-3-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250407172504.50849-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250407172504.50849-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the `-q` quiet mode from some instances of `grep`,
as the lack of `-q` on the "TAG_F1" `grep` implies that its output is
required, when that is not the case. This change ensures consistency and
avoids confusion about whether the output of `grep` is used.

Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5abac938d0..e69dae55dc 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -97,8 +97,8 @@ test_expect_success 'two labels on the same changelist' '
 
 		git tag >output &&
 		grep TAG_F1 output &&
-		grep -q TAG_F1_1 output &&
-		grep -q TAG_F1_2 output &&
+		grep TAG_F1_1 output &&
+		grep TAG_F1_2 output &&
 
 		cd main &&
 
-- 
2.39.5 (Apple Git-154)

