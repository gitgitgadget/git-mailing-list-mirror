Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA81C4A0A
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898823; cv=none; b=NCZXUOWGWUqiZ5kyO+4NkOqro9WVnB3/6BZsJ0YCyJf2y8Kgjy+lAfp4KDjNBhzgf6SV8SZzcIt8J6b9rPd6TCXT5cwqF2b0dltoMslXn+Aj1jdyXb7GJQbEhsT1seS8WO35mpOnlblTxIf2i2p6NCQPa7vgnH6nYu9fs7ZRjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898823; c=relaxed/simple;
	bh=14mN/uQsgMY2nZdTzHXDlnXsPn04Jyi7B7bY8xMAvjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hCXT85D4OVqEPjltQ8kT/WxBp1NVdnwAYxX7erVMUhStmVYof7mx4BnXWmqAJsDcVb0AkDyX653MCWIoIosFoZgVGmdFQuEzOcf7z/KOE8DrqwHm3Jn0udr1K99QC7a69LdNNp/rKHn2bwrqH1V5nRWzLmVWPvaS/eGsV0FF/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h28pmE6B; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h28pmE6B"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3d69e5b63so548208a12.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898819; x=1734503619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAPGDr+WiUf06luBBNRaYgfVqRmQKfVRA0+eKbJbh8w=;
        b=h28pmE6Bh45B7ZkRTChNl0fNPRQpBZuqV1F/q0lVhb41eJG540C28k3xx76wfRIDcw
         s6fBqePBsJI+uzGAEQXSxqW6HZMET0FRq6FJGg7/2EJOzs9R9zteOCwqK60cT3ukTlu8
         gZHtBlKGg5jW93qfeQnS4d2NfqZjAKYv+85AiRCNlxKRemoAtB95+8cxV+lIjJQIU109
         udfJIPGjWjPuoiP6vwgQuQ+zvpFht9n+ujyzwhZ0VyJTjlJBAWP4MPb7R0n7qULHKAxn
         /PRIJfZv0Xs7qiCllt3eL7/UgTysCHrW1WuZVKcU3JeOFiYfrHalqLzv7Qo1B3DOs/QD
         TiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898819; x=1734503619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAPGDr+WiUf06luBBNRaYgfVqRmQKfVRA0+eKbJbh8w=;
        b=BunPkHps73aFLj7Sb+s+RBWhsqI/O8mlnGEVqhGpQoPiOIV2khZzR19mwXG/n+0VI3
         YwjmafQb+1D/STeQDA9rtRGfmco+SrwG1b5JTHgAYhrnxfYJg3m0PmBlB5sB4qJJJwRJ
         14SViYVmoaLQBeGh28OZ5AHlQM7dQ4rEStUx7VkJZ0T11uLewJTYpiV5Ut5HtZPqPsps
         2jUdew7hYs3eIe8yULUy/RfwdBmIZS6HIOaus+WIZmYb1pxJOXVor+ZKO0GwG3Q2LKre
         csZQLoUHzBeDc62fy82pnnWh795zT38lKFhXVm55hind6//3Bel0ZjBXXdwrfBtc048G
         yEqA==
X-Gm-Message-State: AOJu0YxD/IRo/ONs5eB/+nmYw9i+JlXjo0L2R3xe60chGJOG8ShvQdnO
	WiWC3bu8U88Y8jHRSRxBNg7W4H02kBW/XusBzNadNvk7lQQV2R43skMhNxYc
X-Gm-Gg: ASbGncvOJkvHZ0soV6TpOnTKPdfds/z3I+9kbla3IYssy7EHX2c5RcMzYVp+gSZkkF7
	8WvISbSwrlg2T/8Lq0M5oYeGRY1dqYNfu6bXrZQ6NN1U2haUmgs+iH0rzG+hQU8rru/IW+ucafJ
	SLNRpDg6ikCqryDufS9OEIm6rKV539UAIztMR+1tcTE+HtCyW60ROyZnoSdpiYTaEV8mo0cf2gV
	8YCh2LxRiJbqb8DVCy2OXgMXGx3XIHQbuDHxD9/kiyWiSUEGw5VNrW/3xB67IM=
X-Google-Smtp-Source: AGHT+IHRryZtxZunhy6IndsGGYFvAz505NxWK/0m5zWg2cZZ5Jzpx0RSC/BP3aMCjKJqhyoCEOQXkw==
X-Received: by 2002:a05:6402:2682:b0:5d0:8111:e946 with SMTP id 4fb4d7f45d1cf-5d4330c22c5mr436504a12.5.1733898819173;
        Tue, 10 Dec 2024 22:33:39 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm6875803a12.6.2024.12.10.22.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:33:38 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v4 1/7] git-submodule.sh: improve parsing of some long options
Date: Wed, 11 Dec 2024 08:32:28 +0200
Message-Id: <20241211063234.7610-2-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241211063234.7610-1-royeldar0@gmail.com>
References: <20241210184442.10723-1-royeldar0@gmail.com>
 <20241211063234.7610-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some command-line options have a long form which takes an argument. In
this case, the argument can be given right after `='; for example,
"--depth" takes a numerical argument, which can be given as "--depth=X".

Support the case where the argument is given right after `=' for all
long options, in order to improve consistency throughout the script.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 03c5a220a2..d3e3669fde 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -77,6 +77,9 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		--branch=*)
+			branch="${1#--branch=}"
+			;;
 		-f | --force)
 			force=$1
 			;;
@@ -110,6 +113,9 @@ cmd_add()
 			custom_name=$2
 			shift
 			;;
+		--name=*)
+			custom_name="${1#--name=}"
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth="--depth=$2"
@@ -425,6 +431,9 @@ cmd_set_branch() {
 			branch=$2
 			shift
 			;;
+		--branch=*)
+			branch="${1#--branch=}"
+			;;
 		--)
 			shift
 			break
-- 
2.30.2

