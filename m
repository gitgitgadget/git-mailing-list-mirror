Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689CD8635B
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044178; cv=none; b=e2z9LsB+lQVG4efteRPdv7UxvhcMqXN/qnVtVdCLfqYOxaPtN1u0sqCIH2CaggPXzAN6yZwX68ngy+Aus/A6yozQNT4oYS4O36WZguqvp2Q83uWdWPC8yx9PqekWND7S73OikfWoaw/TGqHetqL5UGdzbc92GbK/BOFEudtYM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044178; c=relaxed/simple;
	bh=AY/A6JcW4j5PNTEUvkx8ZwmTTQCtgxAZVI0tMd8z6Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzXfJUfabMtJReND2TwHNxy2hu3EjEgckVtkXEBRxQF3vWLyePKCD2tNiIUaC6dapz4izsqWRmW7OABKeNU5CMTcsa9b+qvcweFNyt3LgN77CW4JsGlXj3clp0l00jkl5ecwMc+idGZafeg9zHtlmhLDSvIdj5jKiC+VYFmlM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJdKu52N; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJdKu52N"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436345cc17bso7464605e9.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 08:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044174; x=1737648974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR0QMyZhvkOz9hBR6NZ/o6Ku/vPQYlB258CFhflv5Hk=;
        b=DJdKu52NsQ3GrzwFlZTTINMocidfKC4/2U4rmgyZp6vEc5GYr88YeofCRc1cBfjlJm
         /0COM9IIPA7ov6nUlgEsSTzdAYjOxs1DhTbJQfRdPtYVairnA+wjxyU7YVCjQ3lDE/gH
         3VLowoS4sFsSX0T2HbzkAKJ5rxGg8ntBaMN7l0GkJ0kVMO2eZJ/aQCK0HxalgA6e9nq1
         Ccjyvq2EyJcSyV/WCHKks6u64pGa+8dVNjcMGkbMeygMH6bJ4070xTTSC1b2V0rgKHBV
         UpLefVkQlvxBbXRLbyKbScYXGkKvDIlRbnnv5IiBpz+dkuGnzCyYIpCIY+XjJnPw1lSx
         g2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044174; x=1737648974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR0QMyZhvkOz9hBR6NZ/o6Ku/vPQYlB258CFhflv5Hk=;
        b=IEDkzxeUZV1Z5K4+/mA6+f3kaGhkrnYlCpTPjWPhjqokw29EOU3UOO03z8IJ3V2Kre
         pe7UPwP/cx0hV7SAnttajQakiTxqBEASZPcP+kBhyaDH86AnbEqGwYIv1zQw/ary9/3k
         92kgQKRkMYPxh3+19MxmRUcMeY6Gb99VXacP7dOMC0NT91XYamvR4/vpP/MN3UOzSobF
         eo1maCuOt65qBvCd9jnqmt5aOEWdzrocbh82kt1UOzEWndmjVywqi2TtqNvkZYPbzthl
         qn2TtTHrmlod7rFMh7iZVubAeDE1ZMWkHnNNt+fUpPeWwNSo6d7zg3RLHU9RivP5mnV4
         4G1Q==
X-Gm-Message-State: AOJu0Yy+vQ43ywNAB4zHcsbw2Bq44+LbecN1l5d7MgLmAF7Y4CZRfS1o
	0p6GNkGjGtFNYKLpFni0DYx1m55kHYne/E0X1sm6yfil30lbibuWl1CBOLm3ZveRSA==
X-Gm-Gg: ASbGncvdGYaRTdu1RLcFk/24p/oXaT27VODRVUQ/KfXB+v6ZPqDyORogUmhWTXPV84K
	xDudPiFnWUK8jtNOLS0ZJLxfJTFaodiJfePYJciftqVxLVRAMZUZbaQfFLyns6wYGEUWOVPW7/V
	JGA23K6ZQE+kljpX1OL2Td3fW+FbdyyaYVXKGCWS0dugAReTRsIzL9hIVFEvw7RMLo+ojNOHjI2
	YST8asOKViDNkL3ODovMCJ1KJsoNTQIwXrpGXIG1ZZ0XLOYRH2SWWT/avnnBMkK0imUrA==
X-Google-Smtp-Source: AGHT+IEZihNnSGYdsQOrAAeJ2BR0nk/HG7TIhJRiPawCou4eBbYqT8Lmb5dSVXdWjKRzk3A3AsrDsg==
X-Received: by 2002:a05:600c:3514:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-436e26a607fmr352858715e9.14.1737044172798;
        Thu, 16 Jan 2025 08:16:12 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c752935csm63177025e9.26.2025.01.16.08.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:16:12 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 1/4] t/unit-tests: handle dashes in test suite filenames
Date: Thu, 16 Jan 2025 17:15:56 +0100
Message-ID: <20250116161559.91038-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250116161559.91038-1-kuforiji98@gmail.com>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
 <20250116161559.91038-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script is designed to extract function signatures that match a
specific pattern derived from the unit test file's name.
`generate-clar-decls.sh` does not pick up dashes in filenames, which
prevents the scripts from being run.

Adapt script to translate dashes (`-`) in test suite filenames to
underscores (`_`) to correctly extract the function signatures and run
the corresponding tests. This will be used by subsequent commits which
follows the same construct.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/unit-tests/generate-clar-decls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
index 3b315c64b3..abf6a2ea2a 100755
--- a/t/unit-tests/generate-clar-decls.sh
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -14,6 +14,7 @@ do
 	suite_name=$(basename "$suite")
 	suite_name=${suite_name%.c}
 	suite_name=${suite_name#u-}
+	suite_name=$(echo "$suite_name" | tr '-' '_')
 	sed -ne "s/^\(void test_${suite_name}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
 	exit 1
 done >"$OUTPUT"
-- 
2.34.1

