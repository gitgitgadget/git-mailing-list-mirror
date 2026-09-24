Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22754488239
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261075; cv=none; b=EhM09A+SKUtPItijhLQbIYTImTasIKeB+v7hAGK9oA0gOmCS5VwuXRAFY0aFbIomxvfGx7JiMq47obgUu2NhE/Rd6akVtgKB3E1v6zFpCcoGJgTfaeCeykPHD+PTjLnKd50uhCB0cLGPigDuSDFl5MACK3WWGufLjGndB5hpZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261075; c=relaxed/simple;
	bh=pAX530mibkfJUv00QU5cIykrkUf9frE0H8bpOChRapQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GiKfU69pWky2o7f3X4FqYBhmj8hux2FkKMkRVoXgvBYNLZOp0cgjMm903z2O0x1JcA6hiraj46BbkiDQ3bbxaya602EbQQE60cHOUOAW4XQQjVtrVy+t1iGOWM2GPQ9Nr6/ePc1miqE5lg66VqBnceEjsuCMwYUF53JYDk4iFLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMydP7m3; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMydP7m3"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so20402325ad.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261073; x=1790865873; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MnFFTFLjCXazsGbgiBiyKT4KuUlMvFXkRn2jiU9XiXo=;
        b=CMydP7m3+eDD4CFreW8Xxym2lp0SuMMsSnbyfsqAAy4wjV6NMPb/M7zHirGKokk8uc
         MOUphlWTVgdl4M0l4jcpgkBEdEMJ6Io0wsdPqy83GDbzaPk62vfRti8LR395+40vQzhm
         obGZo0tv7uhnRemvoMKeL6IJ394TCXPMm3DIR5y0QoF/bzUYitYiYBR4EIWnBRWkc5oJ
         mBeGQJscPfJwQJJNCpeIetmpccjyseALDMz89BngZZ0wvZLPlxkpL4TadK4Yma9avavH
         yoHBNXVxCDz5R54lkQKt1F9HRwJS8Jt166PMSz+/rO8/Fc4BsNM2FXZC4ZieOxHPMq9Z
         GMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261073; x=1790865873;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MnFFTFLjCXazsGbgiBiyKT4KuUlMvFXkRn2jiU9XiXo=;
        b=EbBX9wz2MGn6BpBspFEZPI4PpHJrSSLLuPvbHHY3GwV5t2DPkDHs1dR60/EmLxvCp5
         IEwsH16HyMPTfPnJ9+7vqXanf/7ZOSHTFAMTToqnJTa5WmFM/yj50UpCR4tjTpidzrgI
         Q954aW0tLjmxD2EBMZsuNNF2sp04LRpkR2j/UMzryjKp/fRFAwuoJ6wDYltF5O63+g9q
         f+pWjAmvKoyW6Hx9PTdGI9N2caHPGoh0CNmFTAVLVM1lRzCVo+mkd9k+KxHpTbw2UNen
         sBPtm3NHNHcpPfnrOEF3Mr+rPa5OA4VPrGA+deQggdLNCMLXK5yphBU1e5Pk0dWIpv3c
         xXsA==
X-Gm-Message-State: AFuF++lN6NRlKAPowScHu4al/ChUHBnueHpAiZEYhzWJy043Na/dFRYj
	f6+s2VwXWbULDWWAKc9BARJf9fAB24XlTp+JFUI+RZgO3Ky1OLFXPm5heC1U89wl
X-Gm-Gg: AYBFou2Z3TRMxKLsUTzTBSeAk1rI6CNvhdgNkdpPZVLJxXqNLJK67jtQTAGogP2VXu2
	zwwvtIqp1RaxDUpaUWaDOaKvJOKQczoMhNKwfrhyLn3HMHoFPexzD2Yk0RZKW1db9MHfVwRQkd6
	c4gO8OQ5o16lhSU0jtoBkbdSJ8KIduQGkmNHFor/ddui62Lxrid4y2gEOXJHU6TZ7nTgcs+Vj9u
	E6e1PYtzfWGQyT98LE6554PHvIww0BvM0UHREs/+D9K97hD3yDJb4ijGNZgw06Kp5S6BZoZualv
	i87Pp2pqfYQoXIUrU1TtQOpfMK7lpKXWoXPP9nhCt7Tk0/TMea+Gd1dZVo1Jrvcn8F6wpkk8+IB
	G7a3aXqRimaTpGlC9F41Xm0NolNf3Ef0lunpMTZthqKYL6o3lQzq4CUN/MRKEscH/FihyDsYA/R
	6D94VcD/GK5YkWIXUIiVdZ7HkgDm6B3KHy92w0v1zTJEWrMEv9nbLU4F1qhgvqqWduxfn9CzQn6
	T8=
X-Received: by 2002:a17:903:b4b:b0:2dd:7979:246 with SMTP id d9443c01a7336-2df7da82154mr24711755ad.16.1790261073275;
        Thu, 24 Sep 2026 07:44:33 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5db05dsm28182055ad.49.2026.09.24.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:44:32 -0700 (PDT)
Message-Id: <4505fdc9a6dec37296952107c90947e43f39bae4.1790261062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 14:44:22 +0000
Subject: [PATCH 7/7] [doc] ignore conflict markers in gitmergeconflicts.adoc
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
Cc: ps@pks.im,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index 26490ad60a..0a0fc950b1 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -14,6 +14,7 @@ CODE_OF_CONDUCT.md -whitespace
 /t/oid-info/* text eol=lf
 /Documentation/git-merge.adoc conflict-marker-size=32
 /Documentation/git-merge-file.adoc conflict-marker-size=32
+/Documentation/gitmergeconflicts.adoc conflict-marker-size=32
 /Documentation/gitk.adoc conflict-marker-size=32
 /Documentation/user-manual.adoc conflict-marker-size=32
 /t/t????-*.sh conflict-marker-size=32
-- 
gitgitgadget
