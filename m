Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768A2D29BC
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935879; cv=none; b=cvGwV/CTNHWOTQdd0A5lPuRlFky9mdf0weme/hCUrqR9RfjXWxhJQQ9KBU/RHM9dF386chbH5xo0Yf9GOSSbGSBIGdSuBnb8E8YQgxeggOhfcZrTbVjn7kzFY27fkqkaRZ1+jjfFIA8oIdjknhucLu9hfcdVJYfR60JTw/nGbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935879; c=relaxed/simple;
	bh=5LK50v+RXvPtVm1rFaoGKAtjooIqistOHOGZj/a3ZVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cb0rJpo2fYJd0J/z2Ffdaw2kS4y8t+6rWCzN6IGWaGAJ5GDYlG0RrKCbvAsUvi2oiCFUdOQpXXR8bxSKZBu7H+Rf+UGuA59saUrW54NgjKjTh5Zx1icLRdT3qqCEOaml6H5QEObSPQxFHCD7eU/tqHzyfPoi03m7GWHhXJQLAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de; spf=pass smtp.mailfrom=campus.lmu.de; dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b=BfHa1EPu; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b="BfHa1EPu"
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4Zn2Kd3dghzyTk;
	Tue, 29 Apr 2025 16:11:01 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=lmu.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmu.de; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=lm-postout21; i=
	@campus.lmu.de; t=1745935860; bh=8y9tTYiDal0FrV9pmQBQ30K5+DK3MX7
	HB0+UvT//l/0=; b=BfHa1EPut8IofoA7CnWRCJA+WLh80c+vP0s/6m79nQ3KZ44
	I3b3D+pr+Gd0WoEP7nggOVmlydoLyNHgUgyTH6CeuJupvmbtT8L3Sq9ye1qxTBFM
	HLCxp4eWRNSLPnS4YEDEQ++r6uLVsJsHMy0yALVpadmdb1pusqGm+/aJozmvGCyi
	YZjiWshEOuWC19bPfNUIkaGbCJ+QOMmT5r/1PnPd/1xvJlbizO2ejHFQwJ1LWvSP
	uYSJPacsOea2wafNfy7t9ISJgfizaE+o4iH4CRUhb6+SDji9Q7Yj1R3w35sRkkeR
	szzVNMRxOhpTpfFvyq+WYxfawJCWfXNk916v8Ng==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.883
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
 by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id MRYfZZZHnzYv; Tue, 29 Apr 2025 16:11:00 +0200 (CEST)
Received: from niels-ubuntu-2023.eduroam.mwn.de (unknown [IPv6:2001:4ca0:0:f238:a621:f0ab:b2e0:fe13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4Zn2Kc1CvTzyV3;
	Tue, 29 Apr 2025 16:11:00 +0200 (CEST)
From: Niels Glodny <n.glodny@campus.lmu.de>
To: git@vger.kernel.org
Cc: Niels Glodny <n.glodny@campus.lmu.de>,
	phillip.wood@dunelm.org.uk,
	johannes.schindelin@gmx.de,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v3] xdiff: disable cleanup_records heuristic with --minimal
Date: Tue, 29 Apr 2025 16:09:49 +0200
Message-Id: <20250429140949.2634935-1-n.glodny@campus.lmu.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
References: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The cleanup_records function marks some lines as changed before running
the actual diff algorithm. For most lines, this is a good performance
optimization, but it also marks lines that are surrounded by many
changed lines as changed as well. This can cause redundant changes and
longer-than-necessary diffs.

Whether this results in better-looking diffs is subjective. However, the
--minimal flag explicitly requests the shortest possible diff.

The change results in shorter diffs in about 1.3% of all diffs in Git's
history. Performance wise, I have measured the impact on
"git log -p -3000 --minimal > /dev/null". With this change, I get
  Time (mean ± σ): 2.363 s ±  0.023 s (25 runs)
and without this patch I measured
  Time (mean ± σ): 2.362 s ±  0.035 s (25 runs).
As the difference is well within the margin of error, this does not seem
to have an impact on performance.

Signed-off-by: Niels Glodny <n.glodny@campus.lmu.de>
---
 t/meson.build           |  1 +
 t/t4071-diff-minimal.sh | 14 ++++++++++++++
 xdiff/xprepare.c        |  5 +++--
 3 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100755 t/t4071-diff-minimal.sh

diff --git a/t/meson.build b/t/meson.build
index bfb744e886..8f2e9d2c50 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -501,6 +501,7 @@ integration_tests = [
   't4068-diff-symmetric-merge-base.sh',
   't4069-remerge-diff.sh',
   't4070-diff-pairs.sh',
+  't4071-diff-minimal.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4071-diff-minimal.sh b/t/t4071-diff-minimal.sh
new file mode 100755
index 0000000000..4c484dadfb
--- /dev/null
+++ b/t/t4071-diff-minimal.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+test_description='minimal diff algorithm'
+
+. ./test-lib.sh
+
+test_expect_success 'minimal diff should not mark changes between changed lines' '
+	test_write_lines x x x x >pre &&
+	test_write_lines x x x A B C D x E F G >post &&
+	test_expect_code 1 git diff --no-index --minimal pre post >diff &&
+	test_grep ! ^[+-]x diff 
+'
+
+test_done
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c84549f6c5..e1d4017b2d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -368,6 +368,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	xrecord_t **recs;
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
+	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
 
 	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
 		return -1;
@@ -379,7 +380,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
 		nm = rcrec ? rcrec->len2 : 0;
-		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
+		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
@@ -387,7 +388,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
 		nm = rcrec ? rcrec->len1 : 0;
-		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
+		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
2.34.1

