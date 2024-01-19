Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A684C6B
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705644811; cv=none; b=MrtvRy3L5TUdZ+lVP3Q8wP+SdPd+QyorR9IS5XqK3Q5VPbFmAAF3Bwa7ektXSQEul036URkj9ZqVnDz8fmC62rbD6bkOp8yIFuqWoKLXY7pnXHD/eVwO0BTgWgwdAITDHFcEufWlE0GJjXn5A7QZQ3trGYrMmB1NlWldJWlzOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705644811; c=relaxed/simple;
	bh=Ydix5KtKopQNAktjnuuvoLuvkI4vFUmgzKx1qIH8wD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6PKgnXhoYerx2oq9hKicQ9+0PHqCxvBO9+n7Aa/kNZE7kkL+93yZzs/s8YNzkeNif7U1Jaqzni0ri2k/B+xBt5rXghuJ+rbH9FO0C+PSaGtXLDT9/0vVhCUsxCtfb5rIQgDbtWIQxqDVAqXs3LIJXvVDufNypW0AYiWG3QbgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+Gtxeh0; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+Gtxeh0"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4b7fc7642fcso143617e0c.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 22:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705644808; x=1706249608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muBAlT/xliW8oO/cZE1jTJJhDe0VG5uxjuiSbAemcBw=;
        b=U+Gtxeh0aTLSytM4p/8OS+D7C/jV5aAXapErjXp1oRQjV+z+aweu5PyJQGrsGTDKh9
         sJhITqme+pjzdoA9TmCNdY0v2Qx6+0IPAAH9JTjQl8TJgvHbHhGV49wtbGTR7SQXQh7w
         ZAFkiENpG+uVfrde62DHu0t24AlkwcBCmUSRAVY4F+7cRZ+kouH5skRfe6XxcYidn5zd
         Trtr9NUT7fP9WocyahPQpoXM/GHginJe8SE8BiYBXvGEk4KO4EhQtNu0A3p2f4ahYts/
         l2yQMJHKaPASo/aUAC4+Z+18DfxNGCgVT+AiaXOX7c3xw8BLivE07Q5Brd7kYf29esr/
         +sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705644808; x=1706249608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muBAlT/xliW8oO/cZE1jTJJhDe0VG5uxjuiSbAemcBw=;
        b=TLb8Azhncz7us+YpqtORPE4YsIFIqPgpPDUDhO7PJA+OqBsoHjlxaJleXK4zUhs9Xx
         YwngSdOo9xXfJfJC79uEnEBCSyqqvvjZRW2vYH8QZ+MUOWIGLGUTMzQnbpHQpo53ViVA
         XtmG4M1cFX/e6G0AFTSogHztN37VDtjA2TgAHuT4UIJweRx6kY3enCAjWL9UfCgnNP9t
         +/8FFISpQDyBtrDE2KajSfEm39W+aakzrhTKYKmnbVtwduHPh/BVNVxwiCbe52Bmr60l
         RdmpgKNk9dnPicNyiCVqCPUmbtyj4xZuv7CoSmSC0XtugcmrFBUYd+m36yWnvRtd48a2
         BxSA==
X-Gm-Message-State: AOJu0Yyj0xIjR9TbANVa3UBHdGUytG6JlqaAzT926tKz/9bbr+Y8hyez
	MOb+H61+KfA1EaIPpvhK1lnDs/t3RqWiQE1lndgroLwjtOyBuWjlWh5312nI
X-Google-Smtp-Source: AGHT+IF4CDsjmcYHANHY4mMAbtTcJTsGaCBqlclIuBy3rPCyZxxnEjnqgvLoi7hSydA4fSdvg9Nu6Q==
X-Received: by 2002:a05:6122:45a5:b0:4b6:e2a0:bc1a with SMTP id de37-20020a05612245a500b004b6e2a0bc1amr1741216vkb.13.1705644808117;
        Thu, 18 Jan 2024 22:13:28 -0800 (PST)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id op23-20020a056214459700b0068189a17598sm1365062qvb.72.2024.01.18.22.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 22:13:27 -0800 (PST)
From: brianmlyles@gmail.com
To: git@vger.kernel.org
Cc: me@ttaylorr.com,
	newren@gmail.com,
	Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH 2/4] docs: Clean up `--empty` formatting in `git-rebase` and `git-am`
Date: Thu, 18 Jan 2024 23:59:18 -0600
Message-ID: <20240119060721.3734775-3-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Lyles <brianmlyles@gmail.com>

Both of these pages document very similar `--empty` options, but with
different styles. This commit aims to make them more consistent.

In a future commit, we'll be documenting a new `--empty` option for
`git-cherry-pick`, making the consistency even more relevant.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-am.txt     | 18 ++++++++++++------
 Documentation/git-rebase.txt | 17 ++++++++++++-----
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index e080458d6c..77df5e606a 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -67,12 +67,18 @@ OPTIONS
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
 --empty=(stop|drop|keep)::
-	By default, or when the option is set to 'stop', the command
-	errors out on an input e-mail message lacking a patch
-	and stops in the middle of the current am session. When this
-	option is set to 'drop', skip such an e-mail message instead.
-	When this option is set to 'keep', create an empty commit,
-	recording the contents of the e-mail message as its log.
+	How to handle an e-mail message lacking a patch:
++
+--
+`stop`;;
+	The command will fail, stopping in the middle of the current `am`
+	session. This is the default behavior.
+`drop`;;
+	The e-mail message will be skipped.
+`keep`;;
+	An empty commit will be created, with the contents of the e-mail
+	message as its log.
+--
 
 -m::
 --message-id::
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b4526ca246..3ee85f6d86 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -293,13 +293,20 @@ See also INCOMPATIBLE OPTIONS below.
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
-	upstream changes).  With drop (the default), commits that
-	become empty are dropped.  With keep, such commits are kept.
-	With ask (implied by `--interactive`), the rebase will halt when
-	an empty commit is applied allowing you to choose whether to
-	drop it, edit files more, or just commit the empty changes.
+	upstream changes):
++
+--
+`drop`;;
+	The empty commit will be dropped. This is the default behavior.
+`keep`;;
+	The empty commit will be kept.
+`ask`;;
+	The rebase will halt when the empty commit is applied, allowing you to
+	choose whether to drop it, edit files more, or just commit the empty
+	changes. This option is implied when `--interactive` is specified.
 	Other options, like `--exec`, will use the default of drop unless
 	`-i`/`--interactive` is explicitly specified.
+--
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
-- 
2.41.0

