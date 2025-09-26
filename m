Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E042BE048
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926529; cv=none; b=OHWxE2BvRDoGBoiXHxS+0SbseSoXdDrgG8zP5VF3L2N7s/Xsni2u+xfpJWKp49I3zSf3PLEh3mIdrhLZbIfY96RyhPviS+4njYXlJLtskC/6Xooy28cjBGfpsHahzJPieNB3RudJ+HVnlfV+yoPJ4kpeDa2CFbx3Ix8VTKHMdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926529; c=relaxed/simple;
	bh=BTBkqOBo46HKLrO1JkXLChyVjl9VuzfjDtDRU8/t574=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g5lp4ZzfsbSD2HT3vcT1QeQWVoDttwElBg190AvnprsLQNsE/3Ogbd2qqLluYcIERFvBbv7NPn+9PVhJ0eEIeSBAxc+JSGklfQMlVJoeSTe5+QfKZRffNPN/Vozm8k54ntcY0w6lG8bg7Q2VV6VXxPVc3dl1AkV7Slf7oQmnbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd+g/ZFh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd+g/ZFh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27ee41e074dso21331595ad.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926526; x=1759531326; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WErw3AydLrOKz0X239j3/jDTD9XruWWs5KcWhttI7Q=;
        b=Xd+g/ZFh6YI3Foeq+XOzfwojfIQ9klfBlwvhkE/7tBmlL/vitjFCgOlayXlF9dwH/D
         SItTMYQw3sVOj9jf/TA+mdiBAC3zayWRvqfX02ZSQGAhgz4yOnXRYTS/eGgDNitUnZBm
         nsMfEEtBF/m0cKcsuYqFVPzgVJ+bsQRdzeoAcBIyc3WUPsbAICW3i3gH5f/gVDIbVtSG
         bGmsQeYIvBs2qVPDBf0wCRdtIWpiSs5eyiXJEdPqqXAJF3tGpDCTa7jh1HRjqECglw6r
         SUTIELavFpd5CsugwFH7VibDcH0dei9Gw5Cjf5kE9APCpdoNCwPMeOGQhboZK36776rS
         7LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926526; x=1759531326;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WErw3AydLrOKz0X239j3/jDTD9XruWWs5KcWhttI7Q=;
        b=tm8e8kGyf8+zKQNYAve7tt7vOhxh5olfLspk/RJTrTxxzoYIXm++RBrWJkyJUJ55Yq
         b4oDSJae3VfeJ14xL5tx2D44yEnyEybLidfNEovPjlrJsWAH7YgoqYgCIZj5bwyxkXlf
         onPnKCZpVPxnFycCZUpaFJC8KFfnLxqwAYC0w4x5Rgri4V9SWgRkBec4ICzHYwGMjvgD
         2FRgE4qlO7oNWtdeDjQZPF/f7mSgRBEolwmjWe+D80cF9AW6K2gZaTk/ihUmp9JKccu8
         lsCdHp0NpyA9R8nQJLF7D9is+bD9d31TnSmM8kfujvyVmiTn4VgeHPbfsT6zne66aSO1
         tIMw==
X-Gm-Message-State: AOJu0Ywq++/cxEtKylahMPGE3Akmx1D03CxgjTporvHXiFIvuiyxjTtt
	0/3+E9y4MTnaLjh8X8DE25Fa1DITtGpR9MNyarSHEjW4nJBzGExVPZgX+QAicVyJ
X-Gm-Gg: ASbGncuK+Aj44Th6vsflJgK+/rzI+qVFfwBwN6oihM2luOAhqxVXSvyuQ9vkBX21xHo
	33tY26fc8rV/aD2Lu3MsvIi3P2YzzMkqSvRPLAD+phKtQR+yohETIGSEo5KgmreIUHzerOj3xq7
	1wZEojzB/BtAtt9AHKTCEYs5TbinUVSqckGqmBfobRpnxDVtbk4qOGoAbNgFAxSl9EadS6ajZBI
	8TUtt+qn92Lyi9xlAyzersiUGO5vHEEmpxrvqnyl6YrSyLpGvWQTd9m56GTSbBakyaqy8SgWVJ+
	+c5a/cob/UzUiSKOWw2U/Psvus6tBEyfrC1GJlSD8nH83PtveDT7RUMpfjwuQZoebMBqJoAFqdt
	YMpFp3DnTkxB5RDxWdlh8soNUFrXRWuku++8=
X-Google-Smtp-Source: AGHT+IEMfA+6BPg5RhbwWxT4YWIQNJNFLPL9A2WnJ77R7U8qQqAjCCzihTKpskDYmaxtPeyqquDO0A==
X-Received: by 2002:a17:903:3550:b0:269:82a5:f9e9 with SMTP id d9443c01a7336-27ed4a7e8e2mr87843165ad.29.1758926526481;
        Fri, 26 Sep 2025 15:42:06 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90327sm10034460a91.3.2025.09.26.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:06 -0700 (PDT)
Message-Id: <7d3a7e617c68cba19e6ea1195bd6d753a5795a4d.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:51 +0000
Subject: [PATCH v6 04/12] xdiff: delete superfluous function xdl_get_rec() in
 xemit
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

When xrecord_t was a linked list, and recs didn't exist, I assume this
function walked the list until it found the right record. Accessing
a contiguous array is so trival that this function is now superfluous.
Delete it.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xemit.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 1d40c9cb40..40fc8154f3 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -22,23 +22,14 @@
 
 #include "xinclude.h"
 
-static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
-
-	*rec = xdf->recs[ri]->ptr;
-
-	return xdf->recs[ri]->size;
-}
-
 
 static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
 	long size, psize = strlen(pre);
-	char const *rec;
-
-	size = xdl_get_rec(xdf, ri, &rec);
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
+	char const *rec = xdf->recs[ri]->ptr;
 
+	size = xdf->recs[ri]->size;
+	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0)
 		return -1;
-	}
 
 	return 0;
 }
@@ -120,8 +111,8 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	const char *rec = xdf->recs[ri]->ptr;
+	long len = xdf->recs[ri]->size;
 	if (!xecfg->find_func)
 		return def_ff(rec, len, buf, sz);
 	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
@@ -160,8 +151,8 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	const char *rec = xdf->recs[ri]->ptr;
+	long len = xdf->recs[ri]->size;
 
 	while (len > 0 && XDL_ISSPACE(*rec)) {
 		rec++;
-- 
gitgitgadget

