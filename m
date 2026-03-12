Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5C3A450D
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319839; cv=none; b=RGWdG0q6jl5wlSooxWkihz7kd8oAjvSKFBon96Eb13Ak0yfiBlBF5YWGgEwRx4066n3CvY62jxGDQuoHZe+2n3HYWjThehbox/bOsSJVD4h7tAJU8P/ACQgKQ/Fk4WC8p+7VlnUnJoGbLT/Wy33DT/lLdYd4tvz4qMi31/yNkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319839; c=relaxed/simple;
	bh=0YQCOen66LJSIImiulOj7ThMFQFIZXwqguloGMX2amg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHtJaSG2/6iNPO3vViZCrWCGig2m7N6tiR2eCFIxSv2XEDWfIxjtffagRKztARziOUvLVjwf68vP269wrM0C9F9YTYU8q6nsmkIfZJT6+z/JNjoWY4u3cdrnXFF/3Zj6ddcnyfIe5hPXlkc+XT+0xs6IGrFE7H5zA8Fi6qef4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyW1QzAc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyW1QzAc"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70f91776fcso429548a12.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773319837; x=1773924637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNGZtCed9EKrsa6tEIdi6FJ0+KVC8y2A9c5lfFu5CKk=;
        b=QyW1QzAcGhdVTuAQM1Hfs7fyKmgs2tHop8vIrwziHumCeefMPMeSth4AZwR+f3yVJr
         sjkSV4NEm85+ltAEO8VIaD52v3yi1Cff9Ca9IEJXSNAbE3HalGcevmxRfpdH4cspd0NQ
         CcVWdirW+5YyNWmJN/rtfLiukPrOg0h+Lm9cEzJsyh+W6MWwIUgi9QAYSG4y4GHlSBfs
         GRL+3b3ixTB0LdHa89VOSuQkCS40VsELBjRoQYlJ/VI4iglIe0dRVlDtn1WTaGXmwh44
         hEgX1uXssE/HPV+yy5S1unt/de+6TCb6m6cIq/IJFGenRTLl2fDUzxcsU2UUiU2U8rui
         98Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773319837; x=1773924637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNGZtCed9EKrsa6tEIdi6FJ0+KVC8y2A9c5lfFu5CKk=;
        b=kkww6/f5RCI+S9YZDJDwjRveycy+duTWJ2bwCsYvAfZMM/kDznIKeI8jzqAQIVt+7X
         6No+aOToPIXp1vcPw/01wbdVZiBYIMbpLsUmjk4LhPNG6X8M+CkdZ6rUfcLgBlx32R6C
         iSYC2pvn+QRjgTlTuZjA0Za6Kt8ZFSEtbYpaubCDse2iFj8HdXtK+lI5DhF4SeN9vuC1
         8vNSUIQwIgjivXjG/3IgMKdCfknvHQWHCjzduM5/9BKmooXsmZ4cZFSV5lQqGtup5GyQ
         Oe6m5djTxYGp41eMhwAb1+OZzK257r505C3pXVNmF8el7zZFSPv/6XH45atmeMvOF/F2
         PFmA==
X-Gm-Message-State: AOJu0Yzg3+TqlBjqENfmLmOId4It73n8NCGN3VBU3D6DAq1b4ZnQjgJO
	ADbI5uTojBElP0L7WVXxdB8Jgif4eJ6Bq4cwo5QPMBJQFFZuNMQYdtRmXqF2WOH3uiU=
X-Gm-Gg: ATEYQzx/o+76+yOKQSXPow2zG0coHFCSylv0X7tIEWx7YbaqyE7T6KkzAivfdMAWfwo
	jSuh1Cz8SRQhoCxNiPyDXoRPOpuQzNkHQpiqNZfwRWNMiCimfAj6BV7rEQF4FnzAO0G+I04JBDC
	314eUQahKeVxMgEgyoRBeyhd/Se/nxLrLptUBlsFCTPtVTu+faK93LZYyW1V3aI6VzyPz9pSQZp
	GfnEDF8GlD1BgMDeWpz6mPBoPbtgD5FiDXr5f6eD5seuN7YsK3fE3LKKnW2QRGId5PTA5QFz9fG
	cTuxSMer+U2px/L5vmAZ+5vWBr11uiQMjpJ1ypHyfadEWSIOxVjzHucXHJX11acwXGrHwayOSNi
	au9xZYVnpKboQWmXkDWrG+Fces+3Ow85mf2abQDCOH4UFLK1C6giTBP4cDdd+YhSJiFakKsF1rd
	SzbJQ1O29+bshL6fCsLdbuz+I1RjdIjm9WPvfybNLno56ZfnHNAV236vissDQJIYNSrHzkKic=
X-Received: by 2002:a17:903:2f8d:b0:2ae:3fb9:2690 with SMTP id d9443c01a7336-2aeae7ef14amr62110125ad.19.1773319837378;
        Thu, 12 Mar 2026 05:50:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:57c5:70fb:4d85:c87c:62ea:831e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378c9csm55705795ad.86.2026.03.12.05.50.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Mar 2026 05:50:37 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jonathantanmy@google.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] t0410: modernize delete_object helper
Date: Thu, 12 Mar 2026 18:20:30 +0530
Message-ID: <20260312125030.7799-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The delete_object helper currently relies on a manual sed command to
calculate object paths. This works, but it's a bit brittle and forces
us to maintain shell logic that Git's own test suite can already
handle more elegantly.

Switch to 'test_oid_to_path' to let Git handle the path logic. This
makes the helper hash independent, which is much cleaner than manual
string manipulation. While we're at it, add a call to
'test_path_is_file' so that the test fails early and clearly if we
try to delete an object that isn't there, rather than failing
silently.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t0410-partial-clone.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 2a5bdbeeb8..eca113f0f8 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -11,7 +11,11 @@ test_description='partial clone'
 GIT_TEST_COMMIT_GRAPH=0
 
 delete_object () {
-	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
+	repo=$1
+	obj=$2
+	path="$repo/.git/objects/$(test_oid_to_path $obj)" &&
+	test_path_is_file "$path" &&
+	rm "$path"
 }
 
 pack_as_from_promisor () {
-- 
2.51.2

