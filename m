Received: from mail-dl2-f20.google.com (mail-dl2-f20.google.com [74.125.229.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A556E05F
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096127; cv=none; b=ReQil5+NL77/srPji3NU180L0wZ4mTHzmbJegApYRBtZK6RNqxTGI/O+Xk08QN7e0UKa3MVTHvGQ+5HkKWIEYSRfOaaJo0lWZmj+E6RoFcR2tHW8FPIC1JLunt51pb5rjAY/5wFJRW7aqlsU8GQvkBROSHcSDgTGTl5bnNNPWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096127; c=relaxed/simple;
	bh=h6SpQzLY2/ApZdxFre+12/B4own0eWOvmNXsXLyTSz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQpFR0AqeC+ijJArbVhEshkSVbZnGBy9YV7lYXR3SIyPCvO5oPIiTdow+OgEOWKp+i3RaVPdBaUtqkC1tLyxDnhxElNwEjb5r9mKgWULoDjedxvj0c6/VNW6jkbk6grkPzFNckq7BNTn3eBCeDDEC1/bQYHiuUqb1a8sU6YJilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhN6ALHq; arc=none smtp.client-ip=74.125.229.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhN6ALHq"
Received: by mail-dl2-f20.google.com with SMTP id a92af1059eb24-143875ac998so45221c88.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790096125; x=1790700925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u34szW/NIDfFH5SWyBBI3YOt/UIxmMSsKL7+nh5jcsA=;
        b=QhN6ALHqFxcLYIgLY+rry7ykJKYIrdd8UujW88aX+FhahqslM/wYro4xGMkAlSP5fo
         wCX8/1+sjOXmYoaqGcQX6KyGi4f1uDnp2/Cy3gs0GjJsnma8Ptc15wc8bnOuWCuoJrBN
         kFEVjF9rcRqQn8wChlawb0bmWjtwgvbNZ7u5cRoHaV9Trw3PpLL4dgn6hmbO40l271z4
         43evwTHs/ub674SU76I82++N0I/kRwfJib1pOJRE6T1vRsnEd6HGdITly3B3txTut17K
         t8GnHDU2twZ+0hzI8ChVI4ltvSgXRD9ncxx9jQ1sQHFqff8FIniMbJfWMkPiDVB/+Ng0
         E77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096125; x=1790700925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u34szW/NIDfFH5SWyBBI3YOt/UIxmMSsKL7+nh5jcsA=;
        b=GLtmFQp+xd9UaQl3WMiHicd7AVTcmfbSvci0a+6QozqFf5PnzpsxrSzEdLZK8fukfx
         Ahdb23GBZBoCN1/ACeU6AnWhfpCBLj+xlUYdcwQNLY3DiM4wK07p3QpTK6wACmLpRIIu
         Zg1EsaF+NvHnFLsrskPp5JEQoJsxkEmUBYeZk9nlG0pmlSs42O6JYoTDcfQF5ysliN8g
         2CBu0mHc2mLJYLgf0IDqicoE5NbSZSZxA4Yk0Of9u1d2DuL1awqTySDmnpDmH3xszrjO
         o9gNLkX/nJNBffQXhdyabyJ3GSdGH5fUXH9IVMA087Cp0RSegMY4xjGwUszaABme3Odg
         q3FA==
X-Gm-Message-State: AFuF++lQJntQnkaSKd3yqI2v5AO95Y/LIEET0E/HLS2FuxxFVa54PSFs
	qC0p6dTuVZBezgtbQoZlbjDyoiSJ9H2+zhfu8OUUwZ6EJcvGhuUP2CPCWxZ0tMnU
X-Gm-Gg: AYBFou120lFMp0nQfXDeNe7YC4uE1BMoU0p9eYiJWd4yihUXQw3LHz3tHvARKUzYyYk
	o2NunoqpKp2EbRrPBc2RBnMirpig3D3OH1RHDzRqh+eh2wiGDqYwAMBQ6CzsuSYpZaDU4eAPlKY
	kCuXTieeW37p3KOicZD4/eonLfs+8tZOIGd+HZuvAtULVfa9MkY9X/mtcwMfqs9UoWLEc308/mC
	Kp86VWMH4Q1tZXJdEw89gUl6guYwdIkYoZdrmZZ2+Z0f+PV5ACVWWr5zAUjoEiT62NU7tyeC/ZJ
	nx6QhnKhyuLcHdeveFso7tSLcfjkU/VxoAljxKlJGoVKEIZYrJsCguq7vMWpHx5v5/y0yb99qTO
	wDa7NtT/s1J11r7z9HJdfU0csZfFKWj9xeCLxUMyGFU8zEWWaj+4u9HPPXdoO3FCNriDnyhM6rL
	f3xu3bVA58b3Qw75KOLtUtGiqYwgAlqGnyouupmTDVSdppyQSm5ILsUslmbIG1Ev7CE/JRsMgGY
	gLXg7/Ask3B6aZ+W+w=
X-Received: by 2002:a05:7022:7e08:b0:143:f79:f679 with SMTP id a92af1059eb24-144f8d4c0c0mr117944c88.1.1790096125071;
        Tue, 22 Sep 2026 09:55:25 -0700 (PDT)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f8f43683sm39725c88.1.2026.09.22.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:55:24 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: r.norouzi@proton.me
Cc: git@vger.kernel.org,
	ps@pks.im,
	peff@peff.net,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] reflog: fix default expiry periods
Date: Tue, 22 Sep 2026 16:54:34 +0000
Message-ID: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.55.0.1055.g20c0e7c0fb
In-Reply-To: <GZicFFe4cqB928v52ERTcEFaAFtAwL0rp8VaCKSMyYzJ48XbQ9XoduiDtsou0Qp4N2CGmCS49uRbxi9dUWwlFzgzlt0PkGzR7IkqysP9tVQ=@proton.me>
References: <GZicFFe4cqB928v52ERTcEFaAFtAwL0rp8VaCKSMyYzJ48XbQ9XoduiDtsou0Qp4N2CGmCS49uRbxi9dUWwlFzgzlt0PkGzR7IkqysP9tVQ=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default expiry periods for reflog entries are reversed in
REFLOG_EXPIRE_OPTIONS_INIT(). This causes reachable entries to
expire after 30 days instead of the documented 90 days.

Restore the intended 90-day expiry for reachable entries and
30-day expiry for unreachable entries.

Add a regression test for a reachable reflog entry that is
60 days old.

Reported-by: r.norouzi <r.norouzi@proton.me>
Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 reflog.h          |  4 ++--
 t/t1410-reflog.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/reflog.h b/reflog.h
index b996712c00..3bdd1ca8a5 100644
--- a/reflog.h
+++ b/reflog.h
@@ -23,8 +23,8 @@ struct reflog_expire_options {
 	int recno;
 };
 #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
-	.default_expire_total = now - 30 * 24 * 3600, \
-	.default_expire_unreachable = now - 90 * 24 * 3600, \
+	.default_expire_total = now - 90 * 24 * 3600, \
+	.default_expire_unreachable = now - 30 * 24 * 3600, \
 }
 
 /*
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 8f78cf4b01..1239c078ef 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -153,6 +153,19 @@ test_expect_success 'reflog expire should not barf on an annotated tag' '
 	test_grep ! "error: [Oo]bject .* not a commit" err
 '
 
+test_expect_success 'reflog expire keeps reachable entries for 90 days' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		timestamp=$(test-tool date timestamp "60.days.ago") &&
+		timestamp=${timestamp#* -> } &&
+		test_commit --no-tag --date "$timestamp +0000" old &&
+		git reflog expire --all &&
+		test_stdout_line_count = 1 git reflog refs/heads/main
+	)
+'
+
 test_expect_success 'corrupt and check' '
 
 	corrupt $F &&
-- 
2.56.0.rc1.320.g68acceee5b.dirty

