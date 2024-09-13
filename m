Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0266F2F6
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247797; cv=none; b=Imtkp86bkcZqlhpEQlttQsp7R7aepCeDbXFaBBUWfbjWoPD1enh4TcVSwSq+usrSHaa/zG4ss6NfOX+0PIgdUJtNdIsIt24hriOG7C/Of6VgfQKF73z4PIymrXoZInwIe7KliYtt0ksCbtMKPK5He7fd2AgXg2p2cQJdcWkC5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247797; c=relaxed/simple;
	bh=Ei76NNn9ZuIt6/c5YZrfkWpABLETbb7A2ZN7vYE2UAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV3jF7wAyhB5WVcMjMx1Ccvf3s1bv+NZpDCa7ubW+9SbgQwoOdB2NvwQtXp1w3G60RU8IIjIO/LpIsqZ6dusaVi/zUlZQ0FH6B7TePtChnxxMw6pg6gUew17frezgFTLzUdniDsvAFSc7zOr+QW51Rf6sIZoTudY/V6Hs4Sw++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtoQp6Ri; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtoQp6Ri"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7193010d386so1079564b3a.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726247795; x=1726852595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QJReyzWosByjug4OQcBfjDsyWNBRNw0n2w0RI6Hd40=;
        b=HtoQp6Ri/W0avdTb0o7ZT1ZeCRexQzQ72Eycwo6iQw9SFN9ozFiLT6xXtO0RFq3K35
         Nb6tf2BWq6yrH2z3FHjZjjVA9ho6rFc998X8P+YCZeEJ7WHh1F+W87vsYrTT3UNW7Z2r
         txg9bBjAU7+Fpap7wprxlnpC8XNOWA0tDmQjNF6wq0zPYLhobX8rbQLiik1Y3zAy09lV
         rk+2SXy2ztgrJoWmOGmOzS+Facwa9F3dU9AUlcT5YpwDV/C8/9Xn1FwI1OOis8zdeLw8
         QF8NgojdJK3Im1Y+Se3pDELW2DE13JF0mj8G/znjRzOBu0+FzJZUnMB4/xulxEmNeb2y
         1nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726247795; x=1726852595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QJReyzWosByjug4OQcBfjDsyWNBRNw0n2w0RI6Hd40=;
        b=uxVEKvC6fR/jJNTLY0ZYe3XiNFbRIzTO5La9rtSIN9DF3tVGaliHoF/jp545KqZHGf
         aSbrzFNht9ZW2wiREixo6CLYHNHAJkgNkAFdLwRfEnz3DJocVQHqg3hnRUakm1lP7Rmx
         pFg1wxUD/uf2WqaDw+HGlrUqklRhKm0kII2EonbxBujzy7/hG1tHPl0TNvYexvkCXiDF
         faYDHBPgyJSPajZY6E76xg7nwov9mFn0K/cRYV2oW6Id5ugQ8kw1sI2Q9Vab42JUeDbY
         RAkANlPmTFBNGtNNPgorxr14eR0ao32SDsymvbNfssANoq8HsmHAmZez0ZVfNpwXe/i4
         KHkA==
X-Gm-Message-State: AOJu0Yyt9pJAC4Gs8eNbh/iM8+OfMxStDFzvnBZmnyiYr3ZiZE82CD6D
	DKjwPjsf5b5UTCeMNuuJDjoT8ePuQdutyDjxvTGd4U3o2NQMl7t0/Ntr0w==
X-Google-Smtp-Source: AGHT+IE8zwkJUOx8+15umuY6pPgNSzQj191O7VjO+aZ7Hbngs8/fPgOdDduMErXZXhb6eve/c8kJmg==
X-Received: by 2002:a05:6a00:9188:b0:717:8e49:37ce with SMTP id d2e1a72fcca58-71936afad89mr5437379b3a.21.1726247794955;
        Fri, 13 Sep 2024 10:16:34 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc7efdsm6351406b3a.7.2024.09.13.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:16:34 -0700 (PDT)
Date: Sat, 14 Sep 2024 01:17:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/5] ref: initialize "fsck_ref_report" with zero
Message-ID: <ZuRztuVQSVY6SiXF@ArchLinux>
References: <ZuRzCyjQFilGhj8j@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuRzCyjQFilGhj8j@ArchLinux>

In "fsck.c::fsck_refs_error_function", we need to tell whether "oid" and
"referent" is NULL. So, we need to always initialize these parameters to
NULL instead of letting them point to anywhere when creating a new
"fsck_ref_report" structure.

The original code explicitly initializes the "path" member in the
"struct fsck_ref_report" to NULL (which implicitly 0-initializes other
members in the struct). It is more customary to use " {0} " to express
that we are 0-initializing everything. In order to be align with the the
codebase, initialize "fsck_ref_report" with zero.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8d6ec9458d..890d0324e1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3446,7 +3446,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 		goto cleanup;
 
 	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
-		struct fsck_ref_report report = { .path = NULL };
+		struct fsck_ref_report report = { 0 };
 
 		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
 		report.path = sb.buf;
-- 
2.46.0

