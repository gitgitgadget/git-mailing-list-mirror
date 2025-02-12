Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515231D5CC5
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340264; cv=none; b=er7yBhOiQmoNJ2QB+j4W11wO3chxIXFZkXpoyCxfLl28FjkKMnmDGXEm7dhUFbrlIGETTxnPyY8U/9UuTjsxlsraNj9He/Ny173zm3U8KpZMskaOF3S15o8mWC/b2MsHtDFsrhyNJxg2UZ4UW/1oHlz6x1ju/D72AvW/Q6c23BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340264; c=relaxed/simple;
	bh=lXQjblvtRmvhzmyO/cwJHInTVHBhfiWTpGBIoxvftrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPKziJ3VdHzxnIQrFKD1GJMPfFNyMjmxwvaq7LW/RCa7sh2paH+fFNcHy1T/9j+esnKkteULILKMMLgVvUYR5qdwRdjddoYvaVbdMaDeDHTXw3hLkudMBO6U9noP2eGDndApAS5EbXjlyUEmlLoK8SVqGJ9BfxKpvFTNUZOyuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvJ5ujDq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvJ5ujDq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f55fbb72bso83061445ad.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 22:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739340262; x=1739945062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k4nCQ+nwbNpR8HFDJVE8FSyFVEroX3StH2yQ7Q/jkY=;
        b=LvJ5ujDqOL7isosKbuDE3LSurcYcBDRJtHG/SL96LCw1vPAZZVm+B//wvEGyEoFi7P
         lke+oCV4F8PCifPkm7fsk/cUOjYFn7W1xNGXWBjWDw3AbpOmFt/hr0z8geRd+0mJYBqj
         GsNx0uWW9B13KjaKVISNCUdqQQf0sKmZDpjFwrmd0TlwdppCmC3RxRkwyR6VyiVMomUe
         DDtj2YVaok7eHhB4vmqDZLTSqwVZ0AuhnwWJxPpLQCe/jQeGkjKFaHpZet/f3MnCrIVY
         puNZEh2DLhMKivkwx0mHsyLttoroFUlc94pN4tQ/ZsTeWxPuOoErnmuEndgH5a9wKhvh
         IzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739340262; x=1739945062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k4nCQ+nwbNpR8HFDJVE8FSyFVEroX3StH2yQ7Q/jkY=;
        b=nMKEiSs47NebKgSjd1clEq+oxywKGNeBAAb7Uhvi92g2w/680bkkilhuqbI4inG2M7
         HYVxgKfNaxE5uVB4oB/0VPnUURB09i3S+iYDD8ZYWIamcsJSPZWfApDUNJVO/8scjflZ
         qMmI68ZYrk/JIWzyu4GhbeNnccxQWnrmBaG6DaGSEg/W3ai6vR8YMXeGCzsJBT1APUWj
         zQhWupWOolnbr+6559Jtmo9JEkUwEnQ+tE2MS+pl+CjX3GM8eSK/XtS25UKVEDL6iDgv
         B6g9ZkpppOt9BiH7b5m55LvNPaNh0tsYVwhEc5uJAktKkb/ZhrzrfbeOae6IO7vUdZoM
         Dk5g==
X-Gm-Message-State: AOJu0YzUYWFQ/nVs4wHyZBVOmk9Y68w8d6iIOZV54NJpRU1GeExHVD3N
	Bc1ZmLL9NNXK+YF5sdunbNxT9BaUuEO/msc/5g6aHZQvu/OvE4jbQjtS3A==
X-Gm-Gg: ASbGncv8yWxVLaZSSF8eYkYZ3oAuGWotAp4/9IEdVGpc8odnbgTJ18hlaiUOYqdBAh5
	nnWaOP0TA4NuK9nedONWH/4+WJIi73N0WG0/oRLzsDdxAa7wKyh9byAAxlBZptqKdsNUAeBMfoZ
	tQYxheGmhVx9SxIztAAWZV4/d6nJF/3G6xQkFq5TVce3slLnpZ+yxklJdwkKMr7OmbpUlAOtBz6
	VD63sK2uFcg6hCaqAvmq1l/jY9pFJcAtePFQRedyAf6Ho4O08iwDhrRVXKvICKIcr/giKU5pXu7
	PPfXQAK/r50W3H7DCL/IK5vGdA==
X-Google-Smtp-Source: AGHT+IFf9K+VvMuf4YSWXCCeWCrafF1MRvB1odOELPXi2RWtqvmL+LzqMBociHRCCKmScRezGEALZQ==
X-Received: by 2002:a05:6a21:6f09:b0:1e0:d4f4:5b2f with SMTP id adf61e73a8af0-1ee5c83db92mr5016132637.32.1739340262538;
        Tue, 11 Feb 2025 22:04:22 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53f6e2633sm5747411a12.16.2025.02.11.22.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:04:22 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/6] xdiff: avoid signed vs. unsigned comparisons in xdiffi.c
Date: Tue, 11 Feb 2025 22:04:14 -0800
Message-ID: <20250212060418.1645241-2-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.643.g32d702c6e8
In-Reply-To: <20250212060418.1645241-1-davvid@gmail.com>
References: <20250212060418.1645241-1-davvid@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop iteration variable is non-negative and only used in comparisons
against other size_t values.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 xdiff/xdiffi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 4685ba6137..8889b8b62a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -19,7 +19,6 @@
  *  Davide Libenzi <davidel@xmailserver.org>
  *
  */
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "xinclude.h"
 
@@ -1014,7 +1013,7 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
 static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
 	regmatch_t regmatch;
-	int i;
+	size_t i;
 
 	for (i = 0; i < xpp->ignore_regex_nr; i++)
 		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
-- 
2.48.1.643.g61982db19f

