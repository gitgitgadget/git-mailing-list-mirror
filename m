Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAE126C05
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505162; cv=none; b=sbMMEeFPAVy/EiVGpSdGVvB4Tu+hkcMQJ9tHqgA9PO0NrkausHPT+4Z+3hP0GwIHQT3rOe/Jrjx7Immlj2s6JtFTshDCrBMmsjCIFECjANzuPlgF2Nrf+H9rUnXvrUZtAD9XNr86N92LhVso5L8orKsLivdBoiH3cMsVv5KnFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505162; c=relaxed/simple;
	bh=ZCjNGJhXmiqnzd2L1GKApvpyyBY995QQZS9WVHzVOOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4M+p+L9Gnit1eBc5czbeBmS1EzXydVFxDirEmUnmvoz41HItwA/S7JxZeK461zX4dBWB98JRtYyo9rUkp9fwGXSfg6E49cfyegTQvieXDBf9f9kdn+SnVU4Mjjqv4hiB3afXuuiHSWObPECdj7mOL/wPIiwI2UFe3cSROy0wSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krmlqyRg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krmlqyRg"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d603acc23so29163137b3.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 18:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758505160; x=1759109960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7YRrTiQhTc7FEFlW0zxreJ510IqVyNe6b+yd+4WU5c=;
        b=krmlqyRgc2Yc7NMIVC0fuH8zMwxSHpr9mcfzqgvU3BWXgTagYum8L0iUzsSLUM5k5l
         svdiQGoFl6x+2ErPPzL3W/lx+9GtvZpwn5FvPjxSxNAPjmhcMuw95zq4jYJg+nVPp5ch
         s9to2tSA+0I0YUyRpj1+F2Ql+dy/GEqEGAGJnjX+u3KhVHq4RploizI47UQ4fx3iDq2M
         Vct5XIDTmVU697Szg5BZgZ40CDqFZZ1Bh45HjHReDJhTtW7lKwkPd+FfP3fNV2mG87/N
         YrgqezS7lawZcHFGGUcc0A7ttCd67vHgTSQY7xqqY4q1VFnxp93/fA59PK9KoK8tFkNq
         9iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758505160; x=1759109960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7YRrTiQhTc7FEFlW0zxreJ510IqVyNe6b+yd+4WU5c=;
        b=CDK0gbGFkHmVo67KnZeASc1ZXn5P5zQ0g1kKXm2S9ee0TmE9AaqAB1cjqvdbS2Z0OJ
         H1EC/bZTYHL7YOldSrFi8ekv5xFPrxgpVPJDoprOMvN6LMNaKMugfGURwD/udfEi4wRW
         CIlthMrc7PkODFKXY8E49ZDhdSQfdw+tg2W+SaUpQiYqKjWwh2csREtm8FhFJGL0BHzv
         YF4IYK91z84GNJMEQ8J9h9bpblvpbIam8a5LzspgmOgAgkfw7g1xMnTGujGcYUHixZm8
         sN5nJ6RayiBiqGWYC4o8IWSrhKWUiBsfOB4pH/pqlshi3UtBs5MTl8vsz2OX+1t9kgTV
         NeoA==
X-Gm-Message-State: AOJu0Yzw/z/raCIQtRtLFDHkAPY0v1ddlgqz7F6tfCIJaN9l2CW7iKdZ
	t8StWbi5I8b+HnddJ4oTmLAY/SGxgQkW4dLv6Fr21nPl9hBMzYRhFsY95BTzJA==
X-Gm-Gg: ASbGncukgX639QkKWRCvKqXqzYFM5qaIQb+miXnCvZqUeGvaAjDnX4ULqZXD5LzVQsY
	KzFuYuQNhNJe+1OIkN0lZ1m4OjKUoYucryXd91yHpPlBoVQq5zqpaj/n3Sm0ICosDm4kLOlMW/K
	uO3pvmqMk3oTeCFy56m8hPnpdiCfcHkTuMUIIeG/wZGh72725KSF7vSWzY+PZ9NMbKLWr5ovql9
	jcmeufTHVQ5Qjd4M+25mFIWy4xttyIdgLir1/oU8t4VR+Bhpw+OyDmnNlKlF/b0fjFPCYSnUktu
	JVU7ex97eVPUGo1VyLmLmJNCRNgps/lQc83l5fc5toaRn+4VJkTgxafPeoHye8Edp6Kh16GselN
	btGCtHWNF4DdGwv3oG4WuzqsExuzi5QhRZn3BPMJcvVHEWxYWO69VbvTVvCDzQLlafWHaYX4hRx
	Qp27rlqhUgO3gu
X-Google-Smtp-Source: AGHT+IGbWT+UPIhyGnHqYI7NEdInMlQRJPwzB8pmgOeIY1o6aTARDVUDpQV/4WCwaMVHfKtJbH49vQ==
X-Received: by 2002:a05:690c:c92:b0:724:2cad:8df0 with SMTP id 00721157ae682-73d3a52b212mr92082227b3.29.1758505159623;
        Sun, 21 Sep 2025 18:39:19 -0700 (PDT)
Received: from localhost.localdomain (69-77-149-20.skybest.com. [69.77.149.20])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcd05dd7sm3942069d50.7.2025.09.21.18.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 18:39:19 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/4] t3903: reduce dependencies on previous tests
Date: Sun, 21 Sep 2025 21:39:03 -0400
Message-ID: <1328eb8eac65ec7bbf1f3cb257d7221a372c45c3.1758505011.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758505011.git.ben.knoble+github@gmail.com>
References: <cover.1757982870.git.ben.knoble+github@gmail.com> <cover.1758505011.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skipping previous tests to work through only failing tests with
arguments like --run=4,122- causes some tests to fail because subdir
doesn't exist yet (it is created by a previous test; typically
"unstashing in a subdirectory"). Create it on demand for tests that need
it, but don't fail (-p) if the directory already exists.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t3903-stash.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4..b8936a653b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -895,6 +895,7 @@ setup_stash()
 
 test_expect_success 'apply: show same status as git status (relative to ./)' '
 	git stash clear &&
+	mkdir -p subdir &&
 	echo 1 >subdir/subfile1 &&
 	echo 2 >subdir/subfile2 &&
 	git add subdir/subfile1 &&
@@ -1327,6 +1328,7 @@ setup_stash()
 
 test_expect_success 'stash -- <subdir> leaves untracked files in subdir intact' '
 	git reset &&
+	mkdir -p subdir &&
 	>subdir/untracked &&
 	>subdir/tracked1 &&
 	>subdir/tracked2 &&
@@ -1343,6 +1345,7 @@ setup_stash()
 
 test_expect_success 'stash -- <subdir> works with binary files' '
 	git reset &&
+	mkdir -p subdir &&
 	>subdir/untracked &&
 	>subdir/tracked &&
 	cp "$TEST_DIRECTORY"/test-binary-1.png subdir/tracked-binary &&
-- 
2.48.1

