Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5145016
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730543312; cv=none; b=tYQE0QYu0hSpYTNGTSkoYlPOYle9FhjKdOt2IUMniH7PvuSCn2DZ7CTTf8ZLpwKqpz2ciDQuVernBSEB65F6AN3ONKfREyYX0XbWqA4uvkxWsz6WneKIrqLy7sYzcsVMWQX2wGdcN+qFO+rxzmzoEZKlpDn0rFKxgW7btTO2Pok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730543312; c=relaxed/simple;
	bh=oPx9lgDXaox2Un7YMm1Q9ickcjP3kSqHrMC3jykZpxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctuuzX34rPc+JRqoOI1IHzhF3E513PcLjr9AP/dNzewAm2CAcHzrtcoTVyLs1GT61QLPX214qhDqP7jEdwOOUQTmpsqeMO6oVEmEGz4JXfpYwfqIEXIWZTGC6bMRt/LGztvkv0CXFR3yVmO2xByAsIH8nKMhPgP0E2nt4p3C62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAF3Y3K1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAF3Y3K1"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431688d5127so20831425e9.0
        for <git@vger.kernel.org>; Sat, 02 Nov 2024 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730543309; x=1731148109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS916Ry/hfwr5a1lH3Kd0nANpJt2uf1sYANwhC3DIkM=;
        b=GAF3Y3K1c50hWsCURZ6XsAkK4o2VDbi9dmDpzcfxNPax3ARFtpjGgmt86HElpuiX3m
         6YbTp4qkf79tw4KGRN+uDlWmab5MKxtGVQkoLM9UX0lIx4fF5RMrJ/8KvQN6jjf3+b5h
         s94o/yH7rrPNKQF3/q0j9YUkrOi/gudAQQEUeJar6qpp5ZvPoIevEKOXlhOdRpxRuZTK
         pvBx68VxxPLQcsHpdZLjx+Hotrv23TXm4bYShsSA0DVtBb0KuXtWN83iclTd6b3nVXZ7
         seXEJY59XmljyJMnVSYJgEWt48JpQiIiBf+HOlj87gP7oI4jmF9bw0LS2ozSYOc90Kvj
         h2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730543309; x=1731148109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dS916Ry/hfwr5a1lH3Kd0nANpJt2uf1sYANwhC3DIkM=;
        b=FBCiXv6iEE381vp0O8Bzue1pKAaGQFv+VdhpFzjfXRr31+ltTQOr3pHzSWLUypvY8e
         YWasZSX332HNMPgrbq5FNwdBVmFMUCDBgX6Sua+zRk7PakuNBJIsKsPhwAel3SV0VCeU
         LOm58UhsA4i6OJLU2ACQFIe2JsR1txjrAZgl7W9DCpp4vv63MfxOQ1fx3FJUR1R4JJjh
         BuAyn2TVIc+HSIJ6ZSAmihHYDsmN3fKNdPsszTgnIL2jI/6Ct8TiXQefBDMxXw2SUb4i
         Og03fUN5/JgeqnC3CQOfMEn5Jd8V3O0Z5htValLfl7jyVk30KMQgsufwGOeAS498v6ZL
         Qgyw==
X-Gm-Message-State: AOJu0Yxor0RHKmhgz9R1FZhKzsBWpPZ7sirqfeFXNrEKw0vC6qh10OGF
	0EIi+Gea2/S4nYh/eQBmxo4OyHep8T2mqPGhwRcKpbrLPCFfWJrUNCst+0wfH0pBcA==
X-Google-Smtp-Source: AGHT+IFxCIEcqXKQy+dsHdf6rCzUUVC/S4Fw+ohoVcJQ7JWVctfOUAGveZ+4bt9V1hxGvCD25wxUkA==
X-Received: by 2002:a05:600c:46d4:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-4319ad049a8mr211532905e9.27.1730543308732;
        Sat, 02 Nov 2024 03:28:28 -0700 (PDT)
Received: from localhost.localdomain ([41.217.55.85])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c1189123sm7649570f8f.115.2024.11.02.03.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 03:28:27 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	kristofferhaugsbakk@fastmail.com,
	me@ttaylorr.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2] t9101: Refactor test_expect_success format
Date: Sat,  2 Nov 2024 11:28:01 +0100
Message-ID: <20241102102801.26432-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20241031094554.68916-1-kuforiji98@gmail.com>
References: <20241031094554.68916-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current script uses an outdated formatting style for
test_expect_success blocks, where each argument is separated by a
backslash and newline. This style can lead to readability issues and
makes it harder to maintain the script.The modern style consolidates the
multi-line command arguments into a single quoted block, which improves
readability, maintainability, and aligns the code with current coding
standards.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/t9101-git-svn-props.sh | 48 ++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index b2ee626b9a..792f7896e4 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -73,12 +73,13 @@ test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
 test_expect_success 'fetch revisions from svn' 'git svn fetch'
 
 name='test svn:keywords ignoring'
