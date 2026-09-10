Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F0425228D
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020332; cv=none; b=L4s/KMKqfAne8Rk/2TQcz19OqqGOUd9O9rWYVBICRpFuzA1wD1uarYbAugMPVfcaGe8Y5Vzolde2h16EULjyWQ/PlF6Ntc16OkDq4aLF9jLYTozi5Kg7LQhVuv+iobDM+vEVU/tosivffjROzUaw0t2s39S/9KhKtGHZWozDEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020332; c=relaxed/simple;
	bh=YOYQZL5C76JWFdQ3HfIYXJg5+8558k0fXxHO5T7farI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lloR1w3T2RKWbZU7t5um0uLlk7z8g3OOOP6bvpAIfHt84ypkYmAzlHzAbta+9XRm0lCY4cKGdZzuWX/YOH2bjys+VJL4TDRCqtTz6MSZIthmwkdpkh+B65Rx4sktBTxRl8gK711GSeBqCJneVL03OTV2ygSal8Vfo0pnRKEURvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWzNPHe5; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWzNPHe5"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso1750042a12.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020330; x=1789625130; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8gdu/kok4at9oubCrELGeJ0aXbuNiL86agI26AfKIEg=;
        b=rWzNPHe58bxPkw+E4Bi+ynMBg9/u+TDEfEW6ZHQksRjQ7Y1pSrkS0K8TZnPUrLJqvx
         BdLqy6bHGwt4zEOy7ZE2TraI9s360a3ELfXPWFTfQ6mZ1nT8awnYrfR3W1cdBn/w2T9i
         EfU6Xu+jIK0reixe8A7G9wWj2ETvQDpNqgxf0Qwe6j4Hj9xW1kn1mU38VHSI4u5fQeLq
         LwNuswaBnrmSgUBmNHqVbLEu92nZrXlL1siE+s86jrwQGNO01zCD8TjGfkyh72uCYavB
         9EY0udoPcAjKLGLhFTMC0cQ1SGup5oOmKxuJEcWHkPtLUeUVon8hFusIAPqmlnf4H25s
         fyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020330; x=1789625130;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gdu/kok4at9oubCrELGeJ0aXbuNiL86agI26AfKIEg=;
        b=koYlmze6HlMpFt5j7g7W0MEbE2DKMswME1zphOLua34y05COuHQ3h/C+5+Npcb+Sqx
         qJI6WOeiTiSzRdadFSHKQzz67Z2GEOvFlpS+zF6+ABxYDHiBZjKDyCswk+TsihYX+uYA
         7VxuAPdtPBRK/ZAS8oLqIZlNxBZN2uWAdI1dejZHPv/MaYsP5qBkZkHdy9cKayidyXk0
         GCClH2wQd47Qk3k+EZ+cmuKQ6IE1GJGAEFmCJSx+8B5oB7c8czA0kngfpuCtg+rJwN4k
         ORirtdLreyaQkTQSuLra2gDWbJpgWXV8gGKpCSUQWL5iNFpynM9Yevs+Htf6WwU4h7ek
         I0OA==
X-Gm-Message-State: AFuF++m6cB8T1QZiNpuYy+0QEf+Rq6+vEW4ptETNG9CAISxlCmpyCO4y
	c2oMASxBgEqTzu5kbcpo1HHCI3gUq2Qi7GCujYBjAbx/YxinQZNS2RUXWDLa8A==
X-Gm-Gg: AYBFou3FYjptdTzzZbQFX+lEAfB5gpIw6tVZ0wPmjzXcf76FqoWE+Nrm5Mhblq8yF34
	r1Mtc02mF+s99IDrVjzXwrnepQja9sIlWfvfD6syptUNdWqN79zD1nMcU/LrtGJv7pj6T7Rnyqg
	cYw3No516BWuVDYCub5zAnflAdKzjpZCdM8hvBVrSjtZqwl6OGWg8LboFIOVpByqnbcU4gmNULx
	zFSGXeaOd12goCCRyYP2zIQv2L+nvrmjOQBNanKl2Sm1hGmH7naO6bDZ30BmLN09DVmu3JPXsF8
	WK6pnmSRjCB5nhFuCotVFfC+X+I2xvjBKCgM8RqVtsFuSZd57EhWr7S4hW5fJfSLel5qdzB+57H
	+K3LYOPf3zTtOJ7+YJLgTvvyycum7QaVTNFqWilZvin92Rg72fZJP7lQn9zzGKdhuGYmFhU+Vxu
	RkLwYWVGh9QtCX/Gw2BnHJi+o/bZVtsYLW//amzxhdFXjbp21Kyt14sZdHSwBejjLGsVWsnB2w
X-Received: by 2002:a05:6a20:3d19:b0:3da:b761:80c0 with SMTP id adf61e73a8af0-3dabb1e9d50mr18333968637.14.1789020330223;
        Wed, 09 Sep 2026 23:05:30 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm44615833c88.13.2026.09.09.23.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:29 -0700 (PDT)
Message-Id: <0b8ca0e3b991eb28dc0cd3a99db8997a73177069.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:15 +0000
Subject: [PATCH v4 01/13] mingw: include the Python parts in the build
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While Git for Windows does not _ship_ Python (in order to save on
bandwidth), MSYS2 provides very fine Python interpreters that users can
easily take advantage of, by using Git for Windows within its SDK.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 9ebd240378..8dd8acfaa5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -781,6 +781,7 @@ ifeq ($(uname_S),MINGW)
 	HAVE_LIBCHARSET_H = YesPlease
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
+	NO_PYTHON =
         ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig
-- 
gitgitgadget

