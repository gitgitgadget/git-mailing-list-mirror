Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABE209673
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295629; cv=none; b=Y/UL2m7X1Iqif8bWGfu2NpXIgdqg+hsYVwo2R3PlYCxAQPHDwElGf5g/X4IgDsQfalnH5Ln2lb8vhybHYxDjpD4t4M5bRRuTZFGNSARXTAXgD5uuG9yWx2MeUcgWUmTIxsWcILVy8LsojNBjvglzkm++pNFYzip++Z5sO5vgVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295629; c=relaxed/simple;
	bh=x+4ITheMFV15srN/DNeCL8OOej5Cz/3Iokphcl0qfFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2/C4d6eXlO2ukhK+wB3jj6EnoAuJDPs5aW4FDck430sh3+nQgagsWQSVe03PnT1KPdDLEnnia3YAkdNlayakj4+lcNrM/cIJ9qb5YbWwH8mLKO7gZkYDyu/FWoSgZXE00ngLWTRUuBmKr2qQdI6bdC2HrvaXSfsuoRVHjZX7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaN/p3C4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaN/p3C4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so20182345e9.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742295625; x=1742900425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wO3y36G9A/pjzGu/899mnIFGDJqjSV8cLgeTdoBqFkc=;
        b=XaN/p3C4uViedWqKpJJriCoZhEYah4vyBV5KtqU0jI/yvla1rJONqZ1hUSXvdKA+qE
         YegvRoOQumZSv1NHqyYDkG9IteF731Y+xf7WqlaXiVt3w7lqhfNzzzr7IgUx/vRw+KK2
         EqIEUksCL2EBcdy5898CUQ1A4sLRNJ5xrVJDeiUQzZfisHdvEh0TgSOrkaBhxa38YSBE
         HXctimHo0451JRrs0bncaBa+I/Fnddqy7P4Ew3yYqT02RL4y+Zy7yIZkRstTz5pa9CHX
         nY3RemfJaoMtY2u8mV65SM8xoEdwFmgvH5Gx8Ib2aC227RrMiEDhAZtw8eyhbpO4sM/a
         q6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295625; x=1742900425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wO3y36G9A/pjzGu/899mnIFGDJqjSV8cLgeTdoBqFkc=;
        b=prDpf+lBEljMc99Wm1351twisvxlWh13T5d7X3YXyKgwiir5/48jTQrDMz8NmkreHW
         chnRc8znfK+L6TZp/GUpX0bR98RUg6Hvfhg8xYbWl+LIzFhCIBZk/LcMJhKcxF7s3pfN
         6HPkmb7SIZparDLBjyIQsy1eGDzfDYM3k+Q2aWcb3Y97UC8ZDXMBA6IoHzHdnFSyJmVi
         S0nAr+s5oioJL3Dj342m4kXHtKf50sLE8iAqh1pPqsL7ofTvDyFY5RkmJndmC09nWoch
         kIkkdm6epp/sZZp11MKRy2I5vr27kABp1Fqm/6QXqDqD7MKXojodBKIMZpR349X3XhwH
         ak1Q==
X-Gm-Message-State: AOJu0YxZV0HncQlU+Kpg+J5W2kjPAO5FTbAFKchbpnB8zVL7ktyvhLqJ
	kudgU0n7VI8unx98N6D7zJVGz1ZM3Fzf4tc7W45ciUe9bHA0WW6m0B+wpw==
X-Gm-Gg: ASbGncvysf4cGF0nhPj3Xd8zSLPizh/aaKAlPQjDIFZAf8P8qSGYtAUl97107Jcb6HD
	rgFwA4VSTMpsWtyVhhSN7lUt8lE9j3MJNP8FHz/8KsHsRbHcJLjrJWZesu6G3AI0i3atnlHEgP7
	YYon351nMSCDf4sDBTO1213QMksFUZFhyItXuvq1M/WNskors2Vvp3LTQW0bo/AzsIsJPSLfUZs
	YFQBeWTA1jtIO2cgEz25ebkefypUh4ltqe1I3DRMw/FNl0P7jkWbMtYJyQ9uMQZy1WQTmdpEnX2
	FJaUXmmNcY70q4Ypt3x/W4BO/TpciB5ACtu/wgdd7p0349KpOieoGTpyMiqSo8wYSRIbHBxPLdI
	VXQ==
X-Google-Smtp-Source: AGHT+IG/S68QlVbYrBCsM3+UQsHZcNRPQRr/LXh2bu8fzllVQizHTMtkq4/MIRWz4mrumHIb4jOyyA==
X-Received: by 2002:a05:600c:1d8d:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-43d3ca66b80mr14577705e9.9.1742295625034;
        Tue, 18 Mar 2025 04:00:25 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:f066:6e28:cef1:9d6a:ca5b:64d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60951sm131169515e9.26.2025.03.18.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:00:22 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 1/4] t5710: arrange to delete the client before cloning
