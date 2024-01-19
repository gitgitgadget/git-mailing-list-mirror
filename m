Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B355E66
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695546; cv=none; b=ZXedNu2rIiwAjHjaI0bfZTVpaZb33AOP4Mk6t3H2FQGE0k9YNl1oPK1tUixJ3ITsjFQW3DjMXpbEVZiCzqHF2p2M25liDmeCl+/AountkXa3XwtvE0wkT6hqne59SqaTX1IqNOZByzEin8W3Jb06aERT/B4bUkJlMULyL7loh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695546; c=relaxed/simple;
	bh=XLaRIGfRIT+lsUqMekTNbLXNJHOwyY+Om+SqIbNbJnA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VnG884M111ZL1kyPkZsjwlhbFV3Cl06I6ufTOe5HF3Zux9duPiPzhaS3aL8cyAvoCfMR+6ucyLawreXc3alomS8f7iv1zhuRKhsoM6Oow9Sh8Wu2Te6WC9q83OtoxMVejasFVQUlj05/7pt3g/kQQRzDac2xmyE9kVnkXWmrAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keSgFah6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keSgFah6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so12491975e9.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695542; x=1706300342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHVnONCg9pxZuuWVW5p2OykS2DQHRcqKQTpknldftx0=;
        b=keSgFah6w1BDgxnuUkNnl3QXxRgCk9dZ7c3s/lmfyzo/gyUlaHZUkDsv/LBMF/ilnt
         mWWqscayYYvPu/Xr8fWmLQBesKPa+AVv/OaKW4sXUj9n2lGCq4ddx+uzyUWfjO1JGgHY
         uulsPUCjaHYoLM5WcWlzLg1ZO3oKvcDE2ImhrneS+m3YM0FqqMOQQmewK1pVO0rrxucQ
         T5nTIUCnkImI/XiKT2qn0+y2hOSWCuVJF7k11xEvL6yR3rGAN9ay5VKuREUM2ry93jz1
         O6jqMDldkp7Hvr3723EnMKZZe1ILEKHWqQbPJxhv75rnZiq0g+GAXrWpwAIL1nWt27cI
         I+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695542; x=1706300342;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHVnONCg9pxZuuWVW5p2OykS2DQHRcqKQTpknldftx0=;
        b=T+jccxS1If5ZwCNGSqM9A7J+6DYOC5MGZ5r7JSovFQnMOY35WRPYr7cbv9HCd20AG5
         1U/tVU+SjsAq7xaRpuqTIPkkvBbPIWT/aN0AOwvxVfXUjSTBHS29KD5h/ciuQCyWqiFJ
         YQqTYWiOlXY8tFHVOyGA6VAkBFsiY4wytWKbbVl5N82jP2lueiQ0vLKoZ72uvvfz/tTM
         I0VFGhxevcnfL4cDOHM+uNZGd2Z51cPeISVNnnQuhWuQd6zBW4w2Fa9Qv/tDFBpcbMlO
         QpIGU8EBzrgwe01AXelpv7uUfhWafiTWVFWhGrq6xpNY1I/+pZSLIykKQ+YZlmV/tYcr
         llXQ==
X-Gm-Message-State: AOJu0YzrIufWXmwtPdsiwIvxhplrUsc6oON5AVFl4TPVeRJPMkpZHDR9
	XumDpPVJguTQyyv60It/AzOJfGdJhl8B1K+2uYjNix5OAg8O3E8alqnjYXfZ
X-Google-Smtp-Source: AGHT+IEEaxWe9ZUI8YbDjWc8vuwpAbOImr3vhFiqjUbDfdpjLHk1Q9YCfasKBrbR+FB4nF62akGtzw==
X-Received: by 2002:a05:600c:4510:b0:40e:80be:c9dd with SMTP id t16-20020a05600c451000b0040e80bec9ddmr174689wmo.98.1705695542267;
        Fri, 19 Jan 2024 12:19:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b0040e88fbe051sm10080451wmo.48.2024.01.19.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:02 -0800 (PST)
Message-ID: <ca65b9e6122d10a7b43d06a6069dae00e645a392.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:49 +0000
Subject: [PATCH v2 01/12] t3210: move to t0601
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move t3210 to t0601, since these tests are reffiles specific in that
they modify loose refs manually. This is part of the effort to
categorize these tests together based on the ref backend they test. When
we upstream the reftable backend, we can add more tests to t06xx. This
way, all tests that test specific ref backend behavior will be grouped
together.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/{t3210-pack-refs.sh => t0601-reffiles-pack-refs.sh} | 6 ++++++
 1 file changed, 6 insertions(+)
 rename t/{t3210-pack-refs.sh => t0601-reffiles-pack-refs.sh} (98%)

diff --git a/t/t3210-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
similarity index 98%
rename from t/t3210-pack-refs.sh
rename to t/t0601-reffiles-pack-refs.sh
index 7f4e98db7db..f7a3f693901 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -15,6 +15,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+if ! test_have_prereq REFFILES
+	then
+		skip_all='skipping reffiles specific tests'
+		test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
-- 
gitgitgadget

