Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB61F03D7
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097304; cv=none; b=gS8SXDQbTVUbZeoDmoJByafK38SJLj184QvD0agznIL5J2aEGd+wvg1+rgCUpQbSObITLy6oJuoaHnOJx4jw7xdk4rdfv+GiPCUKkG4Xd262wbCbXJUnaPwyksBLGs/a0uodcz1l8t2AHyKJB52H9MWJfNXodP8GZd4q3OHoKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097304; c=relaxed/simple;
	bh=xO7+kRhBVvFWrYpNYM7GPs8Ym8l1z7k6jFqaf+SU+ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKX3F8R0Dj2I6r5KGaF0kJXg0AWDvf7pmPhz6a/7SlTxQeJk8SohgOrzGylpmdZlPzdqIXGOPpZwF0FgyevL//FJp1DL4/fOJphnGsRZ0zuJOmvs51F1Yohh4KsT65Gq3Zqnn0ryf36G/N6UCiLEOdFTCOchgkbD7RZtvVrRXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6oey+Zd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6oey+Zd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso6325725e9.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773097301; x=1773702101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usp7dt5PhzjPLwLWzasjUbZqOkSn7a3HxEe2BkVmhNs=;
        b=K6oey+Zd9724RbSEZEuWZOeCEOJVWZSs0poJ8UNQ/DbyfEmdb5XfsuxXbZVKSM/6aB
         sYMXdcm9qHSG4XywBRJAMpylTxlSGZ+CkEAqYpulrhsuHtJg4wCMI/Edr8E4/JnfTGbr
         UbB5zjZ2/J8XDLwwEmh0MpuLDHk1VKzJu+zzTcvtJOBKCQr9e144hkvJQ/AqHjXIkjWt
         GEd0AZa9sz8lTiTb36m+ELeJewsHNBBmOnP9TlxlvsMgjAVAmAhdFutyXyyAC9hN/Q4A
         sCIbQVmryJWcLAUHE6mt+XAFv10385LWLCTVHHbWrcXQ96gtsSmsCsAG8D71VykMbsER
         7UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097301; x=1773702101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Usp7dt5PhzjPLwLWzasjUbZqOkSn7a3HxEe2BkVmhNs=;
        b=tHPhkJNuIZRIXWqqp6hZInjWAh36vTULaU8Fn3N8dJIBzrD0NM9Z9xrcuFRb2cuA6b
         45Akabj5GJPJGtUGXl3U1sNAcHX6CkZ8eMVy5/71PIEbqXUZDT7ZyVbZYr9tvfbzjkbZ
         +pzOHO4mmNo2q1IRL36y51nZenpTX+txlpFE8hYhQRFUvrVvqYSvOOCLOm/gQ33ZwJUS
         W2I+v6oMEfZMQm+hqQZ7ahLczrl161fLbmRLqdYM4tIMqT0ugBYDw6b6ubUns+rWY1zd
         ab40yjAxA/MJaNz49nSusKdpnkdPVkhW1tXKH8lK0oN2TX3hMn7C1QrEaI0mXBHwgR9n
         0NNg==
X-Gm-Message-State: AOJu0Yx2OzZV6rlVC3hMx38p78eDy+7u0P4zn4P5GU39OrTjde+v+M64
	sfgRN42NwirJM8l29lVpjajNp0epKMh2WuBKhye1GpDwKmdLpQhM4D27uTqNH4Vgobc=
X-Gm-Gg: ATEYQzxCp0feDJloS8gwEDvoKK5jU9fPS7+FqAKQ4jDBZTxoizbzuy/OoJ9toSaxEO1
	2G5NwxTR+UWLfIeW9jDeQ+qUtPwyZbLviM6ZEEkLhcy3W4/6b1QjezwZ1GLSXSXICpTmFp/YSBY
	Wzu0ZmzFjZWMYKTdwEAVuyP7c6ZeBp1dDRLuc/IgCjDxUFigWQhTKUEyoAhZI9UVfS6NM+9+v2D
	kTvM/8sQhKs38N08C7pg0gSQWy12ls1i0xFvaK/19s+i/LDYeEwfvmoYu2v8+NqzAQ85beMlcpB
	gaEIKWcb8Oqp5m4NShEamqcwFfiGerZ15v6fqN/MDA1prVRlpi0IJXXdwqtOnZc1fk/FN6yuVSy
	VzpBaG6/P4uGxk5RCep/VyYbH79n2NIbA8Hcj8jFnKHpcwOYk2hVQ4OL1h9z4aS2MLTZE+WZpQw
	1WA5wB0b9lS1VPgqfqP1HphMJB94mf8uP3pVOBmXMALF5sqSTPjrb+R8E0Py6/yERvSzoIH66No
	7vuwXtDbiyNP7ehvp8LjnS7PJ+oXrIBnQbkt1Xwqv6qzCaguISogz13DLRim40JdPNerg==
X-Received: by 2002:a05:600c:a115:b0:485:3b5b:eb8 with SMTP id 5b1f17b1804b1-4853b5b108emr69206515e9.26.1773097300799;
        Mon, 09 Mar 2026 16:01:40 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad97be5sm30382746f8f.11.2026.03.09.16.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:01:40 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v3] t9200: replace test -f/-d with modern path helpers
Date: Tue, 10 Mar 2026 00:01:34 +0100
Message-ID: <20260309230134.758107-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309150935.578465-1-pabloosabaterr@gmail.com>
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace old style 'test -f' and 'test -d' with helpers
'test_path_is_file' and 'test_path_is_dir' respectively,
which make debugging a failing test easier by loudly
reporting what expectation was not met.

The instances were found with:

	git grep "test -[efd]" t/

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/t9200-git-cvsexportcommit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index a44eabf0d8..4507e8e6db 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -31,7 +31,7 @@ export CVSROOT CVSWORK GIT_DIR
 rm -rf "$CVSROOT" "$CVSWORK"
 
 cvs init &&
-test -d "$CVSROOT" &&
+test_path_is_dir "$CVSROOT" &&
 cvs -Q co -d "$CVSWORK" . &&
 echo >empty &&
 git add empty &&
@@ -303,7 +303,7 @@ test_expect_success 're-commit a removed filename which remains in CVS attic' '
 	git commit -m "Added attic_gremlin" &&
 	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
 	(cd "$CVSWORK" && cvs -Q update -d) &&
-	test -f "$CVSWORK/attic_gremlin"
+	test_path_is_file "$CVSWORK/attic_gremlin"
 '
 
 # the state of the CVS sandbox may be indeterminate for ' space'
-- 
2.43.0