-test_expect_success "$name" \
-	'git checkout -b mybranch remotes/git-svn &&
+test_expect_success "$name" '
+	git checkout -b mybranch remotes/git-svn &&
 	echo Hi again >>kw.c &&
 	git commit -a -m "test keywords ignoring" &&
 	git svn set-tree remotes/git-svn..mybranch &&
-	git pull . remotes/git-svn'
+	git pull . remotes/git-svn
+'
 
 expect='/* $Id$ */'
 got="$(sed -ne 2p kw.c)"
@@ -94,10 +95,11 @@ test_expect_success "propset CR on crlf files" '
 	 )
 '
 
-test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
-	'git svn fetch &&
-	 git pull . remotes/git-svn &&
-	 svn_cmd co "$svnrepo" new_wc'
+test_expect_success 'fetch and pull latest from svn and checkout a new wc' '
+	git svn fetch &&
+	git pull . remotes/git-svn &&
+	svn_cmd co "$svnrepo" new_wc
+'
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
@@ -110,15 +112,17 @@ cd test_wc
 	printf '$Id$\rHello\rWorld' >ne_cr
 	a_cr=$(printf '$Id$\r\nHello\r\nWorld\r\n' | git hash-object --stdin)
 	a_ne_cr=$(printf '$Id$\r\nHello\r\nWorld' | git hash-object --stdin)
-	test_expect_success 'Set CRLF on cr files' \
-	'svn_cmd propset svn:eol-style CRLF cr &&
-	 svn_cmd propset svn:eol-style CRLF ne_cr &&
-	 svn_cmd propset svn:keywords Id cr &&
-	 svn_cmd propset svn:keywords Id ne_cr &&
-	 svn_cmd commit -m "propset CRLF on cr files"'
+	test_expect_success 'Set CRLF on cr files' '
+		svn_cmd propset svn:eol-style CRLF cr &&
+		svn_cmd propset svn:eol-style CRLF ne_cr &&
+		svn_cmd propset svn:keywords Id cr &&
+		svn_cmd propset svn:keywords Id ne_cr &&
+		svn_cmd commit -m "propset CRLF on cr files"
+	'
 cd ..
-test_expect_success 'fetch and pull latest from svn' \
-	'git svn fetch && git pull . remotes/git-svn'
+test_expect_success 'fetch and pull latest from svn' '
+	git svn fetch && git pull . remotes/git-svn
+'
 
 b_cr="$(git hash-object cr)"
 b_ne_cr="$(git hash-object ne_cr)"
@@ -141,7 +145,7 @@ cat >show-ignore.expect <<\EOF
 /deeply/nested/directory/no-such-file*
 EOF
 
-test_expect_success 'test show-ignore' "
+test_expect_success 'test show-ignore' '
 	(
 		cd test_wc &&
 		mkdir -p deeply/nested/directory &&
@@ -155,7 +159,7 @@ no-such-file*
 	) &&
 	git svn show-ignore >show-ignore.got &&
 	cmp show-ignore.expect show-ignore.got
-"
+'
 
 cat >create-ignore.expect <<\EOF
 /no-such-file*
@@ -170,7 +174,7 @@ cat >create-ignore-index.expect <<EOF
 100644 $expectoid 0	deeply/nested/directory/.gitignore
 EOF
 
-test_expect_success 'test create-ignore' "
+test_expect_success 'test create-ignore' '
 	git svn fetch && git pull . remotes/git-svn &&
 	git svn create-ignore &&
 	cmp ./.gitignore create-ignore.expect &&
@@ -179,7 +183,7 @@ test_expect_success 'test create-ignore' "
 	cmp ./deeply/nested/directory/.gitignore create-ignore.expect &&
 	git ls-files -s >ls_files_result &&
 	grep gitignore ls_files_result | cmp - create-ignore-index.expect
-	"
+'
 
 cat >prop.expect <<\EOF
 
@@ -207,7 +211,7 @@ test_expect_success 'test propget' '
 	test_propget svn:ignore nested/ ../prop.expect &&
 	test_propget svn:ignore ./nested ../prop.expect &&
 	test_propget svn:ignore .././deeply/nested ../prop.expect
-	'
+'
 
 cat >prop.expect <<\EOF
 Properties on '.':
@@ -225,12 +229,12 @@ Properties on 'nested/directory/.keep':
   svn:entry:uuid
 EOF
 
-test_expect_success 'test proplist' "
+test_expect_success 'test proplist' '
 	git svn proplist . >actual &&
 	cmp prop.expect actual &&
 
 	git svn proplist nested/directory/.keep >actual &&
 	cmp prop2.expect actual
-	"
+'
 
 test_done
-- 
2.47.0.86.g15030f9556

