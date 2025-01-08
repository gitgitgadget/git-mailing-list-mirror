Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A2202F9A
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363692; cv=none; b=DHd5RoKTmN2AP4GPL0PjIm7TjcShmuNb+s7gXr0/E6SP9ex7yhBD35mZ3arwOm5Xzb2PXTQn95X68gb0Q3EorJ8fx0X+5Ou6apHpu8jQmf5GjM7K8U1eoWUjeTpq+9jbfcUWXwkZH/RV3aHNHWIHGFWpDbz+LCCfPspm8ej5SoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363692; c=relaxed/simple;
	bh=I8b+brVSHXda+TWSVUyYNES/AqHV9Opc0j4jgRI3bdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEUYU4OYxNOcXtzgXph1fpYG3naumVus97qqxHIzijZrwo1ur5zq5DEnZwohpP2813mSpk0IQl2h9oDagj2gX7LR+jfFon7DDH+9TLvhiZ6HvErKGgYGQWSU+oZP3YvUI3eqLk6SsnpTGBcfDZfjyfy4b/dwjW1rDiSsbdwOMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nZwpmIka; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nZwpmIka"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5447fae695so103183276.2
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736363690; x=1736968490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sc62gKTFY5X8YNEhTN/LBtFdmPFQi1T0wqUTSv1smlA=;
        b=nZwpmIkaOxxJs7LZmeq9IvA7Pg1gGJru6iSb1dW5emhM80wXJzT8AUORCjD0SNwIbe
         J6Ugp2Aj9gyN/399BzjpeQHuugMnC6EvZkPFyOBVriZ8gx5TqbzQ+7mdOcT5KkEEF0hX
         jqenDVD/diyKKrzSF/OjlaSQ/91+QOE0RyIKMLmDYgRUPaZzR5M8WErxHBd/snxlOm4j
         +R/iTbBuuiakD7fzghVkXZsGPpnH9RvwCAx3a3+RWxpmqIdX24IdRzt6DTYZwzR/05zw
         pXUsCs3S46dOAtBV7Nfnic5dYuwZPmPJFzNQqiXQxhFp0I0yzSMiPxmLJmJC3PJaNWIK
         x67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363690; x=1736968490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc62gKTFY5X8YNEhTN/LBtFdmPFQi1T0wqUTSv1smlA=;
        b=Isz6QPe/RLhC/2UZxnb1Mowpy0rSXYTsEmHB1I1Xv28i94FeYrzvraIBFbXJwBjyUI
         PF9ikFVUBWPk2+DUuC2n9bcSiD+DXL9ckcTESm82ZdorbdSIc28kAcGKshQ+XcYoaZ10
         +NQu4+1kYiSUTDjn5F/g++c73+CWod4oXFdEDL9pD7GeVT+crDmQWvpgugWqKO4BQ/6S
         RN4sN5g7nvP6T1PbNpHxGJwtLITkZeQnxBfoi4XobVcQZN+gi5bDrhZiJB9bLTAWjQW4
         /Pg1hJQMZ7XK07Yvsc69W3usyF7hD7tCx80ipdtPTdi8AV4HW62aNSWtqM/yIzlQd9XG
         wH5w==
X-Gm-Message-State: AOJu0YzOEeoPU6Z9eeRX+KaelZXt9hAnv/nG6tLUWtNRg9pPYRsvYmTK
	iY2pxN2Yc750rXuYzqyPNbPlS5kDbaU+Ji1pk9iQsfJvfUX2O60uySBysZPHdaliPAwqkp1Lah5
	200c=
X-Gm-Gg: ASbGncuIjd5WzIf96tPqCCMtlRe1nSmc7T6D/FY+JBsTpM/g5MgXnSHMuGg8tBkZtj/
	ghDqW8/5RspR9HF/rZcaAsJ0f4ozaQ8hA3nXL+fg/hks0TkpvNBXCM8UaYRzOKdOYshh/GKSjVT
	GnijMito6iA0W5+SWu530Px9G9JUCDjT3xA8AKQ1AlmNpPWKoJ3S/S3NTc5kk3mjyyfgiKRvwf6
	ZX1PlfQ+TR4HuXEt/dIhEwzxrnLKpU5HEZa6UUQe9Li1UJebjNNYylbkObqSIJsgzXmiYh2pAFw
	dFxg8tSu/tfXMxy/Oijrobk4EU9J
X-Google-Smtp-Source: AGHT+IEAMw5Fm9r5jT371FNuv1YLqVpK9bXSREdahPNPFXbSg8AU4KMglmtJEo/pIV9/RwVfi8wEvw==
X-Received: by 2002:a05:690c:b17:b0:6ee:66d2:e738 with SMTP id 00721157ae682-6f5311e4ab2mr39751387b3.2.1736363689865;
        Wed, 08 Jan 2025 11:14:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7837fc1sm93268697b3.108.2025.01.08.11.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:14:49 -0800 (PST)
Date: Wed, 8 Jan 2025 14:14:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 6/8] t/helper/test-hash.c: use unsafe_hash_algo()
Message-ID: <a2b9ef03080020ca45f2a956128b602d0dca9e3b.1736363652.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com>

Remove a series of conditionals within the shared cmd_hash_impl() helper
that powers the 'sha1' and 'sha1-unsafe' helpers.

Instead, replace them with a single conditional that transforms the
specified hash algorithm into its unsafe variant. Then all subsequent
calls can directly use whatever function it wants to call without having
to decide between the safe and unsafe variants.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-hash.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index d0ee668df95..aa82638c621 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -9,6 +9,8 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 	int binary = 0;
 	char *buffer;
 	const struct git_hash_algo *algop = &hash_algos[algo];
+	if (unsafe)
+		algop = unsafe_hash_algo(algop);
 
 	if (ac == 2) {
 		if (!strcmp(av[1], "-b"))
@@ -27,10 +29,7 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 			die("OOPS");
 	}
 
-	if (unsafe)
-		algop->unsafe_init_fn(&ctx);
-	else
-		algop->init_fn(&ctx);
+	algop->init_fn(&ctx);
 
 	while (1) {
 		ssize_t sz, this_sz;
@@ -49,15 +48,9 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 		}
 		if (this_sz == 0)
 			break;
-		if (unsafe)
-			algop->unsafe_update_fn(&ctx, buffer, this_sz);
-		else
-			algop->update_fn(&ctx, buffer, this_sz);
+		algop->update_fn(&ctx, buffer, this_sz);
 	}
-	if (unsafe)
-		algop->unsafe_final_fn(hash, &ctx);
-	else
-		algop->final_fn(hash, &ctx);
+	algop->final_fn(hash, &ctx);
 
 	if (binary)
 		fwrite(hash, 1, algop->rawsz, stdout);
-- 
2.48.0.rc2.33.gaab3d23ed4c

