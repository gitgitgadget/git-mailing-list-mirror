Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D751C9877
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365983; cv=none; b=JDY10qYdbhG9BZ7QEOf+MjrPt58VJAZHaHaxLjE/P9s3TBi3jGCCanfH/L3cKKWDe9vnsXMwVuM+tuezMa/XjslOophe2dBWSMcJ2kRIX/n34qQ18h6TbXC5n0hw9EJRJpKwrXa7BrvPyldQnnEMM1xKG22+A4e+wALE0602nUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365983; c=relaxed/simple;
	bh=Ei76NNn9ZuIt6/c5YZrfkWpABLETbb7A2ZN7vYE2UAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDzPimVMecp3bJV1MmRgPBlTcxxXR9FNvLn1B+ffeu8dTX5E0XefNN9gSgCkUbiPrl/YQ83UzELO2yKZ+gOQwJuM/kGi9ZoLc0Lfyp4eHC7qS0xuyLtM/kYCaasYDbDzkT1m06ASTeKvnxU2K6rymXxBGT58tP7GPzkXUibH7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdpezdN9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdpezdN9"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d1fa104851so2955226a12.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725365980; x=1725970780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QJReyzWosByjug4OQcBfjDsyWNBRNw0n2w0RI6Hd40=;
        b=JdpezdN9J1neEGa/yihxxNW1MPHn0NYQ1PrjVGzyx4eXeMHu+rhv5sj2SwE2O5pXOE
         uFGKhwXvOA0nYbIKfVb+OGGojBZ4DkEBMfgN/IM8Hc/TTXk5Rfdxv3jn4fgGLZBDXf9F
         Oq75zVYaPx+rVxZkDccBFPACJqx4z0l4aeoYffk1MdnNP04qhL4mkoMhinU3J/VmHxKB
         hSySJ2qbyUvFv0KwQziA4dq1XX5g2SlT804n4CWVhCzzaW8XhLRW8vzqp6WOnSGXfq60
         ewhAS6r6Ri8BHW/P8/bIxW2Tiy4iJHzE+VwG/uonrpPG9CmUkxzwCMp0mOWvs26UbNg3
         Nzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725365980; x=1725970780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QJReyzWosByjug4OQcBfjDsyWNBRNw0n2w0RI6Hd40=;
        b=NhPjq1rtiuWjQwcx4HS2mUxwJ6rhsCZdOHiDoh1mQ4CQCuLtcrgyCB2FU1BdxkQrQ7
         sJBhO6Qs8HlMW326El0rVt52Ns+9Ufk+7ACKPEVBxlAZCaf7xd3vIovYxdcLcovdARE9
         Ki+cquZCxrUt/QLr5D+sdXtIiKbkgBoMy7GGVqDef/WmXvb5X/xqQ1gVepArAt9xXHuc
         5xJAQIr1aQWz5pHUXDQLWxex7Y261KoRCd/aF7OW9dWPYWykCw0zb+CJCOy1Nhbw+gUG
         qSZUAG192oADlWE1NU2XVtdDskeHg69CkaUG0bJOAgiJWmRwRQWlC4fAJkJ595pXs+Gs
         9ddw==
X-Gm-Message-State: AOJu0YyWZnvUGXq2/hizmdk8lDDa5ZgyI2IyseADdTCEdyVPQV8Mzeun
	HGL5bN1QJYb1+iIWpSQ/tyJZjuzXjTptobVnZfmMd27QERM9GRYVXbvaAQ==
X-Google-Smtp-Source: AGHT+IFQgemMoC7EHxY0il7krLQCZJ8MCv2m/LGNo4+5ZLfm+zY7uFFjhlzKPWHbTahApu0fQL1vFQ==
X-Received: by 2002:a05:6a21:e90:b0:1ca:c673:9792 with SMTP id adf61e73a8af0-1cecf49af5amr12398761637.10.1725365979631;
        Tue, 03 Sep 2024 05:19:39 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6ff1sm8389970b3a.86.2024.09.03.05.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 05:19:39 -0700 (PDT)
Date: Tue, 3 Sep 2024 20:20:37 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] ref: initialize "fsck_ref_report" with zero
Message-ID: <Ztb_FZl_xaIot-GK@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztb-mgl50cwGVO8A@ArchLinux>

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

