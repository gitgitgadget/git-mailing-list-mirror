Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0EF30CD94
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340181; cv=pass; b=sMtMJujnkxn6lgY9HQoybh9JAFqMaBEBPsm4u2HIO7XvZAlfwQtXtua6fzRPX1t4N31Bfp6slESVVMAtqa0w4L4z0sZSGkItnq8Gl2UslzYV+Ox0KLft6f0UtGNLXpGFo+Su7RJKlSa/456aSVVEeyLS7stuoLIEQbXyRiVVg5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340181; c=relaxed/simple;
	bh=b19EHfbOddqsCZi8455VozhuqRY0IfxELJCVEWKtMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpD3tNio1kf7ZwrhYRS9r3nWxvTXDXlZQ2K+O/S8QHkHJFJCFgGSdfXWwgUKwfD2/6tCqCGSOO4VmtSoOMRe5Vw/mfoSBXw9UzREpZF2vcJNpLzaRuS987QFYhN3Eqo5C5xY7RFCuY3ltfJWJxVPFhG0usiwGwn1b8afQceJAoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=fiRQuasl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="fiRQuasl"
ARC-Seal: i=1; a=rsa-sha256; t=1757340159; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j4b9ZQldkWahLCeSSsuD+x1m82J0jmPCH5e+ODxgIPqiG2/Kff5ykIqDn/e3szLu3ZuwbsQ71CAabwVhRIOP5/liXyDaLkHhTuHHM2g7pA4VB/xKISCtukuMbAOF9oHBmBb6G4w8H1OHADxjGMocRHIHuw2gG0wdfo3pIBpI9xY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340159; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2+9nPy9wf0IWtJtrSDyEIQAgOKKdgyBzoHDeyzB8sgY=; 
	b=mhC4bK4xDxiNrawB3AN5SgzaHJ9gH2TOIDbKUyX1YwjrCPBX5ChnhGCNstKrIf5tztwZlOZcpTnAHT/KitJPHm/egfKqWJEMJkA1wmCcNsO+PQ4CV29KzzSjm+IpKSCY8PXNhhqo5hUhVaQTdhql4fWo2T2q3p2C19OHe8Isjs4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340159;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2+9nPy9wf0IWtJtrSDyEIQAgOKKdgyBzoHDeyzB8sgY=;
	b=fiRQuaslg0GAfjXJEgFinhLu7NeAYc+LqYhQLT+zKw6DQ9p268U5Yq88NJLlnU2Q
	74VXZ2u0ZuTWU9dSx0EuXVw30gxnJ8I+Qb2UkENTJpS/Hyo18lLXoDeeN56HwXT1z+7
	+1fl/DUsU5Iw+DZKzLUEzm2d6J/8OgkBq1QWgBuU=
Received: by mx.zohomail.com with SMTPS id 1757340155516983.2516769978342;
	Mon, 8 Sep 2025 07:02:35 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 10/10] t7425: add gitdir encoding tests
Date: Mon,  8 Sep 2025 17:01:17 +0300
Message-ID: <20250908140117.262205-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250908140117.262205-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add some tests to further exercise the gitdir encoding functionality
alongside the existing mixed directory and nested gitdir tests.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 t/t7425-submodule-mixed-gitdir-paths.sh | 47 +++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/t/t7425-submodule-mixed-gitdir-paths.sh b/t/t7425-submodule-mixed-gitdir-paths.sh
index a8c22de070..f467bafaab 100755
--- a/t/t7425-submodule-mixed-gitdir-paths.sh
+++ b/t/t7425-submodule-mixed-gitdir-paths.sh
@@ -152,4 +152,51 @@ test_expect_success 'checkout -f --recurse-submodules must corectly handle neste
 	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
 '
 
+test_expect_success 'new style submodule gitdir paths are properly encoded' '
+	(
+		cd main &&
+
+		# add new-style submodule name containing /
+		git submodule add ../new-sub foo/bar &&
+		git commit -m "add foo/bar" &&
+
+		# simulate existing legacy submodule name containing escaping char %
+		git clone --separate-git-dir .git/modules/foo%bar ../legacy-sub foo%bar  &&
+		cat >>.gitmodules <<-EOF &&
+		[submodule "foo%bar"]
+			path = foo%bar
+			url = ../legacy-sub
+		EOF
+		git add .gitmodules &&
+		git commit -m "add foo%bar" &&
+
+		# add new style submodule name containing escaping char %
+		git submodule add ../new-sub fooish%bar &&
+		git commit -m "add fooish%bar" &&
+
+		# add a mixed case submdule name
+		git submodule add ../new-sub FooBar &&
+		git commit -m "add FooBar"
+	) &&
+	verify_submodule_gitdir_path main foo/bar submodules/foo%2fbar &&
+	verify_submodule_gitdir_path main foo%bar modules/foo%bar &&
+	verify_submodule_gitdir_path main fooish%bar submodules/fooish%25bar &&
+	verify_submodule_gitdir_path main FooBar submodules/_foo_bar
+'
+
+test_expect_success 'submodule encoded name exceeds max name limit' '
+	(
+		cd main &&
+
+		# find the system NAME_MAX (fall back to 255 if unknown)
+		name_max=$(getconf NAME_MAX . 2>/dev/null || echo 255) &&
+
+		# each "%" char encodes to "%25" (3 chars), ensure we exceed NAME_MAX
+		count=$((name_max + 10)) &&
+		longname=$(test_seq -f "%%%0.s" 1 $count) &&
+
+		test_must_fail git submodule add ../new-sub "$longname"
+	)
+'
+
 test_done
-- 
2.51.GIT

