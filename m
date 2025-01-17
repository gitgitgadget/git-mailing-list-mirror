Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB91FDE0B
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110824; cv=none; b=aFlp8w9JwVviiz61MxVZJO5QsWneclsnwgnSv7I4mdMVsMnV74fmX5AgHLO8zhQAJIhcZp96sQr+od6yaN68q3ogql6kqgBihI7/RcrjOZ6mFmzOPraip0f+yTh5SN6sskb9v2XmGPeoJSr/XME9L5dO0mzb7UnRiZdUMDnAuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110824; c=relaxed/simple;
	bh=QQ7GUf0ktN7gLQiI5GvWRwmGffoeAeCpHGWKxF3Hxoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmYn8HsnyAxpOLF1BftOE1tI0ubReiOOM5YPr/zm4D4XqDFWhLJ7I9n2YEYh0ggRco7SrEJ/LsgEdhHcadoN+AjC3w+/ay+PJ8VCoybu20pMZXGUhgsX996MKBYkSj6vWUkRFWhNkoCN9BmWUTuHbre+LGoR1kduc+hNoJNbXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+2CckOR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+2CckOR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21680814d42so30838675ad.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110821; x=1737715621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALFAAhPXG1sud+Hsk5Gb/byfBFcmg+Pt5vQNmyxcz9E=;
        b=A+2CckORcx+FSSoJihN2KDOSEpSQ+x7uP3aKysazZS6wKo1ZR+q4ZluO/Wn2MdjLvD
         gBusIv0h5/wKH5CN0+EJOSrvV4BboYj4dKY5Jeb5F77XBDlzzoIl2V6RI0nmywX931FX
         ALPba5pqFNj6RaAm6RFPl48Ad0EekK9do9uVR0C5nopXNAzUTr0qH3+j8+jI0PzpM5kf
         D01hDzbB4brY/MM4JjUTKN88ta4BM5qfdTXrAmoJ229Yb3GZ16HaOF/Q1dRHskz+q81k
         7e1TduH7YVFbps6bijIDwOD0dE5iBwTefBXQU1/6pdW1/HW34hMDHzAcJWrpky7aEVdP
         lkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110821; x=1737715621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALFAAhPXG1sud+Hsk5Gb/byfBFcmg+Pt5vQNmyxcz9E=;
        b=p2Uwk1/L/J3XZWBNq77zeniUG9UO8mPmTotvuws3zFJDd1tHTA1e34wbouZzG0Uj7W
         TCHVFr84f3n9Y4h0gBBSYhV30FjaaFNSdEdA6HQyaDYLEFA6RuiRzUGmFH0t52z4XrXx
         0kTw0BmTFtfvoZ+QFeoz+f0oIvT1NOXl2o9q7SyTX4wub0yHjlOQtC2o0F2zxUaKYfuc
         5BFxdV66NEsYriI6WKszhmBd/na5b/bXZmuoKEqe8mEOv4WmhtJm1woFoyjvxKmD5Ed6
         dGTtcZo0KFo9bnMDPFfCxXv2WJmvqSgF4gr1l+9IDx0T+TF3TRv2j4IN0iqeesn0Qy9F
         6Tsw==
X-Gm-Message-State: AOJu0YxfTtUVcme6ozHgtxO3uByDA7CikuUCjJ4k/zHythpaZqB9Shc+
	GZp/XFEBDYE/xvBl9h3y4LM2Vi+1MGP0PJfuX+cbZVgMBFAWfKqN3SiD7j2Hrtw=
X-Gm-Gg: ASbGncuY/0Zic7VD3/t4lpKttjWlGbh4VCXM0qnY1PSH+j6x3qz3YWxOiJhZLWAQtOW
	+dhNsEJnlpotNQ71xuSR9cdxWoq5IIeeLNl9wxdKU1EmQhasoaPxhRmCHovd2GfdaxP0/gwPLSl
	6yHJlatGbjOUeodPbnrL6orX3mIzVrCA62HN1p3JG3DZjlgnrENDmiRGx6lhNI6hSaPIiPNypLE
	g6B7Zf7Jtvdy8UMzaIP3H4no58QW6wnvhaeVHMj3+6/DeBOTw/AYkb6rM5rX0dSyYfEjjy95Tde
	E1j5dA==
X-Google-Smtp-Source: AGHT+IHc8OMGi1ykPM934p8Y3Y8Vi+/zv2qamYxMigmBtiDaqLMRczTG6DaTtqb16xyWiPWANq/EQg==
X-Received: by 2002:a05:6a20:6a14:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1eb2149467cmr2927523637.16.1737110821430;
        Fri, 17 Jan 2025 02:47:01 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48eb8sm1574985b3a.136.2025.01.17.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:47:01 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	sunshine@sunshineco.com,
	rsbecker@nexbridge.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/6] t5701: add setup test to remove side-effect dependency
Date: Fri, 17 Jan 2025 16:16:16 +0530
Message-ID: <20250117104639.65608-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the "test capability advertisement" test creates some files
with expected content which are used by other tests below it.

To remove that side-effect from this test, let's split up part of
it into a "setup"-type test which creates the files with expected content
which gets reused by multiple tests. This will be useful in a following
commit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t5701-git-serve.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index de904c1655..0c0a5b2aec 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -7,14 +7,17 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-test_expect_success 'test capability advertisement' '
+test_expect_success 'setup to generate files with expected content' '
+	printf "agent=git/$(git version | cut -d" " -f3)" >agent_and_osversion &&
+
 	test_oid_cache <<-EOF &&
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
+
 	cat >expect.base <<-EOF &&
 	version 2
-	agent=git/$(git version | cut -d" " -f3)
+	$(cat agent_and_osversion)
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
@@ -23,6 +26,9 @@ test_expect_success 'test capability advertisement' '
 	cat >expect.trailer <<-EOF &&
 	0000
 	EOF
+'
+
+test_expect_success 'test capability advertisement' '
 	cat expect.base expect.trailer >expect &&
 
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
-- 
2.48.0

