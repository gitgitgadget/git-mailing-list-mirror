Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B843FB88
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298232; cv=none; b=cqsbLEkCLH+Z5iXKz5AXhqnb2eGzlTkUaDG4WFBSr17P/foxchgYEglor3A0tEgA2XwR8bL+XoYeoE/GfZCNfpaSYRxlYAtw9yl5KPnYQtqeK0AbJqZn+m8q6UCn1hmLqyDwtimQ5h4VO8rRcAhn1lcJgbIaQhNEZlNLQtz1xNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298232; c=relaxed/simple;
	bh=oUowxy85RRwxPbkC4XvvMr08FGJRs/7OOFo2I73cKhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVMSzrWBWfiGxvXWx5gdN439vgYhH2JKDdYLI3i+MjTYURpKbRk53TM7e7NXsdPz5SCy/P9nGW4hzTOwECb45Q7gVI8yT5pg5fShWVzi91mC7rBD9bUY1MkNh+ahVS1WZtzH4YwkzvnkF3xgLPzEEg+znMYmVWrgo63T4A2KvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2GDdGfo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2GDdGfo"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so771744b3a.1
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 05:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709298230; x=1709903030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj9lomUybqsoPsCplvOIj3SllzJAay2YAAliwK4iE/M=;
        b=g2GDdGfoPrEmyvAKPt+DTVGavfN1BEn0vwgZJPiRuEJQ2gaQglujzYmXd1rp8hcAl/
         58A1biV8/O0b3jbUNGQwetSOyRLvBSy0nzhE+nWRlKxu1C/cyTWdnP958V+95njZjHWP
         vN1jmjx3TM9aV/OHPni5kkjBiRXxaw/Yr+piLBt7BnPqWNxbe0QxY0i8CF5B9s9iEWqM
         WEbnIYJMWfmclOV8nTo8cmECD+d3fke9587Tmgu1jL7jeUkaqBG/BJS7+Y2nI9UEJCMF
         f4UhsUpm1WVIj06o6eRg67RiieeiO6nzcGnNeocU9o8P4XMkA3WuT4EKnn4vgvNZTj+7
         GN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298230; x=1709903030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj9lomUybqsoPsCplvOIj3SllzJAay2YAAliwK4iE/M=;
        b=BJo08XVZH+XsPTA4ieUygVsZPqAZ3xWHMyzF2ZHuVod3rW63aumBEOtkUlXNDG4BDo
         0Z2r+MPG8+8grzopsCbWadvGceaUCLgdpIpPtnPwrNHmemes3w2xioxwU0mYt8EqID/g
         7ChVEgfL+dGI1eIdo+9MtFXgRDtW9Tlayua43krnl2rsHhXqEqBDEoHC9hga3fmovovh
         SfJ4YjTdu4eGIm7wr04xYwpeCGfVlTD9oecae3kIl7lA0pRikA3pjiDNw3/pSPdvq7a3
         SDJJTdWcaSmgAFYJnvScabanIux8Bp42TQjkSYh3/rnggKvpqTL5+C+TnonMcgTlC06C
         jgGA==
X-Gm-Message-State: AOJu0Yy4Ib3yI02lBB3okRymfdNUS0zdmTli+4iCF9WNqkOytRZNZJ9T
	YGFbHWMqRBcsa3+3bwU0Zt3GX6GLMH2ksmF2PJR6ZzknEoNFBPyFsjSfArebMw7g8g==
X-Google-Smtp-Source: AGHT+IE60CMTHNZ2S5JL77BBFzPwOe+pLkD/XVgFmPLCL2+8azVHvtL5v7yj66R6mfSOpSU1qw9SRA==
X-Received: by 2002:a05:6a21:9994:b0:1a0:e463:fcad with SMTP id ve20-20020a056a21999400b001a0e463fcadmr1771119pzb.2.1709298229947;
        Fri, 01 Mar 2024 05:03:49 -0800 (PST)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b001dcc7f470a0sm3384254plf.96.2024.03.01.05.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:03:49 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 1/1] [PATCH] t9117: prefer test_path_* helper functions
Date: Fri,  1 Mar 2024 21:03:34 +0800
Message-ID: <20240301130334.135773-2-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301130334.135773-1-shejialuo@gmail.com>
References: <20240301034606.69673-1-shejialuo@gmail.com>
 <20240301130334.135773-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -(e|f) does not provide a nice error message when we hit test
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

