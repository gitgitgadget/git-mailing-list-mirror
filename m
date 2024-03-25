Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD1839E3
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409159; cv=none; b=m3rnkdurLb+UH8jM4k86IFEm8KbaX8B0KEqzbVpHmieofcXRfUGWShi1jBw0vmEoMn4+oca31GP7x9elzCZp0gP+JyDSZZA1iaZPafx2NyxRLeCFShp7I0u0wwVUwOpqc1mtLUsNcyFG32Tjs4gcqmdC2NmOyBMEstktlHjVxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409159; c=relaxed/simple;
	bh=kStL5dchvVaRhLI2j5rvtL321b5d/OQ2h0ZwtPZHLD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAC0qgmGoxLiOj4lv0XG46YREgS4Fs1793CLkzHVlV9caqXX8k4VW5D/Hua89MyXsYKFxe9Kk+BXHYr96or15c/YdxfVatVBb0U+djnb0XZ0NtI6vcACt28GwTablHABnjv49D0Jaz0vv9x5tvgspT7VSEsvReLhj2wmLcn8IBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYwzqJDy; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYwzqJDy"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1e992f060so2061461b6e.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409155; x=1712013955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPlWsMoiBeRoa6N+S9fF/C4VJbCmKCIQK/8ktmFQ9dU=;
        b=XYwzqJDyDUlxgk+BvBJw/uxuijTBUs5zh8Q5p8+4Y7coSl+EzF8mjmrb1yK6uYqyUb
         TExQx0LBdJFDdD7dAFSSXQE6+Pf3S490Sg7Exyleg/AQAxWNqh7YtNGHtXrT4zYahteb
         EF7vWPmbVgck3UbysLtWiF0uPDdPBtJNHDi1pmmFCg2fVAosM9svBBg4+rwXvn+rKPEC
         iB1paM3X2UhBYVJaYjGGtm6jUNuVNOricuTMBfx3CTk5FbdKC9j16Q8jnB/GORjpvhOc
         xPk45+G2pd0gMle1sITx0ACe+IMpnmSrtNBPm6mFLESYA5oNcv+Bde9d8PtQdDSa1H3E
         7jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409155; x=1712013955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPlWsMoiBeRoa6N+S9fF/C4VJbCmKCIQK/8ktmFQ9dU=;
        b=YiVxuQQ6KTZD50MBaWyIJiZmsEOoDoQFu72xYZuMOE27KCiQpuvCdt9Zm8PfIA/X+s
         2915o0Je8IXXtUkAGgd90NtfoN+G5lNQ+WTnG9Ik4orzKj5hYT/VQNk8HIamEIUN5Gzj
         OMYYgwGpZVA3s8GZuor4dMC73HJO+uNBweKlbEInVEaRWeNfvQZfpE2mENQe7Si5R0/U
         tf0M3CIFvoDAo+ftPayqxVCHYgV88PtIAxUG81slUJp2u4ERJijEQb3CypzCvTxlphX7
         9Jj2LkP/5MihFoFjp0/NliEjAQZam4Ads10Pe+FlI5Jp9mi3+2vyV/Mjfm29dbVi4yqZ
         SVqw==
X-Gm-Message-State: AOJu0Yx/6PRoIF8tFSx3mPDvIeXwLYAe/xv8E2ZnzJaWSAM5RIXuJVOe
	6FME1P5cHNAYU/GB5TjcfBWi7tBAJKQMkzCfC8S7kuJLrPzD6Hxmf6W9pUgU8Bw=
X-Google-Smtp-Source: AGHT+IGFxZ2Ku7x7vh7Agt2d8ti0BCn+i2wEwFDD1rTcO+SGk6i9EKbeiherfKWgnFESnXhgsu4WaA==
X-Received: by 2002:a05:6870:a453:b0:22a:516b:2284 with SMTP id n19-20020a056870a45300b0022a516b2284mr2768291oal.30.1711409155267;
        Mon, 25 Mar 2024 16:25:55 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id vp8-20020a056871a00800b0022a1d794bb8sm1454868oab.22.2024.03.25.16.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:25:54 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v5 2/7] docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
Date: Mon, 25 Mar 2024 18:16:49 -0500
Message-ID: <20240325232451.963946-3-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both of these pages document very similar `--empty` options, but with
different styles. The exact behavior of these `--empty` options differs
somewhat, but consistent styling in the docs is still beneficial. This
commit aims to make them more consistent.

Break the possible values for `--empty` into separate sections for
readability. Alphabetical order is chosen for consistency.

In a future commit, we'll be documenting a new `--empty` option for
git-cherry-pick(1), making the consistency even more relevant.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-am.txt     | 20 +++++++++++++-------
 Documentation/git-rebase.txt | 25 ++++++++++++++++---------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index e080458d6c..f852e0ba79 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -66,13 +66,19 @@ OPTIONS
 --quoted-cr=<action>::
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
---empty=(stop|drop|keep)::
-	By default, or when the option is set to 'stop', the command
-	errors out on an input e-mail message lacking a patch
-	and stops in the middle of the current am session. When this
-	option is set to 'drop', skip such an e-mail message instead.
-	When this option is set to 'keep', create an empty commit,
-	recording the contents of the e-mail message as its log.
+--empty=(drop|keep|stop)::
+	How to handle an e-mail message lacking a patch:
++
+--
+`drop`;;
+	The e-mail message will be skipped.
+`keep`;;
+	An empty commit will be created, with the contents of the e-mail
+	message as its log.
+`stop`;;
+	The command will fail, stopping in the middle of the current `am`
+	session. This is the default behavior.
+--
 
 -m::
 --message-id::
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3334e85356..0b0d0ccb80 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -289,17 +289,24 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---empty=(drop|keep|ask)::
+--empty=(ask|drop|keep)::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
 	empty after rebasing (because they contain a subset of already
-	upstream changes).  With drop (the default), commits that
-	become empty are dropped.  With keep, such commits are kept.
-	With ask, the rebase will halt when an empty commit is applied
-	allowing you to choose whether to drop it, edit files more, or just
-	commit the empty changes.
-	When the `-i`/`--interactive` option is used, the default becomes ask.
-	Otherwise, when the `--exec` option is used, the default becomes keep.
+	upstream changes):
++
+--
+`ask`;;
+	The rebase will halt when the commit is applied, allowing you to
+	choose whether to drop it, edit files more, or just commit the empty
+	changes. This option is implied when `-i`/`--interactive` is
+	specified.
+`drop`;;
+	The commit will be dropped. This is the default behavior.
+`keep`;;
+	The commit will be kept. This option is implied when `--exec` is
+	specified unless `-i`/`--interactive` is also specified.
+--
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
@@ -704,7 +711,7 @@ be dropped automatically with `--no-keep-empty`).
 Similar to the apply backend, by default the merge backend drops
 commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an `--empty=(drop|keep|ask)` option for changing the behavior
+also has an `--empty=(ask|drop|keep)` option for changing the behavior
 of handling commits that become empty.
 
 Directory rename detection
-- 
2.43.2