Date: Tue, 18 Mar 2025 12:00:05 +0100
Message-ID: <20250318110008.656695-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.4.g81387f61c3
In-Reply-To: <20250318110008.656695-1-christian.couder@gmail.com>
References: <20250314141203.2548803-1-christian.couder@gmail.com>
 <20250318110008.656695-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If `test_when_finished "rm -rf client"` is run after we clone, it
will not run if the clone failed, so the "client" directory might
not be removed at the end of the test.

`git clone` does try to remove the directory when it fails, but
let's be safe and try to protect against possibly weird clone
failures by moving `test_when_finished "rm -rf client"` before
the clone. It just makes more sense this way around.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t5710-promisor-remote-capability.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index d2cc69a17e..e26a97f588 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -93,6 +93,7 @@ test_expect_success "setup for testing promisor remote advertisement" '
 
 test_expect_success "clone with promisor.advertise set to 'true'" '
 	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
 
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
@@ -100,7 +101,6 @@ test_expect_success "clone with promisor.advertise set to 'true'" '
 		-c remote.lop.url="file://$(pwd)/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
-	test_when_finished "rm -rf client" &&
 
 	# Check that the largest object is still missing on the server
 	check_missing_objects server 1 "$oid"
@@ -108,6 +108,7 @@ test_expect_success "clone with promisor.advertise set to 'true'" '
 
 test_expect_success "clone with promisor.advertise set to 'false'" '
 	git -C server config promisor.advertise false &&
+	test_when_finished "rm -rf client" &&
 
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
@@ -115,7 +116,6 @@ test_expect_success "clone with promisor.advertise set to 'false'" '
 		-c remote.lop.url="file://$(pwd)/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
-	test_when_finished "rm -rf client" &&
 
 	# Check that the largest object is not missing on the server
 	check_missing_objects server 0 "" &&
@@ -126,6 +126,7 @@ test_expect_success "clone with promisor.advertise set to 'false'" '
 
 test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
 	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
 
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
@@ -133,7 +134,6 @@ test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
 		-c remote.lop.url="file://$(pwd)/lop" \
 		-c promisor.acceptfromserver=None \
 		--no-local --filter="blob:limit=5k" server client &&
-	test_when_finished "rm -rf client" &&
 
 	# Check that the largest object is not missing on the server
 	check_missing_objects server 0 "" &&
@@ -144,8 +144,8 @@ test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
 
 test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C server config promisor.advertise true &&
-
 	test_when_finished "rm -rf client" &&
+
 	mkdir client &&
 	git -C client init &&
 	git -C client config remote.lop.promisor true &&
@@ -162,6 +162,7 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 
 test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
 	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
 
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
@@ -169,7 +170,6 @@ test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
 		-c remote.lop.url="file://$(pwd)/lop" \
 		-c promisor.acceptfromserver=KnownName \
 		--no-local --filter="blob:limit=5k" server client &&
-	test_when_finished "rm -rf client" &&
 
 	# Check that the largest object is still missing on the server
 	check_missing_objects server 1 "$oid"
@@ -177,6 +177,7 @@ test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
 
 test_expect_success "clone with 'KnownName' and different remote names" '
 	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
 
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.serverTwo.promisor=true \
@@ -184,7 +185,6 @@ test_expect_success "clone with 'KnownName' and different remote names" '
 		-c remote.serverTwo.url="file://$(pwd)/lop" \
 		-c promisor.acceptfromserver=KnownName \
 		--no-local --filter="blob:limit=5k" server client &&
-	test_when_finished "rm -rf client" &&
 
 	# Check that the largest object is not missing on the server
 	check_missing_objects server 0 "" &&
@@ -195,6 +195,7 @@ test_expect_success "clone with 'KnownName' and different remote names" '
 
 test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
 	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
 
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
@@ -202,7 +203,6 @@ test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
 		-c remote.lop.url="file://$(pwd)/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
-	test_when_finished "rm -rf client" &&
 
 	# Check that the largest object is still missing on the server
 	check_missing_objects server 1 "$oid"
@@ -212,6 +212,7 @@ test_expect_success "clone with 'KnownUrl' and different remote urls" '
 	ln -s lop serverTwo &&
 
 	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client" &&
 
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
@@ -219,7 +220,6 @@ test_expect_success "clone with 'KnownUrl' and different remote urls" '
 		-c remote.lop.url="file://$(pwd)/serverTwo" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
-	test_when_finished "rm -rf client" &&
 
 	# Check that the largest object is not missing on the server
 	check_missing_objects server 0 "" &&
-- 
2.49.0.1.g12e6251c65

