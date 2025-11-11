Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A73328F5
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890166; cv=none; b=XGkoZ8W+gU8ronOm1LyZdyD03brjrPCer5QkkL+4CI27BweVb7z0VCNea/IdTZDBPYJqUmMqVRxwkaCwJVH41x6oyRqa4y9D3ATG6VjyVsO7jb+37L0WVH1bG0SW00329RkiydP2FqY2tK9vYRSnVCg9tUSTbPCrfUwXQ9F5ezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890166; c=relaxed/simple;
	bh=dI7lUxD0hiRGclLoPlnlVKkLTUTOkd6Wb046AGDINQ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hQcsyhHrxMH7DgITWqrOVZREnlLXT5LXHD5wlItx+HX0vdVOslU75z6xiXV4QCIhA2//pi9tIx+FZHlyfqr0LQFHPgJ61ZosMlrL8iNyQFXm0P42CraX0GFRwXmIvW7t42LWPo0X80NgmPcvPcoVckw5Q5mt6SXbuveNkOjEChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXXhQfvE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXXhQfvE"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8a3eac7ca30so8337685a.2
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890163; x=1763494963; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inwy0uG/WnvZptLXI7EOBeiG3huAXIK2vF/M0jpOTpg=;
        b=OXXhQfvEAPH45Yl6cMDzCJUplNaxu35gUroPGIUk+zB4OoSAfXggwaiUYzRHJmX9NE
         CmV8QdL3ZHzqugMdqAE8hqV8pHYG90KHiDP2AmnRujgQG5SD9cHyw0b6vTGr+Nd9ukEZ
         8cG9/LkJOm+jAJkOdI0edq7oC2eOotXqodvRdSGJUkTOiMf/hQkaNpgT61nMk97I2E/4
         ibFPX4SuV1KVn7sHaTX0hU0RcAnXw5ayLG+jqVmSMmkLr7ZcL4KDn7jAwGkrulcjDF4j
         QrBfH1gZbIVrrfEf1UcpwX1f79vufqnLWSGEZgYxDBtHWEbHaCc7FKZwslxvje9U4Ub8
         j9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890163; x=1763494963;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=inwy0uG/WnvZptLXI7EOBeiG3huAXIK2vF/M0jpOTpg=;
        b=Kihe+3+/uhMpVUOY8eMRPHqI1JdmwNvK2Chc14mb62JO9B075fyX6a6jEotLYJuRbq
         R9e8vu1TGPcCvY7mfbkm6u/O0y/9wGS+Y692dC9Ge6DgGtHq2Xr+ZCWIHuHnqpIbApZC
         gZjnO+XUoCdmVeAwQ3m4cyt96eaNSgQSl+ilIB8Lx+G7T01rVPRCUFUTAfhWLiW0Mxv5
         0DASJKmmXOwX5J691K0dpv4G/0Q3jaWnGPqYOuwFsCR5XpJwcNkL8SpsvLaoEjjFBSNc
         UyMmOd0FSPhUHfn/HTBp5cmz6jQn8FurXitGu9sl/2qnZrFSWYz7Hf3QoaWzyPweHssF
         nIiw==
X-Gm-Message-State: AOJu0YzNuyxTnfpTdsqGlsMX3ZdW6Jhksdt7GoPJUL7dZcN+wbbSwERX
	h/WuFZLcT3O1gRqZZSa5pzn74yrdzloMEXQrqjWYBh/oEadEmDOdyaxaYbt3Bg==
X-Gm-Gg: ASbGncvaae/v3YqPrFoB/NROcMqrHOMIXe+9jCu/eJaB4UUP7e1zT7JO6iez83ByOSU
	5EVKrUMk5baq81kOw7gxvaWNSuBpK5/8HfU3tjVpWhhimIhIMOL2XnR4T1iTG23o3storcZZYlv
	t2nBZNlHuwNcnKiTkcTXur2jxJO7mYhiUCXsLX62bEZBBEC+X2cltIXDMbINXxdkSWyhUzfMg7O
	unIlSYZlLe0Y+yYGNv0xPqfFCvwntsZwHuENpwPaIQ1DIOzyrOJRCbIsKI7U1VIiRAs6lSvmF//
	U7Qkz4jwXWlH30GJhxb7SNrkopezAnh/CWTFcU5svkoZscLO+1RbJZW/sr3D1srWqxM18Xjd1y+
	arvolbTkJRtpW2OcYMsUEkF2D3jsTfIuoFMqOosXImy3Rk1q/0we1z/OtbX6mD66ZuIVaxXq+z8
	JHP54IVFroNj3Jiw==
X-Google-Smtp-Source: AGHT+IExEecA6P1Rh7eLd4BoRqH0QtcEgtQP6m8UkDHblJcHnbYVNwnjYOGCLMV/Sl0Z8BLsJARjkg==
X-Received: by 2002:a05:620a:191b:b0:8a1:7f8a:cdc6 with SMTP id af79cd13be357-8b29b7668efmr71705485a.7.1762890163543;
        Tue, 11 Nov 2025 11:42:43 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a84ae31sm43689485a.8.2025.11.11.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:42:42 -0800 (PST)
Message-Id: <31cd2a1aa4c4205f0875f5608013b3ef9adf7984.1762890152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 19:42:30 +0000
Subject: [PATCH v3 08/10] xdiff: make xdfile_t.nreff a size_t instead of long
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

size_t is used because nreff describes the number of elements in memory
for rindex.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 +++++++-------
 xdiff/xtypes.h   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 705ddd1ae0..39fd79d9d4 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -264,7 +264,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, nreff, mlim;
+	long i, nm, mlim;
 	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
@@ -307,29 +307,29 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * Use temporary arrays to decide if changed[i] should remain
 	 * false, or become true.
 	 */
-	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
+	xdf1->nreff = 0;
+	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[nreff++] = i;
+			xdf1->rindex[xdf1->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf1->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf1->nreff = nreff;
 
-	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
+	xdf2->nreff = 0;
+	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[nreff++] = i;
+			xdf2->rindex[xdf2->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf2->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf2->nreff = nreff;
 
 cleanup:
 	xdl_free(action1);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 17cafd8b6e..df4c5cab1a 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -50,7 +50,7 @@ typedef struct s_xdfile {
 	size_t nrec;
 	bool *changed;
 	long *rindex;
-	long nreff;
+	size_t nreff;
 	ptrdiff_t dstart, dend;
 } xdfile_t;
 
-- 
gitgitgadget

