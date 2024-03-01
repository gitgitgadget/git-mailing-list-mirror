Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698D16FF42
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264799; cv=none; b=jqcUTPs4Ds+k1frS101Jys013MoCz+hEQ+uYHEwP2M7hkBhSxsSc61bDBxQnuZHz+S7nNX37Q1wTZmeJPhV1Bgch2JbqxWhJKzDMWpbvj+bhikWrpJy8oUhHGaCHIIdNRC2BnpJD8jgHteYmOJq/NT5HpCSImF/Dic+CPd3PpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264799; c=relaxed/simple;
	bh=zjRjpbpAeyc13S4Zpikk+fEow/AjJdR/NEZ/FCDy4Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev/GheJGrbTrqvU04pm5RSIj3iOkroq9qcjUSMVlI9ySFruOKrfaGmTajjiSi+c9wOmo2wN0HEpv62aFUFPLe26R1aWSdFKz4T4P22+5uipEUOMjKV4McyZHXyt2l2P1MJr2Ot8Ai8XEa7IUi05j/QSpufXDKxN9qKAN4PKzx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3/NWrAh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3/NWrAh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so14568405ad.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709264796; x=1709869596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dpj4+SM9n+M27HcJliDgtNHjvlQrenBQgETipBmOgsg=;
        b=D3/NWrAhV+orMzXCAXbz/UP/vg+mXwvo/jhn6U+2eFq4Eds3OXhsBOs0KSYKa3aOBD
         knJnqPbDGDLhbrqBJStINKnfetx/HYuCgWMD3oi1/06U4GMaW0OlO8PUpbD9BaVQ77tu
         Ga/IPH7UY/gDCczLQ9yxUwKEE6eidN1gu7AYhUHi8zKQU/aUCvGJM79173NB1hiCp1Jg
         BWqLtSNJWo0aMUtQ4NX4n8ByNJGAGBch4MGLEOxWHbYZ//AOc02Y3nmlwUA7nYRNpr4O
         i2hEeXrt6+JaEqS+HIIK2n5ItdAflLeSZZiL+mpn1vPvYMNyqr5QWQoxvxlqmw0V7Qve
         AU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264796; x=1709869596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dpj4+SM9n+M27HcJliDgtNHjvlQrenBQgETipBmOgsg=;
        b=AhOS6/XwybIWzDUhayZR8OhuDk/1DS7eCmkjh/gp3Whm2e+DPai889e70wmD1qgJW3
         W6CS/O7Vvi3pZP/IhWI24bcUXePk2roC7TId9Q4LBs35PP+wTeQF3zJB6d/9yY4l8bPs
         z5MpncDLCly6UJ/76xZnd6K8vr+Es/CFIo1w5ur1dmFgwA2j8pI4Br0AfkuWS2g9CyYR
         Idv789Do5oDhOaFpuLUrgIORtOJR/v7yITyVpNL9nMce237TDs+gFSE4wMYbkF82Lj1C
         iFF38p6xbJpO7zco61KOw89OWtTJgRYlOZASOYEbQ0tWSEYuNB95BXHw/Y7NhRPrKdgC
         MOGw==
X-Gm-Message-State: AOJu0Yy12edJ2qYe4PaPoPpZ8P2oLvt46hW0hJ1T+N8Qi34/7klztFjK
	4ELcvNB0Xe2nDFQXjWclMLmUld8lMxcJ+q0YLnCEnx/HbJJbehT9qXF1QC6OFY8eVQ==
X-Google-Smtp-Source: AGHT+IFWJMCffeskj95WQa29P4+QgScUQ6bGctiDAwhzwWjmAFRamq44vHcoJH/lxvr51RtEDZZA0w==
X-Received: by 2002:a17:902:f54f:b0:1db:f696:b09 with SMTP id h15-20020a170902f54f00b001dbf6960b09mr587323plf.14.1709264796350;
        Thu, 29 Feb 2024 19:46:36 -0800 (PST)
Received: from ArchLinux.vdiclient.nvidia.com ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902dcc500b001d949393c50sm2295746pll.187.2024.02.29.19.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 19:46:35 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [PATCH 1/1] t9117: prefer test_path_* helper functions
Date: Fri,  1 Mar 2024 11:46:06 +0800
Message-ID: <20240301034606.69673-2-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301034606.69673-1-shejialuo@gmail.com>
References: <20240229150442.490649-1-shejialuo@gmail.com>
 <20240301034606.69673-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -(e|f|d) does not provide a nice error message when we hit test
