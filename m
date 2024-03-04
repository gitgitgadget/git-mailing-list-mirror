Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7E20DC5
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546104; cv=none; b=BXX5LXtwyWO0wy/jdsTV/yc7xV4qHsosaaiZgjVYSOiTBw2k8gquCLNN/HXeW561OxU141I+sqqXsEDcISxmlZgAUaxMN77Km9+KpbkhfH/BYYg1mbS2oaNF//HHTFUIubEEM7V+Nbe4DzBEVEon06ZbpPuUhPb+NrlTBgHXl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546104; c=relaxed/simple;
	bh=i+zxOv/e7ORjyxixj//tiPW1TMzhyzIOb0fx29oQKt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyEYj1d5qiG75CXIgIr5VChA84HsuO297fzGvQmkH+NFbFMODkR6FbAUzIDM8ek1qBzdA4N3CKb6YrUF1goWFev9Yci2htX3yRn4SB5TI1Njml9tL1huyUpCBHnGMdIhs7/zm+om8YxoHGh4gwQ48KgGn/EW05AQJ/ZvQVLoqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFXtpdUO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFXtpdUO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dcab44747bso34260175ad.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 01:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709546101; x=1710150901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VN/xkqD7FttQTDFpEW6ZavuT6AHlTUHM/Tg1j0HpU8=;
        b=iFXtpdUOVCjf6V4NsFKsVbglPk8Px+Bg2k/hddVodshQRA8hxk/qDQTpxfEsVcTKmv
         xF6W0gFzm/D42Ng7JjrjEFf9cPeLHy0+iK5sseIlZtZzGxq5frq1qN/fMOowyttkBOfF
         mEQcMiLJX315wxSgIub4RACMG//heEozbylKQT4RB/+sYfXxRPfXA2Cnalhkb3uBagkx
         4cptNCDE8mspHzNOwGe/dLWCIQY9RP0640CQIdnobwECPVZIk2zpRxWfxTJ6ByhdvPIV
         b+rgEqaVR/CHnXWwwiUY3f+NZAzOCBLPYx24kVxhbwrv3T93wRFLIn+1brsHklH5xkkP
         Ju/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709546101; x=1710150901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VN/xkqD7FttQTDFpEW6ZavuT6AHlTUHM/Tg1j0HpU8=;
        b=m/4q1uBEx5xhxFvC0RbwTk3X81roBmAQ1e9ipHuJZrpY3gpBnLOyqoTETNWVQqNq/K
         O/eNEnrsborcUPYR9ZO70drTu0WAyVwQ2IufwgY0/nFriipdxaL0vDv6MXOSKV3U5o8k
         6h5ernmqURM/hRtzGOZrQoC2A8C+2Vo1IGgsvPxZ7jBfIkcsk34vfK+57lg/x5vAaJTk
         FFwXfYYGPdaGnZmGolWYWjt7g+/A4nBwPHIzJQyEzpk1VXjEmHZBYn89jCcPPL0j2pm1
         csyjg8rwR9XFd3Y0EE3lSCQVCZqSN7wOxc7PWXYLEvRg8zTfxJBdTbR8DZS6FxngHzhO
         waeA==
X-Gm-Message-State: AOJu0YxQLSI6nqGC5p8q8pDbLipNT38RyBu/kn+uB7Rk8KUEMqLpqWZI
	LkJaF9SzhwH0rCIyf6Q6JQQ92ZRfYXDKEr71AH0tEV5XM+kwKAFUPJkqDdHsgSDB6A==
X-Google-Smtp-Source: AGHT+IGVfBS7kNttffiQrB0mA18NvIH/2dOaiWDwkuGqiz3ZJrhdtCeVy6jR33ECXbQqIFuWGj31HQ==
X-Received: by 2002:a17:902:bb8c:b0:1dc:7923:a9e5 with SMTP id m12-20020a170902bb8c00b001dc7923a9e5mr6690746pls.39.1709546101388;
        Mon, 04 Mar 2024 01:55:01 -0800 (PST)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001db9fa23407sm8094022plk.195.2024.03.04.01.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:55:01 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	shejialuo <shejialuo@gmail.com>
Subject: [PATCH v4 1/1] [PATCH] t9117: prefer test_path_* helper functions
Date: Mon,  4 Mar 2024 17:54:36 +0800
Message-ID: <20240304095436.56399-2-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304095436.56399-1-shejialuo@gmail.com>
References: <20240301130334.135773-1-shejialuo@gmail.com>
 <20240304095436.56399-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -(e|d) does not provide a nice error message when we hit test
failures, so use test_path_exists, test_path_is_dir instead.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/t9117-git-svn-init-clone.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index 62de819a44..3b038c338f 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -17,32 +17,32 @@ test_expect_success 'setup svnrepo' '
 test_expect_success 'basic clone' '
 	test ! -d trunk &&
 	git svn clone "$svnrepo"/project/trunk &&
-	test -d trunk/.git/svn &&
-	test -e trunk/foo &&
+	test_path_is_dir trunk/.git/svn &&
+	test_path_exists trunk/foo &&
 	rm -rf trunk
 	'
 
 test_expect_success 'clone to target directory' '
 	test ! -d target &&
 	git svn clone "$svnrepo"/project/trunk target &&
-	test -d target/.git/svn &&
-	test -e target/foo &&
+	test_path_is_dir target/.git/svn &&
+	test_path_exists target/foo &&
 	rm -rf target
 	'
 
 test_expect_success 'clone with --stdlayout' '
 	test ! -d project &&
 	git svn clone -s "$svnrepo"/project &&
-	test -d project/.git/svn &&
-	test -e project/foo &&
+	test_path_is_dir project/.git/svn &&
+	test_path_exists project/foo &&
 	rm -rf project
 	'
 
 test_expect_success 'clone to target directory with --stdlayout' '
 	test ! -d target &&
 	git svn clone -s "$svnrepo"/project target &&
-	test -d target/.git/svn &&
-	test -e target/foo &&
+	test_path_is_dir target/.git/svn &&
+	test_path_exists target/foo &&
 	rm -rf target
 	'
 
-- 
2.44.0

