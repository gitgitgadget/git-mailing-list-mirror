Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E514B08A
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202908; cv=none; b=EWO3mlpYA0RH5D0Qa3AaZUktekZwYuf9OeZAMGNF3chE3n9hFFFb2Oi0keQR7dYlC1JLauFUMIkUrHolqfrPwDKBeSQSOYeIBDtA3oIizI/U6QFuooL7a6C45IIIiwq4xVtUp7wTVYtjYLMHoj2TPLUemYx1gf57owJicfWapEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202908; c=relaxed/simple;
	bh=L3G3T/4DDS05TEQ0z0MvMx/uK9v//Nglsax8lhndlEo=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=AX9nBeYH+I5FoCdROXBVI4dUjdOssg9oCMa/gi2xqm+XU9UTeofRhBtETzK62s/Tf/4O9GgaWk+dCCL+ukbsdXTTSLjK1XIv7d6UV4KReu7ZXuD7s3fT5ijjC4XSDVK7DZt+Y7XP9GYiGrL2SzJx201uwyAmM9KQa+F+8YpLruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E46DZ8A5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E46DZ8A5"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88888c41a13so35771926d6.3
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 13:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769202905; x=1769807705; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xYXUxwMviEzvyqa3L8Uib+CXOGTpsE2e4tuAMr6Dq64=;
        b=E46DZ8A5AaCshS50zowi0KYR5W0SU4LepfU5Wj9qpD+zET1AKeYzaltbZaSGrerP/X
         0vlXIJBOdo7ZvBikj0IvxMq2Pz4sSMvdkqvyVkgRL+qPX3+s2t0gatW2O1nQHhd/COmT
         j8dCDcbxf+i0IlZ6kOZjzWoYDD1Fq4EDCPGGwjzkUS+yniDs/BLGFaLGjVX6gohbUlL2
         30pks4BfbbBWRxt3qXcDizgu2SngOGIAl3QFhqenQmhp63/gbbn9nS4cTiQ8UCfI5E4a
         mkuTYttIBe334rkyQcqNiPOYePCvSU43LSo9RSylP5SjfNQC8TGAm2C3I9bJ7dQ5EDxH
         gasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769202906; x=1769807706;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYXUxwMviEzvyqa3L8Uib+CXOGTpsE2e4tuAMr6Dq64=;
        b=sbvSBjVn0befIeukP/HoPn9IAEPsnp8j+Yq06BS5eX3GuWG1TIXCQYbvfltGk6Ux1t
         mvTW0igqactkKaAQ5BpFgAmQCNYvuDcuo/flglQ9bEd1t8Hy9BHLgDzBS9G0SDTdsKJR
         wqSK4KbpCb2Q7U5HxonGzoUgd5IGQ77PfFTMJxd5hPNr4RJmBJRTdIHsZQdbzOz5Lgsm
         rTCcyc4EAh2lUl7v3ypkZFsqEgtyifNBmtZRrF+nG7P0QFljPVnrK7iG4K15Wt9u4DcI
         6X7sFNcA18n4SDfqFE1tjj0SHDl6t31k48VLEI4nLITYuOE0zIlgaeGgj1SznXIeCE94
         +Vmg==
X-Gm-Message-State: AOJu0YxtLSDsygXD2RyN4jDffWc3meakQU1BfhZvDIPhpBttpCY7orWF
	9kTGW2WJCcvWqfaMBSysa2kGAzFvLMAF5Iji1lTDUViE/lIuaRaYUJLYE9gpHl1d
X-Gm-Gg: AZuq6aJFDG+As74zn1YT8o7qZsVx82DAClUSaAhFat0kLhpqdnYiW3mfnCyGa21IUe9
	dhIlc/zUlJX1qPXYLHf7WA0QqL7rgyKO2V+7qyZ8icmvC1R5zs3NBUEP3ojguTG9XYWHo7rgHOv
	opyYDNvVrN7cuftcDlELBL+DPSYLObObx67hhtpUmKAqghWlEJOviIrfOBmcCpCXcad/0/EFX+m
	VLmtrH+c4l1vmCyDBhPuz+djo8Bc1K5jY34z4CBQUaaeFbvJmGLstmf1kCo6pUr4j6CZyhpa4B4
	n72Q4gIDAHCd70IfkR3P/L6jMDRtsarmMgNEMgzSVVCa3Vbm8xyLvodmp+qIjexYiLRTpNCiOVs
	dEtAEhwU04jXzkGwsgGa5X7Vh0BQfsSns6EAuhmdtPjD7/QrLHvtqyCSPLVwySX2HVelSHA5GFp
	CugeDhX81j1uWoNDM=
X-Received: by 2002:ad4:5cce:0:b0:894:7051:bdaa with SMTP id 6a1803df08f44-894901acd94mr65533886d6.21.1769202905620;
        Fri, 23 Jan 2026 13:15:05 -0800 (PST)
Received: from [127.0.0.1] ([172.183.133.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894a1b2bf41sm707556d6.22.2026.01.23.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 13:15:04 -0800 (PST)
Message-Id: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Jan 2026 21:14:59 +0000
Subject: [PATCH 0/4] doc: some more synopsis conversions and fixes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This time, git-show and git-submodule are converted. Some mistakes on
previous work were also spotted and fixed.

Jean-Noël Avila (4):
  convert git-submodule doc to synopsis style
  doc: finalize git-clone documentation conversion to synopsis style
  doc: fix some style issues in git-clone and for-each-ref-options
  doc: convert git-show to synopsis style

 Documentation/asciidoc.conf.in          |   6 +
 Documentation/for-each-ref-options.adoc |   4 +-
 Documentation/git-clone.adoc            |  52 ++--
 Documentation/git-show.adoc             |  16 +-
 Documentation/git-submodule.adoc        | 369 ++++++++++++------------
 Documentation/pretty-formats.adoc       | 164 ++++++-----
 6 files changed, 321 insertions(+), 290 deletions(-)


base-commit: d8af7cadaa79d5837d73ec949e10b57dedb43e9b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2036%2Fjnavila%2Fgit_submodule-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2036/jnavila/git_submodule-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2036
-- 
gitgitgadget