failures, so use test_path_exists, test_path_is_dir and
test_path_is_file instead.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/t9117-git-svn-init-clone.sh | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index 62de819a44..2f964f66aa 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -15,39 +15,39 @@ test_expect_success 'setup svnrepo' '
 	'
 
 test_expect_success 'basic clone' '
-	test ! -d trunk &&
+	! test_path_is_dir trunk &&
 	git svn clone "$svnrepo"/project/trunk &&
-	test -d trunk/.git/svn &&
-	test -e trunk/foo &&
+	test_path_is_dir trunk/.git/svn &&
+	test_path_exists trunk/foo &&
 	rm -rf trunk
 	'
 
 test_expect_success 'clone to target directory' '
-	test ! -d target &&
+	! test_path_is_dir target &&
 	git svn clone "$svnrepo"/project/trunk target &&
-	test -d target/.git/svn &&
-	test -e target/foo &&
+	test_path_is_dir target/.git/svn &&
+	test_path_exists target/foo &&
 	rm -rf target
 	'
 
 test_expect_success 'clone with --stdlayout' '
-	test ! -d project &&
+	! test_path_is_dir project &&
 	git svn clone -s "$svnrepo"/project &&
-	test -d project/.git/svn &&
-	test -e project/foo &&
+	test_path_is_dir project/.git/svn &&
+	test_path_exists project/foo &&
 	rm -rf project
 	'
 
 test_expect_success 'clone to target directory with --stdlayout' '
-	test ! -d target &&
+	! test_path_is_dir target &&
 	git svn clone -s "$svnrepo"/project target &&
-	test -d target/.git/svn &&
-	test -e target/foo &&
+	test_path_is_dir target/.git/svn &&
+	test_path_exists target/foo &&
 	rm -rf target
 	'
 
 test_expect_success 'init without -s/-T/-b/-t does not warn' '
-	test ! -d trunk &&
+	! test_path_is_dir trunk &&
 	git svn init "$svnrepo"/project/trunk trunk 2>warning &&
 	! grep -q prefix warning &&
 	rm -rf trunk &&
@@ -55,7 +55,7 @@ test_expect_success 'init without -s/-T/-b/-t does not warn' '
 	'
 
 test_expect_success 'clone without -s/-T/-b/-t does not warn' '
-	test ! -d trunk &&
+	! test_path_is_dir trunk &&
 	git svn clone "$svnrepo"/project/trunk 2>warning &&
 	! grep -q prefix warning &&
 	rm -rf trunk &&
@@ -69,7 +69,7 @@ project/trunk:refs/remotes/${prefix}trunk
 project/branches/*:refs/remotes/${prefix}*
 project/tags/*:refs/remotes/${prefix}tags/*
 EOF
-	test ! -f actual &&
+	! test_path_is_file actual &&
 	git --git-dir=project/.git config svn-remote.svn.fetch >>actual &&
 	git --git-dir=project/.git config svn-remote.svn.branches >>actual &&
 	git --git-dir=project/.git config svn-remote.svn.tags >>actual &&
@@ -78,7 +78,7 @@ EOF
 }
 
 test_expect_success 'init with -s/-T/-b/-t assumes --prefix=origin/' '
-	test ! -d project &&
+	! test_path_is_dir project &&
 	git svn init -s "$svnrepo"/project project 2>warning &&
 	! grep -q prefix warning &&
 	test_svn_configured_prefix "origin/" &&
@@ -87,7 +87,7 @@ test_expect_success 'init with -s/-T/-b/-t assumes --prefix=origin/' '
 	'
 
 test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
-	test ! -d project &&
+	! test_path_is_dir project &&
 	git svn clone -s "$svnrepo"/project 2>warning &&
 	! grep -q prefix warning &&
 	test_svn_configured_prefix "origin/" &&
@@ -96,7 +96,7 @@ test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
 	'
 
 test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
-	test ! -d project &&
+	! test_path_is_dir project &&
 	git svn init -s "$svnrepo"/project project --prefix "" 2>warning &&
 	! grep -q prefix warning &&
 	test_svn_configured_prefix "" &&
@@ -105,7 +105,7 @@ test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
 	'
 
 test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
-	test ! -d project &&
+	! test_path_is_dir project &&
 	git svn clone -s "$svnrepo"/project --prefix "" 2>warning &&
 	! grep -q prefix warning &&
 	test_svn_configured_prefix "" &&
@@ -114,7 +114,7 @@ test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
 	'
 
 test_expect_success 'init with -T as a full url works' '
-	test ! -d project &&
+	! test_path_is_dir project &&
 	git svn init -T "$svnrepo"/project/trunk project &&
 	rm -rf project
 	'
-- 
2.44.0

