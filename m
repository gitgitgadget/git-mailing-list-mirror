Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439036CE0A
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875742; cv=none; b=EGceJAI2f2lkpfAfVaWrgj1ZhNty0gxgGiQbzOokuX1L1Is8cbhdumYhcnO73xKoYpsPfYpJ+71p5QIrLRPKZPh607ewHD5Eu60ZdCv62tCoS5M4Yl7+UJBDPLD2SrSp/uavxy4feb7aCdfdyTd13KTJJpvuAJHUj2lngqKcQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875742; c=relaxed/simple;
	bh=DdDd3A4j4fycR8iSGYFLgqPu1A099/iObY+xGPduyeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7gQ+IZnHTEbSIbpLNgW2gA8BuiZNM1mN4bLqYjxqgI2k2ovifrko4OBiWJYnIi9daW0OrJ/R9ttpM9Ait7GRWXBLA88aWUBcHcnC1TpiZPR+xdgg/NZDIz7om2Fuegq+bg9+YU8/k16ZNVxPVzzgXH6RzRh+UtLFlFW4BzUMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLDgpmh6; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLDgpmh6"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4c7d04890so4238163a34.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875739; x=1772480539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFIY9MGue3OUYouw4bqz1Ry4Q3iVtC+Pnkni1B3csAM=;
        b=RLDgpmh6TVCeqbN2H6PO7IdwcWFhzo6uMBxh0XIGX2K8D2z+jQy3BkiKT0L+BI7zZV
         +GpTDtXmHYmHVkkjLp5WA2gVsX8yIQ3YJztE/ssPtSRKsCZV5iP35Qdh8IVy1+v8zGZZ
         dQmmRHQWgayal4rjqG3GRPHZWnOFE1lOqI2VL+6Hn6oNOXSITRNmkNsgpZjpQ9ymlUN9
         ycRhwzdpsEjF8dH5KJCBIiFJM7LFeJqpkm+oBXxtauiXbLswrX5YNsqKP/iD3r42iOID
         nyjyT5wiIXEgqdZapGWE7Gjh5jo0QGxEPTuTf9c0G1Ep7kLOTxi1fT7vDdzN3zxKkKq1
         tfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875739; x=1772480539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFIY9MGue3OUYouw4bqz1Ry4Q3iVtC+Pnkni1B3csAM=;
        b=kA6jbRF5L5HPIrnlddHnnZj0898nnwwchZzYCAbMLjLVk1CeABfned613d8QOYZv4Y
         crYhr5vaFNw+7d+bas9loqPr70XD325edBhWa11auNb5n4HNr8iz5J84P475ddo9YOZI
         ezw5zQpJJU45RzMr8m9JAXcDpsvGQjIzyr1G7+9BeBfpgn4hOS7aWOmx95t5IIxnzB6i
         SzmM+m60LoYm5acHDqpTfkI5+ohrbp0jj240YuWvYmdF0GUuM21YfOkOzK7ASUeyYxMO
         CQl3e/h6SjDCGLodBgiif4PwqZWienHPeacxM0sXR2QKfNpOWcB6JlDEF/PsxVVfhP5S
         YX4g==
X-Gm-Message-State: AOJu0Yy0ST+VnLys75s4hUrJFsmr8bYjM8TDHiVGrEPVotyounmYKaEl
	0raZw5SnVdZiD1LLh0Q5xVmzIqgVGvNbxNAyChit2pRehLc4lIiy1PX+fkX5zA==
X-Gm-Gg: AZuq6aK+61Fe4cn2W6nbptHgMPG5o9G5/Na/TA9lNw+RlFfKRaNgEtlJDwClK3UfDq9
	2iWr8PPRtjrOsZxu958uYRVc/8uqdbApvLPZQ8QSTj/L1QF+buNyvQxq6MXNLgGB2Wii4KSBeHW
	Jl3bnYvSBA0vffCNYJ6mFNtkjzE7QQRqUWaASd3GwFSyNVD72JRJ90574Mmptw92N3Lp9xCdd27
	fgf826dHIunUGm1f3qdja5nYOLHX2Mn/FrDR75jPxSpXC60lp8UJBP4fQZ1/phKSHiUJAVImhqr
	sE4Qgc8KKvGlCTr4xzqFiQ/lA7TtqprX6Gze7QWhcLGBUYHNeuAqdOtXsKlp/5pIob37TjhPvA1
	xLztaiORzxct1wkQzoRM0ZF1TzizumI8uQQpqVDIeHCdRcA728v8C2RXmIxf2Irp7mfgO+BBpVQ
	RpIhVamP7Anv8cncsXWXX8HC17f/HFaSs=
X-Received: by 2002:a05:6808:148d:b0:45e:ed45:15f4 with SMTP id 5614622812f47-4644633bf91mr6255191b6e.35.1771875739321;
        Mon, 23 Feb 2026 11:42:19 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d3a9121sm8051179fac.19.2026.02.23.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:42:19 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/2] commit: remove unused forward declaration
Date: Mon, 23 Feb 2026 13:41:45 -0600
Message-ID: <20260223194146.3476768-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223194146.3476768-1-jltobler@gmail.com>
References: <20260223194146.3476768-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 6206089cbd (commit: write commits for both hashes, 2023-10-01),
`sign_with_header()` was removed, but its forward declaration in
"commit.h" was left. Remove the unused declaration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 commit.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit.h b/commit.h
index 1635de418b..f0c38cb444 100644
--- a/commit.h
+++ b/commit.h
@@ -390,8 +390,6 @@ LAST_ARG_MUST_BE_NULL
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook, const char *name, ...);
 
-/* Sign a commit or tag buffer, storing the result in a header. */
-int sign_with_header(struct strbuf *buf, const char *keyid);
 /* Parse the signature out of a header. */
 int parse_buffer_signed_by_header(const char *buffer,
 				  unsigned long size,
-- 
2.53.0

