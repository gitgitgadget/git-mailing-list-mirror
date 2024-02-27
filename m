Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E089146910
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049798; cv=none; b=qEVO70oaoyjVpSjXYAa0o6YKz4iAxBUSXyxE9/Or7ObN2fzShBzAI1Fpy1PDanZV9I1Ooir1O+uGKt4Nh3/LrtMJtIzllEq7jyufmW7ih7PmF52E4IPe1mL0+XWFWPbc5lPSH0EhV0klFSxZHKzSGrS5HYk4+qD53fYullDxo6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049798; c=relaxed/simple;
	bh=QoXU40IhfjYnfjUzBn2AL0XB6zAm+mtwfjIxxlXs99k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XODGQb9Ig9nMGtEnFpNViKCWs6oOsTCs8TNkXxzy0CXxGX97JIJo9wkQzCdgxaNBqGSpxG+UEi8nsc0HHh7MAXVJizka//vx0K5y+mBs2A+XZYNefS46RRcwGIFxN0yZioOX6nzXqTsTVfdERPcrPxtlGMyXc9WysbimBWepe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNLx4Irj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNLx4Irj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412ad927275so5488235e9.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709049795; x=1709654595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuS2yvg1wo4U8mkfVTxOZsS+fosUZKsUvC0bLydMFY8=;
        b=gNLx4IrjLpLO9q+mXHaMMkY0mhMYmLB1BSNlKtHcJ2U5cAoUym6KoQ2bmRItsXfcMb
         2SakvBZtbYVavygOdWv6eVCK/dW0G+psFlu5GHBLAtvG+5GdUwdhQJXO6T+sbYtoJr0r
         VwoNQQY4B/XiJYbd8ojwX6FWG4pUhNkhNev7P4SDPz4tkb6EA/UL+CxW3yVT3agy8QTo
         UsRMhONxOy7TiNReQNwImmUY5XdyNYq0ZSrzjmuzrfIMEApvU0YsE6RqIiGchVSmjf6V
         Ck2mBtV3QVjN62Z8TwokvqMTvoxSsGMwN0aqi0TH5c48KVtePP1NHlC/2DulFNG91PGx
         5gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049795; x=1709654595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuS2yvg1wo4U8mkfVTxOZsS+fosUZKsUvC0bLydMFY8=;
        b=iLj/ScqgvtQgWhkFtXfqPRMur8i+Emu8gB37OOWOuZubjMwnXm3NGbVaq7072dqGhn
         ZWTVT+fbl9k+wCNUSieFMm4sDsyMLoer6BCUbhIF15JZq0TDvf9pA6hTbashEdpBEm7e
         1SCSb/VmF9SeiGve7ShtoeMn+cIovk0EJP2sEj0ePLy6SHPTFYyn5eCFPXE88IyjcJll
         689vZ0ClJd9Ymsgl0mwX6nYezC4j1FhVlK4bkdTPBc/McWBuVc8OZe4fPv2HRUXfzF7I
         RlM0RkfY5InN9p6sgfwuMud7p7D9A0/MP+DocCugCNLroGZ9eyJ9Fq6hnAfln6BHiE9R
         kacg==
X-Gm-Message-State: AOJu0YzRaxG1jLQrYMsXYxX62gbMfOGwbMtne9gSJJZfvCHVPZr2yGRg
	ZSkttieBF9q3rui2+7e/Vsgnumb3uNh92kO7XKJFNGlyr1VpqUorZG6YFQtexJw=
X-Google-Smtp-Source: AGHT+IFWdgKdwHfsyu/aaZ1TwRZm0mGpRVuSiwYsNbG4TVQNyRIpjPwgY5G0y1ktvj9fi4i7cr9lTg==
X-Received: by 2002:a05:600c:a4c:b0:412:77cb:ae28 with SMTP id c12-20020a05600c0a4c00b0041277cbae28mr9054475wmq.11.1709049794617;
        Tue, 27 Feb 2024 08:03:14 -0800 (PST)
Received: from host-sergy.. ([154.72.153.219])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d5702000000b0033ce5b3390esm11714323wrv.38.2024.02.27.08.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:03:14 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Justus Chesami Nyah <sergiusnyah@gmail.com>
Subject: [PATCH 2/2] Subject:[GSOC] [RFC PATCH 2/2] Add test for JavaScript function detection in Git diffs
Date: Tue, 27 Feb 2024 17:02:53 +0100
Message-ID: <20240227160253.104011-3-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227160253.104011-1-sergiusnyah@gmail.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
 <20240227160253.104011-1-sergiusnyah@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergius Justus Chesami Nyah <sergiusnyah@gmail.com>

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


