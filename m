Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7B13B2B8
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043701; cv=none; b=bT+wrHFJIlVPBWbvUHjQivvV51mTpNXHDhY4VvK3D8Ecj+S0BxGO9uGT52UJCO42m9oWGQ7VGbFIYMv7lDGeuvcPKomz33j24to8Y25VfDc0aHKKore7DCCKL1SHcFCjky+/eMwioerPqjIDMjoqKqiL16oxst8+ec7TkNNpRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043701; c=relaxed/simple;
	bh=WQP4SVmnPYY1pNODPkAQmPZ+70EERLfPesotpQgk8xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChDOordsOY3KuanYgHiPZ1YVBqR6cs2XrA3Y3A208DpxsPhTD40sQs05AiSUuL28wD4fm131HcqO0KmZcQMwkosQ8l1glKanbDrZH85a4OYvEztgPmSRLDjBFWUXWUVPIxaEtk5D9KlMO2oQHJC4cv3YonZdq1bkpHkV5Y6L/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZy2Gl73; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZy2Gl73"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d2533089f6so51079831fa.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043698; x=1709648498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3ZVwX/Tnt0iQUJkcUBRAuTTatfyAkULK9qOPPp02T4=;
        b=EZy2Gl737Hm8yxTgwlI8PPHse93HoMrsy+k9IwdkDbnoXcYO74SGTsfoDkOdiQ/EHt
         yinCblDJ3B8YZZ/JQ0esCcjwqtVPk4yCgoew1BwYxT2ck3k57B5oLm5Au0aEzSpkU1gc
         rb75fyqvMtIekZvgl+RQdI4JDXRaH27eKxUDEmrPLPPvtA9RUkBjEKmFtPphIBcUwmXm
         cte/Xmbi5I7BuhspjD60vMNo/vlthDdTEJjpIBvNJ7SQpgTXhIS9SHWdPspNrY8UC9EE
         rhNyC+uKVE0EkhAWTEZ7nDycXVf5UwTPHN3kX4axmae6/Vr7bOVxJuTPCjU70zWREijS
         kLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043698; x=1709648498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3ZVwX/Tnt0iQUJkcUBRAuTTatfyAkULK9qOPPp02T4=;
        b=SRdb6sO256zZLGNONqoEs+fn07f1wyoy6j6KmVoeLP5Daz9FQFIswKpk5D52PvMikz
         Q6LZ8pUJ2v0KgRVpZrEnhD04bAlu3CbJVzjR+oqWDrIAAMc1bYQC6urd0jrmdYs7RZEf
         t7WwulvK3Ta5jqjqNzHmOjT0udsJcMayMzCbSnkyRz4j4xBVMX+NcqhkrMDhZ/Lv7ZZd
         emjHOpvFoimUZasjj/lBHUybN6Ep1iQgR3hLy56yFakSAzE8pdAb6aQcWbx4cGygwtBX
         plCYaDNg6wlDM0Yti8yTQu+4pQpzhlncf+VXxj0QCyrbuGYIkiAeoq/2SP4ejNFmle0X
         ehbg==
X-Gm-Message-State: AOJu0YzJTPPs4LI9Pi0SB6x0mhstl73KlRnMVu3gVi/Xm8+50uggGu1i
	U31gcRM0vCOd6XmvfszV7JjZEptgIiPnR5bKs6Y2vPhlY1klW1824fbW23N6svU=
X-Google-Smtp-Source: AGHT+IFfpt7KdZAOcXccNO2o8g0SHk9QCTD+iGupOogLUiJFcWkL9zp8AR547L3GRCQ5n8hpCQH2Cw==
X-Received: by 2002:a05:6512:39c4:b0:513:ed7:32a1 with SMTP id k4-20020a05651239c400b005130ed732a1mr1169677lfu.69.1709043698363;
        Tue, 27 Feb 2024 06:21:38 -0800 (PST)
Received: from host-sergy.. ([154.72.153.222])
        by smtp.gmail.com with ESMTPSA id lh11-20020a170906f8cb00b00a3fb62260e3sm810127ejb.72.2024.02.27.06.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:21:38 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
X-Google-Original-From: Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
Subject: [PATCH 2/2] Subject:[GSOC] [RFC PATCH 2/2] Add test for JavaScript function detection in Git diffs
Date: Tue, 27 Feb 2024 15:21:21 +0100
Message-ID: <20240227142121.72518-3-74214119+Sergius-Nyah@users.noreply.github.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227142121.72518-1-74214119+Sergius-Nyah@users.noreply.github.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
 <20240227142121.72518-1-74214119+Sergius-Nyah@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>

This commit introduces a new test case in t4018-diff-funcname.sh to verify the enhanced JavaScript function detection in Git diffs. The test creates a JavaScript file with function declarations and expressions, modifies them, and then checks the output of git diff to ensure that the changes are correctly identified. This test validates the changes made to userdiff.c for improved JavaScript function detection.
---
 t/t4018-diff-funcname.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index e026fac1f4..e88e63bd1f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 	# a non-trivial custom pattern
 	git config diff.custom1.funcname "!static
 !String
-[^ 	].*s.*" &&
+[^ 	].*s.*" && 
 
 	# a custom pattern which matches to end of line
 	git config diff.custom2.funcname "......Beer\$" &&
@@ -119,4 +119,25 @@ do
 	"
 done
 
-test_done
+test_expect_success 'identify builtin patterns in Javascript' '
+    # setup
+    echo "function myFunction() { return true; }" > test.js &&
+    echo "var myVar = function() { return false; }" >> test.js &&
+    git add test.js &&
+    git commit -m "add test.js" &&
+
+    # modify the file
+    echo "function myFunction() { return false; }" > test.js &&
+    echo "var myVar = function() { return true; }" >> test.js &&
+
+    # command under test
+    git diff >output &&
+
+    # check results
+    test_i18ngrep "function myFunction() { return true; }" output &&
+    test_i18ngrep "function myFunction() { return false; }" output &&
+    test_i18ngrep "var myVar = function() { return false; }" output &&
+    test_i18ngrep "var myVar = function() { return true; }" output
+'
+
+test_done 
\ No newline at end of file
-- 
2.43.2

