Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B509304BB4
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967015; cv=none; b=JO8g69YOqS0lreqA2R6EZmaA1/+RP/ZVho/PShReegXWo2cm4lprYxX42PO/+6eEjrM7eckMeRPOwP5xfHrXQjgfI64fXNyg0TDPfZ6wCx/NIq1wIPl8KNdBzgDVmhsJdgfOWdzQ6fAeDPGXVDm4T4nor4nZkn0ngbj2RPycISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967015; c=relaxed/simple;
	bh=yI7HqHgxpmxkG2x537KgpHEjpIdxY6gjjx3pkWa4KfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJ2pbmmCCZImZVkwvTRm4nqtS0G0DtFwoiqF27hNRuh1wU9w5BIbY29gcBJqGy7bG+JxqnXiZfGJ1HKoFzz3lYNOA4KSocIhDA1Bch0XGzA4gqYKKGfUectV6EcXOk3D2yVu4QWECmhUt2q+6NPUa7/NLgza1hkJ/VpyQKixVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXd9Kj2n; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXd9Kj2n"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bde0f62464cso2286772a12.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771967013; x=1772571813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwArzwE9sMIeYrkYTXVboW3nWKAvZF2IQSFPvblnor0=;
        b=IXd9Kj2nLCgFSotj7cPVqOTDffyS/a2dhZkDlEUs1OEG3n7lvdBov1MlxXWWTOr1hS
         efKWRgtm10jfl+Gx/XjiDUzlSL79iQnJP6wEgHSaf3El2LtKX8cyAqK41djBeB0hMGK3
         EoeUHjedTQiaJhV85jOoT5JIUchwpsVnj0BMXIvKFA6+SnSbhauK0ekoN2IoNfIHdn0L
         9DLbIiJhA8VZcnaqJ5SFT8bBE6TkgQXDVQEuaxwWjZjIM4fDXAwSrBWeqFx2W4SfBcro
         eTbiscm5NhiuwAiTfbnbAyx7nDNg6P8pV1NRCyWpZ7xotWfCMJDpRxjcgGUcbJbwctM+
         mQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771967013; x=1772571813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwArzwE9sMIeYrkYTXVboW3nWKAvZF2IQSFPvblnor0=;
        b=IJYeMtQJqt+ilrCCdrbyrQl9D76oyHEClFZjPZJNrVPKakuTGHSs7N8aeWeiNRnUA/
         tOhGVOv2F0S6yBCQawPkzGhopwyL+eRkHP4k2nQeio5RK/B4fGJxoWJqU9qlOhS9i547
         yL8pHiuTnwh0FnsrjZzFlYyD31jxGxXioiOwTpDNAMJE+qweF0mr3VjoVkRAfKAWD0Wm
         /UDTfIfvHqDZvhi481DXSf0fDoFvmz7O4CcIrf+qScTFQGi/4lXzyYPHONRZgh95Rxh8
         ivqEJ2InBjpL2Vxwshs5uxE5WghCKZZjcOUHSG7FGX+55WmhE4MUdsnHex2pe4C2RnKP
         Kz3g==
X-Forwarded-Encrypted: i=1; AJvYcCXStK9AL8naw/Ny1iFcZBhhSGxr0rcQUa0shP8r0AwNeiJgje3EXW5Zc5DRz8E3SWG8LQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrzJHlCBanfMDsuF48yRiI9ZO6pzBD0fV/AQ+g4mZZlBKZJw9
	tjUcJoO8jhT7HWwl/mWlp7ZwmlJga5ZtwJX30PFtiI4vVAQ005JSePwl
X-Gm-Gg: ATEYQzwXvrkwwBxlxcky1TMNwynPA+ckxQMcG+PRLctPHazBLdZfcHBrl2n29qWgF8D
	1T//LJxSsoipxDbhzjNhdc8mx2GTC/djlBfAxFV0p6aIgOr9IM4xhTYLP6uuGnycgjxGOlAiIl2
	E3LT3qRWXuAh7+Hl0kvTYXvc8Cr2G1UVbKNY73P0oizmDxzsBMH7jv5W8NNL+IUABo9CIaVH0R0
	DhKCmKuhKR94gom/yoNIzJYyHrA1Ziy4bBCzgBxIfCBL+BJa+CrF9MKZBeKMU0Fr3D+e0Xm1379
	hyRdjaZzHhA5xAJvBJf7G3pGfbUuJAHaZq75QZo0cUVgZaOma7us6jUNGRMtX3DpgQgn6D0Dkal
	S3Ont5Y8bsZYVWT+trbnXJEVmgQ06OFVPbtc4ceYgxpxHa2rBOTnPdQEbEqR3Ogwk97JqrIhnqP
	tmYSRZhSg3bQvNORJcE8fzb3oPpY8qN/Lig/VHrhHEVcvgZe6Gn4SHxaSLVIEh407nPOfVnGTH0
	waRDmCrHm/5OANr4S54ahS3L6PC1BIsSSL8WlamlbkxRoO4lSWLyssveD+Ar/sFoBwR9MQ6buqa
	jUySl49nTg==
X-Received: by 2002:a17:90b:390a:b0:352:c995:808a with SMTP id 98e67ed59e1d1-3590f08f704mr75564a91.14.1771967013420;
        Tue, 24 Feb 2026 13:03:33 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:100f:98c3:814b:c2e4:a180:5c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f91esm690527a91.4.2026.02.24.13.03.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 13:03:32 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: valusoutrik@gmail.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	lucasseikioshiro@gmail.com,
	siddharthasthana31@gmail.com
Subject: [PATCH v2] builtin/repo.c: change info default behavior to show all fields
Date: Wed, 25 Feb 2026 02:33:18 +0530
Message-ID: <20260224210318.16547-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224204047.8452-1-valusoutrik@gmail.com>
References: <20260224204047.8452-1-valusoutrik@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  	if (all_keys)
>  		return print_all_fields(repo, format);
> +	else if(!argc)
> +		return print_fields(argc, argv, repo, format);
I did not mean to send the above patch. It was a mistake.
---

Previously, git repo info would print nothing,
when invoked without arguements. Change the default
behaviour to display all available fields, to make
it a little more user friendly.

Signed-off-by: SoutrikDas <valusoutrik@gmail.com>
---
 builtin/repo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..d044d83b14 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -191,7 +191,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	if (all_keys && argc)
 		die(_("--all and <key> cannot be used together"));
 
-	if (all_keys)
+	if (all_keys || !argc)
 		return print_all_fields(repo, format);
 	else
 		return print_fields(argc, argv, repo, format);
-- 
2.52.0

