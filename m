Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015936828B
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326676; cv=none; b=LhlikKc1rcUS2Ird8ZwP8Z5D81h1NdO14KaLP0E0frHXIgRHwuntL9mmInAmxbprU/L3S4NRwd+tC6h3HWAOMjqQ62JDNobHP3nL//yi9B8mBksuDzuAW6SqPvyZH7CihJBcc3K49nbKYXqPYVzOC9+jmgJ5vDTRYTTcmXYcCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326676; c=relaxed/simple;
	bh=Y9dmJJ9BodHKfigvrGCmLdtS/nmbfEJ0ccK8bxCQtXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LDn99IrZ87z+l2AADb0ZZZydpyvaEh43h1lfIbVvSswvtUahOoTjJ7BJpJrT0+Biq+ddZ4kJVCJxF/+E4m5FNd2eGfrXoSdQCIHM8Kf4Gt5FwihQk+m/VxvhadtB4Zh0FrwS1OHWyZL0pwbscpkPd4ocaOkfdKhdS/SpXDkY6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXQP769n; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXQP769n"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90e9e042ee1so29974816d6.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789326673; x=1789931473; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ON9c9TKY4MNUZwbIHzrMaWzEBuXram4HuIBT1PWicHM=;
        b=HXQP769nct7aU0igvumyyM+if05qZxPBOdi5aEsJGCRvuMD92in+8IaPvptSjJ1DyE
         opEcH0WdO7xYGA5uQ6lyGAzfCROgqYrvAikVvT/1doJrNLGrJdWjAI8bE+Mm6ZIYkrQx
         X744nMd2aExZaYsAZ9xpKGd82MYnSpfEEkbDvUVb5iH7oW0+paWAiAczwTY8eBcBaXmv
         xEkDmCQs6kYa01AVqw4Oq63XMr4ngu8H4BWy4+r0enjVMXiqEIZsY+VUQPnOTHj8mdQj
         XT/xeJOm7oEXM7TjVEz3Cohx2Bgai8MUolEzQ/DtN05P6ABxvcZvTno5LIBeB758kRVC
         5clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789326673; x=1789931473;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ON9c9TKY4MNUZwbIHzrMaWzEBuXram4HuIBT1PWicHM=;
        b=C/Oop6+SoCvKgTzSJeoUWvhWpMyEjCd6xY7ZsRPS94zXt3LaypBwFe8uRC7klN0kow
         XZCZVncEHWYWUXvR6YsSAHm5KHbVqh3M2TLikSE0yz9sfuWsWeFmRvacw9Q3+ODozJ/B
         P6XG0o+fmaQhjm3qiwV7PrZnrOjdindDtGK2sXw2xBNiC5TJ/0O+FDKvouJQ+4IKpwI6
         nVdwkmQqzgr914qq4GGwJqqWCEq7ucme6HzxlK6n1ZAyG3M2A7aVY5bPaBikB9jbg67E
         VvvYpagxlfIHSr0UN0BQUM+u93CMINdY9srdVUvZHFj09PtJKQSjVQQAPqrbdTVmgAJH
         T4xA==
X-Gm-Message-State: AFuF++lgjfJpW4NT7ICd5v9CQTjkjtIUyGWpBh3CGRzXX4oX/qeg7yN3
	P5o9kISjlJDvhhQGxKtgJaKhbov6kb/BoUWKfeGOPtVyaYvHvSrf9uSfHY/d8Q==
X-Gm-Gg: AYBFou2qw78n4DlnsW3Qb3SDfwbwzzx1irlqWjyamkCj2F0WcMusb02lIqHgtn+G7e6
	vl+z5Q0HY4jlp/w/AlLjr8cw2kxz2f1T/hhalsj4J98QE010fxQMOL5AnF7hJ45VBqLj1pSez4+
	TgPLcMVHLymiONkPlHxIeUQVAQY3vRQSutTS9qFYkg2AMLaU5o/2P+hOOphUd5Uhn1BpAOIMTr0
	bCd6TpH6yObOw/clymHjda2j1vFeVAlLzuHXHnEg3NPV72+IZrgXuqsxlPwe/4Sow6z+K7ej+N6
	rUJJcNB6Y/JMFe1vm8N09tOZnadM/zD0GuXf8MipmgxB1gW9jDC5U98i4mms4XWSL8QTapvXw9R
	2bOXJgAybNQOWFC6RHFtMYfH8+32ytJWGgAIy2liYX0mi63uhpLoqJn9kWcVaRTut8BQu3mfQCF
	WhdtJWsW+3XCWgBNxHuq9l6iq+O4v4S40wIArcsJKWcS0F45793ZCpypBGJbF0V+RZHRlSXIFAu
	cY=
X-Received: by 2002:a05:622a:c4:b0:530:fc4d:7348 with SMTP id d75a77b69052e-530fc4d7405mr47606811cf.48.1789326673333;
        Sun, 13 Sep 2026 12:11:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530f9b99fc7sm26294151cf.30.2026.09.13.12.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:11:12 -0700 (PDT)
Message-Id: <8d065f1b4f6f2a40cd9154cac460ef9dbc959488.1789326667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2227.git.1789326667.gitgitgadget@gmail.com>
References: <pull.2227.git.1789326667.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 19:11:07 +0000
Subject: [PATCH 2/2] t9129: skip UTF-8 tests on Windows
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The assumption of this test is that Perl and Git have the same idea how
to perform encoding conversions.

However, in Git for Windows, Git is a native Win32 program, and such
programs have a very different concept of encodings (called "Code
Pages", and they are not controlled via environment variables at all),
whereas the Perl interpreter used in Git for Windows is a pseudo-Unix
one that uses the MSYS2 runtime (which _does_ try very much to abide by
Unix' `LC_ALL` and friends, and totally ignores Windows' current or
active code pages).

As such, these test cases _cannot_ work with Git for Windows. So let's
just skip them on that platform.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9129-git-svn-i18n-commitencoding.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 01e1e8a8f7..f72a425dc1 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -71,7 +71,7 @@ do
 	'
 done
 
-test_expect_success UTF8 'ISO-8859-1 should match UTF-8 in svn' '
+test_expect_success UTF8,!MINGW 'ISO-8859-1 should match UTF-8 in svn' '
 	(
 		cd ISO8859-1 &&
 		compare_svn_head_with "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
@@ -80,7 +80,7 @@ test_expect_success UTF8 'ISO-8859-1 should match UTF-8 in svn' '
 
 for H in eucJP ISO-2022-JP
 do
-	test_expect_success UTF8 "$H should match UTF-8 in svn" '
+	test_expect_success UTF8,!MINGW "$H should match UTF-8 in svn" '
 		(
 			cd $H &&
 			compare_svn_head_with "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
-- 
gitgitgadget
