Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092FC5474B
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843028; cv=none; b=EYu26pw4Mb51pdmOrxxxmOgBKPEMrkbf1aKm6ViwzXJ++vOTe1hByBWoUWBo161SgUZNQ4OyeTaZkZXb9GIdsxPh1MAnPCKFnaRsDrWaWwCZeLzLsUMNUZvKN+BRvrxQUdUeyoNoHaSse2oaCgOUXXj91SvClIVNfGDwZwAlI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843028; c=relaxed/simple;
	bh=dWmSotVS4BiZs+e2Xh2ZNw31f6j78Oagv4ocyQ9Re/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKeC7rmLHPIpYSeU4UONmHwXN9PPQ/MkDAkhNflLF601B+77dTd6yrQxfuzdBwkTVTDXZGPVKNM0WI5kQTaRCrIvcpBZ1X/UP5XJYvGZ/gmi5cnKlTU1MxpHHRjeb94/2q/zn1P4lqxEoNf2ZSnW9KSCzQc+YYGd0fBgP9WyP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS77CwB3; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS77CwB3"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c396fec63aso158738b6e.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710843026; x=1711447826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wifzrb2n0eoqa9RDkKAImT3C7pRW9CoaJRQnc2OY61U=;
        b=XS77CwB3/MPVQ1nfNQUPouNW6oAyIexDae6jN/P0ztR+LVfZhzSFnWsKLytIenMUfw
         h6VK7awmF0/M9SzMPKBY2BhcGOzK5RSpcRCtlud1omk93BIuCC6swkOry1BVQ62MS0L8
         r7YskRaF5wrNZyqGjyUuW36Wil5oy+DbrYel85JUrUlwXu2gn5sj02mHNyHR81kCGyZU
         zBf0YGwhlPlLQxtT7DO0gs8skef1jZNlt0GYFtV6BjU2JznWWF+FASYjIUYQanlgI03x
         8ASZuNqmxoSKtFiNaoQ0rAZ/dVTSC5raMN7YsJIrY+hQNZnAGZlrYbmuOeeD8fOOHH/v
         LJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843026; x=1711447826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wifzrb2n0eoqa9RDkKAImT3C7pRW9CoaJRQnc2OY61U=;
        b=sbqcQAm73M6fCHOKKr3SC/NJrzBY0AMgOVWF+IWA/0LwNLyvlE+7c7I/uEZjinCe7Y
         AdnXV5HZ6kMcPotdMa7WkiL6gZveS6I1c0mX/gdOYp3vvcyl2593KOrtYGnKMdUGiXo9
         AV06NT/x2hvBsa7Hb2kVdbfU0SYKDVjugfRP54aJ9lt1TwALCJwKH11R2cOHzVGFC7L2
         TVfDpvZrvo8FkVrY7hfdhlY/eij2DQ92OkEKNcEGlk+Vb9VD+/HJNh/krjgsDIrQN5Ed
         FG8t6yTN+YkPDB9OijwgKZS6GaPz7lBCkpGsUY4ud0cbD1vp+5lnIbEGxjsSAkf/7fN7
         qZWQ==
X-Gm-Message-State: AOJu0Yy7Qr1tNio7FYk+v8bSXOe/GuGT21HfrNJL3ALCoGKlWTIHhnBk
	NMi+17E2oISS1LypC8GSz46oYal1lTe75ia21vyiQqnokyqHORfF/AzRmgtQ8zE=
X-Google-Smtp-Source: AGHT+IGbObJ9SfCIDggk6726vqMVesuuliIXkfIvw2o8NUruX/alJ11/KGgeiOwUMTx3bstYQvpAbA==
X-Received: by 2002:a05:6808:13c5:b0:3c3:7666:7657 with SMTP id d5-20020a05680813c500b003c376667657mr16223472oiw.23.1710843026084;
        Tue, 19 Mar 2024 03:10:26 -0700 (PDT)
Received: from host-sergy.. ([154.72.153.193])
        by smtp.gmail.com with ESMTPSA id z12-20020a056808048c00b003c385d0ce00sm776628oid.3.2024.03.19.03.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:10:25 -0700 (PDT)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	pk@pks.im,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [GSOC][PATCH v2]userdiff: improve code quality and add JavaScript language driver.
Date: Tue, 19 Mar 2024 11:10:00 +0100
Message-ID: <20240319101000.76767-1-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <ZeWOhxBDvyjH8gW7@tanuki>
References: <ZeWOhxBDvyjH8gW7@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces several improvements to the codebase:

- replace the use of `test_i18ngrep` with `test_grep` in
`t/t4018-diff-funcname.sh` for better pattern matching and improved
performance.
- add a JavaScript language driver to enhance the functionality of the
application.
- clean up the code by removing trailing whitespaces and fix multiline
comments in `t/t4034-diff-words.sh` and `userdiff.c`.

Signed-off-by: Sergius Nyah <sergiusnyah@gmail.com>
---
 t/t4018-diff-funcname.sh | 14 +++++++-------
 t/t4034-diff-words.sh    |  1 +
 userdiff.c               | 23 ++++++++++++-----------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index d35cce18a0..e6d2f1c215 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -119,8 +119,6 @@ do
 	"
 done

-test_done
-
 test_expect_success 'identify builtin patterns in JavaScript' '
 	# setup
 	echo "function myFunction() { return true; }" > test.js &&
@@ -136,9 +134,11 @@ test_expect_success 'identify builtin patterns in JavaScript' '
 	git diff >output &&

 	# check results
-	test_i18ngrep "function myFunction() { return true; }" output &&
-	test_i18ngrep "function myFunction() { return false; }" output &&
-	test_i18ngrep "var myVar = function() { return false; }" output &&
-	test_i18ngrep "var myVar = function() { return true; }" output
+	test_grep "function myFunction() { return true; }" output &&
+	test_grep "function myFunction() { return false; }" output &&
+	test_grep "var myVar = function() { return false; }" output &&
+	test_grep "var myVar = function() { return true; }" output
 '
-test_done
\ No newline at end of file
+
+test_done
+
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 74586f3813..cf2374af2c 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -328,6 +328,7 @@ test_language_driver dts
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
+test_language_driver javascript
 test_language_driver kotlin
 test_language_driver matlab
 test_language_driver objc
diff --git a/userdiff.c b/userdiff.c
index bbe2bcb9a3..15342c8662 100644
--- a/userdiff.c
+++ b/userdiff.c

 PATTERNS("javascript",
-      /* Looks for lines that start with optional whitespace, followed
-      * by 'function'* and any characters (for function declarations),
-      * or valid JavaScript identifiers, equals sign '=', 'function' keyword
-      * and any characters (for function expressions).
-      * Also considers functions defined inside blocks with '{...}'.
-      */
-      "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
-      /* This pattern matches JavaScript identifiers */
-      "[a-zA-Z_$][0-9a-zA-Z_$]*"
-      "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
-      "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"),
+	/*
+	 * Look for lines that start with optional whitespace, followed
+	 * by 'function' and any characters (for function declarations),
+	 * or valid JavaScript identifiers, equals sign '=', 'function' keyword
+	 * and any characters (for function expressions).
+	 * Also consider functions defined inside blocks with '{...}'.
+	 */
+	 "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
+	 /* Match JavaScript identifiers with this pattern */
+	 "[a-zA-Z_$][0-9a-zA-Z_$]*"
+	 "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
+	 "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"),

2.43.2

