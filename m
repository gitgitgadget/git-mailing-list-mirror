Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1D439AD5
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096418; cv=none; b=EoArrqmpft5c5HS6TaYZxOHtJBeFz47TKGS57xYH0yUxcabKU68BdlMCWnMt6yiAbamJ1EvDzn7jD3bd08kk/JyJ+Y38Th+FVOqSi/Emav1EKDBFUHtQSH0zU1J6wBCXTcOMty4+rfHq6E54/o14FxyG1C2ClHL8Q8IYIAiby1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096418; c=relaxed/simple;
	bh=OCKX7tYfYuiWPNM7no5O+X8SdFxu6kWxUtX6zRtx+cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVoT65VtRz2MElNyAj/WL1a/zi0N3x/PdW6fjyIEgJ/tx35Pzj8pbaP2CZo4V+TIEwiRzIvEwI+6/rDS/EkvJNZe/7rMFreqquTdCOE1vJ4vCDxBUq49300SsE1OHfh6sjVFB4nycDZaBQ/d+4iAl6Az3n84mkEzHCPhWDx57w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqnWsTqj; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqnWsTqj"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a1d83a86e8so664225eaf.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710096414; x=1710701214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93lxL14z4HxSLAYV64yswSeX4EUoZ+Ng9fdsyPz1iJY=;
        b=dqnWsTqjP2TAzqy0MHa/LyrmFnydOIgSZy4GrKkC+oRusaAPDaDRaTJZoTEc/6MZVf
         fBxwkxBU3HRq4583SZjBqdjKB74DHocMUbTS2IpkT2FW4X79zmrFK/7XS/BNtjwrPwdH
         zM+qzUtBHReAIZNye2yK/lnKXlGPSNszodDSKFd4YShH8UQJyN0hXKAqg/n3Kwj6QDoF
         eETeIzJ+hYyJ0PopDnlNs/Z2c/jAVqZD4+TO9LTIJe3TnDii06LxWkAZVrsP2cz6ZfL8
         Gk7EQr6uzosV2SyaObubfmG2pKkwN39eoxa3CU3ddyCnmob8bjZ8y2WCH/IoUUFtc/zm
         qTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096414; x=1710701214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93lxL14z4HxSLAYV64yswSeX4EUoZ+Ng9fdsyPz1iJY=;
        b=cRGRuOe4L3rJ3BwXCADLvL38SM6lUcHst60VbUSU3IsesO8NcAabHctHVBjyeG22gk
         hvGYfkumOfP0eCR9QuiO6FHfNvAiX6f7AaEc9KTFXMR0jplplaa7lKIqOqInCJd46noH
         PWal5eA4Yf9BOQF/KjykKLBiSQR+mtOJ74EId55NACbPnieMUtZTKIxuGBGPICwWJbas
         Qsx2kH6kncaLR7X9C4TwgnHa0goa0HBTjSByfrYWvtXWHlziVflkJm1jaW8l28qloS+o
         YZkFzxh2Hq+X9d5cwqe+s7bBsNXqlMOO1jizS2b8bkHwEl96H49lj4ctzEv9Ja6soTPx
         SZvQ==
X-Gm-Message-State: AOJu0YzsrYzfjPDahF2qZjJUAZLMmCI6mjEYTjxI5nAHNNR1JrCOhqph
	5x8bDjNu9frw0BI5blQhghcAp/PATo+AuPsGWfrGAnbBE0W8OZtonjAcrmNphoE=
X-Google-Smtp-Source: AGHT+IHBb/c8sL7kg6oQSrI33+m+oF+Km9bYqxvrfqkD1NA42KoFRBCg0yyDjq/ZZ03r2PJ27rp7zQ==
X-Received: by 2002:a9d:77ce:0:b0:6e5:2f0d:dab9 with SMTP id w14-20020a9d77ce000000b006e52f0ddab9mr1191704otl.29.1710096414377;
        Sun, 10 Mar 2024 11:46:54 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id l8-20020a0568302b0800b006e4c97ec1f4sm742131otv.69.2024.03.10.11.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:46:53 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/7] docs: address inaccurate `--empty` default with `--exec`
Date: Sun, 10 Mar 2024 13:42:00 -0500
Message-ID: <20240310184602.539656-2-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for git-rebase(1) indicates that using the `--exec`
option will use `--empty=drop`. This is inaccurate: when `--interactive`
is not explicitly provided, `--exec` results in `--empty=keep`
behaviors.

Correctly indicate the behavior of `--exec` using `--empty=keep` when
`--interactive` is not specified.

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/git-rebase.txt | 10 +++++-----
 t/t3424-rebase-empty.sh      | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 06206521fc..3334e85356 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -295,11 +295,11 @@ See also INCOMPATIBLE OPTIONS below.
 	empty after rebasing (because they contain a subset of already
 	upstream changes).  With drop (the default), commits that
 	become empty are dropped.  With keep, such commits are kept.
-	With ask (implied by `--interactive`), the rebase will halt when
-	an empty commit is applied allowing you to choose whether to
-	drop it, edit files more, or just commit the empty changes.
-	Other options, like `--exec`, will use the default of drop unless
-	`-i`/`--interactive` is explicitly specified.
+	With ask, the rebase will halt when an empty commit is applied
+	allowing you to choose whether to drop it, edit files more, or just
+	commit the empty changes.
+	When the `-i`/`--interactive` option is used, the default becomes ask.
+	Otherwise, when the `--exec` option is used, the default becomes keep.
 +
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 5e1045a0af..73ff35ced2 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -167,4 +167,42 @@ test_expect_success 'rebase --merge does not leave state laying around' '
 	test_path_is_missing .git/MERGE_MSG
 '
 
+test_expect_success 'rebase --exec --empty=drop' '
+	git checkout -B testing localmods &&
+	git rebase --exec "true" --empty=drop upstream &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec --empty=keep' '
+	git checkout -B testing localmods &&
+	git rebase --exec "true" --empty=keep upstream &&
+
+	test_write_lines D C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec uses default of --empty=keep' '
+	git checkout -B testing localmods &&
+	git rebase --exec "true" upstream &&
+
+	test_write_lines D C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec --empty=ask' '
+	git checkout -B testing localmods &&
+	test_must_fail git rebase --exec "true" --empty=ask upstream &&
+
+	git rebase --skip &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0

