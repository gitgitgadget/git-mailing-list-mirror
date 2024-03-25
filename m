Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5D82D93
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409157; cv=none; b=PVKih5M4hUU2ibLAVZjGReu1n65L4XjAWggGLsBZjnfrAWNOQb7sOX8b1CvHSkO3XjFd4e4C157qOlH05gyHWQNRPiD08llZvhE8aVTdTT0Xk5zj56iZMfpd9P1ucfUgqHwhzFoBtVm7RDQyF+my+zYpTNUbCoPmiAJ9LNJwoNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409157; c=relaxed/simple;
	bh=7vi9xEIraSQTmgrxuX9lWfU89wiQ3Rx44ve0Uy/5DOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEoq2+p5l0nRYvIeepNMGKdGr8GN/67HoEcI0FYOThBPlAomBLjWvSeDMfg7u0+WO4R/oEOfGcWgWpUp8rx7h8k1Sx90ks8b5Qf5Az9yO2YktAD396s69o2Q3vGiaFPcPelspOkKioHLG8I6mjOn6VzDs4g2OxfMQGyNPPqX5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwJ9VhO2; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwJ9VhO2"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22a1e72f683so1226551fac.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409154; x=1712013954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtZyJeuKt/HRxb8Ihb0j/W0T1+psaZxhXjN6gBA936M=;
        b=jwJ9VhO2BEoitY9JthaVTfSSq3qihIigYDLZZXBa9EGb5e/NxyIYXA7sBWmkZiIyXN
         IdixxJB4Ho17Y/GddrgwOfW4xoVv9WPuTyCL8lgcK1t5WCt7Tubti3K5Nhj+TBS97XZo
         W0kfZQfJqK4crh4QQmJPqm0XDlYXKIPSLsSQB1t7G1Ez+W1z06eOVHrMncJmd4pwQpOH
         np6KXhkh+xVwDwEkAyHRm5oKWIWOaWzP/Obz57LB/oJUML4cAOE72l3KCtmt+QrxmdR2
         30pGOfp+is1+ErurFgf94LeoEmkgBwBAtJqiTdJ0pFOgKiZnltOHhNE6zeJL4yMpIMDu
         T9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409154; x=1712013954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtZyJeuKt/HRxb8Ihb0j/W0T1+psaZxhXjN6gBA936M=;
        b=rINMOya9vZMatL0LtrkefTQkWDYeGlsZVCr8AsLluvp9XHBry5tyvp2zUawUrOvY0W
         IgodXM5FaLZqORcZZ/S5XWNdHf049EcSX75W1wP4S1qJ6H4VDu444+OrOv7REWDMDEr3
         wY6fDMIeejb80UGWGfB61xo0jye+rO0JR43rZTKnLN5KyU6XeOMAI8EtNx6qX2joTW2w
         oq5idepBrEcjl9lZjgNYrcTtFD8m27nmqkK5riOjYPZF5cdEFu3upniFEA7ETWo9vL/p
         AW94j3Jj6a7obICe0zVjgiiNxffOsr+C0fLkOawcXZrdNwC/UWG3RgapmkNRwceTDZCj
         lL1w==
X-Gm-Message-State: AOJu0YySdtmzWct+oHIjiFU2sdf3aBG2MYRPtVGuVNh7iu5mLzVOuFX0
	0yt/OYfxMGSibXbAFaf5bxFnhWTArAKKPr0W9XvooT/PEBUPujjw2hRsQVdNTeI=
X-Google-Smtp-Source: AGHT+IEL4YZzDOyueXg3s7BV8uqLELF4hbXmbPDxUkK+4bTmvRK/6bYfWljHpGYRhrmZjzCL+9/mAA==
X-Received: by 2002:a05:6870:f699:b0:22a:1e0c:812c with SMTP id el25-20020a056870f69900b0022a1e0c812cmr7601679oab.37.1711409154159;
        Mon, 25 Mar 2024 16:25:54 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id vp8-20020a056871a00800b0022a1d794bb8sm1454868oab.22.2024.03.25.16.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:25:53 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 1/7] docs: address inaccurate `--empty` default with `--exec`
Date: Mon, 25 Mar 2024 18:16:48 -0500
Message-ID: <20240325232451.963946-2-brianmlyles@gmail.com>
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
2.43.2

