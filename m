Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0E201259
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361483; cv=none; b=YsXJzJAsPPXgtdPXqKXxOqDXMfq+Hj4qfuI21hZ9ZfqgJQcYqoRBQzv+KV+yKwTD9Pp9p3N4f75NQFQn17f1FofaOFcy+wIcLoh8vmvFdhFykhSMPr0o9iay5J6c5k5NFDahNuG0VeXBe8/mQpyUmjJazdDkBTPPnwY3hAkpeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361483; c=relaxed/simple;
	bh=015UkzzgBVeqRa8x5NRYEtBCc9wEI939Rdn0MoJ7X3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgY9c3v0m6o4q2JmhNXo/r6k4M2IrIRRHTQHRl91mxdkwrOiTkLma+ag196edKble+BIvyUP9gqkvNqsdhpnImE3wCrbv+LZKHBaDQEhHwjc1cf2rKodqT/Sc1n81mjDNAlSHgSFlhb+jzlfpc5K6PqLI6R0i62NyaquzOBKGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRFarm/r; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRFarm/r"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd43aa1558so1635646d6.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 10:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736361480; x=1736966280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMSfX9lzqqlF66vCHXp6Kv9pQ2HeL1c1zZ7Uoud4Myo=;
        b=kRFarm/rNUgsY2LvYUdPfYNmbYKyWtDLtvaqrJlbnmT9wn86JEl8C8gH1cLDQ9x8lK
         /wRyVa1s77TYbZS+5om3+Zk9s09tk9s9nl0vfj6DToAYdhOhRNK3558Y2vXTX0yYn2W5
         D2TNZ18aNPn21qVs9eGyp+Dy1RNo4JbcUjwLNBHZcCTfQNJzsYY2mqdX2N/nYINid4Ca
         MSmmQI7f7KsrmTJgJKcbZ9DkcqefYQ5/c0hP1nCibVyK3bN4RHGtZmP+IdilYzs41H8y
         z4XJGzmuPvQTulVBhT+ReAv9gaRMu5TzMVoIkIHymLQ2TdYZen/OWGDFroPlklSDbTLX
         JnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361480; x=1736966280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMSfX9lzqqlF66vCHXp6Kv9pQ2HeL1c1zZ7Uoud4Myo=;
        b=RLDuTqXuz2JWGKCOb+nMIVQY3G4z/ARnFe9Nz7XQ9SN8L1/UwV+Z4E9No7UM/oLSNy
         IvXs0wLHkMUNrEOU6mnQXdnXOChTUNS6s7KQ2FWl32MgxKS6f0OjiKXcnJRusHqcwjdQ
         NF3HsOgOyYzqHot0ZUeL8y3YABJZ4KBPfvODIyIhXHBd1R3ByQJTXfZ4KynN6Dy6covC
         7K4Llzt8cPnSgmz4z4lb2yDdLfg1VobT43XQns9fuJc+klbK7giezEolbZhA6zXI0wD5
         /MGcUNGaslqbMrhQeNlkBO8+btCbYN3ZI4RFX2ZLkoj8R1hUjdlKjm8QpUmnO6UDJOxR
         DLmA==
X-Gm-Message-State: AOJu0YxFB6bfDivevfjZS4R1w/baTUJy2iAk0GY/ZygpUNJwOVMbcvTh
	uDHlIW9g0Z2JwValhzv6GomVdlBgVatWMTieYHpeN8C3jAHiqDrIcedUjaNcso8=
X-Gm-Gg: ASbGncvoX/Rs/Pc9j6YMDnHG86mZco2JGMqGh3bvEgt51wqoAObEictqrFUQhGBvgBo
	xTcYBZ/U35GIhTgonpJxk5OVt6Oq9V96qK3361+Gc2r6h9D1vFOTEGg06NB5TUgaIowJWbFVctj
	mm7UgXYRU2GAvYrpMb9O/Nw2aWr6E8tbPxrwvaN9uOlkDldoQkPoMm62aCabA/QHN+PVYy+PbT6
	7dN3FPr6WCDzS+ts4r/31yh+uoBDORdHuDRljkTcRVSY8cDauacFjwFKmaWr8raH0rnJlgTziTn
	gPpoWIwj2g==
X-Google-Smtp-Source: AGHT+IFeSOjdFDTnnfwFg49RJCtSBq7De3q7H3HUnw65iZwZUrYZ/QGORZlb6+GW7z10c19VGBf5WA==
X-Received: by 2002:a05:6214:dc4:b0:6d3:fa03:23f1 with SMTP id 6a1803df08f44-6df9b1ef368mr70147266d6.13.1736361480346;
        Wed, 08 Jan 2025 10:38:00 -0800 (PST)
Received: from localhost.localdomain ([184.148.194.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea74bsm193228036d6.25.2025.01.08.10.37.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jan 2025 10:38:00 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v9 3/8] cat-file: split test utility functions into a separate library file
Date: Wed,  8 Jan 2025 13:37:34 -0500
Message-ID: <20250108183740.67022-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108183740.67022-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactor extracts utility functions from the cat-file's test
t1006-cat-file.sh into a dedicated library file. The goal is to improve
code reuse and readability, enabling future tests to leverage these
utilities without duplicating code
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 13 +------------
 2 files changed, 17 insertions(+), 12 deletions(-)
 create mode 100644 t/lib-cat-file.sh

diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
new file mode 100644
index 0000000000..9fb20be308
--- /dev/null
+++ b/t/lib-cat-file.sh
@@ -0,0 +1,16 @@
+# Library of git-cat-file related tests.
+
+# Print a string without a trailing newline
+echo_without_newline () {
+	printf '%s' "$*"
+}
+
+# Print a string without newlines and replaces them with a NULL character (\0).
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
+# Calculate the length of a string removing any leading spaces.
+strlen () {
+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ff9bf213aa..5c7d581ea2 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -3,6 +3,7 @@
 test_description='git cat-file'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -98,18 +99,6 @@ do
 	'
 done
 
-echo_without_newline () {
-    printf '%s' "$*"
-}
-
-echo_without_newline_nul () {
-	echo_without_newline "$@" | tr '\n' '\0'
-}
-
-strlen () {
-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
-}
-
 run_tests () {
     type=$1
     oid=$2
-- 
2.47.0

